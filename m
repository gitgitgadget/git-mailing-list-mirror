From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [StGIT PATCH] Don't use patches/<branch>/current
Date: Wed, 16 May 2007 22:40:29 +0200
Message-ID: <20070516204029.GB17805@diana.vm.bytemark.co.uk>
References: <20070506150852.8985.98091.stgit@yoghurt> <b0943d9e0705150856n771cb696h6e8225a0bbd5d43d@mail.gmail.com> <20070515182549.GB17851@diana.vm.bytemark.co.uk> <b0943d9e0705151301r7412109qd73a6008b888f8bc@mail.gmail.com> <20070516071130.GB7453@diana.vm.bytemark.co.uk> <b0943d9e0705160507h2b3c4a34xe9895d007c41d91a@mail.gmail.com> <20070516194002.GA17805@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 16 22:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HoQIX-0005Yl-9h
	for gcvg-git@gmane.org; Wed, 16 May 2007 22:40:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759945AbXEPUkd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 16 May 2007 16:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760035AbXEPUkd
	(ORCPT <rfc822;git-outgoing>); Wed, 16 May 2007 16:40:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4311 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759945AbXEPUkc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 May 2007 16:40:32 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HoQIP-0005NV-00; Wed, 16 May 2007 21:40:29 +0100
Content-Disposition: inline
In-Reply-To: <20070516194002.GA17805@diana.vm.bytemark.co.uk>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47455>

On 2007-05-16 21:40:02 +0200, Karl Hasselstr=F6m wrote:

> On 2007-05-16 13:07:14 +0100, Catalin Marinas wrote:
>
> > I did a quick test of 'stg series' with the DAG patches applied,
> > on a Linux kernel repository ('du -sh .git' is 285M) with 42
> > patches (only 25 applied). It constantly takes over 2 seconds to
> > complete (compared to < 200ms without the DAG patches). The
> > problem is that this delay will happen for bash completion as
> > well.
>
> This is more than ten times as expensive as in my measurement.
> Curious. And the algorithm is designed so that it shouldn't take
> time proportional to the repository size, just proportional to the
> number of patches.

I set up a kernel repository with 100 applied and 100 unapplied
patches:

  $ git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/li=
nux-2.6.git
  $ cd linux-2.6/
  $ stg init
  $ for ((i=3D0;i<200;i++)); do stg new p$(printf '%03d' $i) -m "Patch =
$i"; done
  $ stg goto p099

Then repeatedly:

  $ time stg series >/dev/null

This gives times such as

  real    0m0.247s
  user    0m0.156s
  sys     0m0.060s

  real    0m0.147s
  user    0m0.088s
  sys     0m0.036s

  real    0m0.153s
  user    0m0.088s
  sys     0m0.032s

  real    0m0.144s
  user    0m0.104s
  sys     0m0.024s

Tab completion also feels like it takes 0.1-0.2 seconds -- which it
should, since it's implemented with series, applied, and unapplied,
allow which do the same amount of work.

But my kernel repository is _much_ smaller than yours:

  $ du -sh .git
  183M    .git

Do you perchance have a bunch of loose objects in there?

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
