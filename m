From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGit PATCH] It doesn't make sense to sink below an unapplied patch
Date: Sun, 16 Sep 2007 01:22:52 +0200
Message-ID: <20070915232252.GA25507@diana.vm.bytemark.co.uk>
References: <20070914002031.GC23330@diana.vm.bytemark.co.uk> <20070914005231.17533.17120.stgit@yoghurt> <9e4733910709131822s3c519a3bj7e42c0ecaa89fb6e@mail.gmail.com> <20070914060456.GA27014@diana.vm.bytemark.co.uk> <9e4733910709140715g3cc3e47fu2eb24eed6d4e2c08@mail.gmail.com> <20070914150609.GA319@diana.vm.bytemark.co.uk> <9e4733910709140918wbe94b5eu6ec326b25b0f3d42@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 16 01:23:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWgzC-0004xW-Aa
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 01:23:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753047AbXIOXXJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Sep 2007 19:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753030AbXIOXXI
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Sep 2007 19:23:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1396 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752929AbXIOXXH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2007 19:23:07 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1IWgyS-0006fT-00; Sun, 16 Sep 2007 00:22:52 +0100
Content-Disposition: inline
In-Reply-To: <9e4733910709140918wbe94b5eu6ec326b25b0f3d42@mail.gmail.com>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58277>

On 2007-09-14 12:18:17 -0400, Jon Smirl wrote:

> On 9/14/07, Karl Hasselstr=F6m <kha@treskal.com> wrote:
>
> >   $ stg pop p2 p3
> >   $ stg push p3 p2
> >
> > Does this cover what you had in mind?
>
> Sure this works. I'm just wondering if it is a good idea to have
> separate reordering commands for patches that are applied vs
> unapplied. The separate commands confused me.
>
> Would it be better to simply prohibit reordering of apply patches
> and require that they be popped before they can be reordered? A
> sink/float that causes merge errors must be a mess to sort out.

It's not a mess, actually -- it's implemented in terms of push and pop
of single patches, so the theory is dead simple. (The push and pop
commands are also implemented in terms of push and pop of single
patches.)

> If you prohibit reordering of applied patches sink/float can be
> eliminated.

But they're useful! Though as I said earlier, they're implemented in
terms of push and pop, so they're technically redundant. But "sink p5
--to p2" would be "pop p3..p5 && push p5 p3 p4", which is more typing
(starting with applied patches p1, p2, p3, p4, p5).

> Another way to handle this would be to eliminate the ability of
> pop/push to reorder and extend sink/float to handle unapplied
> patches.

I think that I'd like the latter without the former -- that is,
teaching sink/float how to handle unapplied patches, and leaving
push/pop as is. That'll let you do what you tried to do in the first
place, and will leave us with a more redundant command set, but I
don't think that's bad.

Another idea that's been kicked around is to have a general reorder
command, that spawns an editor and lets you move around (and delete)
patch names until you're satisfied. (This too would be implemented in
terms of push and pop of single patches.)

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
