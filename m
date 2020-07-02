Return-Path: <SRS0=gkpi=AN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEA8EC433E0
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C116820899
	for <git@archiver.kernel.org>; Thu,  2 Jul 2020 20:06:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="xAA/sh9f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgGBUGn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jul 2020 16:06:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725915AbgGBUGn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jul 2020 16:06:43 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4902CC08C5C1
        for <git@vger.kernel.org>; Thu,  2 Jul 2020 13:06:43 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id e13so26872655qkg.5
        for <git@vger.kernel.org>; Thu, 02 Jul 2020 13:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r/mDULSywTj1gnI63NMMQbObygwrg4AQY9hOWJYRbA4=;
        b=xAA/sh9foT0qmuc1iJcxXDyG9LrgqrSkjC3g0RL/YX6UdwWi74KzHv8ZGQlP5/lsvq
         pcS/Kq0siShS7VBXdzgk7YDkrMtPEKrKV+7vX92brnfx5Rjk6KIp84QusUZbNcR5T9dA
         vhIHcvwGKOPI2jkDR2pvYOWuklvMQEmd3lQ8aEfTbnIgz93OmuJfgaSc5UUE+ksTw7Dd
         gTgthO9gdWiuWpWgLa9+QvC+j4G1Ff8gm9JVAt5kRu/dOKE29SdT3Qda9SArEf5N92Qk
         Rrp8mcXeKPnIo1czyFlJ3b8LFHTv2MpqNV6tx+F591aJ+1nnOkZorixh+8Xysq6l4YpX
         2LSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r/mDULSywTj1gnI63NMMQbObygwrg4AQY9hOWJYRbA4=;
        b=oESt5WAe+oZ0jpHM7Z7L2qDdkpNnWV+m9nC1fnzNkSmRk7LzFXtIfyAKl1Ehik/PsM
         yjRlXsoy2l+S4KyuTw4D2RtIefCb+ErdK59NHZ85HTEag3DMMOKrpF7EA0iCZ4b9Kz/o
         Au8nHGaVAHnopsc83ZIVOlHVGbCcN/3av8i53AR/Of7tBDBAuZxp5nnkQ+Pjm3ijYB7I
         TcFlCYCmPlCNOf8G828J6ErZAEsCgVLdUvs8tlqGSpR5ra4IxMJmSnVdRA3QoNvmCd0k
         6+3x7QVh7Xi5A+1b/OWKgSPGonbDRPEQU++ZybQ6INEwE+sNWIucyQU3YQqD6ffmooik
         U4Cw==
X-Gm-Message-State: AOAM5336+c6JOytbusY+0QYNPeWKzfZGc+9cIlP3RNAKsdijJuALCkAU
        pcnqKDfev1ataHCEq+iGCCgLlJm6ZxgNgQ==
X-Google-Smtp-Source: ABdhPJw4jmct3VBljiamK4P0a0ZIkTd9uzZcpEz2am33seWC0IsEAo+ohzXo5BdStkGpxyx8c6cNTQ==
X-Received: by 2002:a37:470a:: with SMTP id u10mr33328022qka.202.1593720402089;
        Thu, 02 Jul 2020 13:06:42 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:650d:8c1a:48a0:61b2])
        by smtp.gmail.com with ESMTPSA id j7sm9268646qtd.53.2020.07.02.13.06.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2020 13:06:41 -0700 (PDT)
Date:   Thu, 2 Jul 2020 16:06:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org
Subject: [PATCH 4/4] upload-pack.c: introduce
 'uploadpack.filter.tree.maxDepth'
Message-ID: <9fa765a71d25ef3462ce81cca9754daa9b2579b6.1593720075.git.me@ttaylorr.com>
References: <cover.1593720075.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1593720075.git.me@ttaylorr.com>
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

  $ git config uploadpack.filter.tree.allow true

(since it would allow all values of 'n'), we would like to be able to
allow this filter for certain values of 'n', i.e., those no greater than
some pre-specified maximum.

In order to do this, introduce a new configuration key, as follows:

  $ git config uploadpack.filter.tree.maxDepth <m>

where '<m>' specifies the maximum allowed value of 'n' in the filter
'tree:n'. Administrators who wish to allow for only the value '0' can
write:

  $ git config uploadpack.filter.tree.allow true
  $ git config uploadpack.filter.tree.maxDepth 0

which allows '--filter=tree:0', but no other values.

Unfortunately, since the tree depth is an unsigned long, we can't use,
say, -1 as a sentinel value, and so we must also keep track of "have we
set this" as well as "to what value".

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt |  6 ++++++
 t/t5616-partial-clone.sh            |  8 ++++++++
 upload-pack.c                       | 32 ++++++++++++++++++++++++++---
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/uploadpack.txt
index fd4970306c..3671b62e4c 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -73,6 +73,12 @@ Note that the dot between 'filter' and '<filter>' is both non-standard
 and intentional. This is done to avoid a parsing ambiguity when
 specifying this configuration as an argument to Git's top-level `-c`.
 
+uploadpack.filter.tree.maxDepth::
+	Only allow `--filter=tree=<n>` when `n` is no more than the value of
+	`uploadpack.filter.tree.maxDepth`. If set, this also implies
+	`uploadpack.filter.tree.allow=true`, unless this configuration
+	variable had already been set. Has no effect if unset.
+
 uploadpack.allowRefInWant::
 	If this option is set, `upload-pack` will support the `ref-in-want`
 	feature of the protocol version 2 `fetch` command.  This feature
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 5dcd0b5656..8781a24cfe 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -261,6 +261,14 @@ test_expect_success 'upload-pack fails banned object filters with fallback' '
 	test_i18ngrep "filter '\''blob:none'\'' not supported" err
 '
 
+test_expect_success 'upload-pack limits tree depth filters' '
+	test_config -C srv.bare uploadpack.filter.allow false &&
+	test_config -C srv.bare uploadpack.filter.tree.allow true &&
+	test_config -C srv.bare uploadpack.filter.tree.maxDepth 0 &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc3
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index a014ae23a9..8db1745b86 100644
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
 
@@ -1022,11 +1033,22 @@ static void die_if_using_banned_filter(struct upload_pack_data *data)
 {
 	struct list_objects_filter_options *banned = banned_filter(data,
 								   &data->filter_options);
+	struct strbuf buf = STRBUF_INIT;
 	if (!banned)
 		return;
 
-	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
-			    list_object_filter_config_name(banned->choice));
+	strbuf_addf(&buf, _("filter '%s' not supported"),
+		    list_object_filter_config_name(banned->choice));
+	if (banned->choice == LOFC_TREE_DEPTH &&
+	    data->tree_filter_max_depth != ULONG_MAX)
+		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
+			    data->tree_filter_max_depth,
+			    banned->tree_exclude_depth);
+
+	packet_writer_error(&data->writer, "%s\n", buf.buf);
+
+	strbuf_release(&buf);
+
 	die(_("git upload-pack: banned object filter requested"));
 }
 
@@ -1239,6 +1261,10 @@ static void parse_object_filter_config(const char *var, const char *value,
 				(void *)(intptr_t)git_config_bool(var, value);
 		else
 			data->allow_filter_fallback = git_config_bool(var, value);
+	} else if (!strcmp(spec.buf, "tree") && !strcmp(key, "maxdepth")) {
+		string_list_insert(&data->allowed_filters, "tree")->util
+			= (void *) (intptr_t) 1;
+		data->tree_filter_max_depth = git_config_ulong(var, value);
 	}
 
 	strbuf_release(&spec);
-- 
2.27.0.225.g9fa765a71d
