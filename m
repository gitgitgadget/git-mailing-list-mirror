Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BF5051F576
	for <e@80x24.org>; Thu,  1 Mar 2018 09:12:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966793AbeCAJMJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Mar 2018 04:12:09 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:37971 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966682AbeCAJL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Mar 2018 04:11:59 -0500
Received: by mail-pf0-f194.google.com with SMTP id d26so2190475pfn.5
        for <git@vger.kernel.org>; Thu, 01 Mar 2018 01:11:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HuC9h7BtvrRAL8FlNpswed7GvszKtzaso9EJo9tMWFQ=;
        b=QwpowZmw02SDRyRGuMXfyIAkK8v6uiK43H1SZdn1K4bneClS3wMEa7NKmqYmX6HopJ
         842HSpA7u/u/4rlj+INQzAszFEgNXFgK5dEj/a72vHX848evlmR6hmFYft3aic+SeW+z
         GZbcZYHE07xb3ZzCJFL3nSQ1vDYcPdhPu7VzW4qo/vrAVyyqfyyCahIiqB+W7bIuKYRJ
         egTrd99oR3Wt+EKgXzA7M9xguMo6lRv3ikMzmKd0p/HKCOknDWk7vwilM7dw3o/ZjEyk
         6uwIxcikPuZxo921o1gj9btgrEMyFle3gSbwnGvAb39ofk+jJKmf0C5NTvL83VmXfpyA
         3WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HuC9h7BtvrRAL8FlNpswed7GvszKtzaso9EJo9tMWFQ=;
        b=jU4glEfafwT/+iYVJKHpqCvoLsjlgOnA4yHMLPyUwolMtNt8X8FU2pnJ//RHliMeW8
         +zrnavP57VCVbW2/7/CNDQyeV7GASZ/YcCvapZjeOHGfe+riRXPbCxzAtfWfl7f4ikjV
         hCpBw36IUfoDaTxy/gmVxlz7fesh3lDOSW3GeOp/ScrWvNCaHHlH6vsioyTu+w8EwOgQ
         z9W99JAY5IGSN/9On5X+evwR5dZL1660B9ChphVTPVtCiGuZCgFuiGFqeH09w2zcWHWb
         s90cO2AZ0VYeBr10j7g4ckiuF+q7SzKSJjhBWQhdbDgSrRnDDLHqhoaaHbXCK/DSXs5E
         4Grw==
X-Gm-Message-State: APf1xPDclcVrEGfMb6VYX/OqgBZOP55eRIl8zXkiKmWQbCxXqhNdXyNl
        Nbd+9PU+6IvfE+6hDsCx+jGgaA==
X-Google-Smtp-Source: AG47ELuAqJXFHsM4Ec09HLYAVP99C+EgIayxK1x0oem+tcIArUj9UkblAlLiYOODtOnltIyk0vSatA==
X-Received: by 10.98.189.8 with SMTP id a8mr1220816pff.125.1519895518986;
        Thu, 01 Mar 2018 01:11:58 -0800 (PST)
Received: from ash ([171.232.93.137])
        by smtp.gmail.com with ESMTPSA id j25sm6763375pgn.92.2018.03.01.01.11.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Mar 2018 01:11:58 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 01 Mar 2018 16:11:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Eric Wong <e@80x24.org>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/11] pack-objects: reorder 'hash' to pack struct object_entry
Date:   Thu,  1 Mar 2018 16:10:51 +0700
Message-Id: <20180301091052.32267-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.1.435.g8f24da2e1a
In-Reply-To: <20180301091052.32267-1-pclouds@gmail.com>
References: <20180228092722.GA25627@ash>
 <20180301091052.32267-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 pack-objects.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/pack-objects.h b/pack-objects.h
index f339f0411a..52087b32e5 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -33,12 +33,10 @@ struct object_entry {
 	uint32_t delta_sibling_idx; /* other deltified objects who
 				     * uses the same base as me
 				     */
-	/* XXX 4 bytes hole, try to pack */
-
+	uint32_t hash;			/* name hint hash */
 	void *delta_data;	/* cached delta (uncompressed) */
 	unsigned long delta_size;	/* delta data size (uncompressed) */
 	unsigned long z_delta_size;	/* delta data size (compressed) */
-	uint32_t hash;			/* name hint hash */
 	unsigned char in_pack_header_size; /* note: spare bits available! */
 	unsigned in_pack_idx:OE_IN_PACK_BITS;	/* already in pack */
 	unsigned type:TYPE_BITS;
@@ -57,7 +55,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 104, padding: 4 */
+	/* size: 96 */
 };
 
 struct packing_data {
-- 
2.16.1.435.g8f24da2e1a

