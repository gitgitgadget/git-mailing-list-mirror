Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BF26C636CD
	for <git@archiver.kernel.org>; Wed,  8 Feb 2023 01:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbjBHBTV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Feb 2023 20:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjBHBTU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Feb 2023 20:19:20 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF762748F
        for <git@vger.kernel.org>; Tue,  7 Feb 2023 17:19:19 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id dr8so47378708ejc.12
        for <git@vger.kernel.org>; Tue, 07 Feb 2023 17:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GwKzVwAlE0wNI2rrZeDWj2lyXsFpWCORpEv+mdZFeU0=;
        b=Dx1bp6zkm+aNIyftHxhl8F70Cyt6a6EbNvuE6a7cr2SJA8dg3MT2+zVEqF41iCskMF
         lQaoZMni1zh3wCzcNs9S1HuoWVpjc8s7U7VUDacqhJ0RtYvcc+XQ4W8IlGPu/QeDWklb
         x30gBOX97fQGIWhIwLMVPEG3U1umURRajhL16mrDpAr1wZixBpprIljVK8Erd0mrDUwb
         GhlV8tmyE8oqT52G+FmfRLt1FdvX/qMp8gklg8FAQ3IHb5l2Dp5S0TOt/W5Y9A5PLAdA
         VmVarLJsQ2FkxO56EZ7x+9Y2X3gd5ozxk6f9LZQGFTPjYYwCCarKhymxLGokI/ekp3KY
         dsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GwKzVwAlE0wNI2rrZeDWj2lyXsFpWCORpEv+mdZFeU0=;
        b=n10A68euXXydwWl+I0DOwQbh6xcD4DgQK5GgExTIGxX82+SrchzBPsQBvk5F/SXnuT
         ecVZofB8Qvv2hUt4Sl/DokYm6p/Mrg7008v891D6A8zG1F7TQvekerBTkYUeDr32tM54
         Zx1LnVTTdC0MR7Lbaez5AduOdkrQZRFZsD6JSoE/dnAX+YxHzJOOfZo+7FkBYSVZIyu2
         XCyJH8IsrTp2srT7+lu0nJnoCc4qMjC+g7Qg66BO8Y+UyzqsWP2varR/oYXevZnqnZeF
         eOjsbOsA3mAXiBWiThK2fvkojV7dOdBSk9FPVd7e3n/4mq0K3VIdJxZCEfG3MGW0r1L3
         8Xkg==
X-Gm-Message-State: AO0yUKXaseld0nJSiLDrKLOhg84kO+ilobsdI8MSMCq0AE7AgF9nuVou
        YUs/GwxGBlUSZu1yFbbOPfs=
X-Google-Smtp-Source: AK7set89qWZLtiuFM14FWbAOBW3di/yzeSQetLXUAYX7TVPC1bKKzlpR0fBJnYD4D9G/7PefY95QCA==
X-Received: by 2002:a17:906:8a6b:b0:882:2027:c8e2 with SMTP id hy11-20020a1709068a6b00b008822027c8e2mr5553080ejc.56.1675819157532;
        Tue, 07 Feb 2023 17:19:17 -0800 (PST)
Received: from gmgdl ([81.191.238.7])
        by smtp.gmail.com with ESMTPSA id u11-20020a170906408b00b0088a694749f7sm7578785ejj.4.2023.02.07.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 17:19:16 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1pPZ7E-00193K-0o;
        Wed, 08 Feb 2023 02:19:16 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Subject: Re: [PATCH v2 6/6] imap-send: correctly report "host" when using
 "tunnel"
Date:   Wed, 08 Feb 2023 02:06:55 +0100
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com>
        <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
        <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
        <Y91J+P5P9gV1Dygm@coredump.intra.peff.net>
        <230203.86bkmabfjr.gmgdl@evledraar.gmail.com>
        <Y94866yd3adoC1o9@coredump.intra.peff.net>
        <230205.86ilgf7osb.gmgdl@evledraar.gmail.com>
        <Y+KYwsBjty0aaLes@coredump.intra.peff.net>
        <230207.86fsbh2nqo.gmgdl@evledraar.gmail.com>
        <Y+LNitGAude1vogv@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 28.2; mu4e 1.9.0
In-reply-to: <Y+LNitGAude1vogv@coredump.intra.peff.net>
Message-ID: <230208.86a61p0x9n.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Feb 07 2023, Jeff King wrote:

> On Tue, Feb 07, 2023 at 09:39:48PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> *nod* I'll just note that you elided the part where I noted that I don't
>> really care, and will submit some re-roll that's compatible with the
>> current imap.{host,tunnel} interaction.
>
> Yeah, sorry, I should have said "yes, thank you" there. :) I wasn't
> meaning to continue arguing, but just trying to answer your "how would
> they even find this?" confusion.

*nod*

>> I.e. if we just say that we're not going to support this use-case
>> anymore we can get rid of all of the OpenSSL reliance in-tree, except
>> for the optional (and hardly ever used) OPENSSL_SHA1, and
>> uses-only-one-API-function "HAVE_OPENSSL_CSPRNG" use.
>
> Yeah, getting rid of that openssl code is a reasonable goal. And this
> may seem counter-intuitive, but I'm actually _more_ in favor of that
> than the change you proposed here, even though it potentially breaks
> more users. That's because I feel like we're buying something useful
> with it, whereas with the patch we've been discussing, the tradeoff was
> less clear to me.

Makes sense.

> That said, it seems like there should be a path forward for supporting
> tunnels via curl, and then we could be getting rid of the openssl
> dependency _and_ all of the custom and rarely-run imap code.

I really think it's obscure enough that just offerng users a documented
way out should be neough.

> [...]
>   Side note: If somebody were proposing to add imap-send at all today,
>   I'd probably say "no, that should be a separate project, and you
>   should probably write it in some language that has a decent imap
>   library". It really has nothing at all to do with Git in terms of
>   implementation, and I suspect it's not super well maintained in
>   general. But perhaps it is too late for that.

I think it's a reasonable feature, but in hindsight our mistake was to
think that we should be perma-forking isync, which has since moved
on. I've used isync's "mbsync" extensively for IMAP in other contexts,
and it works well for that.

So if we were going back to the drawing board a "git-imap-sync" really
should just be something in our mail tooling that can produce a Maildir,
and if we wanted an IMAP helper it could invoke mbsync, offlineimap or
various other "maildir to IMAP" bidirectional syncing utilities to
"send" via IMAP.

So, just some hook support for format-patch with some documented
examples should do it, but I won't be working on that task...
