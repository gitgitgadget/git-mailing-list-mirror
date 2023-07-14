Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42DF3EB64DC
	for <git@archiver.kernel.org>; Fri, 14 Jul 2023 23:38:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbjGNXiZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jul 2023 19:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjGNXiY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2023 19:38:24 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D30DA3A92
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 16:38:23 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6689430d803so1765547b3a.0
        for <git@vger.kernel.org>; Fri, 14 Jul 2023 16:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689377903; x=1691969903;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t6DHpVdFJId4SXZd9ZUFyxCQYwiiThFk33SS+Kr4NmM=;
        b=cYHaRVyiv2F/pMeCnV/5elZw+M0P2npWhr0kOI64M1S+/Gf+90atd0N60sl0YyalhB
         BoIDrGj3PeOVgTyqQ5WMFiE2EWfn5Q7lauhplOVpCBF4H36lk8JvFNAm0/UP2FlTbjq8
         BAQ3eR2lvgIdfejXrcUsJ8ls/BYqCWLQJh83FBYLRl1B8yGMISh0QmfM2/UgCezgWUHo
         iep+MnOhH9ImBcU/ioFTMUYvInOKI/1WV2m1ftFBLG5bqqFOM9lsF0bydswOZH4b9qko
         qeQ3SdgBJYjx6NN+T54YMsVIdJoZyHQgvE4GJ3ODKPJoTJvmI3NmNyNkLU43rkNhSbr9
         mIow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689377903; x=1691969903;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t6DHpVdFJId4SXZd9ZUFyxCQYwiiThFk33SS+Kr4NmM=;
        b=Nxe5+GKiVa7ih8mpHt2/e4oEXOgqVP3kcoE1tOWTNFPuzl/GCRTt8rl+SOggX2jEwj
         Bzuy59ltFE009ojue2bzWbUneaf4k1sLLW3p1Ml1+/aRr1G018mHJTq5aIDxJMRLIsPd
         HKiezrLwn2RE2xduV4FaFgSsY6h67AenscghkrvrSYkjwCCS0lgZmcIxPT68m5LKqCIg
         4IVXu+6uPr7bHEKjb4nduipWeVWFcrjCCO1UAk8Hs3fd3kvb83gw3JGTE8S7tCAJzENB
         gPbjjvY4ICzFvIqV1nBfR5rh7+MuGczUmXWxkMoAgjLqBJrKiWz+senj1z7zZ8PMALwt
         XlQw==
X-Gm-Message-State: ABy/qLah1BRBSuiCv+hrAcWaOD11yiDmvMTwRr2SuL4b2VBsoWNFXrP+
        i1+1X6DY3sUeZ5cwggl9HIkPzA==
X-Google-Smtp-Source: APBJJlHwzC6ClwhYIRwrT4OQ1J3e3v09X8Ql2CZtt5mHr0q2fkDwZ0W7mpzUuAjKpY5Qg/aPG4it+g==
X-Received: by 2002:a05:6a00:3913:b0:67e:bf65:ae68 with SMTP id fh19-20020a056a00391300b0067ebf65ae68mr5619132pfb.3.1689377903141;
        Fri, 14 Jul 2023 16:38:23 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:5363:38df:480d:c7f7])
        by smtp.gmail.com with ESMTPSA id i19-20020aa787d3000000b0063b7f3250e9sm7646431pfo.7.2023.07.14.16.38.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 16:38:22 -0700 (PDT)
Date:   Fri, 14 Jul 2023 16:38:16 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Splitting common-main (Was: Re: [PATCH RFC v2 1/4] common-main:
 split common_exit() into a new file)
Message-ID: <ZLHcaFvvZh88TrLb@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <20230517-unit-tests-v2-v2-1-21b5b60f4b32@google.com>
 <xmqqcz2xtv83.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqcz2xtv83.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi, I'd like to revisit this as it's also relevant to a non-unit-test
issue (`make fuzz-all` is currently broken). I have some questions
inline below:

On 2023.05.18 10:17, Junio C Hamano wrote:
> steadmon@google.com writes:
> 
> > It is convenient to have common_exit() in its own object file so that
> > standalone programs may link to it (and any other object files that
> > depend on it) while still having their own independent main() function.
> 
> I am not so sure if this is a good direction to go in, though.  The
> common_exit() function does two things that are very specific to and
> dependent on what Git runtime has supposed to have done, like
> initializing trace2 subsystem and linking with usage.c to make
> bug_called_must_BUG exist.

True. We won't call common_exit() unless we're trying to exit() from a
file that also includes git-compat-util.h, but I guess that's not a
guarantee that trace2 is initialized or that usage.o is linked.

> I understand that a third-party or standalone non-Git programs may
> want to do _more_ than what our main() does when starting up, but it
> should be doable if make our main() call out to a hook function,
> whose definition in Git is a no-op, that can be replaced by their
> own implementation to do whatever they want to happen in main(), no?
> 
> The reason why I am not comfortable with this patch is because I
> cannot say why this split is better than other possible split.  For
> example, we could instead split only our 'main' out to a separate
> file, say "main.c", and put main.o together with common-main.o to
> libgit.a to be found by the linker, and that arrangement will also
> help your "standalone programs" having their own main() function.
> Now with these two possible ways to split (and there may be other
> split that may be even more convenient; I simply do not know), which
> one is better, and what's the argument for each approach?

Sorry, I don't think I'm understanding your proposal here properly,
please let me know where I'm going wrong: isn't this functionally
equivalent to my patch, just with different filenames? Now main() would
live in main.c (vs. my common-main.c), while check_bug_if_BUG() and
common_exit() would live in common-main.c (now a misnomer, vs. my
common-exit.c). I'm not following how that changes anything so I'm
pretty sure I've misunderstood.

The issue I was trying to solve (whether for a unit-test framework or
for the fuzzing engine) is that we don't have direct control over their
main(), and so we can't rename it to avoid conflicts with our main().

I guess there may be some linker magic we could do to avoid the conflict
and have (our) main() call (their, renamed) main()? I don't know offhand
if that's actually possible, just speculating. Even if possible, it
feels more complicated to me, but again that may just be due to my lack
of linker knowledge.
