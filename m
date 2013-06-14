From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v6 31/31] git-remote-mediawiki: Make error message more precise
Date: Fri, 14 Jun 2013 15:50:39 +0200
Message-ID: <1371217839-23017-32-git-send-email-celestin.matte@ensimag.fr>
References: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 14 15:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UnUPS-0001Je-Qo
	for gcvg-git-2@plane.gmane.org; Fri, 14 Jun 2013 15:51:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab3FNNvN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Jun 2013 09:51:13 -0400
Received: from mx2.imag.fr ([129.88.30.17]:33314 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753030Ab3FNNvG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Jun 2013 09:51:06 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id r5EDp35L011347
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 14 Jun 2013 15:51:03 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5EDp5DY013469;
	Fri, 14 Jun 2013 15:51:05 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5EDoqgN016142;
	Fri, 14 Jun 2013 15:51:04 +0200
X-Mailer: git-send-email 1.8.3.1.491.g8a51f1c
In-Reply-To: <1371217839-23017-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Fri, 14 Jun 2013 15:51:03 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227842>

=46rom: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>

In subroutine parse_command, error messages were not correct. For the "=
import"
function, having too much or incorrect arguments displayed both
"invalid arguments", while it displayed "too many arguments" for the "o=
ption"
functions under the same conditions.
Separate the two error messages in both cases.

Signed-off-by: C=C3=A9lestin Matte <celestin.matte@ensimag.fr>
Signed-off-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
---
 contrib/mw-to-git/git-remote-mediawiki.perl | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/contrib/mw-to-git/git-remote-mediawiki.perl b/contrib/mw-t=
o-git/git-remote-mediawiki.perl
index 2246c84..9ff45fd 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -161,12 +161,16 @@ sub parse_command {
 		die("Too many arguments for list\n") if (defined($cmd[2]));
 		mw_list($cmd[1]);
 	} elsif ($cmd[0] eq 'import') {
-		die("Invalid arguments for import\n")
-		    if ($cmd[1] eq EMPTY || defined($cmd[2]));
+		die("Invalid argument for import\n")
+		    if ($cmd[1] eq EMPTY);
+		die("Too many arguments for import\n")
+		    if (defined($cmd[2]));
 		mw_import($cmd[1]);
 	} elsif ($cmd[0] eq 'option') {
+		die("Invalid arguments for option\n")
+		    if ($cmd[1] eq EMPTY || $cmd[2] eq EMPTY);
 		die("Too many arguments for option\n")
-		    if ($cmd[1] eq EMPTY || $cmd[2] eq EMPTY || defined($cmd[3]));
+		    if (defined($cmd[3]));
 		mw_option($cmd[1],$cmd[2]);
 	} elsif ($cmd[0] eq 'push') {
 		mw_push($cmd[1]);
--=20
1.8.3.rc3.49.g4e74807
