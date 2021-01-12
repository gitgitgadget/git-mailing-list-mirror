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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DC5C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9064422D2C
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 08:23:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404811AbhALIW4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 03:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728262AbhALIW4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 03:22:56 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFE3AC061575
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:22:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id w5so1450314wrm.11
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 00:22:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h305WaGyI1sHfqJER3FVAw5XAt78+8sFmTh3lgAgHoU=;
        b=YVKygPH0OxFh/od5vhsfC7ZxaNelsZLZpQ8F1XjejCrodUbyVvfZ4iUiYNZKtry5bV
         1Q52W7FuOxe3gVn8ri3YI4CIp3FVFqxbqZxogb+R7y0OTSnWKacd8ZxBG85Ci53bU4u7
         /iDkdYuvxkv7MOTUq9SnI0AnSjhLkLCSDADY9tM3vMEcULxwMA64HxsdgROQbhFrQJ3O
         ximdKPEoO6CdROKx01f+JZiepoN66xvLriaQHvFAuk2u1LfC4dbEBe8dtKd6DNHIhruq
         Z3l/m1gHF0IXsB4ijPDyUTL8kqsuV7FHuTn9P4codcVVtByesfZAvI3wRs5v/z3Pp5zZ
         RhKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h305WaGyI1sHfqJER3FVAw5XAt78+8sFmTh3lgAgHoU=;
        b=E8Yxmo4AewaOjlSGSDh0BXQCg8CKMC8d7y7pboho8IPqBzipNkt2xdRo2S7EBKF82n
         QSSmK46VgR2EFFGhXH4nMJ1cGDrgaL1wMUHrVYo7KzuH6FOIehp/9BecKfcfjefLeH6S
         ILbiObGAnocLYXyWYizXTGxcIk34oxeCh1gyogo5iju//UhEkf/P0h31ImdfGbA1mw73
         wAWVxI9jZ7nMhNFZdRdsJy1BMI+OjXlatXPKmu7X6SBTEryf8G8ixwFYbudNvmnslrq2
         QopI/LYL/WjiXKw5u1RYV9WauJvHg605RI/Me/TsDf6Xaxnc4Bm1onrH4qmWqDS57HHF
         +nnA==
X-Gm-Message-State: AOAM532UQXxF9canbtVdHfmdQZLbeQsFII6q4sagO2/PLuBtRlpOSdQ7
        ac7fby2TrcENDmJjb+0xoHnGkn3IMhps3g==
X-Google-Smtp-Source: ABdhPJyM0jGHAjJFVKV8EirU1PcfeWvGTUe33GGqnRMrU2ejmk1p2fDNuznHkgSHCSwWA0XPW0f+vg==
X-Received: by 2002:adf:ee90:: with SMTP id b16mr2949909wro.221.1610439734537;
        Tue, 12 Jan 2021 00:22:14 -0800 (PST)
Received: from localhost.localdomain ([193.57.125.79])
        by smtp.gmail.com with ESMTPSA id f9sm3919247wrw.81.2021.01.12.00.22.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 00:22:13 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: [PATCH 1/2] fetch-pack: rename helper to create_promisor_file()
Date:   Tue, 12 Jan 2021 09:21:58 +0100
Message-Id: <20210112082159.2277214-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.30.0.83.g36fd80b35a
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we are going to refactor the code that actually writes
the promisor file into a separate function in a following
commit, let's rename the current write_promisor_file()
function to create_promisor_file().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 fetch-pack.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 876f90c759..c5fa4992a6 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -772,8 +772,8 @@ static int sideband_demux(int in, int out, void *data)
 	return ret;
 }
 
-static void write_promisor_file(const char *keep_name,
-				struct ref **sought, int nr_sought)
+static void create_promisor_file(const char *keep_name,
+				 struct ref **sought, int nr_sought)
 {
 	struct strbuf promisor_name = STRBUF_INIT;
 	int suffix_stripped;
@@ -875,7 +875,7 @@ static int get_pack(struct fetch_pack_args *args,
 
 		if (args->from_promisor)
 			/*
-			 * write_promisor_file() may be called afterwards but
+			 * create_promisor_file() may be called afterwards but
 			 * we still need index-pack to know that this is a
 			 * promisor pack. For example, if transfer.fsckobjects
 			 * is true, index-pack needs to know that .gitmodules
@@ -943,7 +943,7 @@ static int get_pack(struct fetch_pack_args *args,
 	 * obtained .keep filename if necessary
 	 */
 	if (do_keep && pack_lockfiles && pack_lockfiles->nr && args->from_promisor)
-		write_promisor_file(pack_lockfiles->items[0].string, sought, nr_sought);
+		create_promisor_file(pack_lockfiles->items[0].string, sought, nr_sought);
 
 	return 0;
 }
-- 
2.30.0.83.g36fd80b35a

