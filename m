Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFEF7C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1662086A
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="Vcc75xj5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgHCSAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHCSAU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:00:20 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93057C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:00:20 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id b2so7178505qvp.9
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Wwjj3nW+/A4IB9Jolhj7VMy6tdooPj+JpfFiwvAHNkY=;
        b=Vcc75xj5d8ySfJA187zmQ03aL2HkmOwZ4wszfymmbGbH5MsPH55SaLKktd82OX7PSB
         IjFxkYd18zauMJn/WheEhJAsOsvF0/xi3tKLLg1AbxzuUBAgdODXhaU/6K/WT5nj6sYE
         6Y3mVxY0Sl02ZPDOnefbdI5Y8/3YyHH05MDP+bdZxd+ApzxVYK81ZIBcEVlwbblaWq9s
         PmYSitQAFwr6CU+Ov+8P00IpIuMw27fj6oLHSQoonwtf5exDVDA4ZkqQYC2ipLmv5Al5
         qye8QAXP2A/sZMiTFCMbdlQmqb/AJNV2FZuQQZ2UtPCNwqGQ4d5KT9aXOrY07APRrWCF
         UnNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Wwjj3nW+/A4IB9Jolhj7VMy6tdooPj+JpfFiwvAHNkY=;
        b=h3sNCnz/7HSV9k1CDEQPtL3atjLrTx5zyFgROhhlLVdwSmgiG1kDQpBrTVdCrDWXN7
         BifUWrlv67Dtd3LpnLFyLVXAgdhYEBzLg/reH9vFfeYbzxNBsaSaYs8hvYWjUnB32VpM
         3fKvLtn1QQbJDShuC2ePAqePhetBRAjAinxygqPcYUPdCzNc0QQi2szllY4svWmqS6xi
         biQt/BrNbOr6AyHAjrMteXmGo7Um3JuoKOOKhAQwFX5ucDLsi6G4NxG4GH+ki7y9AfJ8
         xslPT4yXMW/n1qRAIuOl8OPIS9l88HP/vSviE3LlpTti9/ihscAoaBZAM48a/3IcbTA2
         a16A==
X-Gm-Message-State: AOAM533cg7lNBsFzaSLixdruLJC4GaXDCho5J8nx8pYqRX4zAbHjtPX5
        WSXvprKeZTNaAcSBbQK/4xYhwLaDYFALqA==
X-Google-Smtp-Source: ABdhPJwiRs2D+yoywHEAV5t24Vy1mS1qsiz53pFpklipNn09LJtlo+4K2DKtdhl8+T+Yc89wrF3TWQ==
X-Received: by 2002:a05:6214:1143:: with SMTP id b3mr18513307qvt.84.1596477618980;
        Mon, 03 Aug 2020 11:00:18 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id j15sm18695799qkl.63.2020.08.03.11.00.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:00:18 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:00:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v4 3/3] upload-pack.c: introduce
 'uploadpackfilter.tree.maxDepth'
Message-ID: <a0e7731a55b6cda3e1dd549725692a2d4c9b0900.1596476929.git.me@ttaylorr.com>
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

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/config/uploadpack.txt |  6 ++++++
 t/t5616-partial-clone.sh            |  9 +++++++++
 upload-pack.c                       | 18 ++++++++++++++++++
 3 files changed, 33 insertions(+)

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
index aa68782587..96ab45feab 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -259,6 +259,15 @@ test_expect_success 'upload-pack fails banned object filters with fallback' '
 	grep "filter '\''blob:none'\'' not supported" err
 '
 
+test_expect_success 'upload-pack limits tree depth filters' '
+	test_config -C srv.bare uploadpackfilter.allow false &&
+	test_config -C srv.bare uploadpackfilter.tree.allow true &&
+	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
+	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
+		"file://$(pwd)/srv.bare" pc3 2>err &&
+	grep "tree filter allows max depth 0, but got 1" err
+'
+
 test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
 	rm -rf src dst &&
 	git init src &&
diff --git a/upload-pack.c b/upload-pack.c
index 2098af8156..fbd2db04cd 100644
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
@@ -1020,6 +1022,13 @@ static void check_one_filter(struct upload_pack_data *data,
 
 	if (!allowed)
 		send_err_and_die(data, "filter '%s' not supported", key);
+
+	if (opts->choice == LOFC_TREE_DEPTH &&
+	    opts->tree_exclude_depth > data->tree_filter_max_depth)
+		send_err_and_die(data,
+				 "tree filter allows max depth %lu, but got %lu",
+				 data->tree_filter_max_depth,
+				 opts->tree_exclude_depth);
 }
 
 static void check_filter_recurse(struct upload_pack_data *data,
@@ -1249,6 +1258,15 @@ static int parse_object_filter_config(const char *var, const char *value,
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
