Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E55CCA480
	for <git@archiver.kernel.org>; Thu, 14 Jul 2022 10:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiGNKtS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jul 2022 06:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiGNKtB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jul 2022 06:49:01 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D75310FC1
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 03:48:59 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id fd6so1874641edb.5
        for <git@vger.kernel.org>; Thu, 14 Jul 2022 03:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=5NsDLAEoN3YcGez76TT39aL41JqOHJ6pjyKo9w1Az90=;
        b=ZLpB5Nqu+VvdpKdkcv3EDZm2CkuJOXNCup98P4hrm4lIUIUa/FnykrE9ua0mdwVX75
         x8muKfyaNHU5cptKbl6+1fVR5HIUN6Bo6X2Z1vaDVavk+KMzK5JzET5wLvZASD1uxE4O
         fznKPsjy/zD7llKhx0+6vFw09umvGIif2O2qZIC2Ks3P5dxKmCvyN1tgeEMHky6cvIwd
         1WR+pu+hGociEzWpGZt+ljFwArAwE1YL4wQw8n8nC5Jl3B8WijuYr5tbLPktEVQGDB6a
         u4dNdW+hzLFm57zfhqEvEyiOHOU1Cr8yoLo+Bl0hFOxDfPP0ouDaVnFy37bEmx+mFOW3
         /zUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=5NsDLAEoN3YcGez76TT39aL41JqOHJ6pjyKo9w1Az90=;
        b=SXOmUejh/Y0N7QmvYMABAzHItdZFzU1rmU7AjMMDGvAQJCUdhcdNh+FWyyM3GGlC6T
         aZcbOdlc0D/2tV7udMEYRLayBXE4PsY4yXGP08yv/d2LLDXaYp1RVqUfyoc/Itiy8ZHW
         eeNruzZEpUNZYmKMRuuUOxGo6eNuv+GMLGDpSi1xlfl9s0QPFR0DWTuhGZ7FZ3BEy64N
         86ltbuIEFENFAt9pBIfz7o7KMf0rS9uvKzypywzMWfgr66hcfy81ZMB/YwGZahauqSPS
         j8s7vhG/YIfaGMmRb3sypronDJ+U/kv5CoxzQRq2Z+78xxLRnbYbgEPz5LGFa0LlBqdr
         wfCA==
X-Gm-Message-State: AJIora/fNspjmNWpQsMjaXJeMWLjbVCGakzg8JWH2bcFZpYebQGN6WeH
        Emq1yW8xQToWWNx/J8KyQIG/+Z+dmgQ2PQ==
X-Google-Smtp-Source: AGRyM1sedLMKgSFoG7sP0BBt1CqRKirHsilgcalrVWgxlMKvOwMRa4LuQ4iO3NYqkAZT5/ZvLpS2iw==
X-Received: by 2002:aa7:d9ce:0:b0:43a:6758:7652 with SMTP id v14-20020aa7d9ce000000b0043a67587652mr11558963eds.351.1657795738103;
        Thu, 14 Jul 2022 03:48:58 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id h17-20020a50ed91000000b0043a6df72c11sm817914edr.63.2022.07.14.03.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 03:48:57 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oBwOu-002DZ8-Kw;
        Thu, 14 Jul 2022 12:48:56 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Glen Choo <chooglen@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>
Subject: Re: [PATCH 02/11] submodule--helper: replace memset() with { 0
 }-initialization
Date:   Thu, 14 Jul 2022 12:25:42 +0200
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
 <patch-02.11-4049362e9b4-20220713T131601Z-avarab@gmail.com>
 <kl6lfsj4684n.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqqy1wwaey8.fsf@gitster.g>
 <kl6lbkts63fb.fsf@chooglen-macbookpro.roam.corp.google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <kl6lbkts63fb.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <220714.86v8s00y1z.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 13 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Glen Choo <chooglen@google.com> writes:
>>
>>> Ok. I wonder if we could reduce this kind of churn in the future by
>>> adding this to CodingGuidelines, e.g. "always use { 0 } for stack
>>> variables". Tangentially, do we require { NULL } when the first element
>>> is a pointer? (I'm not sure because this isn't in CodingGuidelines
>>> either AFAICT.)
>>
>> A valiable can legitimately be left uninitialized, or initialized to
>> a known value that is not zero using designated initializers.  So
>> saying something like
>>
>>     When zero-initializing an auto variable that is a struct or
>>     union in its definition, use "{ 0 }", whether the first member
>>     in the struct is of a number, a pointer, or a compound type.
>>
>> may be OK.  I do not think we would want to say "always use X", as
>> the world is not that simple..
>
> Thanks. Also, I made a typo here, I meant to be more specific with
> regards to memset(), like:
>
>   When zero-initializing an auto variable that is a struct or
>   union in its definition, use "{ 0 }", whether the first member
>   in the struct is of a number, a pointer, or a compound type. _Do not
>   use memset()._

It's curious that the { 0 } v.s. { NULL } form jumps out at people, but
seemingly not that you don't memset(&x, NULL, ...). I.e. that we're
already dealing with a form where C's "0 is NULL in pointer context"
rules kick in :)

So I wonder if we should say anything about the first member at all. On
the other hand this is quite an odd bit of C syntax, and reveals a bit
of on edge case or wart that I'm not happy with.

It's why I believe GCC has a syntax extension so you can just do:

	struct foo x = {};

I.e. 6.7.8.10 and 6.7.8.21 disuss the semantics of this, basically that
if there are fewer initializers than elements or members that the
structure is initialized as though it were "static".

But for the first member we rely on 0 and NULL being the same in pointer
context (even though NULL my not be (void*)NULL!). So it's a tad nasty,
it's basically doing the same as:

    const char *foo = 0; /* not NULL */

As an aside I wonder if we should say "C says this is undefined, but
c'mon, let's just assume '#define NULL (void*)0'". I think in practice
it's like the recently standardized 2's compliment, in that almost
nobody can even remember a platform where it isn't true, and none are in
current use (but maybe I'm wrong...).

Anyway, I was curious about this so I tried the following locally:
	
	@@
	type T;
	identifier I;
	@@
	- T I;
	+ T I = { 0 };
	... when strict
	    when != \( I \| &I \)
	(
	- memset(&I, 0, sizeof(I));
	|
	- memset(&I, 0, sizeof(T));
	)
	

Which aside from whitespace issues (that I've asked the cocci ML about)
yields a sane result.

What *doesn't* yield a sane result is getting rid of the "when strict"
there, i.e. we must not do this in xdiff/xhistogram.c's
histogram_diff(), as we "goto" to the memset() to re-zero-out the
variable.

But removing the "when strict" yields a change to 45 more files, the
initial one with "when strict" is 76 files. With the exception of that
histogram_diff() case (and I manually skimmed the code for the rest) it
passes all tests at least... :)

> Unless there really is a legitimate reason to use memset(&my_auto_var, 0
> sizeof(my_autovar)) that I've missed?

Basically no, except when you need to do the init N times, as noted
above.

>> We do favor designated initializers over traditional initialization
>> in the order of members these days, so something like
>>
>>     When declaring a struct/union variable or an array with initial
>>     value to some members or elements, consider using designated
>>     initializers, instead of listing the values in the order of
>>     members in the definition of the struct.
>>
>> would also be good.
>
> Thanks. If I have time I'll send that proposal to CodingGuidelines, or
> someone else can send it (I don't mind either way).

Sounds good!
