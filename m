Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E419EB64D7
	for <git@archiver.kernel.org>; Tue, 13 Jun 2023 22:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241009AbjFMWcX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jun 2023 18:32:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240966AbjFMWcI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jun 2023 18:32:08 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 973A53C22
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:30:57 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-25bf28a04a9so1976212a91.1
        for <git@vger.kernel.org>; Tue, 13 Jun 2023 15:30:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686695404; x=1689287404;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4qhKVmrSIOc+CEjiw9QYuj9e7FK50pZ96hYx42lKTI=;
        b=s3hWhTa08nYAKSKvsdWk+4q2UA7n7DSZsDrp64WygKbNNGCUd99MZetTCPL0MESB1m
         it3oiz2cTLMskKkxpP3GOvUCjl21uHAAlnT3SbvguJwo5aiaBw/u78eNyMeZZQcMU4Hk
         BZBcPItLiZx3ZF0AyE+npgJTUu0dc/jYN/zmGfgSG1GQXoJ5F0vzN43JSivF5MjgRuyI
         usweupDAPQNRG1YL2iEMBK0GJwCU06zHDb77t8ex063WXckDRNKM8729panNlz2wDKGW
         4gO4VI3mssA+R/sIp/T+H2lRdo1qUmLTSol4cqHgMfpre/DqraWEPwsjlHGFcfGrYWn0
         L2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686695404; x=1689287404;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k4qhKVmrSIOc+CEjiw9QYuj9e7FK50pZ96hYx42lKTI=;
        b=M59/nRo/qqTq6X78h9kv9UWJyr76y+gAUd8laCX/kKlPCTVwH5Ysh6Hc1hPrGhEFKL
         8qnRIdcm9F07E/WfdmA4Z2Llw62Q288EGFTYW4VpkqSLvnYIe2AwK8IA5/Ls3ucVdAAZ
         UKdpahizBISNip3c2Osit1olNvlE2KjoMokJ22RmOke59BOelbvrspVXVmNE16dUW0Q+
         fGU+hpeqy1QGlj2qcOTY/9lpdEuv+xZ160M5mjBVWxBO62y/EjVm/YeN2OkEWbWXWwUs
         +bTf1VRhSaEyAWAcODPjBhlps1TRcXqGE59KjDuQ0WbaqUm9iAV5pFABxdMXOTzoYNNM
         iiBg==
X-Gm-Message-State: AC+VfDzx+dhe7cvnYAaXIC47MtsDxvnUMWPo71awZvg1cZyFnD9zve36
        8lt8X5T1KfgNUT+Jspx72+bFbJMTnrM=
X-Google-Smtp-Source: ACHHUZ48IzkbWB2idBnukoMaE2YzyNYc+bpKoDzackGouEQBDl308JFe85NeIn//3QdjSx9FW+Fv8A==
X-Received: by 2002:a17:90a:aa12:b0:258:b43d:bdcc with SMTP id k18-20020a17090aaa1200b00258b43dbdccmr169531pjq.8.1686695404045;
        Tue, 13 Jun 2023 15:30:04 -0700 (PDT)
Received: from localhost (128.65.83.34.bc.googleusercontent.com. [34.83.65.128])
        by smtp.gmail.com with ESMTPSA id y13-20020a17090aca8d00b0024de39e8746sm11415375pjt.11.2023.06.13.15.30.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jun 2023 15:30:03 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, calvinwan@gmail.com, szeder.dev@gmail.com,
        phillip.wood123@gmail.com, chooglen@google.com, avarab@gmail.com,
        sandals@crustytoothpaste.net
Subject: Re: [RFC PATCH v3 1/1] unit tests: Add a project plan document
References: <20230517-unit-tests-v2-v2-0-21b5b60f4b32@google.com>
        <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
Date:   Tue, 13 Jun 2023 15:30:03 -0700
In-Reply-To: <8afdb215d7e10ca16a2ce8226b4127b3d8a2d971.1686352386.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 9 Jun 2023 16:25:30 -0700")
Message-ID: <xmqq7cs73sic.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions).Describe what we hope to accomplish by
> implementing unit tests, and explain some open questions and milestones.
> Discuss desired features for test frameworks/harnesses, and provide a
> preliminary comparison of several different frameworks.
>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> Coauthored-by: Calvin Wan <calvinwan@google.com>
> ---

The co-author should also signal his acceptance of the D-C-O with
his own S-o-b.  [*1*] gives a good example.

> diff --git a/Documentation/technical/unit-tests.txt b/Documentation/technical/unit-tests.txt
> new file mode 100644
> index 0000000000..dac8062a43
> --- /dev/null
> +++ b/Documentation/technical/unit-tests.txt
> @@ -0,0 +1,141 @@
> += Unit Testing
> +
> +In our current testing environment, we spend a significant amount of effort
> +crafting end-to-end tests for error conditions that could easily be captured by
> +unit tests (or we simply forgo some hard-to-setup and rare error conditions).
> +Unit tests additionally provide stability to the codebase and can simplify
> +debugging through isolation. Writing unit tests in pure C, rather than with our
> +current shell/test-tool helper setup, simplifies test setup, simplifies passing
> +data around (no shell-isms required), and reduces testing runtime by not
> +spawning a separate process for every test invocation.
> +
> +We believe that a large body of unit tests, living alongside the existing test
> +suite, will improve code quality for the Git project.
> +
> +== Definitions
> +
> +For the purposes of this document, we'll use *test framework* to refer to
> +projects that support writing test cases and running tests within the context
> +of a single executable. *Test harness* will refer to projects that manage
> +running multiple executables (each of which may contain multiple test cases) and
> +aggregating their results.
> +
> +In reality, these terms are not strictly defined, and many of the projects
> +discussed below contain features from both categories.
> +

OK.

> +== Choosing a framework & harness
> +
> +=== Desired features
> +
> +==== TAP support
> +
> +The https://testanything.org/[Test Anything Protocol] is a text-based interface
> +that allows tests to communicate with a test harness. It is already used by
> +Git's integration test suite. Supporting TAP output is a mandatory feature for
> +any prospective test framework.
> +
> +==== Diagnostic output
> +
> +When a test case fails, the framework must generate enough diagnostic output to
> +help developers find the appropriate test case in source code in order to debug
> +the failure.
> +
> +==== Parallel execution
> +
> +Ideally, we will build up a significant collection of unit tests cases, most
> +likely split across multiple executables. It will be necessary to run these
> +tests in parallel to enable fast develop-test-debug cycles.
> +
> +==== Vendorable or ubiquitous
> +
> +If possible, we want to avoid forcing Git developers to install new tools just
> +to run unit tests. So any prospective frameworks and harnesses must either be
> +vendorable (meaning, we can copy their source directly into Git's repository),
> +or so ubiquitous that it is reasonable to expect that most developers will have
> +the tools installed already.
> +
> +==== Maintainable / extensible
> +
> +It is unlikely that any pre-existing project perfectly fits our needs, so any
> +project we select will need to be actively maintained and open to accepting
> +changes. Alternatively, assuming we are vendoring the source into our repo, it
> +must be simple enough that Git developers can feel comfortable making changes as
> +needed to our version.
> +
> +==== Major platform support
> +
> +At a bare minimum, unit-testing must work on Linux, MacOS, and Windows.
> +
> +==== Lazy test planning
> +
> +TAP supports the notion of _test plans_, which communicate which test cases are
> +expected to run, or which tests actually ran. This allows test harnesses to
> +detect if the TAP output has been truncated, or if some tests were skipped due
> +to errors or bugs.
> +
> +The test framework should handle creating plans at runtime, rather than
> +requiring test developers to manually create plans, which leads to both human-
> +and merge-errors.
> +
> +==== Skippable tests
> +
> +Test authors may wish to skip certain test cases based on runtime circumstances,
> +so the framework should support this.
> +
> +==== Test scheduling / re-running
> +
> +The test harness scheduling should be configurable so that e.g. developers can
> +choose to run slow tests first, or to run only tests that failed in a previous
> +run.
> +
> +==== Mock support
> +
> +Unit test authors may wish to test code that interacts with objects that may be
> +inconvenient to handle in a test (e.g. interacting with a network service).
> +Mocking allows test authors to provide a fake implementation of these objects
> +for more convenient tests.
> +
> +==== Signal & exception handling
> +
> +The test framework must fail gracefully when test cases are themselves buggy or
> +when they are interrupted by signals during runtime.
> +
> +==== Coverage reports
> +
> +It may be convenient to generate coverage reports when running unit tests
> +(although it may be possible to accomplish this regardless of test framework /
> +harness support).

Good to see evaluation criteria listed.


[Reference]

*1* https://lore.kernel.org/git/836a5665b7df065811edc678cb8e70004f7b7c49.1683581621.git.me@ttaylorr.com/

