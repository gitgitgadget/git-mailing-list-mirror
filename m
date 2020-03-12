Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF19C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 14:16:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 450FA20650
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 14:16:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XZMENi5d"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbgCLOQg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 10:16:36 -0400
Received: from mail-pj1-f54.google.com ([209.85.216.54]:54173 "EHLO
        mail-pj1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbgCLOQf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 10:16:35 -0400
Received: by mail-pj1-f54.google.com with SMTP id l36so2612512pjb.3
        for <git@vger.kernel.org>; Thu, 12 Mar 2020 07:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=mdAwImHEEEv7ZygSsut68csF1xXtLVnQnFWC2VB5QC8=;
        b=XZMENi5d9eZeyU/apBdtgiGXXqH+FgTBd1xkjXEasy8W3xoX/FAHyekkzsfN6VM1Qx
         Li896OKmJxA1gm3e6Zon7BQmYfUmXefb3cJHRI2bO0DEolADDswaMQUX+anwm4UsAVSI
         AEWXu0Q3G5Gp9gViOxvbUfBvKdOQTB4PbmOQ2RJ51RXlT4cUa0oe7wYRPIvxUSUYGgMJ
         xP3CFF6l4UsonhHOdRmRM1jcMLlM8EbqMVVb79ewK1r6ch6rqJ97MM+MWgXZhMbSZRK9
         YRW5fFXmmN/FTeSrazCL7sDm5ZUCGnPiDx3cYOlcbxzo4w30wCOVTcy2BbiEcCbkRwCO
         +24w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=mdAwImHEEEv7ZygSsut68csF1xXtLVnQnFWC2VB5QC8=;
        b=enmpqT4U+LhCL9SasExwj234SU7X2LpqtXQ1EAPv4/eMwVxxcX4xF6nLnIzfjJZCON
         AupZIXXPjS9lFuOzyM31NXDuuxRMBac/g8ZiLj6v9Ntnj8GpBFdn2mo296oMW6U75T5g
         umQy2igI91dfPs+f55IICMsl47/P9gbmk5z5/wTiE/Rs4QKTMPWls5MR9GJb0dIqbyZ/
         LP+VRbY7pG+fgSQFRWhItQqxJZk9WHB73vSYRyCx8Zg79iI1g/P5XzInsHC7qaptL0hH
         fpDwPMyiANZc6jCFpj/e6d4bhKQyGZwPJ6Ky9FYpui3PNBrbpO7KrRWhQdevUuzXzKCx
         AGbA==
X-Gm-Message-State: ANhLgQ22Q+mjukwvxQFKGd1Snvk1gfB2weKw2fC0iWetOsK4fasn7Xrg
        Z+sNNnG7H+/fCSis0Mz+AEHJ4hMHk0hYTQ==
X-Google-Smtp-Source: ADFU+vvQVjiryUv0g88gvW2PNDLR0z3zWisxtGIrcE0ys5OB4J9fEE0o8YFeutdLJn6i/ZB6dOxE4A==
X-Received: by 2002:a17:90b:3711:: with SMTP id mg17mr2921238pjb.73.1584022593586;
        Thu, 12 Mar 2020 07:16:33 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id f8sm54811817pfn.2.2020.03.12.07.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2020 07:16:32 -0700 (PDT)
Date:   Thu, 12 Mar 2020 07:16:28 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     James Ramsay <james@jramsay.com.au>
Cc:     git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200312141628.GL212281@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 02:56:53PM +1100, James Ramsay wrote:
> 1. Emily: hooks in the config file. Sent a read only patch, but didn’t get
> much traction. Add a new header in the config file, then have prefix number
> so that security scan could be configured at system level that would run
> last, and then hook could also be configured at the project level.
> 
> 2. Peff: Having hooks in the config would be nice. But don’t do it at
> `hooks.prereceive`, but use a subconfig like `hooks.prereceive.command` so
> it’s possible to add options later on.
> 
> 3. Brian: sometimes the need to overridden, ordering works for me. For Git
> LFS it would be helpful to have a pre-push hook for LFS, and a different one
> for something else. Want flexibility about finding and discovering hooks.
> 
> 4. Emily: if you want to specify a hook that is in the work tree, then it
> has to be configured after cloning.
> 
> 5. Jonathan: It’s better to start with something low complexity as long as
> it can be extended/changed later. If there's room to tweak it over time then
> I'm not too worried about the initial version being perfect — we can make
> mistakes and learn from them. A challenge will be how hooks interact.
> Analogy to the challenges of stacked union filesystems and security modules
> in Linux. Analogy to sequence number allocation for unit scripts
> 
> 6. CB: Declare dependencies instead of a sequence number? In theory
> independent hooks can also run in parallel.
> 
> 7. Peff: Maybe that’s something to not worry about from the start. Like, how
> many hooks do you expect to run anyway.
> 
> 8. Christian: At booking.com they use a lot of hooks, and they also sent
> patches to the mailing list to improve that.
> 
> 9. Emily: In-tree hooks?
> 
> 10. Brian: You can do `git cat-file <ref> | sh` to run a hook.
> 
> 11. Brandon: Is it possible to globally to disable all hooks locally? It
> might be a security concern. Or is it something we might want to add?
> 
> 12. Peff: No it’s not.

Thanks for the notes, James.

I came away with the understanding that we want the config hook to look
something like this (barring misunderstanding of config file syntax,
plus or minus naming quibbles):

[hook "/path/to/executable.sh"]
	event = pre-commit

The idea being that by using a subsection, we can extend the format
later much more easily, but by starting simply, we can start using it
and see what we need or don't want. We can use config order to begin
with.

This means that we could do something like this:

[hook "/path/to/executable.sh"]
	event = pre-commit
	order = 123
	mustSucceed = false
	parallelizable = true

etc, etc as needed.

But I wonder if we also want to be able to do something like this:

[hook "/etc/git-secrets/git-secrets"]
	event = pre-commit
	event = prepare-commit-msg
	...

I guess the point is that we can choose to allow this, or not. I could
see there being some trouble if you wanted the execution order to work
differently (e.g. run it first for pre-commit but last for
prepare-commit-msg)...

I think, though, that something like
hook.pre-commit."path/to/executable.sh" won't work. It doesn't seem like
multiple subsections are OK in config syntax, as far as I can see. I'd
be interested to know I'm wrong :)

Will try and get some work on this soon, but honestly my hope is to get
bugreport squared away first.

 - Emily
