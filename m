Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A6ECAAA3
	for <git@archiver.kernel.org>; Fri, 26 Aug 2022 00:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231485AbiHZAUf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Aug 2022 20:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiHZAUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2022 20:20:34 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B2B2F39E
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 17:20:32 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id 72so59827pfx.9
        for <git@vger.kernel.org>; Thu, 25 Aug 2022 17:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:from:to:cc;
        bh=on2Aqe4Vk1682qgUkiDTyQwNfFygShR/XuV4lSNR9ZA=;
        b=kdTrtbibcz4GSZVmPoQL01ofXMmjbPjSkLctOB5vtURkIVNJH5HdffE59Xn5o72a2J
         zH2OvoYSqPIDKpJ7MDwLR02QZAey4i2x/6SdTcns6aIrI+UjLqowiygcnvF5uUyPC6nX
         ovC7NUzDuDDXfOYn8qSKJf6KZPHiE4YILMUp5g8VPYjFNOsOUxfVe+XocEKm94XetAWs
         QMfIu1PGVz+HJQc5bC18iCZfUK2TmXah1DD0oALRYUDrmE+NtMt6qOKWNZehg53e0Q61
         bVby3foA34jB9DyhnKyP/NMmuXheav9RgLxmqHttEoT/FD9DM8C3XLhRiqiQoMuSKnjg
         zhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id:date
         :references:subject:cc:to:from:sender:x-gm-message-state:from:to:cc;
        bh=on2Aqe4Vk1682qgUkiDTyQwNfFygShR/XuV4lSNR9ZA=;
        b=x+h1m6jX/Wx2EI0UCSQIsCEexPikxiX2xMGocERGyABKxS5bLjA2zDkkx5lU2rpnV1
         woKApowfQSCC8RF1J2CGumNhSbT3GkPdStz6W1lr8cuP4TM7B2DDC1c+fB/B16aQzr8j
         v9EWrPNowu8V3sd1Dxv8iMRUT4mz7gCaCEaHILIGReS0xdQdB3deUKbgEFspnk2e9p+x
         1LSx7MAXSTYC8iX+zVLILkCxARwiN2uS7GPV5NCLqBSjIYHjeCpT0i60OD1XD1YK/+Y0
         74teOeRXutU2KGe9H2eRejamdzcSXSPD2PLT+VEqJGcQoD/6qfPhYQMH8VvyjdGg1m/a
         Lk1g==
X-Gm-Message-State: ACgBeo3S8wXLlrALj4MeiGiwVdIjnGz0ZiVAs6CygZY2yeLDxbu4hl6N
        6j2dv+lmvwY9mcBQnW+ov0E=
X-Google-Smtp-Source: AA6agR6xtQpQyo6WKUFw3wbcRu8HlNBHVSyZMcdoNaFD5O5Uq6MKlM1oeH6DIh3Wwv6uO0xoH64osw==
X-Received: by 2002:a63:f753:0:b0:42a:bfc9:ea52 with SMTP id f19-20020a63f753000000b0042abfc9ea52mr1221453pgk.408.1661473231731;
        Thu, 25 Aug 2022 17:20:31 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id u9-20020a170902e5c900b00172f4835f65sm134099plf.271.2022.08.25.17.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 17:20:31 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Diomidis Spinellis <dds@aueb.gr>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        avarab@gmail.com
Subject: Re: [PATCH v3] grep: fix multibyte regex handling under macOS
References: <20220825082045.2662893-1-dds@aueb.gr>
Date:   Thu, 25 Aug 2022 17:20:30 -0700
Message-ID: <xmqqpmgn26up.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Diomidis Spinellis <dds@aueb.gr> writes:

> diff --git a/Makefile b/Makefile
> index 04d0fd1fe6..d1a9825715 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1427,7 +1427,6 @@ ifeq ($(uname_S),Darwin)
>  		APPLE_COMMON_CRYPTO = YesPlease
>  		COMPAT_CFLAGS += -DAPPLE_COMMON_CRYPTO
>  	endif
> -	NO_REGEX = YesPlease
>  	PTHREAD_LIBS =
>  endif
>  
> @@ -2970,6 +2969,7 @@ GIT-BUILD-OPTIONS: FORCE
>  	@echo NO_PERL=\''$(subst ','\'',$(subst ','\'',$(NO_PERL)))'\' >>$@+
>  	@echo NO_PTHREADS=\''$(subst ','\'',$(subst ','\'',$(NO_PTHREADS)))'\' >>$@+
>  	@echo NO_PYTHON=\''$(subst ','\'',$(subst ','\'',$(NO_PYTHON)))'\' >>$@+
> +	@echo NO_REGEX=\''$(subst ','\'',$(subst ','\'',$(NO_REGEX)))'\' >>$@+
>  	@echo NO_UNIX_SOCKETS=\''$(subst ','\'',$(subst ','\'',$(NO_UNIX_SOCKETS)))'\' >>$@+
>  	@echo PAGER_ENV=\''$(subst ','\'',$(subst ','\'',$(PAGER_ENV)))'\' >>$@+
>  	@echo DC_SHA1=\''$(subst ','\'',$(subst ','\'',$(DC_SHA1)))'\' >>$@+

Build part looks good to me.

> diff --git a/common-main.c b/common-main.c
> index c531372f3f..0a22861f1c 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -40,6 +40,7 @@ int main(int argc, const char **argv)
>  
>  	git_resolve_executable_dir(argv[0]);
>  
> +	setlocale(LC_CTYPE, "");
>  	git_setup_gettext();
>  
>  	initialize_the_repository();
> diff --git a/gettext.c b/gettext.c
> index bb5ba1fe7c..f139008d0a 100644
> --- a/gettext.c
> +++ b/gettext.c
> @@ -10,7 +10,6 @@
>  #include "config.h"
>  
>  #ifndef NO_GETTEXT
> -#	include <locale.h>
>  #	include <libintl.h>
>  #	ifdef GIT_WINDOWS_NATIVE
>  
> @@ -80,7 +79,6 @@ static int test_vsnprintf(const char *fmt, ...)
>  
>  static void init_gettext_charset(const char *domain)
>  {
> -	setlocale(LC_CTYPE, "");
>  	charset = locale_charset();
>  	bind_textdomain_codeset(domain, charset);
> 
> diff --git a/git-compat-util.h b/git-compat-util.h
> index 58d7708296..c6fa3c7469 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -212,6 +212,7 @@
>  #endif
>  #include <errno.h>
>  #include <limits.h>
> +#include <locale.h>
>  #ifdef NEEDS_SYS_PARAM_H
>  #include <sys/param.h>
>  #endif

I'll let others more familiar with the locale support to comment on
these changes.  We are unconditionally including <locale.h> now;
before platforms that lack locale.h can set NO_GETTEXT but that will
no longer work as a "workaround" for them.  I do not know if thta is
a practical downside to anybody, but it could be a problem.

> diff --git a/t/t7818-grep-multibyte.sh b/t/t7818-grep-multibyte.sh
> new file mode 100755
> index 0000000000..a3889f9822
> --- /dev/null
> +++ b/t/t7818-grep-multibyte.sh

Do we need a new test script for this?

> @@ -0,0 +1,34 @@
> +#!/bin/sh
> +
> +test_description='grep multibyte characters'
> +
> +. ./test-lib.sh
> +
> +# Multibyte regex search is only supported with a native regex library
> +# that supports it.
> +# (The supplied compatibility library is compiled with NO_MBSUPPORT.)

This file is not specific to Darwin; "... with a native regex
library" etc. is not something we want to see here.

> +test -z "$NO_REGEX" &&
> +  LC_ALL=en_US.UTF-8 test-tool regex '^.$' '¿' &&
> +  test_set_prereq MB_REGEX

We can safely drop 'test -z "$NO_REGEX" &&' part here, no?  Even if
we omit it, those who built with NO_REGEX would fail "test-tool
regex" step above.  And by omitting $NO_REGEX check, we do not have
to look for and update the condition when the fallback regex engine
we use starts supporting MB_REGEX.

> +if ! test_have_prereq MB_REGEX
> +then
> +  skip_all='multibyte grep tests; Git compiled with NO_REGEX, NO_MBSUPPORT'
> +  test_done
> +fi

I do not think if we need a single use prereq here.  We can just
use whatever condition that is used to set MB_REGEX above and do the
skip-all thing here.

> +test_expect_success 'setup' '
> +	test_write_lines "¿" >file &&
> +	git add file &&
> +	LC_ALL="en_US.UTF-8" &&
> +	export LC_ALL
> +'

Missing inter-test blank line.

> +test_expect_success 'grep exactly one char in single-char multibyte file' '
> +	git grep "^.$"
> +'

I am not sure how much value we are getting out of this test, which
is identical to what we already tested earlier above with "test-tool
regex".

> +test_expect_success 'grep two chars in single-char multibyte file' '
> +	test_expect_code 1 git grep ".."
> +'
> +
> +test_done
