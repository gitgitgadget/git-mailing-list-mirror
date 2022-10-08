Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A57EC433FE
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 01:01:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229624AbiJHBBB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 21:01:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJHBAu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 21:00:50 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FFAE5FFB
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 18:00:48 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id o5so3787113wms.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 18:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V0VGIDMlZhtjJBVHGWHMaQV8BA2gFp7mEq4m/ym1stc=;
        b=ZfQLK0u3XPFe4haRnOYBgqpWduwPf0WG8AaQKrFpcvUU+Dpz8HopZ2nTZEvNuYLMhU
         lfkCxZlcXQksDeaCfGKbsVPyP4LkkxYpf1rtOYwSaZxOMtTwoLlTDOF4jfbv4EZUQKcZ
         jiyNO6Urrq1DutZftL3e4b/pDx1OmYjNTG3KkKX9Jskyu3bACpBAbgY0PmsY1CcIxDKi
         rh64j7MtnwUHpcVo7YDSlwbsX+rRNmYBUSbCuU6xs0tljGxDCmXIWC2sgfSLoO/5aLpK
         TwhmiyzC8MSOOY/fZRkKJI/UBI3YGaoiDkvN8mGeAq128Hrtm1Jlsj245yygaAI8jzJr
         1O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V0VGIDMlZhtjJBVHGWHMaQV8BA2gFp7mEq4m/ym1stc=;
        b=nzkgoBxMp7LHmLU87gcuyuOnNTLE8jIizMaTynu6kO3CO3bPutTuDCAUYLnKkfObMb
         5O464h9kfvooj8/AMLM3JppHuUZF62cbBTfIpyfSbI+zFk416cZ91slWhhpzdS+uEif+
         R+3DrIlAapzVH6fOdglK+XH0n/J7xvT6IwrFolX7LGc9CpI+ymI84u02U07SLqLR9mRm
         jBixnR+NLCjv9aio4hePd/7OQoPBKzuDOUliA3H9FWfKY7ONv3FdLYoV+AbgJQXMu5g7
         fdgQ4tu1XHxuWOW7mOv2TULsSr0QXrTy79Jp+GJCnf1q78ixofu+g4V+4AVS3P4c0bnP
         7Pnw==
X-Gm-Message-State: ACrzQf1L25nGQk5c56rnoKE6tO1B6O6dvzaAB9RnruNa7eIko9y5Znnl
        mNkiD9haOJzYHNAgr0BXlAkiYHYOS7Y=
X-Google-Smtp-Source: AMsMyM6kPZnHp9Mcl9vztoqhOZS0GKZ7x5jSb7USc91YdVnBC+Wsad6Y3Kx+mahyGVk6xOfdknJ3Sg==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr12575074wmb.50.1665190822469;
        Fri, 07 Oct 2022 18:00:22 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id l25-20020a7bc459000000b003a62400724bsm3540349wmi.0.2022.10.07.18.00.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 18:00:22 -0700 (PDT)
Subject: [PATCH v4] branch: support for shortcuts like @{-1}, completed
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Message-ID: <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
Date:   Sat, 8 Oct 2022 03:00:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

branch command with options "edit-description", "set-upstream-to" and
"unset-upstream" expects a branch name.  Since ae5a6c3684 (checkout:
implement "@{-N}" shortcut name for N-th last branch, 2009-01-17) a
branch can be specified using shortcuts like @{-1}.  Those shortcuts
need to be resolved when considering the arguments.

We can modify the description of the previously checked out branch with:

$ git branch --edit--description @{-1}

We can modify the upstream of the previously checked out branch with:

$ git branch --set-upstream-to upstream @{-1}
$ git branch --unset-upstream @{-1}

Signed-off-by: Rubén Justo <rjusto@gmail.com>

---

To simplify the patch and make it easier to review, I removed all
refactoring related to return codes and errors.  Leaving that and
everything else discussed in the thread, to next series.

This patch now only has one commit with the missing @{-N} handling
completed and the tests for it.  Some refactoring has been done in
the test as well.


Un saludo.


 builtin/branch.c                      | 34 +++++++++++++++++++++------
 t/t3204-branch-name-interpretation.sh | 24 +++++++++++++++++++
 2 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 55cd9a6e99..197603241d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -791,19 +791,23 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 	} else if (edit_description) {
 		const char *branch_name;
 		struct strbuf branch_ref = STRBUF_INIT;
+		struct strbuf buf = STRBUF_INIT;
 
 		if (!argc) {
 			if (filter.detached)
 				die(_("Cannot give description to detached HEAD"));
 			branch_name = head;
-		} else if (argc == 1)
-			branch_name = argv[0];
+		} else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch_name = buf.buf;
+		}
 		else
 			die(_("cannot edit description of more than one branch"));
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf)) {
 			strbuf_release(&branch_ref);
+			strbuf_release(&buf);
 
 			if (!argc)
 				return error(_("No commit on branch '%s' yet."),
@@ -814,8 +818,11 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		}
 		strbuf_release(&branch_ref);
 
-		if (edit_branch_description(branch_name))
+		if (edit_branch_description(branch_name)) {
+			strbuf_release(&buf);
 			return 1;
+		}
+		strbuf_release(&buf);
 	} else if (copy) {
 		if (!argc)
 			die(_("branch name required"));
@@ -835,9 +842,15 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		else
 			die(_("too many arguments for a rename operation"));
 	} else if (new_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
+		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to set new upstream"));
 
 		if (!branch) {
@@ -854,11 +867,17 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		dwim_and_setup_tracking(the_repository, branch->name,
 					new_upstream, BRANCH_TRACK_OVERRIDE,
 					quiet);
+		strbuf_release(&buf);
 	} else if (unset_upstream) {
-		struct branch *branch = branch_get(argv[0]);
+		struct branch *branch;
 		struct strbuf buf = STRBUF_INIT;
 
-		if (argc > 1)
+		if (!argc)
+			branch = branch_get(NULL);
+		else if (argc == 1) {
+			strbuf_branchname(&buf, argv[0], INTERPRET_BRANCH_LOCAL);
+			branch = branch_get(buf.buf);
+		} else
 			die(_("too many arguments to unset upstream"));
 
 		if (!branch) {
@@ -871,6 +890,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		if (!branch_has_merge_config(branch))
 			die(_("Branch '%s' has no upstream information"), branch->name);
 
+		strbuf_reset(&buf);
 		strbuf_addf(&buf, "branch.%s.remote", branch->name);
 		git_config_set_multivar(buf.buf, NULL, NULL, CONFIG_FLAGS_MULTI_REPLACE);
 		strbuf_reset(&buf);
diff --git a/t/t3204-branch-name-interpretation.sh b/t/t3204-branch-name-interpretation.sh
index 993a6b5eff..71afceac71 100755
--- a/t/t3204-branch-name-interpretation.sh
+++ b/t/t3204-branch-name-interpretation.sh
@@ -133,4 +133,28 @@ test_expect_success 'checkout does not treat remote @{upstream} as a branch' '
 	expect_branch HEAD one
 '
 
+test_expect_success 'edit-description via @{-1}' '
+	git checkout -b desc-branch &&
+	git checkout -b non-desc-branch &&
+	write_script editor <<-\EOF &&
+		echo "Branch description" >"$1"
+	EOF
+	EDITOR=./editor git branch --edit-description @{-1} &&
+	test_must_fail git config branch.non-desc-branch.description &&
+	git config branch.desc-branch.description >actual &&
+	echo "Branch description\n" >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'modify branch upstream via "@{-1}" and "@{-1}@{upstream}"' '
+	git checkout -b upstream-branch &&
+	git checkout -b upstream-other -t upstream-branch &&
+	git branch --set-upstream-to upstream-other @{-1} &&
+	git config branch.upstream-branch.merge >actual &&
+	echo "refs/heads/upstream-other" >expect &&
+	test_cmp expect actual &&
+	git branch --unset-upstream @{-1}@{upstream} &&
+	test_must_fail git config branch.upstream-other.merge
+'
+
 test_done
-- 
2.32.0
