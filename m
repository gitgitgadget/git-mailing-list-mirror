Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E823BC433DB
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 22:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5616619AA
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 22:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhCVV7p (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 17:59:45 -0400
Received: from mout.gmx.net ([212.227.17.21]:35569 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229746AbhCVV7X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 17:59:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616450358;
        bh=N1fUo2c8RSbe+FnbvX0gudYybrHlplMr3i8aYHymCM4=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h/BUJvOknDKh7qG9a5dOGSVO0XtC7hLfFTPggFpamrQGWUN2+ZTGkaSYXukMJ6D3V
         O6SGu/ORfxPZDfgM/DkqT4WjeoBJv8U8+hjSFa6g7Ymz174APjocg9amtlIQM+6Vdy
         B6GHuLBW58hf9gV5bPrfGv3DtOLEOZ6jqRybyMlw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MzQgC-1lbqh41nP6-00vMyw; Mon, 22
 Mar 2021 22:59:18 +0100
Date:   Mon, 22 Mar 2021 22:59:20 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Alban Gruin <alban.gruin@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v7 07/15] update-index: move add_cacheinfo() to
 read-cache.c
In-Reply-To: <20210317204939.17890-8-alban.gruin@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103222255550.50@tvgsbejvaqbjf.bet>
References: <20201124115315.13311-1-alban.gruin@gmail.com> <20210317204939.17890-1-alban.gruin@gmail.com> <20210317204939.17890-8-alban.gruin@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:nWB4i0XfQW9HkMaKPK9Gt/cLWrJVGWS8JcGaM2ptoQLTPif5ULU
 nMIu66B4WsWn5zrGPNf5hCByL6SfoDapD0oNBRjdIxzPogqSNx0U3v9RSpy/JztXXIS8vZl
 fLUeQf7xNomTratqeoEftn6yAXWvDQWkm1PNqW+PYqzVMvk9gJvG9Tw000xBE3ar5gemDIK
 y0nMzWBKqXhYg0hFD2obw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6TO61GzF+vg=:vZUFCPycDQLDfqWp/qPWWL
 eA2d6C6ntxaqJ9cTHsoMe9jMQ3R3Yy++T9GiCQqtEpyjuMb6mSE/EIBapi9PmyLUF6VLab0it
 XMv4su9dv4PgL1T90PWzW1iFZPDOUKSwAsXNAHjkOvg9+4VWyTacvkpK5KBd9iMO7/JQkZOWv
 WX5mj9EaW46TlRNPh9vd+UfcFvzym/qO+IEUPq1+viVmDfLCoYhMXDphsRCr9A1Y3zb6BG6fP
 SHv0FwBMm01hrP2R0PXiciZ2RBZq8bFWm9FQSX0/Kwk0KXzi/L2FHT6wA0B+zSbm+cEodKMmm
 aoztBtW8mAX6rHavUrtJEY9LyNrLW04HbTr5A1yoHJ1TOiv2JdjryGV10faBZReoSeBCHm0mB
 am1CMYjbg0FNqy+ldWuu1Hefkp2nTfi2nQhmwNbJTlRxT/vi345FOlK3FU5ymQT1q+i3Iz48N
 /ute0GoTeKELx6HkkvBedF/6pqqt8PrffzbgCQLBZOdJgpGqC2DW0wVC/2aIne5GA+LEmfkdg
 4zXV2eZkRebWcZx7FATJkzOZj8/1vinH4taRpO3q6A6ZN0tpRTp7FAmFTTkG/5MAOEX3pSt/e
 a3b+lOgvt+2stnrUsyvMsX/apgtx3oz2D5KlERSR992Ja1y3b2At8ELrhcKLfXtluFzfs78Se
 XXR7o3P3JVej3Ay5smM77C14dlY4PpcWhDhoYHjTCJQ7ilGt3XszxFZtjp5hcZDHG04DJm2Uy
 Hryq9XHmsuRRljKH8iQf4J4+HggL0BkaZM16Np72arItoePRn/BxQBE86cRbmhV346KKy18Nb
 D2Gy+Z648O8GWF1MKCWryFdTlKBJ+Y6wyCKcztQ5Bx0bkIQarBefkL9wByiuVudAbPm25rTrb
 BzspsM5BitoCUMJJkMddPltfBYFevnhShaZcSLtl0=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alban,

On Wed, 17 Mar 2021, Alban Gruin wrote:

> This moves the function add_cacheinfo() that already exists in
> update-index.c to update-index.c, renames it add_to_index_cacheinfo(),
> and adds an `istate' parameter.  The new cache entry is returned through
> a pointer passed in the parameters.  The return value is either 0
> (success), -1 (invalid path), or -2 (failed to add the file in the
> index).

This paragraph still talks about magic numbers, but the code has constants
for them. Maybe elevate the commit message to a more generic description
that does not spend time on specifying the exact values, but rather lists
the three outcomes in plain English?

Other than that, this looks fine to me! Thanks,
Dscho

>
> This will become useful in the next commit, when the three-way merge
> will need to call this function.
>
> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
> ---
>  builtin/update-index.c | 25 +++++++------------------
>  cache.h                |  8 ++++++++
>  read-cache.c           | 35 +++++++++++++++++++++++++++++++++++
>  3 files changed, 50 insertions(+), 18 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index 79087bccea..6b86e89840 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -404,27 +404,16 @@ static int process_path(const char *path, struct s=
tat *st, int stat_errno)
>  static int add_cacheinfo(unsigned int mode, const struct object_id *oid=
,
>  			 const char *path, int stage)
>  {
> -	int len, option;
> -	struct cache_entry *ce;
> +	int res;
>
> -	if (!verify_path(path, mode))
> -		return error("Invalid path '%s'", path);
> -
> -	len =3D strlen(path);
> -	ce =3D make_empty_cache_entry(&the_index, len);
> -
> -	oidcpy(&ce->oid, oid);
> -	memcpy(ce->name, path, len);
> -	ce->ce_flags =3D create_ce_flags(stage);
> -	ce->ce_namelen =3D len;
> -	ce->ce_mode =3D create_ce_mode(mode);
> -	if (assume_unchanged)
> -		ce->ce_flags |=3D CE_VALID;
> -	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
> -	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
> -	if (add_cache_entry(ce, option))
> +	res =3D add_to_index_cacheinfo(&the_index, mode, oid, path, stage,
> +				     allow_add, allow_replace, NULL);
> +	if (res =3D=3D ADD_TO_INDEX_CACHEINFO_INVALID_PATH)
> +		return error(_("Invalid path '%s'"), path);
> +	if (res =3D=3D ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD)
>  		return error("%s: cannot add to the index - missing --add option?",
>  			     path);
> +
>  	report("add '%s'", path);
>  	return 0;
>  }
> diff --git a/cache.h b/cache.h
> index 6fda8091f1..41e30c0da2 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -832,6 +832,14 @@ int remove_file_from_index(struct index_state *, co=
nst char *path);
>  int add_to_index(struct index_state *, const char *path, struct stat *,=
 int flags);
>  int add_file_to_index(struct index_state *, const char *path, int flags=
);
>
> +#define ADD_TO_INDEX_CACHEINFO_INVALID_PATH (-1)
> +#define ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD (-2)
> +
> +int add_to_index_cacheinfo(struct index_state *, unsigned int mode,
> +			   const struct object_id *oid, const char *path,
> +			   int stage, int allow_add, int allow_replace,
> +			   struct cache_entry **ce_ret);
> +
>  int chmod_index_entry(struct index_state *, struct cache_entry *ce, cha=
r flip);
>  int ce_same_name(const struct cache_entry *a, const struct cache_entry =
*b);
>  void set_object_name_for_intent_to_add_entry(struct cache_entry *ce);
> diff --git a/read-cache.c b/read-cache.c
> index 1e9a50c6c7..b514523ca1 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1350,6 +1350,41 @@ int add_index_entry(struct index_state *istate, s=
truct cache_entry *ce, int opti
>  	return 0;
>  }
>
> +int add_to_index_cacheinfo(struct index_state *istate, unsigned int mod=
e,
> +			   const struct object_id *oid, const char *path,
> +			   int stage, int allow_add, int allow_replace,
> +			   struct cache_entry **ce_ret)
> +{
> +	int len, option;
> +	struct cache_entry *ce;
> +
> +	if (!verify_path(path, mode))
> +		return ADD_TO_INDEX_CACHEINFO_INVALID_PATH;
> +
> +	len =3D strlen(path);
> +	ce =3D make_empty_cache_entry(istate, len);
> +
> +	oidcpy(&ce->oid, oid);
> +	memcpy(ce->name, path, len);
> +	ce->ce_flags =3D create_ce_flags(stage);
> +	ce->ce_namelen =3D len;
> +	ce->ce_mode =3D create_ce_mode(mode);
> +	if (assume_unchanged)
> +		ce->ce_flags |=3D CE_VALID;
> +	option =3D allow_add ? ADD_CACHE_OK_TO_ADD : 0;
> +	option |=3D allow_replace ? ADD_CACHE_OK_TO_REPLACE : 0;
> +
> +	if (add_index_entry(istate, ce, option)) {
> +		discard_cache_entry(ce);
> +		return ADD_TO_INDEX_CACHEINFO_UNABLE_TO_ADD;
> +	}
> +
> +	if (ce_ret)
> +		*ce_ret =3D ce;
> +
> +	return 0;
> +}
> +
>  /*
>   * "refresh" does not calculate a new sha1 file or bring the
>   * cache up-to-date for mode/content changes. But what it
> --
> 2.31.0
>
>
