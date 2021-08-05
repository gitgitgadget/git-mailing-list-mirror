Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590DC4338F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9856E60EB2
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 01:26:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237363AbhHEB1C (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 21:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbhHEB1A (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 21:27:00 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8216AC061765
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 18:26:47 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id m13so4716973iol.7
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 18:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=cms208Y3znQf/tovAAooWp/vn9Y+b0GSl4lRJM8RoCc=;
        b=S6YCu1BsMPLBLCj59HBtbLRTQTvi8RAzZjtEWM47fonpweaET08o/zI6Y6R6dMRm72
         rp9EjlnwoUhzJXQW6DliaUsUjJ8kaKxPL30vK0XsbZrOt299wQ5h7Rxsi4h7EazpPE5K
         HlidTycLEYJT8JE1jx6VSItJxEiNfcXM7Nt1r8H25qcuKfAgpSiZ1CN0fj1jNI6z7TNa
         9TnJqtxeeyicK3qugUsuVrujGkuzZv3hhv9YQzkwk/wdEmPzNA/KWuLjzHo+bdKWQkNU
         p2hRrtH4m/SBM7m3cmL1DDViNbp0h9wYQg+6siuFa93xFWrD8rVrjDeXLGzyQsiVMLVB
         YHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=cms208Y3znQf/tovAAooWp/vn9Y+b0GSl4lRJM8RoCc=;
        b=AXRn0CJ0193QjsIWWb+y0qi5PVl3QG9IUaVTwBQAZDRYrg735tRq+GNiZXDccI5QwE
         ol/wY+VaWFu8GGmgHEKJLuFwIWCSLu3Gq2Qo2HtiGsZkPvJ6dQlAfnVvEdhUOwBCRLOP
         5fOIsXyk2E5DI7EMPRJPg5GfZv6kiFTT/m5X+V2koTi62yfo22N4Td6UJoHNx4VmEyIn
         Z0FCSYBipVCJfepbfVYP8h7N1FT/lM4p6m0+7x1iHN44Jx+rnv3suYGAnpJaoD7Q1/1/
         MR97uqe7xIsqYx8svOVivNW2raooURzLw/doxmQXMH9DCDAZ/mzRPV/lpv9IuAyAVPtD
         hiJA==
X-Gm-Message-State: AOAM533BOhFcY+/2rvTQlptwBL5pEggoItnaRvoEjxYe1Ag1SJ7eK5Uw
        j2f9wahz4H8bLqICcCWq1VprGw==
X-Google-Smtp-Source: ABdhPJzv6QRUqgnWPw67mDqpxuGNDfBgqPvFUK1NsStblu5urp7CZ/tvSFw3qL4y1afyp74aW1hItA==
X-Received: by 2002:a02:1cc5:: with SMTP id c188mr1674751jac.46.1628126807001;
        Wed, 04 Aug 2021 18:26:47 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:dd9c:1551:d5f7:652c])
        by smtp.gmail.com with ESMTPSA id q1sm2607136ioi.42.2021.08.04.18.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 18:26:46 -0700 (PDT)
Date:   Wed, 4 Aug 2021 21:26:45 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
Message-ID: <YQs+VQIYDO3pkCNS@nand.local>
References: <cover.1628115064.git.steadmon@google.com>
 <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
 <87a6lwn52u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6lwn52u.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 05, 2021 at 01:40:51AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
> On Wed, Aug 04 2021, Josh Steadmon wrote:
>
> > It is useful for performance monitoring and debugging purposes to know
> > the wire protocol used for remote operations. This may differ from the
> > version set in local configuration due to differences in version and/or
> > configuration between the server and the client. Therefore, log the
> > negotiated wire protocol version via trace2, for both clients and
> > servers.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
>
> I know Taylor asked you to change it to a string from in int upthread in
> <YQmxSxTswHE/gTet@nand.local>, but I really don't see the point. But am
> willing to be convinced otherwise.

The conversion to log a string instead of an integer is necessary if
Josh wants to write "<unknown>" instead of -1. To me, that seemed
clearer, and I like that it makes the trace2 representation for a
protocol version separate from the protocol_version enum.

> It seems to me that both of these codepaths will never usefully use this
> new "UNKNOWN_VERSION" string you added, i.e.:
>
> >  connect.c                             |  3 +++
> >  protocol.c                            |  3 +++
> >  t/t5705-session-id-in-capabilities.sh | 12 ++++++++++++
> >  3 files changed, 18 insertions(+)
> >
> > diff --git a/connect.c b/connect.c
> > index 70b13389ba..5f0e113625 100644
> > --- a/connect.c
> > +++ b/connect.c
> > @@ -150,6 +150,9 @@ enum protocol_version discover_version(struct packet_reader *reader)
> >  		break;
> >  	}
> >
> > +	trace2_data_string("transfer", NULL, "negotiated-version",
> > +			   format_protocol_version(version));
>
> Right after this.
>
> >  	switch (version) {
> >  	case protocol_v2:
> >  		process_capabilities_v2(reader);
>
> We'll die here with BUG("unknown protocol version") if it's unknown..

Good eyes. In fact, the second switch statement shouldn't even need a
case-arm for protocol_unknown_version (but has it to cover all
enumerated values).

I didn't realize before that the unknown case really is dead code, so
we'll never log "<unknown>". And since the mapping from protocol_version
to string is identical for known values, we could probably do without
it.

And I don't much care either way. I think the benefit is really pretty
slim, and arguably my code is just adding unnecessary overhead. So I'm
happy to go with or without it, but I'd be rather sad to spend much more
of our collective time discussing it.

Thanks,
Taylor
