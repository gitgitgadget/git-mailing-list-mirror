From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 2/2] docs/filter-branch: clean up newsubdir example
Date: Mon, 16 Apr 2012 12:03:00 -0400
Message-ID: <20120416160300.GB1350@sigill.intra.peff.net>
References: <20120416152737.GB14724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Christopher Tiwald <christiwald@gmail.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Apr 16 18:03:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJoOX-0006C8-Ll
	for gcvg-git-2@plane.gmane.org; Mon, 16 Apr 2012 18:03:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526Ab2DPQDG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Apr 2012 12:03:06 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:36326
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751513Ab2DPQDD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2012 12:03:03 -0400
Received: (qmail 25334 invoked by uid 107); 16 Apr 2012 16:03:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 Apr 2012 12:03:11 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Apr 2012 12:03:00 -0400
Content-Disposition: inline
In-Reply-To: <20120416152737.GB14724@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195655>

Over the years, this simple example has ended up quite hard
to read because of the number of special cases that must be
handled. Let's simplify it a bit:

  1. Use the new "index-info --clear" to avoid the need for
     a temporary index.

  2. Use "-z" and "perl -0" to avoid dealing with quoting
     issues. As a bonus, using perl means that "\t" will
     work consistently in regexps (the previous example
     using sed was reported to fail on OS X).

  3. Change the indentation to keep one logical unit per
     line and avoid extra backslash-escaping.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-filter-branch.txt |   10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 0f2f117..3df138f 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -358,11 +358,11 @@ git filter-branch ... D..H --not C
 To move the whole tree into a subdirectory, or remove it from there:
 
 ---------------------------------------------------------------
-git filter-branch --index-filter \
-	'git ls-files -s | sed "s-\t\"*-&newsubdir/-" |
-		GIT_INDEX_FILE=$GIT_INDEX_FILE.new \
-			git update-index --index-info &&
-	 mv "$GIT_INDEX_FILE.new" "$GIT_INDEX_FILE"' HEAD
+git filter-branch --index-filter '
+	git ls-files -sz |
+	perl -0pe "s{\t}{\tnewsubdir/}" |
+	git update-index -z --clear --index-info
+' HEAD
 ---------------------------------------------------------------
 
 
-- 
1.7.9.6.8.g992e5
