Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FF8C76195
	for <git@archiver.kernel.org>; Mon, 27 Mar 2023 18:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjC0S0h (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Mar 2023 14:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjC0S03 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Mar 2023 14:26:29 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ABCD3C0A
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 11:26:09 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id kc4so9251693plb.10
        for <git@vger.kernel.org>; Mon, 27 Mar 2023 11:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679941569;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oDLV2zhxvXXx7EtwjuEEiEBgOy7FtYbH84z5Q8hCn/c=;
        b=KSZpILAw5jKayiIlo6/HAbbNIimGd0mHcGVIYi4tmnfh/cv2yjM6L0JbnheUCA07LS
         kd0nMKj7n6h+AaAsOFZfgvs1YlnflnDtkhQwZrG9KuFAt3TCgHJGB3LWUSbAFNcjm6KI
         s846YDmYmbu973Bt08wGGChBUsFtr+zrgPay6H49lB1oP4NuzVXKtgJh7Wkrs//PzGbT
         Cl1ClQORJvwX6Z8FUnA9EJo97S+iZDoigmdZ649IeR6ts3Kb2zvKNJzjIm0GDmF3Bfy+
         L8AtKw4OKmAwznB5CIHHQpVenr3kqxjDxRYZRhwrLPX5LdTY7pVw887+jl5zfPazDxiO
         bmwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679941569;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oDLV2zhxvXXx7EtwjuEEiEBgOy7FtYbH84z5Q8hCn/c=;
        b=09c9Bu8ts+Ms8OyoITu5oO/a5zU9JgZgXKlZhABiwqs4b8gHkL7OjdD/BfgSxe+2po
         6RQh4wpZWQuCquF6QBDf/eZH2eyry3Nj20MHEYBzsKYvmdQ9KnedjWrQGjhFilop1LFi
         7yXurrqRZ2SaiJgNH/tfAbQTmwwlo8hOdUtTTZ/fH+wbOUISU1x3Bc3n6a/3iioM65dg
         YaNM1NoiHmVbbFP3lRvDb8vN1oWpWl8EUAd9PBK4bcVvYCHbXvm8gHAXa5C/FJN6kTYc
         BEOzFe+h5AlOc5Dr176L34ZIDEFCzVn3waAnHdCDhDux9cabcxuPzvuvlga+na3v0nf3
         2QCQ==
X-Gm-Message-State: AAQBX9ephcip1p07ugVa0JX0vIz9lcGo28S+Kt+FSSdBF8o008msKZ/E
        YTdMK033sTf76W90dZXx4CGONvL26sw=
X-Google-Smtp-Source: AKy350ZHkCbfrsXcO+w7AnXOwaZqMkw4G6LStv2/N24ox8XrqrmKcRaf1jHGD/Od+n4P6p0hYohP/g==
X-Received: by 2002:a17:90b:38d2:b0:23f:3b89:7f16 with SMTP id nn18-20020a17090b38d200b0023f3b897f16mr13805075pjb.0.1679941568779;
        Mon, 27 Mar 2023 11:26:08 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ga22-20020a17090b039600b00227223c58ecsm7767620pjb.42.2023.03.27.11.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 11:26:07 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH] describe: enable sparse index for describe
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
Date:   Mon, 27 Mar 2023 11:26:07 -0700
In-Reply-To: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com> (Raghul
        Nanth A. via GitGitGadget's message of "Mon, 27 Mar 2023 14:20:29
        +0000")
Message-ID: <xmqqjzz29hkw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com> writes:

>  builtin/describe.c                       |   2 +
>  t/perf/p2000-sparse-operations.sh        |  14 +-
>  t/t1092-sparse-checkout-compatibility.sh |  10 +
>  t/t6121-describe-sparse.sh               | 675 +++++++++++++++++++++++
>  4 files changed, 697 insertions(+), 4 deletions(-)
>  create mode 100755 t/t6121-describe-sparse.sh

This copying of a file with 600+ lines only to touch up a handful
lines (like a 20+ lines patch) is almost criminal.  Imagine the
effort to keep them in sync over time, when "describe" itself may
learn new features and improved output, independent from the
sparse-index compatibility.

Can't we do better than this with a bit of refactoring?

> diff --git a/builtin/describe.c b/builtin/describe.c
> index 5b5930f5c8c..7ff9b5e4b20 100644
> --- a/builtin/describe.c
> +++ b/builtin/describe.c
> @@ -654,6 +654,8 @@ int cmd_describe(int argc, const char **argv, const char *prefix)
>  			int fd, result;
>  
>  			setup_work_tree();
> +			prepare_repo_settings(the_repository);
> +			the_repository->settings.command_requires_full_index = 0;

Offhand, the only case I know that "describe" even _needs_ a working
tree or the index is when asked to do the "--dirty" thing.  To
figure out if the working tree files are modified, the code calls
into run_diff_index(), but has that codepath been made sparse-index
aware already?

> diff --git a/t/perf/p2000-sparse-operations.sh b/t/perf/p2000-sparse-operations.sh
> index 3242cfe91a0..a8a9ed79441 100755
> --- a/t/perf/p2000-sparse-operations.sh
> +++ b/t/perf/p2000-sparse-operations.sh
> @@ -59,7 +59,8 @@ test_expect_success 'setup repo and indexes' '
>  		git sparse-checkout set $SPARSE_CONE &&
>  		git config index.version 3 &&
>  		git update-index --index-version=3 &&
> -		git checkout HEAD~4
> +		git checkout HEAD~4 &&
> +		git tag -a v1.0 -m "Final"
>  	) &&
>  	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . full-v4 &&
>  	(
> @@ -68,7 +69,8 @@ test_expect_success 'setup repo and indexes' '
>  		git sparse-checkout set $SPARSE_CONE &&
>  		git config index.version 4 &&
>  		git update-index --index-version=4 &&
> -		git checkout HEAD~4
> +		git checkout HEAD~4 &&
> +		git tag -a v1.0 -m "Final"
>  	) &&
>  	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v3 &&
>  	(
> @@ -77,7 +79,8 @@ test_expect_success 'setup repo and indexes' '
>  		git sparse-checkout set $SPARSE_CONE &&
>  		git config index.version 3 &&
>  		git update-index --index-version=3 &&
> -		git checkout HEAD~4
> +		git checkout HEAD~4 &&
> +		git tag -a v1.0 -m "Final"
>  	) &&
>  	git -c core.sparseCheckoutCone=true clone --branch=wide --sparse . sparse-v4 &&
>  	(
> @@ -86,7 +89,8 @@ test_expect_success 'setup repo and indexes' '
>  		git sparse-checkout set $SPARSE_CONE &&
>  		git config index.version 4 &&
>  		git update-index --index-version=4 &&
> -		git checkout HEAD~4
> +		git checkout HEAD~4 &&
> +		git tag -a v1.0 -m "Final"
>  	)
>  '

It is unclear from the proposed commit log what the relevance of
adding a step to create an annotated tag to these tests.  It is not
like any later step uses that tag to figure out anything.  There may
be good reasons to add these tags (otherwise you would not be adding
them to these tests), but please explain why in the proposed log
message so that future readers of the "git log -p" do not have to
ask this question.

> @@ -125,5 +129,7 @@ test_perf_on_all git checkout-index -f --all
>  test_perf_on_all git update-index --add --remove $SPARSE_CONE/a
>  test_perf_on_all "git rm -f $SPARSE_CONE/a && git checkout HEAD -- $SPARSE_CONE/a"
>  test_perf_on_all git grep --cached --sparse bogus -- "f2/f1/f1/*"
> +test_perf_on_all git describe --dirty
> +test_perf_on_all 'echo >> new && git describe --dirty'
>  
>  test_done

Just like '>', '>>' is a rediraction operator and should have SP
before it (you got it right) and no SP between it and its operand.
I.e.

	echo >>new && git describe --dirty

You have the same in t1092, I think.

