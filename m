Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55254C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 14:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjBAOPL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 09:15:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232095AbjBAOPK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 09:15:10 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02FF915C8F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 06:15:09 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id dr8so30228484ejc.12
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 06:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bAtW2wQwjHvOy0Qf4KI4XX+TV3zp/R7orUtOCXaMNFY=;
        b=Efv2um7alcJAWddffwVIxrQFjXIv2IqOSmQSxxwKFDswVizRwwYLpF083VAmTvrMuc
         PtZl1n+Cj/3Act+nYkFxPaJCNYu1Bzp5tEOK5wjmKFm+VS4tO4GPx+ORITQjZ3gQRTMw
         nro7saGsHbR1aHJhutfKUvDn0hdw6mK77MVaQTqKrGI7bPBesDqVd0jBvTzfTT4iLvbO
         HeF+CFb4MW1vPrXWROaywIQtb3e5XdPFsdP1vlb7ABJixRDGEJbDMi6bLAUv7iBHfmjS
         Yp7/ES+zgOhC+FIXmVAd4/br/MMJTr6cPc5x092kGT3ailitTmeruMfuCDPdfXfL+ldJ
         a+1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAtW2wQwjHvOy0Qf4KI4XX+TV3zp/R7orUtOCXaMNFY=;
        b=h+dD88pYLnimLAdPSadWOIoaTmvE4dLvY5R2CuDJvZD0SNAX7JjlO7vqSF3lU8Eq6N
         Z3uRSiDkWjkarwnqRHQ51ZJHnvlPp3J5qq15NSqqTaGsFEod8YYerUCNYjeBOoTTPbzb
         N+R5SeBQFZQZRaDZKpAfVhF8Z0MG8ma3T1asODFHKn9jXOiwH7FB5oN3C1DMTQvDnOQJ
         1ka+DmBIm0iJFa1Uqyd1iYCcpEkCpiUI5w3/6Fh4987dGqEO022SQKAKMc9HLC1bg/5X
         ZpWp4/bif7HMR6IX+jNceN41gTZJ8MUl5+qSnFT6dRSWSoQRPylAhpoT0BEnakwHSAum
         M0eA==
X-Gm-Message-State: AO0yUKVddjrhwN6hYdU5oC5zSiSoIvyAiQnWqGJerhyACZZIgbeJqV0p
        ada/AM+Qxmg8SPfMJQ42ksE=
X-Google-Smtp-Source: AK7set+pXwfepsm0BiJsL92Tg9zpxnfZ2hfv8abaH/vSfx7Phf2ZwItsSnU7r8lDX/KrZFS7mohAVA==
X-Received: by 2002:a17:906:b04a:b0:878:814d:bc99 with SMTP id bj10-20020a170906b04a00b00878814dbc99mr2220941ejb.66.1675260907596;
        Wed, 01 Feb 2023 06:15:07 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id e18-20020a17090681d200b0088519b92080sm6195726ejx.127.2023.02.01.06.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 06:15:06 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pNDtC-002H01-0o;
        Wed, 01 Feb 2023 15:15:06 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC/PATCH 0/6] hash-object: use fsck to check objects
Date:   Wed, 01 Feb 2023 15:06:39 +0100
References: <Y8hX+pIZUKXsyYj5@coredump.intra.peff.net>
 <Y8ifa7hyqxSbL92U@coredump.intra.peff.net>
 <97faa323-a5b9-e459-70d7-3f6318446898@web.de>
 <Y8zqZH+X6fOoCOYV@coredump.intra.peff.net>
 <d225dddc-973c-f710-9d24-cb53b26b973f@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <d225dddc-973c-f710-9d24-cb53b26b973f@web.de>
Message-ID: <230201.868rhhqxp1.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jan 22 2023, Ren=C3=A9 Scharfe wrote:

> Am 22.01.23 um 08:48 schrieb Jeff King:
>> We probably also should outright reject gigantic trees,
>> which closes out a whole class of integer truncation problems. I know
>> GitHub has rejected trees over 100MB for years for this reason.
>
> Makes sense.

I really don't think it does, let's not forever encode arbitrary limits
in the formats because of transitory implementation details.

Those sort of arbitrary limits are understandable for hosting providers,
and a sensible trade-off on that front.

But for git as a general tool? I'd like to be able to throw whatever
garbage I've got locally at it, and not have it complain.

We already have a deluge of int v.s. unsigned int v.s. size_t warnings
that we could address, we're just choosing to suppress them
currently. Instead we have hacks like cast_size_t_to_int().

Those sorts of hacks are understandable as band-aid fixes, but let's
work on fixing the real causes.
