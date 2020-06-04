Return-Path: <SRS0=8h89=7R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A06C433DF
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B28206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUvpsvzk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730335AbgFDRzW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730315AbgFDRzT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:19 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3DAC08C5C3
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:18 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x6so7053785wrm.13
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqsr4g6A1cagzaI+GdVD3EDUOvQWnlnDKkH3jzVKflk=;
        b=lUvpsvzkBczUZ3FRANv2cUMTKAGGrYUhaeHj3H2By0DjBryq2rDYopU/bCLsEsQQvq
         jbuscqUwbjD10yZ0RCp7kIWhFunbFZsXQ3MXzq9DC3O+88A1RggKvqkR5aejxodHY0PA
         idxzYRz+j/d6R5fY6r/terhmH3Uiqovby3ZB7YZCnestHmngvmY/YNoQfxLTVJ6VI1oS
         VsaEXxR+NrCCREDFnElSHDb41AncN/WVRCkAjXA4h9qP541MuBprAQJzd28reCViVQ2U
         Ih4Ji1YR1NiBsfOty6b5jhFoV4rzUIwLw6PpmHwQxSbd6uNuj0L1dPBQ7h2JyW1EASRs
         GA8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqsr4g6A1cagzaI+GdVD3EDUOvQWnlnDKkH3jzVKflk=;
        b=ttjKk76cS2KJ1wp/P2NIb9fqpSneEn4UMRCPj413/PO/19Su/h25Oj9StTZJ67/Tdn
         a8z78HOc3Orva9rSF3QsMktLIVj0j2wWN6ll4laHGC6oDRHtqLP0Q25Hn0oqidnJEVRq
         vUPJefMFQfcjkTXzRvOFF+TzXQMe+kbmOEk6+HX+OY0zhsz4K1sgODGqgj3UpHmt8g5Y
         jpbWKYz0EYHt0b6LqLZHJnuonchQJ93SwvTHMbXAF5WFz0UMwsNi5y+XF1+uTkKV1p4Y
         Xm8dNJdzG7ivTH+1jjDfjvd4ukKhNS0gJMMClol9XLseOUe0k5vq+cRvF2rXlvBEAySk
         h5Jg==
X-Gm-Message-State: AOAM533SJb25bYnEuNrHrr1MEoLisk+JCKVct9iRotVs9WUc45KUep+9
        cZ/qQjzOYXuGBd961xPkLjMp1Hycgs8=
X-Google-Smtp-Source: ABdhPJx7+3Y7lskEymK0IyOXot1egxAIh267Hr2J55bJHttmHloGKP6K/GkhH/LMpMrVwWFkzmM/cQ==
X-Received: by 2002:a5d:6944:: with SMTP id r4mr5412568wrw.169.1591293317276;
        Thu, 04 Jun 2020 10:55:17 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:16 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 08/13] upload-pack: pass upload_pack_data to upload_pack_config()
Date:   Thu,  4 Jun 2020 19:54:45 +0200
Message-Id: <20200604175450.17385-9-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200604175450.17385-1-chriscool@tuxfamily.org>
References: <20200602041657.7132-1-chriscool@tuxfamily.org>
 <20200604175450.17385-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Couder <christian.couder@gmail.com>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to upload_pack_config(),
so that this function can use all the fields of the struct.

This will be used in followup commits to move static variables
that are set in upload_pack_config() into 'upload_pack_data'.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e7b8140e55..b846aa4728 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1113,7 +1113,7 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int upload_pack_config(const char *var, const char *value, void *unused)
+static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
@@ -1158,10 +1158,10 @@ void upload_pack(struct upload_pack_options *options)
 	struct packet_reader reader;
 	struct upload_pack_data data;
 
-	git_config(upload_pack_config, NULL);
-
 	upload_pack_data_init(&data);
 
+	git_config(upload_pack_config, &data);
+
 	data.stateless_rpc = options->stateless_rpc;
 	data.daemon_mode = options->daemon_mode;
 	data.timeout = options->timeout;
@@ -1491,11 +1491,11 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 
 	clear_object_flags(ALL_FLAGS);
 
-	git_config(upload_pack_config, NULL);
-
 	upload_pack_data_init(&data);
 	data.use_sideband = LARGE_PACKET_MAX;
 
+	git_config(upload_pack_config, &data);
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_PROCESS_ARGS:
-- 
2.27.0.rc0.26.gf2851482f5

