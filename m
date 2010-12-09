From: "John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
Subject: [PATCH 08/18] gitweb: Change is_cacheable() to return true always
Date: Thu,  9 Dec 2010 13:57:14 -0800
Message-ID: <1291931844-28454-9-git-send-email-warthog9@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 09 22:56:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQoT0-0006x0-Va
	for gcvg-git-2@lo.gmane.org; Thu, 09 Dec 2010 22:55:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757458Ab0LIVzz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 16:55:55 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:51852 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757196Ab0LIVzy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 16:55:54 -0500
Received: from voot-cruiser.middle.earth (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oB9LtePs027765
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Thu, 9 Dec 2010 13:55:52 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 13:55:52 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163337>

is_cacheable() was set to return false for blame or blame_incremental
which both use unique urls so there's no reason this shouldn't pass
through the caching engine.

Leaving the function in place for now should something actually arrise
that we can't use caching for (think ajaxy kinda things likely).

Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
---
 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 5eb0309..1d8bc74 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -798,7 +798,8 @@ our %actions = (
 );
 sub is_cacheable {
 	my $action = shift;
-	return !($action eq 'blame_data' || $action eq 'blame_incremental');
+	# There are no known actions that do no involve a unique URL that shouldn't be cached.
+	return 1;
 }
 
 # finally, we have the hash of allowed extra_options for the commands that
-- 
1.7.2.3
