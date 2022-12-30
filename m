Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B94DC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 23:04:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235531AbiL3XE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 18:04:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbiL3XE4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 18:04:56 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA1191A23C
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:04:54 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id i17-20020a05600c355100b003d99434b1cfso5889639wmq.1
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:04:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kWDWQh01R8xQtacl7utJ1ASSye/wNZ6MnMvI9mG9dm4=;
        b=mzUKusl1yxMgeWMSjzaFZH10SCukdBjVqoX+fMG9TgR0sMDk0g1HOLiSN2653TuwfN
         eI6CQIMYx2huincQ80zfHXKrGAx2aSU7UYfbMkxtCga1ZSr+TIa0/BDNfLISunH+KjDS
         cxl7zvMn/Bfj67gHa3G5boezR4LtibiuSH3j0bKk61cv/wASeSrEWlkCVKxpNuAgVXfS
         SaigE28xLq3kj8bqVupBSRGzNSAZeloBGntA6drHI8NLhCdbHe7vktpuEvrLw5hL+vbz
         PwhPrsoEmaOcuuNfw9s34/4DbjUSOILYtPn3k0v6VS7BtAAO6Gku7YJk623JhHiTiIz/
         wdlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kWDWQh01R8xQtacl7utJ1ASSye/wNZ6MnMvI9mG9dm4=;
        b=C8w3BbvSrDfYkVjEXHn40Fp0utC3bvfOTjl/nmHkIscOp1IwRLjEPCzkuNQRWlgoXN
         uL6UjUUbSWZBAiCtCD4H1lds0Ff8EiPO2L1RZ06pysLVf61akyvJltVlH40pexAb6/h+
         UYDSFdmZrUZ4jaLFNumuFRs63P5qGzM1OnUzWpwqxu+msLgaZbDqGbwBg7TQdMHWf20J
         CoMVB/LlHjpo3tYN6cgHQ62wNR20ebF8YNAeqsKvM1iofpAqvE7T2y2ywp5ZyD7QZnLn
         8e4kfK59UO8TUfFkgpnKv1rq9NVa1+I7Y7hG7BhFc2WD8i/XmEm2AhCVbLVarzz5A4pq
         y8UA==
X-Gm-Message-State: AFqh2kpp01qg6shaXZplQnxE5kw3P9rnY9SEC/Wxez+HA1x2JQ1fCNB3
        gUXkwMN37lFtlRctArIEyqcOTA65LAY=
X-Google-Smtp-Source: AMrXdXtNk2P2K/GVeyFkGZbBqzcYCN2osi3ZuMvf3ve3AStMRC2ArP0jxYEjtpnBMW5dV28cDYTKCQ==
X-Received: by 2002:a05:600c:4496:b0:3d3:47b7:569e with SMTP id e22-20020a05600c449600b003d347b7569emr23354400wmo.2.1672441493237;
        Fri, 30 Dec 2022 15:04:53 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id m18-20020a05600c3b1200b003a6125562e1sm32868477wms.46.2022.12.30.15.04.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:04:52 -0800 (PST)
Subject: [PATCH 1/2] branch: description for orphan branch errors
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Cc:     junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Message-ID: <dd86016b-3232-563b-940e-03bc36af917a@gmail.com>
Date:   Sat, 31 Dec 2022 00:04:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In bcfc82bd48 (branch: description for non-existent branch errors,
2022-10-08) we used "strcmp(head, branch)" to check if we're asked to
operate in a branch that is the current HEAD, and
"ref_exists(branch_ref)" to check if it points to a valid ref, i.e. it
is an orphan branch.  We are doing this with the intention of avoiding
the confusing error: "No branch named..."

If we're asked to operate with an orphan branch, but it is on a
different worktree, "strcmp(head, branch)" is not going to match:

	$ git worktree add orphan-worktree --detach
	$ git -C orphan-worktree checkout --orphan orpha-branch
	$ git branch -m orpha-branch orphan-branch
	fatal: No branch named 'orpha-branch'.

Let's do the check for HEAD in any worktree in the repository, removing
the "strcmp" and using the helper introduced in 31ad6b61bd (branch: add
branch_checked_out() helper, 2022-06-15)

This commit also extends the tests introduced on bcfc82bd48, in
t3202-show-branch, to cover not just the initial branch but any orphan
branch.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c       |  8 ++++----
 t/t3202-show-branch.sh | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index f63fd45edb..954008e51d 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -528,8 +528,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			die(_("Invalid branch name: '%s'"), oldname);
 	}
 
-	if ((copy || strcmp(head, oldname)) && !ref_exists(oldref.buf)) {
-		if (copy && !strcmp(head, oldname))
+	if ((copy || !branch_checked_out(oldref.buf)) && !ref_exists(oldref.buf)) {
+		if (copy && branch_checked_out(oldref.buf))
 			die(_("No commit on branch '%s' yet."), oldname);
 		else
 			die(_("No branch named '%s'."), oldname);
@@ -806,7 +806,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
 		if (!ref_exists(branch_ref.buf))
-			error((!argc || !strcmp(head, branch_name))
+			error((!argc || branch_checked_out(branch_ref.buf))
 			      ? _("No commit on branch '%s' yet.")
 			      : _("No branch named '%s'."),
 			      branch_name);
@@ -851,7 +851,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		}
 
 		if (!ref_exists(branch->refname)) {
-			if (!argc || !strcmp(head, branch->name))
+			if (!argc || branch_checked_out(branch->refname))
 				die(_("No commit on branch '%s' yet."), branch->name);
 			die(_("branch '%s' does not exist"), branch->name);
 		}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index ea7cfd1951..acaedac34e 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -221,4 +221,40 @@ test_expect_success 'fatal descriptions on non-existent branch' '
 	test_cmp expect actual
 '
 
+test_expect_success 'error descriptions on orphan or unborn-yet branch' '
+	cat >expect <<-EOF &&
+	error: No commit on branch '\''orphan-branch'\'' yet.
+	EOF
+	test_when_finished git worktree remove -f orphan-worktree &&
+	git worktree add orphan-worktree --detach &&
+	git -C orphan-worktree checkout --orphan orphan-branch &&
+	test_must_fail git -C orphan-worktree branch --edit-description 2>actual && # implicit branch
+	test_cmp expect actual &&
+	test_must_fail git -C orphan-worktree branch --edit-description orphan-branch 2>actual && # explicit branch
+	test_cmp expect actual &&
+	test_must_fail git branch --edit-description orphan-branch 2>actual && # different worktree
+	test_cmp expect actual
+'
+
+test_expect_success 'fatal descriptions on orphan or unborn-yet branch' '
+	cat >expect <<-EOF &&
+	fatal: No commit on branch '\''orphan-branch'\'' yet.
+	EOF
+	test_when_finished git worktree remove -f orphan-worktree &&
+	git worktree add orphan-worktree --detach &&
+	git -C orphan-worktree checkout --orphan orphan-branch &&
+	test_must_fail git -C orphan-worktree branch --set-upstream-to=non-existent 2>actual && # implicit branch
+	test_cmp expect actual &&
+	test_must_fail git -C orphan-worktree branch --set-upstream-to=non-existent orphan-branch 2>actual && # explicit branch
+	test_cmp expect actual &&
+	test_must_fail git branch --set-upstream-to=non-existent orphan-branch 2>actual && # different worktree
+	test_cmp expect actual &&
+	test_must_fail git -C orphan-worktree branch -c new-branch 2>actual && # implicit branch
+	test_cmp expect actual &&
+	test_must_fail git -C orphan-worktree branch -c orphan-branch new-branch 2>actual && # explicit branch
+	test_cmp expect actual &&
+	test_must_fail git branch -c orphan-branch new-branch 2>actual && # different worktree
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.0
