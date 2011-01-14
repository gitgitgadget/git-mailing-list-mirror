From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<u.kleine-koenig@pengutronix.de>
Subject: bug: request-pull broken when remote name contains a slash
Date: Fri, 14 Jan 2011 10:06:45 +0100
Message-ID: <20110114090645.GA13060@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 14 10:07:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PdfcY-0003pb-PW
	for gcvg-git-2@lo.gmane.org; Fri, 14 Jan 2011 10:06:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753764Ab1ANJGw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jan 2011 04:06:52 -0500
Received: from metis.ext.pengutronix.de ([92.198.50.35]:37809 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751294Ab1ANJGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jan 2011 04:06:46 -0500
Received: from octopus.hi.pengutronix.de ([2001:6f8:1178:2:215:17ff:fe12:23b0])
	by metis.ext.pengutronix.de with esmtp (Exim 4.72)
	(envelope-from <ukl@pengutronix.de>)
	id 1PdfcL-0002xh-JD
	for git@vger.kernel.org; Fri, 14 Jan 2011 10:06:45 +0100
Received: from ukl by octopus.hi.pengutronix.de with local (Exim 4.69)
	(envelope-from <ukl@pengutronix.de>)
	id 1PdfcL-0006ym-I7
	for git@vger.kernel.org; Fri, 14 Jan 2011 10:06:45 +0100
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-SA-Exim-Connect-IP: 2001:6f8:1178:2:215:17ff:fe12:23b0
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165084>

Hello,

the remotes in my linux repo look as follows:

	[remote "ptx/ukl"]
		url =3D git://git.pengutronix.de/git/ukl/linux-2.6.git
		push =3D +refs/heads/*:refs/heads/*
		fetch =3D +refs/heads/*:refs/remotes/ptx/ukl/*

	[remote "ptx/otheruser"]
		url =3D git://git.pengutronix.de/git/otheruser/linux-2.6.git
		fetch =3D +refs/heads/*:refs/remotes/ptx/otheruser/*

	[remote "ptx/yetanotheruser"]
		url =3D git://git.pengutronix.de/git/yetanotheruser/linux-2.6.git
		fetch =3D +refs/heads/*:refs/remotes/ptx/yetanotheruser/*

unfortunately this makes sending request pulls uncomfortable:

	ukl@octopus:~/gsrc/linux-2.6$ git request-pull HEAD^ ptx/ukl
	The following changes since commit a08948812b30653eb2c536ae613b635a989=
feb6f:

	  Merge branch 'hwmon-for-linus' of git://git.kernel.org/pub/scm/linux=
/kernel/git/groeck/staging (2011-01-10 08:57:46 -0800)

	are available in the git repository at:

	  ptx/ukl mxs/for-2.6.38
	...

The reason for that is in git-parse-remote.sh:get_data_source() which
assumes that a remote with a slash is a filename and so get_remote_url
doesn't use $(git config --get "remote.$1.url") but ptx/ukl directly.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
