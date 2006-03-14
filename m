From: Mark Hollomon <markhollomon@comcast.net>
Subject: [PATCH] Use resolve in git-pull if NO_PYTHON
Date: Tue, 14 Mar 2006 17:16:04 +0000 (UTC)
Message-ID: <1142356355-4772-markhollomon@comcast.net>
X-From: git-owner@vger.kernel.org Tue Mar 14 18:16:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJD4G-0007zd-Ee
	for gcvg-git@gmane.org; Tue, 14 Mar 2006 18:12:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751021AbWCNRMQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Mar 2006 12:12:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752305AbWCNRMQ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Mar 2006 12:12:16 -0500
Received: from sccrmhc14.comcast.net ([63.240.77.84]:24251 "EHLO
	sccrmhc14.comcast.net") by vger.kernel.org with ESMTP
	id S1751021AbWCNRMP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Mar 2006 12:12:15 -0500
Received: from [10.0.0.3] (c-69-249-27-188.hsd1.de.comcast.net[69.249.27.188])
          by comcast.net (sccrmhc14) with SMTP
          id <20060314171214014000oghne>; Tue, 14 Mar 2006 17:12:14 +0000
Date: Tue, Mar 14 12:12:35 2006 -0500
To: git@vger.kernel.org
User-Agent: send_patch 0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17591>

git-pull is hardcoded to use the recursive merge strategy
for the twohead case. But if git has been built with NO_PYTHON,
that strategy is not available. Teach git-pull to use resolve
if built with NO_PYTHON.

Signed-off-by: Mark Hollomon <markhollomon@comcast.net>


---

 git-pull.sh |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

1eb3abec6f4811e3eeafa50445ed0f2ce5d85b08
diff --git a/git-pull.sh b/git-pull.sh
index 6caf1aa..ae9c346 100755
--- a/git-pull.sh
+++ b/git-pull.sh
@@ -8,6 +8,11 @@ USAGE='[-n | --no-summary] [--no-commit]
 LONG_USAGE='Fetch one or more remote refs and merge it/them into the current HEAD.'
 . git-sh-setup
 
+default_twohead_strategy='recursive'
+if test "@@NO_PYTHON@@"; then
+    default_twohead_strategy='resolve'
+fi
+
 strategy_args= no_summary= no_commit=
 while case "$#,$1" in 0) break ;; *,-*) ;; *) break ;; esac
 do
@@ -82,7 +87,7 @@ case "$merge_head" in
 	var=`git repo-config --get pull.twohead`
 	if test '' = "$var"
 	then
-		strategy_default_args='-s recursive'
+		strategy_default_args="-s $default_twohead_strategy"
 	else
 		strategy_default_args="-s $var"
 	fi
-- 
1.2.4.g967a
