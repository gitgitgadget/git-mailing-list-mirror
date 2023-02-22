Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ABCC636D6
	for <git@archiver.kernel.org>; Wed, 22 Feb 2023 22:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232947AbjBVW4h (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Feb 2023 17:56:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbjBVW4g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2023 17:56:36 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69E43756E
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:56:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h14so626943wru.4
        for <git@vger.kernel.org>; Wed, 22 Feb 2023 14:56:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rDYA90/4tNivTK3xW/SiitYTOAREbNwsnL8z2zg/Ims=;
        b=iyrzoSaOnEgu0zgUoijv7MFK67Bb2FG0b/HHnL1HYQVb+R4QLDN+bk4o6bty1Kj+2K
         hcvX/YHgE6i0SqtezpXCjVpnk4fP4WOBYGKGPTkbqpwihZG72H1pS3+rIQ3Cg4OELJci
         w4A2S+4NoTAErLaE8vZTz9nLUQ39Tqq/3OD52KtUoZ24WNKf+oKUz7makoHGrAYAxsOI
         5J6GFJ3g8IQhzCQ1k5zd1VRz0HWTwrvlu0itoG+iLOBZ8PSpYDoB+TidObR0agiYg6sb
         WLE43g6PvyCG0pGsLnF9FXvNcO/NHbpsgLFDfeHEIlOceEGxg9p6WnLIONNUDG5Jqths
         Q4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rDYA90/4tNivTK3xW/SiitYTOAREbNwsnL8z2zg/Ims=;
        b=d9adxmZp05oKtHvD1vacPB4Pn6d1PhD69CAR3g3Fiz2PvvV1fida/m7C7phh7IOCV7
         7acbDDBviXPoDwzqhfVIlSfYoGfyqe1m26G4PdIDGXTGzshcF7IJ3wn2xKy+PNp4rmas
         ZGoKameaKJC4YNGGkUCN4WLSnWtKoORh18vlmi3hIkSJfrDXDy67csqYLPpLgvKecfie
         5+0oH7D7sYiYbsiuiW5C+8ycpdEZ+/D8OjOvw+QNnbL5XjvFZEwervlPZoay6j3uPj+p
         wcYl6wFlqSJb6ZoSixMikOa7SsiOMydNP5B+0DTkrYyhWnT02yRv4JbnXbe2/WB2Qy4X
         4v8w==
X-Gm-Message-State: AO0yUKWmcae3c9QkDSZi7+I3jC6M0tv2cIW9KVS2nWmsWiTActHbkEGh
        s46DtcJP5Aez6wtt+87DgAE=
X-Google-Smtp-Source: AK7set+GFjdBu45597XQdggZGXvmfZbE7NhiivHnUkk6dbwWoUpYjYMSa5WT+ejxwQuvCchTOeYOng==
X-Received: by 2002:a5d:6190:0:b0:2c7:a0b:e8d2 with SMTP id j16-20020a5d6190000000b002c70a0be8d2mr3677303wru.19.1677106593211;
        Wed, 22 Feb 2023 14:56:33 -0800 (PST)
Received: from [192.168.2.52] (59.red-88-14-203.dynamicip.rima-tde.net. [88.14.203.59])
        by smtp.gmail.com with ESMTPSA id n11-20020a5d51cb000000b002c5804b6afasm5366108wrv.67.2023.02.22.14.56.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 14:56:32 -0800 (PST)
Subject: [PATCH v4 3/3] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Message-ID: <3d567892-bdd0-9ad9-a30e-1a67e7face11@gmail.com>
Date:   Wed, 22 Feb 2023 23:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch, skipping rename_ref() if
the branch being renamed is an orphan branch; checking the current HEAD.

However the branch to be renamed can be an orphan branch in a different
worktree than the current one, i.e. not the current HEAD.

In "copy_or_rename_branch()" we are traversing the worktrees checking if
the branch to be renamed is HEAD in any worktree.  Let's include also a
check for HEAD being NULL, which is the indication of an orphan branch,
and use it to extend what we did in cfaff3aac, to all HEADs in the
repository.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  | 16 ++++++++++------
 t/t3200-branch.sh | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index aecf009993..24cd66bae7 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -489,6 +489,7 @@ static void print_current_branch_name(void)
 #define IS_BISECTED 1
 #define IS_REBASED 2
 #define IS_HEAD 4
+#define IS_ORPHAN 8
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
@@ -514,8 +515,11 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	for (int i = 0; worktrees[i]; i++) {
 		struct worktree *wt = worktrees[i];
 
-		if (wt->head_ref && !strcmp(oldref.buf, wt->head_ref))
+		if (wt->head_ref && !strcmp(oldref.buf, wt->head_ref)) {
 			oldref_usage |= IS_HEAD;
+			if (is_null_oid(&wt->head_oid))
+				oldref_usage |= IS_ORPHAN;
+		}
 
 		if (!wt->is_detached)
 			continue;
@@ -531,8 +535,9 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		}
 	}
 
-	if ((copy || !(oldref_usage & IS_HEAD)) && !ref_exists(oldref.buf)) {
-		if (oldref_usage & IS_HEAD)
+	if ((copy || !(oldref_usage & IS_HEAD)) &&
+	    ((oldref_usage & IS_ORPHAN) || !ref_exists(oldref.buf))) {
+		if (oldref_usage & IS_ORPHAN)
 			die(_("No commit on branch '%s' yet."), oldname);
 		else
 			die(_("No branch named '%s'."), oldname);
@@ -567,8 +572,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
@@ -583,7 +587,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 				interpreted_oldname);
 	}
 
-	if (!copy) {
+	if (!copy && (oldref_usage & IS_HEAD)) {
 		/*
 		 * Update all per-worktree HEADs pointing at the old ref to
 		 * point the new ref.
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..5aef00efde 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,20 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -m should work with orphan branches' '
+	test_when_finished git checkout - &&
+	test_when_finished git worktree remove -f wt &&
+	git worktree add wt --detach &&
+	# rename orphan in another worktreee
+	git -C wt checkout --orphan orphan-foo-wt &&
+	git branch -m orphan-foo-wt orphan-bar-wt &&
+	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
+	# rename orphan in the current worktree
+	git checkout --orphan orphan-foo &&
+	git branch -m orphan-foo orphan-bar &&
+	test orphan-bar=$(git branch --show-current)
+'
+
 test_expect_success 'git branch -d on orphan HEAD (merged)' '
 	test_when_finished git checkout main &&
 	git checkout --orphan orphan &&
-- 
2.34.1
