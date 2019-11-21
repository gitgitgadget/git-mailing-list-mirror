Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12016C432C0
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:38:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDC5520672
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 05:38:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="YxrRNuDk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbfKUFiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 00:38:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51192 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725842AbfKUFiB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 00:38:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6610AD184;
        Thu, 21 Nov 2019 00:37:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=/2BU8H1u1ZVV
        OEQTu0El9/UdfTQ=; b=YxrRNuDkJcLIX9rEnCCL+pv+mk2DPxsHQi1+G1tNWhmA
        4M2Og9CM7EstogpJzOFmdxZr+gYHAvJdWiG/o6MLuEmDm/Rnv2tb2LU5FfmIbNkQ
        q1TtHnTDf+6sMMFodIENrSbBFpfgvhJCPJQqO/oYtTLfV5JQo+st4hQG8MgCPDQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=I+R8do
        SZA1LX+v0legA/iNUo5tilsdc4j5kW63XmOC2I6grjcFifqyjMuSvs4zOBYFr5zl
        3QyqnAmYIMnDNh9m9CbVVhhuOE9KSdb1dI2n2I3aN2x2Uxit1sZcFJdIPFkmgjCi
        bIwSk23++FlIfy/9sNiGmyFGazJrZndqSlHpo=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BEAE3AD183;
        Thu, 21 Nov 2019 00:37:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E87C8AD181;
        Thu, 21 Nov 2019 00:37:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 5/8] builtin/config: canonicalize "value_regex" with `--type=bool`
References: <cover.1573670565.git.martin.agren@gmail.com>
        <beb0cfbb78e3ae69e64ff2ed57c8e628ccb187ce.1573670565.git.martin.agren@gmail.com>
Date:   Thu, 21 Nov 2019 14:37:47 +0900
In-Reply-To: <beb0cfbb78e3ae69e64ff2ed57c8e628ccb187ce.1573670565.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Wed, 13 Nov 2019 19:55:04
 +0100")
Message-ID: <xmqqtv6x94d0.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0E2F94C4-0C21-11EA-935F-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> With `--type=3Dbool`, we use the "value_regex" as a normal regex and do
> not use our knowledge about the different well-defined ways we have of
> spelling the boolean values. Let's consider a few examples.
>
> These output "true":
> 	git -c foo.bar=3Dtrue config --type=3Dbool --get foo.bar true
> 	git -c foo.bar=3Dtrue config --type=3Dbool --get foo.bar t

I wonder what

    git -c foo.bar=3Dtrue config --type=3Dbool --get foo.bar 't.*'

should say.  I think you and Peff discussed in the downthread to
make it more strict to require <value_regex> *NOT* regexp at all,
but one of the string representations of boolean we would take,
which means 't' (in your exmaple) and 't.*' would stop yielding
correct result, which I think is fine.

> Canonicalize the provided "value_regex", then canonicalize candidate
> values as we go through the config and compare the canonicalized values=
.

I think (for the reason stated earlier) this is OK, but we should
make sure that we are clear in the documentation that in this mode
<value_regex> is no longer a regex but a string.  We might even want
to have a separate SYNOPSIS entry that does not say regex at all,
something along the lines of ...

-'git config' [<file-option>] [--type=3D<type>] [--show-origin] [-z|--nul=
l] --get name [value_regex]
+'git config' [<file-option>] [--show-origin] [-z|--null] --get name [val=
ue_regex]
+'git config' [<file-option>] --type=3D<type> [--show-origin] [-z|--null]=
 --get name [value]

> If the parameter doesn't canonicalize, fall back to handling it as a
> regex, as before. This would happen in the second example above, but
> also if someone has hand-rolled their own canonicalisation with, e.g.,
> something like "^(on|On|ON|true|1|42)$".

I actually am OK with this fallback, too.  That would also mean the
additional SYNOPSIS entry unnecessary ;-).

> Do not rename the "value_regex" in the documentation. This commit can b=
e
> seen as teaching `git config --type=3Dbool` about a particular type of
> regex, where "true" matches "yes", but not "no". So arguably,
> "value_regex" still describes quite well what is going on.

Heh ;-) I probably should learn to blindly read thru the proposed
log message to the end before starting to think about ramifications
of the proposed changes myself.  Some of the reasoning in this
paragraph should be reflected to the explanation of the argument in
the documentation, so that the readers will know this is not a usual
regex at all.

> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/git-config.txt |  4 ++++
>  builtin/config.c             | 15 +++++++++++-
>  t/t1300-config.sh            | 45 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 63 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.tx=
t
> index 899e92a1c9..139750bbda 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -43,6 +43,10 @@ outgoing values are canonicalize-able under the give=
n <type>.  If no
>  `--type=3D<type>` is given, no canonicalization will be performed. Cal=
lers may
>  unset an existing `--type` specifier with `--no-type`.
> =20
> +With `--type=3Dbool`, if `value_regex` is given
> +and canonicalizes to a boolean value, it matches all entries
> +that canonicalize to the same boolean value.

... otherwise `value_regex` is used as a string, i.e. as if no
'--type=3Dbool' is given.

> +	if (cmd_line_value.mode =3D=3D boolean &&
> +	    git_parse_maybe_bool(value_) !=3D cmd_line_value.boolean)
> +		return 0;
> =20
>  	ALLOC_GROW(values->items, values->nr + 1, values->alloc);
>  	strbuf_init(&values->items[values->nr], 0);
> @@ -292,6 +296,15 @@ static int handle_value_regex(const char *regex_)
>  		return 0;
>  	}
> =20
> +	if (type =3D=3D TYPE_BOOL) {
> +		int boolval =3D git_parse_maybe_bool(regex_);
> +		if (boolval >=3D 0) {
> +			cmd_line_value.mode =3D boolean;
> +			cmd_line_value.boolean =3D boolval;
> +			return 0;
> +		}
> +	}
> +
>  	cmd_line_value.mode =3D regexp;

... which can be seen here.  OK.

> diff --git a/t/t1300-config.sh b/t/t1300-config.sh
> index a38cc143a1..e4906a893e 100755
> --- a/t/t1300-config.sh
> +++ b/t/t1300-config.sh
> @@ -427,6 +427,51 @@ test_expect_success 'no arguments, but no crash' '
>  	test_i18ngrep usage output
>  '
> =20
> +test_expect_success 'setup config file with several boolean values' '
> +	cat >.git/config <<-\EOF
> +	[foo]
> +		n1 =3D no
> +		n2 =3D NO
> +		n3 =3D off
> +		n4 =3D false
> +		n5 =3D 0
> +		n6 =3D
> +		y1 =3D yes
> +		y2 =3D YES
> +		y3 =3D on
> +		y4 =3D true
> +		y5 =3D 1
> +		y6 =3D 42
> +		y7
> +	EOF
> +'
> +
> +test_expect_success '--get-regexp canonicalizes value_regex with --typ=
e=3Dbool (false)' '
> +	git config --type=3Dbool --get-regexp "foo\..*" OFF >output &&
> +	test_line_count =3D 6 output &&
> +	! grep -v "^foo.n" output
> +'
> +
> +test_expect_success '--get-regexp canonicalizes value_regex with --typ=
e=3Dbool (true)' '
> +	git config --type=3Dbool --get-regexp "foo\..*" ON >output &&
> +	test_line_count =3D 7 output &&
> +	! grep -v "^foo.y" output
> +'
> +
> +test_expect_success '--get canonicalizes integer value_regex with --ty=
pe=3Dbool' '
> +	echo true >expect &&
> +	git config --type=3Dbool --get foo.y2 1 >output &&
> +	test_cmp expect output
> +'
> +
> +test_expect_success '--type=3Dbool with "non-bool" value_regex' '
> +	echo true >expect &&
> +	git config --type=3Dbool --get foo.y4 "t.*" >output &&
> +	test_cmp expect output &&
> +	test_must_fail git config --type=3Dbool --get foo.y4 "T.*" >output &&
> +	test_must_be_empty output
> +'
> +
>  test_expect_success 'setup simple config file' '
>  	q_to_tab >.git/config <<-\EOF
>  	[a.b]
