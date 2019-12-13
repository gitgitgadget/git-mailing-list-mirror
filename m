Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC8E7C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:57:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B785F214D8
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 22:57:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AX5nmy6E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbfLMW5Y (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 17:57:24 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52529 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725948AbfLMW5Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 17:57:24 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 677F11A7A4;
        Fri, 13 Dec 2019 17:57:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wn9WmY1kAexQ/LIhjE0tZndb8+E=; b=AX5nmy
        6Ek+/HkIFxLy6t5HODcapoIM2peUS9oYfLljBlo0/XEoLj+tPXC7F4uoV2jc9Kpe
        Ju3WNlKIrRvO61k82qqtnS6iRaNccNCrXPaHwpGlF61ZmHsiLai7z6B8tTxe2Kpo
        KNkk9mxbEVJUmoYvl8xJ2Zcs2rhHpDJRJwUJU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tK2pbcBAGnzdehQg3MzW0DxQBiobtQKa
        RvbEpvejv6X236j68JVda7Dz7ypDSBZdG/b5WIm2nyRE5wbdzOTV1VaDV75R1S7O
        QtX1HigEGz3L11j6/IQBdZKWXx9oWFi9mXBvUnswcgcIbiN4hlSUEfJIr2pTOInf
        VnjMBmyqlpg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5DB931A7A3;
        Fri, 13 Dec 2019 17:57:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BC8431A7A2;
        Fri, 13 Dec 2019 17:57:18 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v4 09/15] bugreport: generate config safelist based on docs
References: <20191213004312.169753-1-emilyshaffer@google.com>
        <20191213004312.169753-10-emilyshaffer@google.com>
Date:   Fri, 13 Dec 2019 14:57:17 -0800
In-Reply-To: <20191213004312.169753-10-emilyshaffer@google.com> (Emily
        Shaffer's message of "Thu, 12 Dec 2019 16:43:06 -0800")
Message-ID: <xmqq7e2zhm0i.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9FCED26-1DFB-11EA-A99B-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer <emilyshaffer@google.com> writes:

> diff --git a/Makefile b/Makefile
> index c49f55a521..76dc51e2b1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -651,7 +651,7 @@ install-perl-script: $(SCRIPT_PERL_GEN)
>  install-python-script: $(SCRIPT_PYTHON_GEN)
>  	$(INSTALL) $^ '$(DESTDIR_SQ)$(gitexec_instdir_SQ)'
>  
> -.PHONY: clean-perl-script clean-sh-script clean-python-script
> +.PHONY: clean-perl-script clean-sh-script clean-python-script clean-script-dependencies
>  clean-sh-script:
>  	$(RM) $(SCRIPT_SH_GEN)
>  clean-perl-script:
> @@ -817,6 +817,7 @@ VCSSVN_LIB = vcs-svn/lib.a
>  
>  GENERATED_H += config-list.h
>  GENERATED_H += command-list.h
> +GENERATED_H += bugreport-config-safelist.h

OK.

>  LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentation/' 2>/dev/null || \
>  	$(FIND) . \
> @@ -2161,6 +2162,12 @@ command-list.h: $(wildcard Documentation/git*.txt) Documentation/*config.txt Doc
>  		$(patsubst %,--exclude-program %,$(EXCLUDED_PROGRAMS)) \
>  		command-list.txt >$@+ && mv $@+ $@
>  
> +bugreport-config-safelist.h: generate-bugreport-config-safelist.sh
> +
> +bugreport-config-safelist.h: Documentation/config/*.txt
> +	$(QUIET_GEN)$(SHELL_PATH) ./generate-bugreport-config-safelist.sh \
> +		>$@+ && mv $@+ $@

OK.

>  SCRIPT_DEFINES = $(SHELL_PATH_SQ):$(DIFF_SQ):$(GIT_VERSION):\
>  	$(localedir_SQ):$(NO_CURL):$(USE_GETTEXT_SCHEME):$(SANE_TOOL_PATH_SQ):\
>  	$(gitwebdir_SQ):$(PERL_PATH_SQ):$(SANE_TEXT_GREP):$(PAGER_ENV):\

But bugreport.o needs this *.h file generated before a compiler
attempts to produce it out of bugreport.c; that dependency is
missing from this update to the Makefile.

> @@ -2791,7 +2798,7 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
>  .PHONY: sparse $(SP_OBJ)
>  sparse: $(SP_OBJ)
>  
> -GEN_HDRS := config-list.h command-list.h unicode-width.h
> +GEN_HDRS := config-list.h command-list.h unicode-width.h bugreport-config-safelist.h
>  EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
>  ifndef GCRYPT_SHA256
>  	EXCEPT_HDRS += sha256/gcrypt.h
> @@ -3117,7 +3124,8 @@ clean: profile-clean coverage-clean cocciclean
>  	$(RM) $(HCC)
>  	$(RM) -r bin-wrappers $(dep_dirs)
>  	$(RM) -r po/build/
> -	$(RM) *.pyc *.pyo */*.pyc */*.pyo config-list.h command-list.h
> +	$(RM) *.pyc *.pyo */*.pyc */*.pyo
> +	$(RM) config-list.h command-list.h bugreport-config-safelist.h

It is kind of sad that GEN_HDRS defines the list of build artifact
that we should be able to clean, and then we manually list them to
be removed here independently.  Can we fix it up too?

We probably clean up the build/update procedure around unicode-width.h
before we can do so, probably.  It may be generatable using contrib/
script, but as far as our normal build is concerned, it is a tracked
source and not part of the build byproducts, so we probably would
want to remove it from GEN_HDRS.  When that happens, we can $(RM)
all of the $(GEN_HDRS) in the "clean" target.

