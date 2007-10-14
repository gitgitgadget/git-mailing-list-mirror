From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: git blame crashes with internal error
Date: Sun, 14 Oct 2007 16:36:28 +0200
Message-ID: <20071014143628.GA22568@atjola.homenet>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="LZvS9be/3tNcYl/X"
Content-Transfer-Encoding: 8bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Oct 14 16:36:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih4aD-0002Uu-1J
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 16:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753572AbXJNOgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 10:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbXJNOgc
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 10:36:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:57393 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752233AbXJNOgc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 10:36:32 -0400
Received: (qmail invoked by alias); 14 Oct 2007 14:36:30 -0000
Received: from i577BAEEF.versanet.de (EHLO localhost) [87.123.174.239]
  by mail.gmx.net (mp042) with SMTP; 14 Oct 2007 16:36:30 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/+X/tGpTr+d0VuQv98UrWeYu36YJBAGzOe8hkj5J
	oBL1b2y826FKvr
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60851>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Junio,

git blame just decided to crash on me, when I tried to use it while
resolving a merge conflict. Interesting is probably, that it crashes
when given the filename of a file that is not _directly_ affected by the
merge, but contains code that originates from a file that caused
conlicts.

Error message is:
fatal: internal error: ce_mode is 0

I tried all git releases from 1.5.3 to 1.5.3.4 as well as the current
master and all of them crashed. A small shell script to reproduce the
problem is attached.

Thanks,
Björn

--LZvS9be/3tNcYl/X
Content-Type: application/x-sh
Content-Disposition: attachment; filename="testcase.sh"
Content-Transfer-Encoding: quoted-printable

#!/bin/sh=0A=0Amkdir gittc=0Acd gittc=0A=0A# Create repo=0Agit init=0A=0A# =
Create the old file=0Aecho "Old line" > file1=0Agit add file1=0Agit commit =
-m file1=0A=0A# Branch=0Agit checkout -b foo=0A=0A# Do an ugly move and cha=
nge=0Agit rm file1=0Aecho "New line ...\n... and more" > file2=0Agit add fi=
le2=0Agit commit -m "Ugly"=0A=0A# Back to master and change something=0Agit=
 checkout master=0Aecho "\n\n\n\n\n\n\n\n\n\nbla" >> file1=0Agit commit -a =
-m file1=0A=0A# Back to foo and merge master=0Agit checkout foo=0Agit merge=
 master=0Aecho "New line ...\n ... and more\n\n\n\n\n\n\nbla\nEven more" > =
file2=0Agit rm file1=0Agit commit -a -m merged=0A=0A# Back to master and ch=
ange file1 again=0Agit checkout master=0Ased -i 's/bla/foo/' file1=0Agit co=
mmit -a -m replace=0A=0A=0A# Try to merge into foo again, and blame=0Agit c=
heckout foo=0Agit merge master=0Agit blame file2 ### DIE=0A=0A
--LZvS9be/3tNcYl/X--
