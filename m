From: Emil Medve <Emilian.Medve@Freescale.com>
Subject: [PATCH v2] git-cvsimport: Add support for CVSNT as an underlying client
Date: Thu, 13 Mar 2008 12:45:18 -0500
Message-ID: <1205430318-4067-1-git-send-email-Emilian.Medve@Freescale.com>
Cc: Emil Medve <Emilian.Medve@Freescale.com>
To: gitster@pobox.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 13 18:52:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZral-0007xl-Us
	for gcvg-git-2@gmane.org; Thu, 13 Mar 2008 18:51:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756585AbYCMRug (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Mar 2008 13:50:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755478AbYCMRuf
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Mar 2008 13:50:35 -0400
Received: from az33egw01.freescale.net ([192.88.158.102]:53415 "EHLO
	az33egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756545AbYCMRud (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Mar 2008 13:50:33 -0400
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id m2DHmaHD010315;
	Thu, 13 Mar 2008 10:48:37 -0700 (MST)
Received: from emmedve1-12.am.freescale.net (emmedve1-12.am.freescale.net [10.82.16.93])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m2DHmZNu022703;
	Thu, 13 Mar 2008 12:48:35 -0500 (CDT)
Received: by emmedve1-12.am.freescale.net (Postfix, from userid 1000)
	id 15E285E1489; Thu, 13 Mar 2008 12:45:18 -0500 (CDT)
X-Mailer: git-send-email 1.5.4.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77109>

CVSNT seems to feature the following relevant differences from classic CVS:
	1. Keeps the password information in ~/.cvs/cvspass instead of ~/.cvspass
	2. Used '=' to separate fields in cvspass instead of ' '

Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>
---
 git-cvsimport.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 95c5eec..90bd6cc 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -238,12 +238,13 @@ sub conn {
 		my $rr = ":pserver:$user\@$serv:$port$repo";
 
 		unless ($pass) {
-			open(H,$ENV{'HOME'}."/.cvspass") and do {
+			(open(H,$ENV{'HOME'}."/.cvspass") or
+			 open(H,$ENV{'HOME'}."/.cvs/cvspass")) and do {
 				# :pserver:cvs@mea.tmt.tele.fi:/cvsroot/zmailer Ah<Z
 				while (<H>) {
 					chomp;
 					s/^\/\d+\s+//;
-					my ($w,$p) = split(/\s/,$_,2);
+					my ($w,$p) = split(/\s|=/,$_,2);
 					if ($w eq $rr or $w eq $rr2) {
 						$pass = $p;
 						last;
-- 
1.5.4.GIT
