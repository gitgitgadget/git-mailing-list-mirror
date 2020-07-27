Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD7BC433EC
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 14:25:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D89A2083B
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 14:25:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="OCA/B6ty"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731441AbgG0OZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 10:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732390AbgG0OZP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 10:25:15 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0005FC0619D5
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 07:25:14 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id l23so15397777qkk.0
        for <git@vger.kernel.org>; Mon, 27 Jul 2020 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8o6xxPLx+Qhe6CAx1om6PFV9E75Qr6BYg1JlGpXW0kU=;
        b=OCA/B6tyYD9jBIyBSOZrWznH4bTPnekijnvD07luZ2Wihh1ZA2a1ue/d0uHQflIp0D
         HzzHA0XlRGgeyEmyx1I+gj9ukxWvc873ijuu1E/rGHKzGxA0UkYO0Blll/jfh/2kpY+O
         IFXb1VTdh5umBmuJGyxJXIxRhItOgYHGKx7CP7H0rnZuFbVgLmM0hbNXv0JevhwYAiEe
         40chZMsJgRgvgEa045q7E9DwxWzVGcvwMUZntPqe93frqUS0EuYo4SDw/ZMfpr2igxwr
         jO7iUJELYr9nFQ+08AlQHX4gEk6NzqQGgWM5OfdKWqLoy7aBGuDNHGRRKYsojEzru86Z
         cctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8o6xxPLx+Qhe6CAx1om6PFV9E75Qr6BYg1JlGpXW0kU=;
        b=bZlZcRBCmA7PErsgT7msVZXboUAFBdzGqRxnoD9Ii064YEAMJ2PRjMwC8cJWlgOAR6
         ejA4+CpGpdg8RaZnMTfF+rTqbTAD2QrU38Ch/Lvf+oJ3RiWHViPJeLBrPzSDIqc2IlnG
         aQltEsImSMgrGddcWZFoOL6OA/a5RjAvvAt2QLq3fuYpqACX9s73f3EDNa1PY1Qbo+TO
         T/cnOodRwrjldtDBr/ujgAVJRKy8tY5vGXBqahgsEs2p40279QGDeV0WC+fGhGlRGzre
         hOx5BAVcaLwv/2XdcA6bIl10aZrc50kZiCTP5Ws+eoA4Ev2je8dH9yNsVJZyB9P+TPFD
         2Ekg==
X-Gm-Message-State: AOAM531Z8laUc/rWmb355cpS9ZwBf90wPImLWGoEy/5bDuVdc/lGvCCz
        aZwdp4H+9zyHrtt+9AjNbyhB5gL33P+o7w==
X-Google-Smtp-Source: ABdhPJzNRCvYFN3QrKhkmqUir7bqOMvzBJhKFYfwP6Oe2puM6vatYmN0F84sJsvKCqbH6WqXFN+e2A==
X-Received: by 2002:a37:7b83:: with SMTP id w125mr22693069qkc.6.1595859913886;
        Mon, 27 Jul 2020 07:25:13 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:9c58:8530:481a:f835])
        by smtp.gmail.com with ESMTPSA id 9sm2305536qtg.4.2020.07.27.07.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 07:25:12 -0700 (PDT)
Date:   Mon, 27 Jul 2020 10:25:11 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727142511.GA62919@syl.lan>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
 <20200724195126.GB4013174@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200724195126.GB4013174@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 24, 2020 at 03:51:26PM -0400, Jeff King wrote:
> On Fri, Jul 24, 2020 at 12:51:33PM -0400, Taylor Blau wrote:
>
> > Let me double check my understanding... I think that you are suggesting
> > the following three things:
> >
> >   - Write the same message as an err packet over the wire as we do when
> >     'die()'ing from inside of upload-pack.c
> >
> >   - Don't mark said message(s) for translation, matching what we do in
> >     the rest of upload-pack.c.
> >
> >   - Re-introduce the 'test_must_fail ok=sigpipe' and stop grepping
> >     stderr for the right message.
> >
> > Do I have that right?
>
> I'm not Gábor, but that is the sequence I think is best.
>
> Between the die() and the ERR, the ERR packets are way more useful in
> practice, since they actually go back to the client. I'd even suggest we
> do away with the die() messages entirely (since they're either redundant
> or go nowhere, depending on the protocol), but I think it would make
> sense to wait until the raciness issues are fixed (until then, they
> _might_ help in the redundant cases, which is what the test here is
> relying on).

All sounds good. I'll wait for an ACK from Gábor to make sure that this
is the direction that they want, too.

In the meantime, this is what I have locally. I'll send a series which
has this as its range-diff if Gábor approves of the direction.

1:  6a77af563e = 1:  6a77af563e list_objects_filter_options: introduce 'list_object_filter_config_name'
2:  6dbf58441d ! 2:  80d19481d8 upload-pack.c: allow banning certain object filter(s)
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil

     +test_expect_success 'upload-pack fails banned object filters' '
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=blob:none \
    -+		"file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
    ++		"file://$(pwd)/srv.bare" pc3
     +'
     +
     +test_expect_success 'upload-pack fails banned combine object filters' '
    @@ t/t5616-partial-clone.sh: test_expect_success 'implicitly construct combine: fil
     +	test_config -C srv.bare uploadpackfilter.combine.allow true &&
     +	test_config -C srv.bare uploadpackfilter.tree.allow true &&
     +	test_config -C srv.bare uploadpackfilter.blob:none.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=tree:1 \
    -+		--filter=blob:none "file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=tree:1 \
    ++		--filter=blob:none "file://$(pwd)/srv.bare" pc3
     +'
     +
     +test_expect_success 'upload-pack fails banned object filters with fallback' '
     +	test_config -C srv.bare uploadpackfilter.allow false &&
    -+	test_must_fail git clone --no-checkout --filter=blob:none \
    -+		"file://$(pwd)/srv.bare" pc3 2>err &&
    -+	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    ++	test_must_fail ok=sigpipe git clone --no-checkout --filter=blob:none \
    ++		"file://$(pwd)/srv.bare" pc3
     +'
     +
      test_expect_success 'partial clone fetches blobs pointed to by refs even if normally filtered out' '
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
3:  bacdea47d9 = 3:  790552c7c2 upload-pack.c: pass 'struct list_objects_filter_options *'
4:  79af94a41b ! 4:  eb9a81eb1f upload-pack.c: introduce 'uploadpackfilter.tree.maxDepth'
    @@ Documentation/config/uploadpack.txt: uploadpackfilter.<filter>.allow::

      ## t/t5616-partial-clone.sh ##
     @@ t/t5616-partial-clone.sh: test_expect_success 'upload-pack fails banned object filters with fallback' '
    - 	test_i18ngrep "filter '\''blob:none'\'' not supported" err
    + 		"file://$(pwd)/srv.bare" pc3
      '

     +test_expect_success 'upload-pack limits tree depth filters' '
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

> -Peff

Thanks,
Taylor
