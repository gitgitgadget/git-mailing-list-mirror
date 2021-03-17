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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7644C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 12:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960E164F26
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 12:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhCQMrw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 08:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbhCQMrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Mar 2021 08:47:18 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C219FC06174A
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 05:47:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id c10so2365375ejx.9
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 05:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=hqyG6iF6GOugqSZrf9qCAQHpnAuEqs30oWofru8UjGw=;
        b=h8Z7TZ82c4Tztyye6pOtDZI7bRxmsmp2ntqphGET32lfnpP7krwSarczvkiSCowjrw
         ajHR6rmn9mPIYGC+vaeOg3Eg9+Bzw8NzGRcyb03mfabrwQ6j+yzU6qwKhdDhtqjMJUQk
         B56WKbRVb8cY2cgBCNtC6QWZPqXsh3N8F3QBnG4vLoLOfvELhUhuVPhI7FUArNUXOpdX
         zpGRk2RWk3Z3beGOpCAf9FhLIEvw5RONGeOkm+D4XJyhYOBijlDXSsbaCKEveR7X+wdK
         TwmIZJSPyeXSpZlaSoYUN8inORiqz52N5vaZFmC/o422bqzn/2GXKDJGlriWGUWQBe6w
         rVjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=hqyG6iF6GOugqSZrf9qCAQHpnAuEqs30oWofru8UjGw=;
        b=ZwTHnYHtcXluZiZkbgYT/zdLf+LFLQ6MDDSnY7u+0UTpHo7tshV5a71C+NQP9gSrt4
         /qqFQ8BtrI/W1bbzJ5AIQwSsTT5qHRv5f3YSpRRwOVY97hCQHvqOgDAUddG8f4ai6ZSL
         dElJceFpZryUNcqrTaQCKfRQ3cz97liWiInp0m3lSur9WOQDaa0Rvk+sWk387zo2TcA8
         7JiCe0tSchDW09mgkpN9Yf0IWlmZWQC8z8g+CEWNg9D5HleT3AEX8WatZVuI4CxdeE0u
         ad6n5wrju7M+AyyknaL+yCEsKg37OiQPi79uFyM/PNgEF4P+G4IWKKnwYhknsAZET0O2
         t5cw==
X-Gm-Message-State: AOAM530MqLstT9TnT/NmHWW9N1BS1ABXPzCF5Mej+6WlNrDZJ7LB67AD
        ixDZkTMoEmjH1qvWNT4JRY0=
X-Google-Smtp-Source: ABdhPJy9+kOjGcka5BCidSWLXiy21yTALbGPPoaooCY85/mgKgWKcwEJ6SEatDKro0bF6tgCQT6MBA==
X-Received: by 2002:a17:906:a2d3:: with SMTP id by19mr34357643ejb.98.1615985236490;
        Wed, 17 Mar 2021 05:47:16 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id bm6sm11416621ejb.50.2021.03.17.05.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 05:47:16 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/7] Makefile: add 'check-sort' target
References: <cover.1615856156.git.liu.denton@gmail.com>
 <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <5088e93d76e44de9d079b7b2296b8c810828a2f5.1615856156.git.liu.denton@gmail.com>
Date:   Wed, 17 Mar 2021 13:47:15 +0100
Message-ID: <87mtv2dk18.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Mar 16 2021, Denton Liu wrote:

> In the previous few commits, we sorted many lists into ASCII-order. In
> order to ensure that they remain that way, add the 'check-sort' target.
>
> The check-sort.perl program ensures that consecutive lines that match
> the same regex are sorted in ASCII-order. The 'check-sort' target runs
> the check-sort.perl program on some files which are known to contain
> sorted lists.
>
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>
> Notes:
>     Full disclaimer: this is the first time I've written anything in Perl.
>     Please let me know if I'm doing anything unconventional :)
>
>  Makefile        | 25 +++++++++++++++++++++++++
>  check-sort.perl | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 56 insertions(+)
>  create mode 100755 check-sort.perl
>
> diff --git a/Makefile b/Makefile
> index 5832aa33da..b23dff384d 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -3240,6 +3240,31 @@ check-docs::
>  check-builtins::
>  	./check-builtins.sh
>  
> +.PHONY: check-sort
> +check-sort::
> +	./check-sort.perl \
> +		'ALL_COMMANDS \+=' \
> +		'ALL_COMMANDS_TO_INSTALL \+=' \
> +		'BINDIR_PROGRAMS_NEED_X \+=' \
> +		'BINDIR_PROGRAMS_NO_X \+=' \
> +		'BUILTIN_OBJS \+=' \
> +		'BUILT_INS \+=' \
> +		'FUZZ_OBJS \+=' \
> +		'GENERATED_H \+=' \
> +		'LIB_OBJS \+=' \
> +		'SCRIPT_LIB \+=' \
> +		'SCRIPT_PERL \+=' \
> +		'SCRIPT_PYTHON \+=' \
> +		'SCRIPT_SH \+=' \
> +		'TEST_BUILTINS_OBJS \+=' \
> +		'TEST_PROGRAMS_NEED_X \+=' \
> +		'THIRD_PARTY_SOURCES \+=' \
> +		'XDIFF_OBJS \+=' \
> +		<Makefile

Why does this part need to be a Perl script at all? We can check this in
the makefile itself. Make has a sort function and string comparisons,
e.g.:

LIB_OBJS_SORTED =
LIB_OBJS_SORTED += $(sort $(LIB_OBJS))
ifneq ("$(LIB_OBJS)", "$(LIB_OBJS_SORTED)")
$(error "please sort and de-duplicate LIB_OBJS!")
endif

This will fail/pass before/after your patches. Note that make's sort
isn't just a sort, it also de-deplicates (not that we're likely to have
that issue).

> [...]
> +	./check-sort.perl '\t\{ "[^"]*",' <git.c

This last one you can IMO be done better as (or if we want to be more
anal, we could make git die on startup if it's not true):
    
    diff --git a/t/t0012-help.sh b/t/t0012-help.sh
    index 5679e29c62..5bd2ebceca 100755
    --- a/t/t0012-help.sh
    +++ b/t/t0012-help.sh
    @@ -77,6 +77,11 @@ test_expect_success 'generate builtin list' '
            git --list-cmds=builtins >builtins
     '
     
    +test_expect_success 'list of builtins in git.c should be sorted' '
    +       sort builtins >sorted &&
    +       test_cmp sorted builtins
    +'
    +
     while read builtin
     do
            test_expect_success "$builtin can handle -h" '

Which just leaves:

> +	./check-sort.perl 'int cmd_[^(]*\(' <builtin.h
> +	./check-sort.perl 'int cmd__[^(]*\(' <t/helper/test-tool.h

As something that can't be done in the Makefile itself or that we're
already extracting from the tests.

Both of those IMO would be better handled down the line by making the
relevant part of these files generated from the data in the Makefile, at
which point we'd have no need for the external perl script.
