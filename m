Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 774E9ECAAA1
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 21:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbiIPV4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 17:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiIPV4D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 17:56:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C9A26ADB
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 14:56:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1E4811BB1BD;
        Fri, 16 Sep 2022 17:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:cc:cc:date:message-id:mime-version
        :content-type; s=sasl; bh=FmT7wrEGgeYG6fwpOtmtDoqr1N29UlJfvw2yO7
        cdrgQ=; b=pgrZ9kOKtofyQzdC5RWOeIwyVe3JzSzxKwPXFluOlAXbGU+csKJjKQ
        VuizJZYAx0eXMWWgkSe3xzNUgPthmi8DkFeoJfn0Cb65YjNCmafSAmbRNl4y5q5w
        kxanAw7kMwzgDlkvUsBcRanS2oo1mRtVuuvV8quHVZY18OySODVr4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 179D61BB1BC;
        Fri, 16 Sep 2022 17:56:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AD0B31BB1BA;
        Fri, 16 Sep 2022 17:55:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Arthur Chan <arthur.chan@adalogics.com>
Subject: Re: [PATCH] fuzz: reorganise the path for existing oss-fuzz fuzzers
References: <pull.1353.git.1663355009333.gitgitgadget@gmail.com>
CC:     Josh Steadmon <steadmon@google.com>
CC:     David Korczynski <david@adalogics.com>
Date:   Fri, 16 Sep 2022 14:55:57 -0700
Message-ID: <xmqqo7vff0gi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58E3C29A-360A-11ED-83CC-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Arthur Chan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Arthur Chan <arthur.chan@adalogics.com>
>
> This patch is aimed to provide a better organisation for oss-fuzz
> fuzzers, allowing more fuzzers for the git project to be added
> in a later development.
>
> A new folder oss-fuzz has been created and existing fuzzers are
> moved into the new folders. Makefile has been fixed accordingly.

"folder" -> "directory" everywhere.

>  Makefile                                            | 6 +++---
>  fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c | 0
>  fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c | 0
>  fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c         | 0
>  4 files changed, 3 insertions(+), 3 deletions(-)
>  rename fuzz-commit-graph.c => oss-fuzz/fuzz-commit-graph.c (100%)
>  rename fuzz-pack-headers.c => oss-fuzz/fuzz-pack-headers.c (100%)
>  rename fuzz-pack-idx.c => oss-fuzz/fuzz-pack-idx.c (100%)

It is curious that we do not have any changes to .gitignore
patterns.

    $ git grep fuzz .gitignore Makefile
    .gitignore:/fuzz-commit-graph
    .gitignore:/fuzz_corpora
    .gitignore:/fuzz-pack-headers
    .gitignore:/fuzz-pack-idx
    Makefile:FUZZ_OBJS += fuzz-commit-graph.o
    Makefile:FUZZ_OBJS += fuzz-pack-headers.o
    Makefile:FUZZ_OBJS += fuzz-pack-idx.o
    Makefile:.PHONY: fuzz-objs
    Makefile:fuzz-objs: $(FUZZ_OBJS)
    Makefile:# Always build fuzz objects even if not testing, to prevent bit-rot.
    Makefile:# Building fuzz targets generally requires a special set of compiler flags that
    Makefile:#      CFLAGS="-fsanitize=fuzzer-no-link,address" \
    Makefile:#      LIB_FUZZING_ENGINE="-fsanitize=fuzzer" \
    Makefile:#      fuzz-all
    Makefile:.PHONY: fuzz-all
    Makefile:fuzz-all: $(FUZZ_PROGRAMS)

I do not know what "fuzz_corpora" is, which step in build creates
it, and why we do not have to bother removing it in "make clean",
the last of which is not the fault of this patch, but I suspect that
at least other three existing entries that name $(FUZZ_PROGRAMS)
need to be updated, because ...

> diff --git a/Makefile b/Makefile
> index d9247ead45b..2d56aae7a1d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -686,9 +686,9 @@ SCRIPTS = $(SCRIPT_SH_GEN) \
>  
>  ETAGS_TARGET = TAGS
>  
> -FUZZ_OBJS += fuzz-commit-graph.o
> -FUZZ_OBJS += fuzz-pack-headers.o
> -FUZZ_OBJS += fuzz-pack-idx.o
> +FUZZ_OBJS += oss-fuzz/fuzz-commit-graph.o
> +FUZZ_OBJS += oss-fuzz/fuzz-pack-headers.o
> +FUZZ_OBJS += oss-fuzz/fuzz-pack-idx.o

... FUZZ_OBJS now live in the oss-fuzz/ directory, and Makefile has

    FUZZ_PROGRAMS += $(patsubst %.o,%,$(FUZZ_OBJS))

    $(FUZZ_PROGRAMS): all
	$(QUIET_LINK)$(CXX) $(FUZZ_CXXFLAGS) $(LIB_OBJS) $(BUILTIN_OBJS) \
		$(XDIFF_OBJS) $(EXTLIBS) git.o $@.o $(LIB_FUZZING_ENGINE) -o $@

neither of which has been touched by the patch, so presumably the
executables are now created in the oss-fuzz/ directory as well, and
they are what .gitignore should be listing, right?

Also, compiling the exectuable files would not be the end of the
story, right?  Do folks (like test script, makefile targets and CI
recipes) who used to run ./fuzz-commit-graph need to be told that
they now need to run oss-fuzz/fuzz-commit-graph instead?  They may
not be inside my tree, but what's the best way to inform them?  Add
entries to release notes (not asking you to add one immediately ---
asking you to help formulating the plans).

Thanks.
