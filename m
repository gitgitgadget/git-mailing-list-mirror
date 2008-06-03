From: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
Subject: [PATCH] Avoid errors from git-rev-parse in gitweb blame
Date: Tue,  3 Jun 2008 12:46:17 +0200
Message-ID: <1212489977-26822-1-git-send-email-rgarciasuarez@gmail.com>
Cc: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 03 12:47:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3U2j-0004eS-S8
	for gcvg-git-2@gmane.org; Tue, 03 Jun 2008 12:47:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753075AbYFCKqG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 06:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756528AbYFCKqF
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 06:46:05 -0400
Received: from smtp6-g19.free.fr ([212.27.42.36]:45075 "EHLO smtp6-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753190AbYFCKqD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 06:46:03 -0400
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id EC1785FE40;
	Tue,  3 Jun 2008 12:46:02 +0200 (CEST)
Received: from localhost.localdomain (inv75-3-82-241-119-67.fbx.proxad.net [82.241.119.67])
	by smtp6-g19.free.fr (Postfix) with ESMTP id C97995FDAD;
	Tue,  3 Jun 2008 12:46:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83635>

git-rev-parse will abort with an error when passed a non-existent
revision spec, such as "deadbeef^" where deadbeef has no parent.
Using the --revs-only parameter makes this error go away, while
retaining functionality, keeping the web server error log nice
and clean.

Signed-off-by: Rafael Garcia-Suarez <rgarciasuarez@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 55fb100..f3b4b24 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4226,9 +4226,9 @@ HTML
 			              esc_html($rev));
 			print "</td>\n";
 		}
-		open (my $dd, "-|", git_cmd(), "rev-parse", "$full_rev^")
+		open (my $dd, "-|", git_cmd(), "rev-parse", '--revs-only', "$full_rev^")
 			or die_error(undef, "Open git-rev-parse failed");
-		my $parent_commit = <$dd>;
+		my $parent_commit = <$dd> || '';
 		close $dd;
 		chomp($parent_commit);
 		my $blamed = href(action => 'blame',
-- 
1.5.6.rc1
