Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F513C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 10:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiARKAd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 05:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234406AbiARKAd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 05:00:33 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EC35C061574
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 02:00:32 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 30so77054957edv.3
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 02:00:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=eS54VIvohz0qVWgoXlFs/xZKUd8BsBYX63gfVaIGPQg=;
        b=J8wzrj5m+ZHL8k2v7iEDRi+74XViVLLLAE652bqT5+zo9LRYkgBginpNw+nAumtYff
         mIt0zVXdhcehk4ZUyqJJkGuPQFjwaiiqDYLfKuiMn8CyJnykvW9Pz+4ni+O6NKs1sEN8
         3kNvoEoRW7/1JQh7gYB2jqd9TWAd+4KdY+zK2Jfv+FXhqeqsinJk0X5lU0C90dvDzoe5
         6aEMllxT4AvXDRlixf+4vQRJK2jyR5ISeCt5E18lrk15jz2yTHZ0aCh3UEGGqFylUYvg
         jvHeyz9NfJgp+0vcHSN69axIHcAkCM1n3aNIXeY5v1ku0vPlcAMz6shjlRP+AnIcSaUA
         N/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=eS54VIvohz0qVWgoXlFs/xZKUd8BsBYX63gfVaIGPQg=;
        b=RUuX8er5M63lsH72IjnnMIcyazJZQNS/51zj++8Wtz3NxquWRYJA/C6RO3Jeisj8vg
         Y4OVEl8ONrMJJs6Ep43JLPEXYCh6JXk7UnJvXLPyy6f2MgmPvs9JadL2jx2PbJNNXHTu
         s2uAyxlkDvuOrlUEjIjAQcKrgHDxFwndCMyQ+GxwiEMG91Ys/2n7ZC7f5EsvmKI28lm8
         8dGzQWT/ZVfr8ruC7Ua1kXuw2ceGTO5yteEHdXkKYBfrYgaPhI/X93MH7JX6P6pqQbGH
         tJVZnmTfDiXb2zZPf7ERkwCf7xLDravYeuEd+zfoNacaxMcdMoBJyMYEwuubgsmwhrGv
         Vgpw==
X-Gm-Message-State: AOAM533E0kP3taJ6OAsAbj8u9dLMCt2Knia6Fl+vZP8oo8SCXJX01HeK
        4AGgM6xGdBD7Gw6uVsId0QY=
X-Google-Smtp-Source: ABdhPJy9E41r5A3AxUOCtqLX0OhPxQIqmQjIb2gnpVhAu1NLaG36rvDX7YRdxTq38bxrpXi6XHWcBA==
X-Received: by 2002:a05:6402:c85:: with SMTP id cm5mr21644777edb.357.1642500030675;
        Tue, 18 Jan 2022 02:00:30 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id mp12sm5253217ejc.19.2022.01.18.02.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 02:00:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1n9lHw-001VE4-OK;
        Tue, 18 Jan 2022 11:00:28 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 1/2] wrapper: add a helper to generate numbers from a
 CSPRNG
Date:   Tue, 18 Jan 2022 10:45:12 +0100
References: <20220104015555.3387101-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-1-sandals@crustytoothpaste.net>
 <20220117215617.843190-2-sandals@crustytoothpaste.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220117215617.843190-2-sandals@crustytoothpaste.net>
Message-ID: <220118.86v8yhpdmr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jan 17 2022, brian m. carlson wrote:

> @@ -234,6 +234,14 @@ all::
>  # Define NO_TRUSTABLE_FILEMODE if your filesystem may claim to support
>  # the executable mode bit, but doesn't really do so.
>  #
> +# Define CSPRNG_METHOD to "arc4random" if your system has arc4random and
> +# arc4random_buf, "libbsd" if your system has those functions from libbsd,
> +# "getrandom" if your system has getrandom, "getentropy" if your system has
> +# getentropy, "rtlgenrandom" for RtlGenRandom (Windows only), or "openssl" if
> +# you'd want to use the OpenSSL CSPRNG.  You may set multiple options with
> +# spaces, in which case a suitable option will be chosen.  If unset or set to
> +# anything else, defaults to using "/dev/urandom".
> +#
>  # Define NEEDS_MODE_TRANSLATION if your OS strays from the typical file type
>  # bits in mode values (e.g. z/OS defines I_SFMT to 0xFF000000 as opposed to the
>  # usual 0xF000).
> @@ -693,6 +701,7 @@ TEST_BUILTINS_OBJS += test-bloom.o
>  TEST_BUILTINS_OBJS += test-chmtime.o
>  TEST_BUILTINS_OBJS += test-config.o
>  TEST_BUILTINS_OBJS += test-crontab.o
> +TEST_BUILTINS_OBJS += test-csprng.o
>  TEST_BUILTINS_OBJS += test-ctype.o
>  TEST_BUILTINS_OBJS += test-date.o
>  TEST_BUILTINS_OBJS += test-delta.o
> @@ -1908,6 +1917,31 @@ ifdef HAVE_GETDELIM
>  	BASIC_CFLAGS += -DHAVE_GETDELIM
>  endif
>  
> +ifneq ($(findstring arc4random,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM
> +endif
> +
> +ifneq ($(findstring libbsd,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_ARC4RANDOM_LIBBSD
> +	EXTLIBS += -lbsd
> +endif
> +
> +ifneq ($(findstring getrandom,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_GETRANDOM
> +endif
> +
> +ifneq ($(findstring getentropy,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_GETENTROPY
> +endif
> +
> +ifneq ($(findstring rtlgenrandom,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_RTLGENRANDOM
> +endif
> +
> +ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
> +	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
> +endif
> +

Just an implementation nit: I think:
    
    ifdef HAVE_CSPRNG_ARC4RANDOM
    endif
    ifdef HAVE_CSPRNG_GETRANDOM
    endif

etc. makes this sort of thing much simpler. It piggy-backs on make's
default "is defined?" semantics, which avoids a lot of verbosity.

The "findstring" function you're using is also designed for one-letter
flags like those used for MAKEFLAGS. See /if.*filter/ for a better
pattern for space-separated tokens if you'd like to use this "variable
takes a space separated list" pattern....

> diff --git a/config.mak.uname b/config.mak.uname
> index a3a779327f..ff0710a612 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -141,6 +141,7 @@ ifeq ($(uname_S),Darwin)
>  	HAVE_BSD_SYSCTL = YesPlease
>  	FREAD_READS_DIRECTORIES = UnfortunatelyYes
>  	HAVE_NS_GET_EXECUTABLE_PATH = YesPlease
> +	CSPRNG_METHOD = arc4random
>  
>  	# Workaround for `gettext` being keg-only and not even being linked via
>  	# `brew link --force gettext`, should be obsolete as of

..another reason to use the "defined?" pattern is that if you're using
an older version of OSX (or one of the other OS's) and this is wrong you
can just:

    HAVE_CSPRNG_WHATEVER =

But with space-separated you'll need a more verbose $(filter-out ...).

> +/*

nit: API comments with "/**" comments.

> + * Generate len bytes from the system cryptographically secure PRNG.
> + * Returns 0 on success and -1 on error, setting errno.  The inability to
> + * satisfy the full request is an error.
> + */
> +int csprng_bytes(void *buf, size_t len);
> +
>  #endif
> diff --git a/t/helper/test-csprng.c b/t/helper/test-csprng.c
> new file mode 100644
> index 0000000000..65d14973c5
> --- /dev/null
> +++ b/t/helper/test-csprng.c
> @@ -0,0 +1,29 @@
> +#include "test-tool.h"
> +#include "git-compat-util.h"
> +
> +

nit: extra line, also git-compat-util.h doesn't need to be included, test-tool.h has it.

> +int cmd__csprng(int argc, const char **argv)
> +{
> +	unsigned long count;
> +	unsigned char buf[1024];
> +
> +	if (argc > 2) {
> +		fprintf(stderr, "usage: %s [<size>]\n", argv[0]);
> +		return 2;
> +	}
> +
> +	count = (argc == 2) ? strtoul(argv[1], NULL, 0) : -1L;
> +
> +	while (count) {
> +		unsigned long chunk = count < sizeof(buf) ? count : sizeof(buf);
> +		if (csprng_bytes(buf, chunk) < 0) {
> +			perror("failed to read");
> +			return 5;
> +		}
> +		if (fwrite(buf, chunk, 1, stdout) != chunk)
> +			return 1;
> +		count -= chunk;
> +	}
> +
> +	return 0;
> +}

I know this is just a "demo", but why not add a trivial test *.sh file
for whatever low-level wrapper test we have, so we at least know it
won't segfault etc.

These return codes seem quite specific, any reason we need 2 and 5, not
just "return 1" everywhere on error?

error_errno() instead of perror()?

> +int csprng_bytes(void *buf, size_t len)
> +{
> +#if defined(HAVE_ARC4RANDOM) || defined(HAVE_ARC4RANDOM_LIBBSD)
> +	/* This function never returns an error. */
> +	arc4random_buf(buf, len);
> +	return 0;
> +#elif defined(HAVE_GETRANDOM)
> +	ssize_t res;
> +	char *p = buf;
> +	while (len) {
> +		res = getrandom(p, len, 0);
> +		if (res < 0)
> +			return -1;
> +		len -= res;
> +		p += res;
> +	}
> +	return 0;
> +#elif defined(HAVE_GETENTROPY)
> +	int res;
> +	char *p = buf;
> +	while (len) {
> +		/* getentropy has a maximum size of 256 bytes. */
> +		size_t chunk = len < 256 ? len : 256;
> +		res = getentropy(p, chunk);
> +		if (res < 0)
> +			return -1;
> +		len -= chunk;
> +		p += chunk;
> +	}
> +	return 0;
> +#elif defined(HAVE_RTLGENRANDOM)
> +	if (!RtlGenRandom(buf, len))
> +		return -1;
> +	return 0;
> +#elif defined(HAVE_OPENSSL_CSPRNG)
> +	int res = RAND_bytes(buf, len);
> +	if (res == 1)
> +		return 0;
> +	if (res == -1)
> +		errno = ENOTSUP;
> +	else
> +		errno = EIO;
> +	return -1;

Why fake up errno here instead of just returning -1? In 2/2 you call
error_errno(). This seems buggy for a function that doesn't clear errno
and doesn't guarantee that it's set on failure....

> +#else
> +	ssize_t res;
> +	char *p = buf;
> +	int fd, err;
> +	fd = open("/dev/urandom", O_RDONLY);
> +	if (fd < 0)
> +		return -1;
> +	while (len) {
> +		res = xread(fd, p, len);
> +		if (res < 0) {
> +			err = errno;
> +			close(fd);
> +			errno = err;
> +			return -1;
> +		}
> +		len -= res;
> +		p += res;
> +	}
> +	close(fd);
> +	return 0;
> +#endif
> +}

...seems better to turn it into a "int *failure_errno" parameter
instead, or just have the function itself call error_errno() in these
cases.

You can't just check "if (errno)" either due to the return value of
close() not being checked here...

