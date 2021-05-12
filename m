Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6043EC433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32A9D613FE
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:32:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhELX3E (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:29:04 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:55078 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233207AbhELXW3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 19:22:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5DB7512B38E;
        Wed, 12 May 2021 19:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=S/dGA6VeA+vrrTtIQLuugiXO6RK/UARjGlsCQQ
        yUdfI=; b=xrPnLWrSPWoSFBNfmE6umFDGyJ8+bxPS7tJBowNyXGvbYfK/bhGuX1
        8CcRT58O2dCDJEoIfLH0R3Ey8XDn5hzl1fhxx8DF5enV9loJoGao/7CjE4Zo9HDx
        /LxmeRqJYNnuJc5xTr2Fy7+9ZGK1y/2xoR69vqsYELjLgmv4W/As8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49F2212B38D;
        Wed, 12 May 2021 19:21:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7CCAA12B38C;
        Wed, 12 May 2021 19:21:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Hariom Verma <hariom18599@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v3 2/2] [GSOC] ref-filter: introduce enum atom_type
References: <pull.951.v2.git.1620659000.gitgitgadget@gmail.com>
        <pull.951.v3.git.1620821464.gitgitgadget@gmail.com>
        <43400cac58e74a2acab15ace929481a9efb7978f.1620821464.git.gitgitgadget@gmail.com>
Date:   Thu, 13 May 2021 08:21:15 +0900
In-Reply-To: <43400cac58e74a2acab15ace929481a9efb7978f.1620821464.git.gitgitgadget@gmail.com>
        (ZheNing Hu via GitGitGadget's message of "Wed, 12 May 2021 12:11:04
        +0000")
Message-ID: <xmqqk0o3edxw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C0B259A6-B378-11EB-B14A-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +/*
> + * The enum atom_type is used as the coordinates of valid_atom entry.

Usually we do not say "coordinates" when we talk about X of an array
element A[X].  "... used as an index in the valid_atom[] array." perhaps.

> + * In the atom parsing stage, it will be passed to used_atom.atom_type
> + * as the identifier of the atom type. We can judge the type of used_atom

You seem to like the verb "judge" (it was also seen in the proposed
log message for 1/2) and tend to overuse it when we use other verbs;
in this particular case, probably the right verb is to "check".

> + * entry by `if (used_atom[i].atom_type == ATOM_*)`.
> + */
> +enum atom_type {
> +	ATOM_REFNAME,
> +...
> +	ATOM_ELSE,
> +};
> +
> @@ -119,6 +169,7 @@ static struct ref_to_worktree_map {
>   * array.
>   */
>  static struct used_atom {
> +	enum atom_type atom_type;
>  	const char *name;
>  	cmp_type type;
>  	info_source source;

OK.

> @@ -506,47 +557,47 @@ static struct {
>  	int (*parser)(const struct ref_format *format, struct used_atom *atom,
>  		      const char *arg, struct strbuf *err);
>  } valid_atom[] = {
> -	{ "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
> ...
> -	{ "else", SOURCE_NONE },
> +	[ATOM_REFNAME] = { "refname", SOURCE_NONE, FIELD_STR, refname_atom_parser },
> ...
> +	[ATOM_ELSE] = { "else", SOURCE_NONE },

Makes sense.

> @@ -628,6 +679,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  	at = used_atom_cnt;
>  	used_atom_cnt++;
>  	REALLOC_ARRAY(used_atom, used_atom_cnt);
> +	used_atom[at].atom_type = i;

Makes sense.

>  	used_atom[at].name = xmemdupz(atom, ep - atom);
>  	used_atom[at].type = valid_atom[i].cmp_type;
>  	used_atom[at].source = valid_atom[i].source;
> @@ -652,7 +704,7 @@ static int parse_ref_filter_atom(const struct ref_format *format,
>  		return -1;
>  	if (*atom == '*')
>  		need_tagged = 1;
> -	if (!strcmp(valid_atom[i].name, "symref"))
> +	if (i == ATOM_SYMREF)
>  		need_symref = 1;
>  	return at;
>  }

Nice.

> @@ -965,14 +1017,15 @@ static void grab_common_values(struct atom_value *val, int deref, struct expand_
>  
>  	for (i = 0; i < used_atom_cnt; i++) {
>  		const char *name = used_atom[i].name;
> +		enum atom_type atom_type = used_atom[i].atom_type;
>  		struct atom_value *v = &val[i];
>  		if (!!deref != (*name == '*'))
>  			continue;
>  		if (deref)
>  			name++;
> -		if (!strcmp(name, "objecttype"))
> +		if (atom_type == ATOM_OBJECTTYPE)
>  			v->s = xstrdup(type_name(oi->type));
> -		else if (starts_with(name, "objectsize")) {
> +		else if (atom_type == ATOM_OBJECTSIZE) {
>  			if (used_atom[i].u.objectsize.option == O_SIZE_DISK) {
>  				v->value = oi->disk_size;
>  				v->s = xstrfmt("%"PRIuMAX, (uintmax_t)oi->disk_size);

Replacing !strcmp() with comparison with ATOM_* like the above is
the best solution for this step, but I wonder if this part (or any
other part that this patch touches) would benefit from using a
switch statement on atom_type.  Something to think about in the
future, after the dust settles.

Thanks.
