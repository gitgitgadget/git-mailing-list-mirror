Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB896C433E5
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 915772071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BNyNS7xc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387556AbgGWBtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:49:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729198AbgGWBtO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:49:14 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F51C0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:14 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id el4so1925692qvb.13
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNJ55miaRx/EShXoUMw2rdQnWBw6IOU1ZIF4ni4DCq0=;
        b=BNyNS7xc9WUGT4OZmQ8lXXaT5ypuijSvZVAwaDOVRfMQm5dbZxDYTDDk8j4XmbKQgF
         +DzV1sJ3qGJWQwAv1AZRdNfa10+2FMPCdqG4oWdra3w1AZDHMOiGH0VDZm/9EcGL2qIb
         HbtA/IiE35qtFiA90WhT9+j95gTRfdQeA1lrfYNOSZe5W0XxvLLakZ2rLZz9JsqgEb0y
         +FR3mHe9LQoTPXVXODNAZz3Bd4lNTuVpATTTl2bbqLmCz8gxeibjuLrDckvXrYu6VwtF
         djkzi8JQkdDXdbb4xPKYLJ+6otthb21nNNjQ8L8RTkTDywT1q5O62sfpvyPZSAY/6zPc
         V7SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bNJ55miaRx/EShXoUMw2rdQnWBw6IOU1ZIF4ni4DCq0=;
        b=O4gbp4gAWy+YJJjcyBS1I6LFp9v4YlNwO1HNJUoe07OTM/mat1tX2vMR91xCIOdL+w
         0fPrWQ8ARBa/CoAo7AtHD7OnOaCPxZ/VKPLhrQOu0jq3vGhSEFVuF0OmQtkGA/bG9pQX
         Pg/fQPusHtUPn/xejmGDJ5BLszaYVA83vpnAwgBq9K0XCsdDRwXgeQWL0NXnpr+VYPmo
         fspkk1b+tCtiHIFleKrRsc+2y4JtSFKtqDtH5PYE4wAeGm85UL7Woz/bHJFFqAK0VzQu
         1pps1nF5bHxSwoYcbOXluAP7Qmos1taUko6I/XaYgRass1XlZo9i1hNJwoi2MjQIxGud
         7PGQ==
X-Gm-Message-State: AOAM533k2+t3GcEha4wLqdmfE13K+Kp8zFODPDbDfFW4LhQoc7sG+SHQ
        6T8piWt3eDPwyL2mXi+FYXDi7G6Yl0d7EA==
X-Google-Smtp-Source: ABdhPJykxeB1Vc14LvDCBjtcNHp9KnQTH86rHANR/wdfiSrUUF9bMLn3Yi0KO1LpNN1MF/d9aKvKag==
X-Received: by 2002:a0c:b315:: with SMTP id s21mr2763496qve.53.1595468952953;
        Wed, 22 Jul 2020 18:49:12 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id b131sm1403239qkc.121.2020.07.22.18.49.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:49:12 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:49:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <bb008f7427cfe4f0a5c85af6c6f821f48a534360.1595468659.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In b79cf959b2 (upload-pack.c: allow banning certain object filter(s),
2020-02-26), we introduced functionality to disallow certain object
filters from being chosen from within 'git upload-pack'. Traditionally,
administrators use this functionality to disallow filters that are known
to perform slowly, for e.g., those that do not have bitmap-level
filtering.

In the past, the '--filter=tree:<n>' was one such filter that does not
have bitmap-level filtering support, and so was likely to be banned by
administrators.

However, in the previous couple of commits, we introduced bitmap-level
filtering for the case when 'n' is equal to '0', i.e., as if we had a
'--filter=tree:none' choice.

While it would be sufficient to simply write

  $ git config uploadpackfilter.tree.allow true

(since it would allow all values of 'n'), we would like to be able to
allow this filter for certain values of 'n', i.e., those no greater than
some pre-specified maximum.

In order to do this, introduce a new configuration key, as follows:

  $ git config uploadpackfilter.tree.maxDepth <m>

where '<m>' specifies the maximum allowed value of 'n' in the filter
'tree:n'. Administrators who wish to allow for only the value '0' can
write:

  $ git config uploadpackfilter.tree.allow true
  $ git config uploadpackfilter.tree.maxDepth 0

which allows '--filter=tree:0', but no other values.

Unfortunately, since the tree depth is an unsigned long, we can't use,
say, -1 as a sentinel value, and so we must also keep track of "have we
set this" as well as "to what value".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt |  6 ++++++
 t/t5616-partial-clone.sh            |  8 +++++++
 upload-pack.c                       | 33 ++++++++++++++++++++++++++---
 3 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index fffe8ac648..ee7b3ac94f 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -69,6 +69,12 @@ uploadpackfilter.<filter>.allow::
 	combined filters, both `combine` and all of the nested filter
 	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
 
+uploadpackfilter.tree.maxDepth::
+	Only allow `--filter=tree=<n>` when `n` is no more than the value of
+	`uploadpackfilter.tree.maxDepth`. If set, this also implies
+	`uploadpackfilter.tree.allow=true`, unless this configuration
+	variable had already been set. Has no effect if unset.
+
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index b196ee694c..4292a644d7 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -259,6 +259,14 @@ test_expect_success 'upload-pack fails banned object filters with fallback' '
 	test_i18ngrep "filter '\''blob:none'\'' not supported" err
 '
 
+test_expect_success 'upload-pack limits tree depth filters' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_config -C srv.bare uploadpackfilter.tree.allow true &&
+	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc3
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 48f10d21f6..47cdaae265 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -105,6 +105,7 @@ struct upload_pack_data {
 	unsigned use_include_tag : 1;
 	unsigned allow_filter : 1;
 	unsigned allow_filter_fallback : 1;
+	unsigned long tree_filter_max_depth;
 
 	unsigned done : 1;					/* v2 only */
 	unsigned allow_ref_in_want : 1;				/* v2 only */
@@ -136,6 +137,7 @@ static void upload_pack_data_init(struct upload_pack_data *data)
 	data->extra_edge_obj = extra_edge_obj;
 	data->allowed_filters = allowed_filters;
 	data->allow_filter_fallback = 1;
+	data->tree_filter_max_depth = ULONG_MAX;
 	packet_writer_init(&data->writer, 1);
 
 	data->keepalive = 5;
@@ -995,8 +997,17 @@ static int allows_filter_choice(struct upload_pack_data *data,
 	const char *key = list_object_filter_config_name(opts->choice);
 	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
 							   key);
+	int allowed = -1;
 	if (item)
-		return (intptr_t) item->util;
+		allowed = (intptr_t) item->util;
+
+	if (allowed != 0 &&
+	    opts->choice == LOFC_TREE_DEPTH &&
+	    opts->tree_exclude_depth > data->tree_filter_max_depth)
+		return 0;
+
+	if (allowed > -1)
+		return allowed;
 	return data->allow_filter_fallback;
 }
 
@@ -1022,11 +1033,18 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
 {
 	struct list_objects_filter_options *banned = banned_filter(data,
 								   &data->filter_options);
+	struct strbuf buf = STRBUF_INIT;
 	if (!banned)
 		return;
 
-	die(_("git upload-pack: filter '%s' not supported"),
-	    list_object_filter_config_name(banned->choice));
+	strbuf_addf(&buf, _("filter '%s' not supported"),
+		    list_object_filter_config_name(banned->choice));
+	if (banned->choice == LOFC_TREE_DEPTH &&
+	    data->tree_filter_max_depth != ULONG_MAX)
+		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
+			    data->tree_filter_max_depth,
+			    banned->tree_exclude_depth);
+	die("%s", buf.buf);
 }
 
 static void receive_needs(struct upload_pack_data *data,
@@ -1238,6 +1256,15 @@ static int parse_object_filter_config(const char *var, const char *value,
 	if (!strcmp(key, "allow"))
 		string_list_insert(&data->allowed_filters, buf.buf)->util =
 			(void *)(intptr_t)git_config_bool(var, value);
+	else if (!strcmp(buf.buf, "tree") && !strcmp(key, "maxdepth")) {
+		if (!value) {
+			strbuf_release(&buf);
+			return config_error_nonbool(var);
+		}
+		string_list_insert(&data->allowed_filters, buf.buf)->util =
+			(void *)(intptr_t)1;
+		data->tree_filter_max_depth = git_config_ulong(var, value);
+	}
 
 	strbuf_release(&buf);
 	return 0;
-- 
2.28.0.rc1.13.ge78abce653
