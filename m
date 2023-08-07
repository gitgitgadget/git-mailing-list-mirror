Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B4AC001DE
	for <git@archiver.kernel.org>; Mon,  7 Aug 2023 20:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjHGUmq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Aug 2023 16:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjHGUml (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2023 16:42:41 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA7AE5F
        for <git@vger.kernel.org>; Mon,  7 Aug 2023 13:42:39 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fe426b86a8so40913085e9.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2023 13:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691440958; x=1692045758;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mfgeGf5ue7gZ6/pijVShw8h7Auz6ChyWTgFB96MzQA=;
        b=faJyn4gmMu0C8HWAhXoXYDUhomsYJMj9znkldvTag7IQp94TD7crwySRoCh5+DTM7u
         1vyvxj0cdGUNIo7ueeExuMBq+hKUqf88+o/84RwKYpLojfHHU4PLVueZ+qS3X06lSK8T
         SmiqusSjIseLI3GowIKXi31pytGqCtnzYyl6PnwGcuNfboQPGFvKW2rjv+Yux85VONdG
         G8cpYqg6CSnfIUKB4LrcKb5EON+Zb7IM8CCVJBLZSizhlApJGF+531eBNqPoTlUk2K8T
         2rJ2P8Xb7oMPxqLjrhdNAIaXRzrsMK+hrOljgQM94SQGPn59fJs9WQVdvLeFHgS9EOUA
         uxbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691440958; x=1692045758;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mfgeGf5ue7gZ6/pijVShw8h7Auz6ChyWTgFB96MzQA=;
        b=by2uMx+3EUrnXP4HsPbUhFaBfSAK/2mcoX+KF26FmV3D/JSV2WQfdGXUag+TF+m7Em
         Ev3Sy9M4S969PMJhmLObk6blHFG5xaZa4pLox0Ptymm/HU3+odA+9kG6edXivAN1Bld8
         Tdc+Fec5zifbswSmM2rAt3RMTKOo8FH6ZJ+2ml6943eyaKRYeyrm0Dch5A1vJPlTv07F
         FAqtOjhBUnytj8i9jDKTxYAxHOp7CHgn+tlA7PbcNhBin6LdfiTeSzR03UBd68OCBqst
         +oUT0HopTOv208cpDRO5NZQTxDRCDmKxjW5pkDsIAlH2affA3lTAIGjSiw0THvpk7yuA
         crkg==
X-Gm-Message-State: AOJu0YzOacp991GGmGkzzffTaPQqrmQq/l/EQ7OPEf25cY2OaJ08sB1O
        FJMwTNH3vHD7Ztom2h3KX9c=
X-Google-Smtp-Source: AGHT+IGIRckVEiTEXLBL3kzzBeEKYOq3Sh72trGfwVv5NMhRhDHbTBjxZQrjf+ZPSs9Bp3o1Xz3SNA==
X-Received: by 2002:adf:dcd0:0:b0:317:51da:83b9 with SMTP id x16-20020adfdcd0000000b0031751da83b9mr7051371wrm.49.1691440957379;
        Mon, 07 Aug 2023 13:42:37 -0700 (PDT)
Received: from [192.168.2.52] (225.red-88-14-55.dynamicip.rima-tde.net. [88.14.55.225])
        by smtp.gmail.com with ESMTPSA id m9-20020adfe0c9000000b003145559a691sm11700969wri.41.2023.08.07.13.42.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 13:42:37 -0700 (PDT)
Subject: [PATCH 1/2] branch: error message deleting a branch in use
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Message-ID: <329ecf0a-46a6-84c8-e96f-f92a398063d9@gmail.com>
Date:   Mon, 7 Aug 2023 22:42:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <7710c002-0832-d8f6-59b8-30119bd5efe6@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's update the error message we show when the user tries to delete a
branch which is being used in another worktree, following the guideline
reasoned in 4970bedef2 (branch: update the message to refuse touching a
branch in-use, 2023-07-21).

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  |  2 +-
 t/t3200-branch.sh | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 08da650516..2ec190b14a 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -261,7 +261,7 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 			const char *path;
 			if ((path = branch_checked_out(name))) {
 				error(_("Cannot delete branch '%s' "
-					"checked out at '%s'"),
+					"used by worktree at '%s'"),
 				      bname.buf, path);
 				ret = 1;
 				continue;
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index daf1666df7..080e4f24a6 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -942,7 +942,19 @@ test_expect_success 'test deleting branch without config' '
 test_expect_success 'deleting currently checked out branch fails' '
 	git worktree add -b my7 my7 &&
 	test_must_fail git -C my7 branch -d my7 &&
-	test_must_fail git branch -d my7 &&
+	test_must_fail git branch -d my7 2>actual &&
+	grep "^error: Cannot delete branch .my7. used by worktree at " actual &&
+	rm -r my7 &&
+	git worktree prune
+'
+
+test_expect_success 'deleting in-use branch fails' '
+	git worktree add my7 &&
+	test_commit -C my7 bt7 &&
+	git -C my7 bisect start HEAD HEAD~2 &&
+	test_must_fail git -C my7 branch -d my7 &&
+	test_must_fail git branch -d my7 2>actual &&
+	grep "^error: Cannot delete branch .my7. used by worktree at " actual &&
 	rm -r my7 &&
 	git worktree prune
 '
-- 
2.42.0.rc0.2.gbb987841e8
