Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA852C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:41:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7163920675
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:41:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ntmr1Rz0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgDBSlA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:41:00 -0400
Received: from mout.web.de ([212.227.17.12]:33199 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgDBSk7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 14:40:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585852850;
        bh=Ccd0RbIHi6nqNAoNN5CHJ/7pa+G5S7Mrnu72Lv+LaFs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=ntmr1Rz0Ju3qXPzJ9qJTb9CFqGWmphZzzKbmvL9PNIYgrCmaBhoOB1FxtRzft+NNw
         rYiAYiu1eg2DRTVWRDZHSOQIbGQm5h8yfZgnZA+5vPxFOwkHpvybdul/H7A5SMSBea
         ujdXCA8vofIns8VpsX2X5pyzKMiWy8GwtN+3OhCE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORiL-1jNdXL0BKH-005obS; Thu, 02
 Apr 2020 20:40:50 +0200
Subject: Re: fast-import's hash table is slow
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <20200401103522.GE60227@coredump.intra.peff.net>
 <20200401111621.GA1265072@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <38be9140-546c-e3fa-fb71-c92937094a40@web.de>
Date:   Thu, 2 Apr 2020 20:40:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401111621.GA1265072@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:hQIxqWleqUn96/A5U2Li7AgShqAj8CgSBbkXdXQuqA+i6TdXKV7
 0rZy2FiSmwf6cFfTk4hpp2mqabBxhBh58M6v+70QoMwSAiPN/rcLDOJyQki7QVyRdnoUOjH
 CElj1ZJvr4MC52fCWadcqIUeGrtACBt7kAI48Tb2mfAWw3priVgxsexxj6fO4t+ihpgUut5
 yjO9KjFshxbGWsF9yzrDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ePY9Nimf6Zg=:6NWiUFZ2DE+EcNOwqD5xTD
 kAyTHzmgpMIKICVS4pECNivmaQovk9ywwFxX8ttN7m3g2nmjZtcDlwAORm1n0/+JdAhPAXDsz
 qRhy95oJmBJrljXAMYRPPs522CjOF4Z9QCDXYvaUwvWiyD/Dd5pi0XZEq3gBkNsrsV7cWqCgP
 I0qky8vrUzm9qvS8vMnCcz19PkHk1B3RiIwC4UoXxOGGViXb00nqPP2HOi84YxdEORWh9tSUR
 YLMvVZsgypN5O+pof7eu6kwxvRlNmalD3tu0KauiHks0vNncEVYnvYZ2GV5i4ZASRPzjfOAre
 CJQyD8iRXe5XUPkgVWVSDaZl0Pkic9dISDJQqi2yI44qhAMYSYSh5wJjabcB7ptG50V1UstQt
 zQpudpMWuvLLTggxH76fyF2pDGgbjuUC+XHXQYCCpdTxV/yw18nxS03gYu0YPImu1JW5CUbu7
 OJ1so3y43AwQII7l1qZwfDBF6Skz986S67EDia79JraBs7pSZrYhP9f4ONR+01UjtGfFXqYg1
 96VyFtCD0KKoBmwB/oWBZsGYRn0M6+j7Dz2i7jUT87ckWHYlYLGgoFmTP9ZxY3nRtz4NaoPnX
 1ZaE385B03HVT9pG5uFn2U9ixSdbJ/yyMKCLIiOmrc6P0rkumJzzst8+9Jl1zkJJk1Jsgdx6Y
 7xvoU4tDey+FNjyalhOt3rt1DL6eKdQvyl+YSXHzEn6dnIBu0I4o2pICBWW+sy4JNjp3YbsqE
 +EQdzh6dzD5g6x4WDX7Ga/HuLQyA72YZo8/1QIdqz3tkNdLkfgC33TTXZhy0LQi+myFYq6v/E
 4ExAl5ONG9fA97mmY2wU2Oq0Ey4dPJLcwRNLKRoJPnwrgtyYVDlqmeILFRHO+6O6Tc2M/DSao
 kMi5rujof+N1HX9APxZ000JyArf8SFwOugaOa84NApgvc1aMDJ5+ojKAqM41CjHYEE8hOPb/z
 fLPQKTOvMOY7yy08MuoQviXd+ds0hvUryv55O7wcc6w2UyicYfWJcBaK2yNpxHmACZHmFgz9U
 ReV5TJCN1J7rxtOLUnTLB2AR/1tOLVcaaEsSpeb/qeKsi2VN9NFoGyeRdIp0Z9MgRoAQVa9N4
 J17RktK/7ZP1AoBOtgZYZw/xVnVyOtCSV1ZD8T3BDxVpldtQTr7MziOeXETt4wum00fl+zW+3
 +qYUW4fXRKQYbSglZK4lCASX0RlsXYTGqgFFjyY2QlUEnBWHVPMzsrg897A//vLJxJOXE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.04.20 um 13:16 schrieb Jeff King:
> On Wed, Apr 01, 2020 at 06:35:23AM -0400, Jeff King wrote:
>
>>>> +	/*
>>>> +	 * this cast works because we only look at the oid part of the entr=
y,
>>>> +	 * and it comes first in the struct
>>>> +	 */
>>>> +	khiter_t pos =3D kh_get_object_entry_set(&object_table,
>>>> +					       (struct object_entry *)oid);
>>>
>>> Dirty, but I can believe the comment.
>>
>> Our hashmap.c implementation gets around this by letting the equality
>> function take an extra parameter. It's annoying when you're writing
>> those functions, but it should allow this case without any casting (or
>> preemptively allocating a struct).
>
> And here's a patch trying that. Much to my surprise, it outperforms
> khash, which has generally been faster in previous tests.
>
> Here are the numbers I get:
>
> nr_objects   master       khash      hashmap
> 2^20         0m4.317s     0m5.109s   0m3.890s
> 2^21         0m10.204s    0m9.702s   0m7.933s
> 2^22         0m27.159s    0m17.911s  0m16.751s
> 2^23         1m19.038s    0m35.080s  0m31.963s
> 2^24         4m18.766s    1m10.233s  1m6.793s
>
> And I didn't even have to pre-size the table. This really makes me
> wonder if there's some silly inefficiency in khash which we could be
> addressing. Or maybe open-addressing really does lose to chaining here,
> but I think we keep the load factor low enough that it should be a win.

Or we're just unlucky.  I tried to find the difference between khash
with and without presizing using callgrind, but came up empty.  It did
reveal that fast-import spends 70% of its cycles in a million memset()
calls issued (indirectly) by git_deflate_init() which in turn is called
by store_object() which is called from parse_and_store_blob(), though.

Why is the won second when handling 1M objects not showing in its
output?  I suspect it's because it uses its custom allocator to gather
its data.  So I ran the test with jemalloc2 preloaded:

nr_objects   master       khash       khash+preload
2^20         0m5.812s     0m5.600s    0m5.604s
2^21         0m12.913s    0m10.884s   0m10.357s
2^22         0m31.257s    0m21.461s   0m21.031s
2^23         1m20.904s    0m40.181s   0m42.607s
2^24         3m59.201s    1m21.104s   1m23.814s

My measurements are noisy, but my point is simply that with a different
allocator you'd not even have seen any slowdown when switching to khash.

>
> ---
> diff --git a/fast-import.c b/fast-import.c
> index 202dda11a6..0ef6defc10 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -39,12 +39,28 @@
>
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	struct object_entry *next;
> +	struct hashmap_entry ent;

That uses 16 bytes more memory per entry on x64 than khash would.
That's 256MB for 2^24 objects -- not ideal, but bearable, I guess.

>  	uint32_t type : TYPE_BITS,
>  		pack_id : PACK_ID_BITS,
>  		depth : DEPTH_BITS;
>  };
>
> +static int object_entry_hashcmp(const void *map_data,
> +				const struct hashmap_entry *eptr,
> +				const struct hashmap_entry *entry_or_key,
> +				const void *keydata)
> +{
> +	const struct object_id *oid =3D keydata;
> +	const struct object_entry *e1, *e2;
> +
> +	e1 =3D container_of(eptr, const struct object_entry, ent);

That's nicer that the pointer alchemy in the khash conversion for sure.

But why const?  Can const change the layout of a structure?  Scary.

Ren=C3=A9
