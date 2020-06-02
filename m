Return-Path: <SRS0=E3tc=7P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77838C433E2
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 525982072F
	for <git@archiver.kernel.org>; Tue,  2 Jun 2020 04:17:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhPMMq9y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFBERW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Jun 2020 00:17:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgFBERU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jun 2020 00:17:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77448C05BD43
        for <git@vger.kernel.org>; Mon,  1 Jun 2020 21:17:19 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id j10so1876673wrw.8
        for <git@vger.kernel.org>; Mon, 01 Jun 2020 21:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zAUxvrmQabyo5XtTJMcze18A6XkrCUCkok/k6x+PkAU=;
        b=NhPMMq9ymQdZcItZWheQxAnxFVhQyH1CqWQd6B94pMof+2fBAEptqKDE+Ud315jxjq
         WCSdgDmC+2GcY8FSkJvbNVJgkhLZ7cd8H/nI+huQ5TbSOtIl7/bbERG01nO1p7dGPelt
         fVlvP+hJCfcaTFSTXMQBnjL/ZBKuDJVmsuQRToxHLBJmV5Y0cabv4KBPCITEIZUDAfDR
         drp7+R3BoxKdxuKwLOynpeW5dLlYr3EQF833WaaZ23+Kc6s7yxHjf6gqWvvDxwh3teuj
         hQBgQ2iSqgnJNJ69HMKRGbmlcw0HaDbwp7W0EKy05scOUfP3dD2WF4flSaxim/L7R6pb
         AfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zAUxvrmQabyo5XtTJMcze18A6XkrCUCkok/k6x+PkAU=;
        b=L2I63CZ3AYCgLonk7H7G8utEfnDy0bqXU/TK8YjQdEm2qGHS9y8x7JBvF3Y3eEUqfC
         lUwdWo0bgAUY91GWCqGi4/KuQK1oCWx/dDFXma/rUH2ozvqsWdH0H3xvtm0q0IBJACl2
         YQFVi874ERI6bQFuy7BOFntlgenmc/M4yhjoBmf60ziXe+AtlCMqNekcDBiRs66ZghSu
         DMe2k4P8zqGqDKpjQMe4ii4SDaic0Q2bax30f/UV2LUbDd7nmtVSpJTLzaN3vZmB4wAG
         zZT3w1jbRMrcSuY0FF+gaEGbikEg9uZmtPVdHntYW1NxSTh0Y9qi3MWniGLO328kE+Io
         IWqg==
X-Gm-Message-State: AOAM5336wSuJ0MFQ4WgqRKnyz8sHA52aBbtbmf6i8amWaMMe3vbdaCqf
        yuVYZ+C7vNyha+rOFmoX3Kg+WxlUBmo=
X-Google-Smtp-Source: ABdhPJwbxQvA93Ipp7vFP+uzhKKUDpNQs2byCHyzr9mgoQ0V0yqSem8qocX+6eHrKcx7u+RDfnr1ag==
X-Received: by 2002:a5d:4a45:: with SMTP id v5mr24403193wrs.223.1591071437861;
        Mon, 01 Jun 2020 21:17:17 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.249])
        by smtp.gmail.com with ESMTPSA id z2sm1717614wrs.87.2020.06.01.21.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 21:17:17 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 01/13] upload-pack: actually use some upload_pack_data bitfields
Date:   Tue,  2 Jun 2020 06:16:45 +0200
Message-Id: <20200602041657.7132-2-chriscool@tuxfamily.org>
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

From: Jeff King <peff@peff.net>

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's actually start using some bitfields of
that struct, which were previously unused.

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

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
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
2.27.0.rc0.26.g636377a2c4

