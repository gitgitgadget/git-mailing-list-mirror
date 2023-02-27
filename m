Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA583C64ED8
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 22:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbjB0WO6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 17:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjB0WO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 17:14:57 -0500
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2157A28849
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 14:14:55 -0800 (PST)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-536bbaeceeaso167513007b3.11
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 14:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Gn45mtGxwflo+04uta6DozOK4lBeJw4VGC4C5rV22x4=;
        b=WyvPAVdxMh67+Zv83/f14iUDCeekCMQ4RaGbqTp+hE2YvPCJGtGphZ8NUSO7GaAEMY
         BOwV3TEnPgXYEY+iSVklPx0A99OGiI0PJLNzpL5STYUpplr3GeLyyRDhm7V3vm0zXdTw
         ZDRWJckAJfZkLgpbhxWyuQudNbHWLxqXYsxkOeboYIkhMRoQi0vbJpF21d4JucXOqfuI
         ZsdKdfy8cQ7/ztCIZk7EJPIWAMFux4CSZXSEOAEiqj7JtHpNTGhn/Bj66g3m+HGZ+zoq
         XNJjB3k6N+IqNBHu+iDl7ZIW0qlBDFVgWpZbParkFKPY1aZBsxXWTUwmP4TsFltv+G6r
         FlcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gn45mtGxwflo+04uta6DozOK4lBeJw4VGC4C5rV22x4=;
        b=QBCnsasY0ofuYD4v+I9usMjKsKKmCQg0YRzsXOjQO5C7CpyQjk4PtuObwUz3Aj23du
         J8ZTMAZDE+boFTAcUO3mjEKtNh9xRy7UeNfqEbVJbXPRGKKrM/gtIPxuoMFheCWlygJi
         I349SgWicTGuRm8xCihNbmsmSY58l2Lk7D+G5I3yiOjfElHtgDVrxpjGZsoP5Z6HHe06
         0H9joU8kxvEmdsD27Z5BdMhlJT1k1RFug7mNuxulRMz9OWzPIe6JcAPFctMactkRgCwW
         ce8j1uce052OowoASaMZDhzW6yM0ok4wpxHlqDAvIXM1Ovd6FUfDU++0aVKoxxJBV4B9
         hs+g==
X-Gm-Message-State: AO0yUKXtSb4/HKuA7sLvw+RqYmDf/xxBpv/47kSNgVLGrZA7/TPic9Sh
        62pzvY5Jz43HpNwcKfCpHaVMD6QdUXQozh0NuMDb
X-Google-Smtp-Source: AK7set/H08//bPAlDtJQwGMvb1J8P465G1ITel/Qi25U16WEImYvXzd+JlTHsrDi0laFbFDiLg6Hs4xGBudO4dlnwsVD
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:202:e547:b66a:7a19:4376])
 (user=jonathantanmy job=sendgmr) by 2002:a05:6902:101:b0:a4e:4575:f3ec with
 SMTP id o1-20020a056902010100b00a4e4575f3ecmr165664ybh.0.1677536094231; Mon,
 27 Feb 2023 14:14:54 -0800 (PST)
Date:   Mon, 27 Feb 2023 14:14:51 -0800
In-Reply-To: <20230225052439.27096-1-five231003@gmail.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
Message-ID: <20230227221451.2433306-1-jonathantanmy@google.com>
Subject: Re: [PATCH] index-pack: remove fetch_if_missing=0
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:
> A collision test is triggered in sha1_object(), whenever there is an
> object file in our repo. If our repo is a partial clone, then checking
> for this file existence has the behavior of lazy-fetching the object
> because we have one or more promisor remotes.

Hmm...this is not true, because (as you said)...
 
> This behavior is controlled by setting fetch_if_missing to 0,

...this makes it so that we don't fetch in this situation.

> but this
> global was added in the first place as a temporary measure to suppress
> the fetching of missing objects and can be removed once the commands
> have been taught to handle these cases.

Yes, that's true.

> @@ -1728,14 +1727,6 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
>  	int report_end_of_input = 0;
>  	int hash_algo = 0;
>  
> -	/*
> -	 * index-pack never needs to fetch missing objects except when
> -	 * REF_DELTA bases are missing (which are explicitly handled). It only
> -	 * accesses the repo to do hash collision checks and to check which
> -	 * REF_DELTA bases need to be fetched.
> -	 */
> -	fetch_if_missing = 0;

I think that the author of such a commit (you) should also independently
verify that this comment is true (and if it is, then yes, all the
remaining cases are handled and we can remove this assignment to
fetch_if_missing). I believe this comment to be true, but I haven't
checked the code in a while so I'm not sure myself.

> +test_expect_success 'index-pack does not lazy-fetch when checking for sha1 collisions' '
> +	rm -rf server promisor-remote client &&
> +	rm -rf object-count &&
> +
> +	git init server &&
> +	for i in 1 2 3 4
> +	do
> +		echo $i >$(pwd)/server/file$i &&
> +		git -C server add file$i &&
> +		git -C server commit -am "Commit $i" || return 1
> +	done &&
> +	git -C server config --local uploadpack.allowFilter 1 &&
> +	git -C server config --local uploadpack.allowAnySha1InWant 1 &&
> +	HASH=$(git -C server hash-object file3) &&
> +
> +	git init promisor-remote &&
> +	git -C promisor-remote fetch --keep "file://$(pwd)/server" $HASH &&
> +
> +	git clone --no-checkout --filter=blob:none "file://$(pwd)/server" client &&
> +	git -C client remote set-url origin "file://$(pwd)/promisor-remote" &&
> +	git -C client config extensions.partialClone 1 &&
> +	git -C client config remote.origin.promisor 1 &&
> +
> +	# make sure that index-pack is run from within the repository
> +	git -C client index-pack $(pwd)/client/.git/objects/pack/*.pack &&
> +	test_path_is_missing $(pwd)/client/file3
> +'

How does this check that no lazy fetch has occurred? It seems to me
that you're just checking the existence of a file in the worktree,
which does not indicate the presence or absence of a lazy fetch.

I think the way to test needs to be more complicated: you need
to create a partial clone, fetch into it from another repo, and
then verify that no fetches were made to the original partial
clone.

