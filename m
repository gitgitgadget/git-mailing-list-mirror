Return-Path: <SRS0=DhGT=5Q=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38A9EC43331
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1AE0212CC
	for <git@archiver.kernel.org>; Tue, 31 Mar 2020 19:15:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="gBklLRLW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727627AbgCaTPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:15:04 -0400
Received: from mout.web.de ([212.227.15.3]:41279 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726295AbgCaTPD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Mar 2020 15:15:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1585682101;
        bh=7Yc1ymXNf+vLU6f1HxnCDhLchvTaaP/egNyOvIbiIzc=;
        h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
        b=gBklLRLWMPR5CGob+2bt8jisoPWWPWd/gbeYGh5LobhnN5LITk08btp7SKJ624K+p
         5mhsLsDbcanHwe7hOa1y0Nr7/D7QHT1prLvXkPr+YAWuHVWrGrnreh6uKp//0DYyRf
         HAM3ZJDk+gNkDD0EEPRDNjvQZopEjAKLtQwtolHY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MJlGW-1jKSHJ0Pq8-00195S; Tue, 31
 Mar 2020 21:15:01 +0200
Subject: Re: fast-import's hash table is slow
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20200331094553.GB7274@coredump.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <fcf422e4-08f6-634a-39ba-18d40d1c25ca@web.de>
Date:   Tue, 31 Mar 2020 21:14:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200331094553.GB7274@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:SVYv0r9OZihmVg/M3HWvzcgEsHz0m4DkB1KO+R4QkR+ln4N1lwb
 n/Z1qBEQyogNnu50mvnSDk10dvschTeE6jkPpSJOw9PZnDEHXgjZDwHViua6QZhimzVrSQL
 ZMYkl0/7boJHYsqogumhK5lSkxhvZmybStib9X4xZH+zzJle3d8XaI562gn/YvB2BeNkl89
 jDzLZ5bhOQmaDGkyGpLCQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SqU3WTQL3Js=:Umr/i6Pq5TT++DUfG4kRM8
 AuF1rDlTQr65kzy3P4xl48s5wtj6sUq7qPetxaHYKl9k0Ticpuv/XjQyMn24kybGgE9p0TN/b
 u7su0AW0LnqJiKwR/AjUceIVCVsMnkyoKhe+Qo87j847++ONZ/n+UiGa7hmFllsrJ43Ce9qiS
 RpkflTP03HQWSq7jY0ZDfHITJPJK8XUxv1Ey6kyYbgzCdeD/ic5vF6sMrCf4W6ZaT5qWR5rsO
 vzekdpvZxxZP9myV6VaNv/I2T+W7liRNJvJ1tdNa8eEFDt8AcpkZjaPGbYWCXPsXvuVJt1P2g
 hQdxjBz7134tkTMZ/ck1jn/i57pyfM2xrAcCeFmYWev4uwDaefRxQ1fpzCB76SBNGQjHSH9P0
 Buf2x8O/7VQlYzKxHHjQYHZbR050ohyZfH6hGyykx5M4ucNR2xdMJ2IOzrrY22wDrtCV6GS2t
 OoSzryF1wV/u3zFjXb6u75Lpc+ID+j9EujHXLjL858cJVg0rbyxoqx2OusyNBsAg9iAWqQnHW
 EOsE/YeajlnVBBhywSFPohgZsjuUrf75FNCjo/Ye8XX3vI8xjzKuwDrS6kNx6BtfA3GBvRdTy
 q66lENnexWyz6EMRs+maqQdpeDPot0jgygkPJVGXwWJQjks2VAj1NToQ+CFHkuc46+dYmi87L
 heh40fyB0whRBO8TyijwNRrhp6cCFEtLbmKR+jHJkgnv+k9gjqLzzGFhf/oLHuIdSOBXzYt+q
 Xu55bqjCSkotgjFqVEX8FuvZINQlhzsw/YukEUrlV7KpdT3PX9+YgwEpyMUJ6yd3kRCfFY1gx
 ybMUaF1GgFFUz/2uWwPYxtfpDs9jsAqHlVe07tiKQoTcB7BvBbzzRpnvM3aui7pKEuH89xhoB
 FU25D8nYjFUDB59fM6ZSl0iN7etri7xoGg95EgXqB94NbuCVKUg/l7f5JNvOo0d6p1nzj1Oeq
 mte8puX5TDGlDrGfEHPGig89A5Eeg3zATAbyvtoxFsDWpnLy4ss8xJ8Ipm5xPRM4p7k0dE1e1
 F86QzIkVZ4e42fHyyjs2PYqNvJuDOHpRMsBydjMebGz1Nrf1tgsFESn800cQtl3zhfRDNpcAW
 zD391d52fDpzknmgOD8kmgOLb23TjIKe3shCehey6CutViyZ2Rn1V9zazVf/jMet7mTCym4hu
 8eUODMJyraAut95XUnEubE7elCc32mS1L59LcER7U/QUdsxZz7DZ+mv1rRHdoUvxIVxZs8ntH
 FU7M6l/UFjOiXeMjK
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 31.03.20 um 11:45 schrieb Jeff King:
> [breaking thread, since this is really an independent topic]
>
> On Mon, Mar 30, 2020 at 10:09:30AM -0400, Jeff King wrote:
>
>> So I arrived at this fast-import solution, which was...not super fast.
>> Profiling showed that we were spending 80% of the time inserting into
>> our custom hashtable, which is fixed at 2^16 entries and then chains
>> beyond that. Swapping it out for a khash proved much faster, but I'm no=
t
>> sure if the memory games are too gross (see the comment in find_object
>> below).
>>
>> I also didn't look into whether we could get rid of the extra allocatin=
g
>> pool (and store the structs right in the hash), or if it's necessary fo=
r
>> their pointers to be stable.
>
> I briefly tried to get rid of the pool. I _think_ it should be possible,
> but I did see some test failures. It's entirely possible I screwed it
> up. However, I did generate a few interesting measurements showing how
> the current hash table behaves on this test:
>
>   git init repo
>   cd repo
>   perl -e '
>       my $bits =3D shift;
>       my $nr =3D 2**$bits;
>
>       for (my $i =3D 0; $i < $nr; $i++) {
>               print "blob\n";
>               print "data 4\n";
>               print pack("N", $i);
>       }
>   ' "$@" | git fast-import
>
> Here are wall-clock timings for the current tip of master, versus with
> the patch below applied:
>
> nr_objects   master       patch
> 2^20         0m04.317s    0m5.109s
> 2^21         0m10.204s    0m9.702s
> 2^22         0m27.159s    0m17.911s
> 2^23         1m19.038s    0m35.080s
> 2^24         4m18.766s    1m10.233s

I get similar numbers.

Pre-sizing by putting this near the top of cmd_main() gets the time
for 1M down to 4 seconds:

	kh_resize_object_entry_set(&object_table, 1 << 18);

The more fair 1 << 16 does not cut it, the totally unfair 1 << 20 gives
a small extra boost.

>
> The curve on master is quadratic-ish (each line has double the number of
> objects of the previous one; the times don't multiply by 4, but that's
> because the hash table is only part of the work we're doing). With my
> patch, it's pretty linear.
>
> But I'm still disappointed that the smallest case is actually _slower_
> with the patch. The existing hash table is so simple I can imagine using
> khash has a little overhead. But I'm surprised it would be so much (or
> that the existing hash table does OK at 2^20; it only has 2^16 buckets).
>
> Maybe this email will nerd-snipe Ren=C3=A9 into poking at it.
>
> The patch I tested is below (it's slightly different than what I showed
> before, in that it handles duplicate insertions). Maybe using hashmap.c
> would be better?
>
> ---
> diff --git a/fast-import.c b/fast-import.c
> index 202dda11a6..6ebac665a0 100644
> --- a/fast-import.c
> +++ b/fast-import.c
> @@ -39,12 +39,25 @@
>
>  struct object_entry {
>  	struct pack_idx_entry idx;
> -	struct object_entry *next;
>  	uint32_t type : TYPE_BITS,
>  		pack_id : PACK_ID_BITS,
>  		depth : DEPTH_BITS;
>  };
>
> +static inline unsigned int object_entry_hash(struct object_entry *oe)
> +{
> +	return oidhash(&oe->idx.oid);
> +}
> +
> +static inline int object_entry_equal(struct object_entry *a,
> +				     struct object_entry *b)
> +{
> +	return oideq(&a->idx.oid, &b->idx.oid);
> +}
> +
> +KHASH_INIT(object_entry_set, struct object_entry *, int, 0,
> +	   object_entry_hash, object_entry_equal);
> +
>  struct object_entry_pool {
>  	struct object_entry_pool *next_pool;
>  	struct object_entry *next_free;
> @@ -178,7 +191,7 @@ static off_t pack_size;
>  /* Table of objects we've written. */
>  static unsigned int object_entry_alloc =3D 5000;
>  static struct object_entry_pool *blocks;
> -static struct object_entry *object_table[1 << 16];
> +static kh_object_entry_set_t object_table;
>  static struct mark_set *marks;
>  static const char *export_marks_file;
>  static const char *import_marks_file;
> @@ -455,44 +468,45 @@ static struct object_entry *new_object(struct obje=
ct_id *oid)
>
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
> +					       (struct object_entry *)oid);

Dirty, but I can believe the comment.


> +	if (pos !=3D kh_end(&object_table))
> +		return kh_key(&object_table, pos);
>  	return NULL;
>  }
>
>  static struct object_entry *insert_object(struct object_id *oid)
>  {
> -	unsigned int h =3D oid->hash[0] << 8 | oid->hash[1];
> -	struct object_entry *e =3D object_table[h];
> +	struct object_entry *e;
> +	int was_empty;
> +	khiter_t pos;
>
> -	while (e) {
> -		if (oideq(oid, &e->idx.oid))
> -			return e;
> -		e =3D e->next;
> -	}
> +	pos =3D kh_put_object_entry_set(&object_table, (struct object_entry *)=
oid, &was_empty);

Now this looks illegal.  khash is surely reading a full object_entry from =
oid,
which only is a mere object_id, no?

> +	if (!was_empty)
> +		return kh_key(&object_table, pos);
>
>  	e =3D new_object(oid);
> -	e->next =3D object_table[h];
>  	e->idx.offset =3D 0;
> -	object_table[h] =3D e;
> +	kh_key(&object_table, pos) =3D e;
>  	return e;
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
> +			struct object_entry *e =3D kh_key(&object_table, iter);
>  			if (e->pack_id =3D=3D id)
>  				e->pack_id =3D MAX_PACK_ID;
> +		}
>  	}

Is this really the best way to handle that, independently of the hashmap
that's used?  I wonder how an extra hashmap or set of valid pack_id
values (or set of invalidated pack_id values?) would fare against having
to touch all object entries here.

>
>  	for (lu =3D 0; lu < branch_table_sz; lu++) {
>

