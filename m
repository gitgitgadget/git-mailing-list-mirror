Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 761CBC4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232673AbiKGTwI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:52:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbiKGTwH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:52:07 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1CE91D0DE
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:52:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id p184so9762059iof.11
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=E/MBeo3EkMoPCKTLTvvZFK+6NymT9lV9E8s2MXH1+SU=;
        b=YSHnUQZJBgFATq2ms3xdjdzdBXq/yGr0L9TwrCkIB1y6MMTZyh9BZwTsrG8pnv0nZS
         X+OJWN3wepgrbxABJWcxZBuA/j9m8HQPmAZ+pynIE4+4h09ZmszzJdH0/bUDLrZ9lMvf
         Jvb2LuWcnIBtXG+a8AsfZdtxASEQQ1CtSItH22jbvXvb/sHazaIx6viIEIQwrMT/LL0X
         zC+9/u847rp5NJBidmPciQicd8vrg9b3CkjjD2ySLDTUfzGDONMeUWnaXeftlmkbMEzW
         6n95sTtkhXB4nRvn7XtlWjQDAM2mYkSrbvO38Vt3bzFVfennBcbBYSz4AYToWmw0BJUc
         9mPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/MBeo3EkMoPCKTLTvvZFK+6NymT9lV9E8s2MXH1+SU=;
        b=jCQjThnzrtMRt49oJ6n5VuhI3TRpMHT3HMWQ0SXnprd9Gfywh2/hklUATywGRowcA0
         72wmnincQVh0KTSGqWxiq1y6j9l95LJABAuFVsYqGljl2bmXDcaZHXEMg2BNoZ+lIGba
         KWfYmIzu9vo0P91Qjg39muiUEEVesDiJPKNIM8VsC0JvOlohB7lIpjUHAZyp5DPYSVCd
         dD6HV+44JMIMKZr/F88srvYbHYZEtHSilTxoU5lmQzcr7E2YDozzAR9xnQQENQzwtabI
         vx1WrKYR+jymXrcQIvYlaCzy8/16oEVaUWSps71E5HK4rnYLPwmrZGWm4H47oKXKIAyF
         d0ng==
X-Gm-Message-State: ACrzQf28FzdXNSZYj5Do1OHrK7nO/BRT6zNe68VXgY/d2GaHTMBH7sw8
        SBgpScGuf/GNWgSQKehIeDU++A==
X-Google-Smtp-Source: AMsMyM7lIybE4zWEL8oY61sZtO2qqg0t0cmM082vh3miFByhyRM/QazhR5xDWUb31Argr4v6wkdqFg==
X-Received: by 2002:a05:6602:1244:b0:6a1:5d00:cf45 with SMTP id o4-20020a056602124400b006a15d00cf45mr657027iou.16.1667850726103;
        Mon, 07 Nov 2022 11:52:06 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n7-20020a92d9c7000000b00300bd581944sm3112796ilq.25.2022.11.07.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 11:52:05 -0800 (PST)
Date:   Mon, 7 Nov 2022 14:52:04 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
Message-ID: <Y2lh5HargaEQrgy+@nand.local>
References: <cover.1666636974.git.me@ttaylorr.com>
 <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
 <2c59cbca-05fb-8aef-a671-61b4a463a368@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2c59cbca-05fb-8aef-a671-61b4a463a368@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2022 at 02:32:05PM -0500, Derrick Stolee wrote:
> On 10/24/22 2:43 PM, Taylor Blau wrote:
> > @@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
> >  		if (line.len != the_hash_algo->hexsz)
> >  			die(_("repack: Expecting full hex object ID lines only "
> >  			      "from pack-objects."));
> > -		string_list_append(names, line.buf);
> > +                /*
>
> This line looked oddly out-of-alignment with the next one.
>
> It seems that the comment is preceded by spaces and not
> tabs. Perhaps Junio fixed this during his application of
> the patch to keep the builds happy.

Odd. In my copy, which I got from gitster/git before Junio went offline,
the alignment looks fine.

Thanks for double checking, though.

Thanks,
Taylor
