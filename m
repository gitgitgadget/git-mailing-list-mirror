Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D633CC07E9B
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B1BCA6113A
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 22:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347932AbhGSWPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 18:15:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384938AbhGSSl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 14:41:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C97CEC061574
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:12:28 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id hd33so30511416ejc.9
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 12:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=Wnrof7f+RSnEBpZHdKhpLl9hIXM5sABs6ATXvkHzMC0=;
        b=GCNKJTDOoidpJlI1o2mB8VtGyWY9AKclLee8EdAz8qXGN54rydOWQWNJtS+oOr4vIG
         nbSyJlm+5vmsxiNB8XkOI4I/IvNkfOtr1fw7Qlo1dVp99MpzNcEn18upJ8gRWUzWaVTn
         IHypw6j/11y9kJiUuDF9Pbf7j0C3uPmYg25qtvg7+cOVPaV/AV3YphT8+tqzfFPl//fT
         OeMAP4tKK+OGhsu0tFAIWksrzGcGzrQNrJqC2RIZWqn6+zrDvnW1Rq6IhboREAkmaRCj
         80Fn72fWSrwP/iTrKzKtwQTICNOcAPrqtMgkw9XPwRvlKb2eQayLhbKaFv+C+6DNYTZ9
         n7nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=Wnrof7f+RSnEBpZHdKhpLl9hIXM5sABs6ATXvkHzMC0=;
        b=Rp01ZEnmYBjNiIf24P+9sgFasM+1FJKwx1HdHgCcJQzu6Hfk8E17Tx4Er8dlflaRYH
         GQt0KS4b/LJev/sHTTlNwJPxkx+Tjcn8jEuAnjardDBa5Oo4pGnIxSCzvPm1bqocaVR/
         j2hdIIRQEIQdrEq8gPHQ4NCb25zyMAv1zPeLk4BtTIL+zXedIVvERNdEpWSq/+2RFt+W
         GsO49AE0nQTQxB3/PKQ+u9azYQ4C6t5iwQ9BA+TeXY8XfO+Zh6k3OMSCQ6WMkMqGi94H
         2j9hKC5CFnDc04tjZMfjvijupL673K2XGwG5fc0wUt8ZE4t0jidaWxKMIN1VSocHCTvw
         Z3Mw==
X-Gm-Message-State: AOAM5311Cxj/nnj8QFoiCENP6FN1uOiQjRDHfJMF1qVLazhGu22d+y5t
        o1Bf0XUUtMk2MSWpWtYeOho=
X-Google-Smtp-Source: ABdhPJxApIh6V8FSNSRzTbQv6UN/u0ZS1+yo0rfqLLjNSEIBR4SaCjpT6ukdl87As7NCwQ9m6yw/Lg==
X-Received: by 2002:a17:906:ecb3:: with SMTP id qh19mr20671847ejb.113.1626722502972;
        Mon, 19 Jul 2021 12:21:42 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w24sm8278200edv.59.2021.07.19.12.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 12:21:42 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/11] refs API: pass the "lock OID" to reflog "prepare"
Date:   Mon, 19 Jul 2021 21:21:43 +0200
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
 <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
 <patch-06.11-e93465f4137-20210716T140631Z-avarab@gmail.com>
 <xmqqfswanu4m.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqfswanu4m.fsf@gitster.g>
Message-ID: <87eebuw1lz.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 19 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Don't pass the object ID we pass into reflog_expire() back to the
>> caller, but rather our locked OID.
>>
>> As the assert shows these two were the same thing in practice as we'd
>
> It is unclear which assert you refer to, but a call to verify_lock()
> near the end of lock_ref_oid_basic() ensures this, I presume?

It's something I omitted by mistake, already fixed in the
soon-to-be-sent re-roll, sorry.
