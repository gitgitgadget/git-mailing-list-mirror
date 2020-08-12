Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 522C9C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:10:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22D222076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 23:10:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Cruw79jL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHLXK2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 19:10:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgHLXK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 19:10:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EE91C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id g33so1818682pgb.4
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 16:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lWU2Ssp0VI544yMluqkhjYar2taJYC7z+QXMwlWQWJI=;
        b=Cruw79jL7k/yxPit5XMeM4sC/f2f2+f0+Jk08E6WEmyMYhyI0vzStE+zuSESy2ojVi
         PRtOP0aO8rgU2yF2UXrEdD/RUEqCteHIpH8UD+r58NOuzAJQ4O5TjqGX4jchtq0YWkQ4
         DlVZx4w6VSliYZMtkA9G/quatAazWIwNHrtlV693ourcvKKN0GPrJtxalBIhPY6nZLeW
         NnKwUm+28palB6Lo7tKY92duistTdwepdRU9Kq87zgMOWMsI19lRcphO9HkxWAGKdVz4
         wBqV1/cyD4p8iNST8KtUOxR7S+OfAVwYSYgR5mfqAx02qO3xYZbzQVlk+tioQR7sgwGU
         aOJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lWU2Ssp0VI544yMluqkhjYar2taJYC7z+QXMwlWQWJI=;
        b=XjmrsRR0jQqQe6V3Q61mlnkpxYkp9XeP9lCGegffvRO8W34EiDdKaGZbXxgDbJm007
         KGpI/x9rZ3FCtnpBqoHQ9lQV9I8+VBtrQLRbMu+USCNrlVjmQPoyI1jE/R5SKj7ukCNi
         HXZwePklbeWosXDfXSjwvdfLVGkqrt+rP0po5/htwqmraw/ENtuxER04eqGGqY62YRjn
         ggkoNAogm8L4E7S9pyfoKr6inzfpjfrEfQw6UiUWZxIvFwLK7oQfOls1z9iwyOrjgJOu
         tIUHz04/u+L3D/P+bPcWXs41yyMCWl4wVVQbzc6LK9LfDuvNTUZqgkhD4B126FcwK0sr
         Q92A==
X-Gm-Message-State: AOAM530LUk5ZgQLfvqspYxLKQE3SW1oK8QPZ60EsTcjh6jHpagRkTeaL
        1HPzeUf7qA9Id6XKYVt63GN3ow==
X-Google-Smtp-Source: ABdhPJzKx2lkeCNfIFIwMgWCNNbCJskjZ7MZ1fBIrAQi16EnA/AT5irij+HNpD3xQpt2L6lPSZ2EnA==
X-Received: by 2002:a63:8249:: with SMTP id w70mr1247215pgd.293.1597273826738;
        Wed, 12 Aug 2020 16:10:26 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id q25sm3378553pfn.181.2020.08.12.16.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 16:10:26 -0700 (PDT)
Date:   Wed, 12 Aug 2020 16:10:21 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/9] fetch: optionally allow disabling FETCH_HEAD update
Message-ID: <20200812231021.GG2965447@google.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
 <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83401c52002716084b9c53a77c9d57b6009f84e2.1596731424.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Note: like last time, this was the subject of our team's review club
this week, so I'll try to cite individual comments. -Emily]

On Thu, Aug 06, 2020 at 04:30:16PM +0000, Junio C Hamano via GitGitGadget wrote:
> 
> +fetch.writeFetchHEAD::
> +	Setting it to false tells `git fetch` not to write the list
> +	of remote refs fetched in the `FETCH_HEAD` file directly
> +	under `$GIT_DIR`.  Can be countermanded from the command
> +	line with the `--[no-]write-fetch-head` option.  Defaults to
> +	true.

[jrnieder] Is providing a config option creating more trouble than
benefit? Is this a burden on script authors that they need to check the
config state, when instead they could just pass the flag? Or rather,
because of the config, the script author has to pass the flag explicitly
anyways.
[emily] removing the config also clears up the confusion around 'git pull' +
'fetch.writeFetchHEAD' I commented on later.

> @@ -895,7 +902,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
>  	const char *what, *kind;
>  	struct ref *rm;
>  	char *url;
> -	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
> +	const char *filename = (!write_fetch_head
> +				? "/dev/null"
> +				: git_path_fetch_head(the_repository));

[emily] Huh. so what does the dry_run codepath look like now? It looks
like it's been superseded by write_fetch_head but the option parse
doesn't tell dry_run to update write_fetch_head instead. (Found the
answer later, see below)

> @@ -1797,6 +1806,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>  	if (depth || deepen_since || deepen_not.nr)
>  		deepen = 1;
>  
> +	/* FETCH_HEAD never gets updated in --dry-run mode */
> +	if (dry_run)
> +		write_fetch_head = 0;

[emily] Aha, here is where dry_run informs write_fetch_head. I wonder if
there's a way to instead tell the options struct that --dry-run ~=
--write-fetch-head?

> +test_expect_success '--write-fetch-head gets defeated by --dry-run' '
> +	rm -f .git/FETCH_HEAD &&
> +	git fetch --dry-run --write-fetch-head . &&
> +	! test -f .git/FETCH_HEAD
> +'

[emily] Would it make more sense to make these args mutually exclusive?
[jrnieder] If someone specifies both, then they probably want to say
"show me what I would write to FETCH_HEAD but don't actually do that" -
which isn't info that we print anyways, right now.

> +
> +test_expect_success 'fetch.writeFetchHEAD and FETCH_HEAD' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=no fetch . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD gets defeated by --dry-run' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=yes fetch --dry-run . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD and --no-write-fetch-head' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=yes fetch --no-write-fetch-head . &&
> +	! test -f .git/FETCH_HEAD
> +'
> +
> +test_expect_success 'fetch.writeFetchHEAD and --write-fetch-head' '
> +	rm -f .git/FETCH_HEAD &&
> +	git -c fetch.writeFetchHEAD=no fetch --write-fetch-head . &&
> +	test -f .git/FETCH_HEAD
> +'
[jrnieder] Thanks for being thorough about these.

> +test_expect_success 'git pull --no-write-fetch-head fails' '
> +	mkdir clonedwfh &&
> +	(cd clonedwfh && git init &&
> +	test_must_fail git pull --no-write-fetch-head "../parent" >out 2>err &&
> +	test_must_be_empty out &&
> +	test_i18ngrep "no-write-fetch-head" err)

Should this be shown as a usage error instead of a die()?

> +'
> +
> +test_expect_success 'git pull succeeds with fetch.writeFetchHEAD=false' '
> +	mkdir clonedwfhconfig &&
> +	(cd clonedwfhconfig && git init &&
> +	git config fetch.writeFetchHEAD false &&
> +	git pull "../parent" >out 2>err &&
> +	grep FETCH_HEAD err)

[emily] I guess it's a little surprising that my config is being overridden
without any warning... although pull can't possibly work if FETCH_HEAD
isn't updated. I am conflicted about this use case..
[jrnieder] This is another argument to drop the config from this patch,
unless we are thinking of changing the default behavior of
--[no-]write-fetch-head.

