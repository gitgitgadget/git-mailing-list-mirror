Return-Path: <SRS0=AzkS=BC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65299C433E0
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD152071A
	for <git@archiver.kernel.org>; Thu, 23 Jul 2020 01:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="BM//D9y2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387439AbgGWBs7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jul 2020 21:48:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733155AbgGWBs6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jul 2020 21:48:58 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8826EC0619DC
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:48:58 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id j10so3332201qtq.11
        for <git@vger.kernel.org>; Wed, 22 Jul 2020 18:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=H9VibOhVkU7Z7kYshygTUv/fwuAYdRXkmJu0SClBukU=;
        b=BM//D9y2N0ST2D9HXcCifDvICr8NLlZshWm4tFs5gbiD0jJngXvT/QAlyjb/FAYxm2
         /wYGF4esJzJyf2rLg7F75nGl5nvr/b2HcTSvO6CANwms7TAdAoVDzBrTUk7S6ZA6r7s5
         PFYNYjlcYNJxgyFB61TUMAp8R0U6Lc0pJXojQfe4zDL8OntoWbPMDBufL3ft8U6k5iLS
         e4y0l2MeyeZgvf82m7AnH/dpBy10oAxabyy0lyO3Qd7J37tt4iu4uBRNpBNv3Xo+M+L1
         VoDBGGanZsK5bsmYr+D03LQ45RdwSOexCzXy87i0GyXdqY/02Zaw9FE3YdK7piCxGB07
         cttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=H9VibOhVkU7Z7kYshygTUv/fwuAYdRXkmJu0SClBukU=;
        b=bDxeBMBZXWiAuE2c1FSS/qQfs4bP1EdvCFiIjPNuqAD02ktWiIHgYklaa5GOKuRqwi
         g+j0CIcCCz4ieb8ENC5E74elun1q5KGgASEiDGOI+yGYzRQwwztz4KpUH0Ad04wmv2Uu
         4yhHpvKlmPTMJBdyNHu6UUwxjKjjB+ReOC5g3bKCOtVBg8Hfc9nthgSbW2+I8640ZZiR
         ACnLy9S0LNRuxiBKjY7Orq/gPvSWcDtI4+0HdWM8uX2RCqcYPCbuI9EwtykxqMmlo69X
         c1QHMinIqBJVvesawlXcYt7uyby0kQAGbKZeVYodDNvrH39qB3nGdmHSSNUQLj4ok/tP
         McEQ==
X-Gm-Message-State: AOAM531EClPGWbrjo1l6VWWSWqFvcT3O3Ct//h468efgMm5xYC9JOOP+
        8akOw5+9A4yr0LSsRp9ydSSCbhxHYHUxTA==
X-Google-Smtp-Source: ABdhPJxaRcoJ2TFpEyE4icIo6bPljjTR6Z73XLbuo2wnw3xgP+v8+CWgYPpJm+Tt2rgT8Msz+oLTjw==
X-Received: by 2002:ac8:4e45:: with SMTP id e5mr2226035qtw.291.1595468937063;
        Wed, 22 Jul 2020 18:48:57 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:351c:83f3:acec:de38])
        by smtp.gmail.com with ESMTPSA id y22sm1258829qth.46.2020.07.22.18.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 18:48:56 -0700 (PDT)
Date:   Wed, 22 Jul 2020 21:48:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, chriscool@tuxfamily.org, gitster@pobox.com,
        szeder.dev@gmail.com
Subject: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <cover.1595468657.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here's a much-delayed v2 of my series to teach upload-pack to limit the
kinds of object filters that it is willing to server in a request.

Much is the same since last time, with two notable exceptions:

  - We use the 'uploadpackfilter' top-level configuration key instead of
    pretending that 'uploadpack.filter' is top-level, which greatly
    simplifies the call to 'parse_config_key()'.

  - Instead of writing an err packet, 'git upload-pack' simply 'die()'s,
    which propagates the error through 'git clone' always, and resolves
    a flaky set of tests that used to result in a SIGPIPE.

Thanks for your review in the meantime, and for encouraging me to send
this reroll now instead of later. Maybe I'll start unloading the rest of
my backlog tomorrow ;-).

Taylor Blau (4):
  list_objects_filter_options: introduce
    'list_object_filter_config_name'
  upload-pack.c: allow banning certain object filter(s)
  upload-pack.c: pass 'struct list_objects_filter_options *'
  upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'

 Documentation/config/uploadpack.txt |  18 +++++
 list-objects-filter-options.c       |  23 +++++++
 list-objects-filter-options.h       |   6 ++
 t/t5616-partial-clone.sh            |  32 +++++++++
 upload-pack.c                       | 103 ++++++++++++++++++++++++++++
 5 files changed, 182 insertions(+)

Range-diff against v1:
  2:  f0982d24e7 ! 134:  9fee52cb6d upload-pack.c: allow banning certain object filter(s)
    @@ Commit message
         Allow configuring 'git upload-pack' to support object filters on a
         case-by-case basis by introducing two new configuration variables:

    -      - 'uploadpack.filter.allow'
    -      - 'uploadpack.filter.<kind>.allow'
    +      - 'uploadpackfilter.allow'
    +      - 'uploadpackfilter.<kind>.allow'

         where '<kind>' may be one of 'blobNone', 'blobLimit', 'tree', and so on.

    @@ Commit message

         If a client requests the object filter <kind> and the respective
         configuration value is not set, 'git upload-pack' will default to the
    -    value of 'uploadpack.filter.allow', which itself defaults to 'true' to
    +    value of 'uploadpackfilter.allow', which itself defaults to 'true' to
         maintain backwards compatibility. Note that this differs from
         'uploadpack.allowfilter', which controls whether or not the 'filter'
         capability is advertised.
    @@ Documentation/config/uploadpack.txt: uploadpack.allowFilter::
      	If this option is set, `upload-pack` will support partial
      	clone and partial fetch object filtering.

    -+uploadpack.filter.allow::
    ++uploadpackfilter.allow::
     +	Provides a default value for unspecified object filters (see: the
     +	below configuration variable).
     +	Defaults to `true`.
     +
    -+uploadpack.filter.<filter>.allow::
    ++uploadpackfilter.<filter>.allow::
     +	Explicitly allow or ban the object filter corresponding to
     +	`<filter>`, where `<filter>` may be one of: `blob:none`,
     +	`blob:limit`, `tree`, `sparse:oid`, or `combine`. If using
     +	combined filters, both `combine` and all of the nested filter
    -+	kinds must be allowed.  Defaults to `uploadpack.filter.allow`.
    -++
    -+Note that the dot between 'filter' and '<filter>' is both non-standard
    -+and intentional. This is done to avoid a parsing ambiguity when
    -+specifying this configuration as an argument to Git's top-level `-c`.
    ++	kinds must be allowed. Defaults to `uploadpackfilter.allow`.
     +
      uploadpack.allowRefInWant::
      	If this option is set, `upload-pack` will support the `ref-in-want`
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil
      '

     +test_expect_success 'upload-pack fails banned object filters' '
    -+	# Test case-insensitivity by intentional use of "blob:None" rather than
    -+	# "blob:none".
    -+	test_config -C srv.bare uploadpack.filter.blob:None.allow false &&
    ++	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
     +	test_must_fail git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
     +'
     +
     +test_expect_success 'upload-pack fails banned combine object filters' '
    -+	test_config -C srv.bare uploadpack.filter.allow false &&
    -+	test_config -C srv.bare uploadpack.filter.combine.allow true &&
    -+	test_config -C srv.bare uploadpack.filter.tree.allow true &&
    -+	test_config -C srv.bare uploadpack.filter.blob:none.allow false &&
    ++	test_config -C srv.bare uploadpackfilter.allow false &&
    ++	test_config -C srv.bare uploadpackfilter.combine.allow true &&
    ++	test_config -C srv.bare uploadpackfilter.tree.allow true &&
    ++	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
     +	test_must_fail git clone --no-checkout --filter=tree:1 \
     +		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
     +'
     +
     +test_expect_success 'upload-pack fails banned object filters with fallback' '
    -+	test_config -C srv.bare uploadpack.filter.allow false &&
    ++	test_config -C srv.bare uploadpackfilter.allow false &&
     +	test_must_fail git clone --no-checkout --filter=blob:none \
     +		"file://$(pwd)/srv.bare" pc3 2>err &&
     +	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    @@ upload-pack.c: static int process_deepen_not(const char *line, struct string_lis
     +	if (!banned)
     +		return;
     +
    -+	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
    -+			    list_object_filter_config_name(banned->choice));
    -+	die(_("git upload-pack: banned object filter requested"));
    ++	die(_("git upload-pack: filter '%s' not supported"),
    ++	    list_object_filter_config_name(banned->choice));
     +}
     +
      static void receive_needs(struct upload_pack_data *data,
    @@ upload-pack.c: static int find_symref(const char *refname, const struct object_i
      	return 0;
      }

    -+static void parse_object_filter_config(const char *var, const char *value,
    ++static int parse_object_filter_config(const char *var, const char *value,
     +				       struct upload_pack_data *data)
     +{
    -+	struct strbuf spec = STRBUF_INIT;
    ++	struct strbuf buf = STRBUF_INIT;
     +	const char *sub, *key;
     +	size_t sub_len;
     +
    -+	if (parse_config_key(var, "uploadpack", &sub, &sub_len, &key))
    -+		return;
    -+	if (!sub || !skip_prefix(sub, "filter.", &sub))
    -+		return;
    ++	if (parse_config_key(var, "uploadpackfilter", &sub, &sub_len, &key))
    ++		return 0;
     +
    -+	if (sub != key)
    -+		strbuf_add(&spec, sub, key - sub - 1);
    -+	strbuf_tolower(&spec);
    -+
    -+	if (!strcmp(key, "allow")) {
    -+		if (spec.len)
    -+			string_list_insert(&data->allowed_filters, spec.buf)->util =
    -+				(void *)(intptr_t)git_config_bool(var, value);
    -+		else
    ++	if (!sub) {
    ++		if (!strcmp(key, "allow"))
     +			data->allow_filter_fallback = git_config_bool(var, value);
    ++		return 0;
     +	}
     +
    -+	strbuf_release(&spec);
    ++	strbuf_add(&buf, sub, sub_len);
    ++
    ++	if (!strcmp(key, "allow"))
    ++		string_list_insert(&data->allowed_filters, buf.buf)->util =
    ++			(void *)(intptr_t)git_config_bool(var, value);
    ++
    ++	strbuf_release(&buf);
    ++	return 0;
     +}
     +
      static int upload_pack_config(const char *var, const char *value, void *cb_data)
  3:  3434bd5979 = 135:  550e4e13f1 upload-pack.c: pass 'struct list_objects_filter_options *'
  4:  9fa765a71d ! 136:  bb008f7427 upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
    @@ Metadata
     Author: Taylor Blau <me@ttaylorr.com>

      ## Commit message ##
    -    upload-pack.c: introduce 'uploadpack.filter.tree.maxDepth'
    +    upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'

         In b79cf959b2 (upload-pack.c: allow banning certain object filter(s),
         2020-02-26), we introduced functionality to disallow certain object
    @@ Commit message

         While it would be sufficient to simply write

    -      $ git config uploadpack.filter.tree.allow true
    +      $ git config uploadpackfilter.tree.allow true

         (since it would allow all values of 'n'), we would like to be able to
         allow this filter for certain values of 'n', i.e., those no greater than
    @@ Commit message

         In order to do this, introduce a new configuration key, as follows:

    -      $ git config uploadpack.filter.tree.maxDepth <m>
    +      $ git config uploadpackfilter.tree.maxDepth <m>

         where '<m>' specifies the maximum allowed value of 'n' in the filter
         'tree:n'. Administrators who wish to allow for only the value '0' can
         write:

    -      $ git config uploadpack.filter.tree.allow true
    -      $ git config uploadpack.filter.tree.maxDepth 0
    +      $ git config uploadpackfilter.tree.allow true
    +      $ git config uploadpackfilter.tree.maxDepth 0

         which allows '--filter=tree:0', but no other values.

    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## Documentation/config/uploadpack.txt ##
    -@@ Documentation/config/uploadpack.txt: Note that the dot between 'filter' and '<filter>' is both non-standard
    - and intentional. This is done to avoid a parsing ambiguity when
    - specifying this configuration as an argument to Git's top-level `-c`.
    +@@ Documentation/config/uploadpack.txt: uploadpackfilter.<filter>.allow::
    + 	combined filters, both `combine` and all of the nested filter
    + 	kinds must be allowed. Defaults to `uploadpackfilter.allow`.

    -+uploadpack.filter.tree.maxDepth::
    ++uploadpackfilter.tree.maxDepth::
     +	Only allow `--filter=tree=<n>` when `n` is no more than the value of
    -+	`uploadpack.filter.tree.maxDepth`. If set, this also implies
    -+	`uploadpack.filter.tree.allow=true`, unless this configuration
    ++	`uploadpackfilter.tree.maxDepth`. If set, this also implies
    ++	`uploadpackfilter.tree.allow=true`, unless this configuration
     +	variable had already been set. Has no effect if unset.
     +
      uploadpack.allowRefInWant::
    @@ t/t5616-partial-clone.sh: test_expect_success 'upload-pack fails banned object f
      '

     +test_expect_success 'upload-pack limits tree depth filters' '
    -+	test_config -C srv.bare uploadpack.filter.allow false &&
    -+	test_config -C srv.bare uploadpack.filter.tree.allow true &&
    -+	test_config -C srv.bare uploadpack.filter.tree.maxDepth 0 &&
    ++	test_config -C srv.bare uploadpackfilter.allow false &&
    ++	test_config -C srv.bare uploadpackfilter.tree.allow true &&
    ++	test_config -C srv.bare uploadpackfilter.tree.maxDepth 0 &&
     +	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
     +		"file://$(pwd)/srv.bare" pc3
     +'
    @@ upload-pack.c: static void die_if_using_banned_filter(struct upload_pack_data *d
      	if (!banned)
      		return;

    --	packet_writer_error(&data->writer, _("filter '%s' not supported\n"),
    --			    list_object_filter_config_name(banned->choice));
    +-	die(_("git upload-pack: filter '%s' not supported"),
    +-	    list_object_filter_config_name(banned->choice));
     +	strbuf_addf(&buf, _("filter '%s' not supported"),
     +		    list_object_filter_config_name(banned->choice));
     +	if (banned->choice == LOFC_TREE_DEPTH &&
    @@ upload-pack.c: static void die_if_using_banned_filter(struct upload_pack_data *d
     +		strbuf_addf(&buf, _(" (maximum depth: %lu, but got: %lu)"),
     +			    data->tree_filter_max_depth,
     +			    banned->tree_exclude_depth);
    -+
    -+	packet_writer_error(&data->writer, "%s\n", buf.buf);
    -+
    -+	strbuf_release(&buf);
    -+
    - 	die(_("git upload-pack: banned object filter requested"));
    ++	die("%s", buf.buf);
      }

    -@@ upload-pack.c: static void parse_object_filter_config(const char *var, const char *value,
    - 				(void *)(intptr_t)git_config_bool(var, value);
    - 		else
    - 			data->allow_filter_fallback = git_config_bool(var, value);
    -+	} else if (!strcmp(spec.buf, "tree") && !strcmp(key, "maxdepth")) {
    -+		string_list_insert(&data->allowed_filters, "tree")->util
    -+			= (void *) (intptr_t) 1;
    + static void receive_needs(struct upload_pack_data *data,
    +@@ upload-pack.c: static int parse_object_filter_config(const char *var, const char *value,
    + 	if (!strcmp(key, "allow"))
    + 		string_list_insert(&data->allowed_filters, buf.buf)->util =
    + 			(void *)(intptr_t)git_config_bool(var, value);
    ++	else if (!strcmp(buf.buf, "tree") && !strcmp(key, "maxdepth")) {
    ++		if (!value) {
    ++			strbuf_release(&buf);
    ++			return config_error_nonbool(var);
    ++		}
    ++		string_list_insert(&data->allowed_filters, buf.buf)->util =
    ++			(void *)(intptr_t)1;
     +		data->tree_filter_max_depth = git_config_ulong(var, value);
    - 	}
    ++	}

    - 	strbuf_release(&spec);
    + 	strbuf_release(&buf);
    + 	return 0;
--
2.28.0.rc1.13.ge78abce653
