Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D36C6C352A4
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 98E082051A
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:55:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YyyK0w4V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727496AbgBJWzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:55:36 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37522 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727116AbgBJWzg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:55:36 -0500
Received: by mail-pj1-f67.google.com with SMTP id m13so396446pjb.2
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QiRQuXv7GNtlx38v5iC8C3gx7HY+n5OCALMdvFjmn1s=;
        b=YyyK0w4VLFU985KbDYNh/4wRw7nZtfE5o97Cq7r1LxzL1dMotNRPLDWXj2F7TBCYZo
         gSmvu8GxLZbcGc2D9crSB4yVn6kY388aMtjMvF7vaGURvdYeJkqhpcbFHuq9yZwvA3Rn
         vJ4+fJlXFOWZUe7ClifPJPvlyI8vqeJn7ok/+0/E4LEC0Rps9DZbCRa/OD8Lnm2+EPLT
         k8SKrVOQCm32jBWNUUMW4ZaxPcuRx0SBRygAC6osAMTYwRhhdgxeZa5CWRce5ANj/zjH
         /IMmupd0My1WQp0khqMLTgqxXtQK6VXbuE6xHWwhKs9Juurkgi8IIv7Rbj3oj9i6Oob1
         ZZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QiRQuXv7GNtlx38v5iC8C3gx7HY+n5OCALMdvFjmn1s=;
        b=klIpLy+KCt/SN78bl0d7r9ms8A6zfTyMin0cIQvXVrkN2P/ty3+w+xvLjbz0M+YHlg
         qb1SNFJbpUQ5O0nQyTNuigRw7nWuLlbcWe2EYbWUvL/YGj63PWTUkAHwyyduU1MTiMmQ
         eg1CmkF60IFn+E79/LFsoCwLmYoRLzgIAZjK+ckgJAAy/trURLzhdDAoLegd3IiOx2jS
         H8Kdc+Aob134S7izJuOXANvtkgDpEgbfkY/D9ZGUbe6/Zuq6xDsUpTPLWJWxiuCDchp7
         cNJ/1iGlTtVD57wstrI2F+II15+CgCWdSxKUAYXisFKPoGesCFtAdX2FG2drDFfkwU7g
         1T8g==
X-Gm-Message-State: APjAAAXkZU8c1ZlDAh9UEwvpKua/51Z3IXk+F57sWW9pSRVRdcOeHgP1
        HIH3A6YM7kScLjvGH8d7BWRVUJ27Om8=
X-Google-Smtp-Source: APXvYqzVeR9SKbPsVlVZs/ySPPwnlh1/J6K0O3ZK658LdsER/GWbmXHKc0vwk7NKa+4wPn+HXId74A==
X-Received: by 2002:a17:902:7d8b:: with SMTP id a11mr13734740plm.99.1581375333544;
        Mon, 10 Feb 2020 14:55:33 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id x25sm1492600pfp.30.2020.02.10.14.55.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:55:32 -0800 (PST)
Date:   Mon, 10 Feb 2020 14:55:28 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jeff King <peff@peff.net>
Cc:     Heba Waly via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Heba Waly <heba.waly@gmail.com>
Subject: Re: [PATCH] advice: refactor advise API
Message-ID: <20200210225528.GD190927@google.com>
References: <pull.548.git.1581311049547.gitgitgadget@gmail.com>
 <20200210203725.GA620581@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210203725.GA620581@coredump.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 10, 2020 at 03:37:25PM -0500, Jeff King wrote:
> On Mon, Feb 10, 2020 at 05:04:09AM +0000, Heba Waly via GitGitGadget wrote:
> 
> >     The advice API is currently a little bit confusing to call. quoting from
> >     [1]:
> >     
> >     When introducing a new advice message, you would
> >     
> >      * come up with advice.frotz configuration variable
> >     
> >      * define and declare advice_frotz global variable that defaults to
> >        true
> >     
> >      * sprinkle calls like this:
> >     
> >       if (advice_frotz)
> >         advise(_("helpful message about frotz"));
> >     
> >     A new approach was suggested in [1] which this patch is based upon.
> 
> I agree that the current procedure is a bit painful, and I think this is
> a step in the right direction. But...
> 
> >     After this patch the plan is to migrate the rest of the advise calls to
> >     advise_ng and then finally remove advise() and rename advise_ng() to
> >     advise()
> 
> ...this step may not be possible, for a few reasons:
> 
>   1. Some of the sites do more than just advise(). E.g., branch.c checks
>      the flag and calls both error() and advise().
> 
>   2. Some callers may have to do work to generate the arguments. If I
>      have:
> 
>        advise("advice.foo", "some data: %s", generate_data());
> 
>      then we'll call generate_data() even if we'll throw away the result
>      in the end.
> 
> Similarly, some users of advice_* variables do not call advise() at all
> (some call die(), some like builtin/rm.c stuff the result in a strbuf,
> and I don't even know what's going on with wt_status.hints. :)
> 
> So I think you may need to phase it in a bit more, like:
> 
>   a. introduce want_advice() which decides whether or not to show the
>      advice based on a config key. I'd also suggest making the "advice."
>      part of the key implicit, just to make life easier for the callers.
> 
>   b. introduce advise_key() which uses want_advice() and advise() under
>      the hood to do what your advise_ng() is doing here.
> 
>   c. convert simple patterns of:
> 
>        if (advice_foo)
>           advise("bar");
> 
>      into:
> 
>        advise_key("foo", "bar");
> 
>      and drop advice_foo where possible.
> 
>   d. handle more complex cases one-by-one. For example, with something
>      like:
> 
>        if (advice_foo)
>          die("bar");
> 
>      we probably want:
> 
>        if (want_advice("foo"))
>          die("bar");
> 
>      instead. Using string literals is more accident-prone than
>      variables (because the compiler doesn't notice if we misspell them)
>      but I think is OK for cases where we just refer to the key once.
>      For others (e.g., advice_commit_before_merge has 13 mentions),
>      either keep the variable. Or alternatively make a wrapper like:
> 
>        int want_advice_commit_before_merge(void)
>        {
>                return want_advice("commitbeforemerge");
>        }
> 
>      if we want to drop the existing mechanism to load all of the
>      variables at the beginning.

I tend to disagree on both counts. I'd personally rather see something
like 'void advise_key(enum advice, char *format, ...)'.

As I understand it, Heba wanted to avoid that pattern so that people
adding a new advice didn't need to modify the advice library. However, I
think there's value to having a centralized list of all possible advices
(besides the documentation). The per-advice wrapper is harder to iterate
than an enum, and will also result in a lot of samey code if we decide
we want to use that pattern for more advices.

(In fact, with git-bugreport I'm running into a lot of regret that hooks
are invoked in the way Peff describes - 'find_hook("pre-commit")' -
rather than with an enum naming the hook; it's very hard to check all
possible hooks, and hard to examine the codebase and determine which
hooks do and don't exist.)

When Heba began to describe this project I had hoped for a final product
like 'void show_advice(enum advice_config)' which looked up the
appropriate string from the advice library instead of asking the caller
to provide it, although seeing the need for varargs has demonstrated to
me that that's not feasible :) But I think taking the advice config key
as an argument is possibly too far the other direction. At that point,
it starts to beg the question, "why isn't this function in config.h and
called print_if_configured(cfgname, message, ...)?"

Although, take this all with a grain of salt. I think I lean towards
this much encapsulation after a sordid history with C++ and an
enlightened C developer may not choose it ;)

 - Emily
