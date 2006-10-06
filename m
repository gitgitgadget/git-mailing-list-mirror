From: Matthew Wilcox <matthew@wil.cx>
Subject: Make git-send-email detect mbox-style patches more readily
Date: Fri, 6 Oct 2006 14:24:14 -0600
Message-ID: <20061006202414.GR2563@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Oct 06 22:24:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVwFD-0002m6-A3
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 22:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932581AbWJFUYQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932583AbWJFUYP
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 16:24:15 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:25795 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S932581AbWJFUYP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Oct 2006 16:24:15 -0400
Received: by mail.parisc-linux.org (Postfix, from userid 26919)
	id B7E38494003; Fri,  6 Oct 2006 14:24:14 -0600 (MDT)
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28443>


Earlier today, I embarrassed myself by trying to construct a patch that
git-send-email would send, and I missed out the putting

>From garbage

line on the front, which led it to send the patches with a
Subject: From: Matthew Wilcox <matthew@wil.cx>
line.  Bad.

This patch makes git-send-email detect an mbox-style file more readily,
and correctly handles the patches I constructed.

--- git-core-willy/git-send-email.perl	2006-07-24 23:45:08.000000000 -0400
+++ git-core-1.4.1.1/git-send-email.perl	2006-10-06 16:02:37.000000000 -0400
@@ -451,6 +451,7 @@
 		if (!$header_done) {
 			$found_mbox = 1, next if (/^From /);
 			chomp;
+			$found_mbox = 1 if (/^(From|Date|Cc|Subject):/);
 
 			if ($found_mbox) {
 				if (/^Subject:\s+(.*)$/) {
