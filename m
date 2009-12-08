From: Alex Vandiver <alex@chmrr.net>
Subject: [PATCH 2/2] git-svn: Move setting of svn.authorsfile in clone to between init and fetch
Date: Tue,  8 Dec 2009 15:54:11 -0500
Message-ID: <1260305651-11111-2-git-send-email-alex@chmrr.net>
References: <1260305651-11111-1-git-send-email-alex@chmrr.net>
Cc: Eric Wong <normalperson@yhbt.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 08 21:54:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NI74q-0008Kz-Cj
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 21:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966098AbZLHUyX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Dec 2009 15:54:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966081AbZLHUyX
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Dec 2009 15:54:23 -0500
Received: from chmrr.net ([209.67.253.66]:41209 "EHLO utwig.chmrr.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965801AbZLHUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Dec 2009 15:54:20 -0500
Received: from 75-147-59-54-newengland.hfc.comcastbusiness.net ([75.147.59.54] helo=localhost.localdomain)
	by utwig.chmrr.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69)
	(envelope-from <alex@chmrr.net>)
	id 1NI74h-0006ch-T1; Tue, 08 Dec 2009 15:54:27 -0500
X-Mailer: git-send-email 1.6.6.rc0.360.gc408
In-Reply-To: <1260305651-11111-1-git-send-email-alex@chmrr.net>
X-Authenticated-User: chmrr
X-Authenticator: plain
X-Sender-Verify: SUCCEEDED (sender exists & accepts mail)
X-Exim-Version: 4.69 (build at 07-Feb-2009 20:08:51)
X-Date: 2009-12-08 15:54:27
X-Connected-IP: 75.147.59.54:40989
X-Message-Linecount: 37
X-Body-Linecount: 27
X-Message-Size: 1328
X-Body-Size: 858
X-Received-Count: 1
X-Recipient-Count: 2
X-Local-Recipient-Count: 2
X-Local-Recipient-Defer-Count: 0
X-Local-Recipient-Fail-Count: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134912>

If a clone errors out because of a missing author, or user interrupt,
this allows `git svn fetch` to resume seamlessly, rather than forcing
the user to re-provide the path to the authors file.

Signed-off-by: Alex Vandiver <alex@chmrr.net>
---
 git-svn.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-svn.perl b/git-svn.perl
index cf5e75e..3c3e0e0 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -394,9 +394,9 @@ sub cmd_clone {
 	$path = basename($url) if !defined $path || !length $path;
 	my $authors_absolute = $_authors ? File::Spec->rel2abs($_authors) : "";
 	cmd_init($url, $path);
-	Git::SVN::fetch_all($Git::SVN::default_repo_id);
 	command_oneline('config', 'svn.authorsfile', $authors_absolute)
 	    if $_authors;
+	Git::SVN::fetch_all($Git::SVN::default_repo_id);
 }
 
 sub cmd_init {
-- 
1.6.6.rc0.360.gc408
