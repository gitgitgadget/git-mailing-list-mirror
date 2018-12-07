Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3330E20A1E
	for <e@80x24.org>; Fri,  7 Dec 2018 01:23:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeLGBXE (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Dec 2018 20:23:04 -0500
Received: from washoe.dartmouth.edu ([129.170.30.229]:58750 "EHLO
        smtp.onerussian.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbeLGBXD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Dec 2018 20:23:03 -0500
Received: from c-76-24-253-1.hsd1.nh.comcast.net ([76.24.253.1] helo=localhost)
        by smtp.onerussian.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <yoh@onerussian.com>)
        id 1gV4r8-00057C-0s
        for git@vger.kernel.org; Thu, 06 Dec 2018 20:23:02 -0500
Date:   Thu, 6 Dec 2018 20:22:56 -0500
From:   Yaroslav Halchenko <yoh@onerussian.com>
To:     git <git@vger.kernel.org>
Message-ID: <20181207012256.GR4633@hopa.kiewit.dartmouth.edu>
References: <20181206173554.GH4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kY8uv8zDm3f8Jb6aC-nit7OZduixyOekGYWa_xnqFqw-w@mail.gmail.com>
 <20181206212459.GN4633@hopa.kiewit.dartmouth.edu>
 <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYoGqWW4tv4-caA18SHKe+y2mnDT84AEWVksDtDObLq0g@mail.gmail.com>
X-URL:  http://www.onerussian.com
X-Image-Url: http://www.onerussian.com/img/yoh.png
X-PGP-Key: http://www.onerussian.com/gpg-yoh.asc
X-fingerprint: C5B9 05F0 E8D9 FD96 68FF  366F A2DE 2350 62DA 33FA
User-Agent: Mutt/1.9.4 (2018-02-28)
X-SA-Exim-Connect-IP: 76.24.253.1
X-SA-Exim-Rcpt-To: git@vger.kernel.org
X-SA-Exim-Mail-From: yoh@onerussian.com
Subject: Re: [wishlist] git submodule update --reset-hard
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:57:07 +0000)
X-SA-Exim-Scanned: Yes (on smtp.onerussian.com)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

Thanks for the dialogue!  Replies are embedded below.

On Thu, 06 Dec 2018, Stefan Beller wrote:
> ...
> > > What if the branch differs from the sha1 recorded in the superproject?

> > git reset --hard  itself is an operation which should be done with some
> > level of competence in doing "the right thing" by calling it.  You
> > can hop branches even in current (without any submodules in question)
> > repository with it and cause as much chaos as you desire.

> Right.

> git reset --hard would the branch (as well as the working tree) to the
> given sha1, which is confusing as submodules get involved.

> The Right Thing as of now is the sha1 as found in the
> superprojects gitlink. But as that can be different from any branch
> in the submodule, we'd rather detach the HEAD to make it
> deterministic.

yeap, makes total sense to be the thing do that by default ;-)

> There was a proposal to "re-attach HEAD" in the submodule, i.e.
> if the branch branch points at the same commit, we don't need
> a detached HEAD, but could go with the branch instead.

if I got the idea right, if we are talking about any branch, it
would also non-deterministic since who knows what left over branch(es)
point to that commit.  Not sure if I would have used that ;)

> > If desired though, a number of prevention mechanisms could be in place (but
> > would require option(s) to overcome) to allow submodule to be reset --hard'ed
> > only when some conditions met (e.g. only to the commit which is among parent
> > commits path of the current branch).  This way wild hops would be prevented,
> > although you might still end up in some feature branch.  But since "reset
> > --hard" itself doesn't have any safe-guards, I do not really think they should
> > be implemented here either.

> So are you looking for
> a) "stay on submodule branch (i.e. HEAD still points at $branch), and
> reset --hard" such that the submodule has a clean index and at that $branch 
> or
> b) "stay on submodule branch (i.e. HEAD still points at $branch), but $branch is
>    set to the gitlink from the superproject, and then a reset --hard
>    will have the worktree set to it as well.

yes!

NB "gitlink" -- just now discovered the thing for me.  Thought it would be
called a  subproject  echoing what git diff/log -p shows for submodule commits.

> (a) is what the referenced submodule.repoLike option implements.

sounds like it indeed, thanks for spelling out

> I'd understand the desire for (b) as well, as it is a "real" hard reset on
> the superproject level, without detaching branches.

yeap

> > >   git reset --hard --recurse-submodules HEAD

> > it does indeed some trick(s) but not all seems to be the ones I desire:

> > 1. Seems to migrate submodule's .git directories into the top level
> > .git/modules

> Ah yes, that happens too. This will help once you want to git-rm
> a submodule and checkout states before and after.

yeap ;-) 

> > > undesirable in the sense of still having local changes (that is what
> > > the above reset with `--recurse` would fix) or changed the branch
> > > state? (i.e. is detached but was on a branch before?)

> > right -- I meant the local changes and indeed reset --recurse-submodules
> > indeed seems to recurse nicely.  Then the undesired effect remaining only
> > the detached HEAD

> For that we may want to revive discussions in
> https://public-inbox.org/git/20170501180058.8063-5-sbeller@google.com/

well, isn't that one requires a branch to be specified in .gitmodules?

> > > >   git submodule update --recursive

> > > > I would end up in the detached HEADs within submodules.

> > > > What I want is to retain current branch they are at (or may be possible
> > > > "were in"? reflog records might have that information)

> > > So something like

> > >   git submodule foreach --recursive git reset --hard

> > > ?

> > not quite  -- this would just kill all local changes within each submodule, not
> > to reset it to the desired state, which wouldn't be specified in such
> > invocation, and is only known to the repo containing it

> With this answer it sounds like you'd want (b) from above.

yeap

> > > You may be interested in
> > > https://public-inbox.org/git/20180927221603.148025-1-sbeller@google.com/
> > > which introduces a switch `submodule.repoLike [ = true]`, which
> > > when set would not detach HEAD in submodules.

> > Thanks! looks interesting -- was there more discussion/activity beyond those 5
> > posts in the thread?

> Unfortunately there was not.

pity

> > This feature might indeed come handy but if I got it right, it is somewhat
> > complimentary to just having submodule update --reset-hard .  E.g.  submodules
> > might be in different branches (if I am not tracking based on branch names), so
> > I would not want a recursive checkout with -b|-B.  But we would indeed benefit
> > from such functionality, since this difficulty of managing branches of
> > submodules I think would be elevated with it! (e.g. in one use case we probably
> > will end up with a few thousands of submodules, and at least 3 branches in each
> > which would need to be in sync, and typically you wouldn't want different
> > branches to be checked out in different submodules)

> > > Can you say more about the first question above:
> > > Would you typically have situations where the
> > > submodule branch is out of sync with the superproject
> > > and how do you deal with that?

> > typically I do not have anything out of sync.  My primary use-case is to
> > "cancel" recent changes in the entire tree of repositories.  I guess for
> > my use case, instead of needing two commands

> >    git reset --hard PREVIOUSPOINT
> >    git submodule update --reset--hard --recursive

> > I wish there was just one

> >    git reset --hard --recursive PREVIOUSPOINT

> Maybe this could learn options like

>   git reset --hard --recursive=hard,keep-branch PREVIOUSPOINT

'keep-branch' (given aforementioned keeping the specified in .gitmodules
branch) might be confusing.  Also what if a submodule already in a
detached HEAD?  IMHO --recursive=hard, and just saying that it would do
"reset --hard", is imho sufficient.  (that is why I like pure
--reset hard   since it doesn't care and neither does anything to the
branch)

> which then could be put into options like

>   git config reset.recurseSubmodules  hard,keep-branch &&
>   # maybe not needed, depending on the exact meaning
>   # of reset.recurseSubmodules:
>   git config submodule.recurse

> and then

>   git reset --hard PREVIOUS

> would do what you'd desire.

you mean

   git reset --hard --recurse-submodules PREVIOUS

in principle overall I would love to have it, besides not sure what
other than 'hard' could be there, and what 'keep-branch' would exactly
do ;-)

> > but I felt that   submodule update   might be a better starting point
> > since it already  provides different modes for update.  If I was even greedier,
> > I would have asked for

> >    git revert --recursive <commit>...
> >    git rebase --recursive [-i] ...

> > which I also frequently desire (could elaborate on the use cases etc).

> These would be nice to have. It would be nice if you'd elaborate on the
> use cases for future reference in the mailing list archive. :-)

ok, will try to do so ;-) In summary: they are just a logical extension
of git support for submodules for anyone actively working with
submodules to keep entire tree in sync.  Then quite often the need for
reverting a specific commit (which also has changes reflected in
submodules) arises.  The same with rebase, especially to trim away some
no longer desired changes reflected in submodules.  

the initial "git submodule update --reset-hard" is pretty much a
crude workaround for some of those cases, so I would just go earlier in
the history, and redo some things, whenever I could just drop or revert
some selected set of commits.

> > NB or --recurse-submodules to avoid confusion with recursive merge
> > strategy?

> ... and sometimes recursing in the file system, c.f. `ls-tree -r`.

ah... so it is only   submodule  command which has --recursive, and the
rest have --recurse-submodules   when talking about recursing into
submodules?

-- 
Yaroslav O. Halchenko
Center for Open Neuroscience     http://centerforopenneuroscience.org
Dartmouth College, 419 Moore Hall, Hinman Box 6207, Hanover, NH 03755
Phone: +1 (603) 646-9834                       Fax: +1 (603) 646-1419
WWW:   http://www.linkedin.com/in/yarik        
