Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C8411F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 22:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbfJKWYk (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 18:24:40 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45370 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729086AbfJKWYk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 18:24:40 -0400
Received: by mail-lj1-f195.google.com with SMTP id q64so11222032ljb.12
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 15:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=oenlJXwButTHmiqBtOnQZlQtaCCorbiHVOmklaGWlLo=;
        b=moIXOtMx33JkBZZX4oeZSLIMnnmeqYvS07CBj2gdsH/5txS/UvQJx9SwC/0M0OkwKJ
         FdpYHJpyZuZXLwUa0AI5sYu13wGDMC6Tu/k5bxmMHtZnbb8KePmdbHYtJS0jIDe1DPky
         4gV0+cR33KHwoxGJezO1xOi3WpNEI6arnF+eN/P7r7t1N8aApwYQXulOpc2B884GTUyI
         R10bWdUbkRboT+qdUx+J0JHXoGS6gYWlS8vwUMvV69ZDdM+8D7Fbgzn1pSMRpZZbg2tt
         vVZjJuwmYMxkAsvbL4ikGYWVylEI2NQYIkvN60CBJznwYfc3ZK6KAdO5YHm4tbUprMei
         HMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=oenlJXwButTHmiqBtOnQZlQtaCCorbiHVOmklaGWlLo=;
        b=Nr6tvlsUw7afTnckkiRp4SCq1ZN0628XkAUVEixz1H5xVXWPwq8BghIdP8jFEp87x/
         RxdHxLfjteKxX1bPIygdxTnXIfw3XbGrDngld2bFiddouyvlCwROW6jXQOEEGNlyDvpa
         0lsF+c+0i8iP7YBwuXcZRPEUEMfYTyqeXY56WVA3CuWw797RDqyA6iDCecclx9jxRNne
         KQSMdfAFpRnHy67rped5B32jC6makI35PVW7BWeWG5lbK/q29omOwUO1sxwa4m5zCjke
         XRG8hNXaZYVe1xtTbDoQ7qVr9boLtoxcyRbgR5/6srpRGkGWaFa7+Gs3T+gDt2QjBqV+
         FSqQ==
X-Gm-Message-State: APjAAAWKWa9mZ8MHEQpKbttP7xDy/hcd797WZJswQhUwO4KRJ2r91c57
        4QQptavMHXDULvamqefkjIg=
X-Google-Smtp-Source: APXvYqyJRGLMM0VBFjfScYQysLRNc9Q66KZQejCiO0EbC/VOzEXwCHvx2D2dCCtUZI+DWMRJD/p0IQ==
X-Received: by 2002:a2e:9bd2:: with SMTP id w18mr10480634ljj.140.1570832677841;
        Fri, 11 Oct 2019 15:24:37 -0700 (PDT)
Received: from OJAN-PAAVO.localdomain ([213.80.106.30])
        by smtp.gmail.com with ESMTPSA id u8sm2710810lfb.36.2019.10.11.15.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 15:24:36 -0700 (PDT)
Date:   Sat, 12 Oct 2019 00:24:48 +0200
From:   Jakob Jarmar <jakob.j@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3] stash: avoid recursive hard reset on submodules
Message-ID: <20191011222448.GA650182@OJAN-PAAVO.localdomain>
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
 <20191011001114.GB640501@OJAN-PAAVO.localdomain>
 <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git stash push does not recursively stash submodules, but if
submodule.recurse is set, it may recursively reset --hard them. Having
only the destructive action recurse is likely to be surprising
behaviour, and unlikely to be desirable, so the easiest fix should be to
ensure that the call to git reset --hard never recurses into submodules.

This matches the behavior of check_changes_tracked_files, which ignores
submodules.

Signed-off-by: Jakob Jarmar <jakob@jarmar.se>
---

Notes:
    I went for two separate tests with the same basic setup, one that does
    push + pop (which should be valid regardless of future changes), and one
    that just does push before checking that the submodule still is dirty
    (which would become invalid if git stash were to learn --recurse-submodules
    in the future, but matches this approach).

 builtin/stash.c            |  2 +-
 git-legacy-stash.sh        |  2 +-
 t/t3906-stash-submodule.sh | 42 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index b5a301f24d..c986c258f2 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1383,7 +1383,7 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 			cp.git_cmd = 1;
 			argv_array_pushl(&cp.args, "reset", "--hard", "-q",
-					 NULL);
+					 "--no-recurse-submodules", NULL);
 			if (run_command(&cp)) {
 				ret = -1;
 				goto done;
diff --git a/git-legacy-stash.sh b/git-legacy-stash.sh
index f60e9b3e87..07ad4a5459 100755
--- a/git-legacy-stash.sh
+++ b/git-legacy-stash.sh
@@ -370,7 +370,7 @@ push_stash () {
 			git diff-index -p --cached --binary HEAD -- "$@" |
 			git apply --index -R
 		else
-			git reset --hard -q
+			git reset --hard -q --no-recurse-submodules
 		fi
 
 		if test "$keep_index" = "t" && test -n "$i_tree"
diff --git a/t/t3906-stash-submodule.sh b/t/t3906-stash-submodule.sh
index d7219d6f8f..83106fa958 100755
--- a/t/t3906-stash-submodule.sh
+++ b/t/t3906-stash-submodule.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-test_description='stash apply can handle submodules'
+test_description='stash can handle submodules'
 
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-submodule-update.sh
@@ -21,4 +21,44 @@ KNOWN_FAILURE_CHERRY_PICK_SEES_EMPTY_COMMIT=1
 KNOWN_FAILURE_NOFF_MERGE_DOESNT_CREATE_EMPTY_SUBMODULE_DIR=1
 test_submodule_switch "git_stash"
 
+setup_basic() {
+	git init sub &&
+	(
+		cd sub &&
+		test_commit sub_file
+	) &&
+	git init main &&
+	(
+		cd main &&
+		git submodule add ../sub &&
+		test_commit main_file
+	) &&
+	test_when_finished "rm -rf main sub"
+}
+
+test_expect_success 'stash push with submodule.recurse=true preserves dirty submodule worktree' '
+	setup_basic &&
+	(
+		cd main &&
+		git config submodule.recurse true &&
+		echo "x" >main_file.t &&
+		echo "y" >sub/sub_file.t &&
+		git stash push &&
+		test_must_fail git -C sub diff --quiet
+	)
+'
+
+test_expect_success 'stash push and pop with submodule.recurse=true preserves dirty submodule worktree' '
+	setup_basic &&
+	(
+		cd main &&
+		git config submodule.recurse true &&
+		echo "x" >main_file.t &&
+		echo "y" >sub/sub_file.t &&
+		git stash push &&
+		git stash pop &&
+		test_must_fail git -C sub diff --quiet
+	)
+'
+
 test_done
-- 
2.23.0

