Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 525B6C6FD1C
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 17:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbjCYRkp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 13:40:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjCYRkk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 13:40:40 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D25B745
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 10:40:38 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id x20so4863343ljq.9
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 10:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679766036;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TyvWri89g7IccIejaisLZaxUu+cJM/3j5BOPTEJFjTA=;
        b=H7hxpyRK6KMkdsWVY+5ryVheQYjH+BawP0TwC+aRckc8FuwHJkhcjUwlGcBXalUSsC
         bXv55RSn+C2pJHOU3/q4vCq98b2Qd3CR5HhciuB/LELha/BxQwJmSCepRVCPj772f/bD
         WSrzq/mW588/5jl/OOWoofIm2sbSJfOSDqj2pAg5ImPuLXVSHeodPWt5H7pJFTWP9nty
         5xuWGS2/N0xnR9+1UN+evXRoCHYG0/NZ0ODsAcgKZYmi2JSDHNGqpT6f1cZAubK3X/TJ
         qYLjz82CeRJNneQk6+lVxK71e86oSr3CL5d0Xq1SC5Ou99KTRMiY21y4wz5Hq27hvj1v
         +vTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679766036;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TyvWri89g7IccIejaisLZaxUu+cJM/3j5BOPTEJFjTA=;
        b=V024qX44NtdusG+wvrnI7fAIgDAOwK1oe6DavUhWh7m/gedK5ddQZhAoQbCSYHXsOi
         pO60/wvaZRKFZmKRx3h2s6RD6KKo6CGmZwTWp1hQT5GXX2eMSzzbKNEj45OuGQr/fL3j
         r03sV3qx1enrHYg7jOo2Us4D08w221+DRQTBE5xcPzjK4OlIXrjCGOdrqgIHYtjT2s8P
         5RZQM/jQuiPE3mEg5JnuH1FNtWMU1sMFSZt9WLPT2f7jgbwKl04Vv5jqHHbLsZsYIdzR
         M3NzEbtfK/o3E7hRP4ltnkz5l/Mm1qs4pZ7SVoFFuHKmUA+b2nNygPr8U8UfY5bmJzIA
         rN9Q==
X-Gm-Message-State: AAQBX9dFf4vQNOR+z7hGScMSU6YRyUfBCiD6O1VsVfcemI6GWNOKAuWk
        zL3PPEKMsIWpptOhHNuvbpajRm5vU2yHrA==
X-Google-Smtp-Source: AKy350amGknt9PP6ETxN0cKqc29U9NgL2o9NEPWLjJ7gez8qKN2lUVkuYM3pwUJ9ux0doz3TNz5qXg==
X-Received: by 2002:a2e:3a0f:0:b0:290:6af8:ec25 with SMTP id h15-20020a2e3a0f000000b002906af8ec25mr1750096lja.52.1679766036126;
        Sat, 25 Mar 2023 10:40:36 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (178235188095.dynamic-4-waw-k-3-0-0.vectranet.pl. [178.235.188.95])
        by smtp.gmail.com with ESMTPSA id t5-20020a2e9545000000b0029896643da2sm3922717ljh.126.2023.03.25.10.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 10:40:35 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What is the status of GSoC 2022 work on making Git use roaring bitmaps?
References: <858rfnb770.fsf@gmail.com> <ZBy18EBE7WM/E4KF@nand.local>
        <851qlfazzp.fsf@gmail.com>
        <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
Date:   Sat, 25 Mar 2023 18:40:33 +0100
In-Reply-To: <CAPOJW5x+yQsPxdwCWMT9AkMQhJyxKp5BiPXp_1PT6WwF7yF4YQ@mail.gmail.com>
        (Abhradeep Chakraborty's message of "Fri, 24 Mar 2023 09:18:24 +0530")
Message-ID: <85tty8afvy.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:

Hello Abhradeep,

Thank you for your response.

> On Fri, Mar 24, 2023 at 3:32=E2=80=AFAM Jakub Nar=C4=99bski <jnareb@gmail=
.com> wrote:
>> Taylor Blau <me@ttaylorr.com> writes:
>>> On Thu, Mar 23, 2023 at 08:26:11PM +0100, Jakub Nar=C4=99bski wrote:
>>>>
>>>> Could you tell me what is the status of the Abhradeep Chakraborty work
>>>> in integrating roaring bitmaps (using CRoaring) in addition to, or
>>>> replacing current EWAH bitmaps (using ewok)? The last communication
>>>> about this shows that the patches were on the road to being merged in,
>>>> see e.g. https://medium.com/@abhra303/gsoc-final-report-feaaacfae737 ,
>>>> but there is no mention of 'roaring' in Git's code or documentation.
>>>
>>> Abhradeep started working on a prototype to teach Git how to read and
>>> write Roaring+Run bitmaps in this series:
>>>
>>>   https://lore.kernel.org/git/pull.1357.git.1663609659.gitgitgadget@gma=
il.com/
>>>
>>> Some folks gave it a review, but there wasn't any serious traction and I
>>> don't think that Abhradeep has had a chance to come back to the series.
>>>
>>> For what it's worth, I would love if Abhradeep (or anybody else
>>> interested in working on this area) picked it back up, either using that
>>> series as a starting point or going from scratch.
>>
>> When I searched the mailing list archives, the thread was never continue=
d.
>
> Hello community,
>
> I have to apologize for the fact that I didn't continue the patch
> series. I wasn't involved in the community either. I am currently too
> busy to enhance my skills to get into a company of "my dream
> engineering environment". The problem is that it needs much effort and
> time to achieve that.
>
> I have always had a love for the Git project and the community. But
> unfortunately I can't contribute to it right now and I don't think I
> can contribute to it prior to my course ends (i.e. June, 2023). I
> would be happy if anybody else pick the issue and continue the work
> where I left off. I am even ready to guide/mentor/help.

Life happens; we can certainly understand the lack of time for work on,
especially as a student.

> There are certain things in my mind (other than roaring bitmaps) that
> I previously shared with Kaartik and Taylor. I will continue to be a
> part of this community and will make contributions after my college
> ends.

Thank you in advance for your offer.

[...]
>>> Abhradeep promised[1] that he'd include some performance work in his
>>> next version of that series. I think the main things we'd be interested
>>> in are:
>>>
>>>   - Does using Roaring provide a file-size advantage over
>>>     EWAH-compressed bitmaps?
>>>   - Does Roaring make it faster to inflate bitmaps? To deflate them?
>>
>> As far as I understand it, after reading articles about EWAH[2] and
>> about Roaring Bitmaps[3][4], the Roaring have the advantage that you
>> don't need to decompress (inflate) bitmaps to perform bitwise operations
>> on them.
>>
>> Run-Length-Encoding (RLE) formats like EWAH can be made to perform
>> operations without decompressing, but only if operations are symmetric.
>> The AND and OR operations are symmetrical, but AND NOT is not.  The last
>> is used by Git to find "want"-ed that are not present (not "have") is
>> not.  That is why Git needs to decompress bitmap and perform
>> operation.

At least that is why I think for any operations Git does decompress the
bitmap into an ordinary bitset / plain bitmap for operations.

>> If I understand it correctly, for both cases (EWAH and Roaring) you can
>> do membership check without decompressing bitmap.
>>
>>
>> [2] Daniel Lemire et al. "Sorting improves word-aligned bitmap indexes",
>>     arXiv:0901.3751
>>
>> [3] Samy Chambi, Daniel Lemire et al. "Optimizing Druid with Roaring
>>     bitmaps", https://dl.acm.org/doi/10.1145/2938503.2938515
>> [4] Daniel Lemire et al. "Roaring Bitmaps: Implementation of an
>>     Optimized Software Library", arXiv:1709.07821v3

The last work includes some benchmark.  I understand that those
benchmarks do not necessary match the particulars of Git's use of
compressed bitmaps, but they are there.

>>> Deflating bitmaps doesn't matter as much, IMHO, since that is a cost
>>> that we pay only when we first have to compress bitmaps before writing
>>> them. But if we could significantly reduce the inflation cost, that
>>> would be an advantage to using Roaring+Run bitmaps over EWAH ones since
>>> they would be faster to decompress at read-time.
>>
>> Well, if Roaring were to be significantly slower when deflating, but
>> only slightly faster when using / inflating, that would affect their
>> evaluation.
>
> IMHO, I don't think Roaring bitmaps would make any significant performance
> improvements. It may be faster to decompress, but I believe it takes more
> in memory computation than the EWAH. My biggest concern is its dynamic
> nature. It can dynamically change its underlying data structure into an a=
rray,
> bitmap or RLE. I didn't test the performance though and I shouldn't draw =
any
> conclusions about it.

Benchmarks results in section 5. "Experiments", in the D. Lemire et al.
paper "Roaring Bitmaps: Implementation of an Optimized Software Library"
does not include detailed information about memory usage during
operations (beside mentioning that BitMagic solution, which is one
solution they compare Roaring Bitmaps against, has exorbitant memory
usage).

However, there are some relevant results that can be found in this
paper, namely:

- Roaring had consitently smaller memory usage in bits per value than
  EWAH, though the difference is not large (e.g. 2.60 vs 3.29, or 0.60
  vs 0.64 for different examples of Roaring vs EWAH)
- time needed to iterate through all values was also smaller, for
  example 5.87 Roaring vs 13.1 EWAH
- EWAH, WAH, and Concise has terrible random-access membership check
  performance; uncompressed is fastest, but Roaring is only 20x slower
  than uncompressed (e.g. 3.74 for bitset[5] vs 63.6 for Roaring,
  vs 3260 for EWAH)
- for computing two-by-two intersections (AND), unions (OR), differences
  (AND NOT), and symmetric differences (XOR) Roaring is fastest or
  second-fastest after uncompressed bitset; EWAH is always slower
- for compting wide union of 200 sets, Roaring is generally faster (in
  several instances several time faster than alternative), except for
  two cases where is about 20% or 10% slower than best (but not than
  EWAH).

[5]: https://github.com/lemire/cbitset


> I am extremely sorry for the inconvenience and I hope you'll understand t=
he
> situation.

Thank you for all your work on reachability bitmaps.

Best,
--
Jakub Nar=C4=99bski
