Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78690C38147
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 23:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbjARXGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 18:06:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjARXGw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 18:06:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F8E539A9
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:06:51 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qx13so1142505ejb.13
        for <git@vger.kernel.org>; Wed, 18 Jan 2023 15:06:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ji5pzq5L1+K9maEXP8r74KTSLNlItLlPQ74kh//b+Hk=;
        b=bGtohdOWlGhZRWzXnU20LWfsFTOfGIBOAvlj0nsKPr1Dzs5PBnbywjz2TFUTIBLEGm
         vZUrUIVP8+1PJEqrZOtYU8J7tAc6+0GRypofLhoC9oRm+sJi6zFya2sHX4gBQzp9kJJy
         QgX0dLMRGZp+rwtdPgHLwCYSDTc3sSx0PH5FkpIHMU2JE9gVn//MfJzBWFFgHxtWnkEP
         ccdDPR+loeGwhvdsbNIEWKzsIzq/WzmBzMsKWRtNnpPeL6WA/9xxdWA0lfluv4djoxxb
         5uKCIIVImi7RK031GzlysoxjciTjY/ctT/KZX6KSIn2B9qmwKaSQXen9KKFzLkr1KYTO
         0FcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ji5pzq5L1+K9maEXP8r74KTSLNlItLlPQ74kh//b+Hk=;
        b=JNsoY2W4eKniYaeHbYMgpEbPF87R1ryp8VlzbE1HME3fEsEM0xD+rGYpCODae5r9/A
         bPYPJp1FJth24WBLBUG5R/JSdNrixQ/N8PQc25M3NEBAjPOIDSlA8nFiuPYFNlfHd0uN
         ledMdc4k6ff13sJbH3gz16RQMRcp4BOlcnlYsoZXwR/Kv2nQN4dGgfCC69e7OlrodrrA
         3+fHmMWMjceaeZ2BdM02n29HGSan+eCOhjwNJ5wb+sah5QU4jmpFEg5gPzODhmxXHLxE
         tR2HZzDbsu+Lnq2i6eb2MEDEURaGmCtSozlayE2lx3GQyUp2x/26vWOdGAerd7GjrRnD
         s+5A==
X-Gm-Message-State: AFqh2krQ2BrrIzMVtdFFeUEAMSS6oXHatUxrXyJpN602dX0/P4w5OfvX
        XrJoxdTXRX7oSzKGWxxpmo8=
X-Google-Smtp-Source: AMrXdXvfG7LxWVC94n7sIBQqrtBte+76sQhHgaq30Zm0qTWplhuPbJZtoWUakcnJsmM95/0UWJv7Kg==
X-Received: by 2002:a17:906:b14b:b0:864:1902:7050 with SMTP id bt11-20020a170906b14b00b0086419027050mr8530775ejb.69.1674083209494;
        Wed, 18 Jan 2023 15:06:49 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id o11-20020a170906768b00b0084d242d07ffsm14944936ejm.8.2023.01.18.15.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 15:06:48 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pIHW4-003C5a-1f;
        Thu, 19 Jan 2023 00:06:48 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Carlo Arenas <carenas@gmail.com>, git@vger.kernel.org,
        Diomidis Spinellis <dds@aueb.gr>
Subject: Re: [PATCH v3] grep: correctly identify utf-8 characters with
 \{b,w} in -P
Date:   Thu, 19 Jan 2023 00:06:43 +0100
References: <20230108155217.2817-1-carenas@gmail.com>
 <20230117105123.58328-1-carenas@gmail.com>
 <230117.865yd5z4ke.gmgdl@evledraar.gmail.com> <xmqqr0vt9oj9.fsf@gitster.g>
 <CAPUEspgzrW63GgbjXhKuvjpKXjEhiKaC7jtupiB-3AhcKTba8A@mail.gmail.com>
 <230118.86tu0ovyvj.gmgdl@evledraar.gmail.com> <xmqq7cxj6chn.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <xmqq7cxj6chn.fsf@gitster.g>
Message-ID: <230119.86cz7bwign.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jan 18 2023, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
>>> GNU grep -P has no knob and would likely never have one.
>>
>> I think the general knob in not just GNU grep but GNU utils and the
>> wider *nix landscape is "tweak your LC_ALL and/or other locale
>> varibales".
>>
>> Which works for it, and will work for us once we're using PCRE2_UCP too.
>>
>>> So for now, I think we should acknowledge the bug, provide an option
>>> for people that might need the fix, and fix all other problems we
>>> have, which will include changes in PCRE2 as well to better fit our
>>> use case.
>>
>> Hrm, what are those PCRE2 changes? The one I saw so far (or was it a
>> proposal) was to just make its "grep" utility use the PCRE2_UCP like GNU
>> grep is now doing in its unreleased version in its git repo...
>
> Yeah, I didn't understand Carlo's comment in that paragraph at all.
>
> In short, it sounds to me that the earlier one that added PCRE2_UCP
> unconditionally would be the best alternative among those that have
> been discussed.

I agree.
