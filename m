From: Johan Herland <johan@herland.net>
Subject: [PATCH 4/6] Documentation/git-mktag: Document the changes in tag
 object structure
Date: Mon, 04 Jun 2007 02:54:13 +0200
Message-ID: <200706040254.13631.johan@herland.net>
References: <200706040251.05286.johan@herland.net>
 <200706040251.52613.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 02:54:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv0q1-00025C-9L
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 02:54:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbXFDAyR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 20:54:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751340AbXFDAyR
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 20:54:17 -0400
Received: from smtp.getmail.no ([84.208.20.33]:33698 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751289AbXFDAyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 20:54:16 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-009-z2.isp.get.no by
 no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JJ300J016IF4W00@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:15 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-009-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300EAX6IDJW20@no-osl-m323-srv-009-z2.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:14 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JJ300JZT6IDQ210@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Mon, 04 Jun 2007 02:54:13 +0200 (CEST)
In-reply-to: <200706040251.52613.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49057>

The new structure of tag objects is documented.

Also some much-needed cleanup is done. E.g. remove the paragraph on the
8kB limit, since this limit was removed ages ago.

Signed-off-by: Johan Herland <johan@herland.net>
---
 Documentation/git-mktag.txt |   42 ++++++++++++++++++++++++++++++------------
 1 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 2860a3d..411105d 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -8,40 +8,58 @@ git-mktag - Creates a tag object
 
 SYNOPSIS
 --------
-'git-mktag' < signature_file
+[verse]
+'git-mktag' < tag_data_file
+
 
 DESCRIPTION
 -----------
-Reads a tag contents on standard input and creates a tag object
+Reads tag object data on standard input and creates a tag object
 that can also be used to sign other objects.
 
 The output is the new tag's <object> identifier.
 
-Tag Format
+
+DISCUSSION
 ----------
-A tag signature file has a very simple fixed format: three lines of
+Tag object data has the following format
 
+[verse]
   object <sha1>
   type <typename>
-  tag <tagname>
+  tag <tagname>               (optional)
+  keywords <keywords>         (optional)
+  tagger <committer>
+
+followed by a blank line and a free-form message and an optional signature
+that git itself doesn't care about, but that may be verified with gpg or
+similar.
 
-followed by some 'optional' free-form signature that git itself
-doesn't care about, but that can be verified with gpg or similar.
+In the above listing, `<sha1>` represents the object pointed to by this tag,
+`<typename>` is the type of the object pointed to ("tag", "blob", "tree" or
+"commit"), `<tagname>` is the name of this tag object (and must correspond
+to the name of the corresponding ref (if any) in `.git/refs/`). `<keywords>`
+is a comma-separated list of keywords associated with this tag object, and
+`<committer>` holds the "`name <email>`" of the tag creator and timestamp
+of when the tag object was created (analogous to "committer" in commit
+objects).
 
-The size of the full object is artificially limited to 8kB.  (Just
-because I'm a lazy bastard, and if you can't fit a signature in that
-size, you're doing something wrong)
+If "`tag <tagname>`" is omitted, <tagname> defaults to the empty string.
+If "`keywords <keywords>`" is omitted, <keywords> defaults to "`tag`" if
+a <tagname> was given, "`note`" otherwise.
 
 
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>
 
+
 Documentation
 --------------
-Documentation by David Greaves, Junio C Hamano and the git-list <git@vger.kernel.org>.
+Documentation by Johan Herland, David Greaves, Junio C Hamano and the
+git-list <git@vger.kernel.org>.
+
 
 GIT
 ---
 Part of the gitlink:git[7] suite
-
-- 
1.5.2
