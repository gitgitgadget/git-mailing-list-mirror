From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 09/18] gitweb: Revert reset_output() back to original code
Date: Thu,  9 Dec 2010 13:57:15 -0800
Message-ID: <1291931844-28454-10-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:55:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoT1-0006x0-Fe
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757466Ab0LIVz5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:57 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51855 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757439Ab0LIVzz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:55 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePt027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:53 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:54 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163335>

Reverted change to reset_output as

	open STDOUT, ">&", \*STDOUT_REAL;

causes assertion failures:

	Assertion !((((s->var)->sv_flags & (0x00004000|0x00008000)) == 0x00008000) && (((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVGV || ((svtype)((s->var)->sv_flags & 0xff)) == SVt_PVLV)) failed: file "scalar.xs", line 49 at gitweb.cgi line 1221.

if we encounter an error *BEFORE* we've ever changed the output.

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1d8bc74..e8c028b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1225,7 +1225,7 @@ sub change_output {
 
 sub reset_output {
 	# This basically takes STDOUT_REAL and puts it back as STDOUT
-	open STDOUT, ">&", \*STDOUT_REAL;
+	open(STDOUT,">&STDOUT_REAL");
 }
 
 sub run {
-- 
1.7.2.3
