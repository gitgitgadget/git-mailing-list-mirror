Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41211C433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:01:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbiKBWB5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbiKBWBx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:01:53 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32AB0F02A
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:01:52 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j15so211481wrq.3
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BFyqAM3oQTFGg6melyvXp4NoiSYsmOxbkbVCMdc4IXA=;
        b=kQVfA88PM0sAHWugZMkR60K+faj1a128z12RpbfJrXP8NTGmKggl0D6T9qXljgO4hm
         yfp8xysdEWYXRJBCZuxgjxGr436HLcjz9ven9Xj2zh+vANSCKbfacNuMAUCmYGw75h1e
         CCJZ5SpU9iFzTy9iMGnXvat9F7mhuqnpKPqGK/HpO5xbarRPfvumMeLnCiA/UnKO8AWT
         v0et+39ZGSUuCmvSAaqE3J63TlqWEBKfQ65BgnS71e/7AjADpGUXl1bt3y46bsj6RyK6
         71CeZjObWsm90h9tzf+zRR+hkfyng70cS0rKbjNwNxkr3RKpgEBZ+HJ098BSce3ePe7S
         rEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BFyqAM3oQTFGg6melyvXp4NoiSYsmOxbkbVCMdc4IXA=;
        b=gI/029n+JY61yxm4VT9CmaP5yAONqgUMcf1eAC8wU8XFTgINdSZ1pb5mRi+JlVokMT
         dsw5REzPjbWSTuvkkuMc62AhpfoWfGkMNsjrHFqfxKeCQiYPtKI1be2gx6C2Ls5ODrnt
         a1PdJ00tJUiRpt70PGZmSZ+fJosxnLnACRZFdxCXADHTU3e7GHklEg9LH/XLGKoK04iU
         tomoohjwWPD3DTuY6Z8OCj5I+7x98LezhSdl3UShR/Gq536Esz62Nv9kotzzNSNDd4Yf
         AJAfg2zWjYX2T8y2cRcBhpXMrqQU4WQ4AoPUY1hg8A3AyJbzsQ5QUBuWlDlkFl2rmGqE
         3fqQ==
X-Gm-Message-State: ACrzQf1y/jc90iI1sNW9nCrClimYwJJ+wiWWrP1KPLO9uLv1SLPpQ18S
        IUFQdi5vM2pkEPckibI9jxlPZSp2Fow=
X-Google-Smtp-Source: AMsMyM4KLTsPYL/orwcsG5JiazlLZqlP421I62x8tCZpdUSeiWbLAXzE8ver9B1zzGZCp2Rs32pbzA==
X-Received: by 2002:adf:f14e:0:b0:236:d073:dad with SMTP id y14-20020adff14e000000b00236d0730dadmr11012080wro.15.1667426510683;
        Wed, 02 Nov 2022 15:01:50 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id y3-20020a05600c17c300b003b4cba4ef71sm3517969wmo.41.2022.11.02.15.01.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:01:50 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, man dog <dogman888888@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] diff.c: use diff_free_queue()
Date:   Wed,  2 Nov 2022 23:01:42 +0100
Message-Id: <20221102220142.574890-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.1.564.g99c012faba
In-Reply-To: <20221102220142.574890-1-szeder.dev@gmail.com>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use diff_free_queue() instead of open-coding it.  This shortens the
code and make it less repetitive.

Note that the second hunk in diff_flush() is interesting, because the
'free_queue' label separates the loop freeing the queue's filepairs
from free()-ing the queue's internal array.  This is somewhat
suspicious, but it was not an issue before: there is only one place
from where we jump to this label with a goto, and that is protected by
an 'if (!q->nr && ...)' condition, i.e. we only skipped the loop
freeing the filepairs when there were no filepairs in the queue to
begin with.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 diff.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index ef94175163..03e6ffb5e4 100644
--- a/diff.c
+++ b/diff.c
@@ -6337,13 +6337,9 @@ static int diff_get_patch_id(struct diff_options *options, struct object_id *oid
 int diff_flush_patch_id(struct diff_options *options, struct object_id *oid, int diff_header_only)
 {
 	struct diff_queue_struct *q = &diff_queued_diff;
-	int i;
 	int result = diff_get_patch_id(options, oid, diff_header_only);
 
-	for (i = 0; i < q->nr; i++)
-		diff_free_filepair(q->queue[i]);
-
-	free(q->queue);
+	diff_free_queue(q);
 	DIFF_QUEUE_CLEAR(q);
 
 	return result;
@@ -6612,10 +6608,8 @@ void diff_flush(struct diff_options *options)
 	if (output_format & DIFF_FORMAT_CALLBACK)
 		options->format_callback(q, options, options->format_callback_data);
 
-	for (i = 0; i < q->nr; i++)
-		diff_free_filepair(q->queue[i]);
 free_queue:
-	free(q->queue);
+	diff_free_queue(q);
 	DIFF_QUEUE_CLEAR(q);
 	diff_free(options);
 
-- 
2.38.1.564.g99c012faba

