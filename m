Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A011C1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391971AbfHBTOm (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 15:14:42 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62350 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfHBTOl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 15:14:41 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 584688019A;
        Fri,  2 Aug 2019 15:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=qrzv5qbJX1ic
        fz+bKwMEsgyR04E=; b=m5QAp/r77Dl9t947IrWA3x7WCYT0lpxrjWQuvMH6GvWZ
        ednb1XRS+cZCxH781CMnfkyehMrCNOO1iUKeUEL4jpMMZXntPYtNiGD9IM5YW3Bn
        jBkLZjyBmfjLAA0UYrMnYl2+DwTYIYYmImkRDQyKEX6UnmaNeZ+L3FVXI+yggEo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=A1VbeS
        YlchzSA7OAOiLormu7CnbGHTBRYSG+ZL2kH6SN1MhdaY0X2rPb4Vysm74Uyq4H8U
        HPTHg9IN0BWVCnTJCi5vJ2mRIjs+pgBRbKZN5TngyRKF3yVleMIFc6RqaUS0cs9A
        9uDkds1rV70jmFO9pHc88YP31fyF5eZm9Exbc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 508A080199;
        Fri,  2 Aug 2019 15:14:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5DD2380197;
        Fri,  2 Aug 2019 15:14:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?Q?=C3=89tienne?= SERVAIS <etienne.servais@voucoux.fr>,
        git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Subject: Re: Simplify-by-decoration with decorate-refs-exclude
References: <D941A96E-E5A8-4C86-A200-0BECA30216D1@voucoux.fr>
        <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de>
Date:   Fri, 02 Aug 2019 12:14:33 -0700
In-Reply-To: <37283d4e-3f79-a6b1-425a-f90704fbcce2@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Fri, 2 Aug 2019 18:52:51 +0200")
Message-ID: <xmqq36ijl6qu.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: C3D8F258-B559-11E9-B052-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Am 02.08.19 um 10:47 schrieb =C3=89tienne SERVAIS:
>> Thus, when I enter
>>
>> ```
>> git log --oneline --graph  --decorate=3Dfull --decorate-refs-exclude=3D=
'refs/tags/<pattern>'
>> ```
>> The selected tags are properly excluded but once I add the
>> `simplify-by-decoration` option
>>
>> ```
>> git log --oneline --graph  --decorate=3Dfull --decorate-refs-exclude=3D=
'refs/tags/<pattern>' --simplify-by-decoration
>> ```
>> The excluded tags pop back again.
>
> Does this help?

I can see how this would help, but it somehow feels a bit brittle
to rely on where the decorations get loaded.

I wonder if it would help to move the ability to handle decoration
filter down from the log layer to revisions.c API layer.

It looks to me that this caller of setup_revisions() can prepare
decoration_filter before it calls setup_revisions(); we can let the
revisions.c layer call load_ref_decorations() in setup_revisions()
if that is the case, no?

Other two callers of load_ref_decorations() are deep inside pretty.c
but I wonder in the longer term if we would want to turn them into
an "a lot higher level should have already loaded decorations"
assert.

Thanks.

> -- >8 --
> Subject: [PATCH] revision: load decorations lazily for --simplify-by-de=
coration
>
> Let setup_revisions() and friends respect a filtered set of decoration
> refs loaded by callers by postponing its own load_ref_decorations() cal=
l
> to just before decorations are used to simplify history.  That function
> only does any actual work the first time it is called.
>
> This allows using the revision option --simplify-by-decoration together
> with the log option --decorate-refs-exclude and having it simplify over
> the restricted set of refs.
>
> Reported-by: =C3=89tienne SERVAIS <etienne.servais@voucoux.fr>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  revision.c     |  8 +++++++-
>  t/t4202-log.sh | 15 +++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>
> diff --git a/revision.c b/revision.c
> index 07412297f0..d3456c959b 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -633,6 +633,13 @@ static int rev_compare_tree(struct rev_info *revs,
>  		return REV_TREE_OLD;
>
>  	if (revs->simplify_by_decoration) {
> +		/*
> +		 * Load decorations lazily; later calls have no effect.
> +		 * This gives callers a chance to load a restricted set
> +		 * beforehand.
> +		 */
> +		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
> +
>  		/*
>  		 * If we are simplifying by decoration, then the commit
>  		 * is worth showing if it has a tag pointing at it.
> @@ -2063,7 +2070,6 @@ static int handle_revision_opt(struct rev_info *r=
evs, int argc, const char **arg
>  		revs->simplify_by_decoration =3D 1;
>  		revs->limited =3D 1;
>  		revs->prune =3D 1;
> -		load_ref_decorations(NULL, DECORATE_SHORT_REFS);
>  	} else if (!strcmp(arg, "--date-order")) {
>  		revs->sort_order =3D REV_SORT_BY_COMMIT_DATE;
>  		revs->topo_order =3D 1;
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index c20209324c..bb66d1d93c 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -837,6 +837,21 @@ test_expect_success 'decorate-refs and decorate-re=
fs-exclude' '
>  	test_cmp expect.decorate actual
>  '
>
> +test_expect_success 'decorate-refs-exclude and simplify-by-decoration'=
 '
> +	cat >expect.decorate <<-\EOF &&
> +	Merge-tag-reach (HEAD -> master)
> +	reach (tag: reach, reach)
> +	seventh (tag: seventh)
> +	Merge-branch-tangle
> +	Merge-branch-side-early-part-into-tangle (tangle)
> +	tangle-a (tag: tangle-a)
> +	EOF
> +	git log -n6 --decorate=3Dshort --pretty=3D"tformat:%f%d" \
> +		--decorate-refs-exclude=3D"*octopus*" \
> +		--simplify-by-decoration >actual &&
> +	test_cmp expect.decorate actual
> +'
> +
>  test_expect_success 'log.decorate config parsing' '
>  	git log --oneline --decorate=3Dfull >expect.full &&
>  	git log --oneline --decorate=3Dshort >expect.short &&
> --
> 2.22.0
