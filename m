From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Fri, 18 May 2007 08:30:15 +0200
Message-ID: <20070518063015.GA13516@diana.vm.bytemark.co.uk>
References: <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515182549.GB17851@diana.vm.bytemark.co.uk> <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com> <20070516071130.GB7453@diana.vm.bytemark.co.uk> <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com> <20070516194002.GA17805@diana.vm.bytemark.co.uk> <20070516204029.GB17805@diana.vm.bytemark.co.uk> <b0943d9e0705170543g4d8c7542p6b44a4e6fa54676a@mail.gmail.com> <20070517145724.GA905@diana.vm.bytemark.co.uk> <b0943d9e0705171351j1a86a4f4ge0283c522a351645@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 08:30:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hovyy-0007ke-O4
	for gcvg-git@gmane.org; Fri, 18 May 2007 08:30:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754466AbXERGaU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Fri, 18 May 2007 02:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbXERGaU
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 02:30:20 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2913 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754466AbXERGaS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 02:30:18 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1Hovyh-0003dM-00; Fri, 18 May 2007 07:30:15 +0100
Content-Disposition: inline
In-Reply-To: <b0943d9e0705171351j1a86a4f4ge0283c522a351645@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47573>

On 2007-05-17 21:51:19 +0100, Catalin Marinas wrote:

> On 17/05/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> > The only possibility I can think of that might explain this is
> > that some of your unapplied patches are attached to a place in the
> > commit DAG that's far away from the branch head (e.g. you have
> > rebased to some entirely different place since you last had them
> > applied), so that "git-rev-list patch ^branch" outputs a large
> > part of the commit DAG.
>
> That's probably the case. I have patches that I haven't rebased for
> months but I keep them in case they might be needed in the future.

That's probably it, then. I'll need to come up with a clever scheme to
make that case cheap again.

> That's the reason for the hide/unhide commands.

Ah.

> Anyway, I'm not yet prepared to give up my current workflow.

I didn't intend to make that workflow painful, so don't despair yet --
there might be a way to make it work.

> I haven't tried to understand your patch yet but the unapplied
> patches will never be in a linear DAG similar to the applied
> patches.

I know.

> Because of this, we need to keep their order in a file anyway and we
> might not need to run git-rev-list (BTW, how do you preserve the
> unapplied patches order with the DAG implementation?).

The order of _all_ patches is kept in the "patchorder" file. This file
is consulted only when the relative order of two unapplied patches
need to be established. (Applied patches are sorted by the DAG, and
applied patches always precede unapplied patches.)

I would like to avoid keeping a record of known-to-be-unapplied
patches; while this is nowhere near as important as not keeping a
record of applied patches, it would still provide an opening for the
user to confuse StGIT.

But I believe I have a cunning plan ...

> > Could you put counters in unapplied_patches() and
> > sort_applied_patches() to see how many lines each of them reads
> > from git-rev-list? The expected number (if it had taken just a
> > little time, like it did for me) is a small constant times the
> > number of patches in both cases.
>
> I'll do this tomorrow to confirm but that's probably the cause of
> the slow-down.

Thanks for hanging in there.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
