Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9741EC433E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 719BA2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u8Av7IcR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726182AbgFBERg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFBER2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D8C061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:28 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id l11so1926472wru.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mWw5J4fqSrG7oiTm6Eb21EsDx3GiDF8MtcKQOnxmWYg=;
        b=u8Av7IcR5ce6v09HJjomOq3sPKWUksi7HPjO167FAvmZ3EnoMrR2rgdsBwJkMea3pf
         8uYiuEtSklbd8zf7SnJceP3clYPi/DMU4J5gRCqx5LolB2EuW0a3Wh9CNoTgaKdRDc06
         Kwm2kWJagUZpjxD+IK5nfkp/MrKrr4yrYvUTQtR3tMS7gv1LXz92tVA2wJ6xxGo2F5Vt
         iP8nJN8mel/QtiwA45Q9oQDjLnSNBwhheRIErF0IeKtx49APVuBFJN6/JXTNjmkAyxqg
         VN4COWfmNYiZ/IUnmiftUsvLGQ1ivTJ7rhb9hAgrifVGDhZxQ5hN4PBBsdiyqLoQEBSS
         IaGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mWw5J4fqSrG7oiTm6Eb21EsDx3GiDF8MtcKQOnxmWYg=;
        b=EnlybSz8haRk6l4Ts6Vcdp0a/jVnPL1t8hZq90pvxzYezoiZSnrPOFkgAfroLuCkHi
         uZEqrvG3wXjbkCfg9LFgks36eCdbZUYbA393WQG66Ij/oCwL0PEg2s6hDTrF8D9IHGmi
         4wUk/t0YPPKJSeu9mrE02Z4XcJxwr/N7aAJNMtRdj/erPbo9VReXCADvvPImr8RkNTn+
         dPzMaev4x53WNdARZgrKxbCZOz7RP85p/G3jbDg6P5IXI1zRQ+Xgtj8tjwawcOU50FKX
         Qh/J/i2BxJ+Es7xEBL+IzUQ/RnfmgBzj8J5ILjK0Yi1nmSonbx9D6TZbrawoZseECjww
         m8OA==
X-Gm-Message-State: AOAM5304gS1LVmM8rTyxLbFm+LcIL4Ulz6moL71U9Okvfx1Qn2Qa74BA
        jSnUG1LDuXUVo/1joRTNND9LvQ4rmkQ=
X-Google-Smtp-Source: ABdhPJwFArhxIyhqQ5jz7UNqhJtmf46/0uT0vbCcK7lwzAbAAY3naeRlqvyA5QN8b9S/bvUOJYUZEQ==
X-Received: by 2002:adf:e68a:: with SMTP id r10mr24358172wrm.384.1591071446853;
        Mon, 01 Jun 2020 21:17:26 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:26 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 09/13] upload-pack: move keepalive to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:53 +0200
Message-Id: <20200602041657.7132-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc0.26.gf2851482f5
In-Reply-To: <20200602041657.7132-1-chriscool@tuxfamily.org>
References: <20200527164742.23067-1-chriscool@tuxfamily.org>
 <20200602041657.7132-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'keepalive' static variable
into this struct.

It is used by code common to protocol v0 and protocol v2.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 7b0954794a..2695b52147 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static int keepalive = 5;
 static const char *pack_objects_hook;
 
 static int allow_filter;
@@ -78,6 +77,7 @@ struct upload_pack_data {
 	timestamp_t deepen_since;
 	int deepen_rev_list;
 	int deepen_relative;
+	int keepalive;
 
 	unsigned int timeout;					/* v0 only */
 	enum  {
@@ -125,6 +125,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
 	packet_writer_init(&data->writer, 1);
+
+	data->keepalive = 5;
 }
 
 static void upload_pack_data_clear(struct upload_pack_data *data)
@@ -253,7 +255,7 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 
 	while (1) {
 		struct pollfd pfd[2];
-		int pe, pu, pollsize;
+		int pe, pu, pollsize, polltimeout;
 		int ret;
 
 		reset_timeout(pack_data->timeout);
@@ -277,8 +279,11 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 		if (!pollsize)
 			break;
 
-		ret = poll(pfd, pollsize,
-			keepalive < 0 ? -1 : 1000 * keepalive);
+		polltimeout = pack_data->keepalive < 0
+			? -1
+			: 1000 * pack_data->keepalive;
+
+		ret = poll(pfd, pollsize, polltimeout);
 
 		if (ret < 0) {
 			if (errno != EINTR) {
@@ -1115,6 +1120,8 @@ static int find_symref(const char *refname, const struct object_id *oid,
 
 static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
+	struct upload_pack_data *data = cb_data;
+
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
 		if (git_config_bool(var, value))
 			allow_unadvertised_object_request |= ALLOW_TIP_SHA1;
@@ -1131,9 +1138,9 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		else
 			allow_unadvertised_object_request &= ~ALLOW_ANY_SHA1;
 	} else if (!strcmp("uploadpack.keepalive", var)) {
-		keepalive = git_config_int(var, value);
-		if (!keepalive)
-			keepalive = -1;
+		data->keepalive = git_config_int(var, value);
+		if (!data->keepalive)
+			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
 		allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
-- 
2.27.0.rc0.26.g636377a2c4

