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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2048C433E1
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6222206DC
	for <git@archiver.kernel.org>; Thu,  4 Jun 2020 17:55:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="glo/4SQl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730283AbgFDRzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Jun 2020 13:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbgFDRzK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jun 2020 13:55:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23023C08C5C0
        for <git@vger.kernel.org>; Thu,  4 Jun 2020 10:55:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id l10so7083373wrr.10
        for <git@vger.kernel.org>; Thu, 04 Jun 2020 10:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkci+K7jA9f4jV84RMhgAxIpDQch1t3DWTwGW4wAQ8s=;
        b=glo/4SQla2ZimQ1p/H5tL+9HaWiiD8DGDZ6n369DFq49QIKo+a5IGSRztMRFP7v5II
         nsi1t2chBqIzzGHB6oE8K57rVTToTYycKZDtXUXb4c8qW38W+pLESrxHtiZrHjUFaNnV
         YKuXgm2JNMdOitaQKBld3ABmsQJjwxL2gQppBUnvtTx/DGkF3jvBDdgWQHwK2RMAtjoL
         E4DeXBSu+rbMeuLA87ftVaeM+VGzK4ahIDEY+jSLamTCT0b1s/7GCE7+02OfvsFiOmuD
         99M0DAyFR4aoaivRETl6SjgYiJt/mbBgi0V0dkbMgRX1XaRYeoLTJTZvtCw2GzBRyYvr
         bPOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkci+K7jA9f4jV84RMhgAxIpDQch1t3DWTwGW4wAQ8s=;
        b=BjBqfRo1i/z+lU4+KcSP+BWU1xpPs61zr3ZScJOaz0R1j6IICPJCqhfQTAYH4/4tWp
         TyZ5wPsacHVRT0pXKsB52iSEGXuJmRGzB5R826OHo70nziZuXtUkcm3ddwmEURXoo/5n
         EAWMcy0xH0/MBJRg7qqk31U/k4UjAKboQAsAyWAz4RItHCSWaFi/aErcWD18SZ73vgOY
         nDDYhY9HHf6sXURYN0jjIS+3c8gaEb3ptjxfXYSPT5urU6cIXyf569HE70Kr8Fbf1TfV
         dIMD9pFf3VwCCkrsmhsk2qDt/hcMUurmYr8LdIzRihRyO6S0Buc7tONBv+353hehW/Zv
         33Nw==
X-Gm-Message-State: AOAM532Ti28OlpV6a/fMEzCErkQ2az1o5T8KBdC4EcF+0914R6CMXhCC
        yhjvEPRycle6evQ/yWO7br4vUsaDvyA=
X-Google-Smtp-Source: ABdhPJyJSKXGblIPg9sdX04LOR7Q12O90huJlYiOhiSaz4IyfAMxdxcLqLyltoTxi15ach1mc8iMkQ==
X-Received: by 2002:adf:9ccf:: with SMTP id h15mr5606610wre.275.1591293308314;
        Thu, 04 Jun 2020 10:55:08 -0700 (PDT)
Received: from localhost.localdomain ([185.228.231.251])
        by smtp.gmail.com with ESMTPSA id s7sm9173540wrr.60.2020.06.04.10.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 10:55:07 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 01/13] upload-pack: actually use some upload_pack_data bitfields
Date:   Thu,  4 Jun 2020 19:54:38 +0200
Message-Id: <20200604175450.17385-2-chriscool@tuxfamily.org>
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

From: Jeff King <peff@peff.net>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's actually start using some bitfields of
that struct. These bitfields were introduced in 3145ea957d
("upload-pack: introduce fetch server command", 2018-03-15), but
were never used.

We could instead have just removed the following bitfields
from the struct:

unsigned use_thin_pack : 1;
unsigned use_ofs_delta : 1;
unsigned no_progress : 1;
unsigned use_include_tag : 1;

but using them makes it possible to remove a number of static
variables with the same name and purpose from 'upload-pack.c'.

This is a behavior change, as we accidentally used to let values
in those bitfields propagate from one v2 "fetch" command to
another for ssh/git/file connections (but not for http). That's
fixing a bug, but one nobody is likely to see, because it would
imply the client sending different capabilities for each request.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
Acked-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 401c9e6c4b..2fa645834a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -46,8 +46,7 @@ static timestamp_t oldest_have;
 
 static int multi_ack;
 static int no_done;
-static int use_thin_pack, use_ofs_delta, use_include_tag;
-static int no_progress, daemon_mode;
+static int daemon_mode;
 /* Allow specifying sha1 if it is a ref tip. */
 #define ALLOW_TIP_SHA1	01
 /* Allow request of a sha1 if it is reachable from a ref (possibly hidden ref). */
@@ -186,17 +185,17 @@ static void create_pack_file(struct upload_pack_data *pack_data)
 	}
 	argv_array_push(&pack_objects.args, "pack-objects");
 	argv_array_push(&pack_objects.args, "--revs");
-	if (use_thin_pack)
+	if (pack_data->use_thin_pack)
 		argv_array_push(&pack_objects.args, "--thin");
 
 	argv_array_push(&pack_objects.args, "--stdout");
 	if (shallow_nr)
 		argv_array_push(&pack_objects.args, "--shallow");
-	if (!no_progress)
+	if (!pack_data->no_progress)
 		argv_array_push(&pack_objects.args, "--progress");
-	if (use_ofs_delta)
+	if (pack_data->use_ofs_delta)
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
-	if (use_include_tag)
+	if (pack_data->use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
 	if (pack_data->filter_options.choice) {
 		const char *spec =
@@ -955,17 +954,17 @@ static void receive_needs(struct upload_pack_data *data,
 		if (parse_feature_request(features, "no-done"))
 			no_done = 1;
 		if (parse_feature_request(features, "thin-pack"))
-			use_thin_pack = 1;
+			data->use_thin_pack = 1;
 		if (parse_feature_request(features, "ofs-delta"))
-			use_ofs_delta = 1;
+			data->use_ofs_delta = 1;
 		if (parse_feature_request(features, "side-band-64k"))
 			use_sideband = LARGE_PACKET_MAX;
 		else if (parse_feature_request(features, "side-band"))
 			use_sideband = DEFAULT_PACKET_MAX;
 		if (parse_feature_request(features, "no-progress"))
-			no_progress = 1;
+			data->no_progress = 1;
 		if (parse_feature_request(features, "include-tag"))
-			use_include_tag = 1;
+			data->use_include_tag = 1;
 		if (allow_filter && parse_feature_request(features, "filter"))
 			filter_capability_requested = 1;
 
@@ -997,7 +996,7 @@ static void receive_needs(struct upload_pack_data *data,
 		check_non_tip(data);
 
 	if (!use_sideband && daemon_mode)
-		no_progress = 1;
+		data->no_progress = 1;
 
 	if (data->depth == 0 && !data->deepen_rev_list && data->shallows.nr == 0)
 		return;
@@ -1279,19 +1278,19 @@ static void process_args(struct packet_reader *request,
 
 		/* process args like thin-pack */
 		if (!strcmp(arg, "thin-pack")) {
-			use_thin_pack = 1;
+			data->use_thin_pack = 1;
 			continue;
 		}
 		if (!strcmp(arg, "ofs-delta")) {
-			use_ofs_delta = 1;
+			data->use_ofs_delta = 1;
 			continue;
 		}
 		if (!strcmp(arg, "no-progress")) {
-			no_progress = 1;
+			data->no_progress = 1;
 			continue;
 		}
 		if (!strcmp(arg, "include-tag")) {
-			use_include_tag = 1;
+			data->use_include_tag = 1;
 			continue;
 		}
 		if (!strcmp(arg, "done")) {
-- 
2.27.0.rc0.26.gf2851482f5

