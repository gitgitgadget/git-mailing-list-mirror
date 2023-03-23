Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE055C6FD1C
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 21:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbjCWVXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 17:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229734AbjCWVXs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 17:23:48 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E346EA9
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:23:47 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id gp15-20020a17090adf0f00b0023d1bbd9f9eso3267946pjb.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679606627;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jf/7qmr0d7xCiNYuEy9cZmJPC7tXZmgNgBJVtDjP1Ag=;
        b=m9mqq/SGPoTreieAOKoEajpdo5t1Wa98WON9S5fx6rT0gvNwpeqeRdBnymZ9EsS8H5
         FjJjAv22Aafq71zqXXQBuSnW/jMt04mvuVD3Euapp6Q0TumY0dXCmWjoly7w/iXDs8tW
         YjwY0TL0b5FX0w2rM5GD8ZVE3N/+wxZ9V/oHHYLCqPJkM6nOs3u0GyViYwSJwFT4roGk
         QLYz7xr2eXgW32TKSs/WhqNmrzO1o2dU9pmJcrRbqT++0YsnX1f6dNFVVMfHi06EXOUS
         1O2ohe7wEbjaQgk+Z9ZMw29ydstNhk7ewwbE6UjpdwfJzX4kCxVLHL27OFoyaLprQHEH
         xMkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679606627;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jf/7qmr0d7xCiNYuEy9cZmJPC7tXZmgNgBJVtDjP1Ag=;
        b=FHQD5izc653b8pLRKmOmw0SkNLxSObP28CqaeOwubb2A7ZfiSre1ysqvlKVIo9knPe
         T3DGpj4MPSzNV3c4HbVgnnwotJl9yY8Dgdrh0ywJu2USexzwiKHI3q/sv1j/LB+SGgv0
         Pm5+0kp0HuT8BQR2gHw8Vc5Lm03s7vOb2GNq0Q6aOw/A8cQSRELTxk+xBVMyI2+joI9+
         Q4IUhMPtGAlU0r8eXki72ShMROHyCvU6IjSpVji2mITTJ6XhWhns2fSmw3l/uL2fbKUz
         b2nPEy5d3bhThR8Gyc4DSIm+0hRvLY0DhtjaPjoUhf6PXqEhWtf9sdUosXUSAHrmbdou
         1uFg==
X-Gm-Message-State: AAQBX9c87HTJJTv0WZ32wbj4AkUu7+SgJsOd2hmxY7Ox/1ivJTtZbucT
        tsUhHgApNP2dfOGbnt7eMXM=
X-Google-Smtp-Source: AKy350ZizVVNPaYySF7eQpg8PycpY5fruqe5F8YBWjklBEWxH0HgZ3Tdt/gcgNH8AU00TD0bmwqF/A==
X-Received: by 2002:a17:90b:4a45:b0:23d:1fc0:dd1f with SMTP id lb5-20020a17090b4a4500b0023d1fc0dd1fmr258437pjb.38.1679606627062;
        Thu, 23 Mar 2023 14:23:47 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id m3-20020a170902bb8300b0019a7d58e595sm12746465pls.143.2023.03.23.14.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Mar 2023 14:23:46 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] pack-redundant: escalate deprecation warning to an
 error
References: <20230323204047.GA9290@coredump.intra.peff.net>
        <xmqqlejn6vb9.fsf@gitster.g> <ZBzBr1EAXoqBwmVo@nand.local>
Date:   Thu, 23 Mar 2023 14:23:46 -0700
In-Reply-To: <ZBzBr1EAXoqBwmVo@nand.local> (Taylor Blau's message of "Thu, 23
        Mar 2023 17:16:31 -0400")
Message-ID: <xmqqh6ub6u1p.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Thu, Mar 23, 2023 at 01:56:26PM -0700, Junio C Hamano wrote:
>> Jeff King <peff@peff.net> writes:
>>
>> > I was looking in this file recently, and was reminded of the deprecation
>> > plan. The two data points above do give me a little bit of pause, but it
>> > seems like the current state is the worst of both worlds: we do not have
>> > the benefit of dropping the code, and people who try to use the command
>> > have a bad experience. So we should probably either proceed (as with
>> > this patch), or decide we need to keep pack-redundant.
>>
>> Sounds like a good thing to do.  Will queue.  Thanks.
>
> Yeah, I agree with and am persuaded by the "worst of both worlds"
> argument. I think that changing this to a die() is sensible for now.
>
> At what point would it be fair to drop this builtin entirely from the
> tree?

I notice that "git pack-redundant --help" does not say anything
about its deprecation.  We probably should add one together with
the patch in question, and then consider that the count-down timer
has finally started.

The timer should last probably for at least a few cycles.
