Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF89C61D97
	for <git@archiver.kernel.org>; Sun, 29 Jan 2023 13:36:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232549AbjA2Ngk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 29 Jan 2023 08:36:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbjA2Ngj (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 29 Jan 2023 08:36:39 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 094A01CF4C
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 05:36:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id v10so8603430edi.8
        for <git@vger.kernel.org>; Sun, 29 Jan 2023 05:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TH4A0epdKZGSczFkZaVzP1kc5upecdDt0S+P8DTQiA0=;
        b=llq95dqRk/IljFyJEXScdIZyW7TSvJEEuT7ws/ub0UgH6Bs/mBoPlfqLszgJwMZGjS
         w9ATUTasliOjQpvkEEE+gTzaifgCCV0LRBzHR7HFZ+mvs2fQBdhhtvzAc3O/7y4ozeEL
         TZaZ+bm7haynSkoVtPXFqial6St8Y/iqIn2PzJOS7J7pz2I60JnbW37YfK7gCXBPU+x4
         JtmH3F/LD/eqf98r5SMubT0EaEEV5S5skkDSQ1dEebo/nbo7QVc1oZVEbNfkcIjU8dR+
         K0D7NOFbYjZR+1R44JKstuPZaa8aKYDEvO87YYX/Yi/nIV1zfN/B1Josgsgy/8Ckkpa8
         OYow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH4A0epdKZGSczFkZaVzP1kc5upecdDt0S+P8DTQiA0=;
        b=sMLnUqHEBmS9DM4EeASqW5PLmY6KxbIAw5C+S3dhYBwNVlDdFNv/RS9xnIw8cQsZa1
         rrB6bgkAjWFEXsrPsmAoYObEzvS0V/gD43TrGlpRRnqMNWWHFkDTJblgDRlVdzCGiNhi
         Q86mU3SGVrPtTZi5DA+edbL1qaUASNv3bfFyY4qHKZujE8vyhUpA3jQ2EiVTdVdiM+RJ
         eXeCuFluroi3yLrKB78gePwVVJSNQXDlKx0E+/NQbSoLNJXhBB709ZmTfhzBP+jiI68B
         Z/yMADdM013lnCX2Bb9Xq63sU1sgJhvzL0pblpX2bhT/9d8rPvd1G0YOLqGgao5FsKPY
         CRBA==
X-Gm-Message-State: AO0yUKWTIZ30nnnYb6lW/+GlPNoh3xljora5oQjtJUdRSgahRaaYkOMr
        6Dn8m7DN7P5a708x3hLKBHi34g==
X-Google-Smtp-Source: AK7set9rxB4k0t3LpCQQVcj591I0ibUlB/+uFmYaGbGLIAyl9CiZZzjpfOZYBpIbEDMfw580xHhZ4g==
X-Received: by 2002:a05:6402:b5a:b0:4a2:331e:85f2 with SMTP id bx26-20020a0564020b5a00b004a2331e85f2mr3420798edb.26.1674999396541;
        Sun, 29 Jan 2023 05:36:36 -0800 (PST)
Received: from ?IPV6:2003:f6:af40:8200:19e:ccc3:be2a:f498? (p200300f6af408200019eccc3be2af498.dip0.t-ipconnect.de. [2003:f6:af40:8200:19e:ccc3:be2a:f498])
        by smtp.gmail.com with ESMTPSA id cf8-20020a0564020b8800b004a18f2ffb86sm4375723edb.79.2023.01.29.05.36.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Jan 2023 05:36:36 -0800 (PST)
Message-ID: <adb5a43a-5081-4f60-d1ea-2a6511f858c0@grsecurity.net>
Date:   Sun, 29 Jan 2023 14:36:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v2] grep: fall back to interpreter if JIT memory
 allocation fails
Content-Language: en-US, de-DE
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>
References: <20221216121557.30714-1-minipli@grsecurity.net>
 <20230127154952.485913-1-minipli@grsecurity.net> <xmqqbkmk9bsn.fsf@gitster.g>
 <xmqq1qnfancf.fsf@gitster.g>
From:   Mathias Krause <minipli@grsecurity.net>
In-Reply-To: <xmqq1qnfancf.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27.01.23 18:39, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Yes, the "instead of failing hard, fall back" makes sense.  Just
>> that I do not see why the runtime test is a good thing to have.  In
>> short, we are not in the business of catching bugs in pcre2_jit
>> implementations, so if they say they cannot compile the pattern (I
>> would even say I doubt the point of checking the return code to
>> ensure it is NOMEMORY), it would be fine to let the interpreter
>> codepath to inspect the pattern and diagnose problems with it, or
>> take the slow match without JIT.
>>
>> What am I missing?
> 
> Note that I've seen and recently re-read the discussion that leads to
> https://lore.kernel.org/git/f680b274-fa85-6624-096a-7753a2671c15@grsecurity.net/

Ahh, so ignore my last advise in the previous Email. You already read it.

> I suspect that this auto-probe is related to solving "the user
> thinks JIT is in use but because of failing JIT the user's pattern
> is getting horrible performance" somehow.  But I do not think a hard
> failure is a good approach to help users in such a situation.

Yes, it's exactly trying to detect this case and not cause a regression
for users expecting 'git grep' to make use of the JIT.

So, beside the W|X memory allocation error, other errors are likely only
to point out limitations of the JIT compiler, e.g. the example I gave in
https://lore.kernel.org/all/2b04b19a-a2bd-3dd5-6f21-ed0b0ad3e02f@grsecurity.net/,
which is, admitted, a made up example that can easily be worked around
by manually prefixing it with '(*NO_JIT)'. It would be a pain having to
do that for *every* pattern, but only doing it for the pathological
cases should be fine. Otherwise more users would have run into it
already and complained about it, no?

> After such a failure, the user can prefix "(*NO_JIT)" to the pattern
> and retry, or give up the operation altogether and not get a useful
> result, but wouldn't it be far more helpful to just fallback as if
> (*NO_JIT) was on from the beginning?

Sure, if it would be required for *every*, i.e. "normal" patterns. But
always doing it even for abusive ones doesn't feel right.

> Also I notice that p->pcre2_jit_on is per "struct grep_pat", so it
> is not like "once we see a pathological pattern, we turn off JIT
> completely for other patterns", right?  That is, if you have
> 
>     git grep -P -e "$A" -e "$B"
> 
> and we fail to compile "$A" (for whatever reason), we could still
> (attempt to) compile "$B".  Perhaps $A was too complex or was
> incompatible with JIT combined with other options, but $B may be
> easy enough to still be JITtable, in which case we would match with
> the JITted version of $B with interpreted version of $A, instead of
> failing, right?

The current version of git would fail hard if it fails to JIT compile
"$A". My patch doesn't change that behavior and that's intentional, as I
share Ævar's thinking about falling back to the interpreter mode for
"complex patterns" (which means pathological cases, really) is a bad
idea. While we might be able to compile the pattern and run it in
interpreter mode, it'll likely have a *much* higher runtime.

Just to get you a glimpse of how much longer, this is what it takes
running the pathological pattern from above's example on git.git:

  $ time git grep -P "(*NO_JIT)$(perl -e 'print "(.)" x 4000')"
  Binary file git-gui/macosx/git-gui.icns matches
  Binary file t/t5000/pax.tar matches
  Binary file t/t5004/big-pack.zip matches
  Binary file t/t5004/empty-with-pax-header.tar matches

  real	44m42,150s
  user	577m14,623s
  sys	0m46,210s


So this grep run eat up ~9.5 *hours* of CPU time. Do we really want to
fall back to something like this for the pathological cases? ...Yeah, I
don't think so either.

Thanks,
Mathias
