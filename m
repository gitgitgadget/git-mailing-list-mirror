Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96B8C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 12:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233554AbiKKMkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 07:40:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233466AbiKKMj4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 07:39:56 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47AED7B223
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 04:39:55 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id a13so7520001edj.0
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 04:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kTVGJ0jwgzI/wPSjqflfb/ACoEqw18gCsXrNuvvBBNA=;
        b=W3H1cg9FigLVSqJbHsU2HpyGQEmEXoN63oKttZ9T9ulbjGzDGtS9JPAEt7GFXzgWkU
         cIPgQUZNzr2dTesl30TJUAINVJzojNVB5Pwu9ao+w7ZH3zxhF3HxdzbP/LVNYC426VN4
         1ISSczKFj5aaw4U7+yVZcxq5mSHU6kX4yUoCwkVYQKIYC/LUxMOkFEWyqGIcjPX6gbib
         xK4HmgrlE6SOKZsNDphk7vEhwSNmErdlrZqOD/O0XidHhEjhIiZ1j5bpELR6NGiB+wI3
         JMWpO6cDzBJ9sXQ9ePDe2nCi4Mg6wXy8Shc9ay5qDv9mphUEXP0XqQbg69SMKZs/QKwf
         9FyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kTVGJ0jwgzI/wPSjqflfb/ACoEqw18gCsXrNuvvBBNA=;
        b=iSexmwEXYb6dn2kiTBwmBwFYbSP8T5ezbwCKqyyibstVll0XXnh5Lw4Xlw0QD6FDr9
         F7Pne3v/hDVXJ5j/AnX8gkzxSLfbIDgVcf8EqGa8ICdpUEVNZkCUsxc37x2OC5NIda1E
         CdfqXbs1zLfIgsAyhBqWfIdb2ioOMJ3ISbp/muM1tCsbKygxa/IWArai9yKhqwc0OSYi
         CHq/CoVoS1832AqqpqyHFcYHT2W8z3bec+0HEWBOuEmetmttl/1tteP87gZPpfn4OpiG
         Vg6P/5BlT4Tp9aMz8TF48OFbbhF4c+8QGbZdbA1DqoPWvyr4Sk9QnijlMb9oGzQjeGk9
         oE/g==
X-Gm-Message-State: ANoB5pkrNssYqs7AvOpEmXujE3r2iwCujbt8X0E5EN0rr4tsRHT1s5/o
        4lnP7w2SuFpMdPt0XJuNY4wcfmxEBTBMhw==
X-Google-Smtp-Source: AA0mqf7/YqXjPt5bHECnKgNlH+xgRAtcZXrtKoE+HQS/gTRqpFEXiC7lrozAlBH8jDDKa2KRrBbzXA==
X-Received: by 2002:a05:6402:22f8:b0:461:60e8:7ac3 with SMTP id dn24-20020a05640222f800b0046160e87ac3mr1266389edb.80.1668170393654;
        Fri, 11 Nov 2022 04:39:53 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id w2-20020aa7d282000000b00461c6e8453dsm1054222edq.23.2022.11.11.04.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 04:39:53 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1otTK4-001rqV-1K;
        Fri, 11 Nov 2022 13:39:52 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Date:   Fri, 11 Nov 2022 13:32:54 +0100
References: <cover.1667561761.git.congdanhqx@gmail.com>
 <cover.1668097286.git.congdanhqx@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <cover.1668097286.git.congdanhqx@gmail.com>
Message-ID: <221111.86v8nloeav.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 10 2022, =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:

> Despite this series has been merged into next.
> I'm sending this because Taylor said he wanted a (combined) reroll?
> <Y2riRSL+NprJt278@nand.local>

Since Taylor hasn't chimed in: I think that "combined reroll" was
referring to whether we could combine the version I sent out, and the
one you sent out.

I think we should (obviously) go for your version, and thanks for
picking this up and running with it. But at the time in that "What's
Cooking" the branch name was "dd/git-bisect-builtin" (i.e. your
version), but the note was still saying the source was
"<cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>" (i.e. my
version).

In any case, the patches you're re-rolling in this 1-3 are already in
next, so a "what it would have looked like" isn't going to be useful to
apply at this point. So I think just...

> Range-diff against v2:
> -:  ---------- > 1:  6b80fd9398 bisect--helper: remove unused options
> 1:  9d8a3cdd7a ! 2:  248ed392ea bisect--helper: move all subcommands into=
 their own functions
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__terms(int argc, const char **argv, const cha=
r *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	if (argc > 1)
>      +		return error(_("--bisect-terms requires 0 or 1 argument"));
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__start(int argc, const char **argv, const cha=
r *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	set_terms(&terms, "bad", "good");
>      +	res =3D bisect_start(&terms, argv, argc);
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__next(int argc, const char **argv UNUSED, con=
st char *prefix)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	if (argc)
>      +		return error(_("--bisect-next requires 0 arguments"));
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__state(int argc, const char **argv, const cha=
r *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	set_terms(&terms, "bad", "good");
>      +	get_terms(&terms);
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__replay(int argc, const char **argv, const ch=
ar *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	if (argc !=3D 1)
>      +		return error(_("no logfile given"));
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__skip(int argc, const char **argv, const char=
 *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	set_terms(&terms, "bad", "good");
>      +	get_terms(&terms);
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__visualize(int argc, const char **argv, const=
 char *prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	get_terms(&terms);
>      +	res =3D bisect_visualize(&terms, argv, argc);
>     @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_term=
s *terms, cons
>      +static int cmd_bisect__run(int argc, const char **argv, const char =
*prefix UNUSED)
>      +{
>      +	int res;
>     -+	struct bisect_terms terms =3D { .term_good =3D NULL, .term_bad =3D=
 NULL };
>     ++	struct bisect_terms terms =3D { 0 };
>      +
>      +	if (!argc)
>      +		return error(_("bisect run failed: no command provided."));

...a stand-alone two-patch series with these (and possibly tying any
other loose ends) would be nice, I think (but haven't looked carefully)
that it could probably be done in such a way that it applies
concurrently with the migration to builtin/bisect.c, i.e. to the extent
that the hunks don't conflict textually or semantically.
