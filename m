Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A4FC4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:59:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 63BEC60F38
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbhHJTAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:00:18 -0400
Received: from mout.web.de ([217.72.192.78]:46753 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230351AbhHJTAR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:00:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628621963;
        bh=22GlMcEf5Xn8W7qFWY9RcRyWUvtxNHyXxZEhHud54Bc=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=MUA30noKy0gFFX0TkXqpRNW5hfkU7NO1YQAyi0oTjyqMB/+bmKov8kG2Kf0jE4BHg
         DXntUlKT9Ps93GhaCY7TlMTSkMdsbsL5aTToRT5AL7MARlDdmWyt0BOC9ezuJcKXm3
         zx3yboh4O1aY+2Y+sH8fdpnPSPCN1IrmIfwt4eHU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb103 [213.165.67.124]) with ESMTPSA (Nemesis) id
 0MF3f5-1mJty42aFP-00GECz; Tue, 10 Aug 2021 20:59:23 +0200
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Carlo Arenas <carenas@gmail.com>, Eric Wong <e@80x24.org>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
 <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de> <20210807224957.GA5068@dcvr>
 <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <eaf4eeb8-bd5f-5817-7a07-f72b735e1ad6@web.de>
Date:   Tue, 10 Aug 2021 20:59:21 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:V+mr1gkhzqjG7DXwW/JfRIAbYflgSx2/ME1dXnjmam9VMcFPN5b
 wvrT7Lkxc4J2p5GWKeIgpvFhuC40b55upP15oJJzdpV+TUu+uRguOAvhoIMFP6rLG81NdK7
 8KOY0MQIOoNpJLhX4qmUf/z6IPLAYAJenu7Vn88HO2lzHimfErPXTfU2KqbBZLxTLYOFE1Z
 qOD6lRaPLWk9wsujnIUmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Basl8/7f0vI=:Ok0femB3ALEqxbZRHVj/cK
 laxH9nlOX4kTvfSiBiZ1NbqYBIsp/x1fgEcQ9PbMJo/vBjG5moQRgN6d8UeTF1waDZ+/83zEE
 XmZzRWnVQhNhX52CRsHhHN3eF46IbemWpZ/M7z2sFx8Luhe1/oSngGzyyyLfmN5mfZeFY+FnR
 wRouc9DfFodTD7DODqWHB6a/JdVTG2DpOFrv2hvrNfvHQCKP9BjAL1DDBcAVHcB2wsPky/WQM
 yvz7SvT8p8dLmKUup5yTzMnL3YCEYbGdKxzGQvecIDSIjnSHF7dA81uWhTDzx/P2iIqL1lC7w
 +4WAMM0NdG2OilNq6mQhU90+wc7nUECa0ZWj3SP9MkslPxhoS/gE94pgVRQ9B1xCE6ASfldak
 YaAesVywMKh4bYZhsYcT/hqLSkQkmaCrfsMRSgOrfcqTAlyZOMsImNm32KV7ezyLp1lczMfpl
 PtIwecuVmoMsJTntH2pqPiT/iD13G19o0a0xT2Zy01DuwCUan3sSMxi7HnsrOnjwLEi31Sce1
 lQP+c3YXJhXoKs6ShuC9ZvNFhyON8kJDWJT5G/QgSzfM/RdE7M6v2x9x0Dxkt/gKLH7sHQtZU
 zQPU1Vlt9BMlY1OuzLHBTJNRmO0nQUUUMEPysY3Ae+d2IkA3oKGhffizwqDkIT1l+k3JcVZxj
 hd7J+im0HSRleg8qPPPh3PJnOBQeh6DDsqsY16K6mr0TNdrwV3T4JFuaW1PYprUfQB0STGtxo
 /lBQF5rIc37SJ4LCxmgZlH3HpVhCskobrlFIopNS+gCFJDBZwO3qtXp6Nge0omqROSw8dPQLb
 3GLZ84c1NQUh2kbz/CAnF/HLlLB5mqFt8BrM2c5ZbcvKvSF3uS2Td87ub2mnY8gk9g+nISCVq
 45/HXHTy/kd4rDAqy/fUT9A4TUpzRGOvAE6wW50zO2qaNxTniAGSI0dZV2QlVhDaZhz1tADwn
 UJv804OLXoSa6d6cwdqabHfHfoVGV6in0c8WLbMr1/7ACtD/c4VCBMJZOl7IaxhKofd+jNDX7
 5DcvQZN+oKpAc0f9gkLuXAFAgcQzawBlKcJ3Z/LVfXLT/lJEhf3pW8Yke8yplwxYjHDFNCwhO
 ijqoR8TE3/y4yKssYeD95OTJb2Eg4203Zb1
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.08.21 um 03:35 schrieb Carlo Arenas:
> On Sat, Aug 7, 2021 at 3:51 PM Eric Wong <e@80x24.org> wrote:
>>
>> Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>>> Am 06.08.21 um 17:31 schrieb Andrzej Hunt:
>>>> On 29/06/2021 22:53, Eric Wong wrote:
>>>>> [...snip...]
>>>>> diff --git a/oidtree.c b/oidtree.c
>>>>> new file mode 100644
>>>>> index 0000000000..c1188d8f48
>>>>> --- /dev/null
>>>>> +++ b/oidtree.c
>>
>>>>> +struct oidtree_node {
>>>>> +    /* n.k[] is used to store "struct object_id" */
>>>>> +    struct cb_node n;
>>>>> +};
>>>>> +
>>>>> [... snip ...]
>>>>> +
>>>>> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid=
)
>>>>> +{
>>>>> +    struct oidtree_node *on;
>>>>> +
>>>>> +    if (!ot->mempool)
>>>>> +        ot->mempool =3D allocate_alloc_state();
>>>>> +    if (!oid->algo)
>>>>> +        BUG("oidtree_insert requires oid->algo");
>>>>> +
>>>>> +    on =3D alloc_from_state(ot->mempool, sizeof(*on) + sizeof(*oid)=
);
>>>>> +    oidcpy_with_padding((struct object_id *)on->n.k, oid);
>>>>
>>>> I think this object_id cast introduced undefined behaviour - here's
>>>> my layperson's interepretation of what's going on (full UBSAN output
>>>> is pasted below):
>>>>
>>>> cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my
>>>> machine: offsetof(struct cb_node, k) =3D=3D 21). We're casting its
>>>> pointer to "struct object_id *", and later try to access
>>>> object_id.hash within oidcpy_with_padding. My compiler assumes that
>>>> an object_id pointer needs to be 4-byte aligned, and reading from a
>>>> misaligned pointer means we hit undefined behaviour. (I think the
>>>> 4-byte alignment requirement comes from the fact that object_id's
>>>> largest member is an int?)
>>
>> I seem to recall struct alignment requirements being
>> architecture-dependent; and x86/x86-64 are the most liberal
>> w.r.t alignment requirements.
>
> I think the problem here is not the alignment though, but the fact that
> the nesting of structs with flexible arrays is forbidden by ISO/IEC
> 9899:2011 6.7.2.1=C2=B63 that reads :
>
> 6.7.2.1 Structure and union specifiers
>
> =C2=B63 A structure or union shall not contain a member with incomplete =
or
> function type (hence, a structure shall not contain an instance of
> itself, but may contain a pointer to an instance of itself), except
> that the last member of a structure with more than one named member
> may have incomplete array type; such a structure (and any union
> containing, possibly recursively, a member that is such a structure)
> shall not be a member of a structure or an element of an array.
>
> and it will throw a warning with clang 12
> (-Wflexible-array-extensions) or gcc 11 (-Werror=3Dpedantic) when using
> DEVOPTS=3Dpedantic

That's an additional problem.  UBSan still reports the alignment error
with your patches.

Ren=C3=A9
