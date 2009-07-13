From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [ANNOUNCE] Stacked Git 0.15-rc1
Date: Mon, 13 Jul 2009 10:28:59 +0200
Message-ID: <20090713082859.GA10549@pengutronix.de>
References: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	John Kacur <jkacur@gmail.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 13 10:29:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQGuL-0008In-3x
	for gcvg-git-2@gmane.org; Mon, 13 Jul 2009 10:29:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbZGMI3C convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 13 Jul 2009 04:29:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbZGMI3C
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jul 2009 04:29:02 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:45073 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbZGMI3A (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jul 2009 04:29:00 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.63)
	(envelope-from <ukl@pengutronix.de>)
	id 1MQGuB-0001Bh-RX; Mon, 13 Jul 2009 10:28:59 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1MQGuB-0004BP-JH; Mon, 13 Jul 2009 10:28:59 +0200
Content-Disposition: inline
In-Reply-To: <b0943d9e0907121540n4b9199e2re3152e71d84a0f5@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123176>

Hi Catalin,


On Sun, Jul 12, 2009 at 11:40:05PM +0100, Catalin Marinas wrote:
> The first release candidate for StGit 0.15 is available from the
> git://repo.or.cz/stgit.git or http://download.gna.org/stgit/. Bugs ca=
n
> be reported on the Git mailing list or via the project bugs page
> (https://gna.org/bugs/?group=3Dstgit).
Try this:

	git clone --depth=3D10 git://git.kernel.org/pub/scm/linux/kernel/git/s=
table/linux-2.6.29.y.git
	wget http://www.kernel.org/pub/linux/kernel/projects/rt/patch-2.6.29.6=
-rt23-broken-out.tar.bz2
	tar xjf patch-2.6.29.6-rt23-broken-out.tar.bz2
	cd linux-2.6.29.y
	git checkout -b 2.6.29-rt v2.6.29.6
	stg init
	stg import -s ../patches/series

(Nice, 0.14.2-1 from Debian failed here, because of a line break in a
=46rom: header.)

But still:

	stg goto include-linux-delay-h-in-hwlat_detector.patch
	git show --stat

yields:

	commit 12c06d44017a9c51746290779fc24fb8d69c68ef
	Author: Uwe Kleine-K=F6nig <=3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=
=3D>
	Date:   Mon Jul 13 10:01:19 2009 +0200

	    Subject: include linux/delay.h in hwlat_detector
		<u.kleine-koenig@pengutronix.de>
	    Date: Sun, 14 Jun 2009 23:31:42 +0200
	   =20
	    This broke when compiling on i386 without X86_LOCAL_APIC because t=
hen
	    arch/x86/include/asm/smp.h doesn't include asm/apic.h which in tur=
n includes
	    linux/delay.h.
	   =20
	    Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
	    Cc: Jon Masters <jcm@redhat.com>
	    LKML-Reference: <1245015102-22057-1-git-send-email-u.kleine-koenig=
@pengutron
	    Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
	    Cc: Thomas Gleixner <tglx@linutronix.de>
	    Cc: Jon Masters <jcm@redhat.com>

	 drivers/misc/hwlat_detector.c |    1 +
	 1 files changed, 1 insertions(+), 0 deletions(-)

There are some things to enhance:

  - s/Subject: //
  - use Date line as author date
  - stray email address
  - author ident is wrong/broken

If you look on arm-__builtin_return_address-works-with-argument-0.patch
there the author is broken in an other way:

	stg goto arm-__builtin_return_address-works-with-argument-0.patch
	git show | grep Author:

yields:

	Author: =3D?utf-8?q?Uwe=3D20Kleine-K=3DC3=3DB6nig?=3D <u.kleine-koenig=
@pengutronix.de>

Note that git quiltimport using git mailinfo gets all that right.
(e.g.

	git checkout -b 2.6.29-rt-quiltimport v2.6.29.6
	git quiltimport --author=3D"do <nt@kn.ow>" --patches=3D../patches/)
	git log --author=3DUwe
	git mailinfo msg patch < ../patches/include-linux-delay-h-in-hwlat_det=
ector.patch
	cat msg
)

Best regards
Uwe
