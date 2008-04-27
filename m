From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: [updated PATCH] Same default as cvsimport when using --use-log-author
Date: Sun, 27 Apr 2008 19:32:46 +0200
Message-ID: <20080427173246.10023.5687.stgit@aristoteles.cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 19:33:43 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqAku-0005Ea-Ud
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 19:33:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbYD0Rcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 13:32:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755725AbYD0Rcx
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 13:32:53 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:43461 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755924AbYD0Rcv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 13:32:51 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 60948545E; Sun, 27 Apr 2008 19:32:46 +0200 (CEST)
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80460>

When using git-cvsimport, the author is inferred from the cvs commit,
e.g. cvs commit logname is foobaruser, then the author field in git
results in:

Author: foobaruser <foobaruser>

Which is not perfect, but perfectly acceptable given the circumstances.

The default git-svn import however, results in:

Author: foobaruser <foobaruser@acf43c95-373e-0410-b603-e72c3f656dc1>

When using mixes of imports, from CVS and SVN into the same git
repository, you'd like to harmonise the imports to the format cvsimport
uses.
git-svn supports an experimental option --use-log-author which currently
results in:

Author: foobaruser <unknown>

This patches harmonises the result with cvsimport, and makes
git-svn --use-log-author produce:

Author: foobaruser <foobaruser>

Signed-off-by: Stephen R. van den Berg <srb@cuci.nl>
---

 git-svn.perl |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/git-svn.perl b/git-svn.perl
index b151049..846e739 100755
--- a/git-svn.perl
+++ b/git-svn.perl
@@ -2434,6 +2434,9 @@ sub make_log_entry {
 		} else {
 			($name, $email) = ($name_field, 'unknown');
 		}
+	        if (!defined $email) {
+		    $email = $name;
+	        }
 	}
 	if (defined $headrev && $self->use_svm_props) {
 		if ($self->rewrite_root) {
