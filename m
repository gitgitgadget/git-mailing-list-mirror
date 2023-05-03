Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D87CAC77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 13:46:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjECNqP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 May 2023 09:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjECNqN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 09:46:13 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C734B1A5
        for <git@vger.kernel.org>; Wed,  3 May 2023 06:46:09 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id 006d021491bc7-546dad86345so3681075eaf.0
        for <git@vger.kernel.org>; Wed, 03 May 2023 06:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683121569; x=1685713569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tRQIt00fj8U2dc5+4/DKM9C+GIa61RRyxvlF9V8tWCw=;
        b=G31PV534/F2a3/wCtov/jl75e6D7cnjVrxajKmeSHK71KWwZtShNfrK9hbtSNWw1jM
         w9UUEkmEZnZllYqbnlLG9rf1mJeMwgmdjyBO1Lj9ewZaFH1D7QtMFGGyunMEGNbkLNPr
         wAoraGF/05JB9qeThYB8n1pRwV4+XEPT3ds38ZweRGRQrhjgsUf2n8V2O//VQNrfZ8ZE
         3id7yttuAE8ySs6VxsQALSDpYZ+9Bm1UprwSikhBcl2UD/e8w52Gr97kmh5brwGVlq1l
         xESDwnPZUGqx1+yAZo4uP0WM1aWCEw9KId2yX9LDXQeLCIwlTO1ix+Ic6NobfOAmHTj/
         QVcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121569; x=1685713569;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=tRQIt00fj8U2dc5+4/DKM9C+GIa61RRyxvlF9V8tWCw=;
        b=hF140gu4fd5yBJ2pxlrxf/vTkijenSAUR3Q0GcDPoNhWQ/c3AkgLkB9XTBa7hsvGJW
         EN2nVJ/SgbYQ0WY4Bzk7ImjjCXsHvEshym6qxWuOOR/hbE9QtJjl0ZXe3siJKAavgmDm
         lRTkWFh2vG2eVH4/LRRaxOXrO4AWqG8/JroJo1andd9NWzPlc1JRLIQ0dUY52HcHlgbK
         GDVvgBk7GyDaedqZMSEPSwn9pkZg1IPALcnaphoCHm2CJw65IGN4TGLVwNQSwSgEA97M
         pXWYezU99CKkyx0KxoogGEA0uTWmjHKqr2GQg7BUf52xlDBxmBraKBrkmaGju0EPyFjf
         ePqw==
X-Gm-Message-State: AC+VfDzJHFV5eTtYmPczUajh0LMKxJq3w6A4LaAUARFeiNiCc3JK5qUA
        O5Z6ukRhSYfcYfMs4Rq6wA8=
X-Google-Smtp-Source: ACHHUZ4eAMd7lOrj0DT9g53Mjkar3bBU9X1h3PGtlWRPTpUcjrJ94T5Xord6ukw7anjNJ7LUCMfmRQ==
X-Received: by 2002:a05:6808:1ab3:b0:386:8c30:6e92 with SMTP id bm51-20020a0568081ab300b003868c306e92mr65296oib.14.1683121568966;
        Wed, 03 May 2023 06:46:08 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 1-20020aca0701000000b0038eb56f5b87sm598271oih.47.2023.05.03.06.46.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 06:46:07 -0700 (PDT)
Date:   Wed, 03 May 2023 07:46:06 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <6452659e704df_682294b6@chronos.notmuch>
In-Reply-To: <xmqqpm7ivtd0.fsf@gitster.g>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
 <20230425061029.GA4015844@coredump.intra.peff.net>
 <644af29c8526c_7f4f2945f@chronos.notmuch>
 <20230502101854.GA1180695@coredump.intra.peff.net>
 <xmqqpm7ivtd0.fsf@gitster.g>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> > Using just a blank line between the code block and the call-out list
> >> > (instead of the "+") works for asciidoc (it is happy to keep the two
> >> > together) but not asciidoctor (it ends the outer ordered list before
> >> > starting the callout list).
> >> ...
> >  $ git checkout hello.cgit checkout hello.c            <3>
> >  ------------
> > -+
> > +
> >  <1> switch branch
> >  <2> take a file out of another commit
> >  <3> restore `hello.c` from the index
> >
> > which asciidoc renders the same, but asciidoctor is not.
> 
> Yet another random annoying differences that explains why we wrote
> it that way in the first place X-<.

I don't think so. This is the sequence of events:

 1. 1e2ccd3abc (Documentation: more examples., 2005-12-12)
 2. 1be0659efc (checkout: merge local modifications while switching branches., 2006-01-12)
 3. 48aeecdcc1 (Fix up remaining man pages that use asciidoc "callouts"., 2006-04-28)

In 1 "callouts" were added inside the listing itself, so they were not actually
callouts, the space was added just for formatting. In 2 other examples were
added, which transformed the original example to a list element, and everything
was peppered with `+`. Finally in 3 the code was transformed to actual AsciiDoc
callouts, which meant that the original space that previously was protected
inside a listing block would not be protected anymore, so it could either be 1)
removed or 2) converted to `+`.

In the thread that added this `+` [1] I see no discussion about the
alternatives.

At no point did anyone consider using a newline inside a list element, because
spaces inside list elements don't work, so the actual two choices were:

A:

  ----
  line 1 <1>
  ----
  <1> callout 1

B:

  ----
  line 1 <1>
  ----
  +
  <1> callout 1

And there never was any actual reason given as to why B was "chosen".

I think the reality is most of the AsciiDoc code doesn't really have any
consideration as to what is the actual AsciiDoc syntax, it's there because it
seems to work, and that's it.

So I think the real reason is that a newline was there before, and newlines
stop list elements.

It couldn't have possibly been because a newline didn't work in asciidoctor,
because asciidoctor would not have been created for another 6 years.

> If it has been removed to make it not to matter, that was lucky of us ;-)

Only if following the actual syntax of a language is considered "luck", in the
same way that it's "lucky" that following the C specification makes C code work
on most C compilers.

[1] https://lore.kernel.org/git/BAYC1-PASMTP028F5C1C39F7EF6A6EEB95AEB20@CEZ.ICE/

-- 
Felipe Contreras
