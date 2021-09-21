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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A0F7C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2B086109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 10:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbhIUKZx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 06:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbhIUKZr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 06:25:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B71C9C0613C1
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:17 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id g16so37591985wrb.3
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 03:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=oH44RwOXLT8MNJILivrCj5vRAIEj7QrO3aKsVGNhmAQ=;
        b=AxIg/YtUzt7knhZxy/lTVG2iXs9OkVGuiRP9XaOAx+02a/df3DhDTwo1tfOAy9S3p4
         Fi9gTT4AA1fo90BmE3Bw6K19Tmaa7MhiGeF7bjd+e2+VtgSvCJGoXYDRIS8/zUM+JgBL
         ZoYsGoxLFhQffbGYrHzflMM/qL11nyuC+CuT8QMEdSKOVa+c8Y/SoWaXitxRxQ4FPzWD
         FLyuboD2uFRUBtmD4yKsj4kaAAHeB0KQNCqp6tg7lZvIlXHEzJMtIH538REFJNpQcBV9
         1YKtZKkGVEllUDwxV7m0kloeTEpMiZzdTpD7j7wJG1j+YJW3Fug5mc6JrVdekLazEq0a
         B+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=oH44RwOXLT8MNJILivrCj5vRAIEj7QrO3aKsVGNhmAQ=;
        b=VkchP+oNBwHEh1oC8B7p7/RZUwtwxpBIaiMqRyn7IiRsEmxlRMK21gag8r4z3nlkp2
         YTBGxM2lEiush8cl0qAAC/Kx8tZw76pe2g4KIHO+oyIcTFsu6H3DxYYT66HZFA5b4dXx
         p3Anag4qlZRYvXwov2qa5PBO7i8uPcX01R5Nn+whjGY3bgqfQsZ9ERBSYGjOEWY+Ql4g
         A7isTyNn0zmzKX/+2dbv7GDuOA+uhnQrOgZqRK8B6GWRlfzyuesOD34kgtF3S3gp4Vkx
         V5h9WEkjaAGYh4Y5uKlqCZZh7Ka0hjeVwK0gjycL2dnUZUVfRKnDJXPDgpwlSJAbg2i7
         8SpQ==
X-Gm-Message-State: AOAM531+BVuyTuW4i9hN65dmVISPMSSjuawZNoPKoxIR3d/oXZOGsp4z
        GW/8Nu1hX3j9Sp4nZJ5BzEm2pziCwSk=
X-Google-Smtp-Source: ABdhPJwvGp8hU+ar3ajjTWKGtpzfII0Tmg9mEFJTtJS397b4ZbKDhs50v8FYrGkPRR8xb0nl4IB1gQ==
X-Received: by 2002:a5d:4b10:: with SMTP id v16mr33737904wrq.176.1632219856053;
        Tue, 21 Sep 2021 03:24:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm6550303wrn.77.2021.09.21.03.24.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 03:24:15 -0700 (PDT)
Message-Id: <55a6250ab38881ba56dfb6e65cf663bd2b631d5f.1632219848.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
References: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
        <pull.1033.v3.git.1632219848.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 21 Sep 2021 10:24:07 +0000
Subject: [PATCH v3 10/10] rebase: dereference tags
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

A rebase started with 'git rebase <A> <B>' is conceptually to first
checkout <B> and run 'git rebase <A>' starting from that state.  'git
rebase --abort' in the middle of such a rebase should take us back to
the state we checked out <B>.

This used to work, even when <B> is a tag that points at a commit,
until Git 2.20.0 when the command was reimplemented in C.  The command
now complains that the tag object itself cannot be checked out, which
may be technically correct but is not what the user asked to do.

Fix this old regression by using lookup_commit_reference_by_name()
when parsing <B>. The scripted version did not need to peel the tag
because the commands it passed the tag to (e.g 'git reset') peeled the
tag themselves.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
---
 builtin/rebase.c        | 14 ++++++++------
 t/t3407-rebase-abort.sh | 18 ++++++++++++++----
 2 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 0ace9e0a8ec..b4433ee7978 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1904,13 +1904,15 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
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
