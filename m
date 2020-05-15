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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEC7C433E1
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A4D02074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uDhIXyka"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728144AbgEOKFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728128AbgEOKFO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:05:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96AD7C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id w7so2776567wre.13
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:05:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eJHTDBVJt/x8TZMShSjXBxMTx4a49GJvjpTL40XCLRU=;
        b=uDhIXykay+tIIo4kLoLXrW8u39sXxL3/rDA4evuDK5gl26Pdag+V8a+dyxbuEegJDW
         REnJACwdLbhqIW0VI7hFhNdAz991X8Qj7EexaSKReXlvvyPQSJmoinU89UTHp2LyhYwH
         G/xw7lBPgUqdw+j+rSTn6OJlA5c7+Sr6+up2ig8nlmSW1pOkQH4id1xy4iwXXH3YmSGd
         +pXrRv9OKPveM+quB5CedrCqEusE8YJNBgS6UFHO0HmU91TTSAI9LoML4mO4GjzntDrN
         3CrwBkH8cmhvhqQPIyPRXN2bFN+1EW54UhqFFyBBNr12F1PZv3TVMW90zBJugH+QwD1s
         l/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eJHTDBVJt/x8TZMShSjXBxMTx4a49GJvjpTL40XCLRU=;
        b=elyMT/CLU+I40NfZv9AtfTbgsXdQnXlvZTKLph/M2dBC0G95OcNZHa7yasD4ay02Ox
         Ahoi3V5z7D3z5KrCoj4FsCc0xCtIXp6iNCmwiDNuEVLqrkhJjWLTnRYcwJWfceDEReYp
         8t1RUZDuUMK4wpHV8ADwixXGZEu9DTaMiihDKVDI5Zs8ux7AvTKpe4SfL5LT5lLdzUuV
         ZYFJlqU0BjMj183Kxbquu97xaYcQrEJT4/W3peuf5a3v5OCFw5oixgQWDBbLeyl8fAGn
         MaMR8fKTWgPQ6ZGa6P+D4heuCC6Dn1ey6+qoU9r/KoPdZ7y31b26FYbc8v+z4EQpO1++
         VHIg==
X-Gm-Message-State: AOAM531baLS9jfoc7K31la4ItZyywaNrCEnL5n6tEBXvbvf7eV9/iZAA
        1Oxx0ShBYhWIHoiZKw8UXDE3T1J55Hg=
X-Google-Smtp-Source: ABdhPJxwDyMepckk+ULd3P1B+8AbTI+IdE+LEwvW9hM1Rxf8+MIzPIIR9tyF24pj3JHyB7C8r4LOpw==
X-Received: by 2002:adf:e752:: with SMTP id c18mr3334166wrn.353.1589537112981;
        Fri, 15 May 2020 03:05:12 -0700 (PDT)
Received: from localhost.localdomain ([193.57.121.171])
        by smtp.gmail.com with ESMTPSA id m3sm2792326wrn.96.2020.05.15.03.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2020 03:05:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 03/13] upload-pack: move 'struct upload_pack_data' around
Date:   Fri, 15 May 2020 12:04:44 +0200
Message-Id: <20200515100454.14486-4-chriscool@tuxfamily.org>
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
more thoroughly, let's move 'struct upload_pack_data' and the
related upload_pack_data_init() and upload_pack_data_clear()
functions towards the beginning of the file, so that this struct
and its related functions can then be used by upload_pack() in a
followup commit.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 upload-pack.c | 112 +++++++++++++++++++++++++-------------------------
 1 file changed, 56 insertions(+), 56 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index e1b10522f7..9aeb3477c9 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -72,6 +72,62 @@ static int allow_ref_in_want;
 
 static int allow_sideband_all;
 
+struct upload_pack_data {
+	struct string_list wanted_refs;
+	struct object_array want_obj;
+	struct object_array have_obj;
+	struct oid_array haves;
+
+	struct object_array shallows;
+	struct string_list deepen_not;
+	int depth;
+	timestamp_t deepen_since;
+	int deepen_rev_list;
+	int deepen_relative;
+
+	struct list_objects_filter_options filter_options;
+
+	struct packet_writer writer;
+
+	unsigned stateless_rpc : 1;
+
+	unsigned use_thin_pack : 1;
+	unsigned use_ofs_delta : 1;
+	unsigned no_progress : 1;
+	unsigned use_include_tag : 1;
+	unsigned done : 1;
+};
+
+static void upload_pack_data_init(struct upload_pack_data *data)
+{
+	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
+	struct object_array want_obj = OBJECT_ARRAY_INIT;
+	struct object_array have_obj = OBJECT_ARRAY_INIT;
+	struct oid_array haves = OID_ARRAY_INIT;
+	struct object_array shallows = OBJECT_ARRAY_INIT;
+	struct string_list deepen_not = STRING_LIST_INIT_DUP;
+
+	memset(data, 0, sizeof(*data));
+	data->wanted_refs = wanted_refs;
+	data->want_obj = want_obj;
+	data->have_obj = have_obj;
+	data->haves = haves;
+	data->shallows = shallows;
+	data->deepen_not = deepen_not;
+	packet_writer_init(&data->writer, 1);
+}
+
+static void upload_pack_data_clear(struct upload_pack_data *data)
+{
+	string_list_clear(&data->wanted_refs, 1);
+	object_array_clear(&data->want_obj);
+	object_array_clear(&data->have_obj);
+	oid_array_clear(&data->haves);
+	object_array_clear(&data->shallows);
+	string_list_clear(&data->deepen_not, 0);
+	list_objects_filter_release(&data->filter_options);
+}
+
 static void reset_timeout(void)
 {
 	alarm(timeout);
@@ -1130,62 +1186,6 @@ void upload_pack(struct upload_pack_options *options)
 	list_objects_filter_release(&filter_options);
 }
 
-struct upload_pack_data {
-	struct string_list wanted_refs;
-	struct object_array want_obj;
-	struct object_array have_obj;
-	struct oid_array haves;
-
-	struct object_array shallows;
-	struct string_list deepen_not;
-	int depth;
-	timestamp_t deepen_since;
-	int deepen_rev_list;
-	int deepen_relative;
-
-	struct list_objects_filter_options filter_options;
-
-	struct packet_writer writer;
-
-	unsigned stateless_rpc : 1;
-
-	unsigned use_thin_pack : 1;
-	unsigned use_ofs_delta : 1;
-	unsigned no_progress : 1;
-	unsigned use_include_tag : 1;
-	unsigned done : 1;
-};
-
-static void upload_pack_data_init(struct upload_pack_data *data)
-{
-	struct string_list wanted_refs = STRING_LIST_INIT_DUP;
-	struct object_array want_obj = OBJECT_ARRAY_INIT;
-	struct object_array have_obj = OBJECT_ARRAY_INIT;
-	struct oid_array haves = OID_ARRAY_INIT;
-	struct object_array shallows = OBJECT_ARRAY_INIT;
-	struct string_list deepen_not = STRING_LIST_INIT_DUP;
-
-	memset(data, 0, sizeof(*data));
-	data->wanted_refs = wanted_refs;
-	data->want_obj = want_obj;
-	data->have_obj = have_obj;
-	data->haves = haves;
-	data->shallows = shallows;
-	data->deepen_not = deepen_not;
-	packet_writer_init(&data->writer, 1);
-}
-
-static void upload_pack_data_clear(struct upload_pack_data *data)
-{
-	string_list_clear(&data->wanted_refs, 1);
-	object_array_clear(&data->want_obj);
-	object_array_clear(&data->have_obj);
-	oid_array_clear(&data->haves);
-	object_array_clear(&data->shallows);
-	string_list_clear(&data->deepen_not, 0);
-	list_objects_filter_release(&data->filter_options);
-}
-
 static int parse_want(struct packet_writer *writer, const char *line,
 		      struct object_array *want_obj)
 {
-- 
2.26.2.638.gb2c16ea67b.dirty

