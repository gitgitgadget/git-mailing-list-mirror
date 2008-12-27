From: "Devin Doucette" <devin@doucette.cc>
Subject: [PATCH] gitweb: Fix export check in git_get_projects_list
Date: Sat, 27 Dec 2008 02:39:31 -0700
Message-ID: <a899d7ef0812270139u7dd28ee1q45a8c05f7c95db2f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Petr Baudis" <petr.baudis@novartis.com>,
	"Jakub Narebski" <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 27 10:41:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGVfD-0003E1-N4
	for gcvg-git-2@gmane.org; Sat, 27 Dec 2008 10:40:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752590AbYL0Jjf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 27 Dec 2008 04:39:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbYL0Jje
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Dec 2008 04:39:34 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:53082 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbYL0Jje (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Dec 2008 04:39:34 -0500
Received: by ewy10 with SMTP id 10so4288275ewy.13
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 01:39:32 -0800 (PST)
Received: by 10.210.66.1 with SMTP id o1mr13620432eba.0.1230370771922;
        Sat, 27 Dec 2008 01:39:31 -0800 (PST)
Received: by 10.210.22.20 with HTTP; Sat, 27 Dec 2008 01:39:31 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103993>

When $filter was empty, the path passed to check_export_ok would
contain an extra '/', which some implementations of export_auth_hook
are sensitive to.

It makes more sense to fix this here than to handle the special case
in each implementation of export_auth_hook.

Signed-off-by: Devin Doucette <devin@doucette.cc>
---
 gitweb/gitweb.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8f574c7..99f71b4 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2147,8 +2147,9 @@ sub git_get_projects_list {

 				my $subdir = substr($File::Find::name, $pfxlen + 1);
 				# we check related file in $projectroot
-				if (check_export_ok("$projectroot/$filter/$subdir")) {
-					push @list, { path => ($filter ? "$filter/" : '') . $subdir };
+				my $path = ($filter ? "$filter/" : '') . $subdir;
+				if (check_export_ok("$projectroot/$path")) {
+					push @list, { path => $path };
 					$File::Find::prune = 1;
 				}
 			},
-- 
1.6.1.rc4
