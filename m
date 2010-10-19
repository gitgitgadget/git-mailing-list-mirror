From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: fetch and bundle don't work in (semi-)broken repo
Date: Tue, 19 Oct 2010 18:09:57 +0200
Message-ID: <20101019160957.GK11713@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 19 18:10:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8ElN-0005Gj-9C
	for gcvg-git-2@lo.gmane.org; Tue, 19 Oct 2010 18:10:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078Ab0JSQJ7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 19 Oct 2010 12:09:59 -0400
Received: from metis.ext.pengutronix.de ([92.198.50.35]:47700 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753837Ab0JSQJ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Oct 2010 12:09:59 -0400
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.71)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8ElB-00036i-9G
	for git@vger.kernel.org; Tue, 19 Oct 2010 18:09:57 +0200
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1P8ElB-0002Ei-7l
	for git@vger.kernel.org; Tue, 19 Oct 2010 18:09:57 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159335>

Hi,

I have a repo that got broken somehow (don't know the exact details,
probably because it is shared with another repo and I rewrote history).
Now I want to fetch one branch to a different repo (that happens to be
the alternative to the first one, but I think this is unrelated.):

	ukl@hostname:~/path1/linux-2.6$ git fetch ~/path2/linux-2.6 sectionmis=
matches
	remote: Counting objects: 118, done.
	remote: error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b13b0
	remote: Compressing objects: 100% (83/83), done.
	remote: fatal: unable to read 40aaeb204dc04d3cf15c060133f65538b43b13b0
	error: git upload-pack: git-pack-objects died with error.
	fatal: git upload-pack: aborting due to possible repository corruption=
 on the remote side.
	remote: aborting due to possible repository corruption on the remote s=
ide.
	fatal: protocol error: bad pack header

I don't know what 40aaeb204dc04d3cf15c060133f65538b43b13b0 is, but I
think it's not necessary for the sectionmismatches branch:

	ukl@hostname:~/path2/linux-2.6$ git format-patch linus/master..section=
mismatches
	0001-wip-enable-DEBUG_SECTION_MISMATCH.patch
	0002-ARM-sa1111-move-__sa1111_probe-to-.devinit.text.patch
	0003-ARM-omap1-nokia770-mark-some-functions-__init.patch
	0004-ARM-omap-fb-move-omap_init_fb-to-.init.text.patch
	0005-ARM-omap-fb-move-omapfb_reserve_sram-to-.init.text.patch
	0006-ARM-omap-fb-move-get_fbmem_region-to-.init.text.patch
	0007-ARM-omap-move-omap_get_config-et-al.-to-.init.text.patch
	0008-wip-ARM-omap-move-omap_board_config_kernel-to-.init..patch
	0009-ARM-omap-ams-delta-move-config-to-.init.data.patch
	0010-MTD-pxa2xx-move-pxa2xx_flash_probe-to-.devinit.text.patch
	0011-VIDEO-sa1100fb-register-driver-using-platform_driver.patch
	0012-ARM-s3c64xx-don-t-put-smartq_bl_init-in-.init.text.patch
	0013-ARM-s3c64xx-don-t-put-smartq7_leds-in-.init.data.patch
	0014-ARM-s3c64xx-don-t-put-smartq5_leds-in-.init.data.patch
	0015-ARM-nomadik-move-nmk_gpio_probe-to-.devinit.text.patch

and linus/master is contained in ~/path1/linux-2.6, too.

Bundling doesn't work either:

	ukl@hostname:~/path2/linux-2.6$ git bundle create tralala linus/master=
=2E.sectionmismatches
	Counting objects: 118, done.
	error: unable to find 40aaeb204dc04d3cf15c060133f65538b43b13b0
	Delta compression using up to 8 threads.
	Compressing objects: 100% (83/83), done.
	fatal: unable to read 40aaeb204dc04d3cf15c060133f65538b43b13b0
	error: pack-objects died

git gc fails with a different object:

	ukl@hostname:~/path2/linux-2.6$ git gc
	error: Could not read f6b6cb2336198913371e66664f28c135df01aea5
	fatal: Failed to traverse parents of commit 76d1acb95eef413a2501a63cb7=
f7f4036b71ed37
	error: failed to run repack

(git gc is fine in ~/path1/linux-2.6)

	ukl@hostname:~$ git version
	git version 1.7.2.3

As a side note I have the general feeling that git recently started to
do more things than necessary (e.g. sometimes `git stash pop` takes >1s
(not mesured) between the status stuff (up to "no changes added to
commit (use ...)") and "Dropped refs/stash@{0} ($commitid)".  I wonder
what git stash is doing during that time.) I don't know if this is the
problem here, though.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
