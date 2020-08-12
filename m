Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C4EC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:03:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE859207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 14:03:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="ViT1pqru"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgHLOD5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 10:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbgHLOD4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 10:03:56 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06450C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:03:56 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id v22so1509499qtq.8
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 07:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=w1+hRtNAm0cuPFujJ/tdFUj6sIbdaad698j+p6A76NQ=;
        b=ViT1pqrueBG44eHPnVxarWUyRWqxwXXHGH1U8hgmS5f16aDs+kO++s1KvOTejHq8aI
         8MojHSnRDJ/0NOuGm96jpQNmtcDhvq/aM+cBY1M+qmgjel2pppAqQ77mRcKZrbTKxUee
         Kdg7k6JRS4e6ENsDShOZGB/rexdnbmzd+xq228ymOq/pmhAxZUYwoIrlX0KyB6Dpq4Gv
         IzeG8fjX2p6aJz8Kx+qqTIZKDpil4xsyqmCGCAM6jL6jEVl0T/7DSNxZW14OFFVpGHko
         YM8pyxTkJGAsOBMGHuzq5UtZe5orGDZT5MhknTIKMSgfEoEIbfnPtgBnMrABFs3xVCz7
         5Ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=w1+hRtNAm0cuPFujJ/tdFUj6sIbdaad698j+p6A76NQ=;
        b=izhbRfEAPTtOlhXtOfbMRFLUPzXVUoXrXfJ+sl9hjoXb+v+e7+xogP99oRE2rVSDs3
         0tUsPorUrQ2UieIbqe1vT75PvIBuWNwSdZXrECk4h2UAMhZy+GasgAYuclGPRlhQK5SG
         FqRWq8T6Ya+6dUBQVH50P9LieGN1EBMsB0k8sALBEAaEQqTA6V4dC6lRHXR0sDoEDi6X
         g+VdirDboU2qvP6cix67mp8C560I7+OCRkpKsoWUUicpw5ihhMFcFbxW5rdDl3vCGUDC
         O6yl+wR+5zHBXSyXwkx1WoEYbT01quriXOygO9T37lklAFd29HEOvMn2vQIXHMMWmTgF
         xEeQ==
X-Gm-Message-State: AOAM533UzxrVj9l0k8R7odoBmSRLJa3PuXjDQE+9NgdAucB5VaMVEpsE
        drFB/XvwZSpTWXf3WUvOKDUHXA==
X-Google-Smtp-Source: ABdhPJzXyTsNTDmBzIIQqtrCIdIHZ+znPF1SlgQlVmS9tznoETZGrdT+gs5GZXcdK8e5SoWIqd33OQ==
X-Received: by 2002:ac8:3772:: with SMTP id p47mr6670782qtb.355.1597241035185;
        Wed, 12 Aug 2020 07:03:55 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:a92f:57be:59a6:7cb2])
        by smtp.gmail.com with ESMTPSA id i19sm2276258qkk.68.2020.08.12.07.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 07:03:53 -0700 (PDT)
Date:   Wed, 12 Aug 2020 10:03:52 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <antti@keraset.fi>,
        phillip.wood@dunelm.org.uk,
        Antti =?utf-8?Q?Ker=C3=A4nen?= <detegr@rbx.email>,
        git@vger.kernel.org,
        Jussi =?utf-8?Q?Ker=C3=A4nen?= <jussike@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase -i: Fix possibly wrong onto hash in todo
Message-ID: <20200812140352.GC74542@syl.lan>
References: <20200811131313.3349582-1-detegr@rbx.email>
 <ebdc0bc7-f48e-9f38-328d-b1181ac974d7@gmail.com>
 <20200811153621.GD19871@syl.lan>
 <20200811181537.qt7jkoxy7qn3k7mo@haukka.localdomain>
 <xmqqsgct9fi1.fsf@gitster.c.googlers.com>
 <20200811190139.GB34058@syl.lan>
 <xmqqft8t9f55.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqft8t9f55.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 11, 2020 at 12:05:58PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > On Tue, Aug 11, 2020 at 11:58:14AM -0700, Junio C Hamano wrote:
> >> Antti Keränen <antti@keraset.fi> writes:
> >>
> >> > On Tue, Aug 11, 2020 at 11:36:21AM -0400, Taylor Blau wrote:
> >> >> Ack, I noticed this too during my review, but apparently forgot to
> >> >> comment on it. I'm puzzled by the first '..*'. If you're searching for
> >> >> any non-empty string, how about '.+' instead?
> >> >
> >> > That's true. Good point. I pretty much copy&pasted the 'todo count' test
> >> > so I didn't give this much thought. I'll fix this.
> >>
> >> Please don't shorten ..* into .+ if you are writing a portable sed
> >> script---stick to the BRE.
> >
> > Sure, and sorry -- I didn't know that we cared about the difference
> > between BRE and ERE. Do you prefer ..* over .\+? Both should be
> > supported in BRE, if I'm reading [1] correctly.
>
> I thought that BRE only commands taking backslash-quoted ERE was GNU
> extension?

*Grumble*, it's not anywhere in POSIX:

  https://pubs.opengroup.org/onlinepubs/9699919799/basedefs/V1_chap09.html

...making this a GNU-ism.

> Look for "stick to a subset of BRE" in Documention/CodingGuidelines;
> we may need to update the document to raise the baseline to match
> the reality of year 2020, though.

So, I think the "reality of year 2020" is that we still write '..*'
instead of '.\+'.

Thanks,
Taylor
