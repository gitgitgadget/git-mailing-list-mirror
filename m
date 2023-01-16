Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC27C46467
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 00:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231648AbjAPAGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Jan 2023 19:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjAPAGh (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Jan 2023 19:06:37 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BDE3A92
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:06:36 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id h16so25960975wrz.12
        for <git@vger.kernel.org>; Sun, 15 Jan 2023 16:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rXI1bGYPQ45Alos3FcjXnRfoMg3pCfn62OLefjH9Q0w=;
        b=myUrxdMeMN96iBZUtlH7dKJ0BgT9yvcSdgR3aBomGSdK5AYpu8bjFPgCf44UvW4I0A
         1fq+H46c5/XTicweOYlKLO3ZNzPKcs/vYZ4xPHCYACtUtc5OrMp7TWKnAA2rhidU4b0U
         eWCXlzngkl2LvMCTPq1j1sPZGk2GuMKWDKR109WsOmY6G9ZUUao9eCgbLnwrbnxkN4pc
         ra2EgUvDLlMHgZWnYVVcWVB+P1Qd+pcU2F7NkwBjNIYUgAjAhiRWBVpgZQKoqHDTlYrU
         nwYb9vk6iQu5/SdPlw6A5hnWTCmOL/erneUoHVbYbqyGjTDxidqd3gKzTuEB3MlG6nzQ
         uUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rXI1bGYPQ45Alos3FcjXnRfoMg3pCfn62OLefjH9Q0w=;
        b=ffTZ4hnH27OybribUul/rPCBG8r8MqixVJVTBNNDDZg9tLpOR+vSzE10MG1dDc3r8x
         CJfVXRqxFxi+V7WcD+wDAxqDNFvg/v8GpPLaaZhBE9dvk5+BKkPFhPpLQE6rZBZmFJ09
         ks+CQZaZB43RySmILZtqdQ8zLSq8y1CxAo5wZsmIIlmezZgrEN51r4s8FOrfZOx+3JrY
         okErYmdCxGj75GtcD+eYFcZl63Q8QVrLeCkMFzVybS9Jhzg4K0vJHjZ/OrXkE4/4IsWH
         xqDpssPkS7dqI+fTugWyPPJncx3jEd6nK560XkNklN1hi3x/RGZN+x77MlZDSNIdsUia
         fHxw==
X-Gm-Message-State: AFqh2koYlbqypN5iOC2futojvcIlIo59PnXhD6FPj6Vsq2WJBI+vuwcK
        ximsCPMrWWwX48c3WcPfoLY=
X-Google-Smtp-Source: AMrXdXuHU4JCxVR3iQjN+d0HH3ws9RnTzLzSyzoQZx7rnYdPZmwgRS+B6nh2UMInGBYTYpDwHXTbtw==
X-Received: by 2002:a5d:448c:0:b0:2bb:dd87:3488 with SMTP id j12-20020a5d448c000000b002bbdd873488mr23016221wrq.39.1673827594585;
        Sun, 15 Jan 2023 16:06:34 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d4588000000b002bdfb97e029sm2640896wrq.19.2023.01.15.16.06.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 15 Jan 2023 16:06:34 -0800 (PST)
Subject: [PATCH v2 3/3] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Message-ID: <4601f80b-e504-c5a2-6374-7a2609236a27@gmail.com>
Date:   Mon, 16 Jan 2023 01:06:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch, skipping rename_ref() if
the branch to rename is an orphan branch, checking the current HEAD.

But the orphan branch to be renamed can be an orphan branch in a
different working tree than the current one, i.e. not the current HEAD.

Let's make "ishead_reject_rebase_or_bisect_branch()" return a flag
indicating if the returned value refers to an orphan branch, and use it
to extend what we did in cfaff3aac, to all HEADs in the repository.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  |  5 ++---
 t/t3200-branch.sh | 16 ++++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 6bb5f50950..7e6baa291a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -495,7 +495,7 @@ static int ishead_and_reject_rebase_or_bisect_branch(const char *target)
 		struct worktree *wt = worktrees[i];
 
 		if (wt->head_ref && !strcmp(target, wt->head_ref))
-			ret = 1;
+			ret = 1 + (is_null_oid(&wt->head_oid) ? 1 : 0);
 
 		if (!wt->is_detached)
 			continue;
@@ -560,8 +560,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !(ishead > 1) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 5a169b68d6..966583dc7d 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -279,6 +279,22 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -m should work with orphan branches' '
+	test_when_finished git checkout - &&
+	test_when_finished git worktree remove -f wt &&
+	git worktree add wt --detach &&
+
+	# rename orphan in another worktreee
+	git -C wt checkout --orphan orphan-foo-wt &&
+	git branch -m orphan-foo-wt orphan-bar-wt &&
+	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
+
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
