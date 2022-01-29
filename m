Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D078C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 08:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344981AbiA2ISI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 03:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235248AbiA2ISH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 03:18:07 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5342C061714
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 00:18:07 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id w81so2961739ybg.12
        for <git@vger.kernel.org>; Sat, 29 Jan 2022 00:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4M126kntqeyNcPAZBl09PnofcxtmvZkLYy7lF1Cz7Rc=;
        b=OCvstx0NaTETyZ+cJA9sC9UwsJ3aLbY/5VSuQpodLFQlf6MhZ3zzQLoqfNgxYtMNLJ
         yf9wpSCIXFZUFiUpTe6BW9UXoAlXVUPaPpac6OkKA51sAGR7u1L0nS6J8CrW091s6dR5
         5ZMUU2DH9XtjHMf1NUDHnyU3aY2tJUehbqqlh4QfchiOSJZmxiL0Ncr1QiqratIQp11A
         ZwRjL8FjRlq1b4oXVa6hvnFl/jPm4u/Xlpv9FmjNk/QKBZpV15fsC0wxXypCGnJZB2uV
         166sDHQlTxNHXR7t5BwoKUflUag5CgvBmghSs0Wj7OPv00e4sOZL0P5E+7qlKajSUWUx
         7b4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4M126kntqeyNcPAZBl09PnofcxtmvZkLYy7lF1Cz7Rc=;
        b=QIZ+bojfYhdkQi1DWRGuB0APAz4m6+oFFTPXzGTtUYKdHtJqO8wThEhTIHJXimIok7
         YvPJVeY+qIVm9kwQVLFPyvu7KLu3K4j4EuizAQxuaYlt3lW46YuXhSF82zf5mXtGV3wX
         Eh7s3RptbKCBbJ2Xa55gyINwD3Bd1dO+kZK5jwdYreNu83Z6idXKCjBgUAbgfxJD4scW
         UepgCHBrWhXtUnrZF11pITAFIRcQQzoN/j2JUY66xGQW7OqY3W92dFExks1ka4ALdoZ/
         OTgPccdhWXk6q7rxsLaHBmrugYSDVmozKuQluPOXT7AVi2YJsrPScgG2l88ZCfOVDWmU
         SRAg==
X-Gm-Message-State: AOAM531ffRcNNw4ZdMZobU9/HVjdu01W4E/ec+DBbZ2Ryr0zHVv7xHQj
        M67vhzP1Y4HcGtOQfjLFYTB8J3VS20mtPUBeRQh1QM+E20w=
X-Google-Smtp-Source: ABdhPJxqzkiOXHfwN8oA2jkdsIlhktKCO2iuAXQyXttjpU3gntwkDvqD/OkeLC8WxmiE7OEh9EWYtEstRjAl8fp6Ceg=
X-Received: by 2002:a25:71c4:: with SMTP id m187mr18305209ybc.427.1643444286743;
 Sat, 29 Jan 2022 00:18:06 -0800 (PST)
MIME-Version: 1.0
References: <pull.1122.git.1642888562.gitgitgadget@gmail.com>
 <CAP8UFD1-=RDx5=JpHEp=sFEOWr2MP-YovOPE7aTydrPLoVGa5w@mail.gmail.com> <CABPp-BH2sWWwy5bgn+R0hnnYQ6o0+1R1=VB-LYzDM+p4NMRhWg@mail.gmail.com>
In-Reply-To: <CABPp-BH2sWWwy5bgn+R0hnnYQ6o0+1R1=VB-LYzDM+p4NMRhWg@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 29 Jan 2022 09:17:55 +0100
Message-ID: <CAP8UFD243zGGderSFtH5WxOhidAv6566Df6vdUfKRiBb1qu9tg@mail.gmail.com>
Subject: Re: [PATCH 00/12] RFC: In-core git merge-tree ("Server side merges")
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jan 29, 2022 at 8:04 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Wed, Jan 26, 2022 at 12:48 AM Christian Couder
> <christian.couder@gmail.com> wrote:
> >
> > On Sat, Jan 22, 2022 at 10:56 PM Elijah Newren via GitGitGadget
> > <gitgitgadget@gmail.com> wrote:

> > > Stuff intentionally NOT included, but which others seemed to feel strongly
> > > about; they'd need to convince me more on these:
> > >
> > >  * Any form of diff output[1]
> >
> > It's not a big issue for me to not include them right now as long as
> > it's possible to add cli options later that add them.
>
> My main concern is just that `merge-tree` remain a low-level tool and
> have machine-parseable output.  I was a little worried that both you
> and Dscho wanted everything on stdout rather than in separate files,
> as the <Informational messages> part of the output is rather
> free-form.  But since it's at the end, and has a machine-parseable
> beginning, it can just be slurped in and we're all good.  The diff
> output raises my eyebrow because I'm worried we're losing this
> property.  If there are clear usecases for adding more output, and we
> can do so without losing this machine-parseable property, I don't have
> a problem with adding an option for it.

That's ok for me for now. I will certainly not work on adding options
for diff output without any usecase.

> One analogy we might use here is that `git merge` provides a diffstat
> at the end.  What you're asking is more than a diffstat, but might be
> considered similar-ish in nature.
>
> > The reason is
> > that I think in many cases when there are conflicts, the conflicts
> > will be small and the user will want to see them.
>
> I'm a little worried about the assumption here that conflict size is
> measurable and visible via diffs.  That might be true in some cases,
> but a UI written with that assumption is going to be very confusing
> when hitting cases where that assumption does not hold.  For example:
>
>   * What if there is a binary file conflict, or a modify/delete or
> rename/delete conflict, or failed-to-merge submodule conflict, or a
> file location conflict? (For these, there is no diff relative to the
> first parent and hence this conflict would have no diff output for
> it)?
>   * What if there was a simple file/directory conflict?  A diff would
> show a rename (even when neither side did any renames), but not any
> conflict markers.
>   * What if there was a rename/rename conflict (both sides renamed
> same file differently) or a distinct types conflict?  The former
> results in three different conflicting files, none of them with
> conflict markers, while the latter results in two different
> conflicting files both without conflict markers?  Showing individual
> per-file diffs totally loses all context here -- it'll show no-diff
> for one of the files, and totally new additions for the ones.

In those cases we just tell users that they cannot resolve those
conflicts in the user interface, see the following doc:

https://docs.gitlab.com/ee/user/project/merge_requests/conflicts.html#conflicts-you-can-resolve-in-the-user-interface

> Such a problem statement just seems fraught with edge cases to me, and
> suggests that the problem statement might be in need of revisiting.

Users understand that some kinds of conflicts cannot yet be resolved
using a user interface. Maybe we will be able to make improvements so
that more kinds of conflicts can be resolved in a UI in the future
though. That's why a flexible and extensible output could help.

> Don't read this as me closing the door on the possibility of diffs;
> I'm not trying to do that.  I'm listing my misgivings about how I
> think they might be used (i.e. be careful if you're headed down this
> path as you might be digging yourself a never-ending support hole).
> You can also think of my comments as feedback to consider and address
> when you propose a future feature addition for adding diffs.  If/when
> you propose such a feature, we'd probably be able to dive more into
> specifics and usecases at that time, which may or may not circumvent
> my concerns.

I know that diffs, or any new single feature, will likely not be a
silver bullet.

> > So it would be
> > simpler to just have an option to show any conflict right away, rather
> > than have the user launch another command (a diff-tree against which
> > tree and with which options?).
>
> Um, this part I'm not sure I get.  I thought the reason for the diffs
> was performance -- you knew you wanted the diffs, and you wanted it
> done as part of the same process.  But why would this be simpler?

In the commit message of 4/12 you show an example of using it in simple scripts:

NEWTREE=$(git merge-tree --write-tree $BRANCH1 $BRANCH2)
test $? -eq 0 || die "There were conflicts..."
...

So I think it would be simpler for someone interested in seeing the
conflicts, like a script writer, or maybe someone using it manually
for example as a dry run before performing a merge, to be able to get
them right away from the command rather than to have to use another
command (which means finding the right command, arguments and options
for that) to get them.

> Your patch series included three different diffs, and the emails you
> pointed me at suggested all kinds of configurability.  That suggests
> the merge-tree command would have to take the exact same options the
> user would supply to diff, and thus would have to be told all the same
> options, right?  I don't see how this removes any complexity at all
> for the user.
>
> Unless...is the request in some way similar to merge's diffstat where
> there is always a very specific type of diff that is wanted and you
> aren't envisioning much flexibility in what kind of diff or what to
> diff against -- is that where the simplification comes from?

Well I just think the default diff output could be tailored for the
most likely usecases and options made available later for more
advanced usecases or users.
