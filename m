Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECFC433EF
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 14:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238272AbhKWOy5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 09:54:57 -0500
Received: from mout.gmx.net ([212.227.17.21]:57207 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233112AbhKWOy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 09:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1637679104;
        bh=woVwendueqoMa7Ld+SblcfrvN6uFl0FQN29X/A7ZX4A=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZDMuTVGDWfA42ew62QFB9kISyIb0Yb41AO9gc8M37W6s926KdbHoYwOPQiMGfNYby
         D9SRBdFJR9DyLM8oKH9Mru7tPGexNoeB7lXa2qRJM5lSXdlUr11XZ2KQ1cJ6aG9Nzw
         URVm0JO67ehQ4tJxsU/BN1/mGiuBoFyBg4/EDOSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.219.221] ([89.1.212.219]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOzSu-1mzX3c19gK-00PJpa; Tue, 23
 Nov 2021 15:51:44 +0100
Date:   Tue, 23 Nov 2021 15:51:42 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v4 08/15] diff --color-moved-ws=allow-indentation-change:
 simplify and optimize
In-Reply-To: <d7bbc0041e076077d3c3299858799cc9907d9831.1637056179.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111231540280.63@tvgsbejvaqbjf.bet>
References: <pull.981.v3.git.1635336262.gitgitgadget@gmail.com>        <pull.981.v4.git.1637056178.gitgitgadget@gmail.com> <d7bbc0041e076077d3c3299858799cc9907d9831.1637056179.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tV0lCXpd8RXEFOJwSjuTvp9VIoCTjbSQkOt19OqKqQZp/Ea0iLd
 eYcvIIMb5lRUnc3pKjlJYKuv/oPVvoJf3xj0L45Ajohuj4pDgyjiQL4oDAKTU/xNaEE5CO6
 ty7Qd3l+Ty/VnRGEZheL3y6lLr1HgB928zawVCqr2chmeKs7gMgeLdO7BUACOytQqBtxWEw
 CZkCCDCzmzlR+sTjHEhJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XYaOaKGlEVk=:aHTPhR/OSe9HGQtxRgr0pK
 yVqpOs1nUnWRkTcF0MK9Zie19J1szYMrKdIDFv1dvbp5h+E6hiJRDzA5Hr4JG2Ru3ZJJpAoVR
 CKzortEltnxq4vxmLPe4hlggViJXaYWwtUobAvSfb95ANoyIPdk34t404C7Bw8Rwf73eOLuZG
 u37qRGlJEz1m6NB34QHW9wkdU+VbI1CSL98YqCsVLz3Re+basbH2bXnKgWQ+RTN1Kdc1TyKWW
 hqBen2KARiG7JskKe7dHkWJw++w7jo1P04EdztEGX751nmeQNbqMZcSPWYPSsJxYRgQicAiha
 UOv3gdcDNja7VvxQq4Cw3MDS7eZECxelYZrFStcWjRBRcdnVnGLWDWyuRkYqunBoGVjV8m/Bz
 jiTCt8EFQyCRuHkgeoryDlTSRpEXupDSEJwrL5IbldLc9c+3750H0wJ+Hq//9B/ddGJobcDKj
 GGJDhVDXYQ59807Raben9MpEv8tdwOpAaGoQuzocklX9rUcXAGqgxBIw3ihj5Fuv3MFRbwKWE
 FrZ+EwNtZC6m0JctLegSnr+Bk8zYCDbzAYMjEw9re30hwfvikhphSFAZLX/pAPK4PQ4v9MGah
 odebImsDbokkVPI2QNbXKA8SyXziwEPnVzMmPQfk7X0pcTzPmyfV7hqgJ5B2qu9HCf3slkb+C
 HY2cA52L8c28NPd0AgDxEtDiHW7aX4YWmFFM9YoHq0LSqTk+k940S4O0Rkkcj4zu1Z41gulwg
 dNv9EgLLHpsJW1TYul5fqP5wwg+jWPw6LIZut7Vv8Pu4sNl45fGw+0/CS5DQr578jNlj0fsiO
 VElsywUrN+1D5lO2bET5p2RDHcXC0YFMQJqG53Qz3WnfjLvVKf1gGOkSoF8/bZP8OqYYyB62/
 rc9JeFwxn3XYijSUk3f4OkIbN1HZ8O3bNuRGqxSIaxAjedH3bnewAamoIQP60//A0SWdh9IAW
 rHeNd8pSrUxKR3/QfjqGxGAnkmXLhei0xCm6Rn7W/7MI9M/gjey3r5q0e0HAXq7YGMA7jAAGF
 iA5i5lTh8w7cMDeNJg7gJm4ZFML/hi0vCGO3/MjG96LE4Ba5olW9coj7e5JYUdbeeo+6gz3LB
 KgzRyF2e9x9CrM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

tl;dr: the patch looks good to me (it is a bit tricky to review, though,
but that is not your fault, it is our code review process' fault).

On Tue, 16 Nov 2021, Phillip Wood via GitGitGadget wrote:

>   git diff --color-moved-ws=3Dallow-indentation-change v2.28.0 v2.29.0
> by 93% compared to master and simplifies the code.

Nice!

> diff --git a/diff.c b/diff.c
> index 9aff167be27..78a486021ab 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -879,37 +879,21 @@ static int compute_ws_delta(const struct emitted_d=
iff_symbol *a,
>  	return 1;
>  }
>
> -static int cmp_in_block_with_wsd(const struct diff_options *o,
> -				 const struct moved_entry *cur,
> -				 const struct moved_entry *match,
> -				 struct moved_block *pmb,
> -				 int n)
> -{
> -	struct emitted_diff_symbol *l =3D &o->emitted_symbols->buf[n];
> -	int al =3D cur->es->len, bl =3D match->es->len, cl =3D l->len;
> +static int cmp_in_block_with_wsd(const struct moved_entry *cur,
> +				 const struct emitted_diff_symbol *l,
> +				 struct moved_block *pmb)
> +{
> +	int al =3D cur->es->len, bl =3D l->len;

Once I realized that the old `b` was removed and the old `c` became the
new `b`, it was a breeze to validate this hunk.

>  	const char *a =3D cur->es->line,
> -		   *b =3D match->es->line,
> -		   *c =3D l->line;
> +		   *b =3D l->line;
>  	int a_off =3D cur->es->indent_off,
>  	    a_width =3D cur->es->indent_width,
> -	    c_off =3D l->indent_off,
> -	    c_width =3D l->indent_width;
> +	    b_off =3D l->indent_off,
> +	    b_width =3D l->indent_width;
>  	int delta;
>
> -	/*
> -	 * We need to check if 'cur' is equal to 'match'.  As those
> -	 * are from the same (+/-) side, we do not need to adjust for
> -	 * indent changes. However these were found using fuzzy
> -	 * matching so we do have to check if they are equal. Here we
> -	 * just check the lengths. We delay calling memcmp() to check
> -	 * the contents until later as if the length comparison for a
> -	 * and c fails we can avoid the call all together.
> -	 */
> -	if (al !=3D bl)
> -		return 1;

The commit message really helped understanding why this is not needed.
Thank you!

> -
>  	/* If 'l' and 'cur' are both blank then they match. */
> -	if (a_width =3D=3D INDENT_BLANKLINE && c_width =3D=3D INDENT_BLANKLINE=
)
> +	if (a_width =3D=3D INDENT_BLANKLINE && b_width =3D=3D INDENT_BLANKLINE=
)
>  		return 0;
>
>  	/*
> @@ -918,7 +902,7 @@ static int cmp_in_block_with_wsd(const struct diff_o=
ptions *o,
>  	 * match those of the current block and that the text of 'l' and 'cur'
>  	 * after the indentation match.
>  	 */
> -	delta =3D c_width - a_width;
> +	delta =3D b_width - a_width;
>
>  	/*
>  	 * If the previous lines of this block were all blank then set its
> @@ -927,9 +911,8 @@ static int cmp_in_block_with_wsd(const struct diff_o=
ptions *o,
>  	if (pmb->wsd =3D=3D INDENT_BLANKLINE)
>  		pmb->wsd =3D delta;
>
> -	return !(delta =3D=3D pmb->wsd && al - a_off =3D=3D cl - c_off &&
> -		 !memcmp(a, b, al) && !
> -		 memcmp(a + a_off, c + c_off, al - a_off));
> +	return !(delta =3D=3D pmb->wsd && al - a_off =3D=3D bl - b_off &&
> +		 !memcmp(a + a_off, b + b_off, al - a_off));
>  }

Once again, I am sad that we have no better platform to do our code
contribution and review. Whatever you can say about GitHub's UI, it is
better than static diffs in mails.

But you used GitGitGadget, and I finally broke down and wrote a script
that allows me to magic my way from the mail into the correct commit in
the GitGitGadget PR in the browser. It is still shell script (at some
stage, I will need to extend the script to be much smarter than any shell
script can be, and probably convert it to node.js, but not today).

This helped me verify that there are no left-over references to the old
`b`. So all is good!

>
>  static int moved_entry_cmp(const void *hashmap_cmp_fn_data,
> @@ -1030,36 +1013,23 @@ static void pmb_advance_or_null(struct diff_opti=
ons *o,
>  }
>
>  static void pmb_advance_or_null_multi_match(struct diff_options *o,
> -					    struct moved_entry *match,
> -					    struct hashmap *hm,
> +					    struct emitted_diff_symbol *l,
>  					    struct moved_block *pmb,
> -					    int pmb_nr, int n)
> +					    int pmb_nr)
>  {
>  	int i;
> -	char *got_match =3D xcalloc(1, pmb_nr);
> -
> -	hashmap_for_each_entry_from(hm, match, ent) {
> -		for (i =3D 0; i < pmb_nr; i++) {
> -			struct moved_entry *prev =3D pmb[i].match;
> -			struct moved_entry *cur =3D (prev && prev->next_line) ?
> -					prev->next_line : NULL;
> -			if (!cur)
> -				continue;
> -			if (!cmp_in_block_with_wsd(o, cur, match, &pmb[i], n))
> -				got_match[i] |=3D 1;
> -		}
> -	}
>
>  	for (i =3D 0; i < pmb_nr; i++) {
> -		if (got_match[i]) {
> +		struct moved_entry *prev =3D pmb[i].match;
> +		struct moved_entry *cur =3D (prev && prev->next_line) ?
> +			prev->next_line : NULL;
> +		if (cur && !cmp_in_block_with_wsd(cur, l, &pmb[i])) {
>  			/* Advance to the next line */
> -			pmb[i].match =3D pmb[i].match->next_line;
> +			pmb[i].match =3D cur;
>  		} else {
>  			moved_block_clear(&pmb[i]);
>  		}
>  	}
> -
> -	free(got_match);

Even got rid of an allocation. Very nice.

>  }
>
>  static int shrink_potential_moved_blocks(struct moved_block *pmb,
> @@ -1223,7 +1193,7 @@ static void mark_color_as_moved(struct diff_option=
s *o,
>
>  		if (o->color_moved_ws_handling &
>  		    COLOR_MOVED_WS_ALLOW_INDENTATION_CHANGE)
> -			pmb_advance_or_null_multi_match(o, match, hm, pmb, pmb_nr, n);
> +			pmb_advance_or_null_multi_match(o, l, pmb, pmb_nr);

Again, magic button to the rescue! And I can verify that `l` is assigned
to `&o->emitted_symbols->buf[n]`, so: the patch does the correct thing.

Thank you,
Dscho

>  		else
>  			pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
>
> --
> gitgitgadget
>
>
