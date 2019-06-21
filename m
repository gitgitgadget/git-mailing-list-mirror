Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BEB1F461
	for <e@80x24.org>; Fri, 21 Jun 2019 17:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbfFURHZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jun 2019 13:07:25 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53095 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725985AbfFURHY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jun 2019 13:07:24 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D1E50152381;
        Fri, 21 Jun 2019 13:07:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Z6sNKNxBgQd3
        yncGakp2G8HmYKA=; b=OZGhiEwweFq8dNNkXSDssYdWDLNnEwTDwY0/xswSUoEM
        jvnC1JDN0uxbaAQFcQiZcO5D7Q9K+F/ZoYJIIJq8zAxgwnybc9NEbA2bgkqgDY79
        B3JOGltHhs2ltFDb/k9PousJxsF940L81FzFIgp0Y209RKWTKdVrbgEfTxbnicg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=oTPgfi
        n5PO3kHphxi0bl3hZGmBjo2123hR/ZjhCp8/4Rj9WR8EECno/HV3vYH2FO6TKP/a
        RqRsqfAgolDqaNgOabBQJ/ONIgZxtHbXTmVEtSSk1F5Whkh/bb53QPBAGqtF9XTZ
        SOoF88ARrsR2SqHdRdze8V7aliv5YJ/31u5D8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C803A15237F;
        Fri, 21 Jun 2019 13:07:22 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2792715237E;
        Fri, 21 Jun 2019 13:07:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/8] env--helper: new undocumented builtin wrapping git_env_*()
References: <20190620210915.11297-1-avarab@gmail.com>
        <20190621101812.27300-3-avarab@gmail.com>
Date:   Fri, 21 Jun 2019 10:07:21 -0700
In-Reply-To: <20190621101812.27300-3-avarab@gmail.com> (=?utf-8?B?IsOGdmFy?=
 =?utf-8?B?IEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 21 Jun 2019 12:18:06 +0200")
Message-ID: <xmqqr27mkgty.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 08BE2B06-9447-11E9-ABC7-46F8B7964D18-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> The --type=3Dbool option will be used by subsequent patches, but not
> --type=3Dulong. I figured it was easy enough to add it & test for it so
> I left it in so we'd have wrappers for both git_env_*() functions, and
> to have a template to make it obvious how we'd add --type=3Dint etc. if
> it's needed in the future.

Yup, it is fine to start small/minimal.  In addition, obviously we
would eventually want "string" type (in fact, it would probably be
the reasonable default when --type=3D<type> option is missing, once
this becomes a real command and not a test helper).

> +static char const * const env__helper_usage[] =3D {
> +	N_("git env--helper --type=3D[bool|ulong] <options> <env-var>"),

This makes it look as if --type=3D<type> is not among options, which I
am not sure is the impression we would want to give, as I doubt we
would want to keep it mandatory in the long run, but I'd say it is
OK for two reasons (1) as we start minimal, it is OK to keep this
mandatory, and (2) this gives us a place to enumerate available
types.

The output from "git env--helper -h" may redundantly list the
"--type" option, though.

> +	argc =3D parse_options(argc, argv, prefix, opts, env__helper_usage,
> +			     PARSE_OPT_KEEP_UNKNOWN);

Why KEEP_UNKNOWN?

> +	if (env_default && !*env_default)
> +		usage_with_options(env__helper_usage, opts);
> +	if (!cmdmode)
> +		usage_with_options(env__helper_usage, opts);
> +	if (argc !=3D 1)
> +		usage_with_options(env__helper_usage, opts);
> +	env_variable =3D argv[0];
> +
> +	switch (cmdmode) {
> +	case ENV_HELPER_TYPE_BOOL:
> +		if (env_default) {
> +			default_int =3D git_parse_maybe_bool(env_default);
> +			if (default_int =3D=3D -1) {
> +				error(_("option `--default' expects a boolean value with `--type=3D=
bool`, not `%s`"),
> +				      env_default);
> +				usage_with_options(env__helper_usage, opts);
> +			}

OK, that more-or-less is equivalent to what git_config_bool_or_int()
does, except that I would say "if (default_int < 0)" to match the
original more closely if I were doing this.

> +		} else {
> +			default_int =3D 0;
> +		}
> +		ret_int =3D git_env_bool(env_variable, default_int);
> +		if (!exit_code)
> +			puts(ret_int ? "true" : "false");
> +		ret =3D ret_int;
> +		break;

I do not think we want to assign 0 to 'ret' if we are not doing
"exit_code".  "We successfully found that the variable's value is
false, said that to standard output, and signal success by exiting
with 0 status" is what we would want, no?

> +	case ENV_HELPER_TYPE_ULONG:
> +		if (env_default) {
> +			if (!git_parse_ulong(env_default, &default_ulong)) {
> +				error(_("option `--default' expects an unsigned long value with `-=
-type=3Dulong`, not `%s`"),
> +				      env_default);
> +				usage_with_options(env__helper_usage, opts);
> +			}
> +		} else {
> +			default_ulong =3D 0;
> +		}
> +		ret_ulong =3D git_env_ulong(env_variable, default_ulong);
> +		if (!exit_code)
> +			printf("%lu\n", ret_ulong);
> +		ret =3D ret_ulong;

Likewise.

> +		break;
> +	default:
> +		BUG("unknown <type> value");
> +		break;
> +	}
> +
> +	return !ret;
> +}
> diff --git a/git.c b/git.c
> index c2eec470c9..a43e1dd98e 100644
> --- a/git.c
> +++ b/git.c
> @@ -500,6 +500,7 @@ static struct cmd_struct commands[] =3D {
>  	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
>  	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
>  	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
> +	{ "env--helper", cmd_env__helper },
>  	{ "fast-export", cmd_fast_export, RUN_SETUP },
>  	{ "fetch", cmd_fetch, RUN_SETUP },
>  	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
> diff --git a/t/t0017-env-helper.sh b/t/t0017-env-helper.sh
> new file mode 100755
> index 0000000000..709bbbd275
> --- /dev/null
> +++ b/t/t0017-env-helper.sh
> @@ -0,0 +1,83 @@
> +#!/bin/sh
> +
> +test_description=3D'test env--helper'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'env--helper usage' '
> +	test_must_fail git env--helper &&
> +	test_must_fail git env--helper --type=3Dbool &&
> +	test_must_fail git env--helper --type=3Dulong &&
> +	test_must_fail git env--helper --type=3Dbool &&
> +	test_must_fail git env--helper --type=3Dbool --default &&
> +	test_must_fail git env--helper --type=3Dbool --default=3D &&
> +	test_must_fail git env--helper --defaultxyz
> +'
> +
> +test_expect_success 'env--helper bad default values' '

I think

	sane_unset MISSING &&

is needed, as I do not think test-lib.sh filters that variable from
the tester's environment from being seen by us.

> +	test_must_fail git env--helper --type=3Dbool --default=3D1xyz MISSING=
 &&
> +	test_must_fail git env--helper --type=3Dulong --default=3D1xyz MISSIN=
G

Both I and you know that the current implementation of env--helper
happens to notice and bail for failing to parse --default without
even consulting the variable, but we do not have to rely on such an
implementation detail.

Speaking of that particular implementation detail, if the variable
is not missing, should we even parse and complain what is in --default?
I think the answer is "yes, for catching bugs in the script, that is
more useful behaviour".

If that is the design principle, we should also test cases where an
existing variable is given with a --default that is unparseable and
make sure that the command fails.

> +'
> +
> +test_expect_success 'env--helper --type=3Dbool' '

Ditto for sane_unset MISSING upfront.

> +	# Test various --default bool values
> +	echo true >expected &&
> +	git env--helper --type=3Dbool --default=3D1 MISSING >actual &&
> +	test_cmp expected actual &&
> +	git env--helper --type=3Dbool --default=3Dyes MISSING >actual &&
> +	test_cmp expected actual &&
> +	git env--helper --type=3Dbool --default=3Dtrue MISSING >actual &&
> +	test_cmp expected actual &&
> +	echo false >expected &&
> +	test_must_fail git env--helper --type=3Dbool --default=3D0 MISSING >a=
ctual &&
> +	test_cmp expected actual &&

As I said already, it is a horrible calling convention to make the
mode that produces textual output to fail when the variable is set
to false.  The above two should read more like

    echo true >expect &&
    git env--helper --type=3Dbool --default=3Dtrue MISSING >actual &&
    test_cmp expect actual &&
    echo false >expect &&
    git env--helper --type=3Dbool --default=3D0 MISSING >actual &&
    test_cmp expect actual &&

