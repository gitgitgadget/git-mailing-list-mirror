Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A73FC43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:41:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiFFRlc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:41:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiFFRlb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:41:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75B7A2EEBD6
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:41:30 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id 25so19532332edw.8
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 10:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ISxRpRhYdvGL06/r1MfAhf9F71IkaGJ+SKxZiTUXK4c=;
        b=HnGvRYAAMmn/FzykXDwxQqdhEqoF3CqHfPlhIsfriteT6R0MWL6M6c8abK2EXWmOJg
         l2V1UZhY4teowikxnhHL4bxtt0kCKQQsS+prUSS220I+eQ4gf9MYgjK+XmPLc9XGZdP3
         iiQ/XpmAklYSjUNAFAwAa3LNPZuML06EU/+kk5kwUYHNvszLVNNoojJBPKiAbCahG53Y
         /7aK9hg3H7lL2RoT71M+bi+1LPNKGPHxff5LNmZbYSfh64XNM0aUX+NQoIkyLiD33jAK
         154tPDRNNB2JoMHYUsovsXQTWJD8AETr5z7CFqgxHbp3GRiCrYCfLJ2Rkxg2Pfz75dil
         zdtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ISxRpRhYdvGL06/r1MfAhf9F71IkaGJ+SKxZiTUXK4c=;
        b=VfPmazJsJ/AznrkNcYNMLnOrvw5y69UKRs5uVvIZAEmweWwAzRX9Mbxmskkpvz9OOF
         7tQ+91Tn3s1xQwGdI+tlVPuDJ8CBZBF7A98V+tYHPSxqiF/rtWdFIO9Q4mORdRG9OVVC
         8ZFptlbEdOIuiKHMwSa6RZz8apBT1z3C3ETBeq79keV9/iKzZIeqzc0jJI129hoK6tOQ
         2m5O3gGcYbljqkM6vGf9cvwFDMT6OjIOg1yi6c2HLAQrFqEeyoXdemQiopifkPdpmOFG
         YEp8OURLpwlpmGZ6PDxnEEjLvsOdzUPxckfDtiMI2dyIJswzQcRERfBj587uYzCNYKVe
         C06g==
X-Gm-Message-State: AOAM531Yr0rl2FevzwGr1UC64xk160bG/Bu2HHFsTy7IeSZ0ktdMXZnF
        aXuWXuAGyE+EbOrBaJfhLBM=
X-Google-Smtp-Source: ABdhPJz/Ymf1MWfI8ABd7y69WhaEX5gt+1GsZ1gkATeKTTZwHRKQ7LjAsP7xW3sTLJu0VqgwYXE/Dg==
X-Received: by 2002:aa7:d14c:0:b0:42d:bbab:43d6 with SMTP id r12-20020aa7d14c000000b0042dbbab43d6mr28719002edo.15.1654537288853;
        Mon, 06 Jun 2022 10:41:28 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id u14-20020aa7d54e000000b0042e21f8c412sm6649483edr.42.2022.06.06.10.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:41:27 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyGjC-002ILi-Uc;
        Mon, 06 Jun 2022 19:41:22 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        Jinoh Kang <luke1337@theori.io>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Glen Choo <chooglen@google.com>, Paul Tan <pyokagan@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        Jeff Smith <whydoubt@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [RFC PATCH 03/15] reftable: don't memset() a NULL from failed
 malloc()
Date:   Mon, 06 Jun 2022 19:38:07 +0200
References: <RFC-cover-00.15-00000000000-20220603T183608Z-avarab@gmail.com>
 <RFC-patch-03.15-0b570d112fc-20220603T183608Z-avarab@gmail.com>
 <693ed3c3-535e-9eae-9fd7-ca612ebf6943@web.de>
 <220604.86pmjpw8h0.gmgdl@evledraar.gmail.com>
 <1de74bf7-0e75-8ae3-6ea7-62939b540061@web.de>
 <220604.868rqcwfnw.gmgdl@evledraar.gmail.com> <xmqq7d5tag3s.fsf@gitster.g>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <xmqq7d5tag3s.fsf@gitster.g>
Message-ID: <220606.864k0xwuyl.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 06 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
> [...]
>> The question shouldn't be whether those things in particular were worth
>> the effort, but whether the added safety of getting the new diagnostic
>> going forward is worth the one-time cost.
>
> Workarounds for false positives are hardly one-time cost.  They have
> to stay with us until the -fanalyzer gets corrected, somebody needs
> to remember to occasionally check if that happened, and revert the
> workaround to bring the code into their more natural form.  What has
> been good and readable for human programmers for a long time does
> not need to be touched just to work around a false positive bug in a
> new tool.

Yes, but I think in this case most of these are either 100% legitimate
issues, or things where we'd like to e.g. add a BUG() assertion anyway,
e.g. in the diff parsing case.

>> I find the warning output from -fanalyzer to be *really useful*.
>
> I do not mind if you add -fanalyzer during your build via your own
> config.mak file, and you would help them improve the analyzer by
> reporting false positive bugs while finding possible bugs in the
> code we have (like you did in a few patches in this series) and the
> code you are writing.  You are capable enough to keep your own set
> of patches to work around their false positive bugs locally.

Of course.

> But if you have to send in 15 patches with more workaround changes
> than real fix, then it is premature for us to bear the cost to have
> workaround for the tool.

The idea here was to send an RFC showing what it would take to get it
into a state where it would be more useful to others.

I.e. I've found it useful to run with it in my own builds and see if
anything crops up that's not on the whitelist, I was aiming to give that
to others with an easily tweakable knob.

> There are folks who use our codebase as a suitably-sized guinea pig
> to improve their tool, and we should not make it harder for them to
> do so, but our priority is to improve the product of this project.

Those people can still use CFLAGS=3D-fanalyzer

> Come to think of it, adding unnecessary workarounds is a hostile act
> to those who are trying to improve -fanalyzer, I guess, too.  They
> may want to fix problems in their tool, but workarounds hide them.

I'm not proposing that we do anything we wouldn't otherwise do to
appease -fanalyzer, but that we:

 1. Fix things it alerts on because we'd find it worthwhile anyway
 2. For the rest, have a macro to appease it.

That macro being similar to e.g. UNLEAK() in that we'd opt-in enable it
if you enabled certain flags, but otherwise we'd ignore it.
