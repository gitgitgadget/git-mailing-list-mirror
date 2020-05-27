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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF76C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C9F02071A
	for <git@archiver.kernel.org>; Wed, 27 May 2020 16:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRukJy0d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgE0QsD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 12:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728384AbgE0QsC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 12:48:02 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA6C03E97D
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:01 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id r15so52315wmh.5
        for <git@vger.kernel.org>; Wed, 27 May 2020 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QyOLRxr5ler/AlEa/fNiQDUJMQ0V1X/3P0+IQemadzI=;
        b=GRukJy0dDzOwy3hSD3uPqT9lx4zT+usN0QnLeFkf/ED6gxWgPXGeUmSxSr5MucRKrv
         JbjezJZtuRnqay+jh1Q3Yn2+73NxKo3tC0bGzhvdCpQG+XQiIHsuZZHsSzyK8hbtOP5F
         Sv8kGd0jEc8mP5xNS10UVcDat16mvgbel8DA1j0TI0MDV76Z31QH+klv3DTf0SZXDybb
         qoQgXfGq2eJI9Inu3zReS+cG/ijIM1XAFVc+h/4B4vOOlxb6CXl3nPvN/OJakXN9rVN+
         Q0fUUe7Nx8KDxXkWLtCLtWyktKxHhjgmMkJAx34EkBe5hXnfCfn/6E9L1A92uVC0/T78
         GOiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QyOLRxr5ler/AlEa/fNiQDUJMQ0V1X/3P0+IQemadzI=;
        b=jQirnhTUzrymsXuRUoPTZFbydKEx3zqEl9iy3MJUjNzzmoTAYOzQ5oECVnnV+dcaK6
         i6oECVdI52NCF2gbQMaJ6e7kZ5G2yMKM5UEJgBbuOJ0q88GacUiQa1IANLnR61hPGT3j
         SLLAtHqT44VgBmuZ0vGsV1AhLCHve4EgjzgL+//iZ2a7ipLJQx/OnLl1K5d5waAodpnC
         POaYbVRRQmuG7bxZw1/SWBOvQrR5juedzJ/bjVKcV+feSnKsc17V7s5RZgGVkCZOw9ou
         4P8S9RAzdaDGN5zLf9W6ZEgIjSXDbBMOuHY+aQNXuZep7B8lft5Ay3AsKT70ZBY/n8OM
         1WXg==
X-Gm-Message-State: AOAM532VssFdVVYEp1h0JIZibE64dFJSS0cTC5FxsrAzYwk/5Q6jk+Pu
        hJZGPPFsZdrmS0Yrf7uzfw6ikTsWURc=
X-Google-Smtp-Source: ABdhPJw9/XjJZ1FVCa48jrRia7RfxiOnez/KzDWvKaEFbahYAn/Z3iJTxaj041QiGmHfFF9stii/9A==
X-Received: by 2002:a1c:f301:: with SMTP id q1mr5018848wmq.109.1590598078633;
        Wed, 27 May 2020 09:47:58 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.40])
        by smtp.gmail.com with ESMTPSA id d17sm2432852wrg.75.2020.05.27.09.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 09:47:58 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/12] upload-pack: actually use some upload_pack_data bitfields
Date:   Wed, 27 May 2020 18:47:31 +0200
Message-Id: <20200527164742.23067-2-chriscool@tuxfamily.org>
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
2.27.0.rc2.38.gc6b4ed14d2.dirty

