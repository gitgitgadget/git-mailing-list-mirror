Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4345AC43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 08:43:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbiGZIna (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jul 2022 04:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiGZIn3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jul 2022 04:43:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8650A27CCE
        for <git@vger.kernel.org>; Tue, 26 Jul 2022 01:43:27 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 43ABE373E8;
        Tue, 26 Jul 2022 08:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658825006; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//OSqieK60ZrkiHBrvp3wqk5onclBqJmVh7tXTRtrGc=;
        b=fR2PfJYUSq8wXRqLA7CfjW0pYXFiqLNZwJ5t5exHaHLZ1vNno9Yi7MYJD34lIvB4r9+Clq
        bbX4P3NF4WgG+9Tb2cAHu5nJvE8Kp+VIqgdBObb1N3hJVOPReNN7/wWDPfM4pwsbCdDxje
        XkNnKtU4fd9YN6Ptp2J3ucdj9wiCD18=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658825006;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=//OSqieK60ZrkiHBrvp3wqk5onclBqJmVh7tXTRtrGc=;
        b=WI6nagMqDS6hl7G76syhWaHKycYGcmHNrDe4s8VLpDeDn8qCOZoUmUz3SNSMYGx8slRK0Z
        lEFdquZgmXZNxuBA==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4FB572C161;
        Tue, 26 Jul 2022 08:43:25 +0000 (UTC)
Date:   Tue, 26 Jul 2022 10:43:24 +0200
From:   Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        Hilco Wijbenga <hilco.wijbenga@gmail.com>,
        Phillip Susi <phill@thesusis.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Stephen Finucane <stephen@that.guru>,
        Git Users <git@vger.kernel.org>
Subject: Re: Feature request: provide a persistent IDs on a commit
Message-ID: <20220726084324.GO17705@kitsune.suse.cz>
References: <220718.86ilnuw8jo.gmgdl@evledraar.gmail.com>
 <87a692e8vj.fsf@vps.thesusis.net>
 <CAE1pOi1pS76iXU8j=A54wPGHC7qofxrPDAO4uyy0d6yMxeQwvw@mail.gmail.com>
 <6426b5c3-0a09-f641-9876-3534b0abd96d@iee.email>
 <20220722203642.GD17705@kitsune.suse.cz>
 <CA+P7+xr+k35RXoGv-O96fsfOJ+sg65HrVvt-3JKYAzerA0TJRw@mail.gmail.com>
 <20220723070055.GE17705@kitsune.suse.cz>
 <CABPp-BEYQOtr6EZmi4emKRKNVXS3071Ud90jiLycdGXGG+YqgQ@mail.gmail.com>
 <CA+P7+xoygnvi8_8JjOSftahKZFC3bZBkzA-LQ8-xAp9fkV79pw@mail.gmail.com>
 <CABPp-BHWueqbFMpz4jMPK9G3xY5=jvWLELLQribU69CYD5DjKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABPp-BHWueqbFMpz4jMPK9G3xY5=jvWLELLQribU69CYD5DjKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

On Mon, Jul 25, 2022 at 08:49:30PM -0700, Elijah Newren wrote:
> On Mon, Jul 25, 2022 at 2:47 PM Jacob Keller <jacob.keller@gmail.com> wrote:
> >
> > On Sat, Jul 23, 2022 at 10:23 PM Elijah Newren <newren@gmail.com> wrote:
> > >
> > > On Sat, Jul 23, 2022 at 12:44 AM Michal Suchánek <msuchanek@suse.de> wrote:
> > > >
> > > > On Fri, Jul 22, 2022 at 03:46:22PM -0700, Jacob Keller wrote:
> > > > > On Fri, Jul 22, 2022 at 1:42 PM Michal Suchánek <msuchanek@suse.de> wrote:
> > > > > >
> > > > > > On Fri, Jul 22, 2022 at 09:08:56PM +0100, Philip Oakley wrote:
> > > [...]
> > > > > > > Part of the rename problem is that there can be many different routes to
> > > > > > > the same result, and often the route used isn't the one 'specified' by
> > > > > > > those who wish a complicated rename process to have happened 'their
> > > > > > > way', plus people forget to record what they actually did. Attempting to
> > > > > > > capture what happened still results major gaps in the record.
> > > > > >
> > > > > > Doesn't git have rebase?
> > > > > >
> > > > > > It is not required that the rename is captured perfectly every time so
> > > > > > long as it can be amended later.
> > > > > >
> > > > >
> > > > > Rebase is typically reserved only to modify commits which are not yet
> > > > > "permanent". Once a commit starts being referenced by many others it
> > > > > becomes more and more difficult to rebase it. Any rebase effectively
> > > > > creates a new commit.
> > > > >
> > > > > There are multiple threads discussing renames and handling them in git
> > > > > in the past which are worth re-reading, including at least
> > > > >
> > > > > https://public-inbox.org/git/Pine.LNX.4.58.0504141102430.7211@ppc970.osdl.org/
> > > > >
> > > > > A fuller analysis here too:
> > > > > https://public-inbox.org/git/Pine.LNX.4.64.0510221251330.10477@g5.osdl.org/
> > > > >
> > > > > As mentioned above in this thread, depending on what context you are
> > > > > using, a change to a commit could be many to many: i.e. a commit which
> > > > > splits into 2, or 3 commits merging into one, or 3 commits splitting
> > > > > apart and then becoming 2 commits. When that happens, what "change id"
> > > > > do you use for each commit?
> > > >
> > > > Same as commit message and any trailers you might have - they are
> > > > preserved, concatenated
> > >
> > > Exactly how are they concatenated?  Is that a user operation, or
> > > something a Git command does automatically?  Which commands and which
> > > circumstances?  If users do it, what's the UI for them to discover
> > > what the fields are, for them to discover whether such a thing might
> > > be needed or beneficial, and the UI for them to change these fields?
> > > This sounds like a massive UX/UI issue that I don't have a clue how to
> > > tackle (assuming I wanted to).
> > >
> > > > and can be regenerated.
> > >
> > > "can be".  But generally won't be even when it should be, right?
> > >
> > > Committer name/email/date basically don't even exist as far as many
> > > Git users are concerned.  They aren't shown in the default log output
> > > (which greatly saddens me), and even after attempting to educate users
> > > for well over a decade now, I still routinely find developers who are
> > > surprised that these things exist.
> > >
> > > Given that committer name/email/date aren't shown with --pretty=full
> > > but with the lame option name --pretty=fuller, I can't see why it'd
> > > make any sense to show Change-Ids in the log output by default.
> > >
> > > But if it's not shown -- and by default -- then it doesn't exist for
> > > many users.  And if it doesn't exist, users aren't going to fix it
> > > when they need to.
> > >
> > > (Even if it were shown by default, it's not clear to me that users
> > > would know when to fix it, or how to fix it, or even care to fix it
> > > and instead view it as a pedantic requirement being foisted on them.)
> > >
> > > I think the "many-to-many issue" others have raised in this thread is
> > > an important, big, and thorny problem.  I think it has the potential
> > > to be a minefield of UX and a steady stream of bug reports.  And
> > > seeing proponents of Change-Id just dismissing the issue makes me all
> > > the more suspicious of the proposal in the first place.
> >
> > I do think there is some value in having a sort of generic id like
> > change-id, but I do think we want to be careful about how exactly we
> > handle it.
> >
> > As you say, if we hide it then users may not be aware of it, and if we
> > make it visible users who don't care may be annoyed. I don't think we
> > can fully automate it because of the nature of combining changes and
> > splitting changes require humans to decide which change keeps which
> > ID. Its not even clear when rebasing whether a split is going to
> > happen. A combine operation is easier to detect in rebase
> > (fixup/squash), but determining which id to keep is not. Would we even
> > want to have support for "this commit merges two and is now one, but
> > we keep both IDs because it really is both commits"? That gets messy
> > pretty fast.
> >
> > Users such as gerrit already simply use the trailer with Change-id and
> > manage to make it work by enforcing some constraints and assuming
> > users will know what to do (because otherwise they fail to interact
> > with gerrit servers).
> >
> > For cases where it helps, I think its very valuable. Being able to
> > track revisions of a series or a patch is super useful. Getting
> > external tooling like public-inbox, patchworks, etc to use this would
> > also be useful. But I think we would want to sort out the situation a
> > bit for how and when are they generated, when are they
> > replaced/re-generated, how this interacts with mailing etc.
> >
> > Should rebase just always regenerate? that loses a lot of value. I
> > guess squashing could offer users a choice of which to keep? Fixup
> > would always keep the same one. And otherwise it becomes up to users
> > to know when they need to copy from an old commit or refresh an
> > existing commit... Thats pretty much what gerrit does these days, if a
> > commit doesn't have the trailer it gets added, and if it does, its up
> > to the user to know when to remove it or regenerate it... Since its a
> > commit message trailer it gets sent implicitly through the mailing
> > list unless removed.
> 
> Yes, I fully agree it needs to be spelled out a lot more.  And not
> just obvious commands (everyone seems to focus on commit, cherry-pick,
> and rebase), but what about e.g. `git merge --squash`?
> 
> Also, as far as value goes, I have an interesting story related to
> Change-Ids (read the last sentence if you only want the summary):
> 
> 
> <long story>
> 
> I have used Gerrit fairly heavily.  I maintained an instance for a few
> hundred developers for several years (inheriting it from others), and
> was responsible for various build & release stuff related to one of
> the larger products tracked in it (an approximately
> linux-kernel-sized) product.  I also attended a Gerrit conference or
> two and submitted a few patches for Gerrit that were accepted.  So,
> for context, I'm clearly not a Gerrit developer since I only submitted
> a few patches, but I was the clear expert within my company on Gerrit.
> So that's my background.
> 
> Some background on the (insane) project management of the time
> (unrelated to Git or Gerrit or Change-Ids) is also important to
> understand this story:  Years ago, this project had well over 100
> active branches (!!).  And yes, branches were being aggressively
> retired, but I still remember when we finally managed to get the count
> under 200.  Each branch had important patches, and hundreds of patches
> on these branches was not uncommon.  Yes, it was insane, and yes, I
> and many others were really happy when we eventually reached the land
> of sanity with just a few active branches (and all but the main one
> only gets backport fixes).
> 
> One of the things I did to help us move in the direction towards
> sanity was a "snowflake report" -- a report that would help people
> determine which patches had not already been upstreamed (i.e. not
> included in the main development branch of the same repository), and
> which still needed to be.  (The terminology for the report was that
> unique patches that weren't upstream were "snowflakes" which we were
> trying to pick out of a "blizzard of commits").  Anyway, the immediate
> impetus for this report was that after enough disasters from
> forgetting to upstream important patches, people started asking around
> about how to avoid another repeat.  I thought this was a trivial
> question to answer at first, but...I was wrong.
> 
> Now, as I said before, this product was tracked in Gerrit.  Also,
> direct pushing to bypass reviews was disabled (with _very_ rare
> exceptions, that essentially didn't affect the quality of the report
> mentioned below at all), and Change-Ids were required for all commits
> pushed up for code reviews.  So, yes, people had the Gerrit-suggested
> hook installed, and yes virtually all commits had Change-Ids.
> 
> So, what was implemented to answer "which patches in this branch have
> been upstreamed (i.e. included in the main development branch)"?  A
> variety of checks.  One of which was fully reliable:
> 
>     * "git cherry" to catch the "100% certainty cherry-picks" (only
> caught maybe 5% of the upstreamed patches, but still useful).
> 
> And a bunch of other checks that were just heuristics:
> 
>     * (author name, author email, author date) triples matching
>     * commit message exactly matching
>     * "(cherry-picked from commit <HASH>)" footers from one commit
> referring to another (or there being a transitive chain that wasn't
> too long, or there being a transitive tree with a path between the
> commits -- think for example of both commits being a cherry-pick of
> the same thing)
>     * patch-hunk-ids matching (instead of git-patch-id which computes
> a patch-id for the overall patch, compute one for each hunk.  Then
> look for other commits that have one of their patch hunks match. This
> could result in a many-to-many relationship between downstream and
> upstream patches)
> 
> We generated a report based on this (on a wiki so folks could edit and
> add notes), with html links and such.  For each downstream commit, we
> added links to all potential upstream commit(s) and included reasons
> why each commit was thought to be a potential match.  Further, for any
> potential upstream commit that might match (and which wasn't a 100%
> certainty pick from "git cherry"), we also looked at which filename(s)
> were modified in both commits and reported on the number of matching
> and non-matching filename(s) between the pair in addition to the
> number of matching and non-matching patch hunks.
> 
> Basically, it was a large amount of information to allow humans to
> review how similar the commits were to help them determine if the
> changes from the commit were already (partially or fully) included
> upstream.
> 
> I got lots of requests to find as many links as possible, because with
> unfortunately frequent regularity, a new report would be created for
> some branch and dozens of teams of developers were being forced to
> review the reports and sign off on every single patch and whether it
> needed to be upstreamed, or even finish being upstreamed (and to do
> the upstreaming work if so).  I got a fair number of comments and
> questions on the reports as a result.
> 
> I'm glad we no longer need this report due to switching to a much more
> sane testing/backporting/delivery/branching/etc. story, but years ago
> this report was helpful.  Anyway...
> 
> A few surprises I found:
>   * Patches could be partially upstreamed.  For example, someone
> cherry-picked something from a newer version of upstream than their
> current branch was based off of, then found and amended important
> fixes into that commit.  So although the patch might appear to be
> upstream (because the commit messages matched, the author
> name/email/dates match, etc.), important fixes in it were not.
>   * I was surprised by the number of cases that were not one-to-one
> mappings.  One patch might be upstreamed via several patches on the
> main branch.  Or parts of several patches may have been upstreamed as
> one big combination commit upstream.  I knew theoretically there could
> be some like this, and perhaps wasn't too surprised that there would
> be at least one, but there were quite a few more than I expected.
>   * One of the weirder cases I remember: Someone had created changes
> by going into the Gerrit UI, picking an existing but obsolete/closed
> code review, editing the code in ways that had absolutely nothing to
> do with the original commit they started on (and perhaps on some other
> branch?), and left the Change-Id around because it looked valid and
> they didn't know what it meant anyway.  (Something about their laptop
> being broken and being unable to edit code locally, so they just
> edited "in the cloud" and let the automated regression tests verify
> their changes; Gerrit either didn't have a way to start a new commit
> at the time or the developer didn't find it, so they just edited
> something else.)  I knew about it because I found weird pairs of
> non-matching things and this developer left a note about it in their
> edited commit message just in case anything weird happened.
> 
> But let me be more explicit about Change-Ids: we didn't use them at
> all.  It came up multiple times as a question, but in my looking into
> useful factors, to me they seemed to provide no extra value and I had
> found multiple cases where they seemed to be misleading.  The purpose
> of the report was to avoid more disasters from forgetting to backport
> commits.  This report seems like the kind of thing that Change-Ids
> were invented for, and we already had Change-Ids in all commits due to
> using Gerrit, but from my exploration I didn't trust the Change-Ids to
> provide net-positive value, so I simply didn't use them at all.
> 
> </long story>

if you are into long stories I have enother one.

<long story>
I am maintaining a code review system that I inherited that comes from
time when code review systems weren't cool, or even a thing at all. It's
basically a bunch of perls scripts that run as git hooks, cron jobs, and
CGI pages.

It is used to maintain some backports and original development on top of
upstream kernel releases.

The design is in some ways interesting. One particular interesting
decision which was made some time in ancient past is that the changes
are maintained as quilt patch series rather than modified sources.

Not sure what was the rationale behind the decision. Surely you could
save a lot of space if you had few changes. Also pre-git you would get
the release tarball, the point release patches, and any local changes as
patches on top so it makes sense to track the files you have together
with the series file that says how to use them, and you cannot get
easily away from tracking patches because that's what you get from
upstream.

This leads to an interesting pattern - you are not tracking changes to
source code but changes to history of changes to source code. At any
time you can render the quilt series as a git history that starts with
the upstream release and adds commits on top, in order specified in the
series file. You can add and drop commits in the middle, update tags,
whatever. And it can all be nice linear development in the repository
that tracks the quilt series.

Initially you would get a lot of big patches similar to the upstream
point releasee patches - like a patch that diffs the changes in a
particular driver between two kernel versions, with some additional
fixes on top. Clearly an unamanageable, untrackable, many-to-many patch
relationship to the upstream development.

However, over time this became a problem with more and more patches
piling up, base kernel version updates causing regressions, etc, etc

So over time some rules emerged. When backporting something from
upstream add each upstream git commit as separate patch file. Tag it
with the upstream git commit ID (change ID, yay). Add additional fixes
as separate patch files, and send them upstream. etc, etc.

In the end 1:1 relationship emerged with some rare exceptions.

Sure, there are upstream subsystems that routinely cherry-pick patches

Sure, there are upstream merge commits that introduce random unrelated
changes.

Nonetheless, the saner the upstream subsystem maintenanace and the the
saner the downstream branch maintenance the closer you get to 1:1 patch
relationship.
</long story>

If I can derive anything from these stories it is that while arbitrary
many to many relationsips between patches are possible they are not at
all desirable. Then it is not a bug for change tracking to not support
such relationship, you can even see it as a safety against people
shooting themselves in the foot.

If you are developing a feature over many revisions before it gets
merged upstream it can happen that you squash some patches that were
initially separate, and later split them differently. However, it does
not happen as one operation. So the many to many problem is not
something worth solving, at least for sane workflows.

Thanks

Michal
