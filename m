Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6FC1C33CAF
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0F920728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 22:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BKReAT0h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729992AbgAPWjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 17:39:15 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:43225 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729025AbgAPWjP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 17:39:15 -0500
Received: by mail-pg1-f194.google.com with SMTP id k197so10637218pga.10
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 14:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=RQA4IL+IUXe8/U3bLJbwhNm38Ojt+eQ7pQe5CaRHEsY=;
        b=BKReAT0hzGnLvqTVN+KGUZD5sL6SI+FxTPIeh8/ttVZK63ExMGeipvKDy6s+bFYcYz
         8sl341wX8yLD9Db4sXxT6UDIo9DLw+sBO/oYAC9zIYc6WpzzGY4kLkJ4G7HXSCmQjVEg
         ubJx+SMf+fCycFC1k+aikLV3YwhrdwjcU4aBcQJ0QMkt0AWV5Man0pPgzZT4/nKAP66K
         LSVySBwb61u9smFso0s7IxaOiKgYMT5kUYNLKtX2XgiEFbnhH43OVvB6xKfqzMdwCDRS
         Jue2XoDhA35o0kZ+DTKFcbdIwSBdKW1jkPxWozMVGatTNDGcKT06PHMhdwMyyt3wXnGo
         KdIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=RQA4IL+IUXe8/U3bLJbwhNm38Ojt+eQ7pQe5CaRHEsY=;
        b=sL+zndNXslFhpxnPFtID0EGcXOekKH22wg5jBCBExsav4vwWTB3b8ffESxRw44x8tC
         /KbJkJa7Y9gHWPqtlsAMahLInZKPOR6l00pUT566PM59ZijwmS5oSXfF+/p9NMLGM34t
         JwM8Q127naz0Mg+b0C8yLah35i6RZv6XtIF8Hk3xZyId6fMu2wf62IUxRtnXhfShY/6G
         bwpcjQAIxRq7dQqbLa+7tDLzko1OrgupUF8qh/PSpym2vHMrukT6hkedesWQne21VBsU
         RrUeXn4oVbbX1sego2gPzVZrGx92SC8EczX5eYrXQ7asiaTHxc0sKkfZlacOOpXZuynP
         GLTw==
X-Gm-Message-State: APjAAAWE9oE7011aFmt/KW2EJ4VLerATvPiw/eFJ9j3PwRhenbLhcVQm
        /0Dy8RJ9Eah7BXgixqzEkMU=
X-Google-Smtp-Source: APXvYqzo5GZYeF3Q1spZiHhWWWb9RanaLdO2rFnrJ1CrLHa29AoZq9duV0aE0JhDMYO2R+6JOxHIjw==
X-Received: by 2002:a65:66ce:: with SMTP id c14mr43390824pgw.262.1579214354231;
        Thu, 16 Jan 2020 14:39:14 -0800 (PST)
Received: from google.com (240.242.82.34.bc.googleusercontent.com. [34.82.242.240])
        by smtp.gmail.com with ESMTPSA id r7sm27389256pfg.34.2020.01.16.14.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 14:39:13 -0800 (PST)
Date:   Thu, 16 Jan 2020 22:39:12 +0000
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to
 "merge"
Message-ID: <20200116223912.GB71299@google.com>
References: <20200110231436.GA24315@google.com>
 <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com>
 <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com>
 <20200116080624.GA253496@google.com>
 <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
 <20200116203521.GA71299@google.com>
 <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Thu, Jan 16, 2020 at 12:35 PM Jonathan Nieder <jrnieder@gmail.com> wrote:

>> Historically "git cherry-pick" ran "git commit", causing it to run the
>
> What do you mean "historically"?

Before 356ee4659bb (sequencer: try to commit without forking 'git
commit', 2017-11-24).  See also 4627bc777e9 (sequencer: run
post-commit hook, 2019-10-15).

>                                  I'm pretty sure this piece of code
> is shared in the sequencer between rebase -i, rebase --merge, and
> cherry-pick, so all three currently call post-commit unless I'm
> mistaken.

Yep, that's right.

[...]
>>  A. run post-commit hook consistently in rebase --am and --merge modes
>
> Could you spell these out a bit more?  I think by this option you mean
> "Always run post-commit when commits are created", which includes
> whether those commits were created by git-commit, git-rebase (any
> backend), git-merge, git-cherry-pick, git-revert, git-am, etc. (but
> with a glaring exception for fast-import and things that call it, much
> like the exception post-rewrite already carves out for it).
>
> Much as I don't see a reason to make rebase --merge different than
> rebase --am, I don't see a reason to differentiate between git-merge
> and git-commit.  I also don't see why rebase --am should be different
> than am.

Sure, that matches the general gist behind (A).

[...]
>>  B. stop running the post-commit hook in rebase
>
> AND sometimes in both cherry-pick and git-revert, depending on the
> number of commit(s) picked/reverted (see below).

Interesting.  Doesn't "git cherry-pick A..B" run post-commit after
each commit today?  It would be possible to do (B) and retain that
behavior.

> Also, even if we go this route, I think the post-commit hook should be
> added to git-merge whenever it creates a merge commit.

Agreed.

>>     Advantages:
>>     * makes --am and --merge consistent with minimal user impact
>
> ...and also makes --interactive and --exec and other cases consistent too.

Hm.  My initial thought with (B) was to stop running post-commit in
non-interactive rebase but keep running it in rebase --interactive.

I don't have a strong opinion about this, though.

>>     Disadvantages:
>>     * meaning of the post-commit hook remains a muddle
>
> Why?  "Commands which create no more than one commit (git-commit,
> git-merge, maybe single-commit git-revert or git-cherry-pick) call
> post-commit, commands which create several commits derived from others
> (git-am, git-rebase, git-cherry-pick, sometimes git-revert ) call
> post-rewrite instead for performance reasons"

Example: if I run "git revert A..B", following that rule we'd want to
call post-rewrite instead of post-commit.  But post-rewrite gets input

	<old-sha1> SP <new-sha1> [ SP <extra-info> ] LF

so that it can be used to copy data such as notes.  What do I pass in as
<old-sha1>?

Relatedly, if I remember correctly, we don't call post-rewrite in "git
cherry-pick" because cherry-pick is considered to represent a *new*
commit instead of a modified version of the old one.  In C++ terms,
it's a copy constructor instead of a move constructor. ;-)  See
notes.rewrite.* in "git help notes" for more on that subject.

[...]
>>  C. stop running the post-commit hook in rebase --merge or commit --amend
>>
>>     Advantages:
>>     * produces a consistent definition of post-commit ("it's about new
>>       commits only")
>
> But cherry-pick never creates "new" commits if commit --amend doesn't,
> so we'd also want to turn the post-commit hook off for cherry-pick,
> right?

With the copy/modify distinction described above, "git commit --amend"
acts as a "modify" operation in a user's workflow, while "git
cherry-pick" acts as a "copy" operation.

That means that with this definition, post-commit is appropriate to
run in cherry-pick but not in commit --amend.

This matches the distinction used by note rewriting and the
post-rewrite hook.  Looking back at the discussion in
https://lore.kernel.org/git/cover.1266164150.git.trast@student.ethz.ch/
I don't see this covered, so it's possible I'm remembering wrong (a
pointer to the motivating discussion that inspired that patch series
would be welcome).  In the context of note copying, this distinction
ended up being a good decision in practice in most workflows I've
seen.

[...]
>>     Disadvantages:
>>     * the change to historical "git commit --amend" behavior is likely
>>       to be surprising
>
> That is certainly one issue, but I'd say this case is riddled with
> problems and is the most muddled of all.

I'm inclined to agree, based on the "git commit --amend" example.

[...]
> I think it was useful to phrase it this way and list the various
> advantages, disadvantages, and mitigations; thanks.
>
> Is there anything I've missed in my additional details?  Anything
> sound crazy (beyond what I said I think case C leads to)?

To sum it up, I lean toward (B), but (A) is not so bad, either
(especially with the "I need some time to adapt to the change" opt-out
config described under mitigations).

Thanks for patiently working it through with me.

My two cents,
Jonathan
