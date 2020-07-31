Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 454E5C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1C4BF22B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 20:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="oLs96E7Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727890AbgGaU00 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 16:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725767AbgGaU0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 16:26:25 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDA7CC061574
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:25 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id d14so29976547qke.13
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 13:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KjRg36aEv9f1IW7wXexLobB3TrIJLP1D4TUN4AOSC1E=;
        b=oLs96E7QRWD3DjLWNlEK0sW2HEe1ySATempmh7UY2IUIsWIOxiCgOo4397dc5OuDvL
         4LXYOOH2Zn6XEgOONt3yf/vUwu7WqUFFAMveLAbBXvbNYvxD0iYYa2DBV6gQkGNSMX1o
         ED3NV4l7mEcypGYj2qRF7hm+DcOUirwtILzMXwZGoQ70NSy8yYraOME5o2m8g9tha+rM
         eaRrj1Q0WAiyq0b1b0FUjwUM4hV7K8KCTIjsKNVjapI1ZRmA48ZBOzURyThW5ApBU3L+
         eJB3UwbjyFIiCbWIbN4lU93L712uoWEkwuzg+ZwEQNIJxNeCQuymjGUdpbMnFwfpqHyl
         KH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KjRg36aEv9f1IW7wXexLobB3TrIJLP1D4TUN4AOSC1E=;
        b=OHbVvL47iu50XvlXkp6A75ZIQPypAr/CcOrgYhQ5++fFdzJi/UOa9TyChg4wA9ECLt
         9S+WWxbBDGQ6/RiA8lTovYsI/zEtnMkJ/CUdANcTukBXn8e1b5NohBa3YkDDK2JsDEHg
         2qIuusQ2XHjqYl97dfn26xS2jurBTr4L0PDnp/whPEw1KL+iQvt3DDuua3CIBp1L20A5
         nNHvPF2+jwFCc2Xi8AEPs9/xQ9kpdDBav5/+GIQIi2asJZJ3bo7wJ5+VEwctgAL/DzCU
         KwHXdNFAIcu46Wi8fBThFtsXutNeox1BIa34fRNO9i0HvQ61u8MrLLR2RkrntPp3g1Ll
         1Ipw==
X-Gm-Message-State: AOAM532FTfp5qvMdxa1JXoq4/C+B8W66ziphd3wbyMxe/uv+EVbwRSlX
        F0aTf3doc1huG2R/9VwIvjHRAG1Qg+3oRg==
X-Google-Smtp-Source: ABdhPJxTcN4Nge4xNlU+pPQ8562ujBv3WydDQm0B3sUkkOj09XWucyFJRjkETCO1pGOG3EcfMyU9BA==
X-Received: by 2002:ae9:c20c:: with SMTP id j12mr6029436qkg.369.1596227184085;
        Fri, 31 Jul 2020 13:26:24 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:1861:1305:b592:e057])
        by smtp.gmail.com with ESMTPSA id j72sm9096190qke.20.2020.07.31.13.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 13:26:22 -0700 (PDT)
Date:   Fri, 31 Jul 2020 16:26:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 0/4] upload-pack: custom allowed object filters
Message-ID: <cover.1596227003.git.me@ttaylorr.com>
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

Here's the third re-roll of my series to teach upload-pack to allow only
certain kinds of object filters. The only thing that has changed since
last time is that we now *do* look for the error messages in t5616.

Normally these error messages may or may not show up (because of the
aforementioned SIGPIPE issue in 'git clone'), but since we are cloning
from a 'file://', we can guarantee that they will appear (and can thusly
be grepped for).

Taylor Blau (4):
  list_objects_filter_options: introduce
    'list_object_filter_config_name'
  upload-pack.c: allow banning certain object filter(s)
  upload-pack.c: pass 'struct list_objects_filter_options *'
  upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'

 Documentation/config/uploadpack.txt |  18 +++++
 list-objects-filter-options.c       |  23 ++++++
 list-objects-filter-options.h       |   6 ++
 t/t5616-partial-clone.sh            |  33 +++++++++
 upload-pack.c                       | 105 ++++++++++++++++++++++++++++
 5 files changed, 185 insertions(+)

Range-diff against v2:
[...rebased on the tip of 'master']
 1:  6a77af563e = 80:  b1b3dd7de9 list_objects_filter_options: introduce 'list_object_filter_config_name'
 2:  6dbf58441d ! 81:  a0a0427757 upload-pack.c: allow banning certain object filter(s)
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil

     +test_expect_success 'upload-pack fails banned object filters' '
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=blob:none \
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
     +'
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil
     +	test_config -C srv.bare uploadpackfilter.combine.allow true &&
     +	test_config -C srv.bare uploadpackfilter.tree.allow true &&
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=tree:1 \
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
     +		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
     +'
     +
     +test_expect_success 'upload-pack fails banned object filters with fallback' '
     +	test_config -C srv.bare uploadpackfilter.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=blob:none \
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
     +'
    @@ upload-pack.c: static int process_deepen_not(const char *line, struct string_lis
     +{
     +	struct list_objects_filter_options *banned = banned_filter(data,
     +								   &data->filter_options);
    ++	struct strbuf buf = STRBUF_INIT;
     +	if (!banned)
     +		return;
     +
    -+	die(_("git upload-pack: filter '%s' not supported"),
    -+	    list_object_filter_config_name(banned->choice));
    ++	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
    ++		    list_object_filter_config_name(banned->choice));
    ++
    ++	packet_writer_error(&data->writer, "%s\n", buf.buf);
    ++	die("%s", buf.buf);
     +}
     +
      static void receive_needs(struct upload_pack_data *data,
 3:  bacdea47d9 = 82:  ad3f0cce56 upload-pack.c: pass 'struct list_objects_filter_options *'
 4:  79af94a41b ! 83:  c9d71809f4 upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
    @@ t/t5616-partial-clone.sh: test_expect_success 'upload-pack fails banned object f
     +	test_config -C srv.bare uploadpackfilter.tree.allow true &&
     +	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
    -+		"file://$(pwd)/srv.bare" pc3
    ++		"file://$(pwd)/srv.bare" pc3 2>err &&
    ++	test_i18ngrep "filter '\''tree'\'' not supported (maximum depth: 0, but got: 1)" err
     +'
     +
      test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
    @@ upload-pack.c: static int allows_filter_choice(struct upload_pack_data *data,
      }

     @@ upload-pack.c: static void die_if_using_banned_filter(struct upload_pack_data *data)
    - {
    - 	struct list_objects_filter_options *banned = banned_filter(data,
    - 								   &data->filter_options);
    -+	struct strbuf buf = STRBUF_INIT;
    - 	if (!banned)
    - 		return;

    --	die(_("git upload-pack: filter '%s' not supported"),
    --	    list_object_filter_config_name(banned->choice));
    -+	strbuf_addf(&buf, _("filter '%s' not supported"),
    -+		    list_object_filter_config_name(banned->choice));
    + 	strbuf_addf(&buf, "git upload-pack: filter '%s' not supported",
    + 		    list_object_filter_config_name(banned->choice));
     +	if (banned->choice == LOFC_TREE_DEPTH &&
     +	    data->tree_filter_max_depth != ULONG_MAX)
     +		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
     +			    data->tree_filter_max_depth,
     +			    banned->tree_exclude_depth);
    -+	die("%s", buf.buf);
    - }

    - static void receive_needs(struct upload_pack_data *data,
    + 	packet_writer_error(&data->writer, "%s\n", buf.buf);
    + 	die("%s", buf.buf);
     @@ upload-pack.c: static int parse_object_filter_config(const char *var, const char *value,
      	if (!strcmp(key, "allow"))
      		string_list_insert(&data->allowed_filters, buf.buf)->util =
--
2.28.0.rc1.13.ge78abce653
