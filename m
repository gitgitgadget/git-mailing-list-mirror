Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA231C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:12:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239086AbjEKTM5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239052AbjEKTMy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:12:54 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED4AA270
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:12:20 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-3909756b8b1so2871894b6e.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:12:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683832257; x=1686424257;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MV5wE3UqfwQNtlvASP9wsO58te4tHtOJ2F4+j3WkLpE=;
        b=H/ecmX48T1kCM76P096x4AHq9bUuRK3mtH9RNdI1y1/qBAR5CYc9by20KYwaq7E0KQ
         +jjvTHWDySWzEXHW5Z14oL8ZdpbXo2U1qFyJNQ0HsI6A9vaHs5RiICI23FrvwBR6B9T6
         3TFXv2WCmtyohVfyvI51rPCzRDzX2j48c60uSLHxLX+K6OOicdGEM6tPPolf1xQKcIPb
         qqYEnmn4Q2JhRE1c7Vtxf2mQBOXvaD6MwZucHvbNXW6Tm5UZxn1BWqIWV5lvDNSyPOFR
         81sLMfhfK8CVnPcQi0bTaDoa06Z9AWG0YMRT5tiwKRo9SasmKh4NorJQANeUjBsRP2jO
         MKyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683832257; x=1686424257;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=MV5wE3UqfwQNtlvASP9wsO58te4tHtOJ2F4+j3WkLpE=;
        b=j+J3c3ncm60U7J9isV+4FzzRRDTArJPKH1NpNBSVZ4KAhfNv04g73zQwUVAmHxvztE
         7Tn9f4x+w49a1D1b6cvLvm47Tz7rw2U8nNS7L6cLrimf0rPXP9TCaN9lL59usbypVmdR
         +0Js/OWcim9vKbRpuWkONPVWPDIA+x54V0WOz2Bo7+yB5sSVkmJa7KJTPxvjsHiPJo1Q
         KaEanYjZ+T7tzLhKquxh26bAx+QrDTQzSksGDdXB+bCUZcT9AKFRUG5t5483lRQhYKH2
         xDeLV3SAcIlvIHMpBmwsClk1Iq7oUbcCjd8kwxz5Mk0TuN3hkUfGcj8XM4LFQOjPtolv
         sAdg==
X-Gm-Message-State: AC+VfDz1By1J53CEpHrabu0ggmaq8v8uBHanHNZpbZnvVF2Y1mf4djlk
        NDaV2ANAlgvwkQ11mbBzVuw=
X-Google-Smtp-Source: ACHHUZ6XStH8ZpqYy5120sYPV85HwaYQRL+bnvsdW7Hahzh7GPPIhbkK6g+rTIp9f8cpa/uxpLEPCw==
X-Received: by 2002:aca:2301:0:b0:38c:a20d:d376 with SMTP id e1-20020aca2301000000b0038ca20dd376mr5372747oie.39.1683832256724;
        Thu, 11 May 2023 12:10:56 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k4-20020a05680808c400b00383cc29d6b2sm3475909oij.51.2023.05.11.12.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:10:56 -0700 (PDT)
Date:   Thu, 11 May 2023 13:10:55 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Message-ID: <645d3dbf785a5_26069229463@chronos.notmuch>
In-Reply-To: <877cte200m.fsf@osv.gnss.ru>
References: <645c5da0981c1_16961a29455@chronos.notmuch>
 <871qjn2i63.fsf@osv.gnss.ru>
 <645d28e112294_26011a294b2@chronos.notmuch>
 <877cte200m.fsf@osv.gnss.ru>
Subject: Re: Can we clarify the purpose of `git diff -s`?
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> > Sergey Organov wrote:
> >
> >> I'd rather think about generic interface for setting/clearing
> >> (multiple) bits through CI than resorting to such convenience
> >> tricks. Once that is in place, one will be able to say "I need these
> >> bits only", "I need to turn these bit(s) on", and "I need to turn
> >> these bit(s) off" conveniently and universally in any part of Git CI
> >> where it's needed.
> >
> > It's possible to achieve both.
> >
> > Imagine your ideal explicit interface. In that interface the default
> > is no output, so you *have* to specify all the bits, for example:
> >
> >   git show --patch
> 
> No, that's not what I meant. There is no point in making "git show" to
> have no output by default, please see below.
> 
> >
> > Or:
> >
> >   git show --raw
> >
> > In this ideal interface it's clear what the user wants to do, because
> > it's explicit.
> >
> >   git show --patch --raw --no-patch
> >
> > Agreed?
> >
> > My proposal achieves your ideal explicit interface, except when no
> > format is specified (e.g. `git show`), a default format is chosen for
> > the user, but that's *only* if the user hasn't specified any format.
> 
> My point is that the default format should be selected as if it has been
> provided by existing options, rather than by some magic hidden in the
> code.

But why?

I don't see any benefit, only drawbacks.

> > If you explicitely specify the output format that you want, then the
> > default is irrelevant to you, thus you have your ideal explicit
> > interface.
> 
> That's not what I had in mind, sorry. It'd rather be something like:
> 
>   --raw: set "raw" bit and clear all the rest
>   --+raw set "raw" bit  (== current --raw)
>   ---raw clear "raw" bit (== --no-raw)
> 
> In this model
> 
>   git show
> 
> would be just an alias for
> 
>   git log -n1 --patch --cc
> 
> and no support for a separate command would be need in the first place.
> 
>   git show --raw
> 
> would then produce expected output that makes sense due to the common
> option processing rules, not because somebody had implemented some
> arbitrary "defaults" for the command.

But now you are at the mercy of those "arbitrary defaults".

Let's say those defaults change, and now the default output of `git show` is
`--stat`.

Now to generate the same output you have to do:

  git show --raw

in one version of git, and:

  git show --no-stat --patch --raw

in another.

This forces the user to know what is the default of every command.

Why force this mental burden?

If I want both patch and raw, then why not explicitely say so:

  git show --patch --raw

And forget about the current defaults for that command.

-- 
Felipe Contreras
