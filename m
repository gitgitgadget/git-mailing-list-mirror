Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 890D1C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 23:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiL3XMJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Dec 2022 18:12:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235616AbiL3XMI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 18:12:08 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FD9DE81
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:12:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id p1-20020a05600c1d8100b003d8c9b191e0so16084741wms.4
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8YHuptPaLp0v/SXDA9Z1UqhYs4bBHSzvH6tt8JPsC2o=;
        b=QEZEtkkzelC9kq3FgsCvDuTXlbQhu0GHyD8yl8W8FHMsdwZdlBAnRUSuDsyqgn+YpN
         hLBt0Y5sTEmMiL3gPqiwhfxvb5/SmDDBsBeXDc2bQ///UuXUblVHQaCCFPsHEVk/njRz
         0P3tv6gZjQcknjqLTZcPcuSAvqI3VotNyJR/tx6ZSnA+5Xbw65selTqklnyGuMW6hCqW
         WuBwh7dR+Gz/BLym2AY5v338ICh8KbiRuEfDCVTh3EZ2MkRBvd/Ukgco1itnGWvhDjdc
         FZcnjCkAGNj5cHSVmIIbefbZWaU8ofbZG6HwYoS8luzLJI1yQ+2TcCckhjHkezqaErK5
         hF8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:cc:references:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8YHuptPaLp0v/SXDA9Z1UqhYs4bBHSzvH6tt8JPsC2o=;
        b=xkYxPhwnsCsMMwcEn3OXG4YmVhZpxxlK9us8T/w5pHLP49K0dLLiHnsaAm0hNrUNUj
         i+9kmdrUc69Cau0U+sHaTNXJNvk3evcp0B9S7yBGLogozcdTyoAyp5u8ciF1qEdmFWWO
         1xWFlrQHpAUrt4c5d8cMuESLJ3d/FloMBy/qdGsR93S6ZGEidJcxxhLgpx5Lm7iZ5kbx
         yV2QmlQaQMf9lA4lseAg4dpw84Y+YqyiPKYKW0YDZhgB9jHZL5yDY3ZMNuTmucDyCmRm
         FdtE9ef0Vuf9HfitVZio7sWGTky1wyHZjIgoNvxeq4TVLL9SIqZJb3rVJ2jml8mV/kUU
         Z68g==
X-Gm-Message-State: AFqh2kob9dQk4yFCCgdfI0H65k5qupdoWuAUiiOgCVEi0iV2UZO9taGv
        V8fZuIRcBuWpFgiAYWQtFCijRcPwSlQ=
X-Google-Smtp-Source: AMrXdXsDsHEEQlljaMaZ2+l0SpFJwy5dFuez5vbZiabOJZsYetQUewq8wuJU0TkX1rPoPDkox9zqbw==
X-Received: by 2002:a05:600c:4f48:b0:3c6:f7ff:6f87 with SMTP id m8-20020a05600c4f4800b003c6f7ff6f87mr24071293wmq.11.1672441925883;
        Fri, 30 Dec 2022 15:12:05 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id n36-20020a05600c3ba400b003b49bd61b19sm36061977wms.15.2022.12.30.15.12.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Dec 2022 15:12:05 -0800 (PST)
Subject: [PATCH 2/2] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Message-ID: <bce24c2f-47c9-30cf-12b7-48beaf112bdb@gmail.com>
Date:   Sat, 31 Dec 2022 00:12:04 +0100
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

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch in the current working
tree, avoiding the rename_ref() error because an orphan branch does not
point to any ref.

We did this with two checks (note that head cannot be null due to a
precondition in cmd_branch):

 	 if (branch_is_not_head)
 	 	// Only HEAD can be orphan. Do the rename_ref
 	 else if (head_ref_is_valid)
 		// There is a valid ref. Do the rename_ref
 	 else
 		// Nothing to do here. Continue

With worktrees, we can try to rename an orphan branch while we are in a
different worktree, and so the orphan branch we want to rename is not
the HEAD in the current worktree:

	$ git worktree add orphan-worktree --detach
	$ git -C orphan-worktree checkout --orphan orphn-branch
	$ git branch -m orphn-branch orphan-branch
	fatal: No branch named 'orphn-branch'.

Lets fix this considering all HEADs in all worktrees in the repository,
changing the checks introduced in cfaff3aac8 to:

 	 if (branch_is_not_head_in_any_worktree)
 	 	// Only HEADs can be orphan. Do the rename_ref
 	 else if (branch_ref_is_valid)
 		// There is a valid ref. Do the rename_ref
 	 else
 		// Nothing to do here. Continue

Let's also add to t3200-branch tests for this and for normal renames of
orphan branches (other than the initial branch) for which we did not yet
have tests.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  |  2 +-
 t/t3200-branch.sh | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 954008e51d..151541e1c2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -559,7 +559,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 			    oldref.buf, newref.buf);
 
 	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	    (!branch_checked_out(oldref.buf) || ref_exists(oldref.buf)) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..01d616af05 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,18 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -m should work with orphan branches' '
+	test_when_finished git worktree remove -f orphan-worktree &&
+	test_when_finished git checkout - &&
+	git worktree add orphan-worktree --detach &&
+	git -C orphan-worktree checkout --orphan orphan-foo &&
+	git branch -m orphan-foo orphan-bar-wt &&
+	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
+	git checkout --orphan orphan-foo &&
+	git branch -m orphan-foo orphan-bar &&
+	test orphan-bar=$(git branch --show-current)
+'
+
 test_expect_success 'git branch -d on orphan HEAD (merged)' '
 	test_when_finished git checkout main &&
 	git checkout --orphan orphan &&
-- 
2.39.0
