Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF14CC433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBAE8610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245415AbhIMPrG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245594AbhIMPqn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:43 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17099C0A889C
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:36 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id r128-20020a1c4486000000b003065f0bc631so2622248wma.0
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ifyGM1bGx9+z5iO0Tty9Ca+lQnQVolwT7KptW3JJAZo=;
        b=VWh86H9m7SmLvNwEOUnmS0onIrwUseWxLcXLTrjmJ8bXP/J9OXHm3Mnukrr2+3RyMG
         xfNP4vraWIvXJiqIT0PxjjDIgcsvl2jJNzd8LC57qmujcB1ZQbisWGt2UiEsr8ZPIHEJ
         DRM07CQX3Y4VBYF7OfJfrKYjEqaxopkmDsmGIS8b/MMk99Vzpf6sUp2yZGj7Dzqt7FAF
         HwhmIXDwYVyhIk2mhzDDGiZVipsW8oNJptWL7U9WzTVz6UsRrpE5BxHgPKwFGzFyvE6k
         JLQ7L5GCTx6qupbDRnlVFvXu5Sx06GhotNwWMIET7gPTOp4cF0DLHGeZ0RC9IN9mE3ws
         +wVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ifyGM1bGx9+z5iO0Tty9Ca+lQnQVolwT7KptW3JJAZo=;
        b=Q2Mvw8Es1alkKQDEdq2YB3BxjY9XGN/uQeLgdfr3f5NYzQw4Wk5W48dqkYkSfvVzOP
         FlO9qNWlFqvYEbWje76LMe04q6rhWBT1qqnNON5I2sP/tueRCuXzlQm1TowCRVxVXGJP
         sm2Gx3pVjyp1TU9EGSzzruxeCbWhkbeIez+1DIhPNy9acdqZDXj29nvdCztmFP41yPJO
         q/4BFbjBb7fUJF2jpZ3HE/d5qJhUoJxaKYK/pVof0py8315EacJVpilYK7WSZHNIWf1f
         Uiz7RloK48ooLfg0MZ7aNwEkLLHuOHfrSPIE+O0SCm/HNVJBlEcYRm9ZMBsC3QISuFQC
         SnTQ==
X-Gm-Message-State: AOAM5335A6MVyGpimc1lfI7eemAKVB70sTALzE61c/YLlBTJ7nGVYjOD
        60rPfPCVcrRAYWFN+DysMaFSS80NaIw=
X-Google-Smtp-Source: ABdhPJwl/UlTQLRudHGXSTgoYedTQ/4N4CdlGHbZMxfVkHIIWSYfWQ053fz1YPR9SdkPgS7IsJWEoQ==
X-Received: by 2002:a05:600c:21d9:: with SMTP id x25mr5498060wmj.7.1631546374739;
        Mon, 13 Sep 2021 08:19:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a10sm7844824wrd.51.2021.09.13.08.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:33 -0700 (PDT)
Message-Id: <951de6bb1992773cda60791c4b7a09867b5e0f19.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:22 +0000
Subject: [PATCH v2 11/11] rebase: dereference tags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Aborting a rebase stated with 'git rebase <upstream> <tag-object>'
should checkout the commit pointed to by <tag-object>. Instead it gives

    error: update_ref failed for ref 'HEAD': cannot update ref 'HEAD':
    trying to write non-commit object
    710d743b2b9892457fdcc3970f397e6ec07447e0 to branch 'HEAD'

This is because when we parse the command line arguments although we
check that the tag points to a commit we remember the oid of the tag
and try and checkout that object rather than the commit it points
to. Fix this by using lookup_commit_reference_by_name() when parsing
the command line.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
---
 builtin/rebase.c        | 14 ++++++++------
 t/t3407-rebase-abort.sh | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 74663208468..2b70a196f9a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1903,13 +1903,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			die_if_checked_out(buf.buf, 1);
 			options.head_name = xstrdup(buf.buf);
 		/* If not is it a valid ref (branch or commit)? */
-		} else if (!get_oid(branch_name, &options.orig_head) &&
-			   lookup_commit_reference(the_repository,
-						   &options.orig_head))
+		} else {
+			struct commit *commit =
+				lookup_commit_reference_by_name(branch_name);
+			if (!commit)
+				die(_("no such branch/commit '%s'"),
+				    branch_name);
+			oidcpy(&options.orig_head, &commit->object.oid);
 			options.head_name = NULL;
-		else
-			die(_("no such branch/commit '%s'"),
-			    branch_name);
+		}
 	} else if (argc == 0) {
 		/* Do not need to switch branches, we are already on it. */
 		options.head_name =
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 162112ba5ea..ebbaed147a6 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -11,18 +11,18 @@ test_expect_success setup '
 	test_commit a a a &&
 	git branch to-rebase &&
 
-	test_commit b a b &&
-	test_commit c a c &&
+	test_commit --annotate b a b &&
+	test_commit --annotate c a c &&
 
 	git checkout to-rebase &&
 	test_commit "merge should fail on this" a d d &&
-	test_commit "merge should fail on this, too" a e pre-rebase
+	test_commit --annotate "merge should fail on this, too" a e pre-rebase
 '
 
 # Check that HEAD is equal to "pre-rebase" and the current branch is
 # "to-rebase"
 check_head() {
-	test_cmp_rev HEAD pre-rebase &&
+	test_cmp_rev HEAD pre-rebase^{commit} &&
 	test "$(git symbolic-ref HEAD)" = refs/heads/to-rebase
 }
 
@@ -67,6 +67,16 @@ testrebase() {
 		test_path_is_missing "$state_dir"
 	'
 
+	test_expect_success "rebase$type --abort when checking out a tag" '
+		test_when_finished "git symbolic-ref HEAD refs/heads/to-rebase" &&
+		git reset --hard a -- &&
+		test_must_fail git rebase$type --onto b c pre-rebase &&
+		test_cmp_rev HEAD b^{commit} &&
+		git rebase --abort &&
+		test_cmp_rev HEAD pre-rebase^{commit} &&
+		! git symbolic-ref HEAD
+	'
+
 	test_expect_success "rebase$type --abort does not update reflog" '
 		# Clean up the state from the previous one
 		git reset --hard pre-rebase &&
-- 
gitgitgadget
