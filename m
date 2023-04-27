Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51DAC77B73
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:09:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjD0WJh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjD0WJg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:09:36 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F7E359B
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:09:34 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6a5f7341850so7103373a34.2
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682633374; x=1685225374;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QqfC/liYBxvd6r/QFdmCxGopBE42hYyLyJH7i+6A8Os=;
        b=jvVQJyYsVjhbyYoXQet99ki/wKG3pPupOOxdoVfpBU9Ldu5vymGo1VpN9IUmQGbDmB
         1TQqFijOKyW3SAMhnp5QxJJ3JMDZpsbCFFGJk21t0WFU//MYcUEa1VJmn/tBTTu98sze
         weoSSl6340xyfdsYzK4tWzoxCVLu0TbIkASt6vdWcMJl0Rge+7mUjD1CpzL8kx8aCpqx
         5cr1j1LiGH+9/y5RjLRX2zqbxMEO/7KVwTK/hlg0/N2pFhNuB2pBeL7eCUP2JGzsy2ZK
         0x8+ue73fPgFVqX63i7H88MuY860TZk6yp1JPk40xv7r/gPLxUKfBX7LoW0G/5ow2DNW
         nQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682633374; x=1685225374;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QqfC/liYBxvd6r/QFdmCxGopBE42hYyLyJH7i+6A8Os=;
        b=aGL3gUsuUFdVoWL925z894Wolhy6la2qjb/WFf0ikVP9j/TmOZrWxFcNJi/wsRv/8u
         vS0CA2gZ0qvEywZb+3J6FRKi8xjDObD2wNQEHQvbncLHT4iYLfk+xzVDu/maMeorzF3Q
         GkYdWFE5nTP1x0/XxVsQk4CaH9Km3YlQaXIcEqzpKdBrqpGkHl1CpMVPKblvRahTErhx
         OH0g2Nnp3Kn8PbAxyKd7EOWIkr4Kv92Vh3V28fvALebCu2rf9+Atw9AMz3WqaRXa/R3o
         6s8rEvaCxLANr5srZmgaeSIVBmb7rzY52cu/26/MLdExrrY0ueoy91822/pjKB8N7xTc
         gbvQ==
X-Gm-Message-State: AC+VfDww49fk9AmkQ6ZX/luSKIyo5pQuQbQRsEYdt2VsEvrJHdMvEfCE
        E7J82WIql/X1NDb1NIC53BJzjWLvuGA=
X-Google-Smtp-Source: ACHHUZ6k9T6gkSZzK2hfEsI6LSeig8zv9MKDkygZo8RT3jMW85S9+MQYzRkwDeWisxdlPFTENhhezA==
X-Received: by 2002:a9d:7c9a:0:b0:6a6:23fd:3ed7 with SMTP id q26-20020a9d7c9a000000b006a623fd3ed7mr1659905otn.34.1682633374169;
        Thu, 27 Apr 2023 15:09:34 -0700 (PDT)
Received: from localhost ([2806:230:6026:c32c:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b22-20020a9d5d16000000b0069d602841e7sm6342379oti.72.2023.04.27.15.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:09:33 -0700 (PDT)
Date:   Thu, 27 Apr 2023 16:09:32 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
Message-ID: <644af29c8526c_7f4f2945f@chronos.notmuch>
In-Reply-To: <20230425061029.GA4015844@coredump.intra.peff.net>
References: <20230418070048.2209469-1-felipe.contreras@gmail.com>
 <20230418070048.2209469-2-felipe.contreras@gmail.com>
 <xmqq8ren8xz1.fsf@gitster.g>
 <644684018a766_aba29424@chronos.notmuch>
 <xmqq8reg96cu.fsf@gitster.g>
 <20230425061029.GA4015844@coredump.intra.peff.net>
Subject: Re: [PATCH 1/2] doc: git-checkout: trivial callout cleanup
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, Apr 24, 2023 at 05:02:25PM -0700, Junio C Hamano wrote:
> 
> > Felipe Contreras <felipe.contreras@gmail.com> writes:
> > 
> > > No, it's for the formatting machinery.
> > >
> > > The fact that both asciidoc and asciidoctor happen to understand our quircky
> > > formatting in this particualr situation doesn't mean it isn't quirky.
> > >
> > > In this particular case the parsers do understand what we are trying to do,
> > > because we just just pepper list continuations (`+`) everywhere and it happens
> > > to work.
> > 
> > I'll stop at pointing out that the first "no" sounds much stronger
> > than the text that tries to substantiate it, which says that the
> > machinery works fine without the changes.
> > 
> > > This discrepancy confused Jeff in [1].
> > 
> > And this is a good reason to add this change for humans.
> 
> Since I'm being used as the example, I'd like to point that I think this
> is somewhat tangential to what actually confused me there.
> 
> What confused me in that earlier message was that having "+" as the
> continuation between a code-block and its call-out list is odd, since
> "+" is about continuing a list item.

Indeed.

> It happens to work because we're in a larger list item,

No, there's only one list item, but yes, it works when the callout is inside
one.

The `+` is continuing the list item the callout list is part of, it's not part
of the callout.

> but it breaks when you put the two of them in their own block (which is the
> part that got me).

You only need to put one, but when you do, the `+` doesn't belong there as it's
not part of the callout.

> Using just a blank line between the code block and the call-out list
> (instead of the "+") works for asciidoc (it is happy to keep the two
> together) but not asciidoctor (it ends the outer ordered list before
> starting the callout list).

I don't know what you mean.

These are three paragraphs:

  foo

  bar

  roo

These are two paragraphs inside a list item with continuations:

  1. foo
  +
  bar
  +
  roo

These are three paragraphs inside a list item with an open block:


  1. foo
  +
  --
  bar
  
  roo
  --

If you are inside an open block, you don't need the list continuations (`+`).

Therefore a callout inside an open block inside a list item does not need continuations:

  1. foo
  +
  --
  ----
  line 1 <1>
  line 2 <2>
  ----

  <1> callout 1

  <2> callout 2
  --

Just like a callout outside a list item:

  ----
  line 1 <1>
  line 2 <2>
  ----

  <1> callout 1

  <2> callout 2

It's only a callout inside a list item with no open block that needs
continuations, just like any other paragraph:

  1. foo
  +
  ----
  line 1 <1>
  line 2 <2>
  ----
  +
  <1> callout 1
  +
  <2> callout 2

> So the second hunk in the patch, to drop the extra continuation between
> the code block and the callout, makes perfect sense to me.
> 
> The first hunk seems less obviously good to me.

I don't see why: it's exactly the same change: removing an unnecessary space.

Except that space is represented with a `+` inside a list item.

> We might say that it is good to always
> stick the callout list directly adjacent to the associated code block,
> since it does matter in other cases.

I'd say that is good.

> But dropping the blank lines between the paragraph-sized callout blocks makes
> the source less readable,

That is a value judgement. It may be less readable to you, I disagree.

I would expect the subsequent callout blocks as close to the listing block they
refer to as possible.

> and empty lines between list elements are a pretty normal thing in asciidoc.

Usually, yeah when these list elements are independent, but callout elements
are not independent.

To me this is perfectly readable:

  This is a simple example in sh:

  ----
  #!/bin/sh          <1>
  echo 'hello world' <2>
  ----
  <1> Shebang
  <2> "echo" prints

  This is a simple example in Ruby:

  ----
  #!/usr/bin/env ruby <1>
  puts 'hello world' <2>
  ----
  <1> Standard shebang
  <2> "puts" puts a string

Put spaces on the callouts, and it's the exact opposite:

  This is a simple example in sh:

  ----
  #!/bin/sh          <1>
  echo 'hello world' <2>
  ----

  <1> Shebang

  <2> "echo" prints

  This is a simple example in Ruby:

  ----
  #!/usr/bin/env ruby <1>
  puts 'hello world'  <2>
  ----

  <1> Standard shebang

  <2> "puts" puts a string

Cheers.

-- 
Felipe Contreras
