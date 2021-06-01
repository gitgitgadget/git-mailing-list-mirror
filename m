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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F1DAC47082
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:01:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FEE260FF2
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 01:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbhFABDT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 21:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhFABDR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 21:03:17 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBB6C061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 18:01:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb17so18956877ejc.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 18:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=x/BqxAGaxzykythAqYTrEwmw+OSzhX6AxMis86t5SS0=;
        b=JtYZU7dy5yKJ+nNmGyAboQ1yn9A+Ny44WaJgvpvTYc1YiP6rmyiUOeTKsie3+u4gWj
         PN/yYKmeXnEVbgD52yBC5bbhKBR6/0Bsh7FxuN2PVmb3jUeNCfLiur34kY1Hj0dc/N74
         yxlTT4lflioNmFAFKYDqJnWSeab7rM5ykTe9/bgpkwB1nHfpMynuENZstfi+UISHbHp+
         gWRajcP4SXeRnMlE9Mj0LvTfgWZI7Zlx2Wq+DOdM/+J7jlBCLrIb4/Pi4He1Jz4oOa27
         KdIiVUnChb6xJdP3fEfofcGUyFOMIGtw82vCwEFTR/e0dASR39R7la1EXP3EYQIAlPNR
         j7qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=x/BqxAGaxzykythAqYTrEwmw+OSzhX6AxMis86t5SS0=;
        b=irEQ3V6gwB+qzRDmyDXqkITtXUIpAgz5xt6XYLrukXTM+vjLk0tvOmIB8ToUX0GD66
         H7AZZSfugFY3EMY4np37dwFkv7qhLn0lH2spfq2BHKMd5Y0ZRzde20wya2kKktcnpqYq
         CWa1UyzCGkACUnb8foVszkWnB5Ytfi+mSJpZuSY4Jdfq4Rt6vrwqK797dnumBSTj/WRD
         IFclysKSPf7/9Vnd/ukcNqPiLIG3NP/uksW++pX+GucLYnDEM2N3o7rP/sH73xbqvxmb
         yOUFecjiwPRRF7fceN3T1l0G2+djAApYYhBZRjoeBmDPhhmsGaVL9V6Js/ZD1UAl8+X2
         ZAGA==
X-Gm-Message-State: AOAM5303rCK1Gn85OVkIWLB1U9XmGEGtg4aLYbNR1dZtXr62U1TM+l/Q
        q+JtrWSEVnokeCb4Td7hHTlkq2PwyVWL3A==
X-Google-Smtp-Source: ABdhPJwfMDdP913UUOtFNOA92DM+O9mLXkVjh2KmGLV8ZxyTlRfDyY0IEVnOgBSAYv9OmzDGhGzQuA==
X-Received: by 2002:a17:906:b84f:: with SMTP id ga15mr12702939ejb.372.1622509281798;
        Mon, 31 May 2021 18:01:21 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id p11sm7603018edt.22.2021.05.31.18.01.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 18:01:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 31/31] hook-list.h: add a generated list of hooks, like
 config-list.h
Date:   Tue, 01 Jun 2021 03:00:04 +0200
References: <87lf80l1m6.fsf@evledraar.gmail.com>
 <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
 <patch-31.31-896956250f6-20210528T110515Z-avarab@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <patch-31.31-896956250f6-20210528T110515Z-avarab@gmail.com>
Message-ID: <87mtsa1jq7.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 28 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> Resolve a long-standing TODO item in bugreport.c of there being no
> centralized listing of hooks, this fixes a bug with the bugreport
> listing only knowing about 1/4 of the p4 hooks. It didn't know about
> the "reference-transaction" hook either.
>
> We can now make sure this is kept up-to-date, as the hook.c library
> will die if asked to find a hook we don't know about yet. The only
> (undocumented) exception is the artificial "test-hook" used in our own
> test suite. Move some of the tests away from the "does-not-exist"
> pseudo-hook, and test for the new behavior.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> ---
>  .gitignore           |  1 +
>  Makefile             | 14 +++++++++++---
>  builtin/bugreport.c  | 44 ++++++++------------------------------------
>  generate-hooklist.sh | 20 ++++++++++++++++++++
>  hook.c               | 22 ++++++++++++++++++++++
>  t/t1800-hook.sh      | 14 +++++++++++---
>  6 files changed, 73 insertions(+), 42 deletions(-)
>  create mode 100755 generate-hooklist.sh
>
> diff --git a/.gitignore b/.gitignore
> index de39dc9961b..66189ca3cdc 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -191,6 +191,7 @@
>  /gitweb/static/gitweb.min.*
>  /config-list.h
>  /command-list.h
> +/hook-list.h
>  *.tar.gz
>  *.dsc
>  *.deb
> diff --git a/Makefile b/Makefile
> index a6b71a0fbed..d0532f3c744 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -817,6 +817,7 @@ XDIFF_LIB =3D xdiff/lib.a
>=20=20
>  GENERATED_H +=3D command-list.h
>  GENERATED_H +=3D config-list.h
> +GENERATED_H +=3D hook-list.h
>=20=20
>  LIB_H :=3D $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!=
Documentation/' 2>/dev/null || \
>  	$(FIND) . \
> @@ -2207,7 +2208,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
>=20=20
>  help.sp help.s help.o: command-list.h
>=20=20
> -builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
> +hook.sp hook.s hook.o: hook-list.h
> +
> +builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h=
 GIT-PREFIX
>  builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS =3D \
>  	'-DGIT_HTML_PATH=3D"$(htmldir_relative_SQ)"' \
>  	'-DGIT_MAN_PATH=3D"$(mandir_relative_SQ)"' \
> @@ -2240,6 +2243,11 @@ command-list.h: $(wildcard Documentation/git*.txt)
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>  		command-list.txt >$@+ && mv $@+ $@
>=20=20
> +hook-list.h: generate-hooklist.sh
> +hook-list.h: Documentation/githooks.txt
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-hooklist.sh \
> +		>$@+ && mv $@+ $@
> +
>  SCRIPT_DEFINES =3D $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\
> @@ -2890,7 +2898,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>=20=20
> -EXCEPT_HDRS :=3D command-list.h config-list.h unicode-width.h compat/% x=
diff/%
> +EXCEPT_HDRS :=3D command-list.h config-list.h hook-list.h unicode-width.=
h compat/% xdiff/%
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS +=3D sha256/gcrypt.h
>  endif
> @@ -2912,7 +2920,7 @@ hdr-check: $(HCO)
>  style:
>  	git clang-format --style file --diff --extensions c,h
>=20=20
> -check: config-list.h command-list.h
> +check: config-list.h command-list.h hook-list.h
>  	@if sparse; \
>  	then \
>  		echo >&2 "Use 'make sparse' instead"; \
> diff --git a/builtin/bugreport.c b/builtin/bugreport.c
> index 941c8d5e270..a7a1fcb8a7a 100644
> --- a/builtin/bugreport.c
> +++ b/builtin/bugreport.c
> @@ -4,6 +4,7 @@
>  #include "help.h"
>  #include "compat/compiler.h"
>  #include "hook.h"
> +#include "hook-list.h"
>=20=20
>=20=20
>  static void get_system_info(struct strbuf *sys_info)
> @@ -41,39 +42,7 @@ static void get_system_info(struct strbuf *sys_info)
>=20=20
>  static void get_populated_hooks(struct strbuf *hook_info, int nongit)
>  {
> -	/*
> -	 * NEEDSWORK: Doesn't look like there is a list of all possible hooks;
> -	 * so below is a transcription of `git help hooks`. Later, this should
> -	 * be replaced with some programmatically generated list (generated from
> -	 * doc or else taken from some library which tells us about all the
> -	 * hooks)
> -	 */
> -	static const char *hook[] =3D {
> -		"applypatch-msg",
> -		"pre-applypatch",
> -		"post-applypatch",
> -		"pre-commit",
> -		"pre-merge-commit",
> -		"prepare-commit-msg",
> -		"commit-msg",
> -		"post-commit",
> -		"pre-rebase",
> -		"post-checkout",
> -		"post-merge",
> -		"pre-push",
> -		"pre-receive",
> -		"update",
> -		"post-receive",
> -		"post-update",
> -		"push-to-checkout",
> -		"pre-auto-gc",
> -		"post-rewrite",
> -		"sendemail-validate",
> -		"fsmonitor-watchman",
> -		"p4-pre-submit",
> -		"post-index-change",
> -	};
> -	int i;
> +	const char **p;
>=20=20
>  	if (nongit) {
>  		strbuf_addstr(hook_info,
> @@ -81,9 +50,12 @@ static void get_populated_hooks(struct strbuf *hook_in=
fo, int nongit)
>  		return;
>  	}
>=20=20
> -	for (i =3D 0; i < ARRAY_SIZE(hook); i++)
> -		if (hook_exists(hook[i]))
> -			strbuf_addf(hook_info, "%s\n", hook[i]);
> +	for (p =3D hook_name_list; *p; p++) {
> +		const char *hook =3D *p;
> +
> +		if (hook_exists(hook))
> +			strbuf_addf(hook_info, "%s\n", hook);
> +	}
>  }
>=20=20
>  static const char * const bugreport_usage[] =3D {
> diff --git a/generate-hooklist.sh b/generate-hooklist.sh
> new file mode 100755
> index 00000000000..25a7207b276
> --- /dev/null
> +++ b/generate-hooklist.sh
> @@ -0,0 +1,20 @@
> +#!/bin/sh
> +
> +echo "/* Automatically generated by generate-hooklist.sh */"
> +
> +print_hook_list () {
> +	cat <<EOF
> +static const char *hook_name_list[] =3D {
> +EOF
> +	grep -C1 -h '^~~~' Documentation/githooks.txt |
> +	grep '^[a-z0-9][a-z0-9-]*$' |
> +	sort |
> +	sed 's/^.*$/	"&",/'
> +	cat <<EOF
> +	NULL,
> +};
> +EOF
> +}
> +

I found that grep -C isn't portable, so (pending any feedback on this
series) I've locally replaced it with:

diff --git a/generate-hooklist.sh b/generate-hooklist.sh
new file mode 100755
index 0000000000..5a3f7f849c
--- /dev/null
+++ b/generate-hooklist.sh
@@ -0,0 +1,24 @@
+#!/bin/sh
+
+echo "/* Automatically generated by generate-hooklist.sh */"
+
+print_hook_list () {
+	cat <<EOF
+static const char *hook_name_list[] =3D {
+EOF
+	perl -ne '
+		chomp;
+		@l[$.] =3D $_;
+		push @h =3D> $l[$. - 1] if /^~~~+$/s;
+		END {
+			print qq[\t"$_",\n] for sort @h;
+		}
+	' <Documentation/githooks.txt
+	cat <<EOF
+	NULL,
+};
+EOF
+}
+
+echo
+print_hook_list
