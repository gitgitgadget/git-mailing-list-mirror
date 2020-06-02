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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92F04C433E0
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7359A2072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s70t3d5I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbgFBERj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFBERe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:34 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2876DC061A0E
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:34 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id q11so1906322wrp.3
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ncZlyZBKSWv7UWqfcUEiYlIqu/0Sa8vD0+mW3XH7jvg=;
        b=s70t3d5Ib743A2DEjyIPMMX8opjsBIKOKhuc+hCm9vwC0OsMFf1XD7ACa8vS/xR0pd
         LOMskXmfIlxtV+n1ItDGqexrSfyyEJuBprFApSF94vU2IVa4FFRN3yYQCz3rWxLAdczj
         50DRVby88kfNvGp37aQqvZTjxBzlejM/kPaOYsFRwvJY9AMIfcBFq5Rt5YV44rUuBopH
         Ic3AOitryOS02GGtGkK3P4HfT2dHgnod1P5RQWgquSV8ky9ZRvwOruCx0k9WMcuT+4Aa
         GOeuYWWAEUXwrMABHYldVIUYjsq8c42OH8UVRVBOjijNYTVfMcOztOcX+BZqZOCRNPf7
         CJSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ncZlyZBKSWv7UWqfcUEiYlIqu/0Sa8vD0+mW3XH7jvg=;
        b=eStTLabE42GRY0GI65+1UN4HfpS9bphYT/VH3ExstHrHiTuZQpTSlOrZ0sckbMNEqS
         cDDOWrzkDiEyMcPQlgsh3v6P+9TNhDDGbsWj1gjQrNIrB2FEjZeF6gPSX0q2M6XAxheU
         njfn0TGvi0sBucEA2J8Y/tsqIBD6Rt2Sx30PDYM1w7XesaG5QbFGFWJuv/BwLYOsUjhL
         R4L2ke1OU6p/hCmmTDxnIHrZ5YmrVdA0fA7cylEfy7zP/+dgImc2oWWpYxHjwANq+pqH
         vkMzzb2Ptc8bC6OKrGBhcwiXMQrYpW3d72wXiVajL0u2J79FTiUI2iTvPV4Fq8+JRWv7
         jALg==
X-Gm-Message-State: AOAM530Ty5qj+t88T2vv5z0xaiegl3BfniqyEtcBvPXZiwxad3XsAAfO
        qYZpXCFhFzshApl2i59+b19Cyz0eiOo=
X-Google-Smtp-Source: ABdhPJy5THFLt4czkcS56h2HCGgY1HnaFvMDBrFcO4CaAyNC/o+E8KSqut7dRnVp3ZzD0FsfZuOUyw==
X-Received: by 2002:a5d:4ccc:: with SMTP id c12mr17895894wrt.281.1591071452108;
        Mon, 01 Jun 2020 21:17:32 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 13/13] upload-pack: move pack_objects_hook to upload_pack_data
Date:   Tue,  2 Jun 2020 06:16:57 +0200
Message-Id: <20200602041657.7132-14-chriscool@tuxfamily.org>
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
more thoroughly, let's move the 'pack_objects_hook' static
variable into this struct.

It is used by code common to protocol v0 and protocol v2.

While at it let's also free() it in upload_pack_data_clear().

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 0887410791..30e8c54060 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -53,7 +53,6 @@ static timestamp_t oldest_have;
 static unsigned int allow_unadvertised_object_request;
 static int shallow_nr;
 static struct object_array extra_edge_obj;
-static const char *pack_objects_hook;
 
 /*
  * Please annotate, and if possible group together, fields used only
@@ -88,6 +87,8 @@ struct upload_pack_data {
 
 	struct packet_writer writer;
 
+	const char *pack_objects_hook;
+
 	unsigned stateless_rpc : 1;				/* v0 only */
 	unsigned no_done : 1;					/* v0 only */
 	unsigned daemon_mode : 1;				/* v0 only */
@@ -137,6 +138,8 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
 	list_objects_filter_release(&data->filter_options);
+
+	free((char *)data->pack_objects_hook);
 }
 
 static void reset_timeout(unsigned int timeout)
@@ -181,10 +184,10 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	int i;
 	FILE *pipe_fd;
 
-	if (!pack_objects_hook)
+	if (!pack_data->pack_objects_hook)
 		pack_objects.git_cmd = 1;
 	else {
-		argv_array_push(&pack_objects.args, pack_objects_hook);
+		argv_array_push(&pack_objects.args, pack_data->pack_objects_hook);
 		argv_array_push(&pack_objects.args, "git");
 		pack_objects.use_shell = 1;
 	}
@@ -1153,7 +1156,7 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 	if (current_config_scope() != CONFIG_SCOPE_LOCAL &&
 	current_config_scope() != CONFIG_SCOPE_WORKTREE) {
 		if (!strcmp("uploadpack.packobjectshook", var))
-			return git_config_string(&pack_objects_hook, var, value);
+			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
 	return parse_hide_refs_config(var, value, "uploadpack");
-- 
2.27.0.rc0.26.g636377a2c4

