Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFA1C433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:08:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7979061139
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:08:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345886AbhIHBJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239456AbhIHBJP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:09:15 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF4AEC061575
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:08:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id n14-20020a05600c3b8e00b002f8bd2f8ab6so260139wms.5
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7B9yckRlPJrugyN1EhI/tEULU1+CP3quKyttdiTb5dc=;
        b=lOnfI/AdCb4V2csSfD9LzGEBPq/GAB+h3mY1odfGtiG3P4yyQXzz14FI1QDeO2HeXL
         g2Dwz2n5c7nTv2wJ8Nl4jbsp6RhNGfYW2FoGRfAJ4eysAk4sAV9hhkrjvGEh5bR9jpRS
         cZC2Pgz+D3Fdwp24vz9MNxvco5SUE6XzwSCvJqgdQngLbs3jSnYUHEAd8BMD2P8M9mb1
         NkqT4j77VlgdwTE8kHWxTNVhi/xMBDBOd/HTxkIivjgD5P2eg0qMhlHBiIKNF72z6pP2
         J9AkOjl6DWibhrjzWAH2B77EDgC/whQZPm85aDEUCEIrEebVfPPj2cMS6B/lco5c/5EU
         UjMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7B9yckRlPJrugyN1EhI/tEULU1+CP3quKyttdiTb5dc=;
        b=qIKM6R9lI/xnDvmE+A4qOR9+oeJIPu8mXd69e7xOsttki5m4kWYCXfpC+2dWkFS5cr
         adRYQlu+oOO8D1IArBMXiWnqhtMfx+WI9bVAk+SGRG539lCo94N1NazacHnFhszcID1R
         CX5cd7Qf9WjeHP3DwfysCwNY/JLY2xbTQtIBczeFS9szRwd1scZESbrz06+oqKG6KhiK
         srbVgTvntpxdo8Lqa39SYKvH+BPaIX/tagfyBYAHB2xeFYOMl7yTTnjWTJvhGbpvrlJ+
         bU7MkQmkdfkaor8eMmSUozTXJPZdK3eh/Thgj5k3rnkJnGh91R2+yR0kA0FMfQuFajxV
         YWag==
X-Gm-Message-State: AOAM532cupMXukYmysXLW+j22F7HmTrCIZSs+eIaZxQ49mwUKjllmFYU
        HAX05APGNIf8mZxM9/LJ0/sPK3uKJn49yQ==
X-Google-Smtp-Source: ABdhPJwV/MkfAW234RT+S9trDgEfZjsPvAsovZqDY5CZgTxmTsnablAPfpqjBl6GdIKnxkb9Dyo/yA==
X-Received: by 2002:a05:600c:4e93:: with SMTP id f19mr886538wmq.185.1631063286856;
        Tue, 07 Sep 2021 18:08:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 17sm503596wmj.20.2021.09.07.18.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:08:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] pack-write: skip *.rev work when not writing *.rev
Date:   Wed,  8 Sep 2021 03:08:03 +0200
Message-Id: <patch-1.1-366ba928bd-20210908T010743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.819.gea1b153a43c
In-Reply-To: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
References: <9f40019eb3d3315cb03440e6237bced4feb6cf67.1617116623.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a performance regression introduced in a587b5a786 (pack-write.c:
extract 'write_rev_file_order', 2021-03-30) and stop needlessly
allocating the "pack_order" array and sorting it with
"pack_order_cmp()", only to throw that work away when we discover that
we're not writing *.rev files after all.

This redundant work was not present in the original version of this
code added in 8ef50d9958 (pack-write.c: prepare to write 'pack-*.rev'
files, 2021-01-25). There we'd call write_rev_file() from
e.g. finish_tmp_packfile(), but we'd "return NULL" early in
write_rev_file() if not doing a "WRITE_REV" or "WRITE_REV_VERIFY".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 pack-write.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/pack-write.c b/pack-write.c
index f1fc3ecafa..1883848e7c 100644
--- a/pack-write.c
+++ b/pack-write.c
@@ -224,6 +224,9 @@ const char *write_rev_file(const char *rev_name,
 	uint32_t i;
 	const char *ret;
 
+	if (!(flags & WRITE_REV) && !(flags & WRITE_REV_VERIFY))
+		return NULL;
+
 	ALLOC_ARRAY(pack_order, nr_objects);
 	for (i = 0; i < nr_objects; i++)
 		pack_order[i] = i;
-- 
2.33.0.819.gea1b153a43c

