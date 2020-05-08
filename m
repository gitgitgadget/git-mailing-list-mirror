Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43AD2C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:09:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C5192173E
	for <git@archiver.kernel.org>; Fri,  8 May 2020 18:09:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXb7XoOE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726950AbgEHSJw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 14:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726756AbgEHSJv (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 8 May 2020 14:09:51 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8665C061A0C
        for <git@vger.kernel.org>; Fri,  8 May 2020 11:09:49 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id u16so11556760wmc.5
        for <git@vger.kernel.org>; Fri, 08 May 2020 11:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t+NlEytZH45LlCvkYF80JiqF/aIjwoeWYGq3WEFyGcU=;
        b=OXb7XoOE9yj3JENA52qY/vWIX3mxTwm0+qMMQQR88oAh/FkHMgowDp6ope2IM7N2OL
         ThzTVczZ45z5JgxQMeA0LBxePi9cPuiHoqCLU8uyukJvPjYhrGMGXCOJ8pXrd+xz6+mi
         Qmn7Pjnuu0MUZ2N3Te4Up1CJ+oQt0llkR8Jn4JEx4BKaP2uASi2RwMo6NRSoi18wofVq
         oTbokr9rJ9CbDqY1i3tS2xB/0RZc0Lb/gHALVVBe5ZIVQMtoBt90o8BWMd/s7fhRdbzR
         2WFVgFnxIr8Q26JsSde6TiiTeztRdVmm53nm721ErkqwWy5/91SgDls2me3aEcthI2le
         UKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t+NlEytZH45LlCvkYF80JiqF/aIjwoeWYGq3WEFyGcU=;
        b=B0AuYxX+7DbMPxd8lFt54fYjnM5WHfZ8MhN80ZcDn9BLyMAlqtJkqMAoyMA8mt5k+V
         mEnn9SvXArwn6AkRWU3CsKYJD7+A+hzhnl02XSV9L2QBNbcde3hsXK+LyPxRxP8r0tIW
         TqmeFZZLu5Gm57053ELshZVDqiD24XQ/CK5ELgcOIH/YD0pO+Zc/7s6mlKIGuwi9i0I2
         oM9AGT9l65fxc9gd/vfGjS6oDpawySpMrTO3sbmPexBABUHvwdfMcUpDqhP0zJMDzJ3G
         KD1KTQvafK+UziJrT1dck13escE1BgBInpoO8mh81a3NL+dAmis7pO8TLXajFA1wGIEF
         WjGw==
X-Gm-Message-State: AGi0PuZ46LfFi/ewpX77tqJKZsfoFXwbBMv0w5hVqQQaNTpI1dQEGtgy
        hbWUO9BMOs4Nly7mimvvAkizFHxpGzA=
X-Google-Smtp-Source: APiQypJTCF3MXg9mcZK4z/3HzMhUKlpDxU6LN5mwvTHZAgyvtQ+4efZmYY4CdnzK7aQN4JlpnrGfhg==
X-Received: by 2002:a7b:cb86:: with SMTP id m6mr16253506wmi.64.1588961388016;
        Fri, 08 May 2020 11:09:48 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.36])
        by smtp.gmail.com with ESMTPSA id o18sm4045097wrp.23.2020.05.08.11.09.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2020 11:09:47 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3] upload-pack: clear filter_options for each v2 fetch command
Date:   Fri,  8 May 2020 20:09:35 +0200
Message-Id: <20200508180935.23142-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.562.g0c5c0b446d.dirty
In-Reply-To: <20200508080115.15616-1-chriscool@tuxfamily.org>
References: <20200508080115.15616-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of the request/response model of protocol v2, the
upload_pack_v2() function is sometimes called twice in the same
process, while 'struct list_objects_filter_options filter_options'
was declared as static at the beginning of 'upload-pack.c'.

This made the check in list_objects_filter_die_if_populated(), which
is called by process_args(), fail the second time upload_pack_v2() is
called, as filter_options had already been populated the first time.

To fix that, filter_options is not static any more. It's now owned
directly by upload_pack(). It's now also part of 'struct
upload_pack_data', so that it's owned indirectly by upload_pack_v2().

In the long term, the goal is to also have upload_pack() use
'struct upload_pack_data', so adding filter_options to this struct
makes more sense than to have it owned directly by upload_pack_v2().

This fixes the first of the 2 bugs documented by d0badf8797
(partial-clone: demonstrate bugs in partial fetch, 2020-02-21).

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Helped-by: Jeff King <peff@peff.net>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The only change compared to V2 is an improved commit title, thanks
to Peff and Junio.

 t/t5616-partial-clone.sh |  7 +++----
 upload-pack.c            | 34 ++++++++++++++++++++++------------
 2 files changed, 25 insertions(+), 16 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 88002b24af..8a27452a51 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -384,12 +384,11 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 	grep "want $(cat hash)" trace
 '
 
-# The following two tests must be in this order, or else
-# the first will not fail. It is important that the srv.bare
-# repository did not have tags during clone, but has tags
+# The following two tests must be in this order. It is important that
+# the srv.bare repository did not have tags during clone, but has tags
 # in the fetch.
 
-test_expect_failure 'verify fetch succeeds when asking for new tags' '
+test_expect_success 'verify fetch succeeds when asking for new tags' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
 	for i in I J K
 	do
diff --git a/upload-pack.c b/upload-pack.c
index 902d0ad5e1..4d4dd7cd41 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -68,7 +68,6 @@ static const char *pack_objects_hook;
 static int filter_capability_requested;
 static int allow_filter;
 static int allow_ref_in_want;
-static struct list_objects_filter_options filter_options;
 
 static int allow_sideband_all;
 
@@ -103,7 +102,8 @@ static int write_one_shallow(const struct commit_graft *graft, void *cb_data)
 }
 
 static void create_pack_file(const struct object_array *have_obj,
-			     const struct object_array *want_obj)
+			     const struct object_array *want_obj,
+			     struct list_objects_filter_options *filter_options)
 {
 	struct child_process pack_objects = CHILD_PROCESS_INIT;
 	char data[8193], progress[128];
@@ -140,9 +140,9 @@ static void create_pack_file(const struct object_array *have_obj,
 		argv_array_push(&pack_objects.args, "--delta-base-offset");
 	if (use_include_tag)
 		argv_array_push(&pack_objects.args, "--include-tag");
-	if (filter_options.choice) {
+	if (filter_options->choice) {
 		const char *spec =
-			expand_list_objects_filter_spec(&filter_options);
+			expand_list_objects_filter_spec(filter_options);
 		if (pack_objects.use_shell) {
 			struct strbuf buf = STRBUF_INIT;
 			sq_quote_buf(&buf, spec);
@@ -848,7 +848,9 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
-static void receive_needs(struct packet_reader *reader, struct object_array *want_obj)
+static void receive_needs(struct packet_reader *reader,
+			  struct object_array *want_obj,
+			  struct list_objects_filter_options *filter_options)
 {
 	struct object_array shallows = OBJECT_ARRAY_INIT;
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
@@ -883,8 +885,8 @@ static void receive_needs(struct packet_reader *reader, struct object_array *wan
 		if (skip_prefix(reader->line, "filter ", &arg)) {
 			if (!filter_capability_requested)
 				die("git upload-pack: filtering capability not negotiated");
-			list_objects_filter_die_if_populated(&filter_options);
-			parse_list_objects_filter(&filter_options, arg);
+			list_objects_filter_die_if_populated(filter_options);
+			parse_list_objects_filter(filter_options, arg);
 			continue;
 		}
 
@@ -1087,11 +1089,14 @@ void upload_pack(struct upload_pack_options *options)
 	struct string_list symref = STRING_LIST_INIT_DUP;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
 	struct packet_reader reader;
+	struct list_objects_filter_options filter_options;
 
 	stateless_rpc = options->stateless_rpc;
 	timeout = options->timeout;
 	daemon_mode = options->daemon_mode;
 
+	memset(&filter_options, 0, sizeof(filter_options));
+
 	git_config(upload_pack_config, NULL);
 
 	head_ref_namespaced(find_symref, &symref);
@@ -1114,12 +1119,14 @@ void upload_pack(struct upload_pack_options *options)
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
 
-	receive_needs(&reader, &want_obj);
+	receive_needs(&reader, &want_obj, &filter_options);
 	if (want_obj.nr) {
 		struct object_array have_obj = OBJECT_ARRAY_INIT;
 		get_common_commits(&reader, &have_obj, &want_obj);
-		create_pack_file(&have_obj, &want_obj);
+		create_pack_file(&have_obj, &want_obj, &filter_options);
 	}
+
+	list_objects_filter_release(&filter_options);
 }
 
 struct upload_pack_data {
@@ -1134,6 +1141,8 @@ struct upload_pack_data {
 	int deepen_rev_list;
 	int deepen_relative;
 
+	struct list_objects_filter_options filter_options;
+
 	struct packet_writer writer;
 
 	unsigned stateless_rpc : 1;
@@ -1169,6 +1178,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	oid_array_clear(&data->haves);
 	object_array_clear(&data->shallows);
 	string_list_clear(&data->deepen_not, 0);
+	list_objects_filter_release(&data->filter_options);
 }
 
 static int parse_want(struct packet_writer *writer, const char *line,
@@ -1306,8 +1316,8 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
-			list_objects_filter_die_if_populated(&filter_options);
-			parse_list_objects_filter(&filter_options, p);
+			list_objects_filter_die_if_populated(&data->filter_options);
+			parse_list_objects_filter(&data->filter_options, p);
 			continue;
 		}
 
@@ -1514,7 +1524,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_shallow_info(&data, &want_obj);
 
 			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj);
+			create_pack_file(&have_obj, &want_obj, &data.filter_options);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
-- 
2.26.2.562.g0c5c0b446d.dirty

