Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32DA0C433E1
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0895A2071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Qwd6lEGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387528AbgGWBtH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBtG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:06 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B79BC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:06 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id el4so1925581qvb.13
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hENg6TEKnC0TvZ9BnPkb+T86J352jpTPJ5TV5UEEGho=;
        b=Qwd6lEGb53Z68opZESt5Uh5n9k1bi8Olv6hPJnhdliiKKQ5Bsf5Lv61hCcQXDgq79O
         UE/gfplNaCvoqkVXNkc/IECxo5VF0mLLzBIu+oiy8VCnIiaZf6qY3uLcbnhWBfHLQJcz
         gfmVs7h1xEJsd2DV0nC1qYPgmhP1biNU7tDYBhWLNULnFvEJqvK+LWZqAwovpvViI8aY
         IiZLyY9tr9nr6H03h2GUQTNPgUhQNYlLw5ItQm0GIdjdHIEyJOmCcKnrUhU/5NQxzn9f
         h8ZP5tt/n7GDk2xNw/SsjsvJEyvpA+LispjJLjUaIx/neZ6S1XV0GEmr99GvJC27dmez
         geBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hENg6TEKnC0TvZ9BnPkb+T86J352jpTPJ5TV5UEEGho=;
        b=D+PVwOEH+YmJJy0KHkYiZdUOI2phGi6toFk0IVf6woKNW09m6F+0qFxGEgZl4UQ5Oi
         SKMk5he3SLYnTep3Y2/GCNP82qPHEmlDfCctVGd6PuvODzh1A6ZHUogO1TqkWfpj4g6Y
         5w7FvvTtSDn2R18qmYW9oodXKFf/pJjAk7/W13TW52R4T7ruJ0n9IwNaffLb5Q0SPwB0
         SiwwEPtH3n8VrWwjyG/jHXqb5xCvD491i5pXFdhf9SJT3KllAEkFGlfbogpJese08OiZ
         3TA23OEE3I0KiyhDVPyhQjg90AVs283vjjXW+/quZo/pSaCo7hJgsYDb7o+AoM0Ph3sv
         Ecyw==
X-Gm-Message-State: AOAM532LStlXHDiH7jBTY+4hMKu24pj8R00mBEURxlDnEwPS1Tzeqr+e
        QGkW+um2+PW2kWLOxGG3Gi3jFda9rUufxw==
X-Google-Smtp-Source: ABdhPJyvm+4lalRTLUuTeEPFIyzVoSCJXG7vVRODkzT47jcBEkiLcCtA0g8/D/edxFePLXD0nI95MQ==
X-Received: by 2002:a0c:a4e3:: with SMTP id x90mr2811187qvx.36.1595468945249;
        Wed, 22 Jul 2020 18:49:05 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id z1sm1370628qkl.74.2020.07.22.18.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:49:04 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:49:03 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2 2/4] upload-pack.c: allow banning certain object filter(s)
Message-ID: <9fee52cb6dbc5eb7157a145eb6764b35b6a0e2f3.1595468659.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt | 12 +++++
 t/t5616-partial-clone.sh            | 24 +++++++++
 upload-pack.c                       | 76 +++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

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
index 8a27452a51..b196ee694c 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -235,6 +235,30 @@ test_expect_success 'implicitly construct combine: filter with repeated flags' '
 	test_cmp unique_types.expected unique_types.actual
 '
 
+test_expect_success 'upload-pack fails banned object filters' '
+	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
+	test_must_fail git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned combine object filters' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_config -C srv.bare uploadpackfilter.combine.allow true &&
+	test_config -C srv.bare uploadpackfilter.tree.allow true &&
+	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
+	test_must_fail git clone --no-checkout --filter=tree:1 \
+		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
+test_expect_success 'upload-pack fails banned object filters with fallback' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_must_fail git clone --no-checkout --filter=blob:none \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 951a2b23aa..61929977ab 100644
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
@@ -983,6 +989,46 @@ static int process_deepen_not(const char *line, struct string_list *deepen_not,
 	return 0;
 }
 
+static int allows_filter_choice(struct upload_pack_data *data,
+				enum list_objects_filter_choice c)
+{
+	const char *key = list_object_filter_config_name(c);
+	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
+							   key);
+	if (item)
+		return (intptr_t) item->util;
+	return data->allow_filter_fallback;
+}
+
+static struct list_objects_filter_options *banned_filter(
+	struct upload_pack_data *data,
+	struct list_objects_filter_options *opts)
+{
+	size_t i;
+
+	if (!allows_filter_choice(data, opts->choice))
+		return opts;
+
+	if (opts->choice == LOFC_COMBINE)
+		for (i = 0; i < opts->sub_nr; i++) {
+			struct list_objects_filter_options *sub = &opts->sub[i];
+			if (banned_filter(data, sub))
+				return sub;
+		}
+	return NULL;
+}
+
+static void die_if_using_banned_filter(struct upload_pack_data *data)
+{
+	struct list_objects_filter_options *banned = banned_filter(data,
+								   &data->filter_options);
+	if (!banned)
+		return;
+
+	die(_("git upload-pack: filter '%s' not supported"),
+	    list_object_filter_config_name(banned->choice));
+}
+
 static void receive_needs(struct upload_pack_data *data,
 			  struct packet_reader *reader)
 {
@@ -1013,6 +1059,7 @@ static void receive_needs(struct upload_pack_data *data,
 				die("git upload-pack: filtering capability not negotiated");
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, arg);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
@@ -1170,6 +1217,32 @@ static int find_symref(const char *refname, const struct object_id *oid,
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
@@ -1209,6 +1282,8 @@ static int upload_pack_config(const char *var, const char *value, void *cb_data)
 			return git_config_string(&data->pack_objects_hook, var, value);
 	}
 
+	parse_object_filter_config(var, value, data);
+
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
@@ -1389,6 +1464,7 @@ static void process_args(struct packet_reader *request,
 		if (data->allow_filter && skip_prefix(arg, "filter ", &p)) {
 			list_objects_filter_die_if_populated(&data->filter_options);
 			parse_list_objects_filter(&data->filter_options, p);
+			die_if_using_banned_filter(data);
 			continue;
 		}
 
-- 
2.28.0.rc1.13.ge78abce653

