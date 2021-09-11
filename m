Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE19C433EF
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 23:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49D806101D
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 23:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhIKXlU (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 19:41:20 -0400
Received: from mout.web.de ([212.227.15.3]:54843 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230403AbhIKXlT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 19:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631403593;
        bh=vwltlo/z9nXy4iFdtYinfPMzdiUR3gJHqNxnC0RQNcs=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=KAHnJQHnwsUa5T5yENw7e2FNYnB8nqKzfsfInqVhRMS6Y5spXMyvb1Hz3UJGOUfAq
         iBuWCPEBdKFyqL0psj/2cgQCUigJexIb2+Be0EEDF99pN7nP2FRViccG3HKsm9x7VM
         D51EPpTeI/kUvFAXdSpAJsTOVP9ASgB46OH90muY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1N3Xjb-1n7e5S0Yp1-010WrG; Sun, 12 Sep 2021 01:39:53 +0200
Subject: Re: [PATCH 4/3] midx: inline nth_midxed_pack_entry()
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <7d9e67bf-e057-694c-c976-ba19e9521882@web.de>
 <YTziaNywmCMn07IS@coredump.intra.peff.net>
 <120ffa79-d3cb-2e81-1da6-358e7407ec69@web.de>
 <YT0dgTgLVrtS9md6@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <a96f8f25-46c6-5d61-6b3d-4b2da2e44566@web.de>
Date:   Sun, 12 Sep 2021 01:39:52 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YT0dgTgLVrtS9md6@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DPoHb2Y8DlRcFvDIZq+1mcoqQj20lqlD7aUmrPNM6B8umGsYV/9
 wAg5uPvHJlCOujQQGrM0m7o1XAGyYGXCB0fp0KyjMOjPE+US7q13dhahcstmblhENprz/ER
 b+uvMDKWUI5m04WdsDjyrYXA7LoGbJ2pBgga1nIPyvlF/3BehAa88zurjEz6OERC08hqMGc
 //2ub7KLV9CBltvQIPX3A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UQrmI1eR9Hc=:m8r+68v/KJTlvnCRvkoyr5
 myuemCVqrPKyYpJcMlocnp11IenBeQKzaEKOIrnWoBOXkx4AfXxiWZEX7DLT0eblciNP6eVOC
 6VI4LKp6V1imWfDzmbeO2fcW/6KbSqTkYvhBYUwKRNiBzzO4BKr6GzMbi4eN5PBBt68Z1o8c4
 aD4V10FzH6N/Z7qmlX3+ERayRWsv6NhmUY3nTfbTUhPOgwysdKRxE7PkA2I4BzHM6nGQVtEnr
 ytRsdK15+qUPktoEiiooiGX+rKK3MJ0mAFbCHCz0Dm/ag6PTjozoZi9eBJYookhkf9sw5l7YI
 XI9/CNdz1ePRIy1TTe/apydT2MtOUe+lS9t1iECPkZ8ZheGOuDfSCLaMRsmMWBWFTJ0Efbkfe
 FQH0BXinZ/sHKrGCOD/5Vakpvju768HUgKD1LR6XnKA8wVG6sx7QC5LwM0aj/iERiw+/izmfQ
 1DutTH4RmeyXgB+9QNI04hxSIiGS4y+Ok66E21y8aLGobOGsPBcMz0tW1KHBV1qm7SafDq9wl
 bjjc419Bhd5oT4z4MwlqmBKDDK7aLTd/rudORh6Gjk6SkhZsSdASgqHdJjhnrkLbneXhI5hXX
 q8eYh1mvijAIkgKT0U/AgGur08huqabeaNYkBgkKjw39kv9gQoUfc6qSawseCNzkcMScqnJ8y
 fyupJPZXCp4JnTOT0Tawj4vu6spw2HdaQ45OVbIRFDdP7uKH9ndBjLcAsnY5k97JuDod5Mt+6
 ghJdUstWuZiko4L7VLav28BZAYo/9hP7B3ZLnmpan2oqz0IKm25XQrXsr52VGb1XOqocmNsae
 tiY/CKy2zMDxr4swpO7R5+GGVy5Zgci4AabYNEx+V5xfsGg9gnGnZjPFNCrRheMJfZ7R0D6ee
 6Lqza0fofzdTwS7CVkQYQu7Zsrps/utqKtxIGR7o4MC9NVl3W4QJwGE6OganpOPmu8j1LDLs1
 7kcrSrPfusGE5kU0BGDwtczYhAFlAV4NDHZi4+3f77OTv4pBDD73Yyhx8ZfZYdbIrSI7Lq2em
 OiO0e1ZjLbYQG2aF5clV0TXpDXsZevhw7HgwzC98us74afsT3GahBlMeWjFaJRAbAWbULHxhF
 PR+QhVDssy6xDI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 11.09.21 um 23:20 schrieb Jeff King:
> On Sat, Sep 11, 2021 at 10:31:34PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> Am 11.09.21 um 19:07 schrieb Jeff King:
>>> On Sat, Sep 11, 2021 at 06:08:42PM +0200, Ren=C3=A9 Scharfe wrote:
>>>
>>>> @@ -304,8 +307,7 @@ static int nth_midxed_pack_entry(struct repositor=
y *r,
>>>>  	if (!is_pack_valid(p))
>>>>  		return 0;
>>>>
>>>> -	nth_midxed_object_oid(&oid, m, pos);
>>>> -	if (oidset_contains(&p->bad_objects, &oid))
>>>> +	if (oidset_contains(&p->bad_objects, oid))
>>>>  		return 0;
>>>
>>> So we get to avoid the nth_midxed_object_oid() copy entirely. Very nic=
e.
>>>
>>> Compared to the code before your series, we still have an extra functi=
on
>>> call to oidset_contains(), which will (in the common case) notice we
>>> have no entries and immediately return. But I think that's getting int=
o
>>> pointless micro-optimization.
>>
>> Right.  I measure a 0.5% slowdown for git multi-pack-index verify.  An
>> inline oidset_size call avoids it.  That's easy enough to add, so let's
>> have it!
>
> I don't mind that, but I wonder if we can have our cake and eat it, too.
>
> oidset_contains() is short, too, and could be inlined. Or if we're
> worried about the size of the embedded kh_get_oid_set() getting inlined,
> we could do something like:
>
>   static inline int oidset_contains(const struct oidset *set, const
> 				    struct object_id *oid)
>   {
> 	if (!oidset_size(set))
> 		return 0;
> 	return oidset_contains_func(set, oid);
>   }
>
> That saves callers from having to deal with it, at the expense of a
> slightly complicated oidset implementation.
>
> I guess it's an extra integer comparison for callers that _do_ expect to
> have a non-empty set. So maybe it is better left to the caller to
> decide whether to optimize in this way.
>
> (A totally inline oidset_contains() avoids the extra check, but possibly
> at the cost of larger code size).

I wondered the same.

Inlining oidset_contains() would follow the spirit of khash.  It adds
16KB to my build (ca. 688 bytes per caller).  Hmm.

I expected the hybrid approach with an inlined emptiness check and a
shared actual contains function to be as fast as the original code, due
to caching.  I actually saw the 0.1% slowdown of git multi-pack-index
verify when I added a fake bad object at the end of prepare_midx_pack()
to simulate a non-empty oidset.  Hmm!

Both are probably defensible, but for this series I took the more
targeted approach to limit the impact.

Ren=C3=A9
