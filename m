Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B96BFC7EE22
	for <git@archiver.kernel.org>; Mon,  8 May 2023 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjEHXWM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 19:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbjEHXWL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 19:22:11 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F1993CC
        for <git@vger.kernel.org>; Mon,  8 May 2023 16:22:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5208be24dcbso3604936a12.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683588129; x=1686180129;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HHdjBFMo6ClFa6lh3ZcuvN1u35ZNZ3AdPxR0RCHnrNI=;
        b=d7E5vG3HNKZ5SztVhIJqkJlVnJdo9cu7JZddjCXJrpdBhklUZK2Uc5xuS+5Z+slSS5
         s7yHow8R0Qr/z5+hcCBDvd/Vetd0ckBHXwIk352IQ2KFOLLG165KvQXtW2BQBmFq7imk
         q0MqfzQv5F2RkKysyKvrSfpFqxztiPaiaHSEOOdGG9+jkF7Yt5qCkpEqqHvxT2fdd+0p
         BTRg8CrwuZdxMZB8PJO3Igb+o8311bsM32YFJ70O8zi/FPQXt2X/mm7itH15kH4qCr6t
         VtdxmLh69wp8q5OvQsIPPf7TXnWp5lJ1Opi0m350K9via+sUyguaYzLTgfQLbZGxhGqs
         R1vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683588129; x=1686180129;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HHdjBFMo6ClFa6lh3ZcuvN1u35ZNZ3AdPxR0RCHnrNI=;
        b=K8nrcjiR973e16uAq9I9toZHRbdlzG0mCRtdbd9JvqsqhsoVzoEnQFk6q9FNkAxd5B
         2F4/QkB10mcLxNYUr3d90aXbAD+fpCjIFya7HJG2ZNQy98UyQCFpGTH3D2oxd2rmXyxG
         sJFJfZjgVfi2606saO5+LPTX2IdVr52mrZAlo6zDcM+YIAjZ5/yWZO3AO4W330BZ4pLq
         7zJRyostM27AXGKVuDcYLwKJ1s/Ht/vnEISYnam5Y2RyOfWKq7tmcFTk3oYmtU+wAsyN
         MOPvvVq+idLxD2ijvuWbwS7W2DKKt1qdLoWbuzlEp34lDux9Ts2JUCxR9ae3V2ggULox
         4J/A==
X-Gm-Message-State: AC+VfDyMHORDDcgsySdRXUtis6DiJk6zCqFiaVDjLBdz2buoA5uHykT8
        k8H+lUd5GEKWnAvVOQdMjC/vW2nvUXA=
X-Google-Smtp-Source: ACHHUZ6MNQaQN+H0XVI7AzT75LYcdBU49u68aITMtNwli8V3e09nr5NrPDJcSGhTBV36bIg3nZTueQ==
X-Received: by 2002:a05:6a20:7354:b0:101:1d1d:43a4 with SMTP id v20-20020a056a20735400b001011d1d43a4mr1530831pzc.15.1683588128819;
        Mon, 08 May 2023 16:22:08 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id e35-20020a635463000000b0051b70c8d446sm15219pgm.73.2023.05.08.16.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 16:22:08 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 06/15] builtin/for-each-ref.c: add `--exclude` option
References: <cover.1683581621.git.me@ttaylorr.com>
        <ea5c0ddc10cd484c2af8505b8078697896ff3bad.1683581621.git.me@ttaylorr.com>
Date:   Mon, 08 May 2023 16:22:08 -0700
In-Reply-To: <ea5c0ddc10cd484c2af8505b8078697896ff3bad.1683581621.git.me@ttaylorr.com>
        (Taylor Blau's message of "Mon, 8 May 2023 17:59:58 -0400")
Message-ID: <xmqqcz3a4den.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> index c01fa6fefe..449da61e11 100644
> --- a/builtin/for-each-ref.c
> +++ b/builtin/for-each-ref.c
> @@ -14,6 +14,7 @@ static char const * const for_each_ref_usage[] = {
>  	N_("git for-each-ref [--points-at <object>]"),
>  	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
>  	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
> +	N_("git for-each-ref [--exclude=<pattern> ...]"),
>  	NULL
>  };

I think the original is already wrong, but the easiest thing we can
do in order to avoid making it worse is to drop this hunk, as the
existing usage is this:

static char const * const for_each_ref_usage[] = {
	N_("git for-each-ref [<options>] [<pattern>]"),
	N_("git for-each-ref [--points-at <object>]"),
	N_("git for-each-ref [--merged [<commit>]] [--no-merged [<commit>]]"),
	N_("git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"),
	NULL
};

and this series merely adds a new "--exclude=<pattern>" as one of
the "<options>". 

As we can see from the fact that for example

 $ git for-each-ref --no-merged next refs/heads/\?\?/\*

works just fine, exactly the same thing can be said about the other
--points-at/--merged/--no-merged/--contains/--no-contains options.

The SYNOPSIS section of the manual page is fine.

> diff --git a/ref-filter.c b/ref-filter.c
> index 6c5eed144f..93dc9b331f 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -2169,6 +2169,15 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
>  	return match_pattern(filter, filter->name_patterns, refname);
>  }
>  
> +static int filter_exclude_match(struct ref_filter *filter, const char *refname)
> +{
> +	if (!filter->exclude.nr)
> +		return 0;
> +	if (filter->match_as_path)
> +		return match_name_as_path(filter, filter->exclude.v, refname);
> +	return match_pattern(filter, filter->exclude.v, refname);
> +}

Earlier I made a comment about .name_patterns member becoming
unnecessary, but I think what should need to happen is instead
match_pattern() and match_name_as_path() to lose the "filter"
parameter, and take a boolean "ignore_case" instead.

>  struct ref_filter {
>  	const char **name_patterns;
> +	struct strvec exclude;

At some point after the dust settles, we may want to tweak
name_patterns so that these two appear to complement each other more
clearly, e.g. use "struct strvec include" to replace "name_patterns"
or something.  But that is an unrelated tangent.

In any case, there wasn't anything surprising or unexpected in the
code.  Looking good.

> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 5c00607608..7e8d578522 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -447,6 +447,41 @@ test_expect_success 'exercise glob patterns with prefixes' '
>  	test_cmp expected actual
>  '
>  
> +cat >expected <<\EOF
> +refs/tags/bar
> +refs/tags/baz
> +refs/tags/testtag
> +EOF
> +
> +test_expect_success 'exercise patterns with prefix exclusions' '
> +	for tag in foo/one foo/two foo/three bar baz
> +	do
> +		git tag "$tag" || return 1
> +	done &&
> +	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
> +	git for-each-ref --format="%(refname)" \
> +		refs/tags/ --exclude=refs/tags/foo >actual &&
> +	test_cmp expected actual
> +'
> +
> +cat >expected <<\EOF
> +refs/tags/bar
> +refs/tags/baz
> +refs/tags/foo/one
> +refs/tags/testtag
> +EOF
> +
> +test_expect_success 'exercise patterns with pattern exclusions' '
> +	for tag in foo/one foo/two foo/three bar baz
> +	do
> +		git tag "$tag" || return 1
> +	done &&
> +	test_when_finished "git tag -d foo/one foo/two foo/three bar baz" &&
> +	git for-each-ref --format="%(refname)" \
> +		refs/tags/ --exclude="refs/tags/foo/t*" >actual &&
> +	test_cmp expected actual
> +'

These are doing as Romans do, so I won't comment on the outdated
pattern of preparing the expectation outside the test script.  After
the dust settles, somebody needs to go in and clean it up.

Thanks.
