Return-Path: <SRS0=sa20=BQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1BBC433F2
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ECDA22D70
	for <git@archiver.kernel.org>; Thu,  6 Aug 2020 11:13:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S6bxD964"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbgHFIqD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728973AbgHFIqA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Aug 2020 04:46:00 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73C2EC061574
        for <git@vger.kernel.org>; Thu,  6 Aug 2020 01:46:00 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id j19so26313081pgm.11
        for <git@vger.kernel.org>; Thu, 06 Aug 2020 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bXFsbmuJI6zYOWJLxHmF4jvwdLPQBkCCFT5fBUuBIWM=;
        b=S6bxD964bysfssOdy17oCR7zaRBeUEald738yLJitJTLhcOrfpeV9yq1D2UDvsgszF
         Wes6nO16BEYjiU3aYrk3RVhbyww63DOzZ/5EUVVIfcRkB/GFtrrCOnZOZsCgTaf5MDOL
         A/PtQjfiDwblm7o4VMYRIU0tcwF/bPIBDnYNEOQhxRrx0r+JT0tSQSKCT5Mt3teKEBJ+
         cWj0Yso55spz1FJk7gPbwaVKQh8AY624SSe9sO87pTzz6si5KC+zD9N3NKOdeiRih/a+
         smbYRQKje1GXXcV7krTQoxV4vRr3EBYmOD3d8OMuy1+oyI4YaFYOkHgl8kGkYKeG3/pL
         jp+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bXFsbmuJI6zYOWJLxHmF4jvwdLPQBkCCFT5fBUuBIWM=;
        b=PQWu4Edn90cYLlylaQUHa6Ao28B48Vu49MvkC2ApA/+wTsf4coAp2flpXVise5ScDU
         xP5FJnRiD9IwDDXPoNhQQopjstCXidPvjlTVhhJPq5JoOz5qP7ES9C77vT3KVNUjTN60
         ZQWJkrrhT4rW4rFFD5f9kPH4c8xNld8DFxK1WrcGj4anaaEClNVx28ty4qlGZUapxOqB
         jxAO1gR+6E2+MBUydOGukp62naClyt6/JrRMm87tnLdVMppzIC2jtC9cOTuLblOnXUrx
         MIR6+xLm2WeEK4STD+1kv+/LaapuhOuzRiU2lL/EmKy9bbdz2pv+Su3cI/ZjLznjKixd
         Pz5w==
X-Gm-Message-State: AOAM530SmFuYpZJChiK/sOY+Q+Qi1g8sTz8U7sy1DZwnOBR+SBIPaigr
        T16Rb5LbZ0eYcIMxWRnxA/VcYBzD9Sw=
X-Google-Smtp-Source: ABdhPJxWzZkdlWrWEJ28H5eMO6mVeGyau9VZuhml2ELK3eY3bddMflDpp5JzJHVavSrmzIoQDlBTTw==
X-Received: by 2002:a62:7644:: with SMTP id r65mr7084665pfc.271.1596703559875;
        Thu, 06 Aug 2020 01:45:59 -0700 (PDT)
Received: from konoha ([45.127.46.60])
        by smtp.gmail.com with ESMTPSA id y20sm7094053pfn.183.2020.08.06.01.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2020 01:45:59 -0700 (PDT)
Date:   Thu, 6 Aug 2020 14:15:53 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, johannes.schindelin@gmx.de,
        chriscool@tuxfamily.org, liu.denton@gmail.com
Subject: Re: [PATCH 1/4] t7401: modernize style
Message-ID: <20200806084553.GA13942@konoha>
References: <20200805174921.16000-1-shouryashukla.oo@gmail.com>
 <20200805174921.16000-2-shouryashukla.oo@gmail.com>
 <20200805193755.GA2650@generichostname>
 <20200805204924.GF9546@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200805204924.GF9546@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05/08 04:49, Taylor Blau wrote:
> On Wed, Aug 05, 2020 at 03:37:55PM -0400, Denton Liu wrote:
> > Hi Shourya,
> >
> > On Wed, Aug 05, 2020 at 11:19:18PM +0530, Shourya Shukla wrote:
> > > The tests in 't7401-submodule-summary.sh' were written a long time ago
> > > and have some violations with respect to our CodingGuidelines such as
> > > incorrect spacing in usages of the redirection operator and absence
> > > of line feed between statements in case of the '|' (pipe) operator.
> >
> > I'm not aware of anywhere in CodingGuidelines that says you can't have
> > the pipe operator on a single line. I assume you're referring to the
> > part that reads
> >
> > 	If a command sequence joined with && or || or | spans multiple
> > 	lines, put each command on a separate line and put && and || and
> > 	| operators at the end of each line, rather than the start.
> >
> > Note that says "If a command sequence [...] spans multiple lines", which
> > doesn't apply in our case.
> >
> > > Update it to match the CodingGuidelines.
> > >
> > > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > > Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
> > > Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> > > ---
> > >  t/t7401-submodule-summary.sh | 8 +++++---
> > >  1 file changed, 5 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
> > > index 9bc841d085..4439fb7c17 100755
> > > --- a/t/t7401-submodule-summary.sh
> > > +++ b/t/t7401-submodule-summary.sh
> > > @@ -16,12 +16,13 @@ add_file () {
> > >  	owd=$(pwd)
> > >  	cd "$sm"
> > >  	for name; do
> > > -		echo "$name" > "$name" &&
> > > +		echo "$name" >"$name" &&
> 
> This change is good.
> 
> > >  		git add "$name" &&
> > >  		test_tick &&
> > >  		git commit -m "Add $name"
> > >  	done >/dev/null
> > > -	git rev-parse --verify HEAD | cut -c1-7
> > > +	git rev-parse --verify HEAD |
> > > +	cut -c1-7
> >
> > For the reason above, I disagree with this change as-is. However, one
> > useful thing that you can do here is breaking the pipe up entirely. We
> > want to avoid is having a git command in the upstream of a pipe. This is
> > because the return code of a pipe comes from the last command executed
> > so if the rev-parse fails, its return code is swallowed and we have no
> > way of knowing.
> >
> > You could break the pipe up by storing the output of the rev-parse in an
> > intermediate file and then have cut read from that file.
> 
> This is a good suggestion (I was preparing to write an email to say the
> same thing, but I'm glad that I checked Denton's response before doing
> so). Something like:
> 
> 	git rev-parse --verify HEAD >out &&
> 	cut -c1-7 out
> 
> would suffice and be in good style.

Sure. I will make the amends.

