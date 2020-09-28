Return-Path: <SRS0=tv2H=DG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2412CC2D0A8
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:13:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D66032080A
	for <git@archiver.kernel.org>; Tue, 29 Sep 2020 00:13:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c924KqtR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgI2ANt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Sep 2020 20:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727344AbgI2ANm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Sep 2020 20:13:42 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6D0C061755
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:48:09 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z19so3090021lfr.4
        for <git@vger.kernel.org>; Mon, 28 Sep 2020 14:48:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=iQK4HESbvleJF12kZbW+DnyeAv6fs+F8zYNadhlvdD0=;
        b=c924KqtRteeNO7eDBEinweT+CsQN/vpEIFbhYiCXTOHa/sZ9KHA1PwZm0buP5VzTvQ
         1mZ9tj20AhdT/l3kJqZizg+tEKQjE0thHKS0kZimG+DJgjebd0iO7rl+7K9um5zQM1Rp
         gu8u9yx2ifSQ02qAJSVcoRmQ3JzAcW08I0ut2eOh2I82/CuZQOjynsznmac9qtYbuwyZ
         owta1GhMKbgI58OCaNc186NxTv7lJ+D+34khma/g/hxfKZ/dFaMCHVQCC29LG36Hb951
         PGC33ID26miI+41pMWbGQGIACGP7ZNc+lZ+5zCuiFckOMq91zUqd0fp5tGIwz1cQpkVs
         dtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version:content-transfer-encoding;
        bh=iQK4HESbvleJF12kZbW+DnyeAv6fs+F8zYNadhlvdD0=;
        b=dUr3u8/INI7eYRdASG2m2CdxAuBx3hyHUA4WT71J1W5ZFbW629cFlNA4ACXWKThh/4
         wP0xcLH7MxHPS01/7wTgIRJnWSNrBrapq9TjaKC5ave5D3HIVWiJ2NvyfLpZD8Lpr+9p
         WX6PQmc+wjNIU/nDIf3Xg3UQjQivT6Qzdm6orbJThXffPS7hjHli/EXs7tUUgUfGUvUY
         LQkSBIqwzl2iUbZ4/bYS/m/srvf8F9Hgg3HdpS/1G8G17NwYIrjZnYuKtB2Nq7Nd47pt
         H0OZ598tK3LXVsJRbytx4yAP82Awe8+/60YKyCHTfBqqx20tXc+gHl0l7rA0eeLP3SJ+
         1YuA==
X-Gm-Message-State: AOAM530pamRyMRamtOz9y2oHCuM41bsbVScO4S03mk7akBlgaI1KeLn0
        l2WJrn6N9fm9mMQvy+Kgb5c=
X-Google-Smtp-Source: ABdhPJwmwVRMDQAbRmfaXC9Mh9AAan3ur0AZ87g+EpIonejXMrdt5zokTHNlX/MmeY1CaWHeCFpifA==
X-Received: by 2002:a19:c34b:: with SMTP id t72mr66675lff.509.1601329687975;
        Mon, 28 Sep 2020 14:48:07 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id w17sm3017458lfr.31.2020.09.28.14.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 14:48:06 -0700 (PDT)
From:   Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
To:     git@vger.kernel.org
Cc:     Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Jakub =?utf-8?Q?Nar?= =?utf-8?Q?=C4=99bski?= <jnareb@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
        <85d03km98l.fsf@gmail.com> <20200825050448.GA21012@Abhishek-Arch>
        <85ft8adilr.fsf@gmail.com> <20200901120653.GA59580@Abhishek-Arch>
        <851rjjasdo.fsf@gmail.com> <20200905172127.GA1382@Abhishek-Arch>
        <85v9gh1yaz.fsf@gmail.com>
Date:   Mon, 28 Sep 2020 23:48:05 +0200
In-Reply-To: <85v9gh1yaz.fsf@gmail.com> ("Jakub \=\?utf-8\?Q\?Nar\=C4\=99bski\=22\?\=
 \=\?utf-8\?Q\?'s\?\= message of "Sun,
        13 Sep 2020 17:39:00 +0200")
Message-ID: <857dsdvai2.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:
> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>> On Thu, Sep 03, 2020 at 03:42:43PM +0200, Jakub Nar=C4=99bski wrote:
>>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>>> On Tue, Aug 25, 2020 at 02:18:24PM +0200, Jakub Nar=C4=99bski wrote:
>>>>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>>>>
>>>>> ...
>>>>>
>>>>> However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
>>>>> difficult.  As far as I can see, we can choose one of the *three*
>>>>> solutions (the third one is _new_):
>>>>>
>>>>> a. store 64-bit corrected commit date in the GDAT chunk
>>>>>    all possible values are able to be stored, no need for
>>>>>    GENERATION_NUMBER_V2_MAX,
>>>>>
>>>>> b. store 32-bit corrected commit date offset in the GDAT chunk,
>>>>>    if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
>>>>>    do not write GDAT chunk at all (like for backward compatibility
>>>>>    with mixed-version chains of split commit-graph layers),
>>>>>
>>>>> c. store 32-bit corrected commit date offset in the GDAT chunk,
>>>>>    using some kind of overflow handling scheme; for example if
>>>>>    the most significant bit of 32-bit value is 1, then the
>>>>>    rest 31-bits are position in GDOV chunk, which uses 64-bit
>>>>>    to store those corrected commit date offsets that do not
>>>>>    fit in 32 bits.
>>>
>>> Note that I have posted more detailed analysis of advantages and
>>> disadvantages of each of the above solutions in response to 11/11
>>> https://public-inbox.org/git/85o8mwb6nq.fsf@gmail.com/
>>>
>>> I can think of yet another solution, a variant of approach 'c'
[...]
>>
>> The primary benefit of c') over c) seems to the range of valid offsets -
>> c') can range from [0, 0xFFFFFFFF) whereas offsets for c) can range
>> betwen [0, 0x7FFFFFF].
>>
>> In other words, we should prefer c') over c) only if the offsets are
>> usually in the range [0x7FFFFFFF + 1, 0xFFFFFFFF)
>>
>> Commits were overflowing corrected committer date offsets are rare, and
>> offsets in that particular range are doubly rare. To be wrong within
>> the range would be have an offset of 68 to 136 years, so that's possible
>> only if the corrupted timestamp is in future (it's been 50.68 years since
>> Unix epoch 0 so far).
>
> Right, the c) variant has the same limitation as if corrected commit
> date offsets were stored as signed 32-bit integer (int32_t), so to have
> overflow we would have date post Y2k38 followed by date of Unix epoch 0.
> Very unlikely.
>
>> Thinking back to the linux repository, the largest offset was around of
>> the order of 2 ^ 25 (offset of 1.06 years) and I would assume that holds
>>
>> Overall, I don't think the added complexity (compared to c) approach)
>> makes up for by greater versatility.
>>
>> [1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/
>
> All right.
>
> With variant c) we have additional advantage in that we can pattern the
> code on the code for EDGE chunk handling, as you said.
>
> I wanted to warn about the need for sanity checking, like ensuring that
> we have GDOV chunk and that it is large enough -- but it turns out that
> we skip this bounds checking for extra edges / EDGE chunk:
>
> 	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
> 		pptr =3D insert_parent_or_die(r, g, edge_value, pptr);
> 		return 1;
> 	}
>
> 	parent_data_ptr =3D (uint32_t*)(g->chunk_extra_edges +
> 			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
> 	do {
> 		edge_value =3D get_be32(parent_data_ptr);
> 		pptr =3D insert_parent_or_die(r, g,
> 					    edge_value & GRAPH_EDGE_LAST_MASK,
> 					    pptr);
> 		parent_data_ptr++;
> 	} while (!(edge_value & GRAPH_LAST_EDGE));

Both Taylor Blau and Junio C Hamano agree that it is better to store
corrected commit date offsets and have overload handling to halve (to
reduce by 50%) the size of the GDAT chunk.  I have not heard from
Derrick Stolee.

It looks then that it is the way to go; as I said that you have
convinced me that variant 'c' (EDGE-like) is the best solution for
overflow handling.

Best,
--=20
Jakub Nar=C4=99bski
