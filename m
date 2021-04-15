Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D11FC433B4
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:10:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BF68611AC
	for <git@archiver.kernel.org>; Thu, 15 Apr 2021 21:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbhDOVKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Apr 2021 17:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234439AbhDOVKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Apr 2021 17:10:41 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12375C061574
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:10:17 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r9so38971028ejj.3
        for <git@vger.kernel.org>; Thu, 15 Apr 2021 14:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=rAIJdbF1rAR6zNNpAiOWB6nFJ/mcoa/q6rSOb+lnh5M=;
        b=BcKg08OlW9Igj0THlu3u+KiJ0+1teEbVCYSUs2nr9ZQ8pW+qEeN1/vTAX7+NPIJiSy
         7xhd0UTjoi+m40kOaYh/s1kxX5WbSd/dmatQzS2K4Sww9KgRf9baJlxQQJ2okVQBvTO/
         MRuythl9KSSluj7TkH1coDjV3iMYU1L5wjekFEmlJ7RjGd8DAU8mglRKNQLm7fIPn5YB
         4xqF79LmiHoGhlJeM46zKEzEx0vJxc42tmwIJv1qsJ1b1LQgKsuWFJjjJXWypMiq6xlz
         Yq6mamMIun+muesvXFYZaNxwodFmn8AANyCwXGfgFpxDcLWHJb1XE7Xzy9pO3bWgqWuF
         5dyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=rAIJdbF1rAR6zNNpAiOWB6nFJ/mcoa/q6rSOb+lnh5M=;
        b=cdTB5U93+k877h/3huPNIuAxpWOwI7m+UD50Famd5/iIyv7Oi+ZE3+wqBxNgT7DJX7
         P8Uv0DZTjzj+Kmav9eIs7ZVmzrY66NZknpbDA7QFw2aGsPBmj15mCQ5zUT0kGQnwGqm3
         rbulX+Tc8HrQto6kA2e4lLXaLTWNRjC33F4Ca1huSQnbD835opiVurqlHxkSvCYiRIRM
         fQLOhqXFHkDLsCntM97+NQbgQFg5/zbXvGJh0iDDnICv79WEhO6LG2KPsk7Oggm9OmQV
         VDbBcvgAk80/X9j+/6rIJua0VcVTJnhwn5OUAEm5+cffcBhvKKkQvoxkagtQbxcPqPFo
         ixqQ==
X-Gm-Message-State: AOAM530sESXBTN8URUrCk2QRg+Reer1rhmeXsFUjUIkJ2yyxCSTujQER
        rD5DlkR5pl1k4v0QRXuVtp0=
X-Google-Smtp-Source: ABdhPJyTg2RL9/LgaYW0FkuknVxUjOa6aWFRwCF/RTJTK54WdCHGT1iko6DxMWsFkpi6MLA6bVfrvg==
X-Received: by 2002:a17:906:2756:: with SMTP id a22mr5433026ejd.437.1618521015813;
        Thu, 15 Apr 2021 14:10:15 -0700 (PDT)
Received: from szeder.dev (78-131-14-48.pool.digikabel.hu. [78.131.14.48])
        by smtp.gmail.com with ESMTPSA id p8sm1436989ejx.81.2021.04.15.14.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Apr 2021 14:10:15 -0700 (PDT)
Date:   Thu, 15 Apr 2021 23:10:13 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 12/16] test-lib: modernize test_create_repo() function
Message-ID: <20210415211013.GM2947267@szeder.dev>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
 <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-12.16-424caad189f-20210412T110456Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 12, 2021 at 01:09:01PM +0200, Ævar Arnfjörð Bjarmason wrote:
> Remove redundant "mkdir -p", argument number checking', test
> environment sanity checking, and disabling of hooks from
> test_create_repo(). As we'll see below these were all either redundant
> to other test other framework code, or to changes in git itself.
> 
> Respectively:
> 
>  1. "mkdir -p" isn't needed because "git init" itself will create
>     leading directories if needed.
> 
>  2. We don't need to check the number of arguments anymore, instead
>     we'll feed "git init" with "$@". It will die if given too many
>     arguments.

Or it will succeed if invoked as e.g. 'test_create_repo --bare repo'.

>  3. We won't ever hit that "Cannot setup test environment"
>     error.

ENOSPC?  Some rogue background process on Windows still desperately
clinging to an open file descriptor to some file in the same
directory, preventing 'rm -rf "$TRASH_DIRECTORY"' near the beginning
of 'test-lib.sh' and interfering with 'git init'?

>     Checking the test environment sanity when doing "git init" dates
>     back to eea420693be (t0000: catch trivial pilot errors.,
>     2005-12-10) and 2ccd2027b01 (trivial: check, if t/trash directory
>     was successfully created, 2006-01-05).
> 
>     We can also see it in another form a bit later in my own
>     0d314ce834d (test-lib: use subshell instead of cd $new && .. && cd
>     $old, 2010-08-30).
> 
>     But since 2006f0adaee (t/test-lib: make sure Git has already been
>     built, 2012-09-17) we already check if we have a built git
>     earlier.
> 
>     The one thing this was testing after that 2012 change was that
>     we'd just built "git", but not "git-init", but since
>     3af4c7156c4 (tests: respect GIT_TEST_INSTALLED when initializing
>     repositories, 2018-11-12) we invoke "git", not "git-init".
> 
>     So all of that's been checked already, and we don't need to
>     re-check it here.

I agree that if we already have a 'git' binary that can run 'git
version', then we can safely assume that it will be able to run 'git
init' as well.  It might be that 'git init' is buggy and segfaults,
but that is not a "have you built things yet?" kind of error.

>  4. We don't need to move .git/hooks out of the way.
> 
>     That dates back to c09a69a83e3 (Disable hooks during tests.,
>     2005-10-16), since then hooks became disabled by default in
>     f98f8cbac01 (Ship sample hooks with .sample suffix, 2008-06-24).
> 
>     So the hooks were already disabled by default, but as can be seen
>     from "mkdir .git/hooks" changes various tests needed to re-setup
>     that directory. Now they no longer do.
> 
>  5. Since we don't need to move the .git/hooks directory we don't need
>     the subshell here either.

We needed the subshell because we changed directory in
'test_create_repo' (even you referenced 0d314ce834d above), not
because we moved the hooks directory.

> In the end it turns out that all we needed was a plain "git init"
> invocation with a custom --template directory.

We don't need '--template', either; see below.

> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index c81726acb9e..1258329fdd8 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -1252,18 +1252,9 @@ test_atexit () {
>  # Most tests can use the created repository, but some may need to create more.
>  # Usage: test_create_repo <directory>
>  test_create_repo () {
> -	test "$#" = 1 ||
> -	BUG "not 1 parameter to test-create-repo"
> -	repo="$1"
> -	mkdir -p "$repo"
> -	(
> -		cd "$repo" || error "Cannot setup test environment"
> -		"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \
> -			init \
> -			"--template=$GIT_BUILD_DIR/templates/blt/" >&3 2>&4 ||
> -		error "cannot run git init -- have you built things yet?"
> -		mv .git/hooks .git/hooks-disabled
> -	) || exit

This patch removes this '|| exit', which is...

  - good: if 'test_create_repo' is invoked in a test case (and not in
    a subshell) and if it were to fail for some reason, then it won't
    abort the whole test script, but will fail only that test case.

  - bad: 'test_create_repo' is responsible for creating the repository
    in the trash directory as well; if that were to fail for any
    reason, then the test script will not be aborted early.

I think the 'exit' on error should be removed from 'test_create_repo',
but the callsite in 'test-lib.sh' should become 'test_create_repo ||
exit 1'.

In any case, removing this '|| exit' is not mentioned in the commit
message.

> +	"${GIT_TEST_INSTALLED:-$GIT_EXEC_PATH}/git$X" \

PATH is already set up to start with GIT_TEST_INSTALLED and/or
GIT_EXEC_PATH before 'test_create_repo' is called to init the repo in
the trash directory, so we could simply run 'git' and rely on PATH
lookup choosing the right executable.

> +		init \
> +		"--template=$GIT_BUILD_DIR/templates/blt/" "$@" >&3 2>&4

Likewise, GIT_TEMPLATE_DIR is already set up to the same value as in
this '--template=...' option, so we could omit this option as well.

And after that all that would remain in this function is:

  git init "$1" >&3 2>&4

And those redirections are only needed when this function is called to
initialize the repo in the trash directory, but not when it creates a
repo in a test case.  This makes me question the value of having this
'test_create_repo' helper function at all; there are already over 800
cases where we run plain 'git init' outside of 't0001-init.sh' instead
of 'test_create_repo', though removing it would be definitely cause
some churn with over 300 callsites.



>  }
>  
>  # This function helps on symlink challenged file systems when it is not
> -- 
> 2.31.1.634.gb41287a30b0
> 
