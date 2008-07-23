From: "P. Christeas" <p_christ@hol.gr>
Subject: [PATCH] svnimport: newer libsvn wants us to ask for the root with "", not "/"
Date: Wed, 23 Jul 2008 23:08:27 +0300
Message-ID: <200807232308.30151.p_christ@hol.gr>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Gerrit Pape <pape@smarden.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 23 22:09:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLkeC-0001eo-Dd
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 22:09:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754735AbYGWUIN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jul 2008 16:08:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754904AbYGWUIM
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jul 2008 16:08:12 -0400
Received: from deliver.hol.gr ([62.38.3.177]:53215 "EHLO deliver.hol.gr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755015AbYGWUIL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jul 2008 16:08:11 -0400
X-Greylist: delayed 46637 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Jul 2008 16:08:10 EDT
Received: from auth-smtp.hol.gr (takeit02.mail.dc.hol.net [192.168.20.72])
	by deliver.hol.gr (8.12.11/8.11.6) with ESMTP id m6NK7mv4007916
	(using TLSv1/SSLv3 with cipher DHE-RSA-AES256-SHA (256 bits) verified OK);
	Wed, 23 Jul 2008 23:07:48 +0300
Received: from pfn1.pefnos (ppp079166029101.dsl.hol.gr [79.166.29.101])
	by auth-smtp.hol.gr (8.13.1/8.13.1) with ESMTP id m6NK7jcY023137;
	Wed, 23 Jul 2008 23:07:47 +0300
Received: from xorhgos2 (cpe-77-83-154-127-dsl.netone.gr [77.83.154.127])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pfn1.pefnos (Postfix) with ESMTP id 65E5BFB0A;
	Wed, 23 Jul 2008 23:07:45 +0300 (EEST)
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.93/7599/Tue Jul  1 14:10:31 2008 on takeit02.mail.dc.hol.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89765>

In r27729, libsvn introduced an assert which explicitly
forbids searching the tree at "/". Luckily enough, it
still accepts an empty string "" as the starting point.

http://svn.collab.net/viewvc/svn/trunk/subversion/libsvn_ra/ra_loader.c?r1=27653&r2=27729

Tested against libsvn0-1.5.0-4mdv2009.0 (needs the fix),
libsvn0-1.4.6-5mdv2008.1 (works anyway)

Signed-off-by: P. Christeas <p_christ@hol.gr>
---
 contrib/examples/git-svnimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/examples/git-svnimport.perl 
b/contrib/examples/git-svnimport.perl
index ea8c1b2..a13bb6a 100755
--- a/contrib/examples/git-svnimport.perl
+++ b/contrib/examples/git-svnimport.perl
@@ -933,7 +933,7 @@ while ($to_rev < $opt_l) {
 	$to_rev = $from_rev + $repack_after;
 	$to_rev = $opt_l if $opt_l < $to_rev;
 	print "Fetching from $from_rev to $to_rev ...\n" if $opt_v;
-	$svn->{'svn'}->get_log("/",$from_rev,$to_rev,0,1,1,\&commit_all);
+	$svn->{'svn'}->get_log("",$from_rev,$to_rev,0,1,1,\&commit_all);
 	my $pid = fork();
 	die "Fork: $!\n" unless defined $pid;
 	unless($pid) {
-- 
1.5.6
