Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE720C433EF
	for <git@archiver.kernel.org>; Tue, 12 Jul 2022 07:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbiGLHLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jul 2022 03:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiGLHLf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jul 2022 03:11:35 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB874275DE
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:11:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id b11so12667225eju.10
        for <git@vger.kernel.org>; Tue, 12 Jul 2022 00:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=KvHwjcA4i1WKRroo3B92lg9qx+TW/GiNXC5VmW+quCw=;
        b=lP1F1yL0X8hrNZCMRp4hSauq6Hnhvt2Du9hDQwcEE9IpY5JD5V+XnmvqKm2In/Jxe1
         ZhF8gzIhil1k0uaIwk8FsXYFzhW3ANsLaKtRRmDDZK7vKQB4lKAsTChQIvEozCNsxwMi
         K7BN1xb4ossPYlIZbkXHip6LKrDZGK05xWotfD4MMJVYH+NA4ZMyBTtTGaNNAEPDHJQx
         0Q9cxS3GQi/0xwhOLoM2Jr+X8FiYQoAAfHWqus9EvHVwKv364+zXHLDHW3RqYOgiSklg
         4idld/VVpDTl/PSn7Z5Dh8wFW7bJioztxkpHAhsPSjM7qsAlUvUuO+tnkSK/cn39Vvsn
         sx/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=KvHwjcA4i1WKRroo3B92lg9qx+TW/GiNXC5VmW+quCw=;
        b=hb3Lwby/27kTQlgkXz0Bnwe5K1hscoycmBcPAqfxDXpMuT1lrI1h5OXxsdh/aNbP+a
         QLiOrhE4qxfRoSVvVGtNfrJlfjIhJZL04dsH3xj6LZ/7v8K7rLKnvtyY2g5OXxv3sdPl
         FYFnRpmRN2qtcSLjh49SDzjZEjL8oxlmrGQdUkHWUcIeiDaW63bfbJgz7ZsHuY3V630f
         a1bvW802ArBbHIWopSk4KL57Z9X0yVXRZ7s9u4ZXTrvQ9ItiId0GezGdjwyO/xbYIKMf
         GxB3pQ5YrXOVt3kHEmwEyitl3XMu7JZJ/cZf/3Buc3xD1vw2pi0DoPrcnjdAT6ylGWP8
         6qKw==
X-Gm-Message-State: AJIora9EhrDCPdlhrNhEZT8WUPRagQiOwhnZUaN9g4JAEPuviYKN1caJ
        6qw1lVMHvlsGOrCqHIebuxp3ks9nT4VVtw==
X-Google-Smtp-Source: AGRyM1uoD+7J37oi+UtL6QnM911zcxWoYE/fwEUIkLEmXf390YnfciIdCMD+ViiSAoJjZRX1YobOyA==
X-Received: by 2002:a17:907:3e11:b0:72b:49d1:2054 with SMTP id hp17-20020a1709073e1100b0072b49d12054mr12446136ejc.78.1657609893312;
        Tue, 12 Jul 2022 00:11:33 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id fd9-20020a1709072a0900b006fed062c68esm3462465ejc.182.2022.07.12.00.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jul 2022 00:11:32 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBA3P-0019Bh-TZ;
        Tue, 12 Jul 2022 09:11:31 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 3/4] .clang-format: do not enforce a ColumnLimit
Date:   Tue, 12 Jul 2022 09:03:03 +0200
References: <YstJl+5BPyR5RWnR@tapette.crustytoothpaste.net>
 <RFC-cover-0.4-00000000000-20220711T110019Z-avarab@gmail.com>
 <RFC-patch-3.4-06d4b76a364-20220711T110019Z-avarab@gmail.com>
 <xmqqedyrmiu8.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqqedyrmiu8.fsf@gitster.g>
Message-ID: <220712.868roy6c0s.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 11 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:
>
>> As with the preceding change what this leaves us with an unresolved
>> question though, should we have some stricter version of "make
>> style-all" that incorporates "ColumnLimit: 80", or perhaps apply it
>> only on "make style", but then what if someone modifies code that
>> happens to e.g. search/replace a line running afoul of the limit?
>
> A more important thing to think about is that there is no single
> good cut-off point.  When we say "wrap your lines at around 80
> columns", we mean that when there is a good place to fold at around
> column 65 and the next good place is at column 82, then it is OK to
> go slightly over 80 and wrap at 82, which may be better than
> wrapping at 65.  If the last good place to wrap is at column 72 and
> the long function call at the end of the line makes you go past the
> 82nd column, wrapping at column 72 might be better.=20

There's the story of the sufficiently smart compiler, and now the
sufficiently smart formatter :)

The proposed solution here is to punt on it, which I think makes sense
if we're trying to push forward clang-format.

(Which I'm really not, this RFC is something I thought I'd send in
response to brian's proposal, as I'd poked at this locally a while ago,
after wondering if I could make use of it myself, and whether our
.clang-format was misconfigured[1]).

> I wonder if
> there is an automated formatter that understands this kind of shades
> of gray and lets us express that.

I don't think so, and setting the configuration to "0" is only a
stop-gap, after all we'd still like it to wrap e.g. lines of a length of
150 or whatever, if it finds them somewhere.

1. I think after I found that some odd styling from one of Han-Wen's
   patches was the result of running clang-format, cf.:
   https://lore.kernel.org/git/CAFQ2z_PAqW+RS2Znaf2wwOJfdNfkjP1VV84=3DxaPu_=
1EAuX+u5w@mail.gmail.com/
