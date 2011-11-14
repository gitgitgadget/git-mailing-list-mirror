From: Ted Percival <ted.percival@quest.com>
Subject: [PATCH] svn: Create config options for common args
Date: Mon, 14 Nov 2011 13:25:10 -0700
Message-ID: <1321302310-28793-1-git-send-email-ted.percival@quest.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Eric Wong <normalperson@yhbt.net>,
	Ted Percival <ted.percival@quest.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 21:25:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RQ36F-0005b9-DW
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 21:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210Ab1KNUZt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 15:25:49 -0500
Received: from alvetxw01.quest.com ([12.106.87.93]:24077 "EHLO
	alvetxw01.quest.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756206Ab1KNUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 15:25:47 -0500
Received: from ALVHTXW01.prod.quest.corp (10.1.135.17) by alvetxw01.quest.com
 (10.1.100.93) with Microsoft SMTP Server (TLS) id 14.1.255.0; Mon, 14 Nov
 2011 12:18:50 -0800
Received: from slc21znqg1.ipv6.vintela.com (10.1.0.6) by
 ALVHTXW01.prod.quest.corp (10.1.135.27) with Microsoft SMTP Server id
 14.1.255.0; Mon, 14 Nov 2011 12:25:46 -0800
Received: from ted by slc21znqg1.ipv6.vintela.com with local (Exim 4.72)
	(envelope-from <ted@slc21znqg1.prod.quest.corp>)	id 1RQ36A-0007V7-5I; Mon, 14
 Nov 2011 13:25:46 -0700
X-Mailer: git-send-email 1.7.7.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185397>

These config options may be set to apply to all commands on the
repository in lieu of providing the command-line options each time:
  svn.localtime: --localtime
  svn.useLogAuthor: --use-log-author
  svn.addAuthorFrom: --add-author-from

Since these flags apply to multiple operations, it's easier to set them
once rather than remembering to use them every time for every operation.

Signed-off-by: Ted Percival <ted.percival@quest.com>
---
 Documentation/git-svn.txt |   10 ++++++++++
 git-svn.perl              |    3 +++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 34ee785..20f8edd 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -113,6 +113,9 @@ repository you cloned from, but if you wish for your local Git
 repository to be able to interoperate with someone else's local Git
 repository, either don't use this option or you should both use it in
 the same local timezone.
++
+[verse]
+config key: svn.localtime
 
 --parent;;
 	Fetch only from the SVN parent of the current HEAD.
@@ -596,12 +599,19 @@ creating the branch or tag.
 	When retrieving svn commits into git (as part of 'fetch', 'rebase', or
 	'dcommit' operations), look for the first `From:` or `Signed-off-by:` line
 	in the log message and use that as the author string.
++
+[verse]
+config key: svn.useLogAuthor
+
 --add-author-from::
 	When committing to svn from git (as part of 'commit-diff', 'set-tree' or 'dcommit'
 	operations), if the existing log message doesn't already have a
 	`From:` or `Signed-off-by:` line, append a `From:` line based on the
 	git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
++
+[verse]
+config key: svn.addAuthorFrom
 
 
 ADVANCED OPTIONS
diff --git a/git-svn.perl b/git-svn.perl
index e30df22..d69b0d7 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -21,6 +21,9 @@ $Git::SVN::default_repo_id = 'svn';
 $Git::SVN::default_ref_id = $ENV{GIT_SVN_ID} || 'git-svn';
 $Git::SVN::Ra::_log_window_size = 100;
 $Git::SVN::_minimize_url = 'unset';
+$Git::SVN::_localtime = Git::config_bool('svn.localtime');
+$Git::SVN::_add_author_from = Git::config_bool('svn.addAuthorFrom');
+$Git::SVN::_use_log_author = Git::config_bool('svn.useLogAuthor');
 
 if (! exists $ENV{SVN_SSH} && exists $ENV{GIT_SSH}) {
 	$ENV{SVN_SSH} = $ENV{GIT_SSH};
-- 
1.7.7.1
