Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA41C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 13:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232398AbjDXN3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 09:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjDXN2t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 09:28:49 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0716C6E9F
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:28:36 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-38e4c98e5ceso1473003b6e.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682342915; x=1684934915;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IU9AJXitEaAM9kWwLch7ThcV0nfOcK5eNy8vBCzDRg=;
        b=mhc4jW6trf6qpjTCyn5wYEjazHzy4/f319UVRMxqGTKRL1qLJZbZB+D8cRbLt/eENQ
         lfsNBowvg5WHrFQpOTjjxPp4Tn3hOwyLFUnzNYK0/HpTfNKN3nhKQthlhAWXibK3DEJc
         Bh4aA6AbayRjpCPJZBQ5hGQOefhp3a+1pzOMbanyUdWQxnyMr1eXmjgXBzoMCHewxIW3
         ZE7rHor73xgJ00xhlbMTTr66+VdmCGDRAT/4U1uFTL/1fjv9RL6esUeIFm+wQTq7d3YC
         3SxTBT2iqht54KWwhCrHW8UreHFEseuPPdlKIJpJoP051mIF0mbFFb4B2SwrhT/oVneE
         Isww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682342915; x=1684934915;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0IU9AJXitEaAM9kWwLch7ThcV0nfOcK5eNy8vBCzDRg=;
        b=lFMPE3rnZTcpC3wJdpbqiICF8KHQWzv2jfH1qtAnVPqk4ArQMq9cC5JC3Fo+pZ+ew+
         BPcZhkjEUzfByS6q3+fvu1OjrQvM+KLagdYQmavJmDD2QGKCDUmJWVe4YB5yh5Nprhir
         jeDNpTM52mmjuuVv7JzqzmGSyiyamsVb6NwKfCJ/Nt9T+34OfT3038cYeoMYv5O++jbw
         mczjTzna5I/DwWQQgFLQVM4ATWvzQYnHFMyd6VkGpBl2jQlAqP3x3OQtN6WZG8Qxl7ny
         tBxSyySFzXoeJE8fYvDcEqEQWAw1JAFtz0SSlF/CD+yU7qmSLte8G4/s0RwTWFgr2s44
         gyJw==
X-Gm-Message-State: AAQBX9et3Ds+SkwmpL0oA3wnBOr0rEYYUM00WgAshEpf2qQK0JChoNis
        MbtEqeRyW9rKBtSIHk3aBAs=
X-Google-Smtp-Source: AKy350ZDEQiLUNRIeWEHow1T7bM9eYn4jnLshNSc0xACTho5lGkh/aXShG2qvVRDZuYFyo2j79qgbg==
X-Received: by 2002:aca:2816:0:b0:38e:f0c4:2106 with SMTP id 22-20020aca2816000000b0038ef0c42106mr651488oix.5.1682342915186;
        Mon, 24 Apr 2023 06:28:35 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id ay13-20020a056808300d00b0038e086c764dsm4424771oib.43.2023.04.24.06.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 06:28:34 -0700 (PDT)
Date:   Mon, 24 Apr 2023 07:28:33 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Message-ID: <644684018a766_aba29424@chronos.notmuch>
In-Reply-To: <xmqq8ren8xz1.fsf@gitster.g>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > The callouts are directly tied to the listing above, remove spaces to
> > make it clear they are one and the same.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  Documentation/git-checkout.txt | 4 ----
> >  1 file changed, 4 deletions(-)
> 
> I tried to format git-checkout.1 and git-checkout.html from HEAD and
> HEAD^ after applying this step, with asciidoc and asciidoctor, and
> did not see any difference that came from this patch.  Am I correct
> to understand that this patch is done purely for the benefit of
> human readers, and not for formatting machinery?

No, it's for the formatting machinery.

The fact that both asciidoc and asciidoctor happen to understand our quircky
formatting in this particualr situation doesn't mean it isn't quirky.

In this particular case the parsers do understand what we are trying to do,
because we just just pepper list continuations (`+`) everywhere and it happens
to work.

This works:

  1. item
  +
  ----
  line 1 <1>
  ----
  +
  <1> callout 1

But if we used an open block instead (which is more propper), this does not:

  1. item
  +
  --
  ----
  line 1 <1>
  ----
  +
  <1> callout 1
  --

This discrepancy confused Jeff in [1].

[1] https://lore.kernel.org/git/20230418061713.GA169940@coredump.intra.peff.net/

> It may be subjective for those who read the source if it is easier
> to read with or without inter-paragraph spaces, but in any case, the
> resulting source material now look the same way between two hunks,
> and consistency is good.

That is an added benefit.

It's simply a good practice to follow the format asciidoctor documentation:
which doesn't contain spaces, doesn't require adding list continations, it's
easier to interpret by the parsers, and works inside open blocks.

-- 
Felipe Contreras
