From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH] git-svn: avoid fetching files outside of the URL we're tracking
Date: Wed, 05 Jul 2006 05:14:00 -0700
Message-ID: <115210164094-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Cc: Santi <sbejar@gmail.com>, git@vger.kernel.org,
	Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Wed Jul 05 14:14:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fy6Ge-000859-TG
	for gcvg-git@gmane.org; Wed, 05 Jul 2006 14:14:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWGEMOE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Jul 2006 08:14:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWGEMOE
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Jul 2006 08:14:04 -0400
Received: from hand.yhbt.net ([66.150.188.102]:24999 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S964828AbWGEMOD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Jul 2006 08:14:03 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 29D427DC021;
	Wed,  5 Jul 2006 05:14:01 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed,  5 Jul 2006 05:14:00 -0700
To: Junio C Hamano <junkio@cox.net>
X-Mailer: git-send-email 1.4.1.ge255
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23347>

Thanks to Santi <sbejar@gmail.com> for the bug report and explanation:
> /path/to/repository/project/file
> /path/to/repository/project-2/file
<...>
> you end up with a project with the following files:
>
> file
> -2/file

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 contrib/git-svn/git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 08e36be..6d49109 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -2625,7 +2625,7 @@ sub libsvn_connect {
 sub libsvn_get_file {
 	my ($gui, $f, $rev) = @_;
 	my $p = $f;
-	return unless ($p =~ s#^\Q$SVN_PATH\E/?##);
+	return unless ($p =~ s#^\Q$SVN_PATH\E/##);
 
 	my ($hash, $pid, $in, $out);
 	my $pool = SVN::Pool->new;
-- 
1.4.1.ge255
