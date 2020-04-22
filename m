Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF754C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:35:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA809206E9
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 08:35:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BFHDKzfd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDVIfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 04:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDVIfz (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 22 Apr 2020 04:35:55 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20BEDC03C1A6
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 01:35:54 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o19so1570220qkk.5
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 01:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0Gpd2e/Og7SflhZSJllwZIoq2coczL7RERWqM57d4lI=;
        b=BFHDKzfdpi3QUsHIU1LnZPJnxNMraGx82+uiHzpRfK59KiBp72tWEaf4LLlztH4tbr
         gI7vAs123E75ip1cDmoWLtoBkjhzFiOAFIc12YVr2x1bVe9K4OUJTbtGqgaGGC4aAwQB
         IpFrlcPvPdaJ4kYIfjdcrzTEpPdOGkcvG2vjwX4haxkeRK9JCn2CwgE0AwRtp29txZ0g
         VwI71HVi5SvsVtwPmJUXShWOOi9NYnMXRq4YnwncsGtK+vfPdP2D6EUaIRAjlwqlhaU5
         HcQBrR7TdsXH5oNEpccqFPqUgR4usQlUwyFQTJmua3d60ijVUqednQUYx7n5ebtvHPRl
         vliQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=0Gpd2e/Og7SflhZSJllwZIoq2coczL7RERWqM57d4lI=;
        b=QVmyzZDgTTuj2Tn+8NwIf5TOVbURbcBDIMcvmPVph6Yt1yhrBc8r3Ph5N8VMN5cBa8
         7GvQCKn/wmMkV/c7Umtr7h4k3QOXnPCXMOLpYxtQjsN6uzUiGgWLr00VaXDvJfU7YWzY
         aYjWULMQlJ0XGae5nVPuR8XqrMKilv42BfR89suhtizRMAOtvOKBgZWlgvqvuhfJKpxn
         nWOivvXNUJVIW+393dKd83hAjXeGZCxlySK+fOPBwGL9K3HtO/KHTyXX7dBsKF9NjDSq
         miXQr5bNY7w8hJZ2/lbntvuM+iLctitUGXTbGJwTX07i/BfKeda5Z5vhUmabZkhukn2p
         z+6Q==
X-Gm-Message-State: AGi0PubPw8/zRv/aaQn2Q/GfuwR//wL0K25PmiyrcYz+Yw1BH4iQEmiR
        4Ol6gnxqRUkpx5C6HM0rWKvBx7aM
X-Google-Smtp-Source: APiQypIeO8q8TmmI1tfZgjDfJteDUIqSAJHRKJMj6NChf6MsB0jiAKZlTq4uptWMVNFIjtyDPq1MKA==
X-Received: by 2002:a37:6594:: with SMTP id z142mr15131572qkb.55.1587544553178;
        Wed, 22 Apr 2020 01:35:53 -0700 (PDT)
Received: from generichostname ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id o67sm3522363qkc.2.2020.04.22.01.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 01:35:52 -0700 (PDT)
Date:   Wed, 22 Apr 2020 04:35:50 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 8/8] t9902: don't use `test_must_fail __git_*`
Message-ID: <20200422083550.GA12348@generichostname>
References: <cover.1587372771.git.liu.denton@gmail.com>
 <6cfa2c447e1196d6c4325aff9fac52434d10fda8.1587372771.git.liu.denton@gmail.com>
 <60627dc6-fb9c-549f-d76d-0e110c5b0de2@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60627dc6-fb9c-549f-d76d-0e110c5b0de2@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Tue, Apr 21, 2020 at 11:16:09PM +0200, Johannes Sixt wrote:
> Am 20.04.20 um 10:54 schrieb Denton Liu:
> > We should only use test_must_fail() to test git commands. Replace
> > `test_must_fail` with `!` so that we don't use test_must_fail() on the
> > completion functions.
> > 
> > This is done because test_must_fail() is used to except git exiting with
> > an expected error but it will still return an error if it detects
> > unexpected errors such as a segfault. In the case of these completion
> > functions, the return codes of the git commands aren't checked and, most
> > of the time, they will just explicitly return 1 or have an unrelated
> > command return 0. As a result, it doesn't really make sense to use
> > `test_must_fail` so use `!` instead.
> > 
> > Signed-off-by: Denton Liu <liu.denton@gmail.com>
> > ---
> >  t/t9902-completion.sh | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> > 
> > diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
> > index 5505e5aa24..320c755971 100755
> > --- a/t/t9902-completion.sh
> > +++ b/t/t9902-completion.sh
> > @@ -294,7 +294,7 @@ test_expect_success '__git_find_repo_path - "git -C" while .git directory in par
> >  test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
> >  	(
> >  		__git_C_args=(-C non-existing) &&
> > -		test_must_fail __git_find_repo_path &&
> > +		! __git_find_repo_path &&
> >  		printf "$__git_repo_path" >"$actual"
> >  	) &&
> >  	test_must_be_empty "$actual"
> > @@ -303,7 +303,7 @@ test_expect_success '__git_find_repo_path - non-existing path in "git -C"' '
> >  test_expect_success '__git_find_repo_path - non-existing path in $__git_dir' '
> >  	(
> >  		__git_dir="non-existing" &&
> > -		test_must_fail __git_find_repo_path &&
> > +		! __git_find_repo_path &&
> >  		printf "$__git_repo_path" >"$actual"
> >  	) &&
> >  	test_must_be_empty "$actual"
> > @@ -313,7 +313,7 @@ test_expect_success '__git_find_repo_path - non-existing $GIT_DIR' '
> >  	(
> >  		GIT_DIR="$ROOT/non-existing" &&
> >  		export GIT_DIR &&
> > -		test_must_fail __git_find_repo_path &&
> > +		! __git_find_repo_path &&
> >  		printf "$__git_repo_path" >"$actual"
> >  	) &&
> >  	test_must_be_empty "$actual"
> > @@ -362,7 +362,7 @@ test_expect_success '__git_find_repo_path - not a git repository' '
> >  		cd non-repo &&
> >  		GIT_CEILING_DIRECTORIES="$ROOT" &&
> >  		export GIT_CEILING_DIRECTORIES &&
> > -		test_must_fail __git_find_repo_path &&
> > +		! __git_find_repo_path &&
> >  		printf "$__git_repo_path" >"$actual"
> >  	) &&
> >  	test_must_be_empty "$actual"
> > @@ -381,7 +381,7 @@ test_expect_success '__gitdir - finds repo' '
> >  test_expect_success '__gitdir - returns error when cannot find repo' '
> >  	(
> >  		__git_dir="non-existing" &&
> > -		test_must_fail __gitdir >"$actual"
> > +		! __gitdir >"$actual"
> >  	) &&
> >  	test_must_be_empty "$actual"
> >  '
> > @@ -608,7 +608,7 @@ test_expect_success '__git_is_configured_remote' '
> >  	git remote add remote_2 git://remote_2 &&
> >  	(
> >  		verbose __git_is_configured_remote remote_2 &&
> > -		test_must_fail __git_is_configured_remote non-existent
> > +		! __git_is_configured_remote non-existent
> >  	)
> >  '
> >  
> > 
> 
> I actually think that the use of test_must_fail has some merit in these
> cases, because the shell function __git_find_repo_path runs `git
> rev-parse` behind the scenes, and it runs it in such a way that
> test_must_fail would do the right thing: the function just dispatches
> into a handful of simple cases, each basically only with a variable
> assignment, two of them in the form
> 
> 	var=$(git rev-parse ...)
> 
> I would suggest to drop this patch.

Thanks for the analysis. I agree with you. I think it's good to avoid
using test_must_fail unnecessarily but it wouldn't hurt to err on the
side of caution when we're potentially wrapping a git command (like in
this case).

In a future patch where I disable test_must_fail except for approved
commands, I'll add __git* commands to the whitelist.

Thanks,

Denton

> -- Hannes
