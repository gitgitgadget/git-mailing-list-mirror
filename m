Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAEAAC433E0
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B7B9E2071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mUsbKXG9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730439AbgE0QsN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgE0QsK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5580C05BD1E
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:09 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u188so85638wmu.1
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCB04ebAsF3S6UDwsj3Vrt/qC1FbhUf2CC5VOfbFsrY=;
        b=mUsbKXG9h2tGwm9y+6C1K4/sQENwtJ9nJx2Oa7oyKCNUm1sm3BjYyB9gJv38lkSRLa
         lVKd00xkVrDgJalv60szWKMbGXjegpoCqqx46duoMKVrYpQNbn5Oa6J93nDfWnnSol3f
         vnynv4Qs/wGWSTLN/rkKMHjnvaQGK29dNDs0fFs5zJwAXw2o9LNqw+VaY1zQ6FGV5LdJ
         ZaTQ2rlTCPXyAHSqaxoYAQIjghtWbvQ+k6uhG/xXoXzCPlzXd4sHzfOrAYzhBRiQb2p9
         f/H4I3im8sNlUGpOu9bpclO65cgqzEJgrJa8LnNhZ25elIBTvBUAAsuvEjJGVg3+xcG3
         yyrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCB04ebAsF3S6UDwsj3Vrt/qC1FbhUf2CC5VOfbFsrY=;
        b=XU8JzDD32kQCeW0DChq0YkNRv8MgVu0gtZygLBrjToib2Ptc8n/QHsJKYClGSo3sUO
         xPkbYOX3pWQ7PLs+N5BZBO61x5OnZwIInPhZyTfRf6O74+DZFQcQtKbZdVbzdWTgBHi0
         HUT+FrkpMrt1nHC1j2SlYpC9gqW+vvQsJfL2cG2ebkFRo7dlGwbaA1/g6jAuxATQI0sc
         phq/F0FPisHzsOFmsGiJLpeqib8GQmtHPntfxo8jU+DqbEWIvtbm5HrA3rIcmKygp7Kd
         BcKpknaVp2YGCSEUnP4xSDF/iMVg1EnctCGoKCq0wEvlpgkA7yoyMDBwesepTaiR1aBA
         7ejw==
X-Gm-Message-State: AOAM532baXpVc9CiSonW7qlFEFjvKSUr0WZ+Ii7+eigzMI9f5qJyEbvl
        4P2MdgaIqwiFCrxR9fQIFQHDnBHSh7c=
X-Google-Smtp-Source: ABdhPJx/59MPfhj0WR+Cggo1RhR5JaUnHqQ9QmkBF4fYHL/Hf/bjdtjbc1kdK1o8oLR3gg7fSSznIQ==
X-Received: by 2002:a1c:9c85:: with SMTP id f127mr5243513wme.79.1590598088267;
        Wed, 27 May 2020 09:48:08 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:48:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 09/12] upload-pack: move allow_filter to upload_pack_data
Date:   Wed, 27 May 2020 18:47:39 +0200
Message-Id: <20200527164742.23067-10-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.27.0.rc2.38.gc6b4ed14d2.dirty
In-Reply-To: <20200527164742.23067-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
 <20200527164742.23067-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's move the 'allow_filter' static variable
into this struct.

It is only used by protocol v0 code since protocol v2 assumes
certain baseline capabilities, but rolling it into
upload_pack_data and just letting v2 code ignore it as it does
now is more coherent and cleaner.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e00631a703..10bafeb8b6 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -55,7 +55,6 @@ static int shallow_nr;
 static struct object_array extra_edge_obj;
 static const char *pack_objects_hook;
 
-static int allow_filter;
 static int allow_ref_in_want;
 
 static int allow_sideband_all;
@@ -99,6 +98,8 @@ struct upload_pack_data {
 	unsigned done : 1;
 	unsigned no_done : 1;
 	unsigned filter_capability_requested : 1;
+
+	unsigned allow_filter : 1;
 };
 
 static void upload_pack_data_init(struct upload_pack_data *data)
@@ -979,7 +980,8 @@ static void receive_needs(struct upload_pack_data *data,
 			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
 			data->use_include_tag = 1;
-		if (allow_filter && parse_feature_request(features, "filter"))
+		if (data->allow_filter &&
+		    parse_feature_request(features, "filter"))
 			data->filter_capability_requested = 1;
 
 		o = parse_object(the_repository, &oid_buf);
@@ -1085,7 +1087,7 @@ static int send_ref(const char *refname, const struct object_id *oid,
 				     " allow-reachable-sha1-in-want" : "",
 			     data->stateless_rpc ? " no-done" : "",
 			     symref_info.buf,
-			     allow_filter ? " filter" : "",
+			     data->allow_filter ? " filter" : "",
 			     git_user_agent_sanitized());
 		strbuf_release(&symref_info);
 	} else {
@@ -1137,7 +1139,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 		if (!data->keepalive)
 			data->keepalive = -1;
 	} else if (!strcmp("uploadpack.allowfilter", var)) {
-		allow_filter = git_config_bool(var, value);
+		data->allow_filter = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowrefinwant", var)) {
 		allow_ref_in_want = git_config_bool(var, value);
 	} else if (!strcmp("uploadpack.allowsidebandall", var)) {
@@ -1329,7 +1331,7 @@ static void process_args(struct packet_reader *request,
 			continue;
 		}
 
-		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
+		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
 			continue;
-- 
2.27.0.rc2.38.gc6b4ed14d2.dirty

