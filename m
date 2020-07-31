Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 231D3C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F10742087C
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="MUO29w6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgGaU0o (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:26:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU0n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:43 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5440C061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:43 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l23so30046124qkk.0
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bRPN9/aHbdi2iL3c6SJIcY26jU7g2txXhiSCHDyZDZ0=;
        b=MUO29w6BPrJlN0Bv/bj19PIkEZiIo0AARUmpYD3zB0sTJFi3U28WtfaxjXVDRy+Isr
         thb4MEKJ5I/eCo7zLBMwMWE33eeEAWRxxiNovmVOKKbf2JCv3VQjTaSdggHEITLzVSwQ
         JfS33MYYpxOQAe4dZkA9wXjnpT70qR7cjU8PAIgxY/goSG7pMKehk18H7TthGoH3njd9
         WgRthLtjuFEBfOXARZXP7yaDIW3f5Il3gd7Xw7mcfEUfIawf+IA5lPL3RkXwyqWgMxfp
         WyG+pwwX8KDLgmhqbug4loUlkjFivC/O8SukfvHpRF+V7KEtpHVfcKFmJpFtlCLCR8Wp
         +rQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bRPN9/aHbdi2iL3c6SJIcY26jU7g2txXhiSCHDyZDZ0=;
        b=GwC29XYeWyOSZ8j4ry8CWTx228HvjHuHgt+SqD1YJ7ogSZk7SOhXJ1QDfIMcHnTMBx
         8bYcQUG20mFITuuB/eLpUxI4/FLgtV3T6U5IgUEBC3hf9pcs8Fquwn9Q4XWI8jW8cwZg
         KI4I78pkOX0OhAP3RvJ5uHS01ask5jDhqC0LNmK2cNhTOl1fesCnoUn9hpRL6BHUIXt3
         tM9UqM4UAKIRKF7GWTnw4iM+ObZ980S0Q5C8pmSJCaGerWbHmomoViUdrHMvgWcHTxoy
         uoAY3RmdThmUqXFtWPtIj1dT7Ob12ccvQ1S3EtKYWSxOSx9R3t+X0SRgPQgH3IQdHD+e
         eC6A==
X-Gm-Message-State: AOAM532RvtYMaf7TPAHej9m5+2kYB50hClRI5Kufzi/ihUylDfuYCdXY
        +nuid7y/7Wxdza1lk8H9OhqfUjl1v5i/Sw==
X-Google-Smtp-Source: ABdhPJyK0tDeadu7TcbpqhT4NgwhDZ7gZ9aXXHAEicF1W1eDKt4pZ7iIhSVDZogzC879N+VgP/84nw==
X-Received: by 2002:a05:620a:122c:: with SMTP id v12mr5920899qkj.113.1596227202098;
        Fri, 31 Jul 2020 13:26:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id k48sm2903348qtk.44.2020.07.31.13.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:26:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:26:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 4/4] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <c9d71809f49dc1b600b75769e0b6aae17382bf4e.1596227003.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
 <cover.1596227003.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1596227003.git.me@ttaylorr.com>
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
 t/t5616-partial-clone.sh            |  9 +++++++++
 upload-pack.c                       | 27 ++++++++++++++++++++++++++-
 3 files changed, 41 insertions(+), 1 deletion(-)

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
index 0d46b5a2f8..35cb6a34a3 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -259,6 +259,15 @@ test_expect_success 'upload-pack fails banned object filters with fallback' '
 	test_i18ngrep "filter '\''blob:none'\'' not supported" err
 '
 
+test_expect_success 'upload-pack limits tree depth filters' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_config -C srv.bare uploadpackfilter.tree.allow true &&
+	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 5fa22da31f..131445b212 100644
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
@@ -996,8 +998,17 @@ static int allows_filter_choice(struct upload_pack_data *data,
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
 
@@ -1029,6 +1040,11 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
 
 	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
 		    list_object_filter_config_name(banned->choice));
+	if (banned->choice == LOFC_TREE_DEPTH &&
+	    data->tree_filter_max_depth != ULONG_MAX)
+		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
+			    data->tree_filter_max_depth,
+			    banned->tree_exclude_depth);
 
 	packet_writer_error(&data->writer, "%s\n", buf.buf);
 	die("%s", buf.buf);
@@ -1243,6 +1259,15 @@ static int parse_object_filter_config(const char *var, const char *value,
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
