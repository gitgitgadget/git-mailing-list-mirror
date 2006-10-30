X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Mon, 30 Oct 2006 22:46:30 +0100
Message-ID: <20061030214630.GA14916@artax.karlin.mff.cuni.cz>
References: <20061022185350.GW75501@over-yonder.net> <Pine.LNX.4.64.0610231018410.3962@g5.osdl.org> <20061023222131.GB17019@over-yonder.net> <Pine.LNX.4.64.0610231534010.3962@g5.osdl.org> <20061024002622.GC17019@over-yonder.net> <Pine.LNX.4.63.0610240853160.10841@qynat.qvtvafvgr.pbz> <20061024163458.GH17019@over-yonder.net> <Pine.LNX.4.63.0610241038060.10841@qynat.qvtvafvgr.pbz> <20061025002713.GN17019@over-yonder.net> <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 21:50:46 +0000 (UTC)
Cc: "Matthew D. Fuller" <fullermd@over-yonder.net>,
	Linus Torvalds <torvalds@osdl.org>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0610251459160.1754@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30529>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Geexq-0007b9-Gj for gcvg-git@gmane.org; Mon, 30 Oct
 2006 22:46:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161395AbWJ3Vqc (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 16:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161413AbWJ3Vqc
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 16:46:32 -0500
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:11927 "EHLO
 artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP id S1161395AbWJ3Vqc
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 16:46:32 -0500
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196) id
 DEB0E4E4B; Mon, 30 Oct 2006 22:46:30 +0100 (CET)
To: David Lang <dlang@digitalinsight.com>
Sender: git-owner@vger.kernel.org

On Wed, Oct 25, 2006 at 03:40:00PM -0700, David Lang wrote:
> On Tue, 24 Oct 2006, Matthew D. Fuller wrote:
> >On Tue, Oct 24, 2006 at 11:03:20AM -0700 I heard the voice of
> >David Lang, and lo! it spake thus:
> >>
> >>it sounded like you were saying that the way to get the slices of
> >>the DAG was to use branches in bzr. [...]
> >
> >I'm not entirely sure I understand what you mean here, but I think
> >you're saying "Nobody's written the code in bzr to show arbitrary
> >slices of the DAG", which is true TTBOMK.
> 
> I think we are talking past each other here.
> 
> what I think was said was
> 
> G 'one feature of git is that you can view arbatrary slices trivially'
> 
> B 'bzr can do this too, you just use branches to define the slices'
> 
> G 'but this limits you becouse branches are defined as code is developed, 
> git lets you define slices at viewing time'
> 
> by the way, I think it's more then just saying 'well, the code could be 
> written to do this in $VCS' some decisions and standard ways of doing 
> things can impact how hard it is to implement a feature, and some decisions 
> can make it impossible (without doing unexpected things).

Since bzr branch is, and is ONLY, a pointer to a revision, I don't see
any design decision that would make this harder in bzr. The UI was only
implemented to take the revisions as branches.

> >>everyone agrees that bzr supports the Star topology. Most people
> >>(including bzr people) seem to agree that currently bzr does not
> >>support the Distributed topology.
> >
> >I think this statement arouses so much grumbling because (a) bzr does
> >support such a lot better than often seems implied, (b) where it
> >doesn't, the changes needed to do so are relatively minor (often
> >merely cosmetic), and (c) disagreement over whether some of the
> >qualifications included for 'distributed' are really fundamental.

The more I read this thread I actually think bzr does support
distributed topology as well as git.

The whole difference is that bzr makes a distinction between the first
and other parents of a revision, while git does not. This distinction is
done in two places:

1. The log shows the first parent and than, as indented subsection the
   ancestry of other parents until the point where the ancestries meet
   again. This actually captures a pattern people usually use. When you
   merge, you usually put in the log something along the lines:

   "merged X, which bars and fixes foo."

   when you actually merge M, which you consider a "mainline" and
   therefore not worth mentioning and X. Linus does it this way too --
   he actually posted a log message as an example, that showed exactly
   this.

2. Assigns revision aliases in this same order (except the "major"
   number for the subsection is based on the common ancestor, not on the
   merge point). They are not special thing that is generated at commit
   time; they are infered from the shape of the DAG (and cached for
   performance reasons).

And the only issue I think is, that the bzr UI and documentation pushes
forward these aliases (revnos) more than appropriate for fully
distributed case and hides the real revision names (revids) too much for
that case.

> >>it's just fine for bzr to not support all possible topologies,
> >
> >I think there's a real intent for bzr TO support at least all common
> >topologies.  I'll buy that current development has focused more on
> >[relatively] simple topologies than the more wildly complex ones.  I
> >look forward to more addressing of the less common cases as the tool
> >matures, and I think a lot of this thread will be good material to
> >work with as that happens.  It's just the suggestion that providing
> >fruit for simple topologies _necessarily_ prejudices against complex
> >ones that I find so onerous.
> 
> one concern that the git people are voicing is that the things that work 
> for simple topologies (revno's) can't be used with the more complex ones 
> (where you need the refid's). especially the fact that users need to do 
> things significantly different when there are fairly subtle changes to the 
> topology.
> 
> the scenerio that came up elsewhere today where you have
> 
>    Master
>    /    \
> dev1   dev2
> 
> and then dev1 and dev2 both start working on the same thing (without 
> knowing it), then discover they are working on the same thing. they now 
> have threeB options
> 
> 1. merge their stuff up to the master so that they can both pull it down.
>   but this puts broken, experimental stuff up in the master
> 
> 2. declare one of the dev trees to be the master
> 
> this changes the topology to
> 
> Master--dev1--dev2
> 
> 3. pull from each other frequently to keep in sync.
> 
> this changes the topology to
> 
>    Master
>    /   \
> dev1--dev2
> 
> if they do this with bzr then the revno's break, they each get extra 
> commits showing up (so they can never show the same history).

That's a deficiency of merge not telling that a merge is pointless.
Actually I think than bzr merge *should* reduce to pull in all cases:

- If the common ancestor is on the leftmost path of the other branch,
  than the existing revnos as seen on this branch will not change in any
  case, only more than one is added. I think it's safe for merge to
  reduce to pull in this case and consider it a bug in bzr that it does
  not.
- If the common ancestor is not on the leftmost path on the other
  branch, than it is because the branch was merged with some other
  deemed "more important" (ie. the "Master" above). In this case
  reducing to pull will change the old revids, but IMO it's correct
  thing to do, because it's now up-to-date with latest revision of
  "Master" and it's revnos should take precedence. Personally I'd just
  like merge to reduce to pull in this case as well, but maybe it'd be
  better to have it error out and request user to either "pull" or
  "merge --pointless".

> in git this is a non-issue, they can pull back and forth and the only new 
> history to show up will be changes.
> 
> this is the situation that the kernel developers are in frequently. it 
> sounds as if you haven't needed to do this yet, so you haven't encountered 
> the problems.

Given that bzr is considerably smaller project than the Linux kernel,
that's quite likely. And it's likely a reason why it was not thoroughly
discussed in bzr yet (or at least I don't know about that it was).

--------------------------------------------------------------------------------
