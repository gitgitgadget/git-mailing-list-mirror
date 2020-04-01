Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2EB4C43331
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7E55F20787
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 04:18:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4z5Yehq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731761AbgDAESd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 00:18:33 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:39774 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731589AbgDAESd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 00:18:33 -0400
Received: by mail-oi1-f196.google.com with SMTP id d63so21051859oig.6
        for <git@vger.kernel.org>; Tue, 31 Mar 2020 21:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eNhjPQzxxUI8P/Q7+Do0Flvj7iOnxc8PPnzFxcf/lCc=;
        b=Z4z5YehqrdVr9AkAlaMR25MzfvNlF0vcpEu7b8kvSB/So7XNtMtKnglkwMcfVkuql/
         8st6bfrrJtUKRW2ol0Gmz92w+vgYmNK9hik9YYCrhIWyLANOFP/oquI0zOsudBzCpXo4
         HuqGqqWWygpuw4Z+M4qxeMfSJT4njdBTA00vhIu3xsk8qjGAMzgnP99k7BAa+qLjUrwK
         NXAUaqOzbf6CCo11079oIqT1wOHc2QtMKtbsLKqfdX8KSEMXxrPd9UBKqD6MnnMAmTLf
         iHinik4hLxXruh1pdkL2fEHsdGmVXNSktCwUW6tcSKHFnoMTTsrXkQePo5x03PlbWlzZ
         HczA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eNhjPQzxxUI8P/Q7+Do0Flvj7iOnxc8PPnzFxcf/lCc=;
        b=eCV5AVDg+ufGmm/yLjyTw2vrhrUkE3GTtRMWAq9UJbfL5+yUd3eNeXyrq2oVNiPvmu
         LaqssstA9IBpw6mi0NEjM250/1Sdi1Ae5j45v6V+ETNYVy+s596Jdz9J3FQwgL6x+ZIQ
         hDshi7hobqPZVqhQs3guZ9EF4qFtyS/e6DIsmUn3pzNssHggr36pSAN1ojcidSn5zlB9
         5HlzjsHIqFfeltMVkVaigtcAmotJDepRdWYEpjWW4RHZa/rmnbCoSz16KmJsPv1WjIp1
         +13pX03BWtgZUmb+FRSrHotFlOGhZMlDfuhBALskKDbes3sOrdiN7x2Zfy1HxSZ1yFOJ
         QC1Q==
X-Gm-Message-State: AGi0Pub5KLJoB98Hsq9Ie4Vgtbg19o6S88j3ZoT0uydBrWXVM3Kvb6Cq
        1DksB9MVC0VLWPSHj1O7Rmf4y4ObtYbIN/ImloY=
X-Google-Smtp-Source: APiQypK5BUwNncJXmARCOrqLv+bCwQSYIcDPhofV2LEn3tfVwKLcI7Y0scrC8tJkzkhBO1Yc6vMzKy7MbSkjtVaKvB0=
X-Received: by 2002:aca:d8d4:: with SMTP id p203mr1552770oig.39.1585714711806;
 Tue, 31 Mar 2020 21:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <6776c32d-35f5-3134-35c7-1c9b803d8c37@debian.org>
 <24190.33234.108820.211871@chiark.greenend.org.uk> <20200328023438.GA202996@google.com>
 <24191.15179.253629.878217@chiark.greenend.org.uk>
In-Reply-To: <24191.15179.253629.878217@chiark.greenend.org.uk>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 31 Mar 2020 21:18:20 -0700
Message-ID: <CABPp-BEiRtG=8xpXy-HYLDGdh9v7uwREuiCvwr--8UqrZ_pz2w@mail.gmail.com>
Subject: Re: git-rebase ignores or squashes GIT_REFLOG_ACTION
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Paul Gevers <elbrus@debian.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 28, 2020 at 4:55 AM Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
>
> Jonathan Nieder writes ("Re: git-rebase ignores or squashes GIT_REFLOG_ACTION"):
> > The main relevant change is that "git rebase" switched its default
> > backend from "apply" to "merge".  This makes it more robust by using
> > three-way merges in a similar way to "git cherry-pick".  The "merge"
> > backend was historically already used for interactive rebases.
>
> Ah.  Interesting.  A co-worker had a case recently where "merge" did
> the wrong thing (silently misapplied a hunk!) but "apply" did the
> right thing and I remmber thinking that "merge" ought to be the
> default (since it can do a better job by using all of the available
> information).  So I applaud that change.
>
> > If I am reading
> >
> >  commit 13a5a9f0fdcf36270dcc2dcb7752c281bbea06f1
> >  Author: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> >  Date:   Thu Nov 29 11:09:21 2018 -0800
> >
> >      rebase: fix GIT_REFLOG_ACTION regression
> >
> > correctly, then dgit requires that to be '-i' for interactive rebases.
> > Are we sure that that's not the issue here?
>
> git-debrebase invokes git-rebase both with and without -i, depending
> on the user's own choice.  In this case, git-debrebase is invoking
> git-rebase *without* -i.
>
> But maybe I have misunderstood.  Maybe you mean `are you sure the test
> case doesn't demand that "-i" appears in the reflog' ?  In which case,
> yes.  The failing line in the test case (which is a shell script) is:
>   git reflog | egrep 'debrebase new-upstream.*checkout'
>
> Here is a repro for the problem.  Run the attached script, optionally
> with "-i" as a single argument.  The script will "rm -rf d" and
> recreate it.  It sets GIT_REFLOG_ACTION="plim" and does a nontrivial
> rebase in a fresh tree, and prints the resulting reflog.
>
> On older git, without -i, quoting only the relevant bits:
>   fc9165e HEAD@{0}: rebase finished: returning to refs/heads/master
>   fc9165e HEAD@{1}: plim: 3
>   ebf6515 HEAD@{2}: plim: checkout HEAD~2
> This is right except for the final finish message.
>
> On older git, with -i:
>   4f6cff0 HEAD@{0}: plim: checkout HEAD~2: returning to refs/heads/master
>   4f6cff0 HEAD@{1}: plim: checkout HEAD~2: 3
>   9f5e72d HEAD@{2}: plim: checkout HEAD~2
> This seems to be wrong for all but the initial checkout.
>
> On newer git, I get this output both with and without -i:
>   30067e1 HEAD@{0}: rebase (finish): returning to refs/heads/master
>   30067e1 HEAD@{1}: rebase (pick): 3
>   8a9a5fd HEAD@{2}: rebase (start): checkout HEAD~2
> This is wrong because it doesn't mention "plim" at all.  That's
> what is spotted by my test case.
>
> I think the best output would be this:
>   30067e1 HEAD@{0}: plim (finish): returning to refs/heads/master
>   30067e1 HEAD@{1}: plim (pick): 3
>   8a9a5fd HEAD@{2}: plim (start): checkout HEAD~2
> or this:
>   30067e1 HEAD@{0}: plim: rebase (finish): returning to refs/heads/master
>   30067e1 HEAD@{1}: plim: rebase (pick): 3
>   8a9a5fd HEAD@{2}: plim: rebase (start): checkout HEAD~2
>
> Which of those two is better depends on whether you think callers
> ought to put something to do with "rebase" in GIT_REFLOG_ACTION
> somewhere.  In this particular case, git-debrebase sets it to
> something like
>   debrebase new-upstream $new_version: rebase
> because it thinks that its GIT_REFLOG_ACTION value will replace
> the usual "rebase", rather than supplementing it.
>
> I think either choice on git-rebase's part would be reasonable and the
> output with current git-debrebase behaviour is good enough either way.
> The former choice on git-rebase's part would produce the prettiest
> output with my current setting of GIT_REFLOG_ACTION.  And it allows
> the caller the most control over the reflog messages.  Unconditionally
> adding the top-level command being invoked could be simulated by the
> caller (whereas adding things like "(finish)" cannot).  So if it were
> up to me I would have git-rebase produce the first of my two expected
> outputs, ie
>   30067e1 HEAD@{0}: plim (finish): returning to refs/heads/master
> etc.
>
> But my test case merely demands that "plim" appears *somewhere*.
>
>
> Aside:
>
> Obviously with an interactive rebase, it might well stop, and the user
> will then later presumably git-rebase --continue (or maybe --abort)
> etc.  Those commands will no longer (necessarily) have
> GIT_REFLOG_ACTION in their environment.  So, with the obvious
> implementation, depending on the circumstances the reflog for later
> parts of the rebase might not contain all the relevant information.
>
> This is unavoidable unless git-rebase were to make a note of the value
> of GIT_REFLOG_ACTION somewhere - and even in that case, it wouldn't
> affect git commit (which is often a thing that is run in the middle of
> an interactive rebase) unless this note had a global effect.  It seems
> to me that it would be a bad idea for git-rebase to do anything like
> this.  Not only would it have to squirrel away GIT_REFLOG_ACTION and
> (perhaps surprisingly) honour it later, it would presumably have to
> try to combine it with the value in force during later commands.
>
> This would all be complicated and provide plenty of opportunity for
> weird corner case bugs, in order to do something which (to say the
> least) it's not clear is desirable.
>
> Instead, I think that the GIT_REFLOG_ACTION in the environment of
> git-rebase should take effect for all the things that are done
> by or on behalf of that git-rebase command until that git-rebase
> command has exited.  Future commands should honour the
> GIT_REFLOG_ACTION in force at that later time.  I hope you
> agree :-), and I'm giving this aside for completeness.
>
>
> I hope this is helpful.

Thanks for the report and details.  Sorry for my slow response; I've
got this thread marked as important, just haven't gotten back to it
with the other things in the queue yet.
