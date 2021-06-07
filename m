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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEC2C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 10:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26D5C61073
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 10:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhFGKws (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 06:52:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230127AbhFGKwr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 06:52:47 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE08C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 03:50:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id ci15so25862947ejc.10
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=z/yZHFbOuw5IYanhYP74ViP0KjlSDSY22LQozm9/pR4=;
        b=YL5jeAr4kUrGEKceaxj5l3IZzUxIOTCITBt131N3ZXGlxVVx9caeo5kpZOx0pQb5ks
         GDKWmlNPAE1xMMI1JBsMetN/LKOYcVVLv8Vh1MpfZ+FYlBPxM19NxGdAsEeqQ2AusUvd
         WWXZd47mtGHunS/C5/jFtP04DYa1xy9q6pBKFDG7DmkcwTs0Sm/Tf6LSHhCET7jsrK8W
         qK2dxDfIY+uBdavxbO45At0xZE9UAE3W0tVoleCLEIwikdilSLjqXqHGfVrhJGlGqZe7
         233FuNzL/bRT+eXXUOkO3oFyNaueeh2wy0oCXkTvtlSEHQv/RkdQb0kGqazGsqTtYj0T
         rGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=z/yZHFbOuw5IYanhYP74ViP0KjlSDSY22LQozm9/pR4=;
        b=b4iN1Ow6cdMirDBwoQwWMdPkyNyFK0fkwvtCEH9XRCH5A4Wl7TyMF8rF5tr8DLTyG9
         E5IK0EMQh8akydAngfcgVT8JI7YiYkL5jvsW20c9jSAfEOW/p9GAJeBq/HpRZrc/Cvk2
         JST6HgZ/oofrORWBN5KpPGBTqdfjRa8wgjfMCpGgopmHxgoggzzf52iK+b17S1aYoRWy
         AFpazJZ1W1+X2ncdUoeTK2eoJKRIQNPfZ2IJnQqKG8oKmR5L+2dqn+Q8R4+kj/vI/rf1
         vGrJzU+iiU0td4UWGWIo4Hwt4MOUJuU0C6zmIkd0qOqMJ9Q5N43EmCicCW6SwBeLxv8y
         N7CA==
X-Gm-Message-State: AOAM5322kBeuhU/HVkMWyG0ubVudWQ8RE2xAUroU/wge0OR2fMy/5w4h
        Kp8NESNpEnv63wh1Dai3FDU=
X-Google-Smtp-Source: ABdhPJyPvoGEMfMXMbWQGXhDBI5vQCT/0B/rhvFld2RNGRf2sXTNPHdiSluxZovc4uCD5lduOqH39g==
X-Received: by 2002:a17:906:7712:: with SMTP id q18mr17708521ejm.10.1623063045565;
        Mon, 07 Jun 2021 03:50:45 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id w17sm7313242edd.44.2021.06.07.03.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 03:50:45 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] rerere: enable by default
Date:   Mon, 07 Jun 2021 11:50:35 +0200
References: <xmqqfsxvxjj2.fsf@gitster.g>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <xmqqfsxvxjj2.fsf@gitster.g>
Message-ID: <877dj654or.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jun 06 2021, Junio C Hamano wrote:

> By default, the rerere machinery has been disabled since a bug in
> the machinery could screw up the end user's data at the most
> stressful time during the end user's workday (i.e. during conflict
> resolution).

What was that bug & in what commit was it fixed? Makes sense to note
that here.

> It however has been in wide use without causing much trouble (other
> than, obviously, replaying a broken conflict resolution that was
> recorded earlier when the user made a mismerge), and it is about
> time to enable it by default.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config/rerere.txt |  5 ++---
>  rerere.c                        | 12 +++---------
>  t/t2030-unresolve-info.sh       |  3 +++
>  3 files changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/Documentation/config/rerere.txt b/Documentation/config/rerere.txt
> index 40abdf6a6b..45e97fc0fa 100644
> --- a/Documentation/config/rerere.txt
> +++ b/Documentation/config/rerere.txt
> @@ -7,6 +7,5 @@ rerere.enabled::
>  	Activate recording of resolved conflicts, so that identical
>  	conflict hunks can be resolved automatically, should they be
>  	encountered again.  By default, linkgit:git-rerere[1] is
> -	enabled if there is an `rr-cache` directory under the
> -	`$GIT_DIR`, e.g. if "rerere" was previously used in the
> -	repository.
> +	enabled, but this configuration can be set to 'false' to
> +	turn it off.
> diff --git a/rerere.c b/rerere.c
> index d83d58df4f..83e740d730 100644
> --- a/rerere.c
> +++ b/rerere.c
> @@ -18,8 +18,7 @@
>  #define THREE_STAGED 2
>  void *RERERE_RESOLVED = &RERERE_RESOLVED;
>  
> -/* if rerere_enabled == -1, fall back to detection of .git/rr-cache */
> -static int rerere_enabled = -1;
> +static int rerere_enabled = 1; /* default to true */
>  
>  /* automatically update cleanly resolved paths to the index */
>  static int rerere_autoupdate;
> @@ -852,16 +851,11 @@ static GIT_PATH_FUNC(git_path_rr_cache, "rr-cache")
>  
>  static int is_rerere_enabled(void)
>  {
> -	int rr_cache_exists;
> -
>  	if (!rerere_enabled)
>  		return 0;
>  
> -	rr_cache_exists = is_directory(git_path_rr_cache());
> -	if (rerere_enabled < 0)
> -		return rr_cache_exists;
> -
> -	if (!rr_cache_exists && mkdir_in_gitdir(git_path_rr_cache()))
> +	if (!is_directory(git_path_rr_cache()) &&
> +	    mkdir_in_gitdir(git_path_rr_cache()))
>  		die(_("could not create directory '%s'"), git_path_rr_cache());
>  	return 1;
>  }
> diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
> index be6c84c52a..8c571ddf92 100755
> --- a/t/t2030-unresolve-info.sh
> +++ b/t/t2030-unresolve-info.sh
> @@ -46,6 +46,7 @@ prime_resolve_undo () {
>  }
>  
>  test_expect_success setup '
> +	git config rerere.enabled false &&
>  	mkdir fi &&
>  	printf "a\0a" >binary &&
>  	git add binary &&
> @@ -127,6 +128,8 @@ test_expect_success 'unmerge with plumbing' '
>  '
>  
>  test_expect_success 'rerere and rerere forget' '
> +	# from here on, use rerere.
> +	git config rerere.enabled true &&
>  	mkdir .git/rr-cache &&
>  	prime_resolve_undo &&
>  	echo record the resolution &&

It seems strange to disable it at the very beginning, but then not have
any test until you turn it on actually rely on that except that "mkdir"
in the second hunk, i.e. this on top works:
	
	diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
	index 8c571ddf92..7195ded9f9 100755
	--- a/t/t2030-unresolve-info.sh
	+++ b/t/t2030-unresolve-info.sh
	@@ -46,7 +46,6 @@ prime_resolve_undo () {
	 }
	 
	 test_expect_success setup '
	-	git config rerere.enabled false &&
	 	mkdir fi &&
	 	printf "a\0a" >binary &&
	 	git add binary &&
	@@ -130,7 +129,6 @@ test_expect_success 'unmerge with plumbing' '
	 test_expect_success 'rerere and rerere forget' '
	 	# from here on, use rerere.
	 	git config rerere.enabled true &&
	-	mkdir .git/rr-cache &&
	 	prime_resolve_undo &&
	 	echo record the resolution &&
	 	git rerere &&

So the only impact of that rerere.enabled=false early is to make sure
we're not creating the .git/rr-cache.

Those tests will fail if we turned on rerere.autoUpdate=true there, so
isn't it a better test coverage to assert that even with
rerere.enabled=true we don't impact these merge resolutions in the
earlier tests?

It also seems to make sense to change the main rerere tests to assert
that we have the default set to this new value, i.e.:
	
	diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
	index 9f8c76dffb..f319f08852 100755
	--- a/t/t4200-rerere.sh
	+++ b/t/t4200-rerere.sh
	@@ -89,8 +89,8 @@ test_expect_success 'activate rerere, old style (conflicting merge)' '
	 '
	 
	 test_expect_success 'rerere.enabled works, too' '
	+	test_path_is_dir .git/rr-cache &&
	 	rm -rf .git/rr-cache &&
	-	git config rerere.enabled true &&
	 	git reset --hard &&
	 	test_must_fail git merge first &&
	 
	@@ -100,8 +100,8 @@ test_expect_success 'rerere.enabled works, too' '
	 '
	 
	 test_expect_success 'set up rr-cache' '
	+	test_path_is_dir .git/rr-cache &&
	 	rm -rf .git/rr-cache &&
	-	git config rerere.enabled true &&
	 	git reset --hard &&
	 	test_must_fail git merge first &&
	 	sha1=$(perl -pe "s/	.*//" .git/MERGE_RR) &&
	@@ -668,7 +668,6 @@ test_expect_success 'test simple stage 1 handling' '
	 	(
	 		cd stage_1_handling &&
	 
	-		git config rerere.enabled true &&
	 		git checkout A^0 &&
	 		test_must_fail git merge B^0
	 	)

As an aside: This pre-dates your change here, but I thought the config
reading in rerere.c was a bit odd, why do we call the one-off config
reading functions when we're about to iterate over the whole set anyway?
Turns out we did it the way I'd expect before 633e5ad326 (rerere.c:
replace `git_config()` with `git_config_get_*()` family, 2014-08-07).
