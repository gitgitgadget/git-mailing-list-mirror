Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CABBFC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 955102083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 09:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dE3Pu50X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGJ6s (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:58:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725900AbgEGJ6s (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:58:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF982C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:58:46 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e26so5757487wmk.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFgiItdkRGR+bLU1kTmbkwwm3A0VonoN2+sO48uMASk=;
        b=dE3Pu50XEkRyD2KXfcZJpBWIdn03OqkGXphzu7tjpZec03RRs2LNAQytu/WkoICF5B
         5ZIbQ5lsZo2ZZPBYYu5rgYYL1vk+Sl/7clvhQ7H+CBOSirjLKCR8qxNajIoOEH5LK2L6
         W317PfFr8zyNeg8aWg4A20dlcdmDrWUgEHNYRJaOMDsQBE0YwRKpJnjj/OuR+WE5dnmw
         +RnuNKVqzo27zK55UNdpXPwDeX6TaECKQsVDZlAdyDJK5rgJ1oXfkFl0uAji2PlyYNDh
         wGrq+LeoArLjNHg6UYW7x18aDIvHaASHylxujoGFYq3Y0ayWO+jUWRStBM3S8FJf+CrP
         V70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FFgiItdkRGR+bLU1kTmbkwwm3A0VonoN2+sO48uMASk=;
        b=khAD425o9DicCl1h6GwhkEnGw+86dXuaFUm4vkOezIGAhnk+LeNccp+9mb+RcCbXta
         0M7EVpdAuHyUWJWYvkX/anXaGQXXakybEggsLHzZzO8wmxDI5Sho2qMNwpIgFVz/X9Kk
         faifVCRm76MgyQzbH61kTKjCcRGrBSHtSSoyuvngFKoKPaOset/pUSab+noUdmkPsh2i
         ff3UN0c3+T0Tdt+vmVsg1JoeFmGGD1t/+gXfvUzPf5mr64q8YHD/QXkzNiBYaAtpqsCu
         6CZ1GZkAsxT+nlH3jY4WuoQ3k5vU+LR2AxavwKW+L//fBrMSXNWUS7jdWxz5YIJkDWRC
         vR8w==
X-Gm-Message-State: AGi0PuYgFsi9MsaSDk7VhCCGJGWWwmBuKidiOcS3Nxy9ierrXirY6n98
        MY2k5dnBarJESSHyERhakDqOmK9UL/4=
X-Google-Smtp-Source: APiQypL08Qaxuxus1OlBsuSxtqU5gW8+Iw5ZaT1xkhFXyTMsZMvKMPWorXfQzDhNoamnNlZbNymamA==
X-Received: by 2002:a1c:790e:: with SMTP id l14mr9167679wme.174.1588845525007;
        Thu, 07 May 2020 02:58:45 -0700 (PDT)
Received: from localhost.localdomain ([185.228.230.114])
        by smtp.gmail.com with ESMTPSA id w6sm7559952wrt.39.2020.05.07.02.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:58:43 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH] upload-pack: fix filter options scope
Date:   Thu,  7 May 2020 11:58:29 +0200
Message-Id: <20200507095829.16894-1-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.26.2.562.ga2ab1ba363
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The upload_pack_v2() function is sometimes called twice in the same
process while 'struct list_objects_filter_options filter_options' was
declared as static at the beginning of 'upload-pack.c'.

This made the check in list_objects_filter_die_if_populated(), which
is called by process_args(), fail the second time upload_pack_v2() is
called, as filter_options had already been populated the first time.

To fix that, filter_options is not static any more, but instead it's
now owned by upload_pack_v2() and upload_pack().

This fixes the first of the 2 bugs documented by d0badf8797
(partial-clone: demonstrate bugs in partial fetch, 2020-02-21).

Helped-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
The issue was originally discussed in:

https://lore.kernel.org/git/dbc1bdcae16f8b9941add514264b0fe04cda48c0.1582129312.git.gitgitgadget@gmail.com/

I am not sure why upload_pack_v2() is called twice. Also it seems
that another similar issue might not be fixed by this. So this patch
is RFC for now. 

 t/t5616-partial-clone.sh |  2 +-
 upload-pack.c            | 40 ++++++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 15 deletions(-)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 88002b24af..b73c38c29a 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -389,7 +389,7 @@ test_expect_success 'fetch lazy-fetches only to resolve deltas, protocol v2' '
 # repository did not have tags during clone, but has tags
 # in the fetch.
 
-test_expect_failure 'verify fetch succeeds when asking for new tags' '
+test_expect_success 'verify fetch succeeds when asking for new tags' '
 	git clone --filter=blob:none "file://$(pwd)/srv.bare" tag-test &&
 	for i in I J K
 	do
diff --git a/upload-pack.c b/upload-pack.c
index 902d0ad5e1..4e22e46294 100644
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
@@ -1250,7 +1257,8 @@ static int parse_have(const char *line, struct oid_array *haves)
 
 static void process_args(struct packet_reader *request,
 			 struct upload_pack_data *data,
-			 struct object_array *want_obj)
+			 struct object_array *want_obj,
+			 struct list_objects_filter_options *filter_options)
 {
 	while (packet_reader_read(request) == PACKET_READ_NORMAL) {
 		const char *arg = request->line;
@@ -1306,8 +1314,8 @@ static void process_args(struct packet_reader *request,
 		}
 
 		if (allow_filter && skip_prefix(arg, "filter ", &p)) {
-			list_objects_filter_die_if_populated(&filter_options);
-			parse_list_objects_filter(&filter_options, p);
+			list_objects_filter_die_if_populated(filter_options);
+			parse_list_objects_filter(filter_options, p);
 			continue;
 		}
 
@@ -1470,6 +1478,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	struct upload_pack_data data;
 	struct object_array have_obj = OBJECT_ARRAY_INIT;
 	struct object_array want_obj = OBJECT_ARRAY_INIT;
+	struct list_objects_filter_options filter_options;
 
 	clear_object_flags(ALL_FLAGS);
 
@@ -1478,10 +1487,12 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	upload_pack_data_init(&data);
 	use_sideband = LARGE_PACKET_MAX;
 
+	memset(&filter_options, 0, sizeof(filter_options));
+
 	while (state != FETCH_DONE) {
 		switch (state) {
 		case FETCH_PROCESS_ARGS:
-			process_args(request, &data, &want_obj);
+			process_args(request, &data, &want_obj, &filter_options);
 
 			if (!want_obj.nr) {
 				/*
@@ -1514,7 +1525,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 			send_shallow_info(&data, &want_obj);
 
 			packet_writer_write(&data.writer, "packfile\n");
-			create_pack_file(&have_obj, &want_obj);
+			create_pack_file(&have_obj, &want_obj, &filter_options);
 			state = FETCH_DONE;
 			break;
 		case FETCH_DONE:
@@ -1525,6 +1536,7 @@ int upload_pack_v2(struct repository *r, struct argv_array *keys,
 	upload_pack_data_clear(&data);
 	object_array_clear(&have_obj);
 	object_array_clear(&want_obj);
+	list_objects_filter_release(&filter_options);
 	return 0;
 }
 
-- 
2.26.2.562.ga2ab1ba363

