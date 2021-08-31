Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C99CC432BE
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:21:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08E4260FC0
	for <git@archiver.kernel.org>; Tue, 31 Aug 2021 08:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240246AbhHaIWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Aug 2021 04:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240109AbhHaIWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Aug 2021 04:22:08 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C674C061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:21:13 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j14-20020a1c230e000000b002e748b9a48bso1400271wmj.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 01:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=Z8KlXG7W8iSDz2WoVySmvzYuHsY2TiZjEQxrE7R0z9A=;
        b=RpuSw/fSzZUelyCldf7C0y6mtYrlmKiKJY70EnuJPFvd+fhoGNohogspGtWjbXMJRC
         YHll3H3NbdZ9dfTsf7VHWuo2zTZyn1KeYKMJBsx7Dd/rT+mbLUcEkFA2hsKdJp4VBqOc
         wM3HbeUDsQqcW0v9sjDgrdlcDnLOXGQsaGbfcrDze0I9dw8aLAB5ETOs0DmapvnkhGNB
         DdlcGvyCryjVuQnU4U/DzJj7KcrKSA2OmQWwTHsAx6tGEmoq2ejqWrr9qgDMXB6TeqVf
         /iX6Tbt+sD94/m9FojxiDJXUYqxPY5nu0i3eQbmWHsXokzUOUFV1SbmvtAVvq6Df3LiQ
         eETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=Z8KlXG7W8iSDz2WoVySmvzYuHsY2TiZjEQxrE7R0z9A=;
        b=UxuJDPv6i1929UFpzDTSttSx648lE6FBPnNzv/ZiQe8JcKoz7ZS60Hhz/vS6rf+fsi
         EVKuPaqr6UbJjfuZeAM7P/wdFGo5hyICtWxTwQd8It0/aysH0RHDqsiwR/vbnJtJ/eE0
         0McyaI7R5Fqp2qBQID8jxTcgcLCMHz+uVCFwP/YMtIc02UvSZjnQknjiwtmGV4Ljtyzw
         bPLhOEF/82k8NHPwujI/e3cBNqx4il4jQU8DXm5g82bGQzSNL/CQmZJfmVFuXxaxUSHc
         0/09ls7jFGO4O+bi88SF5L+lytFgM2ZoDg59OisLZVOSpxP2Q7VDSn9vRLtiUrRKZ4gh
         zOWw==
X-Gm-Message-State: AOAM530LHMMc1FM/MrGQ3v9qEr9BiLXM04PBAiG/87S1TTiTXUNnBHYI
        XwWV4ZlO2d/TbVXBQzEf4TPqU+09n5XYTg==
X-Google-Smtp-Source: ABdhPJzPMSUifOzZy9ZfMlelnuv/nvLs3RKWuZP4jBC9g030ZCqjqTiILmBAuIylP11A6TUGqAud5Q==
X-Received: by 2002:a05:600c:1457:: with SMTP id h23mr2890065wmi.143.1630398071008;
        Tue, 31 Aug 2021 01:21:11 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id a10sm7625475wrd.51.2021.08.31.01.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 01:21:10 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 03/15] scalar: create test infrastructure
Date:   Tue, 31 Aug 2021 10:15:36 +0200
References: <pull.1005.git.1630359290.gitgitgadget@gmail.com>
 <bcfde9bc7651266deaa0e5036cebd058dffc12a7.1630359290.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <bcfde9bc7651266deaa0e5036cebd058dffc12a7.1630359290.git.gitgitgadget@gmail.com>
Message-ID: <87czpuxbwp.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Johannes Schindelin via GitGitGadget wrote:

> To test the Scalar command, create a test script in contrib/scalar/t
> that is executed as `make -C contrib/scalar test`. Since Scalar has no
> meaningful capabilities yet, the only test is rather simple. We will add
> more tests in subsequent commits that introduce corresponding, new
> functionality.

As a comment on 01..03/15: I'd really prefer if we stop using this
pattern of sub-Makefile, the dependencies are a pain to manage, and we
end up copy/pasting large sets of functionality.

That would mean just adding the build of this command to the top-level
Makefile behind some "CONTRIB_SCALAR" flag or whatever, but I find that
much cleaner than....

> @@ -21,7 +22,7 @@ include ../../config.mak.uname
>  TARGETS = scalar$(X) scalar.o
>  GITLIBS = ../../common-main.o ../../libgit.a ../../xdiff/lib.a
>  
> -all: scalar$X
> +all: scalar$X ../../bin-wrappers/scalar
>  
> [...]
> +../../bin-wrappers/scalar: ../../wrap-for-bin.sh Makefile
> [...]
>  scalar.html: | scalar.1 # prevent them from trying to build `doc.dep` in parallel

...things like this, which refer to assets built by other Makefiles, and
need to plaster over the dependency issues...

> +++ b/contrib/scalar/t/Makefile
> @@ -0,0 +1,78 @@
> +# Run scalar tests
> +#
> +# Copyright (c) 2005,2021 Junio C Hamano, Johannes Schindelin
> +#
> +
> +-include ../../../config.mak.autogen
> +-include ../../../config.mak
> +
> +SHELL_PATH ?= $(SHELL)
> +PERL_PATH ?= /usr/bin/perl
> +RM ?= rm -f
> +PROVE ?= prove
> +DEFAULT_TEST_TARGET ?= test
> +TEST_LINT ?= test-lint
> +
> +ifdef TEST_OUTPUT_DIRECTORY
> +TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
> +else
> +TEST_RESULTS_DIRECTORY = ../../../t/test-results
> +endif
> +
> +# Shell quote;
> +SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
> +PERL_PATH_SQ = $(subst ','\'',$(PERL_PATH))
> +TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
> +
> +T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
> +
> +all: $(DEFAULT_TEST_TARGET)
> +
> +test: $(TEST_LINT)
> +	$(MAKE) aggregate-results-and-cleanup
> +
> +prove: $(TEST_LINT)
> +	@echo "*** prove ***"; GIT_CONFIG=.git/config $(PROVE) --exec '$(SHELL_PATH_SQ)' $(GIT_PROVE_OPTS) $(T) :: $(GIT_TEST_OPTS)
> +	$(MAKE) clean-except-prove-cache
> +
> +$(T):
> +	@echo "*** $@ ***"; GIT_CONFIG=.git/config '$(SHELL_PATH_SQ)' $@ $(GIT_TEST_OPTS)
> +
> +clean-except-prove-cache:
> +	$(RM) -r 'trash directory'.* '$(TEST_RESULTS_DIRECTORY_SQ)'
> +	$(RM) -r valgrind/bin
> +
> +clean: clean-except-prove-cache
> +	$(RM) .prove
> +
> +test-lint: test-lint-duplicates test-lint-executable test-lint-shell-syntax
> +
> +test-lint-duplicates:
> +	@dups=`echo $(T) | tr ' ' '\n' | sed 's/-.*//' | sort | uniq -d` && \
> +		test -z "$$dups" || { \
> +		echo >&2 "duplicate test numbers:" $$dups; exit 1; }
> +
> +test-lint-executable:
> +	@bad=`for i in $(T); do test -x "$$i" || echo $$i; done` && \
> +		test -z "$$bad" || { \
> +		echo >&2 "non-executable tests:" $$bad; exit 1; }
> +
> +test-lint-shell-syntax:
> +	@'$(PERL_PATH_SQ)' ../../../t/check-non-portable-shell.pl $(T)
> +
> +aggregate-results-and-cleanup: $(T)
> +	$(MAKE) aggregate-results
> +	$(MAKE) clean
> +
> +aggregate-results:
> +	for f in '$(TEST_RESULTS_DIRECTORY_SQ)'/t*-*.counts; do \
> +		echo "$$f"; \
> +	done | '$(SHELL_PATH_SQ)' ../../../t/aggregate-results.sh
> +
> +valgrind:
> +	$(MAKE) GIT_TEST_OPTS="$(GIT_TEST_OPTS) --valgrind"
> +
> +test-results:
> +	mkdir -p test-results
> +
> +.PHONY: $(T) aggregate-results clean valgrind

...and this entire copy/pasting & adjusting of t/Makefile.
