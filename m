Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C935C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 11:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356253AbiBULVo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 06:21:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356241AbiBULUv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 06:20:51 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCFFAEAF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:00 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i14so26378866wrc.10
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 03:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PnEkkU9Wx6HdLyfYv/KNN6gAbLsvuSzZ8V5DKhxVJIc=;
        b=iTwoWtK3QLj8NGPfT8dTM5RjqTN0rDzKj+C4gXWpgv3RQa3pTLtJLieDeELZC0ehF/
         5WwtiiR4n6rv5lJtGAgKumdYV1Ss26cLVdS8UF9eOFwPMUcF3RYQFntGMG4xPs63JzeH
         m6DqCtHIriaUWgYo4jZdQkNUimmZuKu5eqkTlGNV0lKVmsnrkDZKSxHZyYHKnenM15e1
         +xSkwBfZGolExU4G0tzJKUVTjXWkXu+ql5ukZVATe4FekGQ3ewFjlbhypTBYdozuR6Np
         Bz2WfxOs0v4Y+Vc2tk38DElCVjfYprSFK/zz52bHINWzt9I35sydRqr60R+bNhRZogmS
         dJiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PnEkkU9Wx6HdLyfYv/KNN6gAbLsvuSzZ8V5DKhxVJIc=;
        b=Mf8fQEMEE/9nd+vqNOV83eKjWUnXvjc+k7pmKIJTYcIlF1m3N+BEFgl2yEZoRNkBIn
         TfMlyi7fD76Xd6rmWaKNfa5zh5rMnYFRyT+7dJKH5Nqm8jeiHFrvr5TR9fHWD1ciW6VZ
         5jTRL/Zsvs7BCBZMg/Xa+iVsDtMduuRh/ihD4qzlyyUvOJ6HNuOSUEdWmt4kPEi25Evj
         giruGfzkNL5OkiWliZRu6XCbqwPmcjtuUf/Z68V79bW61C4HfYtbhTfAs1zOtAQQfWHC
         IFUqZw3U6cXAYhIAoxhqeLGL3sWTCbi06W6kwmNFovbN0LLbVGGN96roSWn2RKhWZeop
         FZWg==
X-Gm-Message-State: AOAM5301w64WGCmLTry3cxED7ej67WGHxChi3hCep0+XYFcvMxrToQKG
        FomLtupA0R6FLnliF1DuIEjyGvJpQwY=
X-Google-Smtp-Source: ABdhPJxwZ2ZJ4hogvsDoFYCH8zTbuAKqGqTEl7KVGiF3KosKFpo3LzSIZzLUhrIlZU2mik3RrAaH9g==
X-Received: by 2002:a5d:6d8f:0:b0:1dd:1ced:4050 with SMTP id l15-20020a5d6d8f000000b001dd1ced4050mr15242039wrs.549.1645441859303;
        Mon, 21 Feb 2022 03:10:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c4e8d00b0037bc5ce6042sm9614631wmq.27.2022.02.21.03.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 03:10:58 -0800 (PST)
Message-Id: <58c560d0e19a3fa6dd5de547821c9642089de3fb.1645441854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
References: <pull.1150.git.1645441854.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Feb 2022 11:10:51 +0000
Subject: [PATCH 4/7] rebase --apply: respect GIT_REFLOG_ACTION
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

The reflog messages when finishing a rebase hard code "rebase" rather
than using GIT_REFLOG_ACTION.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 builtin/rebase.c          | 7 ++++---
 t/t3406-rebase-message.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 36863117fba..e50361fc2a9 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -580,10 +580,11 @@ static int move_to_original_branch(struct rebase_options *opts)
 	if (!opts->onto)
 		BUG("move_to_original_branch without onto");
 
-	strbuf_addf(&branch_reflog, "rebase finished: %s onto %s",
+	strbuf_addf(&branch_reflog, "%s finished: %s onto %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT),
 		    opts->head_name, oid_to_hex(&opts->onto->object.oid));
-	strbuf_addf(&head_reflog, "rebase finished: returning to %s",
-		    opts->head_name);
+	strbuf_addf(&head_reflog, "%s finished: returning to %s",
+		    getenv(GIT_REFLOG_ACTION_ENVIRONMENT), opts->head_name);
 	ropts.branch = opts->head_name;
 	ropts.flags = RESET_HEAD_REFS_ONLY;
 	ropts.branch_msg = branch_reflog.buf;
diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
index 8aa6a79acc1..bb2a4949abc 100755
--- a/t/t3406-rebase-message.sh
+++ b/t/t3406-rebase-message.sh
@@ -88,7 +88,7 @@ test_expect_success 'error out early upon -C<n> or --whitespace=<bad>' '
 write_reflog_expect () {
 	if test $mode = --apply
 	then
-		sed 's/.*(finish)/rebase finished/; s/ ([^)]*)//'
+		sed 's/(finish)/finished/; s/ ([^)]*)//'
 	else
 		cat
 	fi >expect
-- 
gitgitgadget

