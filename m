Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 124E11FAE2
	for <e@80x24.org>; Thu,  8 Mar 2018 11:43:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965836AbeCHLnc (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Mar 2018 06:43:32 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42857 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965506AbeCHLnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Mar 2018 06:43:31 -0500
Received: by mail-pg0-f65.google.com with SMTP id y8so2107113pgr.9
        for <git@vger.kernel.org>; Thu, 08 Mar 2018 03:43:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P9gQ4/iGzdpLoSRmX08F59F8kaKBhX1eIjNWkXKyZdY=;
        b=k5KkiF7eB4BaMqXVdVhyD+c5c5o3soneqhaRYF5lh9wOEkXsQcP4KcrxGqPZDYwIoZ
         HHwFuBHBxO3MKh4E66PEi6XkfTuRVQhCDVLDTVZa/ecXbG89laOqCxn7ZAHHCF8zjrB2
         yWPM54jvkZQ0nYXFFaqVjUUC1qcKOQemEZvYiXD0JdEqdbJ1i1clGt6Xky2NNNBt6iOe
         SM+GhjSxlWoUN42ORcBBOS8CJhiYhcclAlkm77wQBB6ARHMyDE6bQTv429+30JwqworV
         1CTTFx1R4eisjQlMSNYorhVYVhOFAdKUPnqoCg1iMKoseM0QNOZwgVClCUGxKBnvYK5H
         vg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P9gQ4/iGzdpLoSRmX08F59F8kaKBhX1eIjNWkXKyZdY=;
        b=hyUzGIq6QMgkfwQQlPh1Sy5nXOIK54jpJS6BUnnXkJFlaEJ+wE5ivH/OjzYGdseX4E
         2Qn/aRUARZwbpEdR2ruZOLBb746WuNsrEDhiQj+OKK3IhHvmIswi3EVh/pWfKetHLIHW
         Bczsk/dKd5vMxtyOG725YFy3UWc+WKES8qkh3dXitjVAYPEhvG4S7D31KsrG3f2gBDsn
         l3amGKxPzDVcNaDBtkQDoI5gI62r4vqH8RRWoUk35vA4xVuRHinotkHHJLKkeqFj/iYc
         RnjCtw92gLcyAZgYImjdOZf6c5MtMc0Bu2M3R9GQQd2OHQo8I2cGj/qu/mTLrHZ0foMj
         zU3A==
X-Gm-Message-State: APf1xPDNIbRU5yE5AFLJGhDLpHM9LKMYzUcId8wBXYOfdEldGVsQbKmC
        B2k7J0nX5DtYm41QITMWsT4=
X-Google-Smtp-Source: AG47ELsRzb6+919kSetulbkuuCm01SJ4VqOqCvQOM7ZUlATorWPL/9SDthycnfkjRABeZrnqCcyXmw==
X-Received: by 10.98.110.71 with SMTP id j68mr25822818pfc.93.1520509411038;
        Thu, 08 Mar 2018 03:43:31 -0800 (PST)
Received: from ash ([27.78.177.129])
        by smtp.gmail.com with ESMTPSA id q6sm32564339pga.37.2018.03.08.03.43.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Mar 2018 03:43:30 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Thu, 08 Mar 2018 18:43:26 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     avarab@gmail.com, e@80x24.org, git@vger.kernel.org,
        gitster@pobox.com, peff@peff.net
Subject: [PATCH/RFC v3 09/12] pack-objects: reorder 'hash' to pack struct object_entry
Date:   Thu,  8 Mar 2018 18:42:29 +0700
Message-Id: <20180308114232.10508-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.16.2.873.g32ff258c87
In-Reply-To: <20180308114232.10508-1-pclouds@gmail.com>
References: <20180303024706.31465-1-pclouds@gmail.com>
 <20180308114232.10508-1-pclouds@gmail.com>
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
index 1c0ad4c9ef..3c15cf7b23 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -77,12 +77,10 @@ struct object_entry {
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
@@ -101,7 +99,7 @@ struct object_entry {
 
 	unsigned depth:OE_DEPTH_BITS;
 
-	/* size: 104, padding: 4, bit_padding: 18 bits */
+	/* size: 96, bit_padding: 18 bits */
 };
 
 struct packing_data {
-- 
2.16.2.873.g32ff258c87

