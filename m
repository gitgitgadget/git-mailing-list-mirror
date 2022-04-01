Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F1D7C433EF
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 10:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343725AbiDAKcm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 06:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232034AbiDAKcl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 06:32:41 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E463158DB8
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 03:30:52 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bg10so4928669ejb.4
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 03:30:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=DGw7q90oCnZyNcxj5QFdxbr1DZqxCBRZAKGzRRiI1J4=;
        b=ORuZpCBfW3ZAL/em81q/eehs22+3dcx+p6otWdGG63LCcmuka80gD72ONFop2ex44q
         spoA84I3QREr91zaf/CB/+9Tf4C07q7PmUZp1vSiKFxIJojuHTMcxAcbeHLLzuu96RVJ
         +LHKi1EXBDoHPq+ykiHtupLFMR3EnTJxHLJc/p4dbJgexP9Cxit80MRjG9INxRZWHVM6
         1KIGM7jmxdURZAvzDd+RSZzPM2RbJ1qf4BY3QVNfMCkZwcaH2IKtNi6HyZdpl0JmcdHa
         fTJjFHd4Y3prfZplIAivNrnUEs247xMsObTB2dLkLWbeTKII1lJXEPZgh8PCiQYHvpdV
         gUpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=DGw7q90oCnZyNcxj5QFdxbr1DZqxCBRZAKGzRRiI1J4=;
        b=cctRsyHjGfYxRICDU9qaZO4Kt8ntHRQoHwvx9KA7U5zVHLXXJcBodYpMtGuvza3jxt
         DLJ01zxfKp5+HuhUKYaPQ3dmeHB987fqIL5wfVry3KH+kycaQ14xjDRHGrThUAMnLwSW
         XtLtLd9n7ea2F4wFH3ioKptwkEKTr+mpo+TWJStLRhM3A36uua5SClDdoL3tWAPcaUg0
         6cLNxzqOaV+s6KKPykdbfyv4+tFX7hOX8KP6kDfyggTolUXe9NB+3n0Y3ud4djPu3r64
         hjFAkTcuScU5TZZNSJad7oVLAWm86ibPnvPwtAYSscwMY7AiAGKXMw/1+dYlZ/f7gRc4
         Zd3w==
X-Gm-Message-State: AOAM530lxFkUmnZtEyF/3j9ViDWHT0JXEMWoX3WlpK7CGMIv6My7bBkz
        f3mP5BghbmSMsC8xjrgbjg8=
X-Google-Smtp-Source: ABdhPJzVCuCe0PTgFS3INPZlc3bdPEukPHfcACCJoFp2w+/G1zySHTLQQ7yp+J/Fn4E/ze47j2boAA==
X-Received: by 2002:a17:907:3d87:b0:6e0:bef:c3cb with SMTP id he7-20020a1709073d8700b006e00befc3cbmr8755144ejc.503.1648809050799;
        Fri, 01 Apr 2022 03:30:50 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id gn33-20020a1709070d2100b006dfcce8be86sm861605ejc.225.2022.04.01.03.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 03:30:50 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naEYL-0011f6-Q9;
        Fri, 01 Apr 2022 12:30:49 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Glen Choo <chooglen@google.com>
Subject: Re: [PATCH 2/2] branch.c: simplify advice-and-die sequence
Date:   Fri, 01 Apr 2022 12:03:03 +0200
References: <xmqq7d89zqys.fsf@gitster.g>
 <20220331224118.3014407-1-gitster@pobox.com>
 <20220331224118.3014407-2-gitster@pobox.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220331224118.3014407-2-gitster@pobox.com>
Message-ID: <220401.86lewpnlie.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Mar 31 2022, Junio C Hamano wrote:

> From: Glen Choo <chooglen@google.com>
>
> In the dwim_branch_start(), when we cannot find an appropriate
> upstream, we will die with the same message anyway, whether we
> issue an advice message.
>
> Flip the code around a bit and simplify the flow using
> advise_if_enabled() function.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Signed-off-by: Glen Choo <chooglen@google.com>
> ---
>  branch.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/branch.c b/branch.c
> index 8ee9f43539..b673143cbe 100644
> --- a/branch.c
> +++ b/branch.c
> @@ -383,13 +383,10 @@ static void dwim_branch_start(struct repository *r,=
 const char *start_name,
>  	real_ref =3D NULL;
>  	if (get_oid_mb(start_name, &oid)) {
>  		if (explicit_tracking) {
> -			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
> -				int code =3D die_message(_(upstream_missing),
> -						       start_name);
> -				advise(_(upstream_advice));
> -				exit(code);
> -			}
> -			die(_(upstream_missing), start_name);
> +			int code =3D die_message(_(upstream_missing), start_name);
> +			advise_if_enabled(ADVICE_SET_UPSTREAM_FAILURE,
> +					  _(upstream_advice));
> +			exit(code);
>  		}
>  		die(_("Not a valid object name: '%s'."), start_name);
>  	}

Looks good, in case you missed it I noted that we could also get extra
help from the compiler by folding the "upstream_missing" variable inline
as an argument to die_message(), likewise for upstream_advice.

I.e. the latter already had only one user, but the former was used in
two places (now one).

That was mainly for getting more compiler aid with format checking,
although the readibility of avoiding the indirection is arguably a good
reason to do it.

But I see from testing just now that I was (mostly) wrong about
that. I.e. if we do:
=09
	diff --git a/branch.c b/branch.c
	index 6b31df539a5..8a704c3ff53 100644
	--- a/branch.c
	+++ b/branch.c
	@@ -339,8 +339,7 @@ static int validate_remote_tracking_branch(char *ref)
=09=20
	 static const char upstream_not_branch[] =3D
	 N_("cannot set up tracking information; starting point '%s' is not a bran=
ch");
	-static const char upstream_missing[] =3D
	-N_("the requested upstream branch '%s' does not exist");
	+static const char upstream_missing[] =3D "blah %s blah %s";
	 static const char upstream_advice[] =3D
	 N_("\n"
	 "If you are planning on basing your work on an upstream\n

Both my local gcc and clang will warn on it. What I was recalling is
that if you try these variants:
=09
	diff --git a/branch.c b/branch.c
	index 6b31df539a5..eea50605c8c 100644
	--- a/branch.c
	+++ b/branch.c
	@@ -339,8 +339,6 @@ static int validate_remote_tracking_branch(char *ref)
=09=20
	 static const char upstream_not_branch[] =3D
	 N_("cannot set up tracking information; starting point '%s' is not a bran=
ch");
	-static const char upstream_missing[] =3D
	-N_("the requested upstream branch '%s' does not exist");
	 static const char upstream_advice[] =3D
	 N_("\n"
	 "If you are planning on basing your work on an upstream\n"
	@@ -384,6 +382,10 @@ static void dwim_branch_start(struct repository *r, c=
onst char *start_name,
=09=20
	 	real_ref =3D NULL;
	 	if (get_oid_mb(start_name, &oid)) {
	+		char *upstream_missing =3D "blah %s blah %s";
	+		const char *upstream_missing =3D "blah %s blah %s";
	+		const char *const upstream_missing =3D "blah %s blah %s";
	+		static const char upstream_missing[] =3D "blah %s blah %s";
	 		if (explicit_tracking) {
	 			if (advice_enabled(ADVICE_SET_UPSTREAM_FAILURE)) {
	 				error(_(upstream_missing), start_name);

My clang version starts warning on the 3rd one (const char *const), but
it takes until the 4th one (static const char ... []) until GCC will
warn on it.

We've had bugs in the past where we passed some variants of that to a
format-expecting function.

So I think that's a good argument for wider use of "const char *const"
in some cases over "const char *" if possible. E.g. if I do this:
=09
	diff --git a/sequencer.c b/sequencer.c
	index a1bb39383db..cd8f59c2a2d 100644
	--- a/sequencer.c
	+++ b/sequencer.c
	@@ -3035,7 +3035,6 @@ static int create_seq_dir(struct repository *r)
	 {
	 	enum replay_action action;
	 	const char *in_progress_error =3D NULL;
	-	const char *in_progress_advice =3D NULL;
	 	unsigned int advise_skip =3D
	 		refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD") ||
	 		refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD");
	@@ -3044,19 +3043,19 @@ static int create_seq_dir(struct repository *r)
	 		switch (action) {
	 		case REPLAY_REVERT:
	 			in_progress_error =3D _("revert is already in progress");
	-			in_progress_advice =3D
	-			_("try \"git revert (--continue | %s--abort | --quit)\"");
	 			break;
	 		case REPLAY_PICK:
	 			in_progress_error =3D _("cherry-pick is already in progress");
	-			in_progress_advice =3D
	-			_("try \"git cherry-pick (--continue | %s--abort | --quit)\"");
	 			break;
	 		default:
	 			BUG("unexpected action in create_seq_dir");
	 		}
	 	}
	 	if (in_progress_error) {
	+		const char *in_progress_advice =3D action =3D=3D REPLAY_REVERT
	+			? _("try \"git cherry-pick (--continue | %s--abort | --quit)\" %s")
	+			: _("try \"git revert (--continue | %s--abort | --quit)\" %s");
	+
	 		error("%s", in_progress_error);
	 		if (advice_enabled(ADVICE_SEQUENCER_IN_USE))
	 			advise(in_progress_advice,

Neither clang nor gcc will detect that I snuck in an extra %s into the
message, which would be a runtime error, but make that "const char
*const" and clang will spot it, but gcc won't.

This was with Debian clang version 13.0.1-3+b2 & gcc (GCC) 12.0.1
20220120 (experimental). I also tested this last one on gcc (Debian
10.2.1-6) 10.2.1 20210110. YMMV.
