Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DC5FC433EF
	for <git@archiver.kernel.org>; Mon, 20 Dec 2021 16:00:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234155AbhLTQA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Dec 2021 11:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhLTQAz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Dec 2021 11:00:55 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0361C061574
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:00:55 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id p19so10131330qtw.12
        for <git@vger.kernel.org>; Mon, 20 Dec 2021 08:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gitlab.com; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ABZR7NPEP6lBvQdWaAecsQT3Er7ZACEsTKvZ+LwSi58=;
        b=B/NT1FESOwYT6YhAJm/gVfBkw+jTCr4wp6YnhzLiK1GBCak0TsJn02Nk0Wleff82cb
         +iw/eT8WzvRaGStgEM04sgozl/z+Y4xINJTCg1dTW6UEHx81y7qINt2y8NDDeuVxWxNI
         WTp7xevjh790GBQWPQyZBp0yvtXnzm3UaTjlE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=ABZR7NPEP6lBvQdWaAecsQT3Er7ZACEsTKvZ+LwSi58=;
        b=LPK2j21G8OPsWCyAqRgIlxCo/p0IR77BIvsp/VOadR6QdAixoJWxSq5A+WDL86MkPc
         79qoy9e0+cafSM1Oqw8Hc6A5AGZRinXktvxS65mdE/y/hRtxvrFSWcId0dunUnrP18NJ
         HcAlb6Nmm7zf4Fd+bz03FCwh0IiwW5fmsFygHJRXNM1yp+hEsMBrIZZ6UIwvoLbOxpJV
         rN81dYgAB2/5oFyVBYURBlJP+RSug/RyD/KBgBDX+TGWUIk3UIOrs5M+80KjntNCwz5d
         YrleaEgd8jLpWQpFhVlWvgR4994nF1b36PGfPKfpF2+AJTxBXMnPaSb+nehlP3yvyg7V
         v38w==
X-Gm-Message-State: AOAM531W84nnZDOsp+sjn9XgZ6D4nXdXebekkbOv0iwgsI9SZoC0GxkO
        EiGxAxKY+HLHyhT6u9LqHUWHTQ==
X-Google-Smtp-Source: ABdhPJzBVYqaGFQzg3qqHY1x0o1AHG49j1g0khkuap2iqCOeH3Nvw3+9vTkor0Q+gOLB7TFW+DrjBw==
X-Received: by 2002:ac8:5710:: with SMTP id 16mr13105810qtw.140.1640016053091;
        Mon, 20 Dec 2021 08:00:53 -0800 (PST)
Received: from smtpclient.apple (pool-108-35-55-112.nwrknj.fios.verizon.net. [108.35.55.112])
        by smtp.gmail.com with ESMTPSA id w10sm15634916qtj.37.2021.12.20.08.00.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Dec 2021 08:00:52 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.20.0.1.32\))
Subject: Re: [PATCH v4 07/10] cat-file: fix remaining usage bugs
From:   John Cai <jcai@gitlab.com>
In-Reply-To: <patch-v4-07.10-878d9052bfb-20211208T123151Z-avarab@gmail.com>
Date:   Mon, 20 Dec 2021 11:00:51 -0500
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <1A123F48-C834-4635-86C5-04B11733DC8A@gitlab.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
 <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
 <patch-v4-07.10-878d9052bfb-20211208T123151Z-avarab@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3693.20.0.1.32)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On Dec 8, 2021, at 7:34 AM, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
> With the migration of --batch-all-objects to OPT_CMDMODE() in the
> preceding commit one bug with combining it and other OPT_CMDMODE()
> options was solved, but we were still left with e.g. --buffer silently
> being discarded when not in batch mode.
>=20
> Fix all those bugs, and in addition emit errors telling the user
> specifically what options can't be combined with what other options,
> before this we'd usually just emit the cryptic usage text and leave
> the users to work it out by themselves.
>=20
> This change is rather large, because to do so we need to untangle the
> options processing so that we can not only error out, but emit
> sensible errors, and e.g. emit errors about options before errors
> about stray argc elements (as they might become valid if the option
> were removed).
>=20
> Some of the output changes ("error:" to "fatal:" with
> usage_msg_opt[f]()), but none of the exit codes change, except in
> those cases where we silently accepted bad option combinations before,
> now we'll error out.
>=20
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com>
> ---
> builtin/cat-file.c  | 95 ++++++++++++++++++++++++++++++---------------
> t/t1006-cat-file.sh | 41 +++++++++----------
> 2 files changed, 84 insertions(+), 52 deletions(-)
>=20
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 87356208134..1087f0f4a85 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -648,6 +648,8 @@ static int batch_option_callback(const struct =
option *opt,
> int cmd_cat_file(int argc, const char **argv, const char *prefix)
> {
> 	int opt =3D 0;
> +	int opt_cw =3D 0;
> +	int opt_epts =3D 0;
> 	const char *exp_type =3D NULL, *obj_name =3D NULL;
> 	struct batch_options batch =3D {0};
> 	int unknown_type =3D 0;
> @@ -701,45 +703,74 @@ int cmd_cat_file(int argc, const char **argv, =
const char *prefix)
> 	batch.buffer_output =3D -1;
>=20
> 	argc =3D parse_options(argc, argv, prefix, options, usage, 0);
> -	if (argc && batch.enabled)
> -		usage_with_options(usage, options);
> -	if (opt =3D=3D 'b') {
> -		batch.all_objects =3D 1;
> -	} else if (opt) {
> -		if (batch.enabled && (opt =3D=3D 'c' || opt =3D=3D 'w'))
> -			batch.cmdmode =3D opt;
> -		else if (argc =3D=3D 1)
> -			obj_name =3D argv[0];
> -		else
> -			usage_with_options(usage, options);
> -	} else if (!opt && !batch.enabled) {
> -		if (argc =3D=3D 2) {
> -			exp_type =3D argv[0];
> -			obj_name =3D argv[1];
> -		} else
> -			usage_with_options(usage, options);
> -	} else if (batch.enabled && batch.cmdmode !=3D opt)
> -		usage_with_options(usage, options);
> +	opt_cw =3D (opt =3D=3D 'c' || opt =3D=3D 'w');
> +	opt_epts =3D (opt =3D=3D 'e' || opt =3D=3D 'p' || opt =3D=3D 't' =
|| opt =3D=3D 's');
>=20
> -	if ((batch.follow_symlinks || batch.all_objects) && =
!batch.enabled) {
> -		usage_with_options(usage, options);
> -	}
> -
> -	if (force_path && opt !=3D 'c' && opt !=3D 'w') {
> -		error("--path=3D<path> needs --textconv or --filters");
> -		usage_with_options(usage, options);
> -	}
> +	/* --batch-all-objects? */
> +	if (opt =3D=3D 'b')
> +		batch.all_objects =3D 1;
>=20
> -	if (force_path && batch.enabled) {
> -		error("--path=3D<path> incompatible with --batch");
> -		usage_with_options(usage, options);
> -	}
> +	/* Option compatibility */
> +	if (force_path && !opt_cw)
> +		usage_msg_optf(_("'%s=3D<%s>' needs '%s' or '%s'"),
> +			       usage, options,
> +			       "--path", _("path|tree-ish"), =
"--filters",
> +			       "--textconv");
>=20
> +	/* Option compatibility with batch mode */
> +	if (batch.enabled)
> +		;
> +	else if (batch.follow_symlinks)
> +		usage_msg_optf(_("'%s' requires a batch mode"), usage, =
options,
> +			       "--follow_symlinks");
> +	else if (batch.buffer_output >=3D 0)
> +		usage_msg_optf(_("'%s' requires a batch mode"), usage, =
options,
> +			       "--buffer");
> +	else if (batch.all_objects)
> +		usage_msg_optf(_("'%s' requires a batch mode"), usage, =
options,
> +			       "--batch-all_objects");

s/_/- for the last argument in the above usage_msg_optf calls

> +
> +	/* Batch defaults */
> 	if (batch.buffer_output < 0)
> 		batch.buffer_output =3D batch.all_objects;
>=20
> -	if (batch.enabled)
> +	/* Return early if we're in batch mode? */
> +	if (batch.enabled) {
> +		if (opt_cw)
> +			batch.cmdmode =3D opt;
> +		else if (opt && opt !=3D 'b')
> +			usage_msg_optf(_("'-%c' is incompatible with =
batch mode"),
> +				       usage, options, opt);
> +		else if (argc)
> +			usage_msg_opt(_("batch modes take no =
arguments"), usage,
> +				      options);
> +
> 		return batch_objects(&batch);
> +	}
> +
> +	if (opt) {
> +		if (!argc && opt =3D=3D 'c')
> +			usage_msg_optf(_("<rev> required with '%s'"),
> +				       usage, options, "--textconv");
> +		else if (!argc && opt =3D=3D 'w')
> +			usage_msg_optf(_("<rev> required with '%s'"),
> +				       usage, options, "--filters");
> +		else if (!argc && opt_epts)
> +			usage_msg_optf(_("<object> required with =
'-%c'"),
> +				       usage, options, opt);
> +		else if (argc =3D=3D 1)
> +			obj_name =3D argv[0];
> +		else
> +			usage_msg_opt(_("too many arguments"), usage, =
options);
> +	} else if (!argc) {
> +		usage_with_options(usage, options);
> +	} else if (argc !=3D 2) {
> +		usage_msg_optf(_("only two arguments allowed in <type> =
<object> mode, not %d"),
> +			      usage, options, argc);
> +	} else if (argc) {
> +		exp_type =3D argv[0];
> +		obj_name =3D argv[1];
> +	}
>=20
> 	if (unknown_type && opt !=3D 't' && opt !=3D 's')
> 		die("git cat-file --allow-unknown-type: use with -s or =
-t");
> diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
> index ebec2061d25..123801cfe2a 100755
> --- a/t/t1006-cat-file.sh
> +++ b/t/t1006-cat-file.sh
> @@ -24,7 +24,7 @@ done
>=20
> test_incompatible_usage () {
> 	test_expect_code 129 "$@" 2>err &&
> -	grep -E "^error:.**needs" err
> +	grep -E "^(fatal|error):.*(requires|incompatible with|needs)" =
err
> }
>=20
> for opt in --batch --batch-check
> @@ -34,48 +34,54 @@ do
> 	'
> done
>=20
> +test_missing_usage() {
> +	test_expect_code 129 "$@" 2>err &&
> +	grep -E "^fatal:.*required" err
> +}
> +
> short_modes=3D"-e -p -t -s"
> cw_modes=3D"--textconv --filters"
>=20
> for opt in $cw_modes
> do
> 	test_expect_success "usage: $opt requires another option" '
> -		test_expect_code 129 git cat-file $opt
> +		test_missing_usage git cat-file $opt
> 	'
> done
>=20
> for opt in $short_modes
> do
> 	test_expect_success "usage: $opt requires another option" '
> -		test_expect_code 129 git cat-file $opt
> +		test_missing_usage git cat-file $opt
> 	'
>=20
> 	for opt2 in --batch \
> 		--batch-check \
> -		--follow-symlinks
> +		--follow-symlinks \
> +		"--path=3Dfoo HEAD:some-path.txt"
> 	do
> -		test_expect_failure "usage: incompatible options: $opt =
and $opt2" '
> +		test_expect_success "usage: incompatible options: $opt =
and $opt2" '
> 			test_incompatible_usage git cat-file $opt $opt2
> 		'
> 	done
> -
> -	opt2=3D"--path=3Dfoo HEAD:some-path.txt"
> -	test_expect_success "usage: incompatible options: $opt and =
$opt2" '
> -		test_incompatible_usage git cat-file $opt $opt2
> -	'
> done
>=20
> +test_too_many_arguments() {
> +	test_expect_code 129 "$@" 2>err &&
> +	grep -E "^fatal: too many arguments$" err
> +}
> +
> for opt in $short_modes $cw_modes
> do
> 	args=3D"one two three"
> 	test_expect_success "usage: too many arguments: $opt $args" '
> -		test_expect_code 129 git cat-file $opt $args
> +		test_too_many_arguments git cat-file $opt $args
> 	'
>=20
> 	for opt2 in --buffer --follow-symlinks
> 	do
> 		test_expect_success "usage: incompatible arguments: $opt =
with batch option $opt2" '
> -			test_expect_code 129 git cat-file $opt $opt2
> +			test_incompatible_usage git cat-file $opt $opt2
> 		'
> 	done
> done
> @@ -84,14 +90,9 @@ for opt in --buffer \
> 	--follow-symlinks \
> 	--batch-all-objects
> do
> -	status=3Dsuccess
> -	if test $opt =3D "--buffer"
> -	then
> -		status=3Dfailure
> -	fi
> -	test_expect_$status "usage: bad option combination: $opt without =
batch mode" '
> -		test_expect_code 129 git cat-file $opt &&
> -		test_expect_code 129 git cat-file $opt commit HEAD
> +	test_expect_success "usage: bad option combination: $opt without =
batch mode" '
> +		test_incompatible_usage git cat-file $opt &&
> +		test_incompatible_usage git cat-file $opt commit HEAD
> 	'
> done
>=20
> --=20
> 2.34.1.926.g895e15e0c0c
>=20

