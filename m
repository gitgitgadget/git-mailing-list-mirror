Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0633C4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A07BA60FE7
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 17:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242059AbhHFRyh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 13:54:37 -0400
Received: from mout.web.de ([212.227.15.4]:47597 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231718AbhHFRyh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 13:54:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1628272429;
        bh=kS9JnBmMUCzsYKUy87rvVsTya6GD87W7LxVZk1MXBf4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=Fzfuw7pJfULEMCn571zZtfzcigNNXwBTnBlhjg3u1wsAYSZ6qyYi+Xz48UQ0+p3U7
         QDTqnrNI3FkurGtmJVZpgBQZ30cAQuHtM0f1xU2YKuhw8EvaXcIzfwRtjIWz/cVbcf
         FcZa1AKrLnkRp2J4JXguJDtIgdASkQqey0CzVaZg=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([91.47.159.106]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1M4bUg-1mBVXf0LJO-001jRQ; Fri, 06 Aug 2021 19:53:49 +0200
Subject: Re: [PATCH v2 5/5] oidtree: a crit-bit tree for odb_loose_cache
To:     Andrzej Hunt <andrzej@ahunt.org>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
References: <20210627024718.25383-1-e@80x24.org>
 <20210629205305.7100-6-e@80x24.org>
 <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bab9f889-ee2e-d3c3-0319-e297b59261a0@web.de>
Date:   Fri, 6 Aug 2021 19:53:47 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <3cbec773-cd99-cf9f-a713-45ef8e6746c3@ahunt.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Q2L+y5fpH9+lReBZn+XboOZkxKtzd0qnfWlctRBC2UP5FxwmRba
 X+fSpGX5hro0UZ5GO2FmsnQcXrjZA4GYbik4QWa9Q8KkqwFrYQ3SEefk1mT0j5Pnoqv+1Cn
 pp7QNuXFISRDOUaR/ncQqYsBQwIX2ppxPB+iBybyQjqVdWzra9iowxv+tPSMsrQVV7Msch9
 uIX0Kt3pYJ83p/NHYIrSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P+UcrxtCoY0=:TUxwpfpJPjC+aIbGb8Y74R
 btHJASkByPos71rTIThWJzJAMjM58YGKU7kf39oIr2TiSm69dhbpa9JVM9DNcBd5d6xh6ydTD
 m3PqAQNolxk/SBlkPbx4JTeX0I8bQ6FisFqCTrjw9u3Hn9lm4YqLR7tPDA+gZGkhIkK2eoHIf
 2MVp54d+jpq7MNqJj6tL+vPfFeGSJls3zW5qtvJjUdl/b/M2MfLFbxPF9jqJlj1GtauRYrEpX
 nmCGNbhqgGC7SoGWnPBFwzJCtvd/r0ByeVkTadxQlLCiOIyFVQgf5fnjKhs8IH1BKSJT7bYrk
 MydnRTxVB1Soigy+KtnboKikboRsMXOChN9YeIQGdGm143zYE1YaLA5C4eYGy/LRkmsCyLjzL
 1CJxi3l8VddEXgQbnzEdO51czHZGda/7zhHntGkV7cgCoVG17/n4YvSHZWIthB7851PGJgP8w
 sfuN/EyYipgFDYBfHgK8BF2huRTeKQIp2uyTJ/WrjFT4xpQFlBNGfxXSCbqyH7N87J1z6Rxz/
 GQ5j2STw3LvPsI9yrdsogx9rPCxmNKpttoqZ+50/+Yx33PK9b6hruu8O1/HQI0bIPoQIYF6wA
 cTKCxDzAbYpPvWJZMSy953oDeULVmVVtrNV9kBABJRdukAYbvyFOlBV6AathJAwscORL+NDF0
 uzwy1u6ZpMMgin3odP31jbYNQm7N5SelypHKjixHEs4wORnjASh6ov2wJMF79aOX5mKp2k9TX
 zr1ARmbFicIZbBbcIFqx4HgnGQTf4aZabmsqJT1RWdnTtbfFXkvYd78MCiOcz6GwS3FuT75rg
 h3Zii4+3mlCcJh24q9iUaIQviE7v8nMcDlxOS4zDhrUnZkfF593lH2Xr52glFoA1mtcifkEwT
 +2ipS6JE3RcH/qRbE1xV0m8FdA0Ml5qQpW3Sl4HRsVgsmnW70TySOCdMP2YMhJKvN5ur0cFQo
 1xP868Z/AIWJBukcsB8DWD6kq8t5IkLLU6WAe7NX72a4kJqDAFx7k6G80pk3Sc9i8Cvs+FK/m
 KLkx8Qr+VMFIGwS7sb0Hd+C+1oIVPXqNVXLnHpaPzWSOa2jaSQmzA6I3u7570SkI++9Z+A6QM
 otuRKrB9BnwuHrNH5Y43lnHNGmRVtkSmjz9
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.08.21 um 17:31 schrieb Andrzej Hunt:
>
>
> On 29/06/2021 22:53, Eric Wong wrote:
>> [...snip...]
>> diff --git a/oidtree.c b/oidtree.c
>> new file mode 100644
>> index 0000000000..c1188d8f48
>> --- /dev/null
>> +++ b/oidtree.c
>> @@ -0,0 +1,94 @@
>> +/*
>> + * A wrapper around cbtree which stores oids
>> + * May be used to replace oid-array for prefix (abbreviation) matches
>> + */
>> +#include "oidtree.h"
>> +#include "alloc.h"
>> +#include "hash.h"
>> +
>> +struct oidtree_node {
>> +=C2=A0=C2=A0=C2=A0 /* n.k[] is used to store "struct object_id" */
>> +=C2=A0=C2=A0=C2=A0 struct cb_node n;
>> +};
>> +
>> [... snip ...]
>> +
>> +void oidtree_insert(struct oidtree *ot, const struct object_id *oid)
>> +{
>> +=C2=A0=C2=A0=C2=A0 struct oidtree_node *on;
>> +
>> +=C2=A0=C2=A0=C2=A0 if (!ot->mempool)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ot->mempool =3D allocate_al=
loc_state();
>> +=C2=A0=C2=A0=C2=A0 if (!oid->algo)
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 BUG("oidtree_insert require=
s oid->algo");
>> +
>> +=C2=A0=C2=A0=C2=A0 on =3D alloc_from_state(ot->mempool, sizeof(*on) + =
sizeof(*oid));
>> +=C2=A0=C2=A0=C2=A0 oidcpy_with_padding((struct object_id *)on->n.k, oi=
d);
>
> I think this object_id cast introduced undefined behaviour - here's
> my layperson's interepretation of what's going on (full UBSAN output
> is pasted below):
>
> cb_node.k is a uint8_t[], and hence can be 1-byte aligned (on my
> machine: offsetof(struct cb_node, k) =3D=3D 21). We're casting its
> pointer to "struct object_id *", and later try to access
> object_id.hash within oidcpy_with_padding. My compiler assumes that
> an object_id pointer needs to be 4-byte aligned, and reading from a
> misaligned pointer means we hit undefined behaviour. (I think the
> 4-byte alignment requirement comes from the fact that object_id's
> largest member is an int?)
>
> I'm not sure what an elegant and idiomatic fix might be - IIUC it's
> hard to guarantee misaligned access can't happen with a flex array
> that's being used for arbitrary data (you would presumably have to
> declare it as an array of whatever the largest supported type is, so
> that you can guarantee correct alignment even when cbtree is used
> with that type) - which might imply that k needs to be declared as a
> void pointer? That in turn would make cbtree.c harder to read.

C11 has alignas.  We could also make the member before the flex array,
otherbits, wider, e.g. promote it to uint32_t.

A more parsimonious solution would be to turn the int member of struct
object_id, algo, into an unsigned char for now and reconsider the issue
once we support our 200th algorithm or so.  This breaks notes, though.
Its GET_PTR_TYPE seems to require struct leaf_node to have 4-byte
alignment for some reason.  That can be ensured by adding an int member.

Anyway, with either of these fixes UBSan is still unhappy about a
different issue.  Here's a patch for that:

=2D-- >8 ---
Subject: [PATCH] object-file: use unsigned arithmetic with bit mask

33f379eee6 (make object_directory.loose_objects_subdir_seen a bitmap,
2021-07-07) replaced a wasteful 256-byte array with a 32-byte array
and bit operations.  The mask calculation shifts a literal 1 of type
int left by anything between 0 and 31.  UndefinedBehaviorSanitizer
doesn't like that and reports:

object-file.c:2477:18: runtime error: left shift of 1 by 31 places cannot =
be represented in type 'int'

Make sure to use an unsigned 1 instead to avoid the issue.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 object-file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/object-file.c b/object-file.c
index 3d27dc8dea..a8be899481 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -2474,7 +2474,7 @@ struct oidtree *odb_loose_cache(struct object_direct=
ory *odb,
 	struct strbuf buf =3D STRBUF_INIT;
 	size_t word_bits =3D bitsizeof(odb->loose_objects_subdir_seen[0]);
 	size_t word_index =3D subdir_nr / word_bits;
-	size_t mask =3D 1 << (subdir_nr % word_bits);
+	size_t mask =3D 1u << (subdir_nr % word_bits);
 	uint32_t *bitmap;

 	if (subdir_nr < 0 ||
=2D-
2.32.0
