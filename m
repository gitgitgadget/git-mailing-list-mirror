Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11BC433E0
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AFAD65105
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 18:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbhCHSSn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Mar 2021 13:18:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59356 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhCHSSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Mar 2021 13:18:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A869B135FFF;
        Mon,  8 Mar 2021 13:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=6L3b8QVgwWV9
        ogdvKdmNjbADWTQ=; b=AAwZ4nK4vXh9uWDFyD/kuPAl2nG/g/CLJPZbuFe2ZMTZ
        gjAyarKLmSpJrlW+Na3oNKEeRQMJDntNlK1Df7mLv9NiTyxXPiJZj99MAUCud8aj
        VVzS8+HH7f6aBoQ/Yv07mU1CNbgQp72UXUFTBa6qrqEqamtkIT5gELo8I95lfRk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=SmXd1W
        BIduFQ1JSbRsy84HlATvFQgX8Huml8W/6vStwWHob1XeA4hjiyUsICx/fym6wZyc
        dWQa7kogY1oeFVPhOj14mzZZ0wpWj6DjSaktT8jt+NezkAolxCC4VQH4XfqCevDq
        hJIgFCxXnwvvxxKPSDWfEoI50pdfAbebX/WU0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A1E30135FFE;
        Mon,  8 Mar 2021 13:18:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id EE0C8135FFD;
        Mon,  8 Mar 2021 13:18:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 3/6] ls-files: don't needlessly pass around stage
 variable
References: <20210306193458.20633-1-avarab@gmail.com>
        <20210308022138.28166-4-avarab@gmail.com>
Date:   Mon, 08 Mar 2021 10:18:06 -0800
In-Reply-To: <20210308022138.28166-4-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Mon, 8 Mar 2021 03:21:35 +0100")
Message-ID: <xmqq1rcp7bmp.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A2093B58-803A-11EB-BE4B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Now that read_tree() has been moved to ls-files.c we can get rid of
> the stage !=3D 1 case that'll never happen.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  builtin/ls-files.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
>
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index a4458622813..74d572a3e4a 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -470,21 +470,12 @@ static int read_one_entry_quick(const struct obje=
ct_id *oid, struct strbuf *base
>  }
> =20
> =20
> -static int read_tree(struct repository *r, struct tree *tree, int stag=
e,
> +static int read_tree(struct repository *r, struct tree *tree,
>  		     struct pathspec *match, struct index_state *istate)
>  {
>  	read_tree_fn_t fn =3D NULL;
>  	int i, err;
> =20
> -	/*
> -	 * Currently the only existing callers of this function all
> -	 * call it with stage=3D1 and after making sure there is nothing
> -	 * at that stage; we could always use read_one_entry_quick().
> -	 *
> -	 * But when we decide to straighten out git-read-tree not to
> -	 * use unpack_trees() in some cases, this will probably start
> -	 * to matter.
> -	 */

The "hoist everything to stage#1, read and compare" the commit that
introduced this comment talks about (cf. af3785dc5a7) was entirely
rewritten by d1f2d7e8 (Make run_diff_index() use unpack_trees(), not
read_tree(), 2008-01-19); this clean-up is long overdue.

Looking good.





>  	/*
>  	 * See if we have cache entry at the stage.  If so,
> @@ -493,13 +484,13 @@ static int read_tree(struct repository *r, struct=
 tree *tree, int stage,
>  	 */
>  	for (i =3D 0; !fn && i < istate->cache_nr; i++) {
>  		const struct cache_entry *ce =3D istate->cache[i];
> -		if (ce_stage(ce) =3D=3D stage)
> +		if (ce_stage(ce) =3D=3D 1)
>  			fn =3D read_one_entry;
>  	}
> =20
>  	if (!fn)
>  		fn =3D read_one_entry_quick;
> -	err =3D read_tree_recursive(r, tree, "", 0, stage, match, fn, istate)=
;
> +	err =3D read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
>  	if (fn =3D=3D read_one_entry || err)
>  		return err;
> =20
> @@ -549,7 +540,7 @@ void overlay_tree_on_index(struct index_state *ista=
te,
>  			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
>  	} else
>  		memset(&pathspec, 0, sizeof(pathspec));
> -	if (read_tree(the_repository, tree, 1, &pathspec, istate))
> +	if (read_tree(the_repository, tree, &pathspec, istate))
>  		die("unable to read tree entries %s", tree_name);
> =20
>  	for (i =3D 0; i < istate->cache_nr; i++) {
