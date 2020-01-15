Return-Path: <SRS0=RXbn=3E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B096C32771
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:50:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 00C902465A
	for <git@archiver.kernel.org>; Wed, 15 Jan 2020 19:50:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d8zluxm4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729433AbgAOTuP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:50:15 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34437 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729299AbgAOTuO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Jan 2020 14:50:14 -0500
Received: by mail-pl1-f194.google.com with SMTP id c9so1976075plo.1
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 11:50:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MEYfKbWGxa3FY+/r4tH+bwef7+xk9zjbpcjlJbojLmI=;
        b=d8zluxm4Q+MDUp1QP79N25xAeguOWxi2ESkbEITet5qkCph3in7XSPeiZ5qNyfmhDa
         ZR5tCpLFn277hivO5qu/PXn7zPBmqdoOqbbnzMlx76+NmjkjW2ic29vxxl3ugCMmKSQB
         Kftg5tTkxaeEhXq1ZAGq1hxKRqmgtmYMHyzMwmySR7TRh7VOOt5S832gkUgTxY9OWxsC
         44ienOLAND9UtK+e0AMqUutBfqV0ixB5lfDAWt7HWhBf13sU4HpF/ugepqqcT8rkmNRK
         FRbaA8ZPq3NEIWFjFWzYWamJny7L9ZfdlhF5vVTckqJOt3wD00JIw0w7lV3VtYBhYJRu
         Z59Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MEYfKbWGxa3FY+/r4tH+bwef7+xk9zjbpcjlJbojLmI=;
        b=Qg6udb0Mrj5YaO0OIt66UWwxmV/OYdSJGDC6cDPNfMASyV68L5u2gusBp+PKvHksgB
         4lUCFL6xxQZL2RSrqoLmNQTm8dqVsxgF+5U55NWCIJClrP3nf7FSXW73Tix01I2Jm4jS
         RaGSnfunjcG46PhLphZqY4wpzWPY1P6NtICWgsVs1gP1JK0otMK4RTDsqP0IbkdwWBBK
         VBf0az14tbm5MRzJfoGlG3x3ZVOWmtMgpRHs08twUmbJ+L46FV7rKuQXBFI6ey0mWJ2r
         O+3sOXj+HSA+AyIw4eNHhG4J478eNtFZdok0yo6py1A0acAMXAn3nHP8sjZD59eqleH0
         CQWg==
X-Gm-Message-State: APjAAAWo+tEemSSK1Fv/f1M/bPD0j27XcvhiNjAfIlS/T0ZQkoiTNp+J
        AujZmbU5fNW8tlT3ZRmcbqE=
X-Google-Smtp-Source: APXvYqyuMHUZZqZb1MNlg0P9E1bkjaeg9r3tdtlSpg2j1YKZB0orQbfRlhsRk06edz+DXGqcgMwcZQ==
X-Received: by 2002:a17:90a:868b:: with SMTP id p11mr1874121pjn.60.1579117813821;
        Wed, 15 Jan 2020 11:50:13 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id p18sm274621pjo.3.2020.01.15.11.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 11:50:13 -0800 (PST)
Date:   Wed, 15 Jan 2020 19:50:11 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     phillip.wood@dunelm.org.uk
Cc:     Elijah Newren <newren@gmail.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200115195011.GA146834@google.com>
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Phillip Wood wrote:
> On 11/01/2020 01:16, Elijah Newren wrote:

>> But the big question here, is what is correct behavior?  Should rebase
>> call the post-commit hook, or should it skip it?  I haven't any clue
>> what the answer to that is.
>
> It's creating a new commit so I lean towards thinking it should run the
> post-commit hook. As an example I have a post-commit hook that prints a
> warning if a commit is created on a branch that is being rewritten by one of
> my scripts in another worktree. There are pre-commit and pre-rebase hooks to
> try and prevent that, but the warning is there as a last resort if those
> hooks are by-passed.

The initial design for the post-commit hook was

    commit 89e2c5f17b901edf28a8bb778ece3f6c18bbb721
    Author: Junio C Hamano <gitster@pobox.com>
    Date:   Thu Aug 18 17:20:08 2005 -0700

    Add commit hook and make the verification customizable.

    There are three hooks:

        - 'pre-commit' is given an opportunity to inspect what is
          being committed, before we invoke the EDITOR for the
          commit message;

        - 'commit-msg' is invoked on the commit log message after
          the user prepares it;

        - 'post-commit' is run after a successful commit is made.

    The first two can interfere to stop the commit.  The last one is
    for after-the-fact notification.

The initial implementation was only in "git commit" and didn't affect
other commands, but that's an artifact of implementation, not
intention.  The intention is more murky: certainly "creating a new
commit" is not the event we want to notify about (for example, "git
commit-tree" should not invoke the hook), but if I were designing it
today then all operations that create a new commit and update the
current branch with it might qualify.

Even that definition is a bit fuzzy: when I run "git rebase <upstream>
<branch>", am I updating <branch> or the current branch?  Are
cherry-picks that carry over changes that were committed previously
new commits?

Worse, we have the body of existing post-commit hooks to contend with,
and each one may have made different assumptions about the semantics.
We do not have the luxury of designing the hook without regard to that
body of existing hooks today.

The hook that jiri installs is very simple.  It wants to check when a
user has (interactively) made a commit on a detached HEAD, to let them
know that they might want to use "git checkout -b" afterward.  With
this particular hook, the behavior is better when git rebase does not
invoke the hook, since in the context of a rebase, the user has no
need to use "git checkout -b" afterward.  This is a regression, and I
think we need to take that seriously.

It doesn't seem like jiri is doing anything weird here, so there's a
reasonably high probability that other hooks would be affected in the
same way.  How can we help authors of such hooks to handle this
change?

I don't think that starting to invoke the 'post-commit' hook even more
without going through that thought process is an acceptable fix.
Since the "right" semantics aren't obvious here, the first step is
probably to collect some typical examples of post-commit hooks, like
the example from the message I'm replying to (thank you!).  Ideas for
where we can find more?

Thanks,
Jonathan
