Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6EDAC433EF
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A36D26103B
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 19:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhKDTtM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Nov 2021 15:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231573AbhKDTtL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Nov 2021 15:49:11 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A111DC061714
        for <git@vger.kernel.org>; Thu,  4 Nov 2021 12:46:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b12so10335347wrh.4
        for <git@vger.kernel.org>; Thu, 04 Nov 2021 12:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=/nqH8TImAlsvg7klj+F4WEfvREC8nD2iq0yZqb39uvo=;
        b=RTEQoTFjCpgCJ2Z9+Pczu2yO+RnOlYgRVjMO4BU71HdoyKvEipcihhTqu/Hw1JGi6b
         3HywVDKxd0VfpLTmerjHiyrec6z9o1fFVCPN2/VeHlbryG/vl/9WJID9NZVS/wpZMx0K
         spIE4ZPS3OQI8xnOhG9ENfs4qJ0aDH13zOZWg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=/nqH8TImAlsvg7klj+F4WEfvREC8nD2iq0yZqb39uvo=;
        b=BYESBOWfxcP6ZhOP62hHdIRNEJpsVhIklmFtihxyuftUagcJ9kO2ItgBwkSjeuzq98
         I0ImjgLfsmoh6DQes9FOgPTe42HpXDgTtClKZeN0HfSB+vPiEBUv6Ro4jqGKxodYipLB
         YRKiWITJfvSU4dvhy3ag+bI/XKAECxxjqjhvNJJ6H/er2VvmbiFzNz+WDmjKU5TswtsA
         V3dCqy1gv9MjsHgtJV9n5i9JP3bcBzztS5uEczrrSmBH7oNQRahUURRWhVyw6FjwNS8k
         NN7CY9uqGOaaXnmZiCQGiXjbsW5VmPA0ubwv7USIVTSkpounhALc4w4VqnMEl6bQgXvz
         g8iQ==
X-Gm-Message-State: AOAM530noFAQNoou+JS5tkyBli5libn9YxnL1t7YdAiHj8pfcHrmEsRk
        QvIOkH0O9z87KpiRDAD80lZnaw==
X-Google-Smtp-Source: ABdhPJxyzFUUmnL9/VSGt46njKf/a5iAARd3oLzCQsmKBHhnAfWK0BStLE5+UsIqTO3Y0NzLbZmq9g==
X-Received: by 2002:a5d:4e81:: with SMTP id e1mr69194101wru.242.1636055191125;
        Thu, 04 Nov 2021 12:46:31 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id c1sm5962755wrt.14.2021.11.04.12.46.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Nov 2021 12:46:30 -0700 (PDT)
Date:   Thu, 4 Nov 2021 19:46:19 +0000
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Carlo Arenas <carenas@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 7/7] t/helper/simple-ipc: convert test-simple-ipc to
 use start_bg_command
Message-ID: <20211104194619.GA12886@dinwoodie.org>
References: <pull.1040.git.1631738177.gitgitgadget@gmail.com>
 <pull.1040.v2.git.1632152178.gitgitgadget@gmail.com>
 <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b7a058284b93fab52458b12a6aede5e8aed6652.1632152179.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday 20 September 2021 at 03:36 pm +0000, Jeff Hostetler via GitGitGadget wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Convert test helper to use `start_bg_command()` when spawning a server
> daemon in the background rather than blocks of platform-specific code.
> 
> Also, while here, remove _() translation around error messages since
> this is a test helper and not Git code.

As part of testing the v2.34.0-rc0 release candidate on Cygwin, I've
found this commit -- 05881a6fc9 (t/helper/simple-ipc: convert
test-simple-ipc to use start_bg_command, 2021-09-20), according to my
bisecting -- is causing t0052.1 to fail on 32-bit Cygwin.  Somehow this
is only affecting the 32-bit Cygwin build; the 64-bit build is working
as expected.

Specifically, the failure I'm seeing is as below:

```
$ GIT_TRACE=1 sh t0052-simple-ipc.sh -vix
trace: built-in: git init '/cygdrive/d/git-32/t/trash directory.t0052-simple-ipc'
Initialized empty Git repository in /cygdrive/d/git-32/t/trash directory.t0052-simple-ipc/.git/
expecting success of 0052.1 'start simple command server': 
	test_atexit stop_simple_IPC_server &&
	test-tool simple-ipc start-daemon --threads=8 &&
	test-tool simple-ipc is-active

++ test_atexit stop_simple_IPC_server
++ test 0 = 0
++ test_atexit_cleanup='{ stop_simple_IPC_server
		} && (exit "$eval_ret"); eval_ret=$?; :'
++ test-tool simple-ipc start-daemon --threads=8
trace: run_command: test-tool simple-ipc run-daemon --name=ipc-test --threads=8
error: daemon failed to start
error: last command exited with $?=1
not ok 1 - start simple command server
#	
#		test_atexit stop_simple_IPC_server &&
#		test-tool simple-ipc start-daemon --threads=8 &&
#		test-tool simple-ipc is-active
#	
++ stop_simple_IPC_server
++ test-tool simple-ipc stop-daemon
++ exit 1
++ eval_ret=1
++ :
```

I've had a look at the code changes, and cannot work out what might be
being handled differently in 32-bit and 64-bit Cygwin environments.
Given the Cygwin project is considering dropping support for 32-bit
Cygwin anyway, it might not be worth doing anything about this.  But I
thought it worth reporting in case there's something obvious to folk
more familiar with this code.
