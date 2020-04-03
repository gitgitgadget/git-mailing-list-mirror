Return-Path: <SRS0=9X1Y=5T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED6D1C43331
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BEA0B206F5
	for <git@archiver.kernel.org>; Fri,  3 Apr 2020 18:53:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ISbKwvLD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728352AbgDCSxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Apr 2020 14:53:43 -0400
Received: from mout.web.de ([212.227.17.12]:33437 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727167AbgDCSxm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Apr 2020 14:53:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585940008;
        bh=F69IJQq7n+WQlDvJdNzNC5FQnEwVo+dUtsITcyOlepo=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ISbKwvLD7o5WdrKmrIFFP4YcR8Hv6I3/Xpts8zIcbP/fTSWJ/IyOO1VEhMTROR7/g
         HMstqtmmYippN2NLRLE8H+/69Y4AHSBkJUeH9uD+KWc8mp9y5/2UYeoFdZeXlc8hmp
         gvN7ReqBlWEfEFo5Q4t3DIgGyV2IJn8sjOny5xYY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFLB2-1jWaWJ3F8W-00EN1m; Fri, 03
 Apr 2020 20:53:27 +0200
Subject: Re: fast-import's hash table is slow
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <20200401103522.GE60227@coredump.intra.peff.net>
 <20200401111621.GA1265072@coredump.intra.peff.net>
 <38be9140-546c-e3fa-fb71-c92937094a40@web.de>
 <20200403121212.GA65799@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <0279dc99-871c-8fb4-f1b0-3ae4ae7d94d8@web.de>
Date:   Fri, 3 Apr 2020 20:53:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200403121212.GA65799@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hujBcxs1v9mVsZ+4H5IefhS6xRz2/9rzxvdbhtHnfVBLvwwLgwk
 V7s0AceiZOjX78t/N0A9LBZ1ojws+n9hdslj5/pWqOdfJ7+TWOvf1ubpiDJ8PQzayRqnFFP
 3LaIFEoNGUhIYKY5SsZC2lSBTQgSM6mntMD8yybx9SRUV0tP6e40inMNoIRmqlcOvbS9xJd
 jRM7VCy8R6nrJ8WQfndBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JAEsGYoLdm4=:651v/vg7OkNDg0///vRqGT
 VHX33u6RcIbRu7op8Fmes3J8063+/wNkZEpXVIk3tGhHJV3RVdsEmWOwh+iyWF4tQGNw+2GT4
 VJsY1l1PTh8lZJ7SGqwFoAteSZIbFH3WkjrdsEVmJUE5MaBRUptLD0puNBfKwU/FSWtxXhWdq
 9BI4FwTnge0mNS3jLB6k66iJKPCs3OOZheyMXRXFwXi0D86JCvgulxr0oZDklTCKJVl1lDSbR
 ZWZ4qI9VrhRLIAUXNmwxCybb+URA2NssQXnAB/7wqUnZGvAk5TNhBpXY5s6f2pWyPk/hYz23F
 /zWuQB1JMIR1ZwJ0v4W1UNNusX/3Iv86mttJwqlcwbhVuVnIJ2Ajb4ai/CWL7dHcFOvAVmZ/i
 WVoS+Mqy+m8xjF7dSZMk4JX5a4zfUDvPbxx9CnbjEJTqWvasK50nJczksQgwClEpUtqLTYP2Y
 GQRGGzcI5VbfImGTws7b1/4FICnXtyKaA0+5dEzXVdRsFsTvFSy1UBX0Hl91Jl8H3Bm4YNX54
 ZAFS7JT7vzoh1aPfWASkOvEzHGwhhofdjBRCmEvp55vv+WAn6SzWf/NoMMmPjoTFvJQdPi4ID
 zKRh/5hTsZbO2TpSp3W8lYMM3DS3HZp0VmHSjqxfMVAG8kyRqz89l2ChV5ulwuRqMclQ5y1tW
 JF0FBOycmivUrO6FVnnwb9U/EwDX5mzx10ft+bDZp0gqfS/JVHlYZwTshbA7J+enEBKwbl+BY
 P9+Ob1UCpGgjWSY4BZSODxyWa2XL3beaqNHeGxR0K1fOaJKzXL6vcdcB0Sh2OICIAtahP3gmG
 LYNrLVLtsgIuz0cZfeGhlcAZo1gqtDKf4ioUs3sRboKw09t7+OYMnKGfOJ4/QPMGmVyloXelZ
 MTVGl5tTland+pCUBd7tMcweznNp68jcpY3DSS6UCCeOXNKAXnMZFlEwqFiGMZu5qAXUNjSqo
 wgTBCq6iuYI1qP4AkWS5FNHzGybmqIYJBmJbEaMc1srjSqLlucfcLDI/R5WaKyl2r2de8dJkm
 vNyplrkvJ+b+Zoy87BolSQJEbe0ZwpF4ilndjGcERyq4dUwMJquGWi+qU5J3RWnzniS3ctCZa
 NUklEBuje2a6B2h8eoJP15X+ADOWa9LB3iihMCH9LlZ44x8QP/yGUg1C1mvUCNJS5Oa2NfaL3
 EsRJ1Hf5BHripKHBQFUrgbxMNk0tIT3M182XcCNYAoP/z4EuN94w6ZX5RiDeFpA1YLszoUfxQ
 IApFrMvP9tmPK5his
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.04.20 um 14:12 schrieb Jeff King:
> On Thu, Apr 02, 2020 at 08:40:35PM +0200, Ren=C3=A9 Scharfe wrote:
>
>>>  struct object_entry {
>>>  	struct pack_idx_entry idx;
>>> -	struct object_entry *next;
>>> +	struct hashmap_entry ent;
>>
>> That uses 16 bytes more memory per entry on x64 than khash would.
>> That's 256MB for 2^24 objects -- not ideal, but bearable, I guess.
>
> Isn't it 8? We're dropping the old pointer and replacing it with the
> "next" pointer in hashmap_entry, plus our 4-byte hash code (which likely
> gets padded to 8).

That's right, so the difference to your khash version is 16, as the
latter removes the pointer without any replacement.

See https://www.godbolt.org/z/xs6CLL for a comparison.

>>> +static int object_entry_hashcmp(const void *map_data,
>>> +				const struct hashmap_entry *eptr,
>>> +				const struct hashmap_entry *entry_or_key,
>>> +				const void *keydata)
>>> +{
>>> +	const struct object_id *oid =3D keydata;
>>> +	const struct object_entry *e1, *e2;
>>> +
>>> +	e1 =3D container_of(eptr, const struct object_entry, ent);
>>
>> That's nicer that the pointer alchemy in the khash conversion for sure.
>>
>> But why const?  Can const change the layout of a structure?  Scary.
>
> No, I don't think it can. I mostly copied the "const" from the other
> container_of() hashmap sites. I don't think it matters in practice,
> because we're assigning the result to a const pointer anyway. But it
> seems a little cleaner not to momentarily cast away the constness even
> inside the macro.

Makes sense.  I disregarded the final cast in container_of when I
wrote the above.  Silly me.

Ren=C3=A9
