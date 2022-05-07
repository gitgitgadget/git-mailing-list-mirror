Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE18FC433F5
	for <git@archiver.kernel.org>; Sat,  7 May 2022 11:57:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355041AbiEGMAy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 May 2022 08:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446309AbiEGMAv (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 May 2022 08:00:51 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F5B48392
        for <git@vger.kernel.org>; Sat,  7 May 2022 04:57:04 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 31-20020a9d0822000000b00605f1807664so6707101oty.3
        for <git@vger.kernel.org>; Sat, 07 May 2022 04:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tZPQaW1n9NC9lerXa1z+tHTTdtjA/njhDO1bzCCs6LU=;
        b=a7tL+OahIamM3mrUHkmo6sLTTGzny5oplxQGue2fgZmM7TCWZFFLBPBgkpGwFtUi77
         Q9vYVkZqlE8ziiO/1rvyYyjJofg1vLBIOrtvXsjKJQgraORwiaCbcGxy6QEHXM3v42Kt
         z5wWR2B6Ffi1z56zwPaG2dMTO+/zZ1aWNbYOSqWSfapDStsyaZbhPxGiZLXMT1CWcSPk
         o0GPadlsFzNKYQZ6/tX/XG2NKNN782UC+7+79E0pwgMPMNXaadRScvf9QOmHKrSncy5H
         NveKoE8c3GE8EUYtOAEMENSih2k+Jk6dJ2io1sTube9ueu5V00/eh4k55Vim9ZQwE1Nq
         wVNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tZPQaW1n9NC9lerXa1z+tHTTdtjA/njhDO1bzCCs6LU=;
        b=Ntg3gdkMsOtTTVlioVOO6sCLL+8R1CTKBQuPnGf7x9rplDij8ZYs+7hpGqH41jYqj2
         4g/bFjk/ZsMJTDIbNWMbw+EmUctuDd5/FpFCNLU7gNQXCzJ4PA0OlwbfYo6p+QxKX5sf
         nFCo4Vcop5VGCPY5I9ZXK6I0bJ9I67zjbh9pTJI3xePBFrysLV50V7Rw8BakpwWT1kuc
         evWOo50OpI0tu9L/J3mZy5PwlekKwtdl2+VoaB3zT5+kpGmq7L9YevrMZMk8jzJQf9ov
         Ll6HaZH/OgEbdd1d0teykan/r2LlWarUdzzr6EtqfdNA8xIV8Ciwy+8t1mwTmJH2LBg/
         KxBw==
X-Gm-Message-State: AOAM531jocLuHtoixD/Glaaiq29wniAiQah9YEMCbt7C6PwyHCUDBRqL
        0EfcNRbXBQnJNbn/STho8iM=
X-Google-Smtp-Source: ABdhPJzRqgDhXMn/EJy0VrAAH1v0x1T5RhifyhwEBbMlFnmeLfdTESw7whS5zr+xpV+Tm0hUYJIG8A==
X-Received: by 2002:a05:6830:19f3:b0:605:fd48:7fed with SMTP id t19-20020a05683019f300b00605fd487fedmr2636819ott.382.1651924623604;
        Sat, 07 May 2022 04:57:03 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id r22-20020a056830081600b0060603221261sm2645844ots.49.2022.05.07.04.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 04:57:03 -0700 (PDT)
Date:   Sat, 7 May 2022 04:57:01 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running with
 sudo
Message-ID: <20220507115701.nozz53t4j52r2xon@carlos-mbp.lan>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
 <20220428105852.94449-4-carenas@gmail.com>
 <xmqq7d79du6c.fsf@gitster.g>
 <5493b2f1-e59d-d91d-ac21-47c93d2996f2@gmail.com>
 <xmqq7d79gjre.fsf@gitster.g>
 <CAPUEspibV6LKVAGpUPBoDYWvF7cjBJUJOSMDzLY6ErMF8s-Eng@mail.gmail.com>
 <xmqq1qx6jq0b.fsf@gitster.g>
 <CAPUEspjOPNTMrBdLQMKcbXYY7G+Vm1br++7C3rq6Bs+5xZ4yHg@mail.gmail.com>
 <xmqqfslmi5c7.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqfslmi5c7.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 06, 2022 at 04:55:36PM -0700, Junio C Hamano wrote:
> Carlo Arenas <carenas@gmail.com> writes:
> 
> > true, but the apparent check for ULONG_MAX (which should have a
> > comment added) was really a check not to overflow when assigning the
> > value we got into uid_t, by sacrificing an unlikely to be valid
> > ULONG_MAX as an uid.
> 
> Are you worried about uid_t wider than ulong?  strtoul() with !errno
> test covers the case, doesn't it?

No, I am worried about uid_t narrower than ulong, which is also the
most likely scenatio with a typeof(uid_t) == uint32_t

> SUDO_UID cannot have any integer
> that cannot be represented in uid_t and if strtoul() does not say
> ERANGE, we know whatever value in SUID_UID did not overflow ulong.

It is a little subtle, but strtoul doesn't warrant always an ERANGE
because it tries to be helpful when given a negative integer and returns
instead an equivalent unsigned long as per spec[1] (or in this case the
commentary from OpenBSD man page which is also easier to link)

"If the minus sign was part of the input sequence, the numeric value calculated from the sequence of digits is negated as if by unary minus in the result type, which applies unsigned integer wraparound rules."

> > it ALSO avoids someone trying to sneak a value that would overflow in
> > one of the most common configurations we will run where sizeof(long) >
> > sizeof(uid_t) && MIN_UID_T >=0, by using an equivalent to MAX_UID_T
> 
> Sorry, -ECANNOTPARSE.  If strtoul() can parse everything in uid_t
> then where is the room for overflowing?

So lets assume a 32bit unsigned uid_t, that wraparounds at 2^32+1, if we
get a negative value that is equivalent to something bigger than it, or
even a positive value bigger than it, then the assignment will overflow
unless we keep it in check by that obviously too clever condition that
was removed and we MIGHT even assume an uid_t of 0, which is embarrasing[0].

> We are trying to protect an
> unsuspecting user who temporary has become 'root' via sudo, and not
> somebody deliberately hurt themselves or others by setting SUDO_UID
> deliberately to strange values (once you are 'root', you have easier
> ways to hurt other people).

You are correct for the current code that even has a big warning telling
people NEVER to run that function for anyone other than root, but who
knows how this will evolve in the future.

Removing it also has other sideeffect, like making this code work in
incorrect ways if uid_t is signed, which I mentioned before but probably
should had been added as a comment, but that was part of the requirements[2]
we had when Phillip argued correctly that I was restricting the valid uid
to only half was possible in 32bit systems.

FWIW, sudo prints the uid using "%u" so using unsigned long makes more
sense and all these problems are unlikely to be practical issues now so
I am ok taking your code if you insist, but I still think that the original
one was safer in case things change in the future or if there is a platform
we currently run on with has signed uid_t, so I will keep it in the RFC with
hopefully enough comments to convince you.

Carlo

[0] https://github.com/systemd/systemd/issues/11026
[1] https://man.openbsd.org/strtoul.3
[2] https://lore.kernel.org/git/CAPUEspjoTYtv9K=rvpkFnyGnEz_uxefED820rx09b6qGG93SqA@mail.gmail.com/
