From: "Devin Doucette" <devin@doucette.cc>
Subject: [PATCH] gitweb: Handle actions with no project in evaluate_path_info
Date: Sun, 28 Dec 2008 00:26:52 -0700
Message-ID: <a899d7ef0812272326j1a407c30k936bf8d8975c9063@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Jakub Narebski" <jnareb@gmail.com>,
	"Petr Baudis" <petr.baudis@novartis.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 28 08:32:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LGq85-0005vH-Pp
	for gcvg-git-2@gmane.org; Sun, 28 Dec 2008 08:32:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751977AbYL1H0z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Dec 2008 02:26:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751573AbYL1H0z
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Dec 2008 02:26:55 -0500
Received: from mail-ew0-f17.google.com ([209.85.219.17]:59137 "EHLO
	mail-ew0-f17.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750988AbYL1H0y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Dec 2008 02:26:54 -0500
Received: by ewy10 with SMTP id 10so4574332ewy.13
        for <git@vger.kernel.org>; Sat, 27 Dec 2008 23:26:53 -0800 (PST)
Received: by 10.210.59.14 with SMTP id h14mr258913eba.16.1230449212843;
        Sat, 27 Dec 2008 23:26:52 -0800 (PST)
Received: by 10.210.123.20 with HTTP; Sat, 27 Dec 2008 23:26:52 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104044>

The action would not be set if no valid project was found in
path_info. Removing the return if the project was not specified fixes
the project_index and opml actions when using path_info.

Signed-off-by: Devin Doucette <devin@doucette.cc>
---
 gitweb/gitweb.perl |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 8f574c7..b6a8ea9 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -552,8 +552,7 @@ sub evaluate_path_info {
 	while ($project && !check_head_link("$projectroot/$project")) {
 		$project =~ s,/*[^/]*$,,;
 	}
-	return unless $project;
-	$input_params{'project'} = $project;
+	$input_params{'project'} = $project if $project;

 	# do not change any parameters if an action is given using the query string
 	return if $input_params{'action'};
-- 
1.6.1.rc4
