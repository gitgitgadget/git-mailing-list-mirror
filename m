From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: t5570 trap use in start/stop_git_daemon
Date: Thu, 12 Feb 2015 15:31:12 -0500
Message-ID: <013601d04702$d7e721e0$87b565a0$@nexbridge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: "'Joachim Schmitz'" <jojo@schmitz-digital.de>
To: "'Git Mailing List'" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 12 21:31:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YM0Q0-0002KN-BQ
	for gcvg-git-2@plane.gmane.org; Thu, 12 Feb 2015 21:31:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751891AbbBLUbU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Feb 2015 15:31:20 -0500
Received: from elephants.elehost.com ([216.66.27.132]:53084 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751219AbbBLUbU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Feb 2015 15:31:20 -0500
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t1CKVCZP037802
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Thu, 12 Feb 2015 15:31:13 -0500 (EST)
	(envelope-from rsbecker@nexbridge.com)
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AdBG89x+7shZsRYjShqEBnkz0yxbSA==
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263766>

On the NonStop port, we found that =93trap=94 was causing an issue with=
 test
success for t5570. When start_git_daemon completes, the shell (ksh,bash=
) on
this platform is sending a signal 0 that is being caught and acted on b=
y the
trap command within the start_git_daemon and stop_git_daemon functions.=
 I am
taking this up with the operating system group, but in any case, it may=
 be
appropriate to include a trap reset at the end of both functions, as be=
low.
I verified this change on SUSE Linux.

diff --git a/t/lib-git-daemon.sh b/t/lib-git-daemon.sh
index bc4b341..543e98a 100644
--- a/t/lib-git-daemon.sh
+++ b/t/lib-git-daemon.sh
@@ -62,6 +62,7 @@ start_git_daemon() {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 test_skip_or_die $GIT_TES=
T_GIT_DAEMON \
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "=
git daemon failed to start"
=A0=A0=A0=A0=A0=A0=A0fi
+=A0=A0=A0=A0=A0=A0 trap '' EXIT
}

stop_git_daemon() {
@@ -84,4 +85,6 @@ stop_git_daemon() {
=A0=A0=A0=A0=A0=A0=A0 fi
=A0=A0=A0=A0=A0=A0=A0 GIT_DAEMON_PID=3D
=A0=A0=A0=A0=A0=A0=A0 rm -f git_daemon_output
+
+=A0=A0=A0=A0=A0=A0 trap '' EXIT
}

Cheers,
Randall
-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In real life, I talk too much.
