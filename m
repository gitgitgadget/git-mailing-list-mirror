Return-Path: <SRS0=aDBb=CX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CCF3C43461
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 11:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE62F208DB
	for <git@archiver.kernel.org>; Mon, 14 Sep 2020 11:06:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGWEeW6R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbgINLGt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Sep 2020 07:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbgINLGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Sep 2020 07:06:47 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1AFC06174A
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 04:06:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id f142so16341243qke.13
        for <git@vger.kernel.org>; Mon, 14 Sep 2020 04:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=o4hBwCHNZyGCPfeVFRnzzCJ7JB5N0E/HYRh1wlCurYw=;
        b=FGWEeW6R1OIB5k3gvVZxqSlxrZrxiY/JHwVLh+1YJYugPIuc0otipJRR9i6hv6WKfl
         GhLOrU72dK/FftBpdfnFoKIVmyEFc1aqIFmaVBgrOfcoJaKqVtGw396iERb00xZ0EbOI
         C9GUOgKnq7HdY9A1Sk8n1D4YOKw3vec0/SCtJdeTJ5N4K0GuGsg3R+jSvUB+6jXwsRwe
         WoEPbmlFD31V4C4dgz/bcXJwuL45ckINRdW/PIgMnjxvbvjydwaVbzZcbnXSkxZ0wNSo
         ZfBf7hTSGs8FTmPKKuTZtgy7VuhJkjVa5hWQ7HQ/ukRShix1n6Se7E/IwJKf3Z9CAUzW
         doCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=o4hBwCHNZyGCPfeVFRnzzCJ7JB5N0E/HYRh1wlCurYw=;
        b=Pm88VWEfAM8KY7ZL68Fjthg/IxEpy09RsyNcNiVwyC8ftDoQp6Gk3bdy5ixfdUAegA
         2H9goz7fQ5M605ODY/K7i1P9kPl3XO3DsejiK/gnA2V6PQmxQC8Q/B145aMWV2rKO7zH
         M5HdF56Ye8Y7eM7/pXHa7679uSegWIv/GLLLRsl6/5y03nDJE1DTu/Bzzu4uuJxGT9sY
         cSYrNpAI6vHlJZiRxR6++ivxsYCsFToq7F2cJuDs1nIyjqBOIv3Uj6zaq87nM0po70Z9
         Spc/wRKT68XLk+pP74UfpIVJmjuXL5fOCo5uhEH6sRcJhmkViyjmhF5kPFHFCw+Twdr7
         fJhg==
X-Gm-Message-State: AOAM532PCuF5HD266Q+stVSK9u0JYM0i7gRsuLobTe6e7P/w/y/YAV8x
        9MGCpIMTPcqGKEM221EkF8LjvYd+fsV8tyh6
X-Google-Smtp-Source: ABdhPJywJUjcqzyohttfoA6DAfbpC2ZDl1q9+4atqZdOXPQLsfO8D/hQC0UT9ivZlgdUoGBONabuKg==
X-Received: by 2002:a37:ef05:: with SMTP id j5mr11719441qkk.456.1600081605763;
        Mon, 14 Sep 2020 04:06:45 -0700 (PDT)
Received: from mail.clickyotomy.dev ([124.123.104.38])
        by smtp.gmail.com with ESMTPSA id j6sm13000103qtn.97.2020.09.14.04.06.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2020 04:06:45 -0700 (PDT)
Date:   Mon, 14 Sep 2020 16:36:38 +0530
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] push: make `--force-with-lease[=<ref>]` safer
Message-ID: <20200914110638.GA32876@mail.clickyotomy.dev>
References: <20200904185147.77439-1-shrinidhi.kaushik@gmail.com>
 <nycvar.QRO.7.76.6.2009072119350.56@tvgsbejvaqbjf.bet>
 <xmqqr1rcxdsu.fsf@gitster.c.googlers.com>
 <nycvar.QRO.7.76.6.2009090542430.54@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2009101220400.56@tvgsbejvaqbjf.bet>
 <20200910144456.GA25125@mail.clickyotomy.dev>
 <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2009120013070.56@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Johannes,

On 09/12/2020 00:16, Johannes Schindelin wrote:
> > + static int oid_in_reflog_ent(struct object_id *ooid, struct object_id *noid,
> > +			     const char *ident, timestamp_t timestamp, int tz,
> > +			     const char *message, void *cb_data)
> > + {
> > +	struct object_id *remote_oid = cb_data;
> > +	struct commit *a = lookup_commit_reference(the_repository, noid);
> > +	struct commit *b = lookup_commit_reference(the_repository, remote_oid);
> > +	return oideq(noid, remote_oid) || in_merge_bases(b, a);
> > + }
> 
> Since `in_merge_bases()` is quite a bit more expensive than `oideq()`,
> personally, I would actually walk the reflog with the `oideq()` check
> first (stopping early in case a match was found), and only fall back to
> looking for a merge base in the reflog if the first reflog walk did not
> find a match.

Thanks for the suggestion; the updated the patch set (v3) - [1] does
something similar to that, along with some other changes. Can you please
take a look?

[1]: https://public-inbox.org/git/20200913145413.18351-2-shrinidhi.kaushik@gmail.com/

Thanks.
-- 
Srinidhi Kaushik
