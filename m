From: Martin Langhoff <martin@catalyst.net.nz>
Subject: [PATCH] cvsserver: use git-rev-list instead of git-log
Date: Thu, 04 May 2006 10:53:37 +1200
Message-ID: <11466968173651-git-send-email-martin@catalyst.net.nz>
References: <Pine.LNX.4.64.0605030745550.4086@g5.osdl.org>
Reply-To: Martin Langhoff <martin@catalyst.net.nz>
Cc: Martin Langhoff <martin@catalyst.net.nz>
X-From: git-owner@vger.kernel.org Thu May 04 00:50:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbQB0-0002LH-U6
	for gcvg-git@gmane.org; Thu, 04 May 2006 00:50:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWECWuP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 May 2006 18:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWECWuP
	(ORCPT <rfc822;git-outgoing>); Wed, 3 May 2006 18:50:15 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:52111 "EHLO
	mail1.catalyst.net.nz") by vger.kernel.org with ESMTP
	id S1751386AbWECWuN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 May 2006 18:50:13 -0400
Received: from leibniz.catalyst.net.nz ([202.78.240.7] helo=mltest)
	by mail1.catalyst.net.nz with esmtp (Exim 4.50)
	id 1FbQAd-0000ER-RQ; Thu, 04 May 2006 10:50:11 +1200
Received: from mltest ([127.0.0.1] helo=localhost.localdomain)
	by mltest with esmtp (Exim 3.36 #1 (Debian))
	id 1FbQDy-00028m-00; Thu, 04 May 2006 10:53:38 +1200
To: git@vger.kernel.org, junkio@cox.net
X-Mailer: git-send-email 1.3.1.g24e1-dirty
In-Reply-To: <Pine.LNX.4.64.0605030745550.4086@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19529>

On 5/4/06, Linus Torvalds <torvalds@osdl.org> wrote:
> No it wasn't. "git log --parents" was definitely supposed to still work.
>
> That said, I suspect a git-cvsserver kind of usage is better off using
> "git-rev-list --parents HEAD" instead, which didn't break in the first
> place.

Signed-off-by: Martin Langhoff <martin@catalyst.net.nz>


---

 git-cvsserver.perl |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

a248c9614fdd130229fb5f9565abbd77bd1d0cc9
diff --git a/git-cvsserver.perl b/git-cvsserver.perl
index 11d153c..ffd9c66 100755
--- a/git-cvsserver.perl
+++ b/git-cvsserver.perl
@@ -2076,14 +2076,15 @@ sub update
     # TODO: log processing is memory bound
     # if we can parse into a 2nd file that is in reverse order
     # we can probably do something really efficient
-    my @git_log_params = ('--parents', '--topo-order');
+    my @git_log_params = ('--pretty', '--parents', '--topo-order');
 
     if (defined $lastcommit) {
         push @git_log_params, "$lastcommit..$self->{module}";
     } else {
         push @git_log_params, $self->{module};
     }
-    open(GITLOG, '-|', 'git-log', @git_log_params) or die "Cannot call git-log: $!";
+    # git-rev-list is the backend / plumbing version of git-log
+    open(GITLOG, '-|', 'git-rev-list', @git_log_params) or die "Cannot call git-rev-list: $!";
 
     my @commits;
 
-- 
1.3.1.g24e1-dirty
