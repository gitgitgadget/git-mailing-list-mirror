Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034C9C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:56:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245286AbiAFW4p (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:56:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245250AbiAFW4p (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:56:45 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB18C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:56:44 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so7661608wra.6
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:56:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=evESkuRJrokF2c/G+PUwivulXlpzLFxLiz07htR3dy4=;
        b=VhyZfAF1/iBpPU6vqFbcbJKLmVj/dqcR3/4FSm6aAXoub1CafscdpLeIelWWGdK3P5
         3qmR9dg7NPcMlPF/Aqxn5gm5Npbr8P8PoebxQ3n/p463Zg49dG1roiMLVPs12hCShvCG
         jJcdtjPNGK80Vcoas+J3lt18mCZCc7u9t3NRnfOkNn0C+7tAnw5sKgIaX9E3EekHbGoL
         wvIIxWMjF+kuB1GeTNj+9gcz/jD95B/1jyO5kIOP5ZhmUwLiQ86wE8qYlXzB83zrykUI
         qjgMCuey+O6HsFg+relJXR5XFAlTqrwc6sS6xg+jclH6kU3pqJE1quiKzRtNkPMQ1ADb
         EZSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=evESkuRJrokF2c/G+PUwivulXlpzLFxLiz07htR3dy4=;
        b=7C/5aG3rMoHzY00q4InU83Bv198DQZdJJ7j3JQRQL28HNPMgV/y8GHVYBESUcsGQnR
         RzZWT6JXv4beSWQJmxRg4Zr4AWROb0GusBxWNBLPiXxPTGHOOkH7hCBkm5g0JAuM7yFC
         UM0Vn99SFhvzANCttQCL4TzdtD7E/L9XoWpTc4Uw/VJS9Pq34GamkVzM7Yjg8TQ34PzP
         EX+1RPqgJuFqmBU3UX+7gV7AKvnk9AZxfvQZnQno96b7k5raGcJcwVZ9SN2mCoaS5mdZ
         L2YCP83B9aanjcoND4S3yN3VzgkwPXqZEFfzJQ8KqCla1ntjNC1Me3rIDdtSrjQFxaxf
         ZlcA==
X-Gm-Message-State: AOAM533AiEY6C81/Ee4hmSVtH6hrvCA5AUfHG79VxxUCGO4/rH1t6220
        YXCKde7AayzJxov3bA1I+++/KA==
X-Google-Smtp-Source: ABdhPJwLj6AnrxAoc4LPem9xqDe9kX6FvX6Bn/J2AyORlqNoJBUXtHQ+vWTXFMFmq4UcMhfGcuPjUA==
X-Received: by 2002:adf:fac4:: with SMTP id a4mr51816296wrs.66.1641509803387;
        Thu, 06 Jan 2022 14:56:43 -0800 (PST)
Received: from smtpclient.apple (global-5-143.nat-2.net.cam.ac.uk. [131.111.5.143])
        by smtp.gmail.com with ESMTPSA id o5sm2747208wmc.39.2022.01.06.14.56.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jan 2022 14:56:43 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.40.0.1.81\))
Subject: Re: [PATCH] Properly align memory allocations and temporary buffers
From:   Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <xmqqh7agbiuq.fsf@gitster.g>
Date:   Thu, 6 Jan 2022 22:56:42 +0000
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <97D2AB55-0F8F-4C38-A5C6-1AAA43EA064A@jrtc27.com>
References: <20220105132324.6651-1-jrtc27@jrtc27.com>
 <YddjJ+uIQM34Gedo@nand.local> <xmqqh7agbiuq.fsf@gitster.g>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3693.40.0.1.81)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6 Jan 2022, at 22:27, Junio C Hamano <gitster@pobox.com> wrote:
>=20
> Taylor Blau <me@ttaylorr.com> writes:
>=20
>> (+cc Ren=C3=A9 as another possible reviewer)
>>=20
>> On Wed, Jan 05, 2022 at 01:23:24PM +0000, Jessica Clarke wrote:
>>> Currently git_qsort_s allocates a buffer on the stack that has no
>>> alignment, and mem_pool_alloc assumes uintmax_t's size is adequate
>>> alignment for any type.
>>>=20
>>> On CHERI, and thus Arm's Morello prototype, pointers are implemented =
as
>>> hardware capabilities which, as well as having a normal integer =
address,
>>> have additional bounds, permissions and other metadata in a second =
word,
>>> so on a 64-bit architecture they are 128-bit quantities, including =
their
>>> alignment requirements. Despite being 128-bit, their integer =
component
>>> is still only a 64-bit field, so uintmax_t remains 64-bit, and =
therefore
>>> uintmax_t does not sufficiently align an allocation.
>=20
> Alignment aside, if uintmax_t is 64-bit but your pointer needs
> 128-bit to store, saving a pointer value in uintmax_t variable would
> not work correctly, I presume, as casting the 64-bit integral type
> back into pointer would not be sufficient to recover the lost
> information that used to be in the second word.
>=20
> So, does the architecture have 128-bit uintptr_t and that is a safe
> type both from the point of view of alignment and from the point of
> view of not losing information? =20

Yes. It is basically just a char * that lets you perform arbitrary
arithmetic; not an unsigned long any more for our architectures.

> If that type is larger than uintmax_t, something smells wrong,
> though.  max is not max anymore at that point.
>=20
> IIRC, uintptr_t is optional in C99, so a simpler solution to use the
> larger type between uintptr_t and uintmax_t as a replacement for how
> we use uintmax_t would not quite work out of the box X-<.

This is also true of uint128_t, it doesn=E2=80=99t fit in a uintmax_t =
either.
uintmax_t was a mistake as it becomes part of the ABI and can never be
revised even when new integer types come along. uintmax_t can hold any
valid address, but will strip the metadata. It turns out almost no
software tries to put a pointer in a uintmax_t and cast it back to a
pointer.

Note that, even if we wanted to, we coldn't just map uintmax_t to a
uintptr_t, as on 32-bit architectures uintmax_t is a 64-bit integer but
uintptr_t only has a 32-bit range (plus 32 bits of metadata), and we do
have a 32-bit CHERI variant for embedded use cases.

This is one of a few warts that people will just have to deal with for
CHERI; there=E2=80=99s no way round it if you want anything that =
implements the
ideas of CHERI.

Jess

