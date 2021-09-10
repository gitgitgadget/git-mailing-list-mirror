Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D6C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC358611BD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:46:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231583AbhIJRro (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:47:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJRrm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:47:42 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA720C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:46:30 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id am9so2542687ejc.7
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=WTRBIIlriteNtEergjkBCfCUFHgvkFXDJ4SKE+PtVPE=;
        b=dOGx1ATVhyg9h4AtcEtrf+fVoU4KzeAAjR7+ancEj3cqlTXj9/LSDeK3g1LtuU0Ne6
         b5par+cvAbo6rYL0UqDURs+Wx/UTNc0jiwC0yGKFH7Btvm7ENGlB+MtUJ2JojBWco65u
         9Flier/ggJJpwMKcn7si7M8KwKpxmzXxe0AdU3CoFGkPC+JMh9LomtmLQmy8FE2EFJap
         JJKAFBAOYnVKtfJXo0Fh/iti9/D/WxH1HuaRUYsPwhri+VvghxP6Ovl2QlR7w7doHHZH
         3spN+B5lXG3u1g0yGV6vQXYW+H1nO6BWY1iJF20IqTrq+BQdDscAMpuVKOjV+c5iq+ka
         ZzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=WTRBIIlriteNtEergjkBCfCUFHgvkFXDJ4SKE+PtVPE=;
        b=VwpLqs+VNbapW+heNq+1SYKaTXkUVV6FMB7/oEVxZbL5WKj4001Sb8fDPhzmholqmk
         ZkAhzY3WnvBmScaIogehS2m7MfBjrhqGl2GAFLcW339f/Dgep0cKOvE+4xolcDpDCW4R
         7woKQQKqkaRwjAdb2c1bQowYY/QXc+Iz7zfdrSZiPwzBWhBvgl5QwphdAI3hop6apRIW
         kqpv68n6DgloZSy/RovnvYa2WYRNCBveyuh0qUtZfkaUKGaAlD+0ytPtLZofGedELpaA
         kziM3Km0B9nDXM+IlqY7fPNoPxLp9+eF7JloGOQQN1KoismIYb48z/symt6YYoRBMGGZ
         h1Bg==
X-Gm-Message-State: AOAM532salEwNdyKuNQ3obBV1MQDJSb9+fIHBeoq6ETndXUD7ykaP5I3
        Ao8D+5lv6TaGz5GFBuE34MviWbQ0ixQUZA==
X-Google-Smtp-Source: ABdhPJwqEL0SrylLr8iNYcWp8XsxWLzkF1Zzo6uaMwfBiObbaDbRZyeTEKOo/JxgAtiVPwNA0tAddw==
X-Received: by 2002:a17:906:b18e:: with SMTP id w14mr11121415ejy.63.1631295989309;
        Fri, 10 Sep 2021 10:46:29 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id z15sm3126732edr.80.2021.09.10.10.46.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 10:46:28 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
Date:   Fri, 10 Sep 2021 19:42:45 +0200
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
 <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
 <xmqqr1dwtlt1.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <xmqqr1dwtlt1.fsf@gitster.g>
Message-ID: <87y284b9xn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 10 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> Version 1 of this had a really bad bug where we'd effectively make all
>> supported curl versions act like 7.19.4, i.e. the oldest supported
>> version except for a couple of our supported features. This is because
>> most of the things checked with the "ifdef" checks are enum fields,
>> not macros. So basically the "devil's advocate" Jeff King pointed out
>> in [2] was already the case. Oops!
>
> Wow.  Thanks for bothering to actually test ;-)

FWIW I'd tested that this worked for CURL_SOCKOPT_OK for v1, but there I
happened to pick one that *is* a macro.

Then I also tested GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY, which isn't,
but the way I wrote the code would have thrown a warning/error about the
unused variable, except in v1 I managed to scew that up in the last
patch, so we unconditionally used the relevant variable either way...
