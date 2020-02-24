Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5CFC11D2F
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B41A020732
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 18:20:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5+st7a8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727775AbgBXSUK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Feb 2020 13:20:10 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33663 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726208AbgBXSUJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Feb 2020 13:20:09 -0500
Received: by mail-lj1-f196.google.com with SMTP id y6so11262758lji.0
        for <git@vger.kernel.org>; Mon, 24 Feb 2020 10:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=1SfhKGSAjycGz47Nv2E+NSRvKHbpEUmdsx01vDBzK8w=;
        b=g5+st7a8WXQoDxQ+L6m6dKNxDopN2b2f5fSgp/DHCPo+KJKAWnYPTNApdHPz71+g8v
         nMbg5mH1yoHRn2prfP1t3KlMU/WXizd1nQZvi318ZI6GaRcCEoFJ7Eqa03ExRvdcMbpv
         oTQEoTpooFgt/5GqQJ3DZZs9d5vJvlcRpCDT4btrT0riI7rXHaSglfVxNEh+xSpd+EqA
         NwI216IleWxz18P5l94jFxSY7ax89DOpFNH80OdvZnEMGn5+s/Dgz9x0ikgigC0fP/MK
         iGSDr6P1da8VnJWIskZgytZMIm7BL8lblcsbaZlI1ayOYSp08IM3j6bS5kGOQ1n8eG76
         DHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=1SfhKGSAjycGz47Nv2E+NSRvKHbpEUmdsx01vDBzK8w=;
        b=LUXJmtn7TYakZplCS/+Aydt3Fy06xbcJflmdkBeWOCirVhTjgAEZPEb13f9EXvejTB
         RvXY8829847BEK18enF1Ok9l2+hviAZjcqJ6wpckrFh2l4G9fnIkQwLpxy6gibsCNvSP
         hdSPpg14vKtRvqlqrFrIQA93tgvfbjhLnnqSRFGgb5ufp6ybau5lrD36VFT3NMSob+Ad
         LVYbgRNdARIODx3AXm9Wkx+Hle4z/vmkTeFoKtR1ghGP74Vmv3a+uc26uDCwmjBsgpC2
         mJCAbS1BKHqsQyAjydiu0R0Xuw6W/zB9nKZlA+GOREVAbqjiuGotiLWSjZgBR52ZXoes
         564A==
X-Gm-Message-State: APjAAAVJYLv6bLEZ3S7MBEqSIWV1xE1+fb4HZeWjUVFIMtsCUtu2eJ0D
        yjlqT64Yfkyy/soE/aojdGeNYwWOVIA=
X-Google-Smtp-Source: APXvYqxfmUTBAF3S9bH+DnNFzZwPq6oUrmAOw7uGes0ptttxWHyO0jqr2YIJzkEXTIqkUQvk7NNobw==
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr31908181ljk.245.1582568407017;
        Mon, 24 Feb 2020 10:20:07 -0800 (PST)
Received: from Laptop-Acer-Aspire-F15 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id g21sm6551670ljj.53.2020.02.24.10.20.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 24 Feb 2020 10:20:06 -0800 (PST)
From:   Jakub Narebski <jnareb@gmail.com>
To:     Garima Singh <garimasigit@gmail.com>
Cc:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Subject: Re: [PATCH v2 02/11] bloom: core Bloom filter implementation for changed paths
References: <pull.497.git.1576879520.gitgitgadget@gmail.com>
        <pull.497.v2.git.1580943390.gitgitgadget@gmail.com>
        <02b16d94227470059dcee2781e29ae7ae010f602.1580943390.git.gitgitgadget@gmail.com>
        <86tv3qqxyn.fsf@gmail.com>
        <a6c08b27-18d7-cf30-c076-3f6451a21519@gmail.com>
        <86wo8d8lus.fsf@gmail.com>
        <8f7a6168-8555-0a37-9945-1dc41d85c50d@gmail.com>
Date:   Mon, 24 Feb 2020 19:20:03 +0100
In-Reply-To: <8f7a6168-8555-0a37-9945-1dc41d85c50d@gmail.com> (Garima Singh's
        message of "Mon, 24 Feb 2020 12:34:02 -0500")
Message-ID: <86h7zf97ak.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Garima Singh <garimasigit@gmail.com> writes:

> On 2/23/2020 8:38 AM, Jakub Narebski wrote:
>> Garima Singh <garimasigit@gmail.com> writes:
>>> On 2/16/2020 11:49 AM, Jakub Narebski wrote:
>>>>> From: Garima Singh <garima.singh@microsoft.com>

[...]
>>>> IMPORTANT: There is a comment around there in the example implementati=
on
>>>> in C on Wikipedia that this operation above is a source of differing
>>>> results across endianness.=20=20
>>>
>>> Thanks! SZEDER found this on his CI pipeline and we have fixed it to=20
>>> process the data in 1 byte words to avoid hitting any endian-ness issue=
s.=20
>>> See this part of the thread that carries the fix and the related discus=
sion.=20
>>>   https://lore.kernel.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@gmai=
l.com/
>>> I will be squashing those changes in appropriately in v3.=20=20
>>=20
>> [...]
>>>>
>>>> In https://public-inbox.org/git/ba856e20-0a3c-e2d2-6744-b9abfacdc465@g=
mail.com/
>>>> you posted "[PATCH] Process bloom filter data as 1 byte words".
>>>> This may avoid the Big-endian vs Little-endian confusion,
>>>> that is wrong results on Big-endian architectures, but
>>>> it also may slow down the algorithm.
>>>
>>> Oh cool! You have seen that patch. And yes, we understand that it might=
 add=20
>>> a little overhead but at this point it is more important to be correct =
on all
>>> architectures instead of micro-optimizing and introducing different=20
>>> implementations for Little-endian and Big-endian. This would make this=
=20
>>> series overly complicated. Optimizing the hashing techniques would dese=
rve a
>>> series of its own, which we can definitely revisit later.
>>=20
>> Right, "first make it work, then make it right, and, finally, make it fa=
st.".
>>=20
>> Anyway, could you maybe compare performance of Git for old version
>> (operating on 32-bit/4-bytes words) and new version (operating on 1-byte
>> words) file history operation with Bloom filters, to see if it matters
>> or not?
>>=20
>
> We chose to switch to 1 byte words for correctness, not performance.=20
> Also, this specific implementation choice is a very small portion of the=
=20
> end to end time spent computing and writing Bloom filters. We run two mur=
mur3=20
> hashes per path, which is one path per `git log` query; and one path per =
change=20
> after parsing trees to compute a diff. Measuring performance and micro-op=
timizing=20
> is not worth the effort and/or trading in the simplicity here.

All right.

I still think that adding to_le32() invocation before the part that
processes remaining bytes (the 'switch' instruction in v2 code), just
like in pseudo-code on Wikipedia:

    with any remainingBytesInKey do
        remainingBytes =E2=86=90 SwapToLittleEndian(remainingBytesInKey)

would be enough to have correct results regardlless of endianness.

As I wrote

JN> The solution in PMurHash.c in Chromium [1], and the pseudo-code algorit=
hm on
JN> Wikipedia do endian handling only for remaining bytes (while the
JN> beginnings of solution in Appleby's code, and solution in current
JN> above-mentioned Chromium implementation do the conversion for all
JN> bytes).  I think that handling it only for remaining bytes (for data
JN> sizes not being multiply of 32-bits / 4-bytes) is enough; all other
JN> operations, that is multiply, rotate, xor and addition do not depend on
JN> endianness.

[1]: https://chromium.googlesource.com/external/smhasher/+/5b8fd3c31a58b87b=
80605dca7a64fad6cb3f8a0f/PMurHash.c

If you have access to, or can run code on some big-endian architecture,
it should be easy enough to check it.


Anyway, if you decide on 1-byte at time implementation, please put a
comment about 32-bit chunk implementation.

>> Side note: I wonder if it would be worth it (in the future) to change
>> handling commits with large amount of changes.  I was thinking about
>> switching to soft and hard limit: soft limit would be on the size of the
>> Bloom filter, that is if number of elements times bits per element is
>> greater that size threshold, we don't increase the size of the filter.
>>=20
>> This would mean that the false positives ratio (the number of files that
>> are not present but get answer "maybe" instead of "no" out of the
>> filter) would increase, so there would be a need for another hard limit
>> where we decide that it is not worth it, and not store the data for the
>> Bloom filter -- current "no data" case with empty filter with length 0.
>> This hard limit can be imposed on number of changed files, or on number
>> of paths added to filter, or on number of bits set to 1 in the filter
>> (on popcount), or some combination thereof.
>>=20
>> [...]
>
> Could be considered in the future. Doesn't make the cut for the current
> series though.=20

Right.

Best,
--=20
Jakub Nar=C4=99bski
