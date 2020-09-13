Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54AABC433E2
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:39:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E3172078D
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 15:39:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPYC8HkW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgIMPjI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 11:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgIMPjE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 11:39:04 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6982EC06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:39:04 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id u4so16423552ljd.10
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 08:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:user-agent:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ARwRvOdz5Qyw0EtM/v05Pk3fUkJj+BQD5SFWTAgsBio=;
        b=hPYC8HkW/4vu7r6gwluYh4xKMHADXW7X9MhYIRlm68cGY7h6rBtZ38IHHp2jp4UeCD
         F5C622PzRvkCKhmPDSKrWWnLkqBjJiCexCPMBg0iH7XzAeLZG6mQqlgDE0EHXzGaEx/o
         eMnLUn/CKaeKKlGWMd4vCIOC1G0u4YAYBOTtQDMjCcfzHbj6fbKeaqZNZdmn8hvRIYo1
         C2dEGfEdDTOnBOK+3qenqTrY7GfBSRT4u3f5802AmKSFtnT24mMdFK0UsVGABOz15pJX
         +w3myyNO+uS4ujkHE2hV4Pn9ucKjUxSwfEQJoHhPBs9Iqqgsva7fzpqvoCsF3IPP2c0n
         ADzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
         :user-agent:date:message-id:mime-version:content-transfer-encoding;
        bh=ARwRvOdz5Qyw0EtM/v05Pk3fUkJj+BQD5SFWTAgsBio=;
        b=WwdOeVJhgwxsQ6FR9eXQLcedBJKxkHFfPwDA3XG+w1Pbt2qKs7ReeAgyRohYF4bf3C
         aSJ2qgpmOsOykAw05g6Ba4sOujQMThh3rXAsudM9s8rXx5cj4srMOPnciWqtlmGy5els
         TBUUdyjyAwdvFdnQ4ydjtpkEwVNT/sJcInKhINVBpySo1hsbwrSqjC7cxhHPtLKBCm1o
         bJnTYqu6e2tnxMjM0EnKUiDnTMM3MhE6e+1h1E0NhpbYRl4fZBeIAiGWCZxiu1gQT6kk
         JOM8ulOnkepWt4R6B4y7l8L8AcNtnfjBfExYud/erfVO4nqudkHfXIFGR9aboM9kwSY/
         kyyw==
X-Gm-Message-State: AOAM530NRVUZh92nHTntw/FK7uNZCSAQHAYF82rxAdAkDttYQYy4O5wq
        w7mZSm/OnnAnl5/lxDekWQk=
X-Google-Smtp-Source: ABdhPJwV2s9jxn5EuNXsE66uOZ4woBgvO8gFgAGxcGHpyo+/hDUQFA6zhnGxbW68qFnIyOX4LR5/LQ==
X-Received: by 2002:a2e:a41b:: with SMTP id p27mr3930306ljn.75.1600011542497;
        Sun, 13 Sep 2020 08:39:02 -0700 (PDT)
Received: from LAPTOP-ACER-ASPIRE-F5 (host-89-229-7-83.dynamic.mm.pl. [89.229.7.83])
        by smtp.gmail.com with ESMTPSA id u10sm2804401lfr.33.2020.09.13.08.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2020 08:39:01 -0700 (PDT)
From:   jnareb@gmail.com (Jakub =?utf-8?Q?Nar=C4=99bski?=)
To:     Abhishek Kumar <abhishekkumar8222@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        "Abhishek Kumar via GitGitGadget" <gitgitgadget@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v3 05/11] commit-graph: return 64-bit generation number
In-Reply-To: <20200905172127.GA1382@Abhishek-Arch> (Abhishek Kumar's message
        of "Sat, 5 Sep 2020 22:51:27 +0530")
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
        <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
        <6be759a9542114e4de41422efa18491085e19682.1597509583.git.gitgitgadget@gmail.com>
        <85d03km98l.fsf@gmail.com> <20200825050448.GA21012@Abhishek-Arch>
        <85ft8adilr.fsf@gmail.com> <20200901120653.GA59580@Abhishek-Arch>
        <851rjjasdo.fsf@gmail.com> <20200905172127.GA1382@Abhishek-Arch>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (windows-nt)
Date:   Sun, 13 Sep 2020 17:39:00 +0200
Message-ID: <85v9gh1yaz.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
> On Thu, Sep 03, 2020 at 03:42:43PM +0200, Jakub Nar=C4=99bski wrote:
>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>> On Tue, Aug 25, 2020 at 02:18:24PM +0200, Jakub Nar=C4=99bski wrote:
>>>> Abhishek Kumar <abhishekkumar8222@gmail.com> writes:
>>>>
>>>> ...
>>>>
>>>> However, as I wrote, handling GENERATION_NUMBER_V2_OFFSET_MAX is
>>>> difficult.  As far as I can see, we can choose one of the *three*
>>>> solutions (the third one is _new_):
>>>>
>>>> a. store 64-bit corrected commit date in the GDAT chunk
>>>>    all possible values are able to be stored, no need for
>>>>    GENERATION_NUMBER_V2_MAX,
>>>>
>>>> b. store 32-bit corrected commit date offset in the GDAT chunk,
>>>>    if its value is larger than GENERATION_NUMBER_V2_OFFSET_MAX,
>>>>    do not write GDAT chunk at all (like for backward compatibility
>>>>    with mixed-version chains of split commit-graph layers),
>>>>
>>>> c. store 32-bit corrected commit date offset in the GDAT chunk,
>>>>    using some kind of overflow handling scheme; for example if
>>>>    the most significant bit of 32-bit value is 1, then the
>>>>    rest 31-bits are position in GDOV chunk, which uses 64-bit
>>>>    to store those corrected commit date offsets that do not
>>>>    fit in 32 bits.
>>
>> Note that I have posted more detailed analysis of advantages and
>> disadvantages of each of the above solutions in response to 11/11
>> https://public-inbox.org/git/85o8mwb6nq.fsf@gmail.com/
>>
>> I can think of yet another solution, a variant of approach 'c' with
>> different overflow handling scheme:
>>
>> c'.  Store 32-bit corrected commit date offset in the GDAT chunk,
>>      using the following overflow handling scheme: if the value
>>      is 0xFFFFFFFF (all bits set to 1, the maximum possible value
>>      for uint32_t), then the corrected commit date or corrected
>>      commit date offset can be found in GDOV chunk (Generation
>>      Data OVerflow handling).
>>
>>      The GDOV chunk is composed of:
>>      - H bytes of commit OID, or 4 bytes (32 bits) of commit pos
>>      - 8 bytes (64 bits) of corrected commit date or its offset
>>
>>      Commits in GDOV chunk are sorted; as we expect for the number
>>      of commits that require GDOV to be zero or a very small number
>>      there is no need for GDO Fanout chunk.
>>
>>    - advantages:
>>      * commit-graph is smaller, increasing for abnormal repos
>>      * overflow limit reduced only by 1 (a single value)
>>    - disadvantages:
>>      * most complex code of all proposed solutions
>>        even more complicated than for solution 'c',
>>        different from EDGE chunk handling
>>      * tests would be needed to exercise the overflow code
>>
>> Or we can split overflow handling into two chunks: GDOI (Generation Data
>> Overflow Index) and GDOV, where GDOI would be composed of H bytes of
>> commit OID or 4 bytes of commit graph position (sorted), and GDOV would
>> be composed oly of 8 bytes (64 bits) of corrected commit date data.
>>
>> This c'') variant has the same advantages and disadvantages as c'), with
>> negligibly slightly larger disk size and possibly slightly better
>> performance because of better data locality.
>>
>
> The primary benefit of c') over c) seems to the range of valid offsets -
> c') can range from [0, 0xFFFFFFFF) whereas offsets for c) can range
> betwen [0, 0x7FFFFFF].
>
> In other words, we should prefer c') over c) only if the offsets are
> usually in the range [0x7FFFFFFF + 1, 0xFFFFFFFF)
>
> Commits were overflowing corrected committer date offsets are rare, and
> offsets in that particular range are doubly rare. To be wrong within
> the range would be have an offset of 68 to 136 years, so that's possible
> only if the corrupted timestamp is in future (it's been 50.68 years since
> Unix epoch 0 so far).

Right, the c) variant has the same limitation as if corrected commit
date offsets were stored as signed 32-bit integer (int32_t), so to have
overflow we would have date post Y2k38 followed by date of Unix epoch 0.
Very unlikely.

>
> Thinking back to the linux repository, the largest offset was around of
> the order of 2 ^ 25 (offset of 1.06 years) and I would assume that holds
>
> Overall, I don't think the added complexity (compared to c) approach)
> makes up for by greater versatility.
>
> [1]: https://lore.kernel.org/git/20200703082842.GA28027@Abhishek-Arch/

All right.

With variant c) we have additional advantage in that we can pattern the
code on the code for EDGE chunk handling, as you said.

I wanted to warn about the need for sanity checking, like ensuring that
we have GDOV chunk and that it is large enough -- but it turns out that
we skip this bounds checking for extra edges / EDGE chunk:

	if (!(edge_value & GRAPH_EXTRA_EDGES_NEEDED)) {
		pptr =3D insert_parent_or_die(r, g, edge_value, pptr);
		return 1;
	}

	parent_data_ptr =3D (uint32_t*)(g->chunk_extra_edges +
			  4 * (uint64_t)(edge_value & GRAPH_EDGE_LAST_MASK));
	do {
		edge_value =3D get_be32(parent_data_ptr);
		pptr =3D insert_parent_or_die(r, g,
					    edge_value & GRAPH_EDGE_LAST_MASK,
					    pptr);
		parent_data_ptr++;
	} while (!(edge_value & GRAPH_LAST_EDGE));

Best,
--=20
Jakub Nar=C4=99bski
