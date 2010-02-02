From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 2/2] gitweb: Fix chop_str to allow for & characters in strings
Date: Tue,  2 Feb 2010 13:56:54 -0800
Message-ID: <1265147814-13284-3-git-send-email-warthog9@eaglescrag.net>
References: <1265147814-13284-1-git-send-email-warthog9@eaglescrag.net>
 <1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 02 22:57:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NcQkB-0002WV-Go
	for gcvg-git-2@lo.gmane.org; Tue, 02 Feb 2010 22:57:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756883Ab0BBV5H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2010 16:57:07 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:42436 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756863Ab0BBV5E (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2010 16:57:04 -0500
Received: from localhost.localdomain (c-71-202-189-206.hsd1.ca.comcast.net [71.202.189.206])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.3/8.14.3) with ESMTP id o12Lusew009001
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Tue, 2 Feb 2010 13:57:03 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.6.6
In-Reply-To: <1265147814-13284-2-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Tue, 02 Feb 2010 13:57:03 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138764>

I'm unsure why this was placed in their originally, and it seems to
ultimately stem from code from before gitweb was merged into git core,
but there's an instance where git chops a string incorrectly based on
this.

Specifically:

	API & protocol: support option to force written data immediately to disk

from http://git.kernel.org/?p=daemon/distsrv/chunkd.git;a=commit;h=3b02f749df2cb1288f345a689d85e7061f507e54

The short version of the title gets chopped to

	API ...

where it should be

	API & protocol: support option to force written data...

This reverts that specific problem.
---
 gitweb/gitweb.perl |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 57771a0..4cc6d19 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1382,7 +1382,6 @@ sub chop_str {
 		my $body = $1;
 		my $tail = $2;
 		if (length($tail) > 4) {
-			$body =~ s/&[^;]*$//;
 			$tail = "... ";
 		}
 		return "$body$tail";
-- 
1.6.6
