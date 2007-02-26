From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: Problems importing git-cur into git
Date: Mon, 26 Feb 2007 15:11:25 +0100
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <20070226141125.GA12506@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Transfer-Encoding: 8bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 26 15:19:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HLgZh-0001ZQ-Cj
	for gcvg-git@gmane.org; Mon, 26 Feb 2007 15:11:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030257AbXBZOLa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Feb 2007 09:11:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030258AbXBZOLa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Feb 2007 09:11:30 -0500
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:45170 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1030257AbXBZOL3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Feb 2007 09:11:29 -0500
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1HLgZc-0007PI-0y
	for git@vger.kernel.org; Mon, 26 Feb 2007 15:11:28 +0100
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11) with ESMTP id l1QEBPlc014138
	for <git@vger.kernel.org>; Mon, 26 Feb 2007 15:11:25 +0100 (MET)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.7+Sun/8.12.11/Submit) id l1QEBPIe014137
	for git@vger.kernel.org; Mon, 26 Feb 2007 15:11:25 +0100 (MET)
Mail-Followup-To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@informatik.uni-freiburg.de>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40622>


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hello,

I tried to apply Russell King's git-cur[1] to my linux-2.6 repo.  The
problem I was faced there is that git-am isn't able to parse the date in
the "From " lines.

arm.mbox uses e.g.

	From rmk Sun Feb 25 22:32:59 GMT 2007

while git-am (or more exactly git-mailsplit) expects to find the year
directly after the time.

The output of date specifies the timezone between time and year, too.

The next problem is that once more that my 'ö' is not correctly taken in
the commit.  I didn't debug that yet, but probably inserting a
Content-Type header helps here?

I'll debug that further, but at the moment I don't have the time.  Just
send out my current status, maybe someone else wants to look after that
issue.

Attached is the current script to reproduce it.

Best regards
Uwe

[1] ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/arm.mbox

-- 
Uwe Kleine-König

http://www.google.com/search?q=gigabyte+in+bit

--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=get-armgitcur

#! /bin/sh

MBOX="ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/arm.mbox";
DIFF="ftp://ftp.arm.linux.org.uk/pub/armlinux/kernel/git-cur/arm.diff";

LINUX_GIT="${HOME}/gsrc/linux-2.6";

tempfile=$(mktemp)
trap 'rm -f "${tempfile}"' INT QUIT TERM EXIT 

# Fix Date format for git-mailsplit that assumes that the year directly follows
# the time ...
wget -O - "${MBOX}" | sed "s/^\\(From .*:[0-9][0-9]\) GMT/\\1/" > "${tempfile}"

cd "${LINUX_GIT}";
git am "${tempfile}";

echo "${tempfile}";



--G4iJoqBmSsgzjUCe--
