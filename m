From: Jeff Garzik <jeff@garzik.org>
Subject: Cosmetic git-am interactive bug
Date: Tue, 04 Dec 2007 14:19:18 -0500
Message-ID: <4755A836.1050408@garzik.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060501020606070603050008"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Dec 04 20:19:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzdJ1-0000at-J6
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 20:19:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751075AbXLDTTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Dec 2007 14:19:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751055AbXLDTTV
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Dec 2007 14:19:21 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:51437 "EHLO mail.dvmed.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750831AbXLDTTU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2007 14:19:20 -0500
Received: from cpe-069-134-071-233.nc.res.rr.com ([69.134.71.233] helo=core.yyz.us)
	by mail.dvmed.net with esmtpsa (Exim 4.63 #1 (Red Hat Linux))
	id 1IzdId-0004TC-6u
	for git@vger.kernel.org; Tue, 04 Dec 2007 19:19:20 +0000
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
X-Spam-Score: -4.4 (----)
X-Spam-Report: SpamAssassin version 3.1.9 on srv5.dvmed.net summary:
	Content analysis details:   (-4.4 points, 5.0 required)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67074>

This is a multi-part message in MIME format.
--------------060501020606070603050008
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Just now, I was exploring git-am's interactive mode, so as to comply 
with Linus's urgings of a cleaner changelog <grin>.  I had a raw email 
changelog with the subject

	Re: 2.6.24-rc3-git6: Reported regressions from 2.6.23

I used the [e]dit feature of interactive mode to change this 
first-line/one-line summary to

	pata_amd/pata_via: de-couple programming of PIO/MWDMA and UDMA
	timings

When I hit [y]es to apply the patch, git reported

	Applying 2.6.24-rc3-git6: Reported regressions from 2.6.23

	Wrote tree 34cebd48e3b4e90fe3e6a6c6c03154ae1ed0c827
	Committed: 943547abdfe9b4e27e36a25987909619908dffbf

The use of the older one-line summary led me to believe that it had not 
committed my changelog edits.  Looking at the result, however, proved 
that the commit changelog was my new, corrected version.

Thus, I concluded that the printing of the old-and-no-longer-valid 
changelog during the commit-to-tree phase was a bug.

Please see attached file for full example.

Thanks,

	Jeff



--------------060501020606070603050008
Content-Type: text/plain;
 name="git-am.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="git-am.txt"

[jgarzik@pretzel libata-dev]$ git-am --utf8 --signoff -i /g/tmp/mbox 
Commit Body is:
--------------------------
2.6.24-rc3-git6: Reported regressions from 2.6.23

On Saturday 01 December 2007, Rafael J. Wysocki wrote:

> Subject               : 2.6.24-rc1: pata_amd fails to detect 80-pin wire
> Submitter     : "Thomas Lindroth" <thomas.lindroth@gmail.com>
> References    : http://lkml.org/lkml/2007/11/7/152
>                 http://bugzilla.kernel.org/show_bug.cgi?id=9322
> Handled-By    : Tejun Heo <htejun@gmail.com>
>                 Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
> Patch         : http://lkml.org/lkml/2007/11/11/115

Tejun's rework of cable detection code which fixes the problem has
been just applied into "upstream" (not "upstream-fixes") so it is
destined for 2.6.25 (I wasn't on cc: BTW) and since I got no feedback
on my patch (below) which also happens to fix the regression, was
acked by Alan, tested by Thomas and has been in -mm for 3 weeks now
I assume that everybody is happy with it (Jeff/Tejun: you were also
on cc: when the patch was merged into -mm)...

Linus, please apply.

[PATCH] pata_amd/pata_via: de-couple programming of PIO/MWDMA and UDMA timings

* Don't program UDMA timings when programming PIO or MWDMA modes.

  This has also a nice side-effect of fixing regression added by commit
  681c80b5d96076f447e8101ac4325c82d8dce508 ("libata: correct handling of
  SRST reset sequences") (->set_piomode method for PIO0 is called before
  ->cable_detect method which checks UDMA timings to get the cable type).

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Tested-by: "Thomas Lindroth" <thomas.lindroth@gmail.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jeff@garzik.org>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all e
Commit Body is:
--------------------------
pata_amd/pata_via: de-couple programming of PIO/MWDMA and UDMA timings

* Don't program UDMA timings when programming PIO or MWDMA modes.

  This has also a nice side-effect of fixing regression added by commit
  681c80b5d96076f447e8101ac4325c82d8dce508 ("libata: correct handling of
  SRST reset sequences") (->set_piomode method for PIO0 is called before
  ->cable_detect method which checks UDMA timings to get the cable type).

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Tested-by: "Thomas Lindroth" <thomas.lindroth@gmail.com>
Acked-by: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Tejun Heo <htejun@gmail.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Signed-off-by: Jeff Garzik <jeff@garzik.org>
--------------------------
Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all y

Applying 2.6.24-rc3-git6: Reported regressions from 2.6.23

Wrote tree 34cebd48e3b4e90fe3e6a6c6c03154ae1ed0c827
Committed: 943547abdfe9b4e27e36a25987909619908dffbf


--------------060501020606070603050008--
