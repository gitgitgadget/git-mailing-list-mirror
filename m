Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB4AC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 22:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344355AbjD0WyJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 18:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344354AbjD0WyH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 18:54:07 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D00212F
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:54:05 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1a6ebc66ca4so67533175ad.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 15:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682636045; x=1685228045;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yub5ttIjtj6fSUprzNJh1P/pSE6GbHwkc/0GSngr5DY=;
        b=g1EEvVsqPdBUbJeEZBkGT2VW3Mge1kJYR41X9aXIuUd0F/UD4SZvazGMssTIhYcnTP
         NXD4++JhLqfb5/iAgwh5A4d0MaVkTevA6d4Tkhh5UNEEno91oI0w06pEhXtjDOK+o/XK
         +RgFXwoh90IWE9SWM/KzgM3hjOU7VFg68bv2ImniKYv7Je181EJ0+3sZOjSoY6ySdbKJ
         ik9QhaR3G5EoAhw3jba8YIVaIzXsSi7cdz2J/KG1+Qij4i6mFtLm+SKYPVJhnJ4X9YrT
         cR6nmEEBz8Trn0lthd7WBkXva1ZzCVo6APbM9uQstUqEgboTWV3rpEUnsfsWbKNvMQch
         CS9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682636045; x=1685228045;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yub5ttIjtj6fSUprzNJh1P/pSE6GbHwkc/0GSngr5DY=;
        b=SGKjW6jPPTK0Q01Yj9eAI5g+1l2KQiFHKAzIG9XZElsW0J1bGwmv9LUtnf+4A0m/wC
         iiKb/EWo6crrU61lyM13ojP3kWo672Jj9yKpK80VxClYLnqkARmtJH6Y0lO4JYxEWFtc
         URNP1ZNKjcsfbguedX+5z6NoRU+phHp1vl3CQMS/73u+86EPA+uON0u5oFmtsEU7yltn
         siCJXsQAvVax/YFWXnOnsYp5D/ZT8Zv4CRzhMcDb55fBgTq9A9x9+XvTSpe45fKHYfIw
         XCKgG7K+NJyOiw2Wpn6zsP1+6jbxGdF28Tr/tfS0gzsewcxWBL+5fnBA0Jy5jwI8SXz/
         Lidw==
X-Gm-Message-State: AC+VfDz7qOP58B3RAyQVteGpM6hz0BlX92oXeXZuJPn5WGsjXII6+Vsh
        UhxEYufFmjoVEM5C/lJnEAQ=
X-Google-Smtp-Source: ACHHUZ51LXOrt+MhjxW2pdyL3oOjlNwtcTxy6w/6aQaNEQN8nVYlYfSONVPcCzf16E5Bp1sIYU90Ag==
X-Received: by 2002:a17:903:1cf:b0:1a9:581e:d809 with SMTP id e15-20020a17090301cf00b001a9581ed809mr3707030plh.7.1682636045094;
        Thu, 27 Apr 2023 15:54:05 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id p9-20020a1709028a8900b0019cb6222691sm12085062plo.133.2023.04.27.15.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Apr 2023 15:54:04 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] setup: trace bare repository setups
References: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
Date:   Thu, 27 Apr 2023 15:54:04 -0700
In-Reply-To: <cb72bca46c6ff2a8cf3196408fb53411f7f91892.1682631601.git.steadmon@google.com>
        (Josh Steadmon's message of "Thu, 27 Apr 2023 15:32:40 -0700")
Message-ID: <xmqqttx1gcmr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/setup.c b/setup.c
> index 59abc16ba6..458582207e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -1352,6 +1352,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
>  		}
>  
>  		if (is_git_directory(dir->buf)) {
> +			trace2_data_string("setup", NULL, "implicit-bare-repository", dir->buf);
>  			if (get_allowed_bare_repo() == ALLOWED_BARE_REPO_EXPLICIT)
>  				return GIT_DIR_DISALLOWED_BARE;
>  			if (!ensure_valid_ownership(NULL, NULL, dir->buf, report))

That is kind of obvious.

> diff --git a/t/t0035-safe-bare-repository.sh b/t/t0035-safe-bare-repository.sh
> index 11c15a48aa..a1f3b5a4d6 100755
> --- a/t/t0035-safe-bare-repository.sh
> +++ b/t/t0035-safe-bare-repository.sh
> @@ -7,13 +7,24 @@ TEST_PASSES_SANITIZE_LEAK=true
>  
>  pwd="$(pwd)"
>  
> -expect_accepted () {
> -	git "$@" rev-parse --git-dir
> +expect_accepted_implicit () {
> +	test_when_finished "rm \"$pwd/trace.perf\"" &&

Why not

	test_when_finished 'rm "$pwd/trace.perf"' &&

instead?  

In your version, $pwd is expanded before test_when_finished sees it,
so you'd have to worry about things like backslashes and double quotes
in it.  You can of course quote the '$' like so

	test_when_finished "rm \"\$pwd/trace.perf\"" &&

to work it around, but it is equivalent to enclosing everything
inside a pair of single quotes.  Either way your $pwd will be
interpolated when "eval" sees the $test_cleanup script.

And it would be much easier to read without backslash and
backslashed double quotes.

> +	GIT_TRACE2_PERF="$pwd/trace.perf" git "$@" rev-parse --git-dir &&
> +	grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
> +}

We ensure that we positively have such a trace in the output.  Good.

> +expect_accepted_explicit () {
> +	test_when_finished "rm \"$pwd/trace.perf\"" &&
> +	GIT_DIR="$@" GIT_TRACE2_PERF="$pwd/trace.perf" git rev-parse --git-dir &&
> +	! grep -F "implicit-bare-repository:$pwd" "$pwd/trace.perf"
>  }

When not asking for the magic behaviour of "$@" and instead doing a
"squash everything into a single string, using the first letter in
$IFS as the separator in between", please write "$*" instead.

    GIT_DIR="$*" GIT_TRACE2_PERF="..." git rev-parse --git-dir

But in this case, I do not think you are ever planning to send a
directory name split into two or more, to be concatenated with SP,
so writing it like

    GIT_DIR="$1" GIT_TRACE2_PERF="..." git rev-parse --git-dir

would be much less error prone and easier to follow, I think.

> @@ -22,12 +33,12 @@ test_expect_success 'setup bare repo in worktree' '
>  '
>  
>  test_expect_success 'safe.bareRepository unset' '
> -	expect_accepted -C outer-repo/bare-repo
> +	expect_accepted_implicit -C outer-repo/bare-repo
>  '

Perhaps futureproof this test piece by explicitly unsetting the
variable before starting the test?  That way, this piece will not be
broken even if earlier tests gets modified to set some value to
safe.bareRepository in the future.

>  test_expect_success 'safe.bareRepository=all' '
>  	test_config_global safe.bareRepository all &&
> -	expect_accepted -C outer-repo/bare-repo
> +	expect_accepted_implicit -C outer-repo/bare-repo
>  '
>  
>  test_expect_success 'safe.bareRepository=explicit' '
> @@ -47,7 +58,7 @@ test_expect_success 'safe.bareRepository in the repository' '
>  
>  test_expect_success 'safe.bareRepository on the command line' '
>  	test_config_global safe.bareRepository explicit &&
> -	expect_accepted -C outer-repo/bare-repo \
> +	expect_accepted_implicit -C outer-repo/bare-repo \
>  		-c safe.bareRepository=all
>  '
>  
> @@ -60,4 +71,8 @@ test_expect_success 'safe.bareRepository in included file' '
>  	expect_rejected -C outer-repo/bare-repo
>  '
>  
> +test_expect_success 'no trace when GIT_DIR is explicitly provided' '
> +	expect_accepted_explicit "$pwd/outer-repo/bare-repo"
> +'
> +
>  test_done

All the expectations look sensible.  Thanks for a pleasant read.
