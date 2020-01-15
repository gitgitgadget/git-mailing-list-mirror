Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14BBFC33CB3
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:59:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D039E24680
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 21:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sUaKmMtX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729353AbgAOV72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 16:59:28 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:46431 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726513AbgAOV72 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 16:59:28 -0500
Received: by mail-pg1-f195.google.com with SMTP id z124so8814040pgb.13
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 13:59:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SNOwHso3ktsN0Dj9Jbb2xTDPb9gKPEGlAsaz8Cuy5cY=;
        b=sUaKmMtXxr2QSANvNKGA/XbockWrsS4ZXAffXH39TL5tVkaNJLM211SQnV9rBNpxJl
         lluSNJsizKYSYnMqjaeyVpnzoZHRafuRwvXE90hDewEX98H9pPbhf+0QK/OkFPFyPsRi
         DhZqPoZGzX9GpDmjONAShDwHO7+hLiljSifT6Lz8MjcHtZbnDBpwfI+6kH5AzdkllluX
         fOCjsdXtvP8pQr00ON6FD58oii068/6G5SMXjZXiwBXf9A87RTaQpDW5AXFXSGDwFDYA
         Qgb/eEHZ1lGgZpIvQCMTm1NAv/jahOIXK0bK5yV3R7TpO5OFaUEOD6OdOFkM3VbVxEVi
         wkyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SNOwHso3ktsN0Dj9Jbb2xTDPb9gKPEGlAsaz8Cuy5cY=;
        b=jOlpriYkP4ZbE3zDw0Mao5QCjTq6OqxcjWuhV/wXNtb0qY+3BPD+i2cCyUZZt+Jr+Z
         B2yyp1nTvcB15ODY8sAMbnmGuxmJL7JGMIz5D773fU619qdQoPJ3ZKDrwQQEtP3WXsot
         LRp+YyifEqmzr9W1jAjM8KMLYelEnyfIiq33OgoRdFge8QDqMNSQM7ySMgEdqB5y2Hb6
         u5sLgFUGZzhnNyQDM734HdjjnINRDTOe1kspd4kqyNSfwlO84eIRlENWy3Z708LwSvGf
         TgkQd/V/B64YibY/SEiDJby4gi+71tVRio98m6sdxYNs86TOGx7bpiUZULyj5gIA/0LJ
         VcDQ==
X-Gm-Message-State: APjAAAWi3f89vWMoy3vWV4CxPYhwogOlM0913aVIqd4MOtVOyr+4PWSw
        YpoZxRQDpMwhqGUAYHIKv3hBLQ==
X-Google-Smtp-Source: APXvYqxp6Buy82ywfLvUSFuwuI4SDgvmHQLdpP3UljxVnHuvU/up1nN4bHCr+WApyfRVi1rARfeQqg==
X-Received: by 2002:a63:d807:: with SMTP id b7mr36824683pgh.52.1579125567492;
        Wed, 15 Jan 2020 13:59:27 -0800 (PST)
Received: from google.com ([2620:15c:2ce:0:231c:11cc:aa0a:6dc5])
        by smtp.gmail.com with ESMTPSA id j7sm24111186pgn.0.2020.01.15.13.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 13:59:26 -0800 (PST)
Date:   Wed, 15 Jan 2020 13:59:22 -0800
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     phillip.wood@dunelm.org.uk, Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200115215922.GI181522@google.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
 <20200115195011.GA146834@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200115195011.GA146834@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 15, 2020 at 07:50:11PM +0000, Jonathan Nieder wrote:
> Hi,
> 
> Phillip Wood wrote:
> > On 11/01/2020 01:16, Elijah Newren wrote:
> 
> >> But the big question here, is what is correct behavior?  Should rebase
> >> call the post-commit hook, or should it skip it?  I haven't any clue
> >> what the answer to that is.
> >
> > It's creating a new commit so I lean towards thinking it should run the
> > post-commit hook. As an example I have a post-commit hook that prints a
> > warning if a commit is created on a branch that is being rewritten by one of
> > my scripts in another worktree. There are pre-commit and pre-rebase hooks to
> > try and prevent that, but the warning is there as a last resort if those
> > hooks are by-passed.
> 
> The initial design for the post-commit hook was
> 
>     commit 89e2c5f17b901edf28a8bb778ece3f6c18bbb721
>     Author: Junio C Hamano <gitster@pobox.com>
>     Date:   Thu Aug 18 17:20:08 2005 -0700
> 
>     Add commit hook and make the verification customizable.
> 
>     There are three hooks:
> 
>         - 'pre-commit' is given an opportunity to inspect what is
>           being committed, before we invoke the EDITOR for the
>           commit message;
> 
>         - 'commit-msg' is invoked on the commit log message after
>           the user prepares it;
> 
>         - 'post-commit' is run after a successful commit is made.
> 
>     The first two can interfere to stop the commit.  The last one is
>     for after-the-fact notification.
> 
> The initial implementation was only in "git commit" and didn't affect
> other commands, but that's an artifact of implementation, not
> intention.  The intention is more murky: certainly "creating a new
> commit" is not the event we want to notify about (for example, "git
> commit-tree" should not invoke the hook), but if I were designing it
> today then all operations that create a new commit and update the
> current branch with it might qualify.
> 
> Even that definition is a bit fuzzy: when I run "git rebase <upstream>
> <branch>", am I updating <branch> or the current branch?  Are
> cherry-picks that carry over changes that were committed previously
> new commits?
> 
> Worse, we have the body of existing post-commit hooks to contend with,
> and each one may have made different assumptions about the semantics.
> We do not have the luxury of designing the hook without regard to that
> body of existing hooks today.

This seems like the most important point to me. I took a very cursory
peek at some search results on Github
(https://github.com/search?l=&q=filename%3A%2Apost-commit%2A&type=Code)
and I see mostly shims - make sure certain files were included in the
commit, bring a worktree up to date, stage stuff that wasn't committed -
but again, that's a very brief glance at over 19000 probable post-commit
hooks. Of course it's not possible for us to examine all of them, but
having these 19k scripts being run lots of times when they didn't used
to during an operation as common as rebase seems a little scary.

> The hook that jiri installs is very simple.  It wants to check when a
> user has (interactively) made a commit on a detached HEAD, to let them
> know that they might want to use "git checkout -b" afterward.  With
> this particular hook, the behavior is better when git rebase does not
> invoke the hook, since in the context of a rebase, the user has no
> need to use "git checkout -b" afterward.  This is a regression, and I
> think we need to take that seriously.
> 
> It doesn't seem like jiri is doing anything weird here, so there's a
> reasonably high probability that other hooks would be affected in the
> same way.  How can we help authors of such hooks to handle this
> change?

This part I do disagree with. Git warns (advice-optional) when I enter
detached HEAD state. When I leave my detached HEAD with some orphaned
commits within (via checkout), I get a warning unconditionally, and an
advice-optional tip to use 'git branch <name> <commit-id>'. The Jiri
hook is warning that these commits I'm making could be lost, but in fact
Git itself is telling me that (and how to save them) at the first moment
when they are actually in danger. So I think this particular example is
not a good one.

I'm more worried about ones like this, although in the rebase case it
may well be a no-op as I can't start a rebase with a dirty index:
https://github.com/alphagov/digitalmarketplace-runner/blob/f8524d9ee7465caef0571d8beb8dff4b25d10fe7/hooks/post-commit

Perhaps a good question is "what could be very catastrophic if it
happened during the middle of a rebase, but not such a bad thing if it
happened when I run 'git commit'?"

> I don't think that starting to invoke the 'post-commit' hook even more
> without going through that thought process is an acceptable fix.
> Since the "right" semantics aren't obvious here, the first step is
> probably to collect some typical examples of post-commit hooks, like
> the example from the message I'm replying to (thank you!).  Ideas for
> where we can find more?

That Github search query I posted above is a pretty big haystack. I
suppose plenty of folks who contribute to Git have a userbase and might
be familiar with some workflows in use there, right?

 - Emily
