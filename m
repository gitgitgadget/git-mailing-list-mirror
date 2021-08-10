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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2FA7C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:41:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D0F60C3E
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 19:41:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbhHJTl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 15:41:26 -0400
Received: from mout.web.de ([212.227.17.11]:41465 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229743AbhHJTlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 15:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628624447;
        bh=8j4DnNG04XFIlO4OGNZkFvWGgnqQ9DpqaXVWho49Fus=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=HEFWeD+nXqB8AuHCCj5JsCrCBpmhUlgH8f5geNwyztOiLVshQ0vYphz1MWX2n/9QJ
         dxQVBmPb1AoUb5OmTTxWicR4fQwQy7i7CZk+/lkqtch+rRQzH4lNfwgnPdWjF9Wcw8
         EtYxoUiWvr1R5XB71NMmHCLXHqNCRK3jwbHgos1A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb106 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MiMEW-1mijEH0hOQ-00fRys; Tue, 10 Aug 2021 21:40:47 +0200
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Eric Wong <e@80x24.org>
Cc:     Andrzej Hunt <andrzej@ahunt.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
 <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de> <20210807224957.GA5068@dcvr>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <d7e11b65-cd20-6a0f-7440-6003578aa680@web.de>
Date:   Tue, 10 Aug 2021 21:40:45 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210807224957.GA5068@dcvr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r3ID4//Vl5vMtO4d6p2iKhWkkS5LtH54/xybnOIYO9jlGG7deoP
 TQSmuBv/MqyB9L1XyOEYTIrBFl14Qa6Qawim/7CFiTOG3GMNoWUu7jz4ZWHMmE+TNa81lM1
 jbKgi6erst4MmQdwY7IttyvjxlAdCBTa5VCIvscO58CkPnAPii1VrotkfSAUEGm4aceHP6R
 2GVHaaBEt8s/WW9fDUJIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DzGFdzjgifw=:oa5DwZVxRA/JpSywryCww2
 2PoiIEkHwoWcS39KO9Mic3nl2trMuTs3VQB1zgAY1BntT5jjH1aUS6vljSTLWDZMIlJ5ngkeb
 SxVDYy5SyBPHa7XIqofDgBUqyhq/EB8EnS6ySfFjc6rh7jIRMDcnzSliCu6k/gEqqv7JX+S3K
 XYtsEHypl8WEKa4J3Dd2F5QP1wMEEUm79fJlfPIW0hb7TZDfZ/Mf0GTqKVAtTxVY1pGcxiFKk
 fQmoTtkvzDOyI3Zkvq5EsORuxo7SiJH/tGDzXhCJtonPbWmIcYL2E8gxMhnnMWk9SoiZ+dh6T
 E9fF6dO7JWiu0/bQGmXSkbbDnKITEf3MI9o4Zka9geK0xSRaf3ND/rH8SSAeSjsY2tXEnsO56
 ViNOtJkfTo1uSY2Pz1Qfu+wtNbZ5TS5nvdIoukYZX4kRAzf2AwOZXuVYpig8B2H/rIQqbyVW0
 QMYt7cNumV1MLVItrqlnJW0AUZOvhbFz9nVEMbLwiEia1WNyiOn9CA+OcpRk8f51SMeFJ88XU
 yNSUCWrx5+SFnPpYn7iWMRSYrcHl/rfZJz0F6alci4SQm5dVfjc8oeW0B0KaBexr02TuvWB1z
 We3vOd0aztHcuk5W7SvwzxuuC2os9oyfnL/J9x96zhXNAJjdTOgHMy62/AFvGYRpbX4s/cOFi
 NrZ9oX4ysJDlVFPwgIO3BI78BcZVqpE7o15DnwQRIxhatIIEp5QyhYU4qWumRWBa7UpecrBTn
 u2IB4fWjaa38fR7Pxdl8YKNgaocukosq0EYweyAovml2aoZ/K9JIjJkynenH8hGN9rBKZd4DZ
 rqUle5Y88emoSYz/W1LTOEEpYDcuuDofKIcEZfptJijlsNECCRD1pZq5O2mgGFkvPDc3h+2Km
 stAx6vlYibAE3xVUjB7raL0VjiY0fp0y5rb+i1MnCmKUKQozh5qLPzTSpI0u91vyY3/M2NJSm
 j+lC8JozMKsUJXapJZdhiEDQxJQ/BrLeUISl7+JjYYapH5ffBTkjYycBQ9wjE64ZBY9MvJKek
 wHZamkHz/J2m00Zuz9SmUTKRiCqg0m9UJ9BvLtQ1CqUSNwDZLrTzRr/ZJ+h5DMioR3/vzQJz9
 VWfPYigxN9V855/Hp+chHbDXWHY7h9bdmaW
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 08.08.21 um 00:49 schrieb Eric Wong:
> Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>> Am 06.08.21 um 17:31 schrieb Andrzej Hunt:
>>> On 29/06/2021 22:53, Eric Wong wrote:
>>>> [...snip...]
>>>> diff --git a/oidtree.c b/oidtree.c
>>>> new file mode 100644
>>>> index 0000000000..c1188d8f48
>>>> --- /dev/null
>>>> +++ b/oidtree.c
>
>>>> +struct oidtree_node {
>>>> +=C2=A0=C2=A0=C2=A0 /* n.k[] is used to store "struct object_id" */
>>>> +=C2=A0=C2=A0=C2=A0 struct cb_node n;
>>>> +};
>>>> +
>>>> [... snip ...]
>>>> +
>>>> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
>>>> +{
>>>> +=C2=A0=C2=A0=C2=A0 struct oidtree_node *on;
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 if (!ot->mempool)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot->mempool =3D allocate_=
alloc_state();
>>>> +=C2=A0=C2=A0=C2=A0 if (!oid->algo)
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG("oidtree_insert requi=
res oid->algo");
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 on =3D alloc_from_state(ot->mempool, sizeof(*on) =
+ sizeof(*oid));
>>>> +=C2=A0=C2=A0=C2=A0 oidcpy_with_padding((struct object_id *)on->n.k, =
oid);
>>>
>>> I think this object_id cast introduced undefined behaviour - here's
>>> my layperson's interepretation of what's going on (full UBSAN output
>>> is pasted below):
>>>
>>> cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my
>>> machine: offsetof(struct cb_node, k) =3D=3D 21). We're casting its
>>> pointer to "struct object_id *", and later try to access
>>> object_id.hash within oidcpy_with_padding. My compiler assumes that
>>> an object_id pointer needs to be 4-byte aligned, and reading from a
>>> misaligned pointer means we hit undefined behaviour. (I think the
>>> 4-byte alignment requirement comes from the fact that object_id's
>>> largest member is an int?)
>
> I seem to recall struct alignment requirements being
> architecture-dependent; and x86/x86-64 are the most liberal
> w.r.t alignment requirements.
>
>>> I'm not sure what an elegant and idiomatic fix might be - IIUC it's
>>> hard to guarantee misaligned access can't happen with a flex array
>>> that's being used for arbitrary data (you would presumably have to
>>> declare it as an array of whatever the largest supported type is, so
>>> that you can guarantee correct alignment even when cbtree is used
>>> with that type) - which might imply that k needs to be declared as a
>>> void pointer? That in turn would make cbtree.c harder to read.
>>
>> C11 has alignas.  We could also make the member before the flex array,
>> otherbits, wider, e.g. promote it to uint32_t.
>
> Ugh, no.  cb_node should be as small as possible and (for our
> current purposes) ->byte could be uint8_t.

Well, we can make both byte and otherbits uint16_t.  That would require
a good comment explaining the reasoning and probably some rework later,
but might be the least intrusive solution for now.

>> A more parsimonious solution would be to turn the int member of struct
>> object_id, algo, into an unsigned char for now and reconsider the issue
>> once we support our 200th algorithm or so.
>
> Yes, making struct object_id smaller would benefit all git users
> (at least for the next few centuries :P).

True, we're currently using 4 bytes to distinguish between SHA-1 and
SHA-256, i.e. to represent a single bit.  Reducing the size of struct
object_id from 36 bytes to 33 bytes seems quite significant.

I don't know how important the 4-byte alignment is, though.  cf0983213c
(hash: add an algo member to struct object_id, 2021-04-26) doesn't
mention it, but the notes code seems to rely on it -- strange.

Overall this seems to be a good way to go -- after the next release.

Ren=C3=A9
