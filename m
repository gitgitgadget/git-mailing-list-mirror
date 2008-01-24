From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [STGIT PATCH] replace "git repo-config" usage by "git config"
Date: Thu, 24 Jan 2008 08:01:25 +0100
Message-ID: <20080124070125.GA19653@diana.vm.bytemark.co.uk>
References: <1200453554-14163-1-git-send-email-dpmcgee@gmail.com> <200801162147.33448.kumbayo84@arcor.de> <200801162158.26450.kumbayo84@arcor.de> <20080117074559.GB25213@diana.vm.bytemark.co.uk> <20080118042447.GA13178@diana.vm.bytemark.co.uk> <b0943d9e0801230335m4a2d1855uf465d0d134f3ef39@mail.gmail.com> <20080123161014.GA5850@diana.vm.bytemark.co.uk> <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Peter Oberndorfer <kumbayo84@arcor.de>, git@vger.kernel.org,
	Pavel Roskin <proski@gnu.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 24 08:02:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHw6f-0006iC-Hy
	for gcvg-git-2@gmane.org; Thu, 24 Jan 2008 08:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbYAXHCF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 24 Jan 2008 02:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752114AbYAXHCE
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Jan 2008 02:02:04 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4506 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752079AbYAXHCC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2008 02:02:02 -0500
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1JHw5V-00059m-00; Thu, 24 Jan 2008 07:01:25 +0000
Content-Disposition: inline
In-Reply-To: <b0943d9e0801230842w250ab963t16a1ab3c8024487e@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71594>

On 2008-01-23 16:42:41 +0000, Catalin Marinas wrote:

> On 23/01/2008, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > On 2008-01-23 11:35:03 +0000, Catalin Marinas wrote:
> >
> > > The 'goto' checks the local status before pushing
> >
> > No, it doesn't anymore
>
> Ah, OK. BTW, even if the tree was clean, a 'goto' failed on my Linux
> tree earlier today with the following message:
>
> $ stg goto realview-eb-header
> Popped realview-pb1176 -- realview-ioaddress
> fatal: Entry 'arch/arm/mach-realview/realview_pb11mp.c' not uptodate.
> Cannot merge.
> stg goto: Command aborted (all changes rolled back)
>
> It worked fine after running 'stg status' once (and not showing any
> changes). In the old GIT interface, we use to call refresh_index (i.e=
=2E
> 'git update-index -q --unmerged --refresh'). Does this still happen?

Ah, no, I guess it doesn't. And I guess it should. We should probably
have a test for that ...

> The message above also shows what I meant with messages not being
> very clear. It reports "Popped" but actually failed. Showing
> "Popping ... done" would be better.

Not necessarily. Even with the latter message style, you'd sometimes
get sequences like this:

  Popping p3 -- p1 ... done
  Pushing p4 ... done
  Pushing p5 ... done
  fatal: Entry 'some/annoying/file' not uptodate.
  Cannot merge.
  stg cool-command: Command aborted (all changes rolled back)

That is, the sequence of pushes and pops succeeded, but the changes
were still rolled back due to a dirty worktree.

Now, this doesn't mean I don't agree with you about the "done"
messages -- they serve as a kind of progress bar -- but just because
it says "done" doesn't mean the change will still be in effect when
the command returns.

And there should probably be an explicit "Checking out files ... done"
stage when we run git-read-tree, since that tends to take relatively
much time.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
