Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FE58C11F67
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F26AB6192F
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 18:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhF2SDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 14:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbhF2SDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 14:03:32 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C612EC061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:01:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id nd37so37840891ejc.3
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 11:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=+tT/eG+Qt8OetWRripQd+GdeBm9SdOpt0vs2yiela/0=;
        b=aA3r3p2NtOa5hF7lsgt9WI3zUQ9VONgdIJ8GhD13g2ksQnboIvL0iJXg8XOWR5PoKI
         Uzpe3mwNc3o/tFFP7eJsWKwBEs7u+RRIerk5jYWrxZbh10c99UagpSTLI61BJqQ5BGYD
         jYMHleAr3ufosM3mY75JqcXeHxVZkJj4F9LTJxFpJ679KN4Gk4XzrfTqQF2QJWMs3i48
         d+b5xCYSHW2nZhimE0o2AwHVdYxlyIalu3erQFlciYI5agvM3xQpo7h2DbRbTEvj228j
         O108saK12HSTZopNIYSEROP2WjVWd83IeRv9qsoEZklYhMi8ql5cgwNm8gyUtYhrdyPI
         LArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=+tT/eG+Qt8OetWRripQd+GdeBm9SdOpt0vs2yiela/0=;
        b=aczHBDaM18DMnpEmuxw2FbRko4e2EZUEMuSL4DaS4ueX8XwSVU2lQuGrkTkqWw26fY
         uiNCbIsCOBCVj21ya14gLtkzc51wgcp45yom59T/7sYM7Hzwq/XjFlsDPNu7FHcGJpYS
         PQW7a09ZnGNaofMjawGwPNODTWNRoNpOyrNdDhi6seJqK3NCWPy1kp9yTLn+1qCH4Uv7
         v75UffPZ11k5rxDUzmDaI4LJSGxi8lA1QH5+5Jsi/pojKzxOtK0D30bJtXreBRC0o0Jd
         EzLfJoS0ad/Or/KjRAlDieAjYAe38BYz16Vz3Ur/IC/GkOcqu/DDxk9Mcx5XUUbKMD/s
         GthQ==
X-Gm-Message-State: AOAM5305mEwy+r7SrlVVvM6XiIlMCHlEl+KhTYob8JkU2UQUOcDYdeS1
        umTLMK/hRfkctYqaGv5sHIEMqFRjKr70TQ==
X-Google-Smtp-Source: ABdhPJwv0zRKVCtl8ybm2RIpgLWOGZbJ4sCXIExv1JREroILqw9y1wm97C+hm7+3FxZCG+q2zpUZyQ==
X-Received: by 2002:a17:906:29c7:: with SMTP id y7mr24387224eje.404.1624989662222;
        Tue, 29 Jun 2021 11:01:02 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id em20sm8659437ejc.70.2021.06.29.11.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 11:01:01 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Matthew Hughes <matthewhughes934@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: report missing left operand of --and
Date:   Tue, 29 Jun 2021 19:52:19 +0200
References: <20210628121748.f3yrc72v4mynknl3@debianXPS.lan>
 <98171911-ba39-27f1-d068-4d381bcd4804@web.de>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <98171911-ba39-27f1-d068-4d381bcd4804@web.de>
Message-ID: <87im1wft42.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 28 2021, Ren=C3=A9 Scharfe wrote:

> Git grep allows combining two patterns with --and.  It checks and
> reports if the second pattern is missing when compiling the expression.
> A missing first pattern, however, is only reported later at match time.
> Thus no error is returned if no matching is done, e.g. because no file
> matches the also given pathspec.
>
> When that happens we get an expression tree with an GREP_NODE_AND node
> and a NULL pointer to the missing left child.  free_pattern_expr()
> tries to dereference it during the cleanup at the end, which result in
> a segmentation fault.
>
> Fix this by verifying the presence of the left operand at expression
> compilation time.
>
> Reported-by: Matthew Hughes <matthewhughes934@gmail.com>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
> Whether the check in match_expr_eval() can now be turned into a BUG is
> left as an exercise for the reader. ;-)
>
>  grep.c          |  2 ++
>  t/t7810-grep.sh | 10 ++++++++++
>  2 files changed, 12 insertions(+)
>
> diff --git a/grep.c b/grep.c
> index 8f91af1cb0..7d0ea4e956 100644
> --- a/grep.c
> +++ b/grep.c
> @@ -655,6 +655,8 @@ static struct grep_expr *compile_pattern_and(struct g=
rep_pat **list)
>  	struct grep_expr *x, *y, *z;
>
>  	x =3D compile_pattern_not(list);
> +	if (!x)
> +		die("Not a valid grep expression");
>  	p =3D *list;
>  	if (p && p->token =3D=3D GREP_AND) {
>  		if (!p->next)
> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 5830733f3d..c581239674 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -11,6 +11,13 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>
>  . ./test-lib.sh
>
> +test_invalid_grep_expression() {
> +	params=3D"$@" &&
> +	test_expect_success "invalid expression: grep $params" '
> +		test_must_fail git grep $params -- nonexisting
> +	'
> +}
> +
>  cat >hello.c <<EOF
>  #include <assert.h>
>  #include <stdio.h>
> @@ -89,6 +96,9 @@ test_expect_success 'grep should not segfault with a ba=
d input' '
>  	test_must_fail git grep "("
>  '
>
> +test_invalid_grep_expression -e A --and
> +test_invalid_grep_expression --and -e A
> +
>  for H in HEAD ''
>  do
>  	case "$H" in

This seems like an incomplete fix, for the exact same thing with --or we
silently return 1, as we would if we exited early in free_pattern_expr
on !x, which aside from the segfault I think we should probably make a
habit in our own free()-like functions.

Whatever we're doing about the --and segfault it seems like we should do
the same under --or, no?

Your first test also passes before your fix, it's only the latter that
segfaults. The first one emits:

    fatal: --and not followed by pattern expression

So having that in a leading patch to indicate no behavior was changed
would be better.

Instead of the "Not a valid grep expression" error let's instead say
something like:

    fatal: --[and|or] must follow a pattern expression

The error (which I know you just copied from elsewhere) is misleading,
it's not the pattern that's not valid (as to me it implies), but our own
--and/--or option usage.

And the "excercise for the reader" is a bit flippant, do we actually hit
that condition now? If not and we're sure we won't now seems like the
time to add a BUG() there, and to change the "Not a valid grep
expression" to "internal error in --and/--or parsing" or something.

Thanks for the patch!
