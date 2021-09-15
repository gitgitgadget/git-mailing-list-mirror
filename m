Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12C50C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:16:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D931160FED
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 04:16:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbhIOERZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 00:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhIOERY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 00:17:24 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B5C061574
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:16:06 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id m11so1729617ioo.6
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 21:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HxbDTVJ35zZNxn/KaeFALucfFIFEr9nAaB/4fKs80sY=;
        b=EPjGaAt7Jmse5WWHXxg21RN7jo65Iy9OdsYv1MGZ4mROzci7IUo9NZWwgdTwdQqZPn
         /t+SmWzm0d6RLl9uqOf69sO3D3HN0HqKr0J7ItoeED3RdvOt74tXgfSjJbLJBZi+3Gj5
         ujEgPgA0oP1nemw33Y/xtDgnA088XD+4qgpCG9Y/r4mpISrBTyv7XARA9TVVGqv3s+ZC
         tPLeSmnDEmO945WhGisPJjszKtvDb7FBgDAG91a+q4byYIg0uXWoZuUZ5v2eVgwy8b/F
         dhQNAY32BKiIvtK9v1cl8qA5Kk5mFxhpNdJ9KSvlhIal+WRZxZ+xbSpE4BzMnfuzCLg0
         H8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HxbDTVJ35zZNxn/KaeFALucfFIFEr9nAaB/4fKs80sY=;
        b=5EtcfcQUVC2n+nJPIfx/Rz+SzRlK44+7nJy9iWxXpuOGVgsFng4aynp5+m3RKht+jV
         XCvxx5FIITdTHrpvg4j2OPHclmmZ6wg06bqcNE3e8TrotM5vM0ehBFiqfWlGcbjnDGB+
         4bIOh9E6TbpXM5RELveVszENO3taJaGkBFBF6wNpbZYnOaqx9x3qu/qfL8Ulvwxx5xZi
         QrXKlVH4pASn+mqdLswZv/VWrRQca50GGOVTiAWXi7ykndHtHL8uGbrEP3MPicx1Tzvj
         oDK9u0kKu1xX3By5/H8WZjVDNNdB7tjxt47oucke6shECGfq6bWvJdmYmbcSI4+GSo24
         eAYg==
X-Gm-Message-State: AOAM533Hc2/Vc/mBvTmgD8+hQF1WwIw1/6R4pnBxGH8Cre92emX+Ri8P
        J9jICHgWINYifVp/E9xQ8OYuew==
X-Google-Smtp-Source: ABdhPJzDv1ifIPTsslBUi+z6z/3JFmOu5dvuSlSc1EpbPrGITyh9bnS4gwf2FZg+9Nv5fbu0twHbSQ==
X-Received: by 2002:a6b:7b4b:: with SMTP id m11mr16446565iop.165.1631679365625;
        Tue, 14 Sep 2021 21:16:05 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15sm8150896ila.34.2021.09.14.21.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 21:16:05 -0700 (PDT)
Date:   Wed, 15 Sep 2021 00:16:04 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 07/11] ls-refs: ignore very long ref-prefix counts
Message-ID: <YUFzhC5Eox8IND4O@nand.local>
References: <YUE1alo58cGyTw6/@coredump.intra.peff.net>
 <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YUE1hz/KKM0XebCP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 07:51:35PM -0400, Jeff King wrote:
> @@ -156,15 +162,25 @@ int ls_refs(struct repository *r, struct packet_reader *request)
>  			data.peel = 1;
>  		else if (!strcmp("symrefs", arg))
>  			data.symrefs = 1;
> -		else if (skip_prefix(arg, "ref-prefix ", &out))
> -			strvec_push(&data.prefixes, out);
> +		else if (skip_prefix(arg, "ref-prefix ", &out)) {
> +			if (data.prefixes.nr < TOO_MANY_PREFIXES)
> +				strvec_push(&data.prefixes, out);
> +		}
>  		else if (!strcmp("unborn", arg))
>  			data.unborn = allow_unborn;
>  	}
>
>  	if (request->status != PACKET_READ_FLUSH)
>  		die(_("expected flush after ls-refs arguments"));
>
> +	/*
> +	 * If we saw too many prefixes, we must avoid using them at all; as
> +	 * soon as we have any prefix, they are meant to form a comprehensive
> +	 * list.
> +	 */
> +	if (data.prefixes.nr >= TOO_MANY_PREFIXES)
> +		strvec_clear(&data.prefixes);
> +

Great, I find this version even better than what I suggested where the
case where the list already has too many prefixes `continue`s through
the loop before calling strvec_add().

Just noting aloud, the `>` part of this conditional will never happen
(since data.prefixes.nr will be at most equal to TOO_MANY_PREFIXES, but
never larger than it).

Obviously not wrong, but I figured it'd be worth mentioning in case it
caught the attention of other reviewers.

Thanks,
Taylor
