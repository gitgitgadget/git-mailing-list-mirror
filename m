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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4EE4C433E2
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AD7E20709
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lVvyS9nD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728133AbgEOKFO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728127AbgEOKFN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14560C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id f13so1689195wmc.5
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ubsdCUOVUBnqz6Tl9GCvT1w2qtiEbSyP7W0au0MvThk=;
        b=lVvyS9nDsDmAyJZCeJKt9PhU0pwQ4JvVWoqzYYceolxrnMEoGn/ETLHFGasov6qpfe
         jSKmWlylf1icNustQ2FvAK140dTywlpgDV0rD5tPjQNh0lHsFs3gr8QbasqxZHEAT2by
         dQl3h15M/nr7yXMRLI0GD8Oo1lC5P5LTq1mbHCBf4SNEBs6hk7zaJj5rEP5TKa3xFd93
         4h2yJJPrxJq/DxO7B0jhyswU7ekhqpLheYEc2yYl/NfSEXP5NI72HBO3Z/k7A71STFVH
         R2y7vdlurTbJRsEMN9/JN7u3ipSmXY+YwX3nidICvMJOcnhhqeOwEWMj0Y+17gquolKl
         37Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ubsdCUOVUBnqz6Tl9GCvT1w2qtiEbSyP7W0au0MvThk=;
        b=WPDC6O+v9umfqiZTLWI+9Dp7+27oE8XbaBBlGfELhwxqsNLunMCHIsGXaD/elfMQO4
         DI+qFSH3sasjY7qW306wIIuy8OYPauCqeLQBVExldhh0XdN/tHghIRcRFC6b8nCy57Xr
         kveEZTKm7E0QJHMLhUsLw7mLzBDcpFn1rCB8e6PgqtTOOvlbRHzbzF/9JIM6W7Pj92Tt
         +zSHYpp3m5wp7ecGM3IjkIVKd/pm1IU0uMg8s9Y2wvxPFkHoT/R+KMxFXeNu3n5T7CLS
         rXPKFWZAag4SwEFT2VmnFG8ldPwQlNTpKXtOdQwIPZ+pnDbWH7c0ALzpF05Z5hc1PITL
         62DA==
X-Gm-Message-State: AOAM533BzZHTw+nLs+uQxfEzM0Du2d0CSNQkvASFZBxUc3EowDT1kVNx
        tmfgtz6ZygyiY5enSiuw02RnqDzbxX0=
X-Google-Smtp-Source: ABdhPJzNfaWjSdslc6FZH+gVbfCbYZEn16r+iWatdoGm79zDT+OxNFzOsx8Vgfo3kvxLtcM+tI6DjA==
X-Received: by 2002:a05:600c:297:: with SMTP id 23mr3373764wmk.12.1589537111305;
        Fri, 15 May 2020 03:05:11 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:10 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 02/13] upload-pack: move {want,have}_obj to upload_pack_data
Date:   Fri, 15 May 2020 12:04:43 +0200
Message-Id: <20200515100454.14486-3-chriscool@tuxfamily.org>
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
more thoroughly, let's move the want_obj and have_obj object
arrays into 'struct upload_pack_data'.

These object arrays are used by both upload_pack() and
upload_pack_v2(), for example when these functions call
create_pack_file(). We are going to use
'struct upload_pack_data' in upload_pack() in a followup
commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 48 +++++++++++++++++++++++++-----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 9aaf886828..e1b10522f7 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -1132,6 +1132,8 @@ void upload_pack(struct upload_pack_options *options)
 
 struct upload_pack_data {
 	struct string_list wanted_refs;
+	struct object_array want_obj;
+	struct object_array have_obj;
 	struct oid_array haves;
 
 	struct object_array shallows;
@@ -1157,12 +1159,16 @@ struct upload_pack_data {
 static void upload_pack_data_init(struct upload_pack_data *data)
 {
 	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
+	struct object_array want_obj = OBJECT_ARRAY_INIT;
+	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct oid_array haves = OID_ARRAY_INIT;
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->wanted_refs = wanted_refs;
+	data->want_obj = want_obj;
+	data->have_obj = have_obj;
 	data->haves = haves;
 	data->shallows = shallows;
 	data->deepen_not = deepen_not;
@@ -1172,6 +1178,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 static void upload_pack_data_clear(struct upload_pack_data *data)
 {
 	string_list_clear(&data->wanted_refs, 1);
+	object_array_clear(&data->want_obj);
+	object_array_clear(&data->have_obj);
 	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
@@ -1256,19 +1264,18 @@ static int parse_have(const char *line, struct oid_array *haves)
 }
 
 static void process_args(struct packet_reader *request,
-			 struct upload_pack_data *data,
-			 struct object_array *want_obj)
+			 struct upload_pack_data *data)
 {
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
 		const char *p;
 
 		/* process want */
-		if (parse_want(&data->writer, arg, want_obj))
+		if (parse_want(&data->writer, arg, &data->want_obj))
 			continue;
 		if (allow_ref_in_want &&
 		    parse_want_ref(&data->writer, arg, &data->wanted_refs,
-				   want_obj))
+				   &data->want_obj))
 			continue;
 		/* process have line */
 		if (parse_have(arg, &data->haves))
@@ -1399,17 +1406,16 @@ static int send_acks(struct packet_writer *writer, struct oid_array *acks,
 	return 0;
 }
 
-static int process_haves_and_send_acks(struct upload_pack_data *data,
-				       struct object_array *have_obj,
-				       struct object_array *want_obj)
+static int process_haves_and_send_acks(struct upload_pack_data *data)
 {
 	struct oid_array common = OID_ARRAY_INIT;
 	int ret = 0;
 
-	process_haves(&data->haves, &common, have_obj);
+	process_haves(&data->haves, &common, &data->have_obj);
 	if (data->done) {
 		ret = 1;
-	} else if (send_acks(&data->writer, &common, have_obj, want_obj)) {
+	} else if (send_acks(&data->writer, &common,
+			     &data->have_obj, &data->want_obj)) {
 		packet_writer_delim(&data->writer);
 		ret = 1;
 	} else {
@@ -1441,8 +1447,7 @@ static void send_wanted_ref_info(struct upload_pack_data *data)
 	packet_writer_delim(&data->writer);
 }
 
-static void send_shallow_info(struct upload_pack_data *data,
-			      struct object_array *want_obj)
+static void send_shallow_info(struct upload_pack_data *data)
 {
 	/* No shallow info needs to be sent */
 	if (!data->depth && !data->deepen_rev_list && !data->shallows.nr &&
@@ -1455,10 +1460,10 @@ static void send_shallow_info(struct upload_pack_data *data,
 			       data->deepen_rev_list,
 			       data->deepen_since, &data->deepen_not,
 			       data->deepen_relative,
-			       &data->shallows, want_obj) &&
+			       &data->shallows, &data->want_obj) &&
 	    is_repository_shallow(the_repository))
 		deepen(&data->writer, INFINITE_DEPTH, data->deepen_relative,
-		       &data->shallows, want_obj);
+		       &data->shallows, &data->want_obj);
 
 	packet_delim(1);
 }
@@ -1475,8 +1480,6 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 {
 	enum fetch_state state = FETCH_PROCESS_ARGS;
 	struct upload_pack_data data;
-	struct object_array have_obj = OBJECT_ARRAY_INIT;
-	struct object_array want_obj = OBJECT_ARRAY_INIT;
 
 	clear_object_flags(ALL_FLAGS);
 
@@ -1488,9 +1491,9 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_PROCESS_ARGS:
-			process_args(request, &data, &want_obj);
+			process_args(request, &data);
 
-			if (!want_obj.nr) {
+			if (!data.want_obj.nr) {
 				/*
 				 * Request didn't contain any 'want' lines,
 				 * guess they didn't want anything.
@@ -1510,18 +1513,19 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			}
 			break;
 		case FETCH_SEND_ACKS:
-			if (process_haves_and_send_acks(&data, &have_obj,
-							&want_obj))
+			if (process_haves_and_send_acks(&data))
 				state = FETCH_SEND_PACK;
 			else
 				state = FETCH_DONE;
 			break;
 		case FETCH_SEND_PACK:
 			send_wanted_ref_info(&data);
-			send_shallow_info(&data, &want_obj);
+			send_shallow_info(&data);
 
 			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj, &data.filter_options);
+			create_pack_file(&data.have_obj,
+					 &data.want_obj,
+					 &data.filter_options);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
@@ -1530,8 +1534,6 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	}
 
 	upload_pack_data_clear(&data);
-	object_array_clear(&have_obj);
-	object_array_clear(&want_obj);
 	return 0;
 }
 
-- 
2.26.2.638.gb2c16ea67b.dirty

