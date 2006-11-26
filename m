X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: "J. Bruce Fields" <bfields@fieldses.org>
Subject: [PATCH] Documentation: add a "git user's manual"
Date: Sat, 25 Nov 2006 23:01:42 -0500
Message-ID: <20061126040142.GB3782@fieldses.org>
References: <20061116221701.4499.qmail@science.horizon.com> <20061117153246.GA20065@thunk.org> <20061117182157.GC11882@fieldses.org> <20061119175040.GB15608@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 26 Nov 2006 04:02:03 +0000 (UTC)
Cc: Theodore Tso <tytso@mit.edu>, linux@horizon.com,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061119175040.GB15608@fieldses.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32326>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoBDF-0004cY-I4 for gcvg-git@gmane.org; Sun, 26 Nov
 2006 05:01:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967290AbWKZEBt (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 23:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967291AbWKZEBt
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 23:01:49 -0500
Received: from mail.fieldses.org ([66.93.2.214]:37056 "EHLO
 pickle.fieldses.org") by vger.kernel.org with ESMTP id S967290AbWKZEBs (ORCPT
 <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 23:01:48 -0500
Received: from bfields by pickle.fieldses.org with local (Exim 4.63)
 (envelope-from <bfields@fieldses.org>) id 1GoBD4-0001b3-TJ; Sat, 25 Nov 2006
 23:01:42 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Sun, Nov 19, 2006 at 12:50:40PM -0500, J. Bruce Fields wrote:
> In fact, I'm tempted to submit a patch that just assigns a chapter
> number to everything under Documentation/, slaps a single table of
> contents on the front, and calls the result "the git user's manual."

Something like this, as a start?:


Add a manual.txt file which generates a "git user's manual" by including
a bunch of preexisting files under Documentation and declaring each to
be a chapter.

The result is a disorganized mess, because the documentation itself is a
disorganized mess.  This is intended to call attention to that fact
rather than fix it.  Hopefully we can massage it into a better order
over time.  And hopefully we can encourage anyone that adds new
documentation to think about where in the order it should be inserted.

Not built or installed by default for now.

Signed-off-by: J. Bruce Fields <bfields@citi.umich.edu>
---
 Documentation/Makefile    |    7 ++++++-
 Documentation/manual.conf |    2 ++
 Documentation/manual.txt  |   30 ++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+), 1 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index c00f5f6..684dacf 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -85,9 +85,14 @@ clean:
 %.1 %.7 : %.xml
 	xmlto -m callouts.xsl man $<
 
-%.xml : %.txt
+%.html : %.txt
 	asciidoc -b docbook -d manpage -f asciidoc.conf $<
 
+manual.html: manual.txt
+	a2x -f xhtml --no-icons --asciidoc-opts="-d book -f asciidoc.conf" $<
+
+# a2x -f xhtml --ascidoc-opts="-d book -f asciidoc.conf" $<
+
 git.html: git.txt README
 
 glossary.html : glossary.txt sort_glossary.pl
diff --git a/Documentation/manual.conf b/Documentation/manual.conf
new file mode 100644
index 0000000..0d0cfad
--- /dev/null
+++ b/Documentation/manual.conf
@@ -0,0 +1,2 @@
+[titles]
+underlines="__","==","--","~~","^^"
diff --git a/Documentation/manual.txt b/Documentation/manual.txt
new file mode 100644
index 0000000..5512212
--- /dev/null
+++ b/Documentation/manual.txt
@@ -0,0 +1,30 @@
+Git User's manual
+_________________
+
+include::tutorial.txt[]
+
+include::tutorial-2.txt[]
+
+Git design overview
+===================
+
+include::README[]
+
+include::everyday.txt[]
+
+include::cvs-migration.txt[]
+
+include::howto-index.txt[]
+
+include::hooks.txt[]
+
+include::diffcore.txt[]
+
+include::repository-layout.txt[]
+
+include::core-tutorial.txt[]
+
+Glossary of git terms
+=====================
+
+include::glossary.txt[]
-- 
1.4.4.rc1.g83ee9
