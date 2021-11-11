Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71007C433EF
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:06:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53C7861267
	for <git@archiver.kernel.org>; Thu, 11 Nov 2021 23:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234183AbhKKXJL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Nov 2021 18:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhKKXJK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Nov 2021 18:09:10 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFA57C061766
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 15:06:20 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id o6-20020a17090a0a0600b001a64b9a11aeso5995117pjo.3
        for <git@vger.kernel.org>; Thu, 11 Nov 2021 15:06:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=OE+gdJwODWgQzj5+KAWXaSVZ+1sMmbIXkV7WRcxG8S4=;
        b=fR3V4r5w6ZxEozZi9hCHcVPnf4i+5EJEJjBs8OEEOtx0TguMEoBMrs+7NedzZNzUek
         7AYX86HM+JZfxtj0C3uccmQ0Umo+mvACvYJz2PW74xd9/8GuYqKPr55r3tFH1lwYH71N
         bl/EejQ4jgWt6U9QsKDCoAjQkSbACYVYm93pAg68q39zMrsQ8EIYm7K4G4rBpmzNkTLz
         Hnt/hjWQSL1qOwpJAckZ8GvWMY1vO2CtpiPkuuLQYWQzKCCf4CuVmWLDN6hSazHY3YV1
         702r9st9y3TrTL0OjPxQRKX1Uj7Mic8ZBa4ShMHz5IPfCCmoGHi5lJOOoXnP1Xxhk+Qj
         xPFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=OE+gdJwODWgQzj5+KAWXaSVZ+1sMmbIXkV7WRcxG8S4=;
        b=mdjX9gWZc4g0Yhx6ELa+P6q1HtXLN2LUIoPcYlMvlFx5juYh8OjKtGj7VcF6HmjhbR
         BfbrPc4T1fsr2ay00qeEa8rUR8ayHPbtu33gYIITlTkgP0+jefkZU+kFgQSADdMe0JgI
         B+gn2f3T4F0r/VCtsZlQYzt4S86NoMd3hV3HCgUwSexhkqYl/7ptYKgGwydZH3bg2T0z
         qRiWhzFHQpnLOQCa+eNf5sZRha0EX7WEVbuuqqqvLB7Vo9bLnBtbRO6fZmBc4H+vJtGJ
         /8T7+7PRqYkELPVAoVBSV9MRdJ/TX+qXXpFJSG7pQJNklJ0Yl8uGarJoOTV+ip7lvr+F
         LhJw==
X-Gm-Message-State: AOAM531HcuVucLdpEqH0704fqSUtuWF9YnSsAxJSBGNVEYwjBwluEKxz
        HQyc0XxSesQ7Cv263SCLXtTR5A==
X-Google-Smtp-Source: ABdhPJzUxNixLpV12mUDXAPY9DyWyqtNnsj/5cXOhdkoddpeC+1+g5KUJFq4EI794jRg2MwQp2mt7A==
X-Received: by 2002:a17:90a:4414:: with SMTP id s20mr30758341pjg.132.1636671980144;
        Thu, 11 Nov 2021 15:06:20 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:2812:884f:9c76:ae35])
        by smtp.gmail.com with ESMTPSA id k5sm4421622pfc.111.2021.11.11.15.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Nov 2021 15:06:19 -0800 (PST)
Date:   Thu, 11 Nov 2021 15:06:14 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
Subject: Re: [PATCH] trace2: increment event format version
Message-ID: <YY2h5lO90vo3Dy42@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>, git@vger.kernel.org,
        git@jeffhostetler.com
References: <ebc4d9a6960f0350772c14981ef211876f29d0fa.1636669891.git.steadmon@google.com>
 <xmqqh7cijnwx.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqh7cijnwx.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.11.11 15:03, Junio C Hamano wrote:
> Josh Steadmon <steadmon@google.com> writes:
> 
> > In 64bc752 (trace2: add trace2_child_ready() to report on background
> > children, 2021-09-20), we added a new "child_ready" event. In
> > Documentation/technical/api-trace2.txt, we promise that adding a new
> > event type will result in incrementing the trace2 event format version
> > number, but this was not done. Correct this in code & docs.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> >  Documentation/technical/api-trace2.txt | 4 ++--
> >  trace2/tr2_tgt_event.c                 | 2 +-
> >  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> Hmph, it seems to me that this is better done before the release,
> or am I mistaken?

Ideally yes, although I am not sure if there is anyone using traces who
strongly depends on the accuracy of the evt field. For release-blocking
fixes (for lack of a better term), should I have sent this patch
differently?
