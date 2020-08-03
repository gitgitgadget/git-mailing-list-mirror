Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDD8C433E0
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3B3122B45
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 18:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="IluE0nYH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727809AbgHCSAJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 14:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726806AbgHCSAJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 14:00:09 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC2C06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 11:00:09 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l23so36017606qkk.0
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 11:00:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+sjmD721QrNHnhCY8rSe24RwzYJ3ABmoahIj7GEAmOw=;
        b=IluE0nYHT0eKgG8CzRPyc/gAD0v0VwzIuhgrrdiDnFdRF3pWVM2vwtkd+wi7tM1Ewa
         pLbFdCC+DQYUkvpsNfaNqMCiz87AgHRBDDiuP5aqWSDA+jb3Sy+iT9YJR6tmK0Q4q282
         5CCURizfqg8UgvRVArCwp5fNCLGnjlc+ANpgX7S0lgO5RFq9JCdAoOEzzqocgTYsEad8
         Dn04712wT8lfFodXYO57Qwvm/f384acpumWJXDlXx38pmIv76Pyer7uNGDBNrTjMWdNM
         tkZycm7yIeVxlgyIehLqh7wmEdS9S4p/hv73a7tJLQ8w171w5LBkOBy+FiFY9HtwDZ4+
         GRcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+sjmD721QrNHnhCY8rSe24RwzYJ3ABmoahIj7GEAmOw=;
        b=PCl9upttG0ulTClSMAQtPqYjX4Igwa9xCqcZ/liLZ+2m+mNIqwIR6AhyLUYaNFDBwp
         bRXSLl2lcj3IXjRNXdMGpv+PfW8iPk+Mu6akIrz8aFmjlQt5/8+FAs/exbCpF0357yWM
         ELrrZzNq+7qpRROr/9I2hDaXlfXeXg7PmwrDTEw4xJkawEqmPnqlvpiDoO0Uf7cewr70
         LHs7uFAL5/icuEIrMfQiHmcFX4NxAYOOgRF5Yg7MaXhjB2wUqhcVhtTxWsgwjgwac2sy
         SCmh1S83gFbIeg8wgSz4wchQZYQmW0lnRxGUx/pv2BXt1RT7cFVYZqc85yZIxp1OiBej
         f9vg==
X-Gm-Message-State: AOAM5319Df4Q3yPu1au2psI4O0bVWui41/yZgVbzCNjuHOdbPx6KEpwV
        sxxL1xTvFEhWHwO7aVDaaRx/p8IA7Br3vA==
X-Google-Smtp-Source: ABdhPJz5YI77eYF93K5bLLDBBmz257ijSqK3C06LzlYarHF4lNrbeIW/aH3LHX2K03ia8L3uvf9EVg==
X-Received: by 2002:a05:620a:62f:: with SMTP id 15mr16711184qkv.483.1596477607605;
        Mon, 03 Aug 2020 11:00:07 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id m3sm20161008qka.31.2020.08.03.11.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 11:00:06 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:00:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v4 0/3] upload-pack: custom allowed object filters
Message-ID: <cover.1596476928.git.me@ttaylorr.com>
References: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1595468657.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here's what I anticipate to be the final reroll of my series to teach
the new 'uploadpackfilter' configuration section, which allows for more
fine-grained control over which object filters upload-pack is willing to
serve.

Two changes from last time:

  - I adopted Peff's suggestion in beginning in [1], but appropriately
    split it over the existing patch structure.

  - I dropped the old patch 3/4, since it really should have never been
    there in the first place, and just made the refactoring more noisy
    than necessary.

    (For the curious, this patch was written as a preparatory step
    within GitHub's fork in order to add the
    'uploadpackfilter.tree.maxDepth' configuration. This was after the
    initial work when I hadn't yet considered adding such a thing. Now
    that we know the full arc, it makes sense to just pass the right
    parameters from the get-go).

Thanks again for all of the review!

[1] :https://lore.kernel.org/git/20200731210114.GC1440890@coredump.intra.peff.net/

Taylor Blau (3):
  list_objects_filter_options: introduce
    'list_object_filter_config_name'
  upload-pack.c: allow banning certain object filter(s)
  upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'

 Documentation/config/uploadpack.txt |  18 +++++
 list-objects-filter-options.c       |  23 ++++++
 list-objects-filter-options.h       |   6 ++
 t/t5616-partial-clone.sh            |  33 +++++++++
 upload-pack.c                       | 104 ++++++++++++++++++++++++++++
 5 files changed, 184 insertions(+)

Range-diff against v3:
-:  ---------- > 1:  21531927e4 Revert "fmt-merge-msg: stop treating `master` specially"
-:  ---------- > 2:  6e6029a82a fmt-merge-msg: allow merge destination to be omitted again
-:  ---------- > 3:  25429fed5c refs: move the logic to add \t to reflog to the files backend
-:  ---------- > 4:  3db796c1c0 t6300: fix issues related to %(contents:size)
-:  ---------- > 5:  85b4e0a6dc Third batch
1:  b1b3dd7de9 = 6:  f4c7771875 list_objects_filter_options: introduce 'list_object_filter_config_name'
2:  a0a0427757 ! 7:  b34f4eaed9 upload-pack.c: allow banning certain object filter(s)
    @@ Commit message
         'uploadpack.allowfilter', which controls whether or not the 'filter'
         capability is advertised.

    +    Helped-by: Jeff King <peff@peff.net>
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## Documentation/config/uploadpack.txt ##
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	grep "filter '\''blob:none'\'' not supported" err
     +'
     +
     +test_expect_success 'upload-pack fails banned combine object filters' '
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
     +		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	grep "filter '\''blob:none'\'' not supported" err
     +'
     +
     +test_expect_success 'upload-pack fails banned object filters with fallback' '
     +	test_config -C srv.bare uploadpackfilter.allow false &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	grep "filter '\''blob:none'\'' not supported" err
     +'
     +
      test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
    @@ upload-pack.c: static int process_deepen_not(const char *line, struct string_lis
      	return 0;
      }

    -+static int allows_filter_choice(struct upload_pack_data *data,
    -+				enum list_objects_filter_choice c)
    ++NORETURN __attribute__((format(printf,2,3)))
    ++static void send_err_and_die(struct upload_pack_data *data,
    ++			     const char *fmt, ...)
     +{
    -+	const char *key = list_object_filter_config_name(c);
    ++	struct strbuf buf = STRBUF_INIT;
    ++	va_list ap;
    ++
    ++	va_start(ap, fmt);
    ++	strbuf_vaddf(&buf, fmt, ap);
    ++	va_end(ap);
    ++
    ++	packet_writer_error(&data->writer, "%s", buf.buf);
    ++	die("%s", buf.buf);
    ++}
    ++
    ++static void check_one_filter(struct upload_pack_data *data,
    ++			     struct list_objects_filter_options *opts)
    ++{
    ++	const char *key = list_object_filter_config_name(opts->choice);
     +	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
     +							   key);
    ++	int allowed;
    ++
     +	if (item)
    -+		return (intptr_t) item->util;
    -+	return data->allow_filter_fallback;
    ++		allowed = (intptr_t)item->util;
    ++	else
    ++		allowed = data->allow_filter_fallback;
    ++
    ++	if (!allowed)
    ++		send_err_and_die(data, "filter '%s' not supported", key);
     +}
     +
    -+static struct list_objects_filter_options *banned_filter(
    -+	struct upload_pack_data *data,
    -+	struct list_objects_filter_options *opts)
    ++static void check_filter_recurse(struct upload_pack_data *data,
    ++				 struct list_objects_filter_options *opts)
     +{
     +	size_t i;
     +
    -+	if (!allows_filter_choice(data, opts->choice))
    -+		return opts;
    -+
    -+	if (opts->choice == LOFC_COMBINE)
    -+		for (i = 0; i < opts->sub_nr; i++) {
    -+			struct list_objects_filter_options *sub = &opts->sub[i];
    -+			if (banned_filter(data, sub))
    -+				return sub;
    -+		}
    -+	return NULL;
    -+}
    -+
    -+static void die_if_using_banned_filter(struct upload_pack_data *data)
    -+{
    -+	struct list_objects_filter_options *banned = banned_filter(data,
    -+								   &data->filter_options);
    -+	struct strbuf buf = STRBUF_INIT;
    -+	if (!banned)
    ++	check_one_filter(data, opts);
    ++	if (opts->choice != LOFC_COMBINE)
     +		return;
     +
    -+	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
    -+		    list_object_filter_config_name(banned->choice));
    ++	for (i = 0; i < opts->sub_nr; i++)
    ++		check_filter_recurse(data, &opts->sub[i]);
    ++}
     +
    -+	packet_writer_error(&data->writer, "%s\n", buf.buf);
    -+	die("%s", buf.buf);
    ++static void die_if_using_banned_filter(struct upload_pack_data *data)
    ++{
    ++	check_filter_recurse(data, &data->filter_options);
     +}
     +
      static void receive_needs(struct upload_pack_data *data,
3:  ad3f0cce56 < -:  ---------- upload-pack.c: pass 'struct list_objects_filter_options *'
4:  c9d71809f4 ! 8:  a0e7731a55 upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
    @@ Commit message

         which allows '--filter=tree:0', but no other values.

    -    Unfortunately, since the tree depth is an unsigned long, we can't use,
    -    say, -1 as a sentinel value, and so we must also keep track of "have we
    -    set this" as well as "to what value".
    -
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## Documentation/config/uploadpack.txt ##
    @@ Documentation/config/uploadpack.txt: uploadpackfilter.<filter>.allow::

      ## t/t5616-partial-clone.sh ##
     @@ t/t5616-partial-clone.sh: test_expect_success 'upload-pack fails banned object filters with fallback' '
    - 	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    + 	grep "filter '\''blob:none'\'' not supported" err
      '

     +test_expect_success 'upload-pack limits tree depth filters' '
    @@ t/t5616-partial-clone.sh: test_expect_success 'upload-pack fails banned object f
     +	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err
    ++	grep "tree filter allows max depth 0, but got 1" err
     +'
     +
      test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
    @@ upload-pack.c: static void upload_pack_data_init(struct upload_pack_data *data)
      	packet_writer_init(&data->writer, 1);

      	data->keepalive = 5;
    -@@ upload-pack.c: static int allows_filter_choice(struct upload_pack_data *data,
    - 	const char *key = list_object_filter_config_name(opts->choice);
    - 	struct string_list_item *item = string_list_lookup(&data->allowed_filters,
    - 							   key);
    -+	int allowed = -1;
    - 	if (item)
    --		return (intptr_t) item->util;
    -+		allowed = (intptr_t) item->util;
    +@@ upload-pack.c: static void check_one_filter(struct upload_pack_data *data,
    +
    + 	if (!allowed)
    + 		send_err_and_die(data, "filter '%s' not supported", key);
     +
    -+	if (allowed != 0 &&
    -+	    opts->choice == LOFC_TREE_DEPTH &&
    ++	if (opts->choice == LOFC_TREE_DEPTH &&
     +	    opts->tree_exclude_depth > data->tree_filter_max_depth)
    -+		return 0;
    -+
    -+	if (allowed > -1)
    -+		return allowed;
    - 	return data->allow_filter_fallback;
    ++		send_err_and_die(data,
    ++				 "tree filter allows max depth %lu, but got %lu",
    ++				 data->tree_filter_max_depth,
    ++				 opts->tree_exclude_depth);
      }

    -@@ upload-pack.c: static void die_if_using_banned_filter(struct upload_pack_data *data)
    -
    - 	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
    - 		    list_object_filter_config_name(banned->choice));
    -+	if (banned->choice == LOFC_TREE_DEPTH &&
    -+	    data->tree_filter_max_depth != ULONG_MAX)
    -+		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
    -+			    data->tree_filter_max_depth,
    -+			    banned->tree_exclude_depth);
    -
    - 	packet_writer_error(&data->writer, "%s\n", buf.buf);
    - 	die("%s", buf.buf);
    + static void check_filter_recurse(struct upload_pack_data *data,
     @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char *value,
      	if (!strcmp(key, "allow"))
      		string_list_insert(&data->allowed_filters, buf.buf)->util =
--
2.28.0.rc1.13.ge78abce653
