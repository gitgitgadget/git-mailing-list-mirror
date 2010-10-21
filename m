From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: format-patch broken [Was: fetch and bundle don't work in
	(semi-)broken repo]
Date: Thu, 21 Oct 2010 09:11:06 +0200
Message-ID: <20101021071106.GG19834@pengutronix.de>
References: <20101019160957.GK11713@pengutronix.de> <20101019183925.GF25139@burratino> <20101019201139.GB28166@pengutronix.de> <alpine.LFD.2.00.1010191635030.2764@xanadu.home> <20101019210233.GA32029@burratino> <alpine.LFD.2.00.1010192154200.2764@xanadu.home> <20101020074122.GC28166@pengutronix.de> <alpine.LFD.2.00.1010200937200.2764@xanadu.home> <20101020150810.GE19834@pengutronix.de> <alpine.LFD.2.00.1010201301130.2764@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ZGiS0Q5IWpPtfppv"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Thu Oct 21 09:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8pIz-0007bN-BD
	for gcvg-git-2@lo.gmane.org; Thu, 21 Oct 2010 09:11:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757485Ab0JUHLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Oct 2010 03:11:09 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:40579 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753213Ab0JUHLH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Oct 2010 03:11:07 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8pIo-0007Pq-Ia; Thu, 21 Oct 2010 09:11:06 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8pIo-0005nP-5z; Thu, 21 Oct 2010 09:11:06 +0200
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010201301130.2764@xanadu.home>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159486>


--ZGiS0Q5IWpPtfppv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Oct 20, 2010 at 01:05:26PM -0400, Nicolas Pitre wrote:
> On Wed, 20 Oct 2010, Uwe Kleine-König wrote:
> 
> > On Wed, Oct 20, 2010 at 09:38:14AM -0400, Nicolas Pitre wrote:
> > > On Wed, 20 Oct 2010, Uwe Kleine-König wrote:
> > > 
> > > > If you want I can provide you the broken repo.
> > > 
> > > Yes, please.
> 
> I'm trying to reproduce the exact error you get. But I'm missing some 
> alternates for objects, and none of the trees I have locally provide the 
> needed objects.
> 
> [nico@xanadu linux-2.6]$ ! git format-patch linus/master..sectionmismatches
> 0001-wip-enable-DEBUG_SECTION_MISMATCH.patch
> 0002-ARM-sa1111-move-__sa1111_probe-to-.devinit.text.patch
> 0003-ARM-omap1-nokia770-mark-some-functions-__init.patch
> fatal: unable to read destination tree (16edb8381f2f2dabec9cc59f4a3d8c9ead899668)
> 
> What do you have in your alternate repo?
Hmm, I just unpacked the archive in a seperate directory, removed
.git/objects/info/alternates and then git format-patch
linus/master..sectionmismatches fails in a different way:

	fatal: Invalid revision range linus/master..sectionmismatches

I guess adding a pristine copy of Linus' tree should do the trick.

[ ... some time later ... creating a fresh clone takes quite some time ... ]

No, that's not enough, I will handpick some objects from the original.

Ah, you only need 16edb8381f2f2dabec9cc59f4a3d8c9ead899668 to make
format-patch work, but still 09b3f464a50111071f7740056b98fa8f36133347 is
missing for this tree.  This doesn't hurt format-patch as it's enough
for it to know that this entry didn't change.  So format-patch needs
less information than bundle/fetch and it's OK that the former succeeds
and the latter fails.

[...]

No, that's not the (only) problem,
40aaeb204dc04d3cf15c060133f65538b43b13b0 is needed, git format-patch is
just ignorant enough and invents something different:

	username@hostname:~/path/linux-2.6$ git rev-list linus/master..sectionmismatches
	eb84720860a90769473b42215a4cb67ee5efe7a7
	2e14a5c831032fa489384763087f4a03d88607cb
	00b18e8058e98927e2e4eae32deae7e58f47467c
	1ad328f663128b5c6e6b4af1ac2da1b443dba530
	2a0e4c23a34c78891db685b2b4851705fd36d656
	089d061c26b00a5b8dbb9e70b81d36a97e1daded
	b7ce4ec88f1bdfbe49fa7ef12df8f985d705605a
	b40acb01793933cd6baaaf826f3fef6dd734f72b
	780e3d47d067b54b17bcac3794d62825e8e60422
	ce06129cf7bbf85afe4fc127afc957d36ba4e9e4
	c2172d687578e7eb037a232802a4a8c6de1b0eea
	0c23684f39714a72f54036ca2be36e8894794b66
	cea2a0668ee1a9dc3617a810954a41c7701a08e9
	2bd6ff604ac3aa4c96636dda1ad80a289205ccba
	7591700d538d08f2e8327bb439b6cb0488e13f3e

	username@hostname:~/path/linux-2.6$ git diff-tree -r 7591700d538d08f2e8327bb439b6cb0488e13f3e
	7591700d538d08f2e8327bb439b6cb0488e13f3e
	:100644 100644 1b4afd2e6ca089de0babdacc5781426ef118da5c 40aaeb204dc04d3cf15c060133f65538b43b13b0 M	lib/Kconfig.debug

	commit 7591700d538d08f2e8327bb439b6cb0488e13f3e
	Author: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
	Date:   Wed Aug 4 08:52:56 2010 +0200

	    wip: enable DEBUG_SECTION_MISMATCH

	diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
	index 1b4afd2..40aaeb2 100644
	--- a/lib/Kconfig.debug
	+++ b/lib/Kconfig.debug
	@@ -1,1157 +0,0 @@
	-
	-config PRINTK_TIME
	-	bool "Show timing information on printks"
	-	depends on PRINTK
	-	help
	-	  Selecting this option causes timing information to be
	-	  included in printk output.  This allows you to measure
	-	  the interval between kernel operations, including bootup
	-	  operations.  This is useful for identifying long delays

So format-patch assumes that lib/Kconfig.debug became empty because of
not knowing what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is.

So it's not git-bundle/git-fetch that is broken, but format-patch.

I attached an archive with the two objects
16edb8381f2f2dabec9cc59f4a3d8c9ead899668 and
09b3f464a50111071f7740056b98fa8f36133347 and will try to recreate
40aaeb204dc04d3cf15c060133f65538b43b13b0 now.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |

--ZGiS0Q5IWpPtfppv
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="missing-objects.tar.bz2"
Content-Transfer-Encoding: base64

QlpoOTFBWSZTWRC1MbkABAZ/////////////////////////////////////////////4As/
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
ICFqY3I=

--ZGiS0Q5IWpPtfppv--
