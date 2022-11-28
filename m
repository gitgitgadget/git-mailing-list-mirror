Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82EB1C43217
	for <git@archiver.kernel.org>; Mon, 28 Nov 2022 13:23:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231538AbiK1NXJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Nov 2022 08:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbiK1NXI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2022 08:23:08 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B54B63CE
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:23:07 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id ho10so25762756ejc.1
        for <git@vger.kernel.org>; Mon, 28 Nov 2022 05:23:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6jP6UTyFHJqvCjiW0BKRHpAH9lzMo+wt0mGFa0QJO7s=;
        b=fSyFGoJ5402miWFFx3NX9kmnoOvWLY0RsGGzEKc3AHd4Ly5vf9GfD/DVpqRB0Zi5oM
         4Y8neBbz3ToRkLwnwQh61rm0hOgZSHzMlKRc2nv6kIb6p2H63QST35XXd2+0BNJB2se/
         KYilUrXV+hwxuekwLjpccm2EToWO2QgnKb11aAQuiYUBLC2JBxMcARGYHvYS/cZSWMQ5
         iF+R/NPaywMF07It0XqOy59SGOYXJVBnGpmQyJgAlGpOM58B/qh+MhBxgfcQEg46pWAB
         +won4QYuZqnfT9ID7nQ5iSc9r9+ntMLhS8ImuPCU9DJTBxS58PlpGB+Rj/kp+C6m6Q8p
         Qswg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jP6UTyFHJqvCjiW0BKRHpAH9lzMo+wt0mGFa0QJO7s=;
        b=8Ew6wL+OhvG7jnAosLOqXxtPIo1n4ZdJJvF3JuRsQEcxJS1RoNBnoEpWRekj566eIC
         apZqBPmSVy04B7Bh6x4xcd/OSSWLx7tHyKpiPqxBxVdguzdxi+lap/E5pKI/Yao68E6j
         3bDTIs3xC0UlubmVyT4HZSWpmIAmoACNB62W9vLPtTXUsR2dFGRgSfw4TR6B966X8mmZ
         7wAyHDx7h1NJVD2AfSUpMhaLmmvifKKQMnZFD4xKg1HTEXsWQf05IKADaec/VrCqZgC6
         1Wvg3AgIhmuKoboUsO7GhKfRqKcMtgFWvHg5QPHYdhVuD4Q+T6gCozYSpiliyJ5bJjo0
         avgQ==
X-Gm-Message-State: ANoB5pnpp4TQ2waD1V/v65GJe2Sv/UrH7ntxkboUOTSWuaCg+MzGCYiu
        rLtqXNOMh2prx0Vs+Pby2scUQ8/k93/R4Q==
X-Google-Smtp-Source: AA0mqf6+FFgrQsaaT/t+ElIs3S3iHDh7A1Y+yMHUbk5a65GkBaHtqA1pNQl6Wk4C0vaixb6onubvMA==
X-Received: by 2002:a17:906:f204:b0:79e:8f4a:c5b3 with SMTP id gt4-20020a170906f20400b0079e8f4ac5b3mr26959766ejb.223.1669641785899;
        Mon, 28 Nov 2022 05:23:05 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id m25-20020aa7c499000000b00462bd673453sm5180843edq.39.2022.11.28.05.23.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Nov 2022 05:23:05 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oze6C-0013Y8-2I;
        Mon, 28 Nov 2022 14:23:04 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2 3/3] t1301: do not change $CWD in "shared=all" test case
Date:   Mon, 28 Nov 2022 14:18:45 +0100
References: <20221127145130.16155-1-worldhello.net@gmail.com>
 <20221128130323.8914-4-worldhello.net@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <20221128130323.8914-4-worldhello.net@gmail.com>
Message-ID: <221128.86ilizkybr.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Nov 28 2022, Jiang Xin wrote:

> From: Jiang Xin <zhiyou.jx@alibaba-inc.com>
>
> In test case "shared=all", the working directory is permanently changed
> to the "sub" directory. This leads to a strange behavior that the
> temporary repositories created by subsequent test cases are all in this
> "sub" directory, such as "sub/new", "sub/child.git". If we bypass this
> test case, all subsequent test cases will have different working
> directory.
>
> Besides, all subsequent test cases assuming they are in the "sub"
> directory do not run any destructive operations in their parent
> directory (".."), and will not make damage out side of $TRASH_DIRECTORY.
>
> So it is a safe change for us to run the test case "shared=all" in
> current repository instead of creating and changing to "sub".
>
> For the next test case, we no longer run it in the "sub" repository
> which is initialized from an empty template, we should not assume the
> path ".git/info" is missing. So add option "-p" to mkdir.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> ---
>  t/t1301-shared-repo.sh | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index 1225abbb6d..fd10c139f5 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -46,8 +46,6 @@ do
>  done
>  
>  test_expect_success 'shared=all' '
> -	mkdir sub &&
> -	cd sub &&
>  	git init --template= --shared=all &&
>  	test 2 = $(git config core.sharedrepository)
>  '
> @@ -57,7 +55,7 @@ test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
>  	git add a1 &&
>  	test_tick &&
>  	git commit -m a1 &&
> -	mkdir .git/info &&
> +	mkdir -p .git/info &&
>  	umask 0277 &&
>  	git update-server-info &&
>  	actual="$(ls -l .git/info/refs)" &&

I think this approach goes against the effort to implicitly stop relying
on templates. See 3d3874d537a (Merge branch 'ab/test-without-templates',
2022-07-18) for commits related to that.

I think better thing to do here is to squash this in:
	
	diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
	index 0b3722aa149..b7222b7bc07 100755
	--- a/t/t1301-shared-repo.sh
	+++ b/t/t1301-shared-repo.sh
	@@ -8,6 +8,7 @@ test_description='Test shared repository initialization'
	 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
	 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
	 
	+TEST_CREATE_REPO_NO_TEMPLATE=1
	 . ./test-lib.sh
	 
	 # Remove a default ACL from the test dir if possible.
	@@ -55,7 +56,7 @@ test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
	 	git add a1 &&
	 	test_tick &&
	 	git commit -m a1 &&
	-	mkdir -p .git/info &&
	+	mkdir .git/info &&
	 	umask 0277 &&
	 	git update-server-info &&
	 	actual="$(ls -l .git/info/refs)" &&

I.e. before we'd not reply on the template, as we created a directory
manually, but now we're using the standard templated "git init", so
AFAICT the first hunk here could be taken, and this could be squashed
into the second hunk instead:

	diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
	index 0b3722aa149..d4315b5ef5a 100755
	--- a/t/t1301-shared-repo.sh
	+++ b/t/t1301-shared-repo.sh
	@@ -55,7 +55,6 @@ test_expect_success POSIXPERM 'update-server-info honors core.sharedRepository'
	 	git add a1 &&
	 	test_tick &&
	 	git commit -m a1 &&
	-	mkdir -p .git/info &&
	 	umask 0277 &&
	 	git update-server-info &&
	 	actual="$(ls -l .git/info/refs)" &&

I.e. before your change we went from knowing that we're crafting a
custom repo, to saying that we're unsure what we're doing by using the
"mkdir -p".

But can't we just use "TEST_CREATE_REPO_NO_TEMPLATE=1" then, and avoid
the "cd sub?"
