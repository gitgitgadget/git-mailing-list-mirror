From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 3/9] contrib/git-svn: strip 'git-svn-id:' when commiting to SVN
Date: Fri, 3 Mar 2006 01:20:08 -0800
Message-ID: <11413776082010-git-send-email-normalperson@yhbt.net>
References: <114137760733-git-send-email-normalperson@yhbt.net>
Reply-To: Eric Wong <normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 03 10:20:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FF6SN-0003xs-QZ
	for gcvg-git@gmane.org; Fri, 03 Mar 2006 10:20:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752198AbWCCJUN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Mar 2006 04:20:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbWCCJUM
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Mar 2006 04:20:12 -0500
Received: from hand.yhbt.net ([66.150.188.102]:64898 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1752198AbWCCJUI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Mar 2006 04:20:08 -0500
Received: from Muzzle (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id 446537DC022;
	Fri,  3 Mar 2006 01:20:08 -0800 (PST)
In-Reply-To: <114137760733-git-send-email-normalperson@yhbt.net>
X-Mailer: git-send-email
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17140>

We regenerate and use git-svn-id: whenever we fetch or otherwise
commit to remotes/git-svn.  We don't actually know what revision
number we'll commit to SVN at commit time, so this is useless.
It won't throw off things like 'rebuild', though, which knows to
only use the last instance of git-svn-id: in a log message

Signed-off-by: Eric Wong <normalperson@yhbt.net>

---

 contrib/git-svn/git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

15b28ddfc496fa88cffdfddcc9262cae635a34d0
diff --git a/contrib/git-svn/git-svn.perl b/contrib/git-svn/git-svn.perl
index 67368a5..edae9d4 100755
--- a/contrib/git-svn/git-svn.perl
+++ b/contrib/git-svn/git-svn.perl
@@ -625,6 +625,9 @@ sub svn_commit_tree {
 		while (<$msg_fh>) {
 			if (!$in_msg) {
 				$in_msg = 1 if (/^\s*$/);
+			} elsif (/^git-svn-id: /) {
+				# skip this, we regenerate the correct one
+				# on re-fetch anyways
 			} else {
 				print $msg $_ or croak $!;
 			}
-- 
1.2.3.g4676
