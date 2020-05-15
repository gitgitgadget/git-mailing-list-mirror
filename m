Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 593A7C433E3
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 35D422074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpSAfcwX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728230AbgEOKF1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728050AbgEOKF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:26 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55F4C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:25 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f13so1689884wmc.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6J+bvf2W1Bq5ralxG1MCJLMyYI7YmjMRNa40bnF0DiI=;
        b=DpSAfcwX7odvJSIDReop3IG1ckLI/WMmvF5fvNFluIPXMNR810mI962bqcCxkNSWat
         MSR1cEDlAIwwd8zsKHGwC9dTA/kIh1BWYP9QlsHU48fEDV895iaijysNplKCqOzpKlqf
         6vgteqMCs0JAjx1XWuOqY2GZIss4JIpXvS4KvgAeiYewJFF3Y/Bjp8Xug8EIlXA/O7T6
         6Li/LnGEqFbO7UITZ3Jir2ZEJJTqHowehWevyGpXJOhrWOf/6uHFKjHeK/07+GPXGOsG
         t+IuwvQGYY1Af9TwxvrC9MbJeXpZIco7QY2RdmqXgAY3df/aIUkELRo5PPjgNiUrulom
         TrRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6J+bvf2W1Bq5ralxG1MCJLMyYI7YmjMRNa40bnF0DiI=;
        b=LVpqqn3Zso5IsvKx1xYO54cC9kHAxna0GEN6xS07xRRYZ6OvQi2Z7jP6p7s2HH7ujI
         ASNKCiC3IYeaxPVq9mYOeKJ3dbbkdhu5fQr6X3g7fZsVkasu3d2I66ecU0RPTiLyANHm
         Tv+CtihsWvoSLUxZ++OsiaoFg4k3/hQZl7lrHRGp1qBidRlDePQo0gi8c5LZFcq/TeTU
         uXkZgJJy918UrP+eDjQ9UuArZmfocgxCkFSiU/hqYWZ8VB6DPnRGKjNLEuVPF8A5pPB7
         gnXwnaHJNlkR7ktGGiEbEOcwzUvQrpN3xKpbd9cmsDtpnbATccOM+uszaJjOCljTmPox
         27Pg==
X-Gm-Message-State: AOAM53372np6okUL6U5YaU2Iel4cdozlV7f9Yu62FInDKt15wqqoLify
        qCrvVRDhlRyplIHIaWSwb/HwitdWLB4=
X-Google-Smtp-Source: ABdhPJz8jP+ljFkDD2iPfrtpei4ABLLQxElhLLisdrrX5yaqCP/Dk6zLwwLQIiKLpYkTrBzZ3D68Ng==
X-Received: by 2002:a7b:cf15:: with SMTP id l21mr3188205wmg.172.1589537124012;
        Fri, 15 May 2020 03:05:24 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:23 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 12/13] upload-pack: pass upload_pack_data to create_pack_file()
Date:   Fri, 15 May 2020 12:04:53 +0200
Message-Id: <20200515100454.14486-13-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.639.gb7dde20fdf
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we cleanup 'upload-pack.c' by using 'struct upload_pack_data'
more thoroughly, let's pass that struct to create_pack_file(),
so that this function, and the function it calls, can use all
the fields of the struct.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 4ac40c5b04..93cf4b1fe5 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -161,9 +161,7 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 	return 0;
 }
 
-static void create_pack_file(const struct object_array *have_obj,
-			     const struct object_array *want_obj,
-			     struct list_objects_filter_options *filter_options)
+static void create_pack_file(struct upload_pack_data *pack_data)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	char data[8193], progress[128];
@@ -200,9 +198,9 @@ static void create_pack_file(const struct object_array *have_obj,
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
-	if (filter_options->choice) {
+	if (pack_data->filter_options.choice) {
 		const char *spec =
-			expand_list_objects_filter_spec(filter_options);
+			expand_list_objects_filter_spec(&pack_data->filter_options);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
 			sq_quote_buf(&buf, spec);
@@ -226,13 +224,13 @@ static void create_pack_file(const struct object_array *have_obj,
 	if (shallow_nr)
 		for_each_commit_graft(write_one_shallow, pipe_fd);
 
-	for (i = 0; i < want_obj->nr; i++)
+	for (i = 0; i < pack_data->want_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&want_obj->objects[i].item->oid));
+			oid_to_hex(&pack_data->want_obj.objects[i].item->oid));
 	fprintf(pipe_fd, "--not\n");
-	for (i = 0; i < have_obj->nr; i++)
+	for (i = 0; i < pack_data->have_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
-			oid_to_hex(&have_obj->objects[i].item->oid));
+			oid_to_hex(&pack_data->have_obj.objects[i].item->oid));
 	for (i = 0; i < extra_edge_obj.nr; i++)
 		fprintf(pipe_fd, "%s\n",
 			oid_to_hex(&extra_edge_obj.objects[i].item->oid));
@@ -1179,9 +1177,7 @@ void upload_pack(struct upload_pack_options *options)
 		receive_needs(&data, &reader);
 		if (data.want_obj.nr) {
 			get_common_commits(&data, &reader);
-			create_pack_file(&data.have_obj,
-					 &data.want_obj,
-					 &data.filter_options);
+			create_pack_file(&data);
 		}
 	}
 
@@ -1525,9 +1521,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_shallow_info(&data);
 
 			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&data.have_obj,
-					 &data.want_obj,
-					 &data.filter_options);
+			create_pack_file(&data);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.26.2.638.gb2c16ea67b.dirty

