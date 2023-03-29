Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C29DC77B62
	for <git@archiver.kernel.org>; Wed, 29 Mar 2023 17:00:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjC2RAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Mar 2023 13:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbjC2RAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Mar 2023 13:00:04 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D689619B5
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 10:00:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id o11so15573168ple.1
        for <git@vger.kernel.org>; Wed, 29 Mar 2023 10:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680109203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bd05p7eS+fC4euMJwnavVhUZGUaPVfJgBsfTqCY3Boc=;
        b=H5J5I5pftEA6TkUUw9gTByfIqN4S8JTULhGoUcfKnWYJZI6IIpwtm4lAP4PlELVvHm
         XhYvDgMXW/eM/vbDuLTDzy/z9Yn/iX+DMVv6MHs3N4eaYPuuANaDzZVr6I5e4TvscyAw
         nFBezXBBFjhfMHFhDl0Q/EGf/MYvIgO0oYkvp1v0J+YAwBga0LBlOljX5tPr1zQU+rBO
         bHkiwfXwTy6TKRhS7uliRH+mjPaiTH5pxl0DUJD5OFrWdNvhsu6O8c2m8dgAHmgFuyxk
         UjiRtAXGi46nLCD9DEWhGb2QkuYSViVe//O+FLLvX+zMmU5+s6JGQ2tWfqDhecz057C0
         1hCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680109203;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Bd05p7eS+fC4euMJwnavVhUZGUaPVfJgBsfTqCY3Boc=;
        b=596LZ1XJevVElzPZvta9HD6KWiLw7Nq/aTDcUm2MrZ/NBb5m8NoyxKkgLjPFcJjpIf
         PWj9iWGWdZqgprvd5sroN2yKQCuNaEtbFA+KFXt2AtTQVv0WPtLjyuvo4NgBy2tUr7PS
         62a7i5lVjFkpM6DxFbEHBx8HGPvgQbSnbNS5IW6Qzl/Xr1i6IhCO3j29zvx4vrtQM7Lg
         rCtFgbpG7Q5Zak4Lw1rHm4lIQEqbq6TwOQW3BLy/aMeMBxpUXpXGvCQXscQsw/euPCn2
         vYcXTYZUMGlQsbBXou7mv9VkTyyYAknqEG8UJdCQ1EafojeMBH3lp2ae2WTgsArUboD9
         UIGg==
X-Gm-Message-State: AAQBX9clEX2shtvhTFq6PHg+N9U1Dg0ETWnP0DFRTYaGyXwmZv80EFBZ
        4O1IO1/aM8scekk40vZRDN4=
X-Google-Smtp-Source: AKy350ZeCEQg1Zj8zOuo1Ey35gY7fh8sNlC2eAls3oiRQqhedBADeb4oMXEInf1VSO2edHwOQjeS2Q==
X-Received: by 2002:a17:902:fb8d:b0:1a2:75cc:654c with SMTP id lg13-20020a170902fb8d00b001a275cc654cmr1721405plb.16.1680109203192;
        Wed, 29 Mar 2023 10:00:03 -0700 (PDT)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b00194d14d8e54sm23256705plr.96.2023.03.29.10.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 10:00:02 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Raghul Nanth A <nanth.raghul@gmail.com>
Subject: Re: [PATCH v2] describe: enable sparse index for describe
References: <pull.1480.git.git.1679926829475.gitgitgadget@gmail.com>
        <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
Date:   Wed, 29 Mar 2023 10:00:02 -0700
In-Reply-To: <pull.1480.v2.git.git.1680107154078.gitgitgadget@gmail.com>
        (Raghul Nanth A. via GitGitGadget's message of "Wed, 29 Mar 2023
        16:25:53 +0000")
Message-ID: <xmqq355nbii5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Raghul Nanth A via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Raghul Nanth A <nanth.raghul@gmail.com>
>
> Add usage and performance tests for describe
>
> Performance metrics
> ...

The description is a bit skimpy.  At least it should explain why
blindly flipping the "requires-full-index" bit off is all that is
necessary. I think in the review discussion on v1, Derrick gave some
explanation you can regurgitate and reuse.

> Signed-off-by: Raghul Nanth A <nanth.raghul@gmail.com>
> ...

> diff --git a/t/t6121-describe-sparse.sh b/t/t6121-describe-sparse.sh
> new file mode 100755
> index 00000000000..ce53603c387
> --- /dev/null
> +++ b/t/t6121-describe-sparse.sh
> @@ -0,0 +1,67 @@
> +#!/bin/sh
> +
> +test_description='git describe in sparse checked out trees'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +check_describe () {
> +	indir= &&
> +...
> +	'
> +}

Having this almost identical helper copied from a near-by test
script means maintenance nightmare.  People will forget to side port
to this copy any fixes they make to the other one.

I was hoping there would be a cleaner approach to reuse t6120, by
doing something similar to either how t8001-annotate shares blame
tests, or how t5559 takes advantage of t5551.  One way might be ...

 * prepare a prerequisite like so near the beginning of t6120

	test_lazy_prereq WITH_SPARSE_INDEX '
		test "$TEST_NAME" = t6121-describe
	'

 * add tests to be run with sparse-index enabled, but guarded with
   some variable, e.g.

	test_expect_success TESTING_SPARSE_INDEX 'a new test' '
		... do sparse-index testing specific code ...
	'

   Such "sparse-index testing specific" code may include turning the
   working tree the previous test already prepared into sparse
   (i.e. additional "setup"), or running commands under
   "ensure_not_expanded" (i.e. new tests).

 * create t6121 that works similar to how t5559 takes advantage of
   t5551, something like

	#/bin/sh
	. ./t6120-describe.sh

Ideally we should be able to do this without adding a new t6121, by
adding new tests that are specific to sparse-index at the end of
t6120, and avoid duplicated code.

Another possibility that may take the least amount of effort (but
may give us a lot less satisfactory outcome) may be to add a
lib-describe.sh library that is sourced from t6120 and t6121, and
move check_describe there.  If check_describe has to behave slightly
differently, have a new conditional in the implementation so that
the caller can make a choice.


