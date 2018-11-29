Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2D6211B3
	for <e@80x24.org>; Thu, 29 Nov 2018 02:59:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727079AbeK2ODb (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Nov 2018 09:03:31 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62107 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726954AbeK2ODb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Nov 2018 09:03:31 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3996F29712;
        Wed, 28 Nov 2018 21:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=zNMtqOamWxue
        iDll8DKxQ0dEROo=; b=Szwu7Gj56jXIeCXX+45xM14MgR2NgLrR5wanGiZXFCjY
        fIaVISFkTtoX20MYSAoBeY/SxkFZhT/VVwyiBdwO8hFDCzKBch7mIK2o7i3KbZuQ
        o7LZwSu93Q2leCRoYJ+1ygxlx8ZhOWJZ8cyr6tKQ+Gm6KLI6ozhH/yC/IL5Pzk8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=kNdD8E
        +C9gJak55TBME1GVLjAUS5HYznYp0d381NvPj76mLgjfbj1yrkMxKbMpk9OgPjbM
        c/OSENdKVpUkYtd7hFkvNeD+thGPrKT4ju3GJ1R3t/GGeeRS4HB/TMZ7Uuec03/x
        TVuN2RZCZOD/kwpq4Xa7NUaXBfxdzwnOvI+v4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 335462970F;
        Wed, 28 Nov 2018 21:59:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3E7482970A;
        Wed, 28 Nov 2018 21:59:39 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/2] format-patch: allow for independent diff & range-diff options
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com>
        <20181128201852.9782-3-avarab@gmail.com>
Date:   Thu, 29 Nov 2018 11:59:37 +0900
In-Reply-To: <20181128201852.9782-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Wed, 28 Nov 2018 21:18:52 +0100")
Message-ID: <xmqq8t1cr3l2.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CFD121FA-F382-11E8-8393-CC883AD79A78-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +		      [--range-diff<common diff option>]]

Let's make sure a random string thrown at this mechanism will
properly get noticed and diagnosed.

> @@ -257,6 +258,13 @@ feeding the result to `git send-email`.
>  	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
>  	for details.
> =20
> +--range-diff<common diff option>::
> +	Other options prefixed with `--range-diff` are stripped of
> +	that prefix and passed as-is to the diff machinery used to
> +	generate the range-diff, e.g. `--range-diff-U0` and
> +	`--range-diff--no-color`. This allows for adjusting the format
> +	of the range-diff independently from the patch itself.

Taking anything is of course the most general, but I am afraid if
this backfires if there are some options that do not make sense to
be different between the invocations of range-diff and format-patch.

> @@ -1689,8 +1688,32 @@ int cmd_format_patch(int argc, const char **argv=
, const char *prefix)
>  	rev.preserve_subject =3D keep_subject;
> =20
>  	argc =3D setup_revisions(argc, argv, &rev, &s_r_opt);
> -	if (argc > 1)
> -		die(_("unrecognized argument: %s"), argv[1]);
> +	if (argc > 1) {
> +		struct argv_array args =3D ARGV_ARRAY_INIT;
> +		const char *prefix =3D "--range-diff";

Please call that anything but "prefix" that hides the parameter to
the function. =20

	const char *range_diff_opt =3D "--range-diff";

might work OK, or it might not.  Let's read on.

> +		int have_prefix =3D 0;
> +
> +		for (i =3D 0; i < argc; i++) {
> +			struct strbuf sb =3D STRBUF_INIT;
> +			char *str;
> +
> +			strbuf_addstr(&sb, argv[i]);
> +			if (starts_with(argv[i], prefix)) {
> +				have_prefix =3D 1;
> +				strbuf_remove(&sb, 0, strlen(prefix));
> +			}
> +			str =3D strbuf_detach(&sb, NULL);
> +			strbuf_release(&sb);
> +
> +			argv_array_push(&args, str);
> +		}
> +

Is the body of the loop essentially this?

			char *passopt =3D argv[i];
			if (!skip_prefix(passopt, range_diff_opt, &passopt))
				saw_range_diff_opt =3D 1;
			argv_array_push(&args, xstrdup(passopt));

We only use that "prefix" thing once, so we may not even need the
variable.

> +		if (!have_prefix)
> +			die(_("unrecognized argument: %s"), argv[1]);

So we take normal options and check the leftover args; if there is
no --range-diff<whatever> among the leftover bits, we pretend that
we stumbled while reading the first such leftover arg.

> +		argc =3D setup_revisions(args.argc, args.argv, &rd_rev, NULL);
> +		if (argc > 1)
> +			die(_("unrecognized argument: %s"), argv[1]);
> +	}

Otherwise, we pass all the leftover bits, which is a random mixture
but guaranteed to have at least one meant for range-diff, to another
setup_revisions().  If it leaves a leftover arg, then that is
diagnosed here, so we'd be OK (iow, this is not a new "attack
vector" to inject random string to command line parser).

One minor glitch I can see is "format-patch --range-diffSilly" would
report "unrecognised arg: Silly".  As we are pretending to be and
reporting errors as format-patch, it would be better if we report
that --range-diffSilly was what we did not understand.

> Junio: I know it's late, but unless Eric has objections to this UI
> change I'd really like to have this in 2.20 since this is a change to
> a new command-line UI that's newly added in 2.20.

Quite honestly, I'd rather document "driving range-diff from
format-patch is experimental and does silly things when given
non-standard options in this release" and not touch the code at this
late stage in the game.  Would it be less intrusive a change to
*not* support the --range-diff<whatever> option, still use rd_rev
that is separate from the main rev, and use a reasonable hardcoded
default settings when preparing rd_rev?


