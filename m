Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 936A9C433EF
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232813AbiBAVde (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:33:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbiBAVdc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:33:32 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81123C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:33:32 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id g15-20020a17090a67cf00b001b7d5b6bedaso3971446pjm.4
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=YTA3cDh4LLlm+ezBSqH4BTzeUmKJzaG32SASELg2+H8=;
        b=EOqnSM6P9cJJTzCmsY5xoBDgehPlWiQVE+qYsBq0xkb51S04ofdlXsBwL6ocGX2DhB
         vPz4+1HijUdPXGJnmrGCBlEPYtFlCXUHNi4gTbI71GbzmkbPf70JxmT5PqsN0jDBR5RH
         kN8kkE6ZmhnWxA4U1WRwA8/ypzKHQ2+GksuL9UDFnsPrwM5XdGZKKfkB8ui6iMAU7Gjd
         RdePKVRMSQD+Y7hSAqpOxbI/w5hf9FmTd1XLAtIk8L7tu0yeZpGqhZwj4Nk2Q1upU34t
         LeaHEzEvxo5XYGAEOZTpcjU6/XM9hPmIkn/JC5vn3/7E9AKOvMJZUswdopD6Kayhs1/F
         WP8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=YTA3cDh4LLlm+ezBSqH4BTzeUmKJzaG32SASELg2+H8=;
        b=Z/B8dAsr0HDVIiFI6W99sLpQPtJdQm+8CMc8DPHk+LyNRn15muwr7m3JSqZYENjp2E
         pXTTM0HirmlubvWbzwiYz+ED5OIt1/oK3h9K8pyIZhgQL9n0qhs9z68n6nqD8hasB/8E
         H5RYae9A9L1nSi6mX/zRbCiFYOYN30Xj/TxzEdHu/jSEzRuxKRHSfCTe3LBr9aqxmg69
         C5kNSBmY59eu/fduaJ5yD8MWPGWo5UaaJvPg7Cs6oj194gVAhpPcOXHdKmZeErYRX2uk
         MhUKOKC8/M4wgFOm8NNzk42fxDNKDKdpV/PmbvXTXLGMmuOlO57Ccadna7YRo7mt4Zk2
         eEJQ==
X-Gm-Message-State: AOAM5301bOaZ81NxH8T7vhe6kwOjnx+LRdzON1snes8fV9s3ZF5jqctq
        8rYaF0XrmH8uT8AsrCsHoaAx6Q==
X-Google-Smtp-Source: ABdhPJwB7eZh/D7ACyPJM49O4hRqU+uxUzDwiAlVH8ET/Fyn+RGFacAMVq+nbmqKiqGf5ngZgsxBDg==
X-Received: by 2002:a17:902:9698:: with SMTP id n24mr28177359plp.60.1643751211719;
        Tue, 01 Feb 2022 13:33:31 -0800 (PST)
Received: from google.com ([2620:15c:2ce:200:b721:7974:9ebe:afb2])
        by smtp.gmail.com with ESMTPSA id n2sm10408345pgf.74.2022.02.01.13.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:33:31 -0800 (PST)
Date:   Tue, 1 Feb 2022 13:33:25 -0800
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] clone, submodule: pass partial clone filters to
 submodules
Message-ID: <YfmnJY6CMF2MP7u4@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
References: <50ebf7bd39adf34fa4ada27cd433d81b5381abe5.1642735881.git.steadmon@google.com>
 <xmqqsftgbkvm.fsf@gitster.g>
 <CABPp-BE2B9NkWG8bWft6m-UOg66aRpjwSRTWvAyrKCiwJCemHQ@mail.gmail.com>
 <xmqqilu7t4nm.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqilu7t4nm.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2022.01.25 22:03, Junio C Hamano wrote:
> Elijah Newren <newren@gmail.com> writes:
> 
> > But how would that interact with this patch?  There's a bit of a
> > conflict.  There's a few ways out:
> >   * Make your change be explicit rather than implicit: Based on
> > Junio's first concern, you could modify this patch so that it requires
> > a new flag like --filter-submodules-too (or some better name), and
> > perhaps folks with a path filter just wouldn't use that.
> 
> I would very much prefer this, given that this is a change of
> default proposed by those who want a different default than the
> status quo, even without the "how would we know it is sensible to
> just pass down any and all filters?" issue.

Yes, I think a new flag (and corresponding set-and-forget config option)
is the right approach. I'll include that in V2.

Out of curiosity, does the project have specific principles about
changing default behavior? For example, would it make sense to plan a
path for --this-new-flag to gradually become the default, or is that
something we'd only consider with a new major-version release?

Just thinking out loud: it should be possible for us at $job and other
people in similar situations with a managed Git installation to look
through traces and see how often people are using or not using a
particular flag or config option, and that could in theory guide such
decisions. On the other hand, I don't think that Git users at megacorps
are sufficiently representative of all Git users to be the basis for
justifying such a change, so we'd need outside feedback as well. Not
trying to suggest any particular agenda or approach here, just wondering
if others have thoughts on this topic.
