Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D6CAC05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjBFXGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:06:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBFXGq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:06:46 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA252C676
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:06:43 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id h16so11916515wrz.12
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:06:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z0AvMxXIs9j9HgcP5jTp403PlQDQYWd4vpAS+pJXyi0=;
        b=Ymll4dRCa8q/kfKScUJQZWv9tqVLDuBmqdH3fd5VB+wumeLCQInPO299CaXpwBuNGe
         +uWZiHZnmYcC59HgyFQlynXCJ3F/vU4jDXAkOMjKljDJcM7bNsBMX+8BDyaMwqbU//Fx
         ZkNcr6J+AgNqOglhtQRBBwFxtxyteJLs65I1xlq32wzm2l7OXFS7PeiZIVya223sKFyZ
         rlwphPM0BY1d5bqPo4+NZt4mgF+MNKK5YZRC2lVK5rTJvM6C/Kh5O1SlMOif+Rs7LO/5
         yK7u8Q8jn9Fgq6rTcAO07QFGkugGeU3U4VzaIMKUjKLLbJqHNIKqKtIx8JSu5MVNTPQM
         nv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0AvMxXIs9j9HgcP5jTp403PlQDQYWd4vpAS+pJXyi0=;
        b=4/FRW+4hzlnqi/shxzXr5E8jBbfUVYnGiJB5U6ve9GnBuozp1mm2O5Up+MX5wZzEQb
         CYHSdI8QNgWpNtfV9aFiQ3iAtCfNczSPaXJWCF3av3lGqcSPtYqNcOin1CS06rqI/Xgm
         0MaxBleJWGsag/ImWWIJj7xexYHaatIskUKsQsiS10Ctkuwv7QawSiDpcFlziCD5pqO+
         cyQHwy5Ei/1/988XRSuT24QzfKScQInsA+3TqySUakx4cMqU3XtQ9/Sld9fA9SSYbCWz
         EuQ2CK5qk5xbnTrWcBtAQTE0Iv5Yr5OTSCs28M1apMv+HW1GwdjIg1JJSlVkmb3jmZ8B
         g1lQ==
X-Gm-Message-State: AO0yUKX/nuDxHhjCwV8GmtPnXKcdhS1MgtLOpjpA/qYaFFsiFFCIeJIJ
        YKhcxNRiTbt2xUxhbqj9GDqU54Us2ns=
X-Google-Smtp-Source: AK7set+Ax6df0aFq0t9FcNzmIxMnHD+leA2tu8J3RsI+gln1dYymaYxU7CaRhfR4RJnA6U3wYiFS3w==
X-Received: by 2002:a05:6000:1a48:b0:2c3:db98:3e93 with SMTP id t8-20020a0560001a4800b002c3db983e93mr576446wry.18.1675724802435;
        Mon, 06 Feb 2023 15:06:42 -0800 (PST)
Received: from [192.168.2.52] (85.red-88-14-56.dynamicip.rima-tde.net. [88.14.56.85])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b002bfb8f829eesm10402311wry.71.2023.02.06.15.06.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 15:06:41 -0800 (PST)
Subject: [PATCH v3 3/3] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Message-ID: <ec027400-db8f-434d-2045-8a0ba0a35117@gmail.com>
Date:   Tue, 7 Feb 2023 00:06:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch, skipping rename_ref() if
the branch being renamed is an orphan branch; checking the current HEAD.

But the orphan branch to be renamed can be an orphan branch in a
different worktree than the current one, i.e. not the current HEAD.

Let's make "die_if_branch_is_being_rebased_or_bisected()" return if the
specified branch is HEAD and orphan, and use it to extend what we did in
cfaff3aac, to check all HEADs in the repository.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  | 16 +++++++++-------
 t/t3200-branch.sh | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 28cec344ad..7efda62224 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -488,7 +488,8 @@ static void print_current_branch_name(void)
 
 /*
  * Dies if the specified branch is being rebased or bisected.  Otherwise returns
- * 0 or, if the branch is HEAD in any worktree, returns 1.
+ * 0 or, if the branch is HEAD in any worktree, returns 1. If the branch is HEAD
+ * and also orphan, returns 2.
  */
 static int die_if_branch_is_being_rebased_or_bisected(const char *target)
 {
@@ -499,7 +500,7 @@ static int die_if_branch_is_being_rebased_or_bisected(const char *target)
 		struct worktree *wt = worktrees[i];
 
 		if (wt->head_ref && !strcmp(target, wt->head_ref))
-			ret = 1;
+			ret = is_null_oid(&wt->head_oid) ? 2 : 1;
 
 		if (!wt->is_detached)
 			continue;
@@ -523,7 +524,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	struct strbuf oldsection = STRBUF_INIT, newsection = STRBUF_INIT;
 	const char *interpreted_oldname = NULL;
 	const char *interpreted_newname = NULL;
-	int recovery = 0, oldref_is_head;
+	int recovery = 0, oldref_is_head, oldref_is_orphan;
 
 	if (strbuf_check_branch_ref(&oldref, oldname)) {
 		/*
@@ -537,9 +538,11 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	}
 
 	oldref_is_head = die_if_branch_is_being_rebased_or_bisected(oldref.buf);
+	oldref_is_orphan = (oldref_is_head > 1);
 
-	if ((copy || !oldref_is_head) && !ref_exists(oldref.buf))
-		die(oldref_is_head
+	if ((copy || !oldref_is_head) &&
+	    (oldref_is_orphan || !ref_exists(oldref.buf)))
+		die(oldref_is_orphan
 		    ? _("No commit on branch '%s' yet.")
 		    : _("No branch named '%s'."), oldname);
 
@@ -564,8 +567,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !oldref_is_orphan &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
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
2.39.0
