Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 708A41F463
	for <e@80x24.org>; Sat, 21 Sep 2019 12:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407616AbfIUMhS (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Sep 2019 08:37:18 -0400
Received: from mout.web.de ([212.227.15.4]:53215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2407609AbfIUMhR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Sep 2019 08:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569069434;
        bh=C1v9Vy9VNEUKrf3VeVyypMgvpSRWavv8iT2SggQjpNY=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UiCrYy40R7KOdJKezCZMFwLTB8afRxN58E3XEEyDs2W29TjGBaqHf2uyw7faKx/Cz
         9OWEzvUllTF5lfvKox9cFAtKj1PtIC6UBKbfNfbeUuBDU9fXI5siZI79dQDYPCq8Of
         Jlv7H4Blg8NDV98nlgG1ktpwCMsFH16RYy3Od4ng=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MWS0g-1iiBIu2qa2-00XZwm; Sat, 21
 Sep 2019 14:37:14 +0200
Subject: Re: [PATCH 09/15] name-rev: restructure parsing commits and applying
 date cutoff
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20190919214712.7348-1-szeder.dev@gmail.com>
 <20190919214712.7348-10-szeder.dev@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <cd11b0b4-e2b5-0b6e-cf44-c6139c574d7e@web.de>
Date:   Sat, 21 Sep 2019 14:37:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190919214712.7348-10-szeder.dev@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fKRUObSRdA2x/fwOR9HUiReDBX1hN72UsAFp0rAI5e4f2Aunfrg
 IxNIeoYSYb4J/Ich+pV7zP4O8/OI182VY6LIDxaGGwhjp/6FdH9M1TEGVVoi8LHL7FpXiO9
 CT2RSeiCPcQZJklKMvplwaau0DSKLarQL1GKHm76GG5kDOZCxPsNo2l/J/iyxuA/oYKRBrA
 P8BwxsyBibSU+zQPjCQJQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ss3WwwawuZc=:7SYPkVVNre6hldiilnU9zV
 jZ+gXyufQToQJusQ8OwFzrOegT7u0HfpvhOdIqTPxEiKfJ7MLaNqoqZdFtFJXf3lqysFFCauv
 V2PGH30Uf7FIn2UCxACR5eRVHmplX2iQspkQkyxLfCkGxlejkJd6tdWf/nPvOWJbBx6vUROjJ
 eaDRfYfYLaTx7PJI+MAWpgzxhG1yoLdfz+Qazc+gRSjz2EfAWbVB2kCiuGc9EkGN6KHxQ6Eea
 q+qqDwFBCArx/n3qRLa0grgtE3JGLzMMu7rvbzW4mMRaE7Yb5yTOgdy+by22apytMtJ6dXJIW
 1NZyprx2COGiA4xbm/mDEJ4G8jypFcV0Biy4ip5CX9dWv6/DvDwOcRiQHaNUx2gF7fXZdiOgK
 BEg+NxMvwy9X+GDN7ERTNOjpn0naJ4VqdP1JcwR40Ed76PclOd+oFjRMF8FNYAkb5KRsO2lhh
 Qhv6BcrlCEERAy8kqnQvobTOTYCAMv0QTzmg1OP85FrlqMA2p7i18wRhkpnZWsOsj8k6b9bSA
 EYLD6JlCWgrNeBEbB8NfyUa2lgT1Ok0EchGHlkwnQOArB+3Otn+gQSRX2bwLgsAYYwEwnhbph
 6xfMN2jAPrr3p7lgJL56fg3Tbz0yM5oQS/4Wx5u78TZZKenbAcSt5jQcZZq0aoLE0dvrglwiD
 EWUCzgsOaVi5Mk8tpCZtrZE0a1KqtxlA4m+j4lONZDTaBmTg2VVS+yp3u86wOUkEbFBOgCS1S
 CUnXZ1qil/hncbeEHTm9GRJgSMkBKTAL35lv3wqYakJvBoBNBevELak3Jv3exw+h/QYn0+28l
 ZUb8XcMAURTFZwnMB1eACCqRpugMJIBIpUAz4FPpahiXB+sgs81VHhSaPCj88xMnLCuaiEPTV
 smi21UNt5KkMtvsjXvQ8OaF3n0xffoTuprrqTdHu3jeDgObkFczQWKw/TEFWJfslfczrYSWP1
 bjMbW8tCgF78l0Gd11Hpmu5GeWKKfNpPnjNqFuzj1SHg4k5/OAbkQQqBwkRh4BUACHvcTGXTW
 u1zoEcqjY/gncaj2O5dLusPpADvSBpxVqLMgE0thUWduBiDSrVaDbKKhh6nczpBQxVtI+PlJP
 ptV6EYy7jNkdu7/rrxD2ww5iYYVjStivBo6k80zdwCbLdRtCIjoFwrvUkdv+TDlt7HfmKUaCT
 CEgm6fVnl7JVBBw9uCfZaWmS0B5D1LpjXGGDxy6Z7WR8Ij/hFU0wvw4hLUWMrtm6f+xD16t/c
 hxlgAKC5SMNBSJXf7CllcnI4piQqyuBQkSjbe+A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 19.09.19 um 23:47 schrieb SZEDER G=C3=A1bor:
> At the beginning of the recursive name_rev() function it parses the
> commit it got as parameter, and returns early if the commit is older
> than a cutoff limit.
>
> Restructure this so the caller parses the commit and checks its date,
> and doesn't invoke name_rev() if the commit to be passed as parameter
> is older than the cutoff, i.e. both name_ref() before calling
> name_rev() and name_rev() itself as it iterates over the parent
> commits.
>
> This makes eliminating the recursion a bit easier to follow, and it
> will be moved back to name_rev() after the recursion is eliminated.
>
> Signed-off-by: SZEDER G=C3=A1bor <szeder.dev@gmail.com>
> ---
>  builtin/name-rev.c | 29 ++++++++++++++++-------------
>  1 file changed, 16 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 42cea5c881..99643aa4dc 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -107,11 +107,6 @@ static void name_rev(struct commit *commit,
>  	struct commit_list *parents;
>  	int parent_number =3D 1;
>
> -	parse_commit(commit);
> -
> -	if (commit->date < cutoff)
> -		return;
> -
>  	if (!create_or_update_name(commit, tip_name, taggerdate, generation,
>  				   distance, from_tag))
>  		return;
> @@ -119,6 +114,12 @@ static void name_rev(struct commit *commit,
>  	for (parents =3D commit->parents;
>  			parents;
>  			parents =3D parents->next, parent_number++) {
> +		struct commit *parent =3D parents->item;
> +
> +		parse_commit(parent);
> +		if (parent->date < cutoff)
> +			continue;
> +
>  		if (parent_number > 1) {
>  			size_t len;
>  			char *new_name;
> @@ -131,11 +132,11 @@ static void name_rev(struct commit *commit,
>  				new_name =3D xstrfmt("%.*s^%d", (int)len, tip_name,
>  						   parent_number);
>

The check now also skips this allocation for old commits...

> -			name_rev(parents->item, new_name, taggerdate, 0,
> +			name_rev(parent, new_name, taggerdate, 0,
>  				 distance + MERGE_TRAVERSAL_WEIGHT,
>  				 from_tag);
>  		} else {
> -			name_rev(parents->item, tip_name, taggerdate,
> +			name_rev(parent, tip_name, taggerdate,
>  				 generation + 1, distance + 1,
>  				 from_tag);
>  		}
> @@ -269,16 +270,18 @@ static int name_ref(const char *path, const struct=
 object_id *oid, int flags, vo
>  	if (o && o->type =3D=3D OBJ_COMMIT) {
>  		struct commit *commit =3D (struct commit *)o;
>  		int from_tag =3D starts_with(path, "refs/tags/");
> -		const char *tip_name;
>
>  		if (taggerdate =3D=3D TIME_MAX)
>  			taggerdate =3D commit->date;
>  		path =3D name_ref_abbrev(path, can_abbreviate_output);
> -		if (deref)
> -			tip_name =3D xstrfmt("%s^0", path);
> -		else
> -			tip_name =3D xstrdup(path);
> -		name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
> +		if (commit->date >=3D cutoff) {
> +			const char *tip_name;
> +			if (deref)
> +				tip_name =3D xstrfmt("%s^0", path);
> +			else
> +				tip_name =3D xstrdup(path);

... and this allocation here as well.  If this improves performance
in a meaningful way then perhaps it should be kept at this place?
And if it doesn't, then an additional allocation might not hurt much?

Just a thought, I still didn't measure..

> +			name_rev(commit, tip_name, taggerdate, 0, 0, from_tag);
> +		}
>  	}
>  	return 0;
>  }
>

