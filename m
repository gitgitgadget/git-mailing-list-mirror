Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E82EC433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:41:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0BAE422B45
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 21:41:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkz1lFTJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728710AbgHDVl3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 17:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727092AbgHDVl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 17:41:28 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15424C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 14:41:28 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id z14so7707411ljm.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 14:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=gKh97oSNE242feTlK1SsL54qeyMaAk1pv/cEjpLH2bY=;
        b=Tkz1lFTJd0TEIw1ezAE8QHWPL5Vyk9VDA+mK4IM31e0sNGC3Pxt1lXvfWw1degbC2y
         POoBPd1Vq9Zke3e95ljLeB1lXHnQ09Ss6gRukH52OUtSVygysl/eNd3YMp4+EkDrlDdw
         zkRGWGgrhsZ+OlcvHESS5slgtOEe5IQhOLBOCZ2czpwITHJBPpMPLAH/spgIvgnC2daP
         4JBMbDoCwnth9zkfZ64YoviFb3xBiMkJQmMkYWH+PdPEIVngjQNc/HthYAqnwehal2xV
         WD+ZsZszGtLKjOS3ZgYV7M47rTBdK8dDqv7TwsvAxwy3JeJWhqHmd/BOY4HVRAhebxJ0
         QaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=gKh97oSNE242feTlK1SsL54qeyMaAk1pv/cEjpLH2bY=;
        b=P/BJLCRYp8bGOBEOWd6w1GNu++Gas+OCU1Q5sCA04eEWm/5MpwXE/txzAYDMA3DDpF
         fzi8GYmKNKJcP0NEYaJk40pB5cIR7nvfGwWQQkJY3bhW5gbzwELx8SpRlJ7xo80Xx73o
         g3HZ7Q/FAfHBM7NoSq3C2vjJBeSAR3MHgpYAPL+T2e2ia+WFGSh8m2U5YuL4/rFGLCj2
         9xYfpUxLNej4FHicxFi+aio4EESj90FnI50XRoY4ZRHCQwaDVpXIfz81L7G56uRScME5
         7FyJ57agSOj8b+PeYVrZRakfPj9GCAzMtvnlkQSpjooS7pYizOWLQt7JZptrDfVM64P9
         7x4w==
X-Gm-Message-State: AOAM533+IM6i6q3bXYEnZjBAm/P1dQ8aL6mU9p9dRMeiUnKoyo5+7Jva
        sXsZM3iZajdAGB/K6HAAf9c=
X-Google-Smtp-Source: ABdhPJyuWqRB1LCSU4mfphwpaGvG2+4+oegPMxE5Ib9cnhFJhN5kaaGWCcu1sfNuFTTvRnpBBTfcLQ==
X-Received: by 2002:a2e:6a17:: with SMTP id f23mr9997141ljc.338.1596577286495;
        Tue, 04 Aug 2020 14:41:26 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id s22sm2437095lji.122.2020.08.04.14.41.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 14:41:25 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 0/7] making log --first-parent imply -m
References: <20200729201002.GA2989059@coredump.intra.peff.net>
        <871rku3soc.fsf@osv.gnss.ru>
        <20200731230858.GA1461090@coredump.intra.peff.net>
        <87mu3drynx.fsf@osv.gnss.ru> <xmqqsgd5rlwi.fsf@gitster.c.googlers.com>
        <87o8nrybnb.fsf@osv.gnss.ru>
        <20200803180824.GA2711830@coredump.intra.peff.net>
        <874kpi47xj.fsf@osv.gnss.ru>
        <20200804195830.GA2014743@coredump.intra.peff.net>
        <873652166e.fsf@osv.gnss.ru>
        <20200804212518.GB2020725@coredump.intra.peff.net>
Date:   Wed, 05 Aug 2020 00:41:25 +0300
In-Reply-To: <20200804212518.GB2020725@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 4 Aug 2020 17:25:18 -0400")
Message-ID: <87y2muxf5m.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Aug 04, 2020 at 11:56:25PM +0300, Sergey Organov wrote:
>
>> >> diff --git a/revision.c b/revision.c
>> >> index 669bc856694f..dcdff59bc36a 100644
>> >> --- a/revision.c
>> >> +++ b/revision.c
>> >> @@ -2323,10 +2323,31 @@ static int handle_revision_opt(struct
>> >> rev_info *revs, int argc, const char **arg
>> >>  		revs->diff = 1;
>> >>  		revs->diffopt.flags.recursive = 1;
>> >>  		revs->diffopt.flags.tree_in_recursive = 1;
>> >> -	} else if (!strcmp(arg, "-m") || !strcmp(arg, "--diff-merges")) {
>> >> +	} else if ((argcount = parse_long_opt("diff-merges", argv, &optarg))) {
>> >>  		revs->ignore_merges = 0;
>> >> +		if (!strcmp(optarg, "off")) {
>> >> +			revs->ignore_merges = 1;
>> >> +		} else if (!strcmp(optarg, "all")) {
>> >> +			revs->diff = 0;
>> >
>> > Should this be revs->ignore_merges = 0?
>> 
>> It's 4 lines above, as it's in fact common for all the cases but the
>> first one.
>
> Ah, I missed that. That raises more questions, though. ;)
>
> For "-m" we do not need to set revs->diff; why do we need to do so
> here?

Good question!

I believe --diff-merges=all should reset revs->diff back to 0 to
entirely undo all the effects of '-c' and '--cc', provided those
appeared before on the command-line, that '-m' fails to do.

Admittedly, I didn't yet check what is the outcome of, say,
"git log -c -m". Is it = "-c", ="-m", or what?

Also, this makes 'all' not the entire synonym for '-m', and that's why I
removed 'all' from the second version of the patch ;-)

>
> For "--cc", we do not need to set revs->ignore_merges. Why do we need to
> do so here? We do need it set eventually, but I think setup_revisions()
> later handles that, and wants ignore_merges untouched to decide whether
> the user asked for it or not.

OK, I'll take further look at this for further changes, -- thanks for
telling!

My general approach though is that every of mutually exclusive options
should better explicitly set all the involved variables appropriately.

Thanks,
-- Sergey
