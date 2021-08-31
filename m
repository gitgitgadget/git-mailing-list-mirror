Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD74C432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0027A600AA
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 14:28:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237379AbhHaO3U (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 10:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbhHaO3M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 10:29:12 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1027FC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:28:17 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id l7-20020a1c2507000000b002e6be5d86b3so2729531wml.3
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 07:28:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=vQfx1yryYjrLnT4fjJ/E6C7rmUapUA+hD6vuVr8bCUg=;
        b=XICralStvSES1jo5STDFEkbJLo/XHcht1tsBR+Hs1tyR0wHRt55w1l1JAzk1+Kg38w
         ru1Hs0cGQpuPctag7WahtSc+zhTupQg/WG3kyYq9OeOVDyxWEnSoD5F16sf5NfO2BN3o
         ZI3k3+ZiYAZOtHkuPSB1tsWEAVi2LAxUKxQNC+YWomnRW3+w97eU1Id2JFPVSZRllmNe
         do36Z3wAhMlr34gvG8WhearVjUeTJDQyQL8r+L/2W3FXOz9l7pC6wIK9G4O5EK2/pqjs
         FJaKq8H66cXdu3QnhUwP17cLsfcUiWeJMw0vref9e41i54GjvlpWH9+liW9C2PJpSPCx
         RI0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=vQfx1yryYjrLnT4fjJ/E6C7rmUapUA+hD6vuVr8bCUg=;
        b=IVatMUBMsJtL2UJn9Jic0jXbUSB13s0AKrBhhru3ojMqjeZIf5tkKr5eQg/hDwFzxi
         XqZWN3BK7JYPK47Ge6bNhJkIx+Ju3mM7/U5QKaAiQRzb7WoakadpB7u6CyhxQX2AE2Im
         GhexecjPX32WCb6X7WT/4ZweVAHuZubpg4P5RZr/R3D0xg2xDJxJdalCfjyiuAXm9ZXK
         e9pSTcySMrhBCp1f95wZjgUJfkrGZXmpetM0NepeeqgG/mWo3B0XwkjtNZcRZ6wLn2jL
         LklZ/YgRv5XrCWN7T9NQardVTCMDiJuBnloPkJ4DUhZMuei4IIeGHd2JRhHiUXDojuMb
         qvXA==
X-Gm-Message-State: AOAM533bjLqp0+VJoeFUkIUihChvtF6sAL0c3G4DszYYre6/6oR9FZZN
        d572UM3kjnfamDs1D34otRA=
X-Google-Smtp-Source: ABdhPJwo4pdTTAZeaVBOfZLgexh1TjyHay2L7GpuPdSEwwV0a8ST5v27WCJCUZKrbiWF4zCLME9vYQ==
X-Received: by 2002:a1c:1d42:: with SMTP id d63mr4448769wmd.113.1630420095524;
        Tue, 31 Aug 2021 07:28:15 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w1sm2589041wmc.19.2021.08.31.07.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 07:28:15 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Stef Bon <stefbon@gmail.com>,
        Git Users <git@vger.kernel.org>,
        Bruno Albuquerque <bga@google.com>
Subject: Re: Exec upload-pack on remote with what parameters to get direntries.
Date:   Tue, 31 Aug 2021 16:23:34 +0200
References: <CANXojcyWnFY60bXG6MDS9WAYkcFQHf+Oef0VREBkvgsuX9e=Kg@mail.gmail.com>
 <YS0tNoAa/0VQe1OW@coredump.intra.peff.net> <xmqq35qq4t1x.fsf@gitster.g>
 <YS1DnGTDo5ZG8Iw4@coredump.intra.peff.net> <xmqq4kb639xt.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqq4kb639xt.fsf@gitster.g>
Message-ID: <87sfypwuwx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> Yes. At GitHub we actually have a custom endpoint which hooks up
>> "cat-file --batch" with a format of the client's choosing. That's what
>> (indirectly) feeds things like raw.github.com.
>>
>> I've been tempted to send it upstream, but it's pretty ugly, and does
>> give the client a lot of power (for now, the placeholders you can use
>> with cat-file are not that powerful, but if we start to unify with
>> ref-filter, etc, then we run into situations like we had with
>> %(describe) recently). Likewise, the v2 object-info endpoint _could_
>> accept arbitrary format strings (it's the same idea, just with
>> --batch-check instead of --batch).
>
> Yeah, the object-info actually was from folks who are interested in
> doing something similar, and it would be nice if we can share the
> protocol endpoint that is more suitable for interactive tree and
> history traversal to help those who want to do virtual filesystem.

While this is all clever, I think this discussion really suggests that
the first thing we should do is make the relatively recent "object-info"
protocol verb not a default part of the supported v2 protocol we ship in
git.git.

I.e. someone setting up a git server probably isn't going to suspect
that one day their server load is going to go up by some big % because
some developer somewhere is using a local IDE whose every file click on
a directory is a new remote server request (i.e. the case where
"object-info"'s functionality is expanded like this).

I found myself wondering this when reading serve.c the other day,
i.e. why we have "always_advertise" for object-info, but it seemed
innocuous enough given how it's described in a2ba162cda2 (object-info:
support for retrieving object info, 2021-04-20).

But just as a general thing, while I'm very much in favor of git growing
*optional* support for more server<->client cooperation and CPU
offloading, even things like "git grep" or "git log" optimistically
running server-side, I think those sorts of features should definitely
be off by default for the reasons noted above.
