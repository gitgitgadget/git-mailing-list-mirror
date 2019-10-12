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
	by dcvr.yhbt.net (Postfix) with ESMTP id 8916C1F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 15:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729041AbfJLPiV (ORCPT <rfc822;e@80x24.org>);
        Sat, 12 Oct 2019 11:38:21 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:40263 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727402AbfJLPiV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Oct 2019 11:38:21 -0400
Received: by mail-lj1-f193.google.com with SMTP id 7so12600003ljw.7
        for <git@vger.kernel.org>; Sat, 12 Oct 2019 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=a1zx4n4Y3/4CbkSycUaLDyOZaTzsqcWnUIGi2jj5Ils=;
        b=Or+hSLmyfbkKb6verfwCywsD0PuNNmy+nL2GcpEb+gyvf7Iald27A0Jo6ZAuXfYSZD
         Sl6ZVGUSsjZOFgIxtIEaxZPFsmmrH/GN94CSrsJeMR9REWchfh1Gb+CsXfgvTPSVgZSL
         ry/pNFEp42jdLWhi+9ehzI0m1KMUa9SuEKOMiHWObEHvgy4ko1y+EqjeG8ptNiCsyPWC
         FfTTcuIaFHV9vSHR//s8iMTk0N+itfRoN2tvREFTZ/evlCWGCX69ggVh7bE+2YGWowvE
         3rtG1DDZDcxvoq0e3K5SpiZp1h5pqQYUivxCnYYq39d+4RG/hPBH8OExKSBE44sDzNcG
         5EXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=a1zx4n4Y3/4CbkSycUaLDyOZaTzsqcWnUIGi2jj5Ils=;
        b=Y2qNkXj/Htc4AvKYLiUfwJ8N84gIsj3/LcQSB5c7T7obuDMXoGu69v5zXgdKAHpoAV
         lqZJqnYL2b7Ab5IgXfJcJ31A8xfC0D8yobD6QgblS9vyar1EFEYf1TLUs/QCAYka4YEC
         gu+c0v6s2ijIAVpSjlRLj2LmllwifVuY2NSD07S6ziUHj4GNKRMm5mvYrhsCTSMRxDaC
         WQ5zSvDA6cNev+/16+YfE/3RMdgI+D01dVsS7krSQjJ3aaCXOVBouaU/ZVk/0cODz8gR
         dutpqbIj+DATATJEAhe4FqZr/gzgvXSAdrP3IyCZUjoulo0T1N/TqCn9U4umxRY6Lq2E
         OiEA==
X-Gm-Message-State: APjAAAX6htHtb/ekCiWga18DklASd4hZVRnnqxV2C4AoQMHpxOsXDiiQ
        ca6C2HNojuhwr4wE7HusZT8=
X-Google-Smtp-Source: APXvYqw+x2cd3opVpQEEqO0vdCwZf8RyK300FFH8ojkXPz+27LKzOyYOT7ehBSl+IeWpyRZPPDFVsw==
X-Received: by 2002:a2e:3003:: with SMTP id w3mr12705590ljw.208.1570894699012;
        Sat, 12 Oct 2019 08:38:19 -0700 (PDT)
Received: from OJAN-PAAVO.localdomain ([213.80.106.30])
        by smtp.gmail.com with ESMTPSA id b6sm3171632lfi.72.2019.10.12.08.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2019 08:38:18 -0700 (PDT)
Date:   Sat, 12 Oct 2019 17:38:29 +0200
From:   Jakob Jarmar <jakob.j@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v4] stash: avoid recursive hard reset on submodules
Message-ID: <20191012153829.GB743557@OJAN-PAAVO.localdomain>
References: <CA+xNDHtVc7pJr=SdihKDKiLE9TE_TcpEWWmPq+N9+fFcfM36wA@mail.gmail.com>
 <20191011001114.GB640501@OJAN-PAAVO.localdomain>
 <xmqqeezjhlad.fsf@gitster-ct.c.googlers.com>
 <20191011222448.GA650182@OJAN-PAAVO.localdomain>
 <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqsgnyenwj.fsf@gitster-ct.c.googlers.com>
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
    1. Added space between function name and parentheses
    2. Moved test_when_finished cleanup to top of setup_basic

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
index d7219d6f8f..b93d1d74da 100755
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
 
+setup_basic () {
+	test_when_finished "rm -rf main sub" &&
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
+	)
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

