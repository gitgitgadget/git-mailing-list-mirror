Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33232C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:52:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 150C861130
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 19:52:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238343AbhJMTyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 15:54:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhJMTyv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 15:54:51 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25F4C061570
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:52:47 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id om2-20020a17090b3a8200b001a069b140ffso2381659pjb.1
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 12:52:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=FFuBV1wL4Bv0NkxKwZXNO75udY3pSKx4K05dwtVY7VQ=;
        b=j+Q3hbE7UdR6Hbyn1TAwac7A4fPQR15pqEWKeCB1TTqY6oPcEAv/Qa7pzwzPzHH/c1
         3W2vPfmkrupGTK/uW9+77tX2IcBoyvL/sMelmUnSsCpGh6OCmhDjpUr1nmWrSIL6g43j
         Vf+V4c72xHfKdTuF5f2zmervSrySreLat8Rals/bsHVqpaLocr1vwQOU0pkM9x0QSqee
         LgjcjU/tKEW6wiVB0IFzXk5f0HcA2sQPSarr5OPSIWuJKwLLXaDW5aOa6rfYZx234z6y
         eXzZKfzVB1TKt+axeOEA9aUPTixN3lVqUY2W7N+C+h2rHJBSTjga/xdMevR7B8Ss9kmV
         s+/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=FFuBV1wL4Bv0NkxKwZXNO75udY3pSKx4K05dwtVY7VQ=;
        b=7SIa+Ns+RYO5D/UBmU1todr8Eheb/zi/ltJMAo19Fb8Dh4nP3+AJ27HgsNekog28FW
         EacaUXTq0xmKNl6n9QHmJM2Pf9LfVtR98wVsLoc43Cz32fiH7KQdY1m3f+UXYQAlAXmD
         jHR8mveGoVEgOW+bnk56qkrYR2bay1ywlemeZ/iKgn2v0r/Px59R2dY/0RhVAwC8RGzx
         gwyTlNyLoSusNiSQB3UNM75vwaXSN+U0s5FWqxoczR/MDeozsEx0veTwbeOK2JVJycSo
         Ox7yTxnMfcrrZ1R7705gmyPuvyUdJhhTLZJAY2N6IMtzM+J636kCAmRhHlZe9ncd1PFe
         3JpQ==
X-Gm-Message-State: AOAM532FpJgfJUoRtlBwvZMn3LJSQk5ypil3lDl2rqPVYyxXAI5LnRmS
        vFOcKUTY48WNM54jrIGu/tHEPbvn6cOdM3IO6Sjr
X-Google-Smtp-Source: ABdhPJxAixhHsFBhuOevTvbmnjKzK93FZ87pidW3lNT4l7VMYpuwf42MD+S0F6JIAGnOUxPpc8YmCJbnuecmnibEUVA1
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a63:ce0f:: with SMTP id
 y15mr906342pgf.249.1634154767407; Wed, 13 Oct 2021 12:52:47 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:52:45 -0700
In-Reply-To: <xmqqk0ih24a0.fsf@gitster.g>
Message-Id: <20211013195245.93145-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <xmqqk0ih24a0.fsf@gitster.g>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: Re: [RFC PATCH 2/2] config: include file if remote URL matches a glob
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Jonathan Tan <jonathantanmy@google.com> writes:
> 
> > I marked this as RFC because there are some design points that need to
> > be resolved:
> >
> >  - The existing "include" and "includeIf" instructions are executed
> >    immediately, whereas in order to be useful, the execution of
> >    "includeIf hasremoteurl" needs to be delayed until all config files
> >    are read. Are there better ways to do this?
> 
> An interesting chicken-and-egg problem.  Even if an included
> configuration file does not have further "include", you may discover
> there are more remotes, which may add new includes to fire from the
> top-level configuration file.

That's true. We might need to say that such conditional includes are
based only on what happened during the main config parsing.

> What if we have multiple remotes?  Is it a sufficient match for only
> one of them match what is mentioned in the includeIf condition?
> Should all of them must match the pattern instead?  Majority,
> perhaps?  Something else?

I think at least one remote should match.

> >  - Is the conditionally-included file allowed to have its own
> >    "include{,If}" instructions? I'm thinking that we should forbid it
> >    because, for example, if we had 4 files as follows: A includes B and
> >    C includes D, and we include A and C in our main config (in that
> >    order), it wouldn't be clear whether B (because A was first included)
> >    or C (because we should execute everything at the same depth first)
> >    should be executed first. (In this patch, I didn't do anything about
> >    includes.)
> 
> Interesting.  The order of real inclusion obviously would affect the
> outcome of the "last one wins" rule.  And this does not have to be
> limited to this "hasremote" condition, so we need to design it with
> a bit of care.
> 
> Would it be possible for a newly included file to invalidate an
> earlier condition that was used to decide whether to include another
> file or not?  If not, then you can take a two-pass approach where
> the first pass is used to decide solely to discover which
> conditionally included files are taken, clear the slate and the
> parse these files in the textual order.  In the case of your example
> above, the early part of the primary config would be the first to be
> read, then comes A's early part, then comes B in its entirety, then
> the rest of A, and then the middle part of the primary config, then
> C's early part, then D, and then the rest of C,... you got the idea.
>
> If it is possible for an included file to invalidate a condition we
> have already evaluated to make a decision, it would become messy.
> For example, we might decide to include another file based on the
> value we discovered for a config variable:
> 
>     === .git/config ===
>     [my] variable
>     [your] variable = false
> 
>     [includeIf "configEq:my.variable==true"]
>             file = fileA
> 
> but the included file may override the condition, e.g.
> 
>     === fileA ===
>     [my] variable = false
>     [your] variable = true
> 
> and applying the "last one wins" rule becomes messy.  I do not
> offhand know what these
> 
>     $ git config --bool my.variable
>     $ git config --bool your.variable
> 
> should say, and do not have a good explanation for possible
> outcomes.

In this case, it makes sense to me to think that files are included
entirely or not at all, so my.variable would be false and your.variable
would be true. I guess the tricky part is something like:

  === .git/config ===
  [my] variable = true
  [your] variable = false
  [includeIf "configEq:my.variable==true"]
    file = fileA
  [includeIf "configEq:my.variable==false"]
    file = fileB
  === fileA ===
    my.variable = false
  === fileB ===
    your.variable = true

and what my.variable and your.variable would end up being.

> Maybe the above example can serve as a way to guide us when we
> design the types of conditionals we allow in includeIf.  This
> example tells us that it is probably a terrible idea to allow using
> values of configuration variables as part of "includeIf" condition.

Hmm...well, remote.foo.url is a configuration variable. I think that the
two-pass approach you describe would work if we prohibit subsequent
inclusions.

> There may lead to similar "'hasremoteurl' makes a well-behaved
> condition, because [remote] are additive and not 'last-one-wins',
> but we cannot add 'lacksremoteurl' as a condition, because a file we
> decide to include based on a 'lacks' predicate may invalidate the
> 'lacks' condition by defining such a remote" design decisions you'd
> need to make around the URLs of the remotes defined for the
> repository.

And if we implement two-pass with no subsequent inclusions, "lacks"
would work the same way.
