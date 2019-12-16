Return-Path: <SRS0=PvcO=2G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9AA6C43603
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 12:19:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D719206CB
	for <git@archiver.kernel.org>; Mon, 16 Dec 2019 12:19:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8YcH3bC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727576AbfLPMTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Dec 2019 07:19:05 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44562 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727481AbfLPMTF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Dec 2019 07:19:05 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so6948520wrm.11
        for <git@vger.kernel.org>; Mon, 16 Dec 2019 04:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vI7zLXL7e65zx497nLb1LGpDfyH+bvmGyRsYiguEyCM=;
        b=I8YcH3bCXTazHf8jlQ2TuVjXGI99kyoOzaZN5P8vYqvMmnDXVJCDyUFw9kPDUNCk8b
         CuH3Yn/0CRPXdxD+PwG1KCayVF82QXs2oWRZxCvItHYE7WyQFoD7zVn8fNh+Ox6LNWOc
         t9+ibhZSFwy17a3EwfscPME+2equZCfEnzs0+lBxDwkGUm3Y4qR5jmL65hZKVPyPsreD
         vv8rC1E0GJ1m7Rmy4zTNqvyyy1V+0LCTPZVs+vhW0YidCoZHHN59kvyBpIGUSD9zwru6
         tYyhVdIsEj0k8soS0L6zDAhz+dS/q8c2qb9YezpW2fwXkDyWLXItPLZpB4Ml0BaHG6gL
         v77w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vI7zLXL7e65zx497nLb1LGpDfyH+bvmGyRsYiguEyCM=;
        b=XgzgvnEFosUVVystbHX8CymriO0O1M/3sbmXrCdOxDTKK8q+RngliXM9IcIfpKbJQ7
         ggIgfUyyFn+ropXtR8gqsupXhm2pqGQADjLiUQsAwLvAaJsM9gOt5eI0xFW3cCxWU8Yw
         WCDCS0D51atjNXA21yurw4qUU/RKuE5e/LDJT6dC5ma7AmTHmxMvMlpH9mPShyPDT8Ot
         OTcXueqgKKtTF836mfh50nfiBr6n82tXabZkpcD3Rd9zYC8XEDYg6hbnmJy50Q+77z05
         KiP0rUz09fRR+l/ICllMXLhbELU2KK0FMhjZ0s21hYQlXWE44Hy8hNmuziJCYteTkPvE
         1XeQ==
X-Gm-Message-State: APjAAAWM/7PatV/W29v9B5bZlIPyI8VCb/KSFV/Y3ezua0bkOkkMNo6s
        ZPw3fIitgTgp+FBwBN/W72s=
X-Google-Smtp-Source: APXvYqxP3AXzy4z+z8V+D1IBw3dvL/C4ojtMDcJbD022H2Ov0pttjCKWPI5S7Va8mB6GAYU2XcOyzw==
X-Received: by 2002:a5d:4602:: with SMTP id t2mr29429998wrq.37.1576498743094;
        Mon, 16 Dec 2019 04:19:03 -0800 (PST)
Received: from szeder.dev (x4dbe5d6c.dyn.telefonica.de. [77.190.93.108])
        by smtp.gmail.com with ESMTPSA id s65sm21276882wmf.48.2019.12.16.04.19.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 04:19:02 -0800 (PST)
Date:   Mon, 16 Dec 2019 13:18:59 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/7] t3701: avoid depending on the TTY prerequisite
Message-ID: <20191216121859.GP6527@szeder.dev>
References: <pull.172.git.1575637705.gitgitgadget@gmail.com>
 <ed870d34a8479366df786e76e2770df344469a41.1575637705.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ed870d34a8479366df786e76e2770df344469a41.1575637705.git.gitgitgadget@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 06, 2019 at 01:08:20PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> The TTY prerequisite is a rather heavy one: it not only requires Perl to
> work, but also the IO/Pty.pm module (with native support, and it
> requires pseudo terminals, too).
> 
> In particular, test cases marked with the TTY prerequisite would be
> skipped in Git for Windows' SDK.
> 
> In the case of `git add -p`, we do not actually need that big a hammer,
> as we do not want to test any functionality that requires a pseudo
> terminal; all we want is for the interactive add command to use color,
> even when being called from within the test suite.
> 
> And we found exactly such a trick earlier already: when we added a test
> case to verify that the main loop of `git add -i` is colored
> appropriately. Let's use that trick instead of the TTY prerequisite.

It's much more interesting _what_ that trick is than when it was
found.  Is it setting TERM=vt100, or is it setting both TERM=vt100 and
GIT_PAGER_IN_USE=true?  I'm inclined to think the latter, but I'm not
sure I interpreted the comment below right.

> +# This function uses a trick to manipulate the interactive add to use color:
> +# the `want_color()` function special-cases the situation where a pager was
> +# spawned and Git now wants to output colored text: to detect that situation,
> +# the environment variable `GIT_PAGER_IN_USE` is set. However, color is

Perhaps a s/is set/has to be set/ would have helped my interpreter,
dunno.

> +# suppressed despite that environment variable if the `TERM` variable
> +# indicates a dumb terminal, so we set that variable, too.
> +
> +force_color () {
> +	env GIT_PAGER_IN_USE=true TERM=vt100 "$@"
> +}

In any case, there are a couple of tests in other test scripts that
test color relying on the TTY prereq.  So maybe it would be worth to
make this into a "global" helper function by adding it to
'test-lib-functions.sh', so we can drop a few more prereqs.

OTOH, some of those other tests have descriptions like:

  t3203-branch-output.sh:test_expect_success TTY '%(color) present with tty'
  t7004-tag.sh:test_expect_success TTY '%(color) present with tty'

i.e. their description is specific about checking the behaviour with a
tty, so I'm not entirely sure.

