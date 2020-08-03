Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAF41C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1318F22B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xUoot0Gt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgHCSAO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:00:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgHCSAN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:00:13 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F9C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:00:13 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id g26so36008107qka.3
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+rqJWSzjO6AwAzEo8mDVubZovA8EKMN9Owj/xcxOO+8=;
        b=xUoot0GtxoCrKKzLkIOq9yFfp7sKBcCwd//4tjF2XoR1+/LsSHLmeKZ+2gzOwAjELm
         7pXuTzWegKGQvcu/WZV19MJ8rPM3fQMZVLIHtKnnrpFqpJGJFJTY5he7L1AtOPCvkf87
         rDx5CxR13J+FY5mphKGRBof8S0zQFvYO5MADJuVMNkZ/1zjQiZSMuk6ln7cuz3Es0q+L
         1Zmw46W3c+Jl+xzi32mRGnt1kRkybuzkkLStBtxRW3nauoU1hNJyQ9B2dzdORjI1MmxZ
         khkM+K08BHDiLeps/SQyqnWiUeHUTJRrTAfqhl1a7NQ71+gPNdzeRZ0T2ZwjDAM1jNPl
         M47Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+rqJWSzjO6AwAzEo8mDVubZovA8EKMN9Owj/xcxOO+8=;
        b=cjqFwgG0xjQj7hiqWPFFeHjlic15ZWhJYMuL2UArDd3Cs06z0HBhHfpyZ0zh3W3aXA
         EZWEbWcOI3A+1N4/+jjjB+IWqStBTZa64D0KVE0x7/FMoViuN3xHbVf1hx63dMkODoOa
         Wq33YGNhf6WjZNYumq0LFiZix5HNk4ryJeUlCNdJWyNlJ+WfGklA8x7kogfm2ucGf3FG
         vCmYEtveZ53NKUbsNnMJ9ZdHuWg3X9y3tZR5ssAqX39aFvZOkJNyU0KW77f3Ng7m7WCk
         v3vh/pg2uyQm0fRqkhN6bOy/3SqOtkovXANNqEU10zH/R9A97eVCg59Se4ppMoGfwzoo
         svmQ==
X-Gm-Message-State: AOAM53242O+M8KiJ/dESkHpfFkCXl5Idt6eBbMOUuewu8j6v+QxjyoBv
        nx7a68GnXdrRKxLAY+VdZ2xz5Q2a9a0GzA==
X-Google-Smtp-Source: ABdhPJxdbfO/5s+78OCXuBI0r8m7Mp3sTbdy+BSSz1QFI6UzqHHwCuyZBM0Agu/oIFt8wGmX9bucVA==
X-Received: by 2002:a37:6594:: with SMTP id z142mr16972762qkb.10.1596477611968;
        Mon, 03 Aug 2020 11:00:11 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 3sm21155590qkm.117.2020.08.03.11.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:00:11 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:00:10 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v4 2/3] upload-pack.c: allow banning certain object filter(s)
Message-ID: <b34f4eaed98817b38cffea7ff44c8111429790ee.1596476929.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596476928.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596476928.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Git clients may ask the server for a partial set of objects, where the
set of objects being requested is refined by one or more object filters.
Server administrators can configure 'git upload-pack' to allow or ban
these filters by setting the 'uploadpack.allowFilter' variable to
'true' or 'false', respectively.

However, administrators using bitmaps may wish to allow certain kinds of
object filters, but ban others. Specifically, they may wish to allow
object filters that can be optimized by the use of bitmaps, while
rejecting other object filters which aren't and represent a perceived
performance degradation (as well as an increased load factor on the
server).

Allow configuring 'git upload-pack' to support object filters on a
case-by-case basis by introducing two new configuration variables:

  - 'uploadpackfilter.allow'
  - 'uploadpackfilter.<kind>.allow'

where '<kind>' may be one of 'blobNone', 'blobLimit', 'tree', and so on.

Setting the second configuration variable for any valid value of
'<kind>' explicitly allows or disallows restricting that kind of object
filter.

If a client requests the object filter <kind> and the respective
configuration value is not set, 'git upload-pack' will default to the
value of 'uploadpackfilter.allow', which itself defaults to 'true' to
maintain backwards compatibility. Note that this differs from
'uploadpack.allowfilter', which controls whether or not the 'filter'
capability is advertised.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt | 12 ++++
 t/t5616-partial-clone.sh            | 24 ++++++++
 upload-pack.c                       | 86 +++++++++++++++++++++++++++++
 3 files changed, 122 insertions(+)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index ed1c835695..fffe8ac648 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -57,6 +57,18 @@ uploadpack.allowFilter::
 	If this option is set, `upload-pack` will support partial
 	clone and partial fetch object filtering.
 
+uploadpackfilter.allow::
+	Provides a default value for unspecified object filters (see: the
+	below configuration variable).
+	Defaults to `true`.
+
+uploadpackfilter.<filter>.allow::
+	Explicitly allow or ban the object filter corresponding to
+	`<filter>`, where `<filter>` may be one of: `blob:none`,
+	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
+	combined filters, both `combine` and all of the nested filter
+	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
+
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 37de0afb02..aa68782587 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -235,6 +235,30 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
 	test_cmp unique_types.expected unique_types.actual
 '
 
+test_expect_success 'upload-pack fails banned object filters' '
+	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	grep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned combine object filters' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_config -C srv.bare uploadpackfilter.combine.allow true &&
+	test_config -C srv.bare uploadpackfilter.tree.allow true &&
+	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
+		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
+	grep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned object filters with fallback' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	grep "filter '\''blob:none'\'' not supported" err
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 8673741070..2098af8156 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -88,6 +88,7 @@ struct upload_pack_data {
 	enum allow_uor allow_uor;
 
 	struct list_objects_filter_options filter_options;
+	struct string_list allowed_filters;
 
 	struct packet_writer writer;
 
@@ -103,6 +104,7 @@ struct upload_pack_data {
 	unsigned no_progress : 1;
 	unsigned use_include_tag : 1;
 	unsigned allow_filter : 1;
+	unsigned allow_filter_fallback : 1;
 
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
@@ -120,6 +122,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	struct string_list deepen_not = STRING_LIST_INIT_DUP;
 	struct string_list uri_protocols = STRING_LIST_INIT_DUP;
 	struct object_array extra_edge_obj = OBJECT_ARRAY_INIT;
+	struct string_list allowed_filters = STRING_LIST_INIT_DUP;
 
 	memset(data, 0, sizeof(*data));
 	data->symref = symref;
@@ -131,6 +134,8 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->deepen_not = deepen_not;
 	data->uri_protocols = uri_protocols;
 	data->extra_edge_obj = extra_edge_obj;
+	data->allowed_filters = allowed_filters;
+	data->allow_filter_fallback = 1;
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
@@ -147,6 +152,7 @@ static void upload_pack_data_clear(struct upload_pack_data *data)
 	string_list_clear(&data->deepen_not, 0);
 	object_array_clear(&data->extra_edge_obj);
 	list_objects_filter_release(&data->filter_options);
+	string_list_clear(&data->allowed_filters, 1);
 
 	free((char *)data->pack_objects_hook);
 }
@@ -984,6 +990,56 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
+NORETURN __attribute__((format(printf,2,3)))
+static void send_err_and_die(struct upload_pack_data *data,
+			     const char *fmt, ...)
+{
+	struct strbuf buf = STRBUF_INIT;
+	va_list ap;
+
+	va_start(ap, fmt);
+	strbuf_vaddf(&buf, fmt, ap);
+	va_end(ap);
+
+	packet_writer_error(&data->writer, "%s", buf.buf);
+	die("%s", buf.buf);
+}
+
+static void check_one_filter(struct upload_pack_data *data,
+			     struct list_objects_filter_options *opts)
+{
+	const char *key = list_object_filter_config_name(opts->choice);
+	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
+							   key);
+	int allowed;
+
+	if (item)
+		allowed = (intptr_t)item->util;
+	else
+		allowed = data->allow_filter_fallback;
+
+	if (!allowed)
+		send_err_and_die(data, "filter '%s' not supported", key);
+}
+
+static void check_filter_recurse(struct upload_pack_data *data,
+				 struct list_objects_filter_options *opts)
+{
+	size_t i;
+
+	check_one_filter(data, opts);
+	if (opts->choice != LOFC_COMBINE)
+		return;
+
+	for (i = 0; i < opts->sub_nr; i++)
+		check_filter_recurse(data, &opts->sub[i]);
+}
+
+static void die_if_using_banned_filter(struct upload_pack_data *data)
+{
+	check_filter_recurse(data, &data->filter_options);
+}
+
 static void receive_needs(struct upload_pack_data *data,
 			  struct packet_reader *reader)
 {
@@ -1014,6 +1070,7 @@ static void receive_needs(struct upload_pack_data *data,
 				die("git upload-pack: filtering capability not negotiated");
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, arg);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
@@ -1171,6 +1228,32 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int parse_object_filter_config(const char *var, const char *value,
+				       struct upload_pack_data *data)
+{
+	struct strbuf buf = STRBUF_INIT;
+	const char *sub, *key;
+	size_t sub_len;
+
+	if (parse_config_key(var, "uploadpackfilter", &sub, &sub_len, &key))
+		return 0;
+
+	if (!sub) {
+		if (!strcmp(key, "allow"))
+			data->allow_filter_fallback = git_config_bool(var, value);
+		return 0;
+	}
+
+	strbuf_add(&buf, sub, sub_len);
+
+	if (!strcmp(key, "allow"))
+		string_list_insert(&data->allowed_filters, buf.buf)->util =
+			(void *)(intptr_t)git_config_bool(var, value);
+
+	strbuf_release(&buf);
+	return 0;
+}
+
 static int upload_pack_config(const char *var, const char *value, void *cb_data)
 {
 	struct upload_pack_data *data = cb_data;
@@ -1210,6 +1293,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
+	parse_object_filter_config(var, value, data);
+
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
@@ -1390,6 +1475,7 @@ static void process_args(struct packet_reader *request,
 		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
-- 
2.28.0.rc1.13.ge78abce653

