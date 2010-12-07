From: Jeff King <peff@peff.net>
Subject: [BUG] yet another doc formatting problem
Date: Tue, 7 Dec 2010 00:07:38 -0500
Message-ID: <20101207050737.GA32485@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 07 06:07:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPpmM-0007qy-IC
	for gcvg-git-2@lo.gmane.org; Tue, 07 Dec 2010 06:07:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750930Ab0LGFHt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Dec 2010 00:07:49 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:58185 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754Ab0LGFHs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Dec 2010 00:07:48 -0500
Received: (qmail 20404 invoked by uid 111); 7 Dec 2010 05:07:45 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Dec 2010 05:07:45 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Dec 2010 00:07:38 -0500
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163067>

When I build git-rm.1, some of the headings look odd. For example:

   Using  git commit -a""
          If you intend that your next commit should record...
   ...
   Using  git add -A""
          When accepting a new code drop for a vendor branch

Note the funny double-space and the weird "" at the end. I get the same
thing from "git show origin/man:man1/git-rm.1 | nroff -man".

The source looks like this:

  $ git grep -A1 Using..git.commit git-rm.txt
  git-rm.txt:Using "git commit -a"
  git-rm.txt-~~~~~~~~~~~~~~~~~~~~~

which looks sane to me. The generated xml also looks OK to me:

  $ grep Using..git.commit git-rm.xml
  <title>Using "git commit -a"</title>

But the resulting roff doesn't:

  $ grep Using..git.commit git-rm.1
  .SS "Using "git commit \-a""

which looks like a quoting error to me, which implies a bug in docbook.

I guess we can hack around it with some XSL magic, but I am tempted to
do the simple:

diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 71e3d9f..8ee559b 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -89,8 +89,8 @@ the paths that have disappeared from the filesystem. However,
 depending on the use case, there are several ways that can be
 done.
 
-Using "git commit -a"
-~~~~~~~~~~~~~~~~~~~~~
+Using git commit -a
+~~~~~~~~~~~~~~~~~~~
 If you intend that your next commit should record all modifications
 of tracked files in the working tree and record all removals of
 files that have been removed from the working tree with `rm`
@@ -98,8 +98,8 @@ files that have been removed from the working tree with `rm`
 automatically notice and record all removals.  You can also have a
 similar effect without committing by using `git add -u`.
 
-Using "git add -A"
-~~~~~~~~~~~~~~~~~~
+Using git add -A
+~~~~~~~~~~~~~~~~
 When accepting a new code drop for a vendor branch, you probably
 want to record both the removal of paths and additions of new paths
 as well as modifications of existing paths.

-Peff
