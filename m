From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] Let deny.currentBranch=updateInstead ignore
 submodules
Date: Thu, 13 Nov 2014 19:55:49 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1411131850510.13845@s15462909.onlinehome-server.info>
References: <cover.1415368490.git.johannes.schindelin@gmx.de> <84dba8872922da96e99953eea0ccff5f5af9dd4a.1415368490.git.johannes.schindelin@gmx.de> <xmqqh9yag6mt.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411101400050.13845@s15462909.onlinehome-server.info>
 <xmqq1tpbawqe.fsf@gitster.dls.corp.google.com> <xmqq389qam25.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411121208250.13845@s15462909.onlinehome-server.info> <xmqqzjbw47vr.fsf@gitster.dls.corp.google.com> <alpine.DEB.1.00.1411131123330.13845@s15462909.onlinehome-server.info>
 <alpine.DEB.1.00.1411131136200.13845@s15462909.onlinehome-server.info> <xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1784107012-1121309502-1415904950=:13845"
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 13 19:56:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XozYl-0005TN-Gh
	for gcvg-git-2@plane.gmane.org; Thu, 13 Nov 2014 19:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933526AbaKMSzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 13:55:55 -0500
Received: from mout.gmx.net ([212.227.17.21]:62377 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932791AbaKMSzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 13:55:54 -0500
Received: from s15462909.onlinehome-server.info ([87.106.4.80]) by
 mail.gmx.com (mrgmx102) with ESMTPSA (Nemesis) id 0MfjJY-1XabQo3j2y-00NDEi;
 Thu, 13 Nov 2014 19:55:50 +0100
X-X-Sender: schindelin@s15462909.onlinehome-server.info
In-Reply-To: <xmqqh9y32e36.fsf@gitster.dls.corp.google.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Provags-ID: V03:K0:XaNICFnXnwK8A6fqjtfxmPO/oEm69XTaKcd0O2UfEl/w5KHkX0T
 PBrSQABsTDjF6Rk+TeFdlWmmuLCzBV4CfrT+ibh+V2NbtEoSa0JfLbQ4Kmmm/L+al0+nzuz
 UPG/RLUDT6jZr5JY+jLdl3pCUDG2dUlO8pQVrr3aUvs89iASvpW7iLWjHqaQWiu3pa2Njym
 rLoGc5fXHnDrfS4lLzCJQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1784107012-1121309502-1415904950=:13845
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Junio,

On Thu, 13 Nov 2014, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>=20
> > On Thu, 13 Nov 2014, Johannes Schindelin wrote:
> >
> >> Due to that experience, the documentation also states pretty clearly t=
hat
> >> `updateInstead` succeeds only in updating the current branch if the
> >> working directory is clean.
> >
> > To clarify why `updateInstead` is stricter than the `merge` scenario: w=
hen
> > pushing into a remote repository with attached working directory, we
> > cannot simply clean up merge conflicts or other problems introduced by =
a
> > merge. Indeed, it is even possible to push without having any option to
> > fix files in the working directory afterwards. Therefore, the
> > `updateInstead` feature really needs to be adamant about the working
> > directory being clean.
>=20
> As the stricter check (which I think is unnecessarily strict and
> which you don't) can be loosened later without making something the
> user used to be able to do in an early version unable to do later,
> I am OK to accept the design as-is.

Thanks for mentioning this. I would like to ask not to loosen this later.
Let me try to explain in more detail than before why I think it would make
*my* life hard if it ever were loosened.

Let's start with a hypothetical change to notes.c, a change, say, that
uses part of the diff machinery. So I am doing that in my working
directory, happily testing stuff, but not quite happy with the result just
yet, staging a couple of things after a debug run so I can "git stash -k"
away the debugging statements.

Please note that while the scenario I just illustrated is purely
hypothetical, made up from thin air, the workflow and the technique is
very much my daily bread, though. I do use "git stash -k" quite frequently
to stash away stuff that I do not want, after staging what I want to keep
first.

Now let's continue by saying that I get interrupted with that notes.c work
and only come back to it much, much later, say, a couple of months,
because I have been working on a different computer in the meantime,
say, fixing Git for Windows bugs like mad.

Okay, so now I am back and I "git pull" your 'master'. Now, for the sake
of the argument, let's say that the pull does not introduce any changes to
notes.c, but instead that there has been an improvement in the diff
machinery, one that required a change of the diff machinery's API and all
of a sudden, my code does not compile anymore. It merged cleanly,
Git is completely groovy, but the code just does not compile any more. Not
a big deal: I can inspect the changes via "git diff
junio/master@{1}..junio/master" and find out very easily what went wrong
and fix my code, compile, stage, and maybe even commit because the code
now works.

Splendid.

But it would be different if the working directory was on another computer
than the one I am operating from. I could not easily access the working
directory, let alone the Git history, if all I did was a "git push".

Now let's modify the scenario a little bit further, still. Let's not talk
about git.git, but about a project implementing a web application. And
let's say that I did not dabble with notes.c but I had to work on the
production setup for a really, really urgent hotfix where the speed of a
fix was more important than not touching the production setup at all.

Please note that this is *not* a hypothetical scenario, but a true account
of what I had to go through a couple of times (don't try this at home, it
causes a lot of gray hair).

Now let's assume that I forgot to commit and push, and that nobody noticed
=E2=80=93 and let's just draw the curtain of charity over the reasons why. =
Also,
let's assume that a couple of months later, I am asked to implement a new
feature for the very same web application, this time without frantic "You.
Have. To. Fix. This. ASAP!" stuff going on. So I develop this on a test
machine, test thoroughly, everything's groovy, and then I push, using the
'updateInstead' feature introduced by the patch in question (and which was
applied to that machine's Git at that time, before some joker updated it
with the official Git).

And now when I try to push, Git complains that the working directory is
not clean, which is *just* fine by me, because after further inspection it
turns out that the uncommitted changes =E2=80=93 which are in a different f=
ile
than the changes introducing my new feature =E2=80=93 would have borked the
production system rather thoroughly.

Please note again that I am talking about something that really happened.

So I would really like to have 'updateInstead', but only in the safe
version, i.e. refusing to update anything but a clean working directory,
and it would be a major regression for me, affecting my workflow rather
negatively, if those strict checks were loosened.

In my mind, when (and if!) a less strict version is desired, it should be
added as another denyCurrentBranch value and 'updateInstead' should be
unaffected, otherwise, speaking for me personally, all my work in this
patch series would be for naught.

Ciao,
Johannes
--1784107012-1121309502-1415904950=:13845--
