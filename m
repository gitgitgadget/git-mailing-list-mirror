Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84A3C2BA18
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B87402077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 18:41:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="a+kNNRG0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388902AbgDBSlD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 14:41:03 -0400
Received: from mout.web.de ([212.227.17.12]:59283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbgDBSlD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 14:41:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585852859;
        bh=C2qaw1ed1x1azrtDPMa/nVUiFOaLR/ARqHXdbzhivK0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=a+kNNRG0M0O1eNWSQ3KJ4CbWVQelus46EVF9NaAAlYJTEefkSrRzBUqWI0Rs+s7C9
         yBY2uiJQiiYohgFr6+40vzN1x6Yts6NHRGRirMTkQrmB29f+56A9nSWoNXfKzntYDM
         vVwQpHh+9BBiFFCauSSNgynuDCyEr1ambmNqoUME=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LZeVM-1iutQE3nCO-00lSvP; Thu, 02
 Apr 2020 20:40:58 +0200
Subject: Re: fast-import's hash table is slow
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20200331094553.GB7274@coredump.intra.peff.net>
 <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
 <c0398484-15f4-e5c2-d229-82037094417c@web.de>
 <20200401102435.GD60227@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <31a0efbe-8ab0-045a-fcab-3211c0d641f6@web.de>
Date:   Thu, 2 Apr 2020 20:40:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200401102435.GD60227@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fMk6rf4D6uuAn4iGDK6JLWFcJQqTXBBmZv+5YFs9qPfM3VQZsKd
 SfbRQVOYqv8YaOCUJujgOO+e5ElgXV39aYifBMjn2hy400gefZS4tV/7T1bcLjI4idSPeyI
 dDOGosr/tVtKbwRlqjDc5YOHW9PFJKAJsVsXTtZ2oTmCjbPsYJGPQ7w+HivLYWZF10JqHtm
 nlJeSRowd/Z5le9RoxY+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:D2zL2pYFCsY=:s7Gut/UodjL1pm5GeVWSu5
 b2jMSKOY6vdH3PE2wOtfcSHDMPSvOmNccBhAD6Y11EDLNFR1qZqAeqTlaGf1zR/uNU2zKSihW
 eACaqlVLDvxTHvY/+p4iMGT/0BYUIQRpc5nIg9SzGDCvtqQWEGXz78nihJYcZu4EcXnTQ/AV1
 uFbG+4ynC/Z+W5KlQYT+zznmo2QdTAEo5YLbJBqqgllWXuhaEBAW2xzLFGQStt8xblC/V9+O3
 JtrnVLJQsdxaBnfUkM2eepHCNKGr/s2C6qVnvc9Ov1zV7LJXmrm2T427/N2iZJGT1gDBWhku5
 56w1lsdyHE/IZjTVfOjyUMsio/2ZaNobTboKjVqr3ZRib58fae16Ln1e3In0XUPaVO1Y7xsWf
 NLnuyCtZu8Y12kiZB0ELqapbMjeZSsN4MpxrCkITzqQPJOphZ01ybSbFmnDGa4gogw4nkIGxP
 CJwfmnw8LtV62sk4qnjczx6f0rzndVTTCtooNlFvFEkwo14oBFKih1+cq3pkxsVFbhRuvgJLZ
 NcqaSMl8GXaIK7DJ0vZLBXCjF7f95luBAAUEvnX4ppFURbKW9hAWdBooWXzFYWKIBD6DunScy
 Eh7t6V5HTJJ+JtTOr5NQ+n2LssRYyTH0DywXtsIOOzi1/WRfSedYfA82ghAdel/h3/mkAePW1
 9JUWLsuyMh3pfD8bbypX0C0VdkluAmjdGJckBn5UWXgTZpxwSSSHbqiwUfNWKcXVIypstT+y/
 o45uygKAUXIADuKq3ocwgXIQ/TVI3lJ/q36Ll9mUK5qOdQHH/jNbIUvcungjM2jDtX+2Tqj0w
 ZTZZX38Utuero/qeWXmS7C6KOVGf2P3D5BgTn3y7jV0Em9cdDn+pU+X/NIHcL8QH2Pd5Pwx4n
 H8d80ATAZqZECrvYhoRs7AofCxZgeiGUrFb9A3qhx5rRWTm3EDOGpfH4HF6V4aUs1e2ZzKw6Q
 NKA+xqekF8m4ifFoGIBkeXZ1/3Qv1YIAITHSfOKUbAVhtrXWdsUhN6ESTlYU3/BxutqWNz8B7
 zyQgpWF1VriyhS7yABqKLHp0iVVIrxw9Vxmirc0vN4/2KgFjQKxGxQ37Pn5mDo+PJme/vwUtv
 hvARxi2n9eY37eyHkiYfMaIVLZARWrpifGznc3pDTpTQnHkVrMAeq5TcV787xf7lIrzsJrHoY
 mfNKDXSLpmcTS3UTqn3F9zbZxFmly5Hgqf1SCC0QdQ8vjhPXdqGNLMCVe80Hesqs92dv+W321
 lk4W+NNIEGKYkivs2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.04.20 um 12:24 schrieb Jeff King:
> On Wed, Apr 01, 2020 at 01:21:08AM +0200, Ren=C3=A9 Scharfe wrote:
>
>>>> +	pos =3D kh_put_object_entry_set(&object_table, (struct object_entry=
 *)oid, &was_empty);
>>>
>>> Now this looks illegal.  khash is surely reading a full object_entry f=
rom oid,
>>> which only is a mere object_id, no?
>>
>> No, it's a set of pointers, and khash only accesses the referenced obje=
cts
>> via the hash and comparison functions.
>>
>> Storing the objects directly in the set and getting rid of new_object()
>> could improve performance due to reduced dereferencing overhead -- or
>> make it slower because more data has to be copied when the hashmap need=
s
>> to grow.  Worth a shot.  Later.
>
> Yeah. I tried that, too, but it caused tons of test failures. Quite
> possibly just a bug in my patch, which I did as quickly as possible. But
> I think it performed about the same. Here it is for reference (though
> you may be better off to start from scratch).

Tried that earlier, ran into failures as well.  I think the pointer
returned from insert_object() is stored somewhere and still used after
the next call, which could have invalidated it by a rehash.  E.g.
insert_mark() seems to do that.

> Note the "this is OK to cast from oid to object_entry" comment is
> leftover from the earlier attempt, but it probably _isn't_ OK. Even
> though we don't do anything actionable on the non-oid bytes, they do get
> passed by value, which could mean reading random bytes.

"Value" meaning pointer value when KHASH_INIT is give a pointer type,
as was the case in the patch with that comment (unlike in the patch
below).  So it should be OK there.

>
> ---
> diff --git a/fast-import.c b/fast-import.c
> index 202dda11a6..5a1b451971 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -39,18 +39,24 @@
>
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	struct object_entry *next;
>  	uint32_t type : TYPE_BITS,
>  		pack_id : PACK_ID_BITS,
>  		depth : DEPTH_BITS;
>  };
>
> -struct object_entry_pool {
> -	struct object_entry_pool *next_pool;
> -	struct object_entry *next_free;
> -	struct object_entry *end;
> -	struct object_entry entries[FLEX_ARRAY]; /* more */
> -};
> +static inline unsigned int object_entry_hash(struct object_entry oe)
> +{
> +	return oidhash(&oe.idx.oid);
> +}
> +
> +static inline int object_entry_equal(struct object_entry a,
> +				     struct object_entry b)
> +{
> +	return oideq(&a.idx.oid, &b.idx.oid);
> +}
> +
> +KHASH_INIT(object_entry_set, struct object_entry, int, 0,
> +	   object_entry_hash, object_entry_equal);
>
>  struct mark_set {
>  	union {
> @@ -176,9 +182,7 @@ static struct packed_git **all_packs;
>  static off_t pack_size;
>
>  /* Table of objects we've written. */
> -static unsigned int object_entry_alloc =3D 5000;
> -static struct object_entry_pool *blocks;
> -static struct object_entry *object_table[1 << 16];
> +static kh_object_entry_set_t object_table;
>  static struct mark_set *marks;
>  static const char *export_marks_file;
>  static const char *import_marks_file;
> @@ -428,71 +432,44 @@ static void set_checkpoint_signal(void)
>
>  #endif
>
> -static void alloc_objects(unsigned int cnt)
> -{
> -	struct object_entry_pool *b;
> -
> -	b =3D xmalloc(sizeof(struct object_entry_pool)
> -		+ cnt * sizeof(struct object_entry));
> -	b->next_pool =3D blocks;
> -	b->next_free =3D b->entries;
> -	b->end =3D b->entries + cnt;
> -	blocks =3D b;
> -	alloc_count +=3D cnt;
> -}
> -
> -static struct object_entry *new_object(struct object_id *oid)
> -{
> -	struct object_entry *e;
> -
> -	if (blocks->next_free =3D=3D blocks->end)
> -		alloc_objects(object_entry_alloc);
> -
> -	e =3D blocks->next_free++;
> -	oidcpy(&e->idx.oid, oid);
> -	return e;
> -}
> -
>  static struct object_entry *find_object(struct object_id *oid)
>  {
> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
> -	struct object_entry *e;
> -	for (e =3D object_table[h]; e; e =3D e->next)
> -		if (oideq(oid, &e->idx.oid))
> -			return e;
> +	/*
> +	 * this cast works because we only look at the oid part of the entry,
> +	 * and it comes first in the struct
> +	 */
> +	khiter_t pos =3D kh_get_object_entry_set(&object_table,
> +					       *(struct object_entry *)oid);

Yeah, this one here is not OK.  We'd need to build a dummy entry.

> +	if (pos !=3D kh_end(&object_table))
> +		return &kh_key(&object_table, pos);
>  	return NULL;
>  }
>
>  static struct object_entry *insert_object(struct object_id *oid)
>  {
> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
> -	struct object_entry *e =3D object_table[h];
> +	struct object_entry e;
> +	int was_empty;
> +	khiter_t pos;
>
> -	while (e) {
> -		if (oideq(oid, &e->idx.oid))
> -			return e;
> -		e =3D e->next;
> -	}
> +	oidcpy(&e.idx.oid, oid);
> +	e.idx.offset =3D 0;
> +	pos =3D kh_put_object_entry_set(&object_table, e, &was_empty);
>
> -	e =3D new_object(oid);
> -	e->next =3D object_table[h];
> -	e->idx.offset =3D 0;
> -	object_table[h] =3D e;
> -	return e;
> +	return &kh_key(&object_table, pos);
>  }
>
>  static void invalidate_pack_id(unsigned int id)
>  {
> -	unsigned int h;
>  	unsigned long lu;
>  	struct tag *t;
> +	khiter_t iter;
>
> -	for (h =3D 0; h < ARRAY_SIZE(object_table); h++) {
> -		struct object_entry *e;
> -
> -		for (e =3D object_table[h]; e; e =3D e->next)
> +	for (iter =3D kh_begin(&object_table); iter !=3D kh_end(&object_table)=
; iter++) {
> +		if (kh_exist(&object_table, iter)) {
> +			struct object_entry *e =3D &kh_key(&object_table, iter);
>  			if (e->pack_id =3D=3D id)
>  				e->pack_id =3D MAX_PACK_ID;
> +		}
>  	}
>
>  	for (lu =3D 0; lu < branch_table_sz; lu++) {
> @@ -766,15 +743,18 @@ static const char *create_index(void)
>  	const char *tmpfile;
>  	struct pack_idx_entry **idx, **c, **last;
>  	struct object_entry *e;
> -	struct object_entry_pool *o;
> +	khiter_t iter;
>
>  	/* Build the table of object IDs. */
>  	ALLOC_ARRAY(idx, object_count);
>  	c =3D idx;
> -	for (o =3D blocks; o; o =3D o->next_pool)
> -		for (e =3D o->next_free; e-- !=3D o->entries;)
> +	for (iter =3D kh_begin(&object_table); iter !=3D kh_end(&object_table)=
; iter++) {
> +		if (kh_exist(&object_table, iter)) {
> +			e =3D &kh_key(&object_table, iter);
>  			if (pack_id =3D=3D e->pack_id)
>  				*c++ =3D &e->idx;
> +		}
> +	}

The original code writes the objects in reverse order of their creation
(LIFO), right?  Is that relevant?

But anyway,  we need stable object locations anyway if their addresses are
stored in other structs, as mentioned above.  Those pointers would have to
be replaced by object_ids and pointer derefs by hashmap lookups.  Not a
promising direction.

Ren=C3=A9
