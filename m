From: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
Subject: [PATCH 1/2] send-email: rfc822 forbids using <address@domain> without a non-empty "phrase"
Date: Thu,  9 Aug 2007 15:27:57 +0200
Organization: Universitaet Freiburg, Institut f. Informatik
Message-ID: <1186666080946-git-send-email-ukleinek@informatik.uni-freiburg.de>
References: <11866660781833-git-send-email-ukleinek@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Uwe=20Kleine-K=C3=B6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 09 15:28:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJ83v-0007J0-MK
	for gcvg-git@gmane.org; Thu, 09 Aug 2007 15:28:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S939213AbXHIN2I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Thu, 9 Aug 2007 09:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S939196AbXHIN2H
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Aug 2007 09:28:07 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:63977 "EHLO
	atlas.informatik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S939198AbXHIN2E (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 9 Aug 2007 09:28:04 -0400
Received: from login.informatik.uni-freiburg.de ([132.230.151.6])
	by atlas.informatik.uni-freiburg.de with esmtps (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.66)
	(envelope-from <zeisberg@informatik.uni-freiburg.de>)
	id 1IJ83W-0006YJ-SI; Thu, 09 Aug 2007 15:28:02 +0200
Received: from login.informatik.uni-freiburg.de (localhost [127.0.0.1])
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11) with ESMTP id l79DS2WU015355;
	Thu, 9 Aug 2007 15:28:02 +0200 (MEST)
Received: (from zeisberg@localhost)
	by login.informatik.uni-freiburg.de (8.13.8+Sun/8.12.11/Submit) id l79DS1p2015354;
	Thu, 9 Aug 2007 15:28:01 +0200 (MEST)
X-Mailer: git-send-email 1.5.3.rc4.855.gaac4
In-Reply-To: <11866660781833-git-send-email-ukleinek@informatik.uni-freiburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55448>

Email::Valid does respect this considering such a mailbox specification
invalid.  b06c6bc831cbb9e9eb82fd3ffd5a2b674cd940d0 addressed the issue,=
 but
only if Email::Valid is available.

Signed-off-by: Uwe Kleine-K=C3=B6nig <ukleinek@informatik.uni-freiburg.=
de>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 39e433b..a02ab96 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -408,8 +408,8 @@ sub extract_valid_address {
 	# check for a local address:
 	return $address if ($address =3D~ /^($local_part_regexp)$/);
=20
+	$address =3D~ s/^\s*<(.*)>\s*$/$1/;
 	if ($have_email_valid) {
-		$address =3D~ s/^\s*<(.*)>\s*$/$1/;
 		return scalar Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
--=20
1.5.3.rc3.943.g14c81
