From: =?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
Subject: [PATCH v5 31/31] git-remote-mediawiki: Make error message more precise
Date: Wed, 12 Jun 2013 17:43:48 +0200
Message-ID: <1371051828-12866-32-git-send-email-celestin.matte@ensimag.fr>
References: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: benoit.person@ensimag.fr, matthieu.moy@grenoble-inp.fr,
	=?UTF-8?q?C=C3=A9lestin=20Matte?= <celestin.matte@ensimag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 12 17:45:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UmnEJ-0007Ue-LP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Jun 2013 17:45:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757020Ab3FLPo0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 12 Jun 2013 11:44:26 -0400
Received: from mx1.imag.fr ([129.88.30.5]:43484 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756991Ab3FLPoX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Jun 2013 11:44:23 -0400
Received: from ensimag.imag.fr (ensimag.imag.fr [195.221.228.12])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id r5CFiKsW028900
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 12 Jun 2013 17:44:20 +0200
Received: from ensibm.imag.fr (ensibm.imag.fr [195.221.228.8])
	by ensimag.imag.fr (8.13.8/8.13.8/ImagV2.1.r_ens) with ESMTP id r5CFiLRC015114;
	Wed, 12 Jun 2013 17:44:21 +0200
Received: from tohwi-K50IE.imag.fr (ensibm [195.221.228.8])
	by ensibm.imag.fr (8.13.8/8.13.8/ImagV2.1.sb_ens.pm) with ESMTP id r5CFhu6G014096;
	Wed, 12 Jun 2013 17:44:21 +0200
X-Mailer: git-send-email 1.8.3.rc3.18.g21a7b2c
In-Reply-To: <1371051828-12866-1-git-send-email-celestin.matte@ensimag.fr>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Jun 2013 17:44:20 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227634>

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
index d839154..a20a588 100755
--- a/contrib/mw-to-git/git-remote-mediawiki.perl
+++ b/contrib/mw-to-git/git-remote-mediawiki.perl
@@ -171,12 +171,16 @@ sub parse_command {
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
1.8.3.rc3.18.g21a7b2c
