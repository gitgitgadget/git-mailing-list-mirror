Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE0C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:55:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12DA9206D9
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 12:55:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmM4UzbF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKMMzL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 07:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbgKMMzK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 07:55:10 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A5FC0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:55:10 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id cw8so13225873ejb.8
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 04:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=C81/yQNBdblGXbxxAtu6FxlJe1CsFV/wrjuppe8rIwk=;
        b=hmM4UzbF0igTu+r/dvCAh9tzPPgclPNJgRzuDCO6BwNoOfx3u0dv03lPIp+ktjz8Z9
         zjItQP1cwm7+YgtYucCVs/uT6XHNsd9boY/kAj42YtR0lwz2kEp9L1z7B/Z9JEsh1I++
         KiZnR8ize2VCGkF0I1HXjDVHrVX3KXmfaZmd4AkHGKw8pHTomxDqqBq1nLxx83cq3yyg
         WGnCsYLYNQk92uBMeRwH5BqbUlEQY2xgHUyDVLAlnqml0cPWf7BnR3Tty/ypHO65rGUz
         0QlwI0d5hnElxz2xsESlvUE8giZNzambUKWog0NYthYo5Pnz6d+gcmFuRo17Gs4kxTIJ
         fsYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=C81/yQNBdblGXbxxAtu6FxlJe1CsFV/wrjuppe8rIwk=;
        b=Ojog9kJuIUmMTiuAlyVPqrs+3Z/WW3uEBcVAel3TZig93hMaEGGPthC2I9DNhvCK8a
         FendoNz0HkqUVrj0VEFwyZjgM6cWzcS49DQW9HZO9t7mYj/q0YQsG7bXeDYNEJlcYPBf
         44wFx3BHqphXZEpekkupjxJdXFhajSXCXNMfUAbOngLvdVLbK1ZwE905fakNKjVNPkQ0
         3ipd+oaSXpjDoVNWbYfWxjXGdmGyU+JXo6nF21qXeUsWI51A0tgGSf+nbY3EbgQwMmeR
         VCo1UK+elc+/O3An3ffAkzM0uvtzdeBIsd7LsgofMauW2X2tkqoTIWiqkVMj8TIZEFV3
         VWyw==
X-Gm-Message-State: AOAM533QN5/1hl7GragJPUzYolsj44wdxXuYDI9I3tti6LuffAxkZp0U
        4CCTbI3pWW4fdtL11+9ZQZijHfdkpVw=
X-Google-Smtp-Source: ABdhPJwMyMMZ3beXLua+w5uibvMii0ofBURBCAvfUVAfgst949KiZaMjzglzj6IuPAOcST59+TRU7Q==
X-Received: by 2002:a17:906:b53:: with SMTP id v19mr1709518ejg.136.1605272109176;
        Fri, 13 Nov 2020 04:55:09 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id nd5sm3551666ejb.37.2020.11.13.04.55.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2020 04:55:08 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 00/28] Use main as default branch name
References: <pull.762.git.1605221038.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 26.3; mu4e 1.4.13
In-reply-to: <pull.762.git.1605221038.gitgitgadget@gmail.com>
Date:   Fri, 13 Nov 2020 13:55:07 +0100
Message-ID: <87pn4hfmc4.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Nov 12 2020, Johannes Schindelin via GitGitGadget wrote:

> This is the big one. This changes the default of init.defaultBranch to main,
> reflecting what many open source projects already did (which was followed by
> GitHub, Azure Repos and others).

I don't have an issue with the end goal of s/master/main|$whatever/ as
UX here as noted in previous related review rounds. But I don't think
this series as it stands is anywhere near ready.

This is 27 patches of s/master/main/ in the tests, followed by making
the change to the default in refs.c without as much as a single
documentation update to inform users of the change.

I don't see the point in doing these sorts of test suite changes, it
just seems like needless churn. But I have not read the whole backlog of
previous iterations of this & related patches, so bear with me.

Why not instead do what we did when we added protocol v2 to the tests,
e.g. in 8a1b0978ab ("test: request GIT_TEST_PROTOCOL_VERSION=0 when
appropriate", 2019-12-23) we simply set the t5515 test to always run
with protocol v1. If you'd do this:
    
    diff --git a/t/t5515-fetch-merge-logic.sh b/t/t5515-fetch-merge-logic.sh
    index 70a9d2d8ab..939c8b2f83 100755
    --- a/t/t5515-fetch-merge-logic.sh
    +++ b/t/t5515-fetch-merge-logic.sh
    @@ -11,6 +11,9 @@ test_description='Merge logic in fetch'
     GIT_TEST_PROTOCOL_VERSION=0
     export GIT_TEST_PROTOCOL_VERSION
     
    +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    +
     . ./test-lib.sh
     
     build_script () {
    
Of course that also needs:
    
    index fa347ed3e1..2d700a171b 100644
    --- a/t/test-lib.sh
    +++ b/t/test-lib.sh
    @@ -1711,10 +1711,8 @@ test_lazy_prereq SHA1 '
     test_lazy_prereq REBASE_P '
     	test -z "$GIT_TEST_SKIP_REBASE_P"
     '
    -# Special-purpose prereq for transitioning to a new default branch name:
    -# Some tests need more than just a mindless (case-preserving) s/master/main/g
    -# replacement. The non-trivial adjustments are guarded behind this
    -# prerequisite, acting kind of as a feature flag
    -test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
    -	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = main
    +
    +test_lazy_prereq MAIN_BRANCH_IS_MASTER '
    +	test -z "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" ||
    +	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = "master"
     '

Because (but see "later" a few paragraphs later), the logic as it stands
on "master" is entirely backwards & broken. I.e. if you don't set
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME or set it to "master" we now skip a
bunch of tests ... which only work if the value is "master". If you set
it to "main" they'll break.

Then instead of ending up with a hardcoding of "main" we'd be able to
run the tests with a new custom branch name (even one with whitespace in
it). That coverage is plenty to test any branch name hardcoding.

The remaining tests that would still have "master" would then just be
dealt with by the same thing we did for the too-protocol-v1-specific
tests, i.e.:
    
    diff --git a/t/t3502-cherry-pick-merge.sh b/t/t3502-cherry-pick-merge.sh
    index 8b635a196d..354f9bd851 100755
    --- a/t/t3502-cherry-pick-merge.sh
    +++ b/t/t3502-cherry-pick-merge.sh
    @@ -8,6 +8,8 @@ test_description='cherry picking and reverting a merge
     
     '
     
    +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
    +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     . ./test-lib.sh
     
     test_expect_success setup '
    
Except unlike protocol v1/v2 we're really not gaining anything in
coverage by going further, it's not the point of any of these tests to
test for the default branch name. It's a *lot* of churn, 

"Later": After writing the above I see from 704fed9ea2 ("tests: start
moving to a different default main branch name", 2020-10-23) that this
state of affairs is intentional. But doesn't discuss why the more usual
(because we've done it that way a few times before) v1/v2-esque
transition wasn't done instead.

Doing it the other way still seems better. We're now not running our
full tests in anticipation for this series landing on "master", and
after applying this we're still not running all of them.

Anyway, enough with discussing this detail of the test suite churn. My
main objection to this version of it is:

After this series as it stands lands what's a rather big UI change in
git isn't discussed *anywhere* in the docs.

I'm not saying we need some similar s/master/main/g in Documentation/ as
what's being done here in t/, but I think a bare minimum for a rather
big UI change like this is:

 1) Let's at least talk about it in some way in git-init(1), i.e. that
    it used to be "master" before version so-and-so and is now
    different. With this series applied we still say:

    Documentation/git-init.txt:If not specified, fall back to the default name: `master`.

 2) Ditto in the init.defaultBranch and things like that

 3) After all this effort at eliminating "master" entirely in the tests
    we're still shipping a sample hook that expects "master" on "git
    init", and breaks now that it's "main"

And maybe stuff like:

 4) Have "git init" emit some new advice message saying that the default
    has changed and we've init-ed a new repo with a "main" branch.

Our primary concern should be the vast majority of users who don't
follow this topic on Twitter, don't read this mailing list, and are just
going to waste 10 minutes of their day because some script they've had
working for years using "git init" did something unexpected.

Let's at least aim to make that 5 minutes instead by making the change
more discoverable.
