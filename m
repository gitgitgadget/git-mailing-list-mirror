From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Fix usage of carets in git-rev-parse(1)
Date: Thu, 6 Oct 2005 01:42:23 +0200
Message-ID: <20051005234222.GA19292@diku.dk>
References: <200510052350.07217.alan@chandlerfamily.org.uk> <7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alan Chandler <alan@chandlerfamily.org.uk>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 06 01:44:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ENIuW-00052W-Gz
	for gcvg-git@gmane.org; Thu, 06 Oct 2005 01:42:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030446AbVJEXm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 19:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbVJEXm0
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 19:42:26 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:13305 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1030446AbVJEXmY (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Oct 2005 19:42:24 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id A4CA56E1B8C; Thu,  6 Oct 2005 01:42:15 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 423B76E1B4A; Thu,  6 Oct 2005 01:42:15 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id 407A060F4C; Thu,  6 Oct 2005 01:42:23 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v7jcrh7wu.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6i
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9748>

... but using a {caret} attribute.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

Junio C Hamano <junkio@cox.net> wrote Wed, Oct 05, 2005:
> Alan Chandler <alan@chandlerfamily.org.uk> writes:
> 
> > "A  suffix  ~<n>  to  a  revision parameter means the commit object that is 
> > the <n>th generation grand-parent of the named commit object, following only 
> > the first parent. I.e. rev~3 is equivalent to rev^ which is equivalent to 
> > rev11^1."
> >
> > Why is rev~3 equivalent to rev^,  surely it is equivalent to rev^^^
> >
> > Why is rev~3 equivalent to rev11^1, should that not be rev^1^1^1
> 
> Sorry, for not knowing how to do that properly in Asciidoc ;-).

I think something like the following will do ...

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -7,6 +7,9 @@
 # Show GIT link as: <command>(<section>); if section is defined, else just show
 # the command.
 
+[attributes]
+caret=^
+
 ifdef::backend-docbook[]
 [gitlink-inlinemacro]
 {0%{target}}
@@ -19,3 +22,5 @@ ifdef::backend-xhtml11[]
 [gitlink-inlinemacro]
 <a href="{target}.html">{target}{0?({0})}</a>
 endif::backend-xhtml11[]
+
+
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -54,13 +54,13 @@ OPTIONS
 	`git-diff-\*`).
 
 --not::
-	When showing object names, prefix them with '^' and
-	strip '^' prefix from the object names that already have
+	When showing object names, prefix them with '{caret}' and
+	strip '{caret}' prefix from the object names that already have
 	one.
 
 --symbolic::
 	Usually the object names are output in SHA1 form (with
-	possible '^' prefix); this option makes them output in a
+	possible '{caret}' prefix); this option makes them output in a
 	form as close to the original input as possible.
 
 
@@ -93,22 +93,23 @@ what is called an 'extended SHA1' syntax
   happen to have both heads/master and tags/master, you can
   explicitly say 'heads/master' to tell GIT which one you mean.
 
-* A suffix '^' to a revision parameter means the first parent of
-  that commit object.  '^<n>' means the <n>th parent (i.e.
-  'rev^'
-  is equivalent to 'rev^1').  As a special rule,
-  'rev^0' means the commit itself and is used when 'rev' is the
+* A suffix '{caret}' to a revision parameter means the first parent of
+  that commit object.  '{caret}<n>' means the <n>th parent (i.e.
+  'rev{caret}'
+  is equivalent to 'rev{caret}1').  As a special rule,
+  'rev{caret}0' means the commit itself and is used when 'rev' is the
   object name of a tag object that refers to a commit object.
 
 * A suffix '~<n>' to a revision parameter means the commit
   object that is the <n>th generation grand-parent of the named
   commit object, following only the first parent.  I.e. rev~3 is
-  equivalent to rev^^^ which is equivalent to rev^1^1^1.
+  equivalent to rev{caret}{caret}{caret} which is equivalent to\
+  rev{caret}1{caret}1{caret}1.
 
-'git-rev-parse' also accepts a prefix '^' to revision parameter,
+'git-rev-parse' also accepts a prefix '{caret}' to revision parameter,
 which is passed to 'git-rev-list'.  Two revision parameters
 concatenated with '..' is a short-hand for writing a range
-between them.  I.e. 'r1..r2' is equivalent to saying '^r1 r2'
+between them.  I.e. 'r1..r2' is equivalent to saying '{caret}r1 r2'
 
 
 Author
-- 
Jonas Fonseca
