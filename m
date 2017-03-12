Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86602201C2
	for <e@80x24.org>; Sun, 12 Mar 2017 03:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755661AbdCLDTL (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 Mar 2017 22:19:11 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62195 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755611AbdCLDTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Mar 2017 22:19:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B188A7BDC2;
        Sat, 11 Mar 2017 22:19:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=L8jR9wsVv4cp
        AAw+UfMxkr3r6II=; b=bvBxa9o9IkTWL4C90V7qBoSzH8nEDPQ0CBU4BSRLftPd
        OwDEQINeUAJNtBv9MHxsAHis6FACLWgMUjfWpxBjqFHX1E+0O7KxAnbeNSc06wbm
        veEWZO5Iq9CkIqNfbq2SDuEb5BzXQZHfNDonpi71yicUBK6oFXLLKItVqrEFwgA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=OlphpX
        C4XGxetRK8fX6kbbdGKtJEtjXk32aw5RnKsPhXek68XDTnQIf+wOuAve7DZBBbJ9
        ogLkWfn3CkcBmrOYlUzQa0f3Cq7oZYCd7Y1SGpSerGk2xxngUuSgGvgVfxSfT8UT
        JFtrWVugY2ktWRM9cWWu3okwaYBAG98uipNDw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A9F3F7BDC1;
        Sat, 11 Mar 2017 22:19:02 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B8C07BDBF;
        Sat, 11 Mar 2017 22:19:02 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jake Goulding <goulding@vivisimo.com>,
        Jeff King <peff@peff.net>, Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] tag: Implicitly supply --list given another list-like option
References: <20170310124247.jvrmmcz2pbv4qf3o@sigill.intra.peff.net>
        <20170311120855.16756-1-avarab@gmail.com>
Date:   Sat, 11 Mar 2017 19:19:00 -0800
In-Reply-To: <20170311120855.16756-1-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 11 Mar 2017 12:08:55 +0000")
Message-ID: <xmqq4lyzw5az.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A3ECEBB2-06D2-11E7-8CCA-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Change these invocations which currently error out without the -l, to
> behave as if though -l was provided:
>
>     git tag -l [--contains|--points-at|--[no-]merged] <commit>

Shouldn't this be

	git tag -l [[--[no-]contains|--points-at|--[no-]merged]	<commit>] [<patt=
ern>]

i.e. if you are giving <commit> you need how that commit is used in
filtering, but you do not have to give any such filter when listing,
and <pattern>, when given, is used to further limit the output, but
it also is optional.

> Subject: Re: [PATCH] tag: Implicitly supply --list given another list-l=
ike option

s/Implicit/implicit/ (ask "git shortlog --no-merges" over recent history)

> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 525737a5d8..c80d9e11ba 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -94,6 +94,9 @@ OPTIONS
>  	lists all tags. The pattern is a shell wildcard (i.e., matched
>  	using fnmatch(3)).  Multiple patterns may be given; if any of
>  	them matches, the tag is shown.
> ++
> +We supply this option implicitly if any other list-like option is
> +provided. E.g. `--contains`, `--points-at` etc.

Who are "we"? =20

	When any option that only makes sense in the list mode
	(e.g. `--contains`) is given, the command defaults to
	the `--list` mode.

By the way, do we catch it as a command line error when options like
`--points-at` are given when we are creating a new tag?

> diff --git a/builtin/tag.c b/builtin/tag.c
> index ad29be6923..6ab65bcf6b 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -454,6 +454,12 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>  	}
>  	create_tag_object =3D (opt.sign || annotate || msg.given || msgfile);
> =20
> +	/* We implicitly supply --list with --contains, --points-at,
> +	   --merged and --no-merged, just like git-branch */

	/*
         * We write multi-line comments like this,
	 * without anything other than slash-asterisk or
	 * asterisk-slash on the first and last lines.
	 */

> +	if (filter.with_commit || filter.points_at.nr || filter.merge_commit)
> +		cmdmode =3D 'l';

Don't we want to make sure we do the defaulting only upon !cmdmode?
Doesn't this start ignoring

	tag -a -m foo --points-at HEAD bar

as an error otherwise?

> +	/* Just plain "git tag" is like "git tag --list" */
>  	if (argc =3D=3D 0 && !cmdmode)
>  		cmdmode =3D 'l';

> @@ -486,12 +492,6 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>  	}
>  	if (filter.lines !=3D -1)
>  		die(_("-n option is only allowed with -l."));
> -	if (filter.with_commit)
> -		die(_("--contains option is only allowed with -l."));
> -	if (filter.points_at.nr)
> -		die(_("--points-at option is only allowed with -l."));
> -	if (filter.merge_commit)
> -		die(_("--merged and --no-merged option are only allowed with -l"));

And I do not think removal of these check is a good idea at all.
Perhaps you were too focused on '-l' that you forgot that people may
be giving an explicit option like -a or -s, in which case these
error checks are still very sensible things to have, no?
