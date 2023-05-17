Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7956FC77B7A
	for <git@archiver.kernel.org>; Wed, 17 May 2023 21:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjEQVib (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 May 2023 17:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjEQVia (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2023 17:38:30 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76CC01BD0
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:38:29 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-ba81031424dso1883025276.2
        for <git@vger.kernel.org>; Wed, 17 May 2023 14:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684359508; x=1686951508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0aYc0BwucyQJ/Drybw2jYZcTMw5IOligaxiKgtee+ag=;
        b=OoNn7AxpvFKLIsgIfPJksZI+wLY59b0Gz22sy0/7CfPjJDXx+tlVi/k6YJYpjtukW+
         WUs7WtqY2muBPjwg2IbeEeVEsiM5AUPHRiWMRAfFNf6pxlpIRxcph0PGKSKQOA8wNGvt
         mBFVBoDtEto+d5/kc/Ke2OGXdHIwa+/Hrgo8IDWLbLyiEAxorBGXtwe/m2zlvQE4hF0l
         CF86Dsv98hXLNxKr+npOkbFHZ9I2Q4RyQG7qHzpw8ZSbZpIb7LNrsqJbQ39aOIliE0mA
         1/X9b37G3/i4q6Ku67ctagB3GczOQwxLHY57KHVTmJ0nNX9pBoGtmv6K86S82Qqeku5n
         iT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684359508; x=1686951508;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0aYc0BwucyQJ/Drybw2jYZcTMw5IOligaxiKgtee+ag=;
        b=c0P23vgprGQ/rHEC2E123KcsMcsFfIBEgL9dbWAr0be+MWGSys8FDKo7j3VvfsAKdT
         x6IB9OiQRUzHZ8Um30R++FeC086qh8UO99eRvDIWTq8nCGIbM/9hZv/YYmr7IxD1aYgk
         xLsNhFJAQYSaoPQtJl0IAOBV3iCrd8CN34KfbZFY2Ptdv0Id2FLQVdul7KlyzTxguqWd
         p+JnbUdEtbJYX7ugOJkpsx1rjhShUHQ2bYyJ7Xi8owyC44XkjFVVz9O/2RacQoiof0Mg
         rXfSDkteSIyqfbDsimEkjCQxZxQWEynIAlg6PNk0aEjEs6wBV8gu/fmH4KkoQ1hV1J8z
         2cLw==
X-Gm-Message-State: AC+VfDyIrtpzaXK2r27zkNdQ+jDW3Px/rZnge9gTfdfx8GqF/v5bPcX7
        6t39tDNYXYh58xVNrVxSSoec4g==
X-Google-Smtp-Source: ACHHUZ6X9mtmm95Wqr7tY8AmTkxdfzX9nzzqakzKioYojMFKWazDIdLeGCP1ngrOAdOsC4oAmhfBtw==
X-Received: by 2002:a81:6dd6:0:b0:561:dd1b:e516 with SMTP id i205-20020a816dd6000000b00561dd1be516mr2171207ywc.35.1684359507322;
        Wed, 17 May 2023 14:38:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id f63-20020a0dc342000000b0055d725edafbsm937768ywd.113.2023.05.17.14.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 14:38:26 -0700 (PDT)
Date:   Wed, 17 May 2023 17:38:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Hesse <list@eworm.de>, git@vger.kernel.org,
        Christian Hesse <mail@eworm.de>
Subject: Re: [PATCH 1/1] imap-send: include strbuf.h
Message-ID: <ZGVFnzyStiscDKh3@nand.local>
References: <20230517070632.71884-1-list@eworm.de>
 <xmqqwn17q7ou.fsf@gitster.g>
 <ZGT6fEZFumAsZnxu@nand.local>
 <ZGT/eK6+IKlCM6Sg@nand.local>
 <xmqqcz2yrjbe.fsf@gitster.g>
 <xmqq8rdmrixc.fsf@gitster.g>
 <ZGUVvjG+xou3w8YW@nand.local>
 <xmqqy1lmq183.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1lmq183.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 17, 2023 at 11:09:16AM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Wed, May 17, 2023 at 10:01:35AM -0700, Junio C Hamano wrote:
> >> Junio C Hamano <gitster@pobox.com> writes:
> >>
> >> >>         if ! gcc -I $(pwd) -E $f | grep -q 'struct strbuf {'
> >> > ...
> >> > What does the above prove, more than what your regular compilation
> >> > that does not fail, tells us?
> >>
> >> It is actually worse than that, isn't it?  This does not even use
> >> the definition in the config.mak.uname, so it is not even matching
> >> your build environment.
> >>
> >> I am uncomfortable to use this as an explanation of what due
> >> diligence we did to convince ourselves that this fix should cover
> >> all similar issues.  Perhaps I am grossly misunderstanding what your
> >> investigation did?
> >
> > Oof, yes, you are right:
> >
> >     diff -u \
> >       <(gcc -I . -E imap-send.c) \
> >       <(gcc -DNO_CURL=1 -I . -E imap-send.c)
> >
> > How *should* we test this?
>
> My inclination is punt and simply do not to claim that we have done
> a good due diligence to ensure with all permutations of ifdef we are
> including necessary headers.

I think that's the best course of action, too. I see that it's already
on 'next', thanks.

Thanks,
Taylor
