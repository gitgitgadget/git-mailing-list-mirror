Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 294E7C433B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8A3613B4
	for <git@archiver.kernel.org>; Wed,  5 May 2021 14:58:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233439AbhEEO7o (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 10:59:44 -0400
Received: from mout.gmx.net ([212.227.15.18]:59377 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233394AbhEEO7o (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 10:59:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1620226720;
        bh=t7RefJ48iDijBdSO+xXV7RjAL0SMXbCF2Bq8Gtuj/Cs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DvJU3n8+Kd7V0a5/9I3Lr2XEn95uOAbW0xU3ol0U91L0yTOPL3eJIk0U+clY/sivU
         S0eukRinHUZDGjPN220OK1F675JX41DKKY7lPbUlFMvI0FqTlfYeVjwtGdgJQZbRc+
         X9sq3P1QQYQ1LM+OHbL2lEkNYyVqXoxYSySctr4M=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.146.104] ([89.1.212.20]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnaoZ-1lF7Ab2CQv-00jZpR; Wed, 05
 May 2021 16:58:40 +0200
Date:   Wed, 5 May 2021 16:58:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 1/2] patience diff: remove unnecessary string
 comparisons
In-Reply-To: <xmqqpmy658e1.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2105051649280.50@tvgsbejvaqbjf.bet>
References: <pull.948.git.1620120345.gitgitgadget@gmail.com> <a339d1cf9b9ffd6365fca3efda8fb7e10346dda4.1620120345.git.gitgitgadget@gmail.com> <xmqqpmy658e1.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IETGERP9rJutnmYe8sh7YvpU7/DZ/Q1emgKvjVUVcHUoC5pjdKe
 fimLssv2kVeG8Qm77Injkrtk0dYRMy1Cui4y1NMyu/cv6l7WXTPzOAcXsZeG3e9n9wR9FKK
 a0p+z/1iASdN6qOT/2C+c2UbKKMEvZ65CG4RQpZbCpWJcUEf6csI2b0Qhx/OSdIjvrHHut+
 +de0g+QggGFsu6ma6Ca9g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bXrGw7u0P1M=:Un386hRhZBZzW5hKkAMaRu
 2H74I5/5sDjxHKg73W0HXtDItong0VTJ5dh6PsVEuJ9PcXokR95Abj24NTu4PGY4pOqveksiX
 y7t2fDLnu6Y5GNjmf88IERzMl1jOFyTy7PMSpWye6YxX2cm9X8Uoir9IuUXVvMh/0Ao/dJudY
 36eNS1ZVf2cJaf34cNNWBtakyZwAX6DAYFfA2sCVw2Z10rpEalOxWo8qAaaCEq/SCAt0o7jwh
 ngFtyrOYQRBQr88qOWribC+UyOpjWvflBWSTLdZErgahpEGhFEO+1nD9WW8HSyawtu6qkN9kY
 OvCNKvIfvojMQ6PpjJe+GiofaGnAwnaGN3ZXXxphW5b4Q7bXkv9w2x7AL4tNHw/48NRd7i1GR
 y3O233HijWSVMHCOVMETlUOBTLrIw49x9edv6baXjmfMS45+WFM3/yezbS9FiVgUqoklAKeK4
 GujncJF48/oe/3QQKUilZq4nhnZTuku33uJNw4K7/iPX8FSAExH3eNuWPhMVTD2o9CIvKfQu/
 ZPw39+/kfTjxaRZm84MX4xWZwBEA+mvYxMEl/i7bjKrqlcBuHQoo3TOVNNUTVv+TwnTfarwgQ
 /t6gmN2AVwGw9u1f4Y0/Ci3A/2TlGd0H5PH9JYX4O7y7Ku3FdjgahoVFwJc6AK1daIYmid83I
 WPSM9mIN/pY40Hu6syqAJREtAhZUvOrIi+Mc9WW4C7hnter2wgQ32wfkbpG+fHNqqiZj4y+6w
 u6wsJ+bSv1NCeLife7yjOt0bVf6KK9Rp+l0ZALK3/527OKf2S7y+ts6mBAF+teP1lWdHteHaD
 YoXzpI63sTSm5PFyBuRa0qSrxWK75caGVHnvGnqfZiQriUmSiIXsljVeXA8Pj5XBh3tYow9Qd
 06sOh8MYv04Mkle+iGNdZbz01HQ1qAVMxN5rbw1xMxpMXbQ5WZH8mN6L2CaDlrrWmoOG8HJdY
 2KFXMg6UTjMZSfl/e9kCrdBnZkjCe6R5whXLcVEPkoeMcNSA2c66VWfKFUpmVJ6PrCF8Dbv6s
 6d0VaKRe14e86xkt6u/CxnD+IA4xJMVKQ+XPoEKBhy04UVcXY6s3511NcoAaG0QxkU1mqPj5c
 vTPNT8OSjsWfch4tzl25drIviOq+HqpRsXN7aLAL5IlRi13TrU9zsV0AGPYZrC0lI5xmzSLzn
 L509SMJzZAXL9qbVtOcNeZUCbTzccwJujmxm97l0cuKmC4pCmzmXEf4+3MWya6oYpQKr50ndU
 eIxkhpT/Y9vcIZP4f
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, 5 May 2021, Junio C Hamano wrote:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: Phillip Wood <phillip.wood@dunelm.org.uk>
> >
> > xdl_prepare_env() calls xdl_classify_record() which arranges for the
> > hashes of non-matching lines to be different so lines can be tested
> > for equality by comparing just their hashes.
>
> Hmph, that is a bit different from what I read from the comment in
> the post context of the first hunk, though.
>
> 	/*
> 	 * After xdl_prepare_env() (or more precisely, due to
> 	 * xdl_classify_record()), the "ha" member of the records (AKA lines)
> 	 * is _not_ the hash anymore, but a linearized version of it.  In
> 	 * other words, the "ha" member is guaranteed to start with 0 and
> 	 * the second record's ha can only be 0 or 1, etc.
> 	 *
> 	 * So we multiply ha by 2 in the hope that the hashing was
> 	 * "unique enough".
> 	 */
>
> The words "home" and "enough" hints to me that the "ha" member is
> not hash, but "lineralized version of it" (whatever it means) does
> not guarantee that two records with the same "ha" are identical, or
> does it?
>
> Well, I should just go read xdl_classify_record() to see what it
> really does, but if it eliminates collisions, then the patch is a
> clear and obvious improvement.

Right. I had the same concern. But it does look as if
`xdl_classify_record()` replaced the possibly non-unique hash values to
unique sequential identifiers.

I have to admit that the code is unnecessarily hard to read for me:
https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L110-L157

But I do gather that the loop at
https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L119-L123
is called for every line, that it does compare it to every seen line with
the same hash, and that it exits the loop early if the contents disagree:

	for (rcrec =3D cf->rchash[hi]; rcrec; rcrec =3D rcrec->next)
		if (rcrec->ha =3D=3D rec->ha &&
				xdl_recmatch(rcrec->line, rcrec->size,
					rec->ptr, rec->size, cf->flags))
			break;

Since naming is hard (and you can easily err on saving space at the
expense of costing readers' time, as libxdiff proves), and since I am
running out of review time, I'll have to assume that
https://github.com/git/git/blob/v2.31.1/xdiff/xprepare.c#L150-L154 means
that indeed, the `ha` field is set to a counter that uniquely identifies
the line contents:

	rec->ha =3D (unsigned long) rcrec->idx;


	hi =3D (long) XDL_HASHLONG(rec->ha, hbits);
	rec->next =3D rhash[hi];
	rhash[hi] =3D rec;

So I am fairly confident that the patch is good, and the performance win
is nice.

Thanks!
Dscho

>
> Thanks.
>
> > diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> > index 20699a6f6054..db2d53e89cb0 100644
> > --- a/xdiff/xpatience.c
> > +++ b/xdiff/xpatience.c
> > @@ -90,7 +90,7 @@ static void insert_record(xpparam_t const *xpp, int =
line, struct hashmap *map,
> >  {
> >  	xrecord_t **records =3D pass =3D=3D 1 ?
> >  		map->env->xdf1.recs : map->env->xdf2.recs;
> > -	xrecord_t *record =3D records[line - 1], *other;
> > +	xrecord_t *record =3D records[line - 1];
> >  	/*
> >  	 * After xdl_prepare_env() (or more precisely, due to
> >  	 * xdl_classify_record()), the "ha" member of the records (AKA lines=
)
> > @@ -104,11 +104,7 @@ static void insert_record(xpparam_t const *xpp, i=
nt line, struct hashmap *map,
> >  	int index =3D (int)((record->ha << 1) % map->alloc);
> >
> >  	while (map->entries[index].line1) {
> > -		other =3D map->env->xdf1.recs[map->entries[index].line1 - 1];
> > -		if (map->entries[index].hash !=3D record->ha ||
> > -				!xdl_recmatch(record->ptr, record->size,
> > -					other->ptr, other->size,
> > -					map->xpp->flags)) {
> > +		if (map->entries[index].hash !=3D record->ha) {
> >  			if (++index >=3D map->alloc)
> >  				index =3D 0;
> >  			continue;
> > @@ -253,8 +249,7 @@ static int match(struct hashmap *map, int line1, i=
nt line2)
> >  {
> >  	xrecord_t *record1 =3D map->env->xdf1.recs[line1 - 1];
> >  	xrecord_t *record2 =3D map->env->xdf2.recs[line2 - 1];
> > -	return xdl_recmatch(record1->ptr, record1->size,
> > -		record2->ptr, record2->size, map->xpp->flags);
> > +	return record1->ha =3D=3D record2->ha;
> >  }
> >
> >  static int patience_diff(mmfile_t *file1, mmfile_t *file2,
>
