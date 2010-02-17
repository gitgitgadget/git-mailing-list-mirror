From: Gabriel <g2p.code@gmail.com>
Subject: [PATCH] import-tars: properly import git-archive tarballs
Date: Wed, 17 Feb 2010 20:20:52 +0100
Message-ID: <1266434452-14532-1-git-send-email-g2p.code@gmail.com>
Cc: Gabriel <g2p.code@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 20:21:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhpSW-0001if-Qq
	for gcvg-git-2@lo.gmane.org; Wed, 17 Feb 2010 20:21:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab0BQTVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 14:21:11 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:48084 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754101Ab0BQTVK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 14:21:10 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id A69AA81816B;
	Wed, 17 Feb 2010 20:21:03 +0100 (CET)
Received: from localhost (pro75-5-88-162-203-35.fbx.proxad.net [88.162.203.35])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C185A818112;
	Wed, 17 Feb 2010 20:21:00 +0100 (CET)
Received: from g2p by localhost with local (Exim 4.69)
	(envelope-from <tobutaz+moulinex+mail+g2p@gmail.com>)
	id 1NhpSB-0003qz-Ig; Wed, 17 Feb 2010 20:20:55 +0100
X-Mailer: git-send-email 1.7.0.rc2.31.g618d1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140254>

git-archive adds a special entry to the archives it creates,
pax_global_header, containing the SHA1 of the exported commit.

import-tars.perl extracted it as a file, the top directory of
the archive became a subdirectory, and files moved with every
imported tarball.

Now import-tars correctly ignores the comment.

Signed-off-by: Gabriel <g2p.code@gmail.com>
---
 contrib/fast-import/import-tars.perl |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/import-tars.perl b/contrib/fast-import/import-tars.perl
index 95438e1..a5170a1 100755
--- a/contrib/fast-import/import-tars.perl
+++ b/contrib/fast-import/import-tars.perl
@@ -108,6 +108,7 @@ foreach my $tar_file (@ARGV)
 			}
 		}
 		print FI "\n";
+		next if $typeflag eq 'g' && $name eq 'pax_global_header';
 
 		my $path;
 		if ($prefix) {
-- 
1.7.0.rc2.31.g618d1
