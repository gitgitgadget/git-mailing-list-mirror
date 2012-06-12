From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH/RFC] git-svn: forward -q to git-rebase
Date: Tue, 12 Jun 2012 17:18:40 +0200
Message-ID: <1339514320-28610-1-git-send-email-kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 12 18:12:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeTht-0006U9-N0
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 18:12:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752398Ab2FLQMe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 12:12:34 -0400
Received: from [77.40.159.131] ([77.40.159.131]:43367 "EHLO rh5test.hue.no"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751306Ab2FLQMd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 12:12:33 -0400
X-Greylist: delayed 3252 seconds by postgrey-1.27 at vger.kernel.org; Tue, 12 Jun 2012 12:12:33 EDT
Received: from rh5test.hue.no (rh5test.hue.no [127.0.0.1])
	by rh5test.hue.no (8.13.8/8.13.8) with ESMTP id q5CFIese028644
	for <git@vger.kernel.org>; Tue, 12 Jun 2012 17:18:40 +0200
Received: (from erik@localhost)
	by rh5test.hue.no (8.13.8/8.13.8/Submit) id q5CFIejL028643
	for git@vger.kernel.org; Tue, 12 Jun 2012 17:18:40 +0200
X-Authentication-Warning: rh5test.hue.no: erik set sender to kusmabite@gmail.com using -f
X-Mailer: git-send-email 1.7.11.rc2.5.g68f532f.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199808>

When calling "git svn rebase -q", we still get the message
"Current branch BRANCHNAME is up to date." from git-rebase, which
isn't quite as quiet as we could be.

Fix this by forwarding the -q flag to git-rebase.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---

I just set up a cronjob that did a "git svn rebase -q", and noticed
it triggered cron to send me an e-mail every time.

Since I'm not really interested in getting an e-mail every time the
script does nothing, but I'd like the option to get an e-mail whenever
it does something useful, perhaps something like this can benefit
other people as well?

 git-svn.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-svn.perl b/git-svn.perl
index 0b074c4..34baa43 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -1590,6 +1590,7 @@ sub cmd_gc {
 sub rebase_cmd {
 	my @cmd = qw/rebase/;
 	push @cmd, '-v' if $_verbose;
+	push @cmd, '-q' if $_q;
 	push @cmd, qw/--merge/ if $_merge;
 	push @cmd, "--strategy=$_strategy" if $_strategy;
 	push @cmd, "--preserve-merges" if $_preserve_merges;
-- 
1.7.11.rc2.5.g68f532f.dirty
