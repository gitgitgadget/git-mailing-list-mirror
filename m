Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B149CECAAA1
	for <git@archiver.kernel.org>; Thu, 27 Oct 2022 21:29:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236898AbiJ0V3z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Oct 2022 17:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236903AbiJ0V3v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2022 17:29:51 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834222559B
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 14:29:47 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id n12so8314445eja.11
        for <git@vger.kernel.org>; Thu, 27 Oct 2022 14:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TxCNAscJaIxv9TXsbeAlZvWgXT1N+Rw5HCxEcGqnq4Y=;
        b=Fhpb2AbEQlic6Kwdpj2Ui+wPQezqCFueIgGzYQz7CDVdfapEb1GKGPD796VFp4Vaox
         bhkp3A6+ZrsBoXLFW4I7X4F7xJJb3bRW1jRWnEtTvNwLp/GyiwiSPB4mUzNhErHnW/xt
         ANFWl5uT37M71q+tVwtermZb+CjBS9g4/nh07zlTO672xdJMyFnPkGt3a99Nw2x2O88N
         LTMVr/8tmXedJeE28byYm86Q0lYDYlQjEMVohDnnkmh846VnWlBnGei0ezju2/tKTXAN
         49dZvImeRVFWzUAGz4i4kVYEgB7PXl+ZlUlfvwoQNbYSLjPe9xidyTHFMVrEP0aryAlf
         qP3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TxCNAscJaIxv9TXsbeAlZvWgXT1N+Rw5HCxEcGqnq4Y=;
        b=eA9qDz0EeiHmL35tPP6ByEQQtB7sLLK1I8tt1g+2ApuCo67jxr0KA4FLDaC2lx7OVq
         UuNEdBS48naU30W2M00c9tmzdOFI+lP66lLNfxLzJ0KiPF8c/ji0gEqlDV/JsdDuK0tq
         PaSdVJGSEOogUAYoBWzkzsgpEtu7ADVv33qzk/cnlxQRtWEfEZ0Mxwj4N8TfhVsKxCnT
         1Af5sKj1+xp7SBfODKE9ItrkQC6GLeafUYIklfAGPfQGejWOsVTp+yNyU+RVEVC9LlUi
         4ElIoHvb1V8MUygAndT51cvaJxQsjqhjEzBCbR/e+dNyb1cavhPJRBFFrWOb0fp09rn2
         u6Zg==
X-Gm-Message-State: ACrzQf16lnnjI7jQs/l5zO6YN4MRZKXKCv8G6ZOHyudfHCJnGfk4ehw7
        YUnzL2155vVB5sJXLd5KpU4=
X-Google-Smtp-Source: AMsMyM7UADt1WgOi+KLtf+y7BS3kxPGTh+EEW6RJsBiK27WWX6KhMJcPF5ejkoqojwDQmOtLML0k/Q==
X-Received: by 2002:a17:907:2bf9:b0:7a4:bbce:dd98 with SMTP id gv57-20020a1709072bf900b007a4bbcedd98mr24200051ejc.669.1666906185901;
        Thu, 27 Oct 2022 14:29:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c9-20020a17090618a900b0073ddff7e432sm1314381ejf.14.2022.10.27.14.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Oct 2022 14:29:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ooARc-009bfZ-0M;
        Thu, 27 Oct 2022 23:29:44 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/8] use child_process member "args" instead of string
 array variable
Date:   Thu, 27 Oct 2022 23:09:46 +0200
References: <7407e074-4bd8-b351-7fa4-baf59b41880c@web.de>
 <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <0e889c96-6004-96e4-9505-19ce1e7f9900@web.de>
Message-ID: <221027.86zgdh9cqg.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Oct 27 2022, Ren=C3=A9 Scharfe wrote:

> @@ -729,20 +727,22 @@ static int is_expected_rev(const struct object_id *=
oid)
>  enum bisect_error bisect_checkout(const struct object_id *bisect_rev,
>  				  int no_checkout)
>  {
> -	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
>  	struct commit *commit;
>  	struct pretty_print_context pp =3D {0};
>  	struct strbuf commit_msg =3D STRBUF_INIT;
>
> -	oid_to_hex_r(bisect_rev_hex, bisect_rev);
>  	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REF=
S_DIE_ON_ERR);
>
> -	argv_checkout[2] =3D bisect_rev_hex;
>  	if (no_checkout) {
>  		update_ref(NULL, "BISECT_HEAD", bisect_rev, NULL, 0,
>  			   UPDATE_REFS_DIE_ON_ERR);
>  	} else {
> -		if (run_command_v_opt(argv_checkout, RUN_GIT_CMD))
> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +		cmd.git_cmd =3D 1;
> +		strvec_pushl(&cmd.args, "checkout", "-q",
> +			     oid_to_hex(bisect_rev), "--", NULL);
> +		if (run_command(&cmd))
>  			/*
>  			 * Errors in `run_command()` itself, signaled by res < 0,
>  			 * and errors in the child process, signaled by res > 0

Perhaps I went overboard with it in my version, but it's probably worth
mentioning when converting some of these that the reason for the
pre-image of some is really not like the others.

Now that we're on C99 it perhaps make s no difference, but the pre-image
here is explicitly trying to avoid dynamic initializer elements, per
442c27dde78 (CodingGuidelines: mention dynamic C99 initializer elements,
2022-10-10).

Well, partially, some of it appears to just be based on a
misunderstanding of how our own APIs work, i.e. the use of
oid_to_hex_r() over oid_to_hex().

> diff --git a/builtin/am.c b/builtin/am.c
> index 39fea24833..20aea0d248 100644
> --- a/builtin/am.c
> +++ b/builtin/am.c
> @@ -2187,14 +2187,12 @@ static int show_patch(struct am_state *state, enu=
m show_patch_type sub_mode)
>  	int len;
>
>  	if (!is_null_oid(&state->orig_commit)) {
> -		const char *av[4] =3D { "show", NULL, "--", NULL };
> -		char *new_oid_str;
> -		int ret;
> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
>
> -		av[1] =3D new_oid_str =3D xstrdup(oid_to_hex(&state->orig_commit));
> -		ret =3D run_command_v_opt(av, RUN_GIT_CMD);
> -		free(new_oid_str);
> -		return ret;
> +		strvec_pushl(&cmd.args, "show", oid_to_hex(&state->orig_commit),
> +			     "--", NULL);
> +		cmd.git_cmd =3D 1;
> +		return run_command(&cmd);
>  	}

The same goes for this, FWIW I split this one out into its own commit (I
left the earlier one alone):
https://lore.kernel.org/git/patch-v2-04.10-5cfd6a94ce3-20221017T170316Z-ava=
rab@gmail.com/;
It uses the same pattern

> diff --git a/builtin/difftool.c b/builtin/difftool.c
> index 4b10ad1a36..22bcc3444b 100644
> --- a/builtin/difftool.c
> +++ b/builtin/difftool.c
> @@ -360,8 +360,8 @@ static int run_dir_diff(const char *extcmd, int symli=
nks, const char *prefix,
>  	struct pair_entry *entry;
>  	struct index_state wtindex;
>  	struct checkout lstate, rstate;
> -	int flags =3D RUN_GIT_CMD, err =3D 0;
> -	const char *helper_argv[] =3D { "difftool--helper", NULL, NULL, NULL };
> +	int err =3D 0;
> +	struct child_process cmd =3D CHILD_PROCESS_INIT;

In general, I like the disection of this series, but with this...

>  	struct hashmap wt_modified, tmp_modified;
>  	int indices_loaded =3D 0;
>
> @@ -563,16 +563,17 @@ static int run_dir_diff(const char *extcmd, int sym=
links, const char *prefix,
>  	}
>
>  	strbuf_setlen(&ldir, ldir_len);
> -	helper_argv[1] =3D ldir.buf;
>  	strbuf_setlen(&rdir, rdir_len);
> -	helper_argv[2] =3D rdir.buf;
>
>  	if (extcmd) {
> -		helper_argv[0] =3D extcmd;
> -		flags =3D 0;
> -	} else
> +		strvec_push(&cmd.args, extcmd);
> +	} else {
> +		strvec_push(&cmd.args, "difftool--helper");
> +		cmd.git_cmd =3D 1;

...and the frequent occurance of just e.g. "cmd.git_cmd =3D 1" and nothing
else I'm wondering if we're not throwing the baby out with the bath
water in having no convenience wrappers or macros at all.

A lot of your 3-lines would be 1 lines if we just had e.g. (untested,
and could be a function not a macro, but you get the idea):

	#define run_command_git_simple(__VA_ARGS__) \
		struct child_process cmd =3D CHILD_PROCESS_INIT; \
		cmd.git_cmd =3D 1; \
		strvec_pushl(&cmd.args, __VA_ARGS__); \
		run_command(&cmd);

But maybe nobody except me thinks that's worthwhile...

>  static void read_empty(const struct object_id *oid)
>  {
> -	int i =3D 0;
> -	const char *args[7];
> -
> -	args[i++] =3D "read-tree";
> -	args[i++] =3D "-m";
> -	args[i++] =3D "-u";
> -	args[i++] =3D empty_tree_oid_hex();
> -	args[i++] =3D oid_to_hex(oid);
> -	args[i] =3D NULL;
> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +	strvec_pushl(&cmd.args, "read-tree", "-m", "-u", empty_tree_oid_hex(),
> +		     oid_to_hex(oid), NULL);
> +	cmd.git_cmd =3D 1;
>
> -	if (run_command_v_opt(args, RUN_GIT_CMD))
> +	if (run_command(&cmd))
>  		die(_("read-tree failed"));
>  }
>
>  static void reset_hard(const struct object_id *oid)
>  {
> -	int i =3D 0;
> -	const char *args[6];
> -
> -	args[i++] =3D "read-tree";
> -	args[i++] =3D "-v";
> -	args[i++] =3D "--reset";
> -	args[i++] =3D "-u";
> -	args[i++] =3D oid_to_hex(oid);
> -	args[i] =3D NULL;
> +	struct child_process cmd =3D CHILD_PROCESS_INIT;
> +
> +	strvec_pushl(&cmd.args, "read-tree", "-v", "--reset", "-u",
> +		     oid_to_hex(oid), NULL);
> +	cmd.git_cmd =3D 1;
>
> -	if (run_command_v_opt(args, RUN_GIT_CMD))
> +	if (run_command(&cmd))
>  		die(_("read-tree failed"));
>  }

Two perfect examples, e.g. the former would just be:

	if (run_command_git_simple("read-tree", "-m", "-u", empty_tree_oid_hex(),
				   oid_to_hex(oid), NULL))
		die(...);
