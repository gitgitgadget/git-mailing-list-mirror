Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF85CC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48C722078E
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 19:28:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sfRV0on+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732033AbgKET2y (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 14:28:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKET2y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 14:28:54 -0500
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDEEC0613CF
        for <git@vger.kernel.org>; Thu,  5 Nov 2020 11:28:54 -0800 (PST)
Received: by mail-pf1-x444.google.com with SMTP id z3so2100292pfz.6
        for <git@vger.kernel.org>; Thu, 05 Nov 2020 11:28:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=axiZ5jmvr3KrsRLZ2ZX12Me10ioKYUvuB2mBbnKj11o=;
        b=sfRV0on+cD2N/Y/H710X1D956enNiRd9RMZKxkoaYL7gbwlrZjCTsgiKU3dcJ+1u9O
         CIZ8IRlMfCVDHD6PYJMSOrBZSm6ut2AiLsAiTcK7EQEyDg2AlB6KJhKDAKzcBuzRzyw3
         cj/AHHOlSEItt5+tyAf89/1yVWh7pJCXXmVsryj8kLUqCE6PNunBphGVGntxVHF4o6zv
         dmAC+Uy4tJINz4/Sf902QfjrA6x4/t4FGQFWXLK045tqNIeV2/Ok0ziuYrdUpEjaBYTP
         gglfK5MPQRFec8Q/GauQ2Xy0gsY8z7GN0M/K08HNeEs6uF/Lx/rKHz/vO4h8AFOQgvs2
         S2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=axiZ5jmvr3KrsRLZ2ZX12Me10ioKYUvuB2mBbnKj11o=;
        b=RUm6F3Ci+eXBGT4IPJdn3oLdWVBERL0XANgA1nQv3oyDzmeHBi2GyvpUHj8mGeATXH
         4YJE5PaWLZHhqhOyA/tXXoDb31fp0a4SxxcMrjmijfffwH94c93d7J2CrTY38DRQLZI+
         W6M08FHDZ3jTG2YFb2WE2HoR/Kjpo0FrS2NJa2mWL1HtwziuLl3AZtQA6FKhmLg3Dyep
         qYs9Vuj3OASatDK+WfhnyovCLXxvsK2cq9CaPru/1br2OhC6m/YD3cAH0cOck4Zk6Adx
         2hVvp++JcPUgibQmgmKST4thHCJRSwnMvm32+xyF4h+g34t1lMU30Flh2U1f9IcIqd1E
         Bzqw==
X-Gm-Message-State: AOAM530/WmlOm+adAal6DQI3MqBtsk+tFUiFVn9dbJleTxTWUtXXRkuS
        YsNxkv0u4Q52UyEMEgIaYeysVQ==
X-Google-Smtp-Source: ABdhPJzbD2xRi3L3y9R+xay063oTV2Mds4YcthYiALl4//JGMC16nGkg404q1NCNjjp3Q3z6xhN8Qg==
X-Received: by 2002:a63:5fc3:: with SMTP id t186mr3778262pgb.187.1604604533327;
        Thu, 05 Nov 2020 11:28:53 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:1ea0:b8ff:fe74:b4c1])
        by smtp.gmail.com with ESMTPSA id 26sm3198586pgm.92.2020.11.05.11.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 11:28:52 -0800 (PST)
Date:   Thu, 5 Nov 2020 11:28:47 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 02/11] docs: new trace2.advertiseSID option
Message-ID: <20201105192847.GD36751@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <cover.1604006121.git.steadmon@google.com>
 <cover.1604355792.git.steadmon@google.com>
 <5d5097b67109554e0763724633810ea616b5e2b2.1604355792.git.steadmon@google.com>
 <xmqq1rhaqfqg.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq1rhaqfqg.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020.11.03 13:42, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > Document a new config option that allows users to determine whether or
> > not to advertise their trace2 session IDs to remote Git clients and
> > servers.
> 
> I do not think placeing this in the trace2 hierarchy is a good idea.
> 
> It is not like concept of "session" belongs to trace2; each
> operation we perform inherently is done on behalf of a session.
> The trace2 subsystem may have been the first to externalize the
> concept, but even after trace2 gets superseded, we would want to
> key our log records with some "session ID".  After we introduce
> an improved mechanism that is successor to trace2, we still would
> want to exchange some session ID if the advertiseSID option the
> users define in their repository today (well, maybe in 3 months
> after this series lands in a released version and widely
> deployed), no?

Yes this makes sense. Do you think it's worthwhile to move all the
session ID implementation out of trace2? Right now there are some
user-facing bits (environment variables for parent/child SID hierarchy)
that specifically mention trace2, and I believe that the repo tool is
using it to tie together logs produced by a single repo invocation.

> We are not exposing the session ID anywhere but the transports, so
> how about calling it transport.advertiseSID, perhaps?

Yeah, this sounds good to me. Will change in V3.

> We also may want to call that just "session ID", not "trace2
> session ID" in the description.
> 
> Thanks.
> 
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Documentation/config/trace2.txt | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/Documentation/config/trace2.txt b/Documentation/config/trace2.txt
> > index 01d3afd8a8..3f2e3b4425 100644
> > --- a/Documentation/config/trace2.txt
> > +++ b/Documentation/config/trace2.txt
> > @@ -69,3 +69,7 @@ trace2.maxFiles::
> >  	write additional traces if we would exceed this many files. Instead,
> >  	write a sentinel file that will block further tracing to this
> >  	directory. Defaults to 0, which disables this check.
> > +
> > +trace2.advertiseSID::
> > +	Boolean. When true, client and server processes will advertise their
> > +	trace2 session IDs to their remote counterpart. Defaults to false.
