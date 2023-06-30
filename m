Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD778EB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 22:35:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbjF3WfJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 18:35:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjF3WfI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 18:35:08 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B8373C01
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:35:07 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b80ddce748so13835095ad.3
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 15:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688164506; x=1690756506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xDE5g/8hHr76isXfqTtiBgdg79aDfv+Ri+qSlXzapjM=;
        b=vtliOHGd6WVenSe37VTBvRiB7TWVo0KfhW6JT/xvgoGZ6pygMzHMXmjedoHbXgTZQo
         jGvJzExBXjgjYLhwdw/NboknugivF1IV0qF8NLUeH6dErX8+tJKvI2HmMr8rgQ1X7ynE
         lvhBVU7clJWGE6zcR3WNB2Xkn4aizZiRRDCNPPIPaXQW/9qQaUAImxbqfjrYGNgvyhRu
         R+QqMUCv7Si1Wd/mHX6kpU51YqHy6C4Kw4iZOrW3oATqETtAv2m/ipEaLN8MBQb3vNZO
         NRDIV3hXRCSWLCrMnF7X+F3Pe+b8CNleAsoyZ8x8GmUpphpC7fZAv7GthcC+WVeiq5mc
         cEOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688164506; x=1690756506;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xDE5g/8hHr76isXfqTtiBgdg79aDfv+Ri+qSlXzapjM=;
        b=Pm8hW5FqCY5vv8sPV9AVw/+CH7fw1da7FiKS0Ng9db1kqXBu1djKNn6SOU0LW+Reku
         +VuGif8sCsShzNxnVyPMgZp2YKsXR99F470QtdXw1kuTyXRd1CUrvehIGqaQtMCtMW9z
         q6hny0YoDoWyegv9gKn6KRqJ/4ohfSJDlx/Sp5iGlETP3pDOfwTWQ/018xBRg3Abi2Cw
         8+kbxztipnQdiA/9x7T3qnDLBdN0OBlSNR0SrD1pNw369ZKHchgQiAzYG7xdbY3qui5K
         scJF6vDyF4Bwfh7S5P+IQMKWK3/GLzuYYZtgLq6NFWq/cKVElfIkrUel0+gedWuzpc0J
         tGmg==
X-Gm-Message-State: ABy/qLYcmyRZJXJEIIEa86LMqpyW9lOi6AQPORIClp/gUQaK2ant581m
        +k07Qo1hns1TR5HJb66ovbJHcw==
X-Google-Smtp-Source: APBJJlFyFJJCDEvni9Bzt6ONY0xxf1eqQtnQwCdFF+84abo8QNASByvsP/aNrW9mXrDcetk9b0sUbA==
X-Received: by 2002:a17:902:d4c7:b0:1b8:2ba0:c9c0 with SMTP id o7-20020a170902d4c700b001b82ba0c9c0mr3399969plg.59.1688164506322;
        Fri, 30 Jun 2023 15:35:06 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:202:1498:3821:7231:6e96])
        by smtp.gmail.com with ESMTPSA id ja10-20020a170902efca00b001b83e624eecsm4788976plb.81.2023.06.30.15.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jun 2023 15:35:05 -0700 (PDT)
Date:   Fri, 30 Jun 2023 15:35:01 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, calvinwan@google.com, szeder.dev@gmail.com,
        chooglen@google.com, avarab@gmail.com, gitster@pobox.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
Message-ID: <ZJ9Ylb+/UOtRNKKy@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        calvinwan@google.com, szeder.dev@gmail.com, chooglen@google.com,
        avarab@gmail.com, gitster@pobox.com, sandals@crustytoothpaste.net
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
 <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
 <a99a5134-3bac-64d4-b4e7-f02e8578090a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a99a5134-3bac-64d4-b4e7-f02e8578090a@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2023.06.30 15:07, Phillip Wood wrote:
> Hi Josh
> 
> Thanks for putting this together, I think it is really helpful to have a
> comparison of the various options. Sorry for the slow reply, I was off the
> list for a couple of weeks.

Thank you for the review! Unfortunately I didn't see it in time for any
of these to make it into v4, but I'll keep them all as TODOs.


> On 10/06/2023 00:25, Josh Steadmon wrote:
> > diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> > new file mode 100644
> > index 0000000000..dac8062a43
> > --- /dev/null
> > +++ b/Documentation/technical/unit-tests.txt

> > +== Definitions
> > +
> > +For the purposes of this document, we'll use *test framework* to refer to
> > +projects that support writing test cases and running tests within the context
> > +of a single executable. *Test harness* will refer to projects that manage
> > +running multiple executables (each of which may contain multiple test cases) and
> > +aggregating their results.
> 
> Thanks for adding this, it is really helpful to have definitions for what we
> mean by "test framework" and "test harness" within the git project. It might
> be worth mentioning somewhere that we already use prove as a test harness
> when running our integration tests.

Yeah, I'll try to clarify this, probably not in V4 though. I'll note it
as a remaining TODO.

> > +==== Parallel execution
> > +
> > +Ideally, we will build up a significant collection of unit tests cases, most
> > +likely split across multiple executables. It will be necessary to run these
> > +tests in parallel to enable fast develop-test-debug cycles.
> 
> This is a good point, though I think it is really a property of the harness
> rather than the framework so we might want to indicate in the table whether
> a framework provides parallelism itself or relies on the harness providing
> it.

Same here.

> > [...]
> > +==== Major platform support
> > +
> > +At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
> 
> I think we'd want to be able to run unit tests on *BSD and NonStop as well,
> especially as I think some of the platform dependent code probably lends
> itself to being unit tested. I suspect a framework that covers Linux and
> MacOS would probably run on those platforms as well (I don't think NonStop
> has complete POSIX support but it is hard to imagine a test framework doing
> anything very exotic)

Yes, unfortunately I don't have easy access to either of these, but I'll
try to figure out how to evaluate these.

> > [...]
> > +==== Mock support
> > +
> > +Unit test authors may wish to test code that interacts with objects that may be
> > +inconvenient to handle in a test (e.g. interacting with a network service).
> > +Mocking allows test authors to provide a fake implementation of these objects
> > +for more convenient tests.
> 
> Do we have any idea what sort of thing we're likely to want to mock and what
> we want that support to look like?

Not at the moment. Another TODO for v5.

> > +==== Signal & exception handling
> > +
> > +The test framework must fail gracefully when test cases are themselves buggy or
> > +when they are interrupted by signals during runtime.
> 
> I had assumed that it would be enough for the test harness to detect if a
> test executable was killed by a signal or exited early due to a bug in the
> test script. That requires the framework to have robust support for lazy
> test plans but I'm not sure that we need it to catch and recover from things
> like SIGSEGV.

I think as long as a SIGSEGV in the test code doesn't cause the entire
test run to crash, we'll be OK. Agreed that this is really more of a
harness feature.


> > +==== Coverage reports
> > +
> > +It may be convenient to generate coverage reports when running unit tests
> > +(although it may be possible to accomplish this regardless of test framework /
> > +harness support).
> 
> I agree this would be useful, though perhaps we should build it on our
> existing gcov usage.
> 
> Related to this do we want timing reports from the harness or the framework?

I'll add this as well in V5.

> > +
> > +=== Comparison
> > +
> > +[format="csv",options="header",width="75%"]
> > +|=====
> > +Framework,"TAP support","Diagnostic output","Parallel execution","Vendorable / ubiquitous","Maintainable / extensible","Major platform support","Lazy test planning","Runtime- skippable tests","Scheduling / re-running",Mocks,"Signal & exception handling","Coverage reports"
> > +https://lore.kernel.org/git/c902a166-98ce-afba-93f2-ea6027557176@gmail.com/[Custom Git impl.],[lime-background]#True#,[lime-background]#True#,?,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,[lime-background]#True#,?,?,[red-background]#False#,?,?
> > +https://cmocka.org/[cmocka],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[lime-background]#True#,?,?
> > +https://libcheck.github.io/check/[Check],[lime-background]#True#,[lime-background]#True#,?,[red-background]#False#,[yellow-background]#Partial#,[lime-background]#True#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/rra/c-tap-harness/[C TAP],[lime-background]#True#,[red-background]#False#,?,[lime-background]#True#,[yellow-background]#Partial#,[yellow-background]#Partial#,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/silentbicycle/greatest[Greatest],[yellow-background]#Partial#,?,?,[lime-background]#True#,[yellow-background]#Partial#,?,[yellow-background]#Partial#,?,?,[red-background]#False#,?,?
> > +https://github.com/Snaipe/Criterion[Criterion],[lime-background]#True#,?,?,[red-background]#False#,?,[lime-background]#True#,?,?,?,[red-background]#False#,?,?
> > +https://github.com/zorgnax/libtap[libtap],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> > +https://nemequ.github.io/munit/[µnit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://github.com/google/cmockery[cmockery],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> > +https://github.com/lpabon/cmockery2[cmockery2],?,?,?,?,?,?,?,?,?,[lime-background]#True#,?,?
> > +https://github.com/ThrowTheSwitch/Unity[Unity],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://github.com/siu/minunit[minunit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://cunit.sourceforge.net/[CUnit],?,?,?,?,?,?,?,?,?,?,?,?
> > +https://www.kindahl.net/mytap/doc/index.html[MyTAP],[lime-background]#True#,?,?,?,?,?,?,?,?,?,?,?
> > +|=====
> 
> Thanks for going through these projects, hopefully we can use this
> information to make a decision on a framework soon.
> 
> Best Wishes
> 
> Phillip
