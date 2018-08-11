Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26BF11F404
	for <e@80x24.org>; Sat, 11 Aug 2018 21:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727543AbeHKXfl (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Aug 2018 19:35:41 -0400
Received: from mout.web.de ([212.227.17.12]:42137 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727333AbeHKXfl (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Aug 2018 19:35:41 -0400
Received: from [192.168.178.36] ([79.237.241.252]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MbQGO-1fVp7L3VWW-00Iinl; Sat, 11
 Aug 2018 22:59:59 +0200
Subject: Re: [PATCH 2/2] fsck: use oidset for skiplist
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFy?= =?UTF-8?Q?mason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <c1ea6be5-57f7-68f1-0215-b4dceb07603a@web.de>
 <54a5367f-f832-402c-f51b-3225c92b41ad@web.de>
 <20180811170248.GC27393@sigill.intra.peff.net>
 <20180811172350.GA2689@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f69e08d7-b29d-a9b7-b6d4-5294c4379133@web.de>
Date:   Sat, 11 Aug 2018 22:59:57 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180811172350.GA2689@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:pz4nUZLU/RC+iDoKxXyPJZ6AaHXLmQ+HAgTbUFDZ76douDhipht
 ibXSnvPfMFpomvJja5J0h12aWJG8NEIh0Nv4lAnEcoYRzNc0TkbGv7gWE77mdh522+gnJ/I
 D/9GKv5QgRGkhZz8fUptnAuOFlKGUg0pjsLX/7q1I8YOSmtC1yfrf+UF2nbnF+wb/VNyA0W
 +hHxHt6LGesX6hI/hvOJg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:84uYJ5rLLPg=:paTRdpNywEnkC1gJUzquoj
 evx4v5I0G3oZDdVIegwIsVi4mECaO0zOJYU36lo6z9grcndPWU6BlynH/624rZ1HFXNfnbu7u
 jzZdkf4hWJJuYA35MiqL2+bR1IQXlcUx8RqNykMoMiu8+KKdahtSe8MxMbvUvC9yxk8tsud9v
 rm3EPj5h09s4EAN9wztSoRPhE4DbjtEcyzwNBsQ8WPkFkKJ9Uq5ktAnfiwHeCl+/Qh6pziwlf
 XXh364bbm8Uz9soJzylyTGcq69c0gFh6QxIqIrBtfKFXdt2R/xjAzDzZxyroZkJTalHiMKB9D
 EgKCJVJtn4VIKAB22JdZyJyq51ugLoVOzBP1Donryh26MvaCM1Wl6JE+iQS3VVWr+ycGvPpMs
 t/TEVoOj4IESExuWZhAktLi9859uF6+8RqWsjpJKQzEkVqzWNZigPyAu+P/WDa5AiQ4NMvvch
 89aM2YSqyDb35egXH9lbyMwMyAJR+x28wOT+kkF5SHrmMAlzjSWV0RByNy7smMdTnfQPbsJhA
 h7933qUQLSquMCdiwx5lIhPxHL6a+R+T2JOznkrB0j4EB145JMZPqzqGX7ZqZ2qAUkD3vgIff
 bZI+8uwjN9xKP9rFj9prXuwvPxmOevoqNi8ifb1812micmKjH0LThFaCT6BqrqMfDZUC7PR0h
 kWYHD9jFwcn0s/61UPZgnqcLhKlktNU6s5kK53uR0/YkuGfpJPnpnr0swo16OfN6wqpibnwQf
 ZSpW4Z3sEkoM/D2WCN/uKhI9t6MlH9nvkbkL2oKchLhWwJjcia0YaFnXvKpcMnoHUMrlW/cj+
 jz3y0GD
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.08.2018 um 19:23 schrieb Jeff King:
> On Sat, Aug 11, 2018 at 01:02:48PM -0400, Jeff King wrote:
> 
>>    - we could probably improve the speed of oidset. Two things I notice
>>      about its implementation:

> Before any optimizations, my best-of-five timing for:
> 
>    git cat-file --batch-all-objects --unordered --buffer \
>                 --batch-check='%(objectname)' >/dev/null
> 
> in git.git was:
> 
>    real	0m0.434s
>    user	0m0.414s
>    sys	0m0.020s
> 
> That's enumerating every object in the repo but not doing much more than
> de-duping the names and printing them.

> So a single hash lookup per
> object does not seem to be measurable. And thus teaching oidset_insert()
> to do a single hash lookup for check-and-insert is unlikely to help us.

> On top of that, I tried using a pool to store the set entries:

> That drops my best-of-five to:
> 
>    real	0m0.300s
>    user	0m0.288s
>    sys	0m0.012s
> 
> which is over a 25% speedup. So that does seem worth pursuing.

> For reference, the oid_array code path for cat-file is still:
> 
>    real	0m0.161s
>    user	0m0.157s
>    sys	0m0.004s
> 
> but that's not completely apples to apples. The oidset code is also
> iterating the packfiles in a different order and generating a revidx
> (which I know is about 25ms in this repo). So a better test would
> actually swap one data structure out for the other with no other changes
> (I just happened to have this test handy, and really wanted to know
> whether the mem_pool stuff would help).

If the current oidset implementation is so bad, why not replace it with
one based on oid_array? ;-)

Intuitively I'd try a hashmap with no payload and open addressing via
sha1hash(), which should reduce memory allocations quite a bit -- no
need to store hash codes and next pointers, only an array of object IDs
with a fill rate of 50% or so.  Deletions are a bit awkward with that
scheme, though; they could perhaps be implemented as insertions into a
second hashmap.

Balancing might become a problem.  Your cat-file example should be fine,
but someone could decide to add only hashes with a certain prefix to
their skiplist, and lookups would lopsided.

But first we'd need something like test-sha1-array for oidset and
some kind of performance tests based on these helpers, right?

René
