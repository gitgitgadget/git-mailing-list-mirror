Return-Path: <SRS0=MaRY=57=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A30F3C2BA19
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:59:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B8A92078A
	for <git@archiver.kernel.org>; Wed, 15 Apr 2020 20:59:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MpU+ooyg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438645AbgDOU7t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 16:59:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2438334AbgDOU7r (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 15 Apr 2020 16:59:47 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18E7C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:59:46 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t11so533436pgg.2
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 13:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7+8uOh54WqkIBhOYX7IVh6v1XW/u0OIO2YMLYoLlo/A=;
        b=MpU+ooygw6SVUVw8qufiW+l6aOg45YiSEdH7+AgYoA7E9hJcQGKdGZ6ytVCUDL4HWC
         ywHHwAcZEMvFqWKQy0DFUJgK6Oj4D9MpkyAhzu+5zNU9/KjdqRs/rk7owFOqAVbUM1kk
         +pm63mcN4pE6lp0aWSQVZ80F0E627ZerDS4rtaJ6zhLZlbEqOQX6YmLVebJjWGRfay3l
         2t1AFs5tarPoHnz9it2j+jBd8yUXFwu+2z682Depz1dB7EIKNOKBrNuo6bR7C0m/CEqr
         kVLu1QFc4yx85QpQg5qs2s26alRQ4cynQlpPcyE7ZFX8hyRiH5U6fCuT7EqvUpPpqAEt
         SR9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7+8uOh54WqkIBhOYX7IVh6v1XW/u0OIO2YMLYoLlo/A=;
        b=jQkXZTBct26U8yvD1mKgzLEPlk458cAbCgz2Ck+dmZ/yNmJ1/iGkvs0Y+z1Y8OzQ+v
         8RPy2/A20HmDWbMH3ZDcLjNLqwdwFygdtWtD9BnnAUQdhTEnOVPPcpRhM2Ta6TDaRQlg
         A1d3uRHAfwVN3y+hjMwTfpwti5AoltilICrMs2bHTi02/Lez8bDUeoW6mX9OYfzeRqnW
         lyROddKiRMXGoeDqjM7+PE5TRbAXbxdIheagAxuaNuRbc9LiDAqxsNGzxbu0XC2ZrWqY
         8/pMw1Dd6vCZD1P/htW+67WA9ELW2Og2JdEBFk1CJmxSDNDpYneWRqQQW/rqVnSkyr4F
         nghQ==
X-Gm-Message-State: AGi0PubNdBf5eevauceC8uBAfH9C8KdJ3tGIdtTxSXhkVfYnZe+CQkN/
        XQQSZhvmy7yIRL11C8UY4WKVWw==
X-Google-Smtp-Source: APiQypI9mUgiDdD0/lwL+W7ajef+s7596hXBXLYy2mMLmdhd21nO7t4wctud3rZOavAOB9jVj8iXlg==
X-Received: by 2002:a62:6c1:: with SMTP id 184mr29480077pfg.316.1586984385890;
        Wed, 15 Apr 2020 13:59:45 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id y126sm9048879pgy.91.2020.04.15.13.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 13:59:45 -0700 (PDT)
Date:   Wed, 15 Apr 2020 13:59:41 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        James Ramsay <james@jramsay.com.au>, git@vger.kernel.org
Subject: Re: [TOPIC 2/17] Hooks in the future
Message-ID: <20200415205941.GB24777@google.com>
References: <AC2EB721-2979-43FD-922D-C5076A57F24B@jramsay.com.au>
 <0D7F1872-7614-46D6-BB55-6FEAA79F1FE6@jramsay.com.au>
 <20200312141628.GL212281@google.com>
 <xmqqeetwcf4k.fsf@gitster.c.googlers.com>
 <20200407230132.GD137962@google.com>
 <20200407235116.GE137962@google.com>
 <20200410213146.GA2075494@coredump.intra.peff.net>
 <20200413191515.GA5478@google.com>
 <20200413215256.GA18990@coredump.intra.peff.net>
 <20200415034550.GB36683@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200415034550.GB36683@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 14, 2020 at 08:45:50PM -0700, Jonathan Nieder wrote:
> 
> Hi,
> 
> Jeff King wrote:
> > On Mon, Apr 13, 2020 at 12:15:15PM -0700, Emily Shaffer wrote:
> >> Jeff King wrote:
> 
> >>> Yeah, giving each block a unique name lets you give them each an order.
> >>> It seems kind of weird to me that you'd define multiple hook types for a
> >>> given name.
> >>
> >> Not so odd - git-secrets configures itself for pre-commit,
> >> prepare-commit-msg, and commit-msg-hook.
> [...]
> > Yeah, I do see how that use case makes sense. I wonder how common it is
> > versus having separate one-off hooks.
> 
> I think separately from the frequency question, we should look at the
> "what model do we want to present to the user" question.
> 
> It's not too unusual for a project with their source code in a Git
> repository to have conventions they want to nudge users toward.  I'd
> expect them to use a combination of hooks for this:
> 
> 	prepare-commit-msg
> 	commit-msg
> 	pre-push
> 
> Git LFS installs multiple hooks:
> 
> 	pre-push
> 	post-checkout
> 	post-commit
> 	post-merge
> 
> git-secrets installs multiple hooks, as already mentioned.
> 
> We've also had some instances over time of one hook replacing another,
> to improve the interface.  A program wanting to install hooks would
> then be likely to migrate from the older interface to the better one.

I find this argument particularly compelling :)

> 
> What I mean to get at is that I think thinking of them in terms of
> individual hooks, the user model assumed by these programs is to think
> of them as plugins hooking into Git.  The individual hooks are events
> that the plugin listens on.  If I am trying to disable a plugin, I
> don't want to have to learn which events it cared about.
> 
> >                                       And whether setting the order
> > priority for all hooks at once is that useful (e.g., I can easily
> > imagine a case where the pre-commit hook for program A must go before B,
> > but it's the other way around for another hook).
> 
> This I agree about.  Actually I'm skeptical about ordering
> dependencies being something that is meaningful for users to work with
> in general, except in the case of closely cooperating hook authors.
> 
> That doesn't mean we shouldn't try to futureproof for that, but I
> don't think we need to overfit on it.
> 
> [...]
> >>> And it doesn't leave a lot of room for defining
> >>> per-hook-type options; you have to make new keys like pre-push-order
> >>> (though that does work because the hook names are a finite set that
> >>> conforms to our config key names).
> 
> Exactly: field names like prePushOrder should work okay, even if
> they're a bit noisy.
> 
> [...]
> >>>   [hook "pre-receive"]
> >>>   # put any pre-receive related options here; e.g., a rule for what to
> >>>   # do with hook exit codes (e.g., stop running, run all but return exit
> >>>   # code, ignore failures, etc)
> >>>   fail = stop
> >>
> >> Interesting - so this is a default for all pre-receive hooks, that I can
> >> set at whichever scope I wish.
> 
> If I have the mental model of "these are plugins, and particular hooks
> are events they listen to", then it seems hard to make use of this
> broader setting.
> 
> But scoped to a particular (plugin, event) pair it sounds very handy.

Striking out on finding another place to fit into the thread, I wonder
if the reason some of us are thinking "I'm going to write a pre-receive
hook" rather than "I'm going to write a linter hook" may be because of
the prior single-script-per-hook limitation. As a result, when you want
to add another function to your hook, you think, "I'll modify my
pre-receive hook". I think part of this RFC is a subtle paradigm shift
away from hooks-as-units-of-work and towards hooks-as-events.

That observation doesn't really provide much guidance though, except
maybe to point out we should think about what the glossary entries would
say for terms like "hook" and "hook command" now... and I think figuring
out those definitions might help us settle on what is most logical in
the config.

(That makes me think I had better write a design doc next, before I get
too much further with RFC patches. I made one pass at one a while ago,
but it was more focused on history and choosing between alternatives;
since we seem to have agreed on an approach, I'll make another attempt
focusing on design and definition instead. I'll try to have something to
the list by next week.)

 - Emily
