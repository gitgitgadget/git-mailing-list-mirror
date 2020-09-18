Return-Path: <SRS0=7xvA=C3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A460C43464
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:21:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 112E121D42
	for <git@archiver.kernel.org>; Fri, 18 Sep 2020 18:21:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="QHuqPmDA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726152AbgIRSVy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Sep 2020 14:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726007AbgIRSVy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Sep 2020 14:21:54 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661C4C0613CE
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:21:54 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id v123so7216528qkd.9
        for <git@vger.kernel.org>; Fri, 18 Sep 2020 11:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=9EfRkbW00UrNNiwRV+OXaJkHEYmuV0yBDbVOALV7sgg=;
        b=QHuqPmDABhz5EUAxYI2qsi8HMWr+3pq+sPVRZ//rIsLDeFKSB/ZRglsCGHB17vW3Uy
         X4Vwd/OgO60QkjBBhRAd/WJQBTU5JADod65epzvV8+/9UTcsTf2YR2o3/d09hgxDoyn5
         1nov1CtixSUyCk90GEWZNTL2L3g5sQfgXKkupNlxSNZNuV+IjrX6wYo31PjCYAI7xD3k
         u3AMiXxHrcDEadfEp/CvgQkAxcKnxgMAusQi++3KmmqbF1/d3qmLvDvT8FrQEX+tYxS5
         V38Y0Dtv9aXJpq65z5vRypHcN5eWQRlcj2qfS4bQN988QAeXvxcta4+dN1t9v1sQiwPJ
         vz7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=9EfRkbW00UrNNiwRV+OXaJkHEYmuV0yBDbVOALV7sgg=;
        b=Qq8SWyd3OelW6iKTM3NWPSFOkhQhMwgnTVC10EPWL+YgYBBuSC2vBmN9uyXcTLVMrR
         bN/g+ZBADidtt0jZH2xov8/bexWOg6c3lPqzl23tD8m4Slm27rdg2U6q5QJeAFbzYFks
         M4jMe0mGXaLnF72fHFWLacXi08t3enpSGRuNmI2XMO0OpZNHOl1+e00oDYCVqeygwFcb
         r+jW7xuXyA+gieORdT5lHxlh/PShYXOtSbubgJxGmG3LL+1V+C5p3eyg7hfV8Y9VYF6X
         /4FM7DWanOxaBtOhFSmikXvOp8oRqHzd3jKQlBbW6EIvkQR7ax0vjOxYoh8jw9/vNmKV
         uarw==
X-Gm-Message-State: AOAM5305M1CpgUGHVaMtQbJJrW6pLsMpFiLzzB5vvC5Z/CNGB81L/Ijo
        sYIy6H7DaI8prcRCvNlVr0pKGA==
X-Google-Smtp-Source: ABdhPJztUMZKEPIkZqhiqZld1N02o5tu1GvZJ4xLX5bwhjLMz/Rz6OAJdKjzZMScuNC+T5L1O+OImQ==
X-Received: by 2002:a37:54a:: with SMTP id 71mr30833248qkf.407.1600453313493;
        Fri, 18 Sep 2020 11:21:53 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:bcd8:3baa:a5e5:d0e6])
        by smtp.gmail.com with ESMTPSA id l19sm2695436qtu.16.2020.09.18.11.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 11:21:52 -0700 (PDT)
Date:   Fri, 18 Sep 2020 14:21:50 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/4] builtin/rev-parse: learn --null-oid
Message-ID: <20200918182150.GC1612043@nand.local>
References: <cover.1600427894.git.liu.denton@gmail.com>
 <004f2e4c92918a7a4e452d49e98ef15f1c5ac545.1600427894.git.liu.denton@gmail.com>
 <20200918141125.GB1602321@nand.local>
 <20200918141614.GC1602321@nand.local>
 <xmqqy2l7kl0p.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2l7kl0p.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 18, 2020 at 11:16:54AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > In either case, I think '--zero-oid' makes more sense than '--null-oid'
> > (and it matches the tests that are already written). The pair
> > '--zero-oid' and '--empty-oid=<type>' make sense to me.
>
> I am not sure rev-parse should even know about "empty-oid".  An end
> user or a script who wants to learn what name an empty blob has can
> and should ask "git hash-object -t blob --stdin </dev/null".

Yeah, my uncertainty ("should this be '--empty-oid' or '--null-oid'?")
is probably a good indication (to me, at least) that the option
shouldn't even exist.

> I can buy --zero-oid might be handy, but don't see a pressing need
> if it is merely to support our test suite and sample hooks.
> Instead, something like
>
>   ZERO_OID=$(git hash-object --stdin </dev/null | tr '[0-9a-f]' '0')
>
> should suffice, no?

Absolutely.

> Take this as a mild indifference, not as a strong rejection.

For what it's worth, I'm probably as indifferent as you. I would be
slightly less so if there was evidence of lots of out-of-tree scripts
that care about these special OIDs, but I haven't looked too far.


Thanks,
Taylor
