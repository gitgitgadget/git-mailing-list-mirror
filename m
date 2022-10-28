Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30984C38A02
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:42:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbiJ1Tmx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiJ1Tmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:42:50 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 301E8228CEA
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:42:49 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id p141so5457854iod.6
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=11OHZGCRF01z0J5x7pKNXZkgJFoBB/ut0nHmm+MLZWo=;
        b=d7e+1/PIUMPSMG2xGeeaGGbWQcuZLO1MqYHcaOiZrU5pEUK1oaeaxkJlZLZltVz0se
         QKqvCmteIbfxHN7rMpQanM/KP/ixPJe3zT7p+a7ScLkkrPq4gjOgaV/Qo7JsVcFQaRf8
         a9LvGcduISv22upnoVqYUKPrpRulWPMPOcp2MwLa62MFLmrJ1EGOFN4dQ1CW2XXBZ0Mr
         V//9lWy4VpY8QMc1Bmn2qrxrF5XBnNpQxCqUuBGJUi87SgUOh+IwquQd0nHQgmdCj2d1
         PgluByd8TEBNwv/ILUJjqFCyubZqR3soIiq4v+yE1s4EOOA/4NYZAOnRew9VTmaf1M4I
         mSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11OHZGCRF01z0J5x7pKNXZkgJFoBB/ut0nHmm+MLZWo=;
        b=ipPSah4S7P3qlRh0W7zkiVKQhwZgfqwKTTEidmJiJBPAFQ92z3AMDpWDkLe+ldS9cN
         698aJWJmKdKaIbr4Dj/IUI5jj6L954ZAceKppJD1Zvf1d9SC1kwxRSQFSLXhtl4oLohd
         I0jYZfsoV6WOfLjCm75UYmmJywwnaewMRuXoTigUrLtrpDCVXCdFXW1w4VcecxxdCD5s
         39yuxWKT18U9PHs2TmVI0a/WVleabUxmx4G0kwsTkF8UZWLiwl9ogWiwF1h3erqQ+JyN
         vcqhmHp7dNAjrb+hIOPMfJ+HmIMSy+3R8ffE9OwXUAx027M9FEMhETPrE3ZDD8wSaDAh
         rsuQ==
X-Gm-Message-State: ACrzQf0/thIyOhXH2T3/6hLiZVqlHDUZDDKMWPbog0VvRUcgjZ1KzRdH
        2RV1vCdU2KvtLEpX8I6hjda1lgJ9S8D9x5qJ
X-Google-Smtp-Source: AMsMyM6jrfX3AKIvgDeJVtq1v9ZAn2aViVaZV2WlxBPg1BATRAgYWLO5//OKZf290tUF+aYnPRui4Q==
X-Received: by 2002:a6b:2ad5:0:b0:6c5:da79:4caf with SMTP id q204-20020a6b2ad5000000b006c5da794cafmr597132ioq.158.1666986168556;
        Fri, 28 Oct 2022 12:42:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id b10-20020a05660214ca00b0067ba7abc4cesm1998294iow.50.2022.10.28.12.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:42:48 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:42:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Victoria Dye <vdye@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/4] builtin/repack.c: write cruft packs to arbitrary
 locations
Message-ID: <Y1wwt0H9JXFsE0Yn@nand.local>
References: <cover.1666636974.git.me@ttaylorr.com>
 <c0f4ec92a057fdab905447bb917ff09e9bcaaab3.1666636974.git.me@ttaylorr.com>
 <xmqq1qqwsyd2.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qqwsyd2.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 24, 2022 at 02:30:49PM -0700, Junio C Hamano wrote:
> > -	prepare_pack_objects(&cmd, args, packtmp);
> > +	prepare_pack_objects(&cmd, args, destination);
> >
> >  	strvec_push(&cmd.args, "--cruft");
> >  	if (cruft_expiration)
> > @@ -714,7 +717,12 @@ static int write_cruft_pack(const struct pack_objects_args *args,
> >  		if (line.len != the_hash_algo->hexsz)
> >  			die(_("repack: Expecting full hex object ID lines only "
> >  			      "from pack-objects."));
> > -		string_list_append(names, line.buf);
> > +                /*
> > +		 * avoid putting packs written outside of the repository in the
> > +		 * list of names
> > +		 */
> > +		if (local)
> > +			string_list_append(names, line.buf);
> >  	}
>
> Even if we do not want to contaminate the "names" list with packs
> that are not in the repository, wouldn't our caller still want to be
> able to tell what packs they are?
>
> What I am wondering is if it makes more sense to have the caller
> pass &names (which can be NULL to just discard the output from the
> pack-objects command) so that this function can concentrate on what
> it does (i.e. formulate the command to write cruft packs and then
> report the packs that are created), without having to worry about
> the management of the &names thing, which can be done by the caller
> of this function?  We are already passing &names, so it may be the
> matter of caller deciding to pass &names or NULL based on the value
> of destination it passes to the function?

It would be nice if it were possible to avoid passing `names` entirely
here, but we still need it to determine the set of packs we already
wrote a few lines above when we write the input to `pack-objects --cruft`.

Thanks,
Taylor
