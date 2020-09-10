Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82F9C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:31:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 627BE20809
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 05:31:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DSJLs0eo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbgIJFbK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 01:31:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60602 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFbF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 01:31:05 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B60FD70D10;
        Thu, 10 Sep 2020 01:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xPfZYeqVxDn6PyxO51QHzeiovGs=; b=DSJLs0
        eoAKj/75vWmo+EVkvzfjZJs+iB2GQBM7kMHxU1LXQX9ryf2E/xI4iQr+I12waxcc
        z4iLFe2r0OCSXglspHyGqi3S+lTZgbR/2jwaweEgeCNImRFIMbeFg6zBbaBOGCDM
        C4QTBimhkWk1QlVWxEgn6Zp0sJg7zS+zXX8Mo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=homaYZKEsia209uyg54wA0LU/e3/KqK7
        NVCB3DxRdAfHdjG+T8Rjd5XiuMLr2YJkv8Tc9tye/ZveF7zh7JIrbMc0AM6dKtJk
        D0DJ3u94j01Szc1llRSYSiryh38c9wu8OYJcDxTjyf8K+kkq1Wll9v2iwyU/mg1+
        VHGOJFAJHhk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AADE770D0F;
        Thu, 10 Sep 2020 01:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2B2ED70D0E;
        Thu, 10 Sep 2020 01:31:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        "KADOTA\, Kyohei" <lufia@lufia.org>
Subject: Re: [PATCH v3 2/2] Use $(LD) instead of $(CC) for linking the object files
References: <pull.694.v2.git.1599680861.gitgitgadget@gmail.com>
        <pull.694.v3.git.1599704262.gitgitgadget@gmail.com>
        <7d33e11867e0a75efb1a906610ff81da2ace9717.1599704262.git.gitgitgadget@gmail.com>
Date:   Wed, 09 Sep 2020 22:31:01 -0700
In-Reply-To: <7d33e11867e0a75efb1a906610ff81da2ace9717.1599704262.git.gitgitgadget@gmail.com>
        (Kyohei Kadota via GitGitGadget's message of "Thu, 10 Sep 2020
        02:17:42 +0000")
Message-ID: <xmqq4ko6ryei.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D0948FBE-F326-11EA-9E7D-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Kyohei Kadota via GitGitGadget" <gitgitgadget@gmail.com> writes:

> diff --git a/Makefile b/Makefile
> index 86e5411f39..c0c0c280f0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -543,6 +543,7 @@ export prefix bindir sharedir sysconfdir gitwebdir perllibdir localedir
>  
>  # Set our default programs
>  CC = cc
> +LD = cc

This is good that any system that use 'cc' to link now will reach
the same 'cc' via $(LD) instead of $(CC).

But those who customize $(CC) to their taste now needs to override
not just CC but also LD.  Can we avoid regressing for them?  Perhaps
default the value of LD to $(CC) instead of hardcoded 'cc'?

> @@ -2121,7 +2122,7 @@ git.sp git.s git.o: EXTRA_CPPFLAGS = \
>  	'-DGIT_INFO_PATH="$(infodir_relative_SQ)"'
>  
>  git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) \
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) \
>  		$(filter %.o,$^) $(LIBS)

Are there those who depended on ALL_CFLAGS on the command line when
the final linking happens?

For example, people have '-g -O2' on CFLAGS, and that will be
included in ALL_CFLAGS and passed to the final linking phase.  GNU
ld has "-O" option to optimize; when existing systems link with "cc
-g -O2 -o $@ ...", it is likely that "-O2" given to "cc" will cause
the "-O" option to be passed to underlying "ld".

But with the updated procedure (where LD is 'cc' for them), the
linkage will be done without ALL_CFLAGS passed on the command line,
and results in "cc -o $@ ...", without "-g -O2".

That sounds like a regression.

> @@ -2445,17 +2446,17 @@ compat/nedmalloc/nedmalloc.sp: SP_EXTRA_FLAGS += -Wno-non-pointer-null
>  endif
>  
>  git-%$X: %.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(LIBS)
>  
>  git-imap-send$X: imap-send.o $(IMAP_SEND_BUILDDEPS) GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(IMAP_SEND_LDFLAGS) $(LIBS)
>  
>  git-http-fetch$X: http.o http-walker.o http-fetch.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(CURL_LIBCURL) $(LIBS)
>  git-http-push$X: http.o http-push.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>  
>  $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
> @@ -2465,7 +2466,7 @@ $(REMOTE_CURL_ALIASES): $(REMOTE_CURL_PRIMARY)
>  	cp $< $@
>  
>  $(REMOTE_CURL_PRIMARY): remote-curl.o http.o http-walker.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
>  		$(CURL_LIBCURL) $(EXPAT_LIBEXPAT) $(LIBS)
>
> @@ -2753,7 +2754,7 @@ perf: all
>  t/helper/test-tool$X: $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
>  
>  t/helper/test-%$X: t/helper/test-%.o GIT-LDFLAGS $(GITLIBS)
> -	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
> +	$(QUIET_LINK)$(LD) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)

Likewise for all of the above.

> diff --git a/ci/lib.sh b/ci/lib.sh
> index 3eefec500d..19c5beb277 100755
> --- a/ci/lib.sh
> +++ b/ci/lib.sh
> @@ -125,6 +125,7 @@ then

All changes to this file to pass LD=cc everywhere CC=cc is passed
look good to me.

> diff --git a/config.mak.in b/config.mak.in
> index e6a6d0f941..76ea7e781e 100644
> --- a/config.mak.in
> +++ b/config.mak.in
> @@ -2,6 +2,7 @@
>  # @configure_input@
>  
>  CC = @CC@
> +LD = @CC@
>  CFLAGS = @CFLAGS@
>  CPPFLAGS = @CPPFLAGS@
>  LDFLAGS = @LDFLAGS@

OK.

> diff --git a/config.mak.uname b/config.mak.uname
> index c7eba69e54..886ce068f8 100644
> --- a/config.mak.uname
> +++ b/config.mak.uname
> @@ -69,6 +69,7 @@ ifeq ($(uname_S),GNU/kFreeBSD)
>  endif
>  ifeq ($(uname_S),UnixWare)
>  	CC = cc
> +	LD = $(CC)
>  	NEEDS_SOCKET = YesPlease
>  	NEEDS_NSL = YesPlease
>  	NEEDS_SSL_WITH_CRYPTO = YesPlease
> @@ -90,6 +91,7 @@ ifeq ($(uname_S),SCO_SV)
>  	endif
>  	ifeq ($(uname_R),5)
>  		CC = cc
> +		LD = $(CC)
>  		BASIC_CFLAGS += -Kthread
>  	endif
>  	NEEDS_SOCKET = YesPlease
> @@ -435,6 +437,7 @@ ifeq ($(uname_S),Windows)
>  	DEFAULT_HELP_FORMAT = html
>  
>  	CC = compat/vcbuild/scripts/clink.pl
> +	LD = $(CC)
>  	AR = compat/vcbuild/scripts/lib.pl
>  	CFLAGS =
>  	BASIC_CFLAGS = -nologo -I. -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
> @@ -525,6 +528,7 @@ ifeq ($(uname_S),NONSTOP_KERNEL)
>  	ifeq ($(uname_R).$(uname_V),L17.02)
>  		CC += -WRVU=L16.05
>  	endif
> +	LD = $(CC)
>  	# Disable all optimization, seems to result in bad code, with -O or -O2
>  	# or even -O1 (default), /usr/local/libexec/git-core/git-pack-objects
>  	# abends on "git push". Needs more investigation.

Ditto.

> @@ -665,8 +669,10 @@ else
>  			BASIC_LDFLAGS += -Wl,--large-address-aware
>  		endif
>  		CC = gcc
> +		LD = $(CC)
>  		COMPAT_CFLAGS += -D__USE_MINGW_ANSI_STDIO=0 -DDETECT_MSYS_TTY \
>  			-fstack-protector-strong
> +		BASIC_LDFLAGS += -fstack-protector-strong
>  		EXTLIBS += -lntdll
>  		INSTALL = /bin/install
>  		NO_R_TO_GCC_LINKER = YesPlease

This is an example of the problem we discussed earlier for not
passing ALL_CFLAGS to the linking phase.  I am not sure what the
best solution is, though.

Thanks.
