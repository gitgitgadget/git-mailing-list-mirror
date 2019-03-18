Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B29C620248
	for <e@80x24.org>; Mon, 18 Mar 2019 22:02:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfCRWCL (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 18:02:11 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:36086 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbfCRWCL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 18:02:11 -0400
Received: by mail-ed1-f68.google.com with SMTP id e4so14901137edi.3
        for <git@vger.kernel.org>; Mon, 18 Mar 2019 15:02:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=7kCCy7S5nSRUUQKUjHnTLN8vsh4sTO5W9scqyk+vK8E=;
        b=FQk8iuapHN3kYVacBV7a3bGjGvohb5sGoQgl2kq+B25EB1U/zZnIIQ1W3v0ujOBWgd
         yVoZxYPgHJCkJoP0/dyNEDcL/Ya/s5Vf4m6m/2PQjv5+oHP5LkvJc3Ein4qeGmx5KIol
         Pod7qcJ/BkPHW231X48qYSKzaJdmKLruHdLMnk7nlO39S+128BE/+q68wbtfoZPfc8fU
         LWajTsRxLKxL1MCLgjQFJe2HaOHx4xDUCgj1GGkcQ45/OT0KV39y1bf91Zazk21ADtL/
         BQArZ4ffz5kU55knP1+cY57LZnGQfSoASw00cMU+beMEvcvEXKwM4NrxUsjXQRjx2cJX
         3Cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=7kCCy7S5nSRUUQKUjHnTLN8vsh4sTO5W9scqyk+vK8E=;
        b=USea74Bucv2mNEb4D4eHKuuuuh34YxxE6s82wt2ifgk2zdUSWDeZRsvutmFfcTvtRa
         GoEY5ABkUtq3U1thPVQNmM9zpIXsgWmnllta7+ztttiv1fvpqcFEfWojV8Xkfnwk4v7Q
         uZ7wjQ4yekEEkLhxFM8NsitQebVNCK9phRlS1u7dMdgJQm9Glx5OFgHeHJKVwnlf6+zh
         d6tPmKzHWzk7iXYNMyaI6tnKxwR343IvebcK0mU472g4z4UlyRYAQqx9iuBsVzvkf+TN
         fNp0SzdNnZSIw1Q2u5pTihO8ztlQliCX0uhiFVOgyCTmyWNEAuA3Vpg2HqliWvLkYEGH
         ssBg==
X-Gm-Message-State: APjAAAVmXVL5Uz38OALRC6DwzwQQxT0pkx2pLDukqc0xZ5Dy4VSrO+xx
        LlygG2J15NIVdxzfIDaUa5nqlikI7Jg=
X-Google-Smtp-Source: APXvYqyNG7a548DlT2Zq1cCSZgC2Z0NbNJXsdRYYj7yz2a4y7/XXgBQ8iIVnbj2ziT+i1ODZxoO0ow==
X-Received: by 2002:a50:ba3d:: with SMTP id g58mr5539968edc.104.1552946528724;
        Mon, 18 Mar 2019 15:02:08 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id u2sm3667169eds.53.2019.03.18.15.02.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Mar 2019 15:02:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com,
        Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 2/3] midx: verify: group objects by packfile to speed up object verification
References: <pull.166.git.gitgitgadget@gmail.com> <86f6b0325821a9e1742a28895f9c9b712a1fdec4.1552919394.git.gitgitgadget@gmail.com> <87pnqodvr9.fsf@evledraar.gmail.com> <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <9c4da72d-6066-8d05-f181-a93c3926705f@jeffhostetler.com>
Date:   Mon, 18 Mar 2019 23:02:06 +0100
Message-ID: <87lg1bet9d.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Mar 18 2019, Jeff Hostetler wrote:

> On 3/18/2019 11:53 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>
>> On Mon, Mar 18 2019, Jeff Hostetler via GitGitGadget wrote:
>>
>>> +static int compare_pair_pos_vs_id(const void *_a, const void *_b)
>>> +{
>>> +	struct pair_pos_vs_id *a =3D (struct pair_pos_vs_id *)_a;
>>> +	struct pair_pos_vs_id *b =3D (struct pair_pos_vs_id *)_b;
>>> +
>>> +	if (a->pack_int_id < b->pack_int_id)
>>> +		return -1;
>>> +	if (a->pack_int_id > b->pack_int_id)
>>> +		return 1;
>>> +
>>> +	return 0;
>>> +}
>>
>> Not a suggestion for a change, just a note that this sent me down the
>> rabbit hole of looking at the different idioms we use for QSORT() in
>> different places. Some use this form, some a ternary nest, and some the
>> succinct subtraction idiom of e.g. (in this case):
>>
>>      return b->pack_int_id - a->pack_int_id;
>
> Yeah, I'm not sure which way is better or worse here.
> An earlier draft of this function sorted by packfile id
> and then by OID (thinking we might benefit from some
> locality later when we do the verify), hence the independent
> if statements.  But it didn't help, so I removed the other
> lines.
>
> On 43+M objects, your version is a hair faster, so I might
> as well take it instead.

Cool!

>>
>>> +
>>>   int verify_midx_file(const char *object_dir)
>>>   {
>>> -	uint32_t i;
>>> +	struct pair_pos_vs_id *pairs =3D NULL;
>>> +	uint32_t i, k;
>>>   	struct progress *progress;
>>>   	struct multi_pack_index *m =3D load_multi_pack_index(object_dir, 1);
>>>   	verify_midx_error =3D 0;
>>> @@ -997,15 +1017,36 @@ int verify_midx_file(const char *object_dir)
>>>   	}
>>>
>>>   	progress =3D start_progress(_("Verifying object offsets"), m->num_ob=
jects);
>>> +
>>> +	/*
>>> +	 * Create an array mapping each object to its packfile id.  Sort it
>>> +	 * to group the objects by packfile.  Use this permutation to visit
>>> +	 * each of the objects and only require 1 packfile to be open at a
>>> +	 * time.
>>> +	 */
>>> +	ALLOC_ARRAY(pairs, m->num_objects);
>>>   	for (i =3D 0; i < m->num_objects; i++) {
>>> +		pairs[i].pos =3D i;
>>> +		pairs[i].pack_int_id =3D nth_midxed_pack_int_id(m, i);
>>> +	}
>>> +	QSORT(pairs, m->num_objects, compare_pair_pos_vs_id);
>>> +
>>> +	for (k =3D 0; k < m->num_objects; k++) {
>>> [...]
>>
>> I have not tested this (or midx in general), but isn't this new QSORT()
>> introducing the same sort of progress stalling that I fixed for
>> commit-graph in 890226ccb57 ("commit-graph write: add itermediate
>> progress", 2019-01-19)? I.e. something you can work around with a
>> "display_progress(progress, 0)" before the QSORT().
>>
>
> I wasn't tracking your commit-graph changes, but yes, I think it is.
>
> Tinkering with how to display progress, I found a couple of problems.
> On my 3599 packfile, 43M object example, QSORT() takes about 5 seconds.
> But there's about 2 seconds of setup before the sort starts.  The final
> verify loops takes about 17 seconds.
>
> Here I put trace2 regions around the main loops and used the
> GIT_TR2_PERF stream.
>
>> | cmd_name     |     |           |           |            | multi-pack-i=
ndex (multi-pack-index)
>> | cmd_mode     |     |           |           |            | verify
>> | data         | r0  |  0.031295 |  0.031295 | midx       | load/num_pac=
ks:3599
>> | data         | r0  |  0.031330 |  0.031330 | midx       | load/num_obj=
ects:42704807
>> | region_enter | r0  |  0.031352 |           | midx       |
>> label:verify/prepare | region_leave | r0  |  0.626547 |  0.595195 |
>> midx       | label:verify/prepare | region_enter | r0  |  0.626602 |
>> | midx       | label:verify/oid_order | region_leave | r0  |
>> 1.570195 |  0.943593 | midx       | label:verify/oid_order |
>> region_enter | r0  |  1.570253 |           | midx       |
>> label:verify/sort_setup | region_leave | r0  |  1.809723 |  0.239470
>> | midx       | label:verify/sort_setup | region_enter | r0  |
>> 1.809803 |           | midx       | label:verify/sort | region_leave
>> | r0  |  6.950595 |  5.140792 | midx       | label:verify/sort |
>> region_enter | r0  |  6.950651 |           | midx       |
>> label:verify/offsets | region_leave | r0  | 24.059736 | 17.109085 |
>> midx       | label:verify/offsets | exit         |     | 24.101434 |
>> |            | code:0
>
> So just adding a delay progress block by itself around the sort doesn't
> help much.  It just sits there for 7 seconds before the actual progress
> starts.
>
> If I add a non-delay progress block around the "verify/prepare",
> "verify/oid_order" and the "verify/offsets" loops, we get a pretty good
> experience.
>
> There is the dead time while the sort() itself is running, but at least
> there is isn't a 5+ second frozen at 0% message on screen.

Yeah, the same with the commit-graph with my hack. I.e. it'll sit there,
but at least it sits like this:

    What I was doing before 100% (X/Y)
    What I'm about to start doing 0% (0/Z) [hanging]

Instead of:

    What I was doing before 100% (X/Y)
    [hanging]

So that's an improvement, i.e. you know it's started that next phase at
least instead of just having a non-descriptive hang.

Ideally there would be some way to reach into the QSORT() and display
progress there, but that's all sorts of nasty, so as the TODO comment in
commit-graph.c notes I punted it.
