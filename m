Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7662C433C1
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:19:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7029961A18
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 15:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhCZPS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 11:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbhCZPSx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 11:18:53 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC7AC0613AA
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:18:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id o19so6746623edc.3
        for <git@vger.kernel.org>; Fri, 26 Mar 2021 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=gCY6cK8yS8GSwCNXVKlWeClTS9uAsoAiyLjbamOo1EY=;
        b=iAj5q1YK3kCBw9/mxxgbMKi5DM17lxePkVGRUVWmSjwrG3j1imqQmLeD4b1icKjExy
         h4AMWvR9jHY1o4HnjlsJQ4vxnd6u91Bg7eqiKViMWerG2yORrubVcUQxvk4IceCGvRe6
         d3rlskb8vOwkM2K5gJ72y5URJ0vXFAiUG1O2WssWen3z4rkN1uLIgOdJmZ7x3dVYfn/C
         ZcGTj/nL8L83vEFKXfAWNX/BxGtNXPXV5iaTa0lhbekCFwUXnGJXCpkdp2qZaojG0TVs
         VAgIc2znpbCvLk8WWcfjo8cZANTfpVNG2j30MWU1YPv2ZVbHOKJZwjIPxGc0nLXySCM2
         yVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=gCY6cK8yS8GSwCNXVKlWeClTS9uAsoAiyLjbamOo1EY=;
        b=Wh0V/Cy5Ji3msT64Vr01KdG6EDV507sEgEpNYQFzA8ozCF/WAraL4cw2qfVuRYg5Rk
         sXUfKY20t6HcKh1Knx79YxWI5U5QawY/3/bTzv7vphQzdiTKi+aDkgz0ERoKDd7uBPAP
         wT0r9G+3BXO+6v/sEn5NBKfn/6cLxusGLl9wR9HvL5k0ogGHDfQMuYdS3yL0ExsBCkcH
         DyV2k4pBqm68iWAUhNk+J1skBYgqWmz7jGqfMKaeZVQi/JS3XqCckNjVtYJ+TAVtt/4Z
         GTs4XSAMRXRMplgZH3KjGbaJlE2FtjWLYTofQqwbEnOSuvQuu8zRUR96pqZAxyTLpq35
         n0vw==
X-Gm-Message-State: AOAM530Zgdi3avlsWz0WbL+NRQu8FPQ+A7uG6SJ8AaSiWs77LTYn5O7V
        RMX9Sd0chXphv+yu5RlVeVE=
X-Google-Smtp-Source: ABdhPJzJyQSyXxRSH9LD5l+uct+LsGrwKRfqXE3et9eqUxnTSMzFtV8+urMxnm7M/uSXIkQEu9PMPw==
X-Received: by 2002:a05:6402:3550:: with SMTP id f16mr15561262edd.134.1616771931802;
        Fri, 26 Mar 2021 08:18:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id n26sm4381974eds.22.2021.03.26.08.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 08:18:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 0/5] small doc make and lint fixes
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <YF3AGsFFX3FQ1/ew@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <YF3AGsFFX3FQ1/ew@coredump.intra.peff.net>
Date:   Fri, 26 Mar 2021 16:18:50 +0100
Message-ID: <87sg4indt1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Mar 26 2021, Jeff King wrote:

> On Fri, Mar 26, 2021 at 11:36:45AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>
>> A small stand-alone series of doc infrastructure fixes. 5/6 fixes an
>> interesting bug that's been missed since doc-diff was introduced.
>
> I'm not sure what you mean about doc-diff here. Patch 5 (of 5?) doesn't
> seem related. Patch 4 is related only tangentially, in that you might
> have more stuff in your Documentation directory.

That's how it's related, the lint script recursively looks for all *.txt
under Documentation/, before doc-diff we could safely assume this was
*.txt at that version of the repository, after doc-diff our recursively
search leads us to a different checkout at a different revision.

I don't think it had any practical effect, just say'n.

> That said...
>
>>   Documentation/Makefile: make $(wildcard howto/*.txt) a var
>>   Documentation/Makefile: make $(wildcard <doc deps>) a var
>>   doc lint: Perl "strict" and "warnings" in lint-gitlink.perl
>
> These three look obviously correct.
>
>>   doc lint: fix bugs in, simplify and improve lint script
>>   doc lint: lint and fix missing "GIT" end sections
>
> These two seem fine, though I left some comments for possible
> improvements.
>
> -Peff

