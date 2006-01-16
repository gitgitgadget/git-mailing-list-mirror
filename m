From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] stgit: make tutorial a valid asciidoc article
Date: Mon, 16 Jan 2006 17:37:48 -0500
Message-ID: <1137451068.5043.19.camel@dv>
References: <1137142486.20073.77.camel@dv>
	 <b0943d9e0601160021t3b40ba3fp@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:38:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eycz9-00078V-2E
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 23:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbWAPWh4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 17:37:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751239AbWAPWh4
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 17:37:56 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:18327 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751238AbWAPWhz
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 17:37:55 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1EycwJ-0005fT-MY
	for git@vger.kernel.org; Mon, 16 Jan 2006 17:35:03 -0500
Received: from proski by dv.roinet.com with local (Exim 4.60)
	(envelope-from <proski@dv.roinet.com>)
	id 1Eycyz-0001eU-1S; Mon, 16 Jan 2006 17:37:49 -0500
To: Catalin Marinas <catalin.marinas@gmail.com>
In-Reply-To: <b0943d9e0601160021t3b40ba3fp@mail.gmail.com>
X-Mailer: Evolution 2.5.4 (2.5.4-6) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14763>

On Mon, 2006-01-16 at 08:21 +0000, Catalin Marinas wrote:
> On 13/01/06, Pavel Roskin <proski@gnu.org> wrote:
> > There should be only one level 0 title in an article, so lower ranks of
> > all headers by one.  Make capitalization uniform in the headers - level
> > 1 is capitalized, but level 2 is not.  Create a new level 1 part
> > "Technical Information".
> >
> > Make ".git/ Directory Structure" a level 2 header and rephrase.
> > asciidoc doesn't like headers starting with a dot.
> 
> I agree with most of this but what's the difference when adding "~~~~"
> instead of "----"?

An article can only have one level 0 title, which is underlined by
"====".  There may be more than one level 0 title in a book, but we
probably shouldn't do it.  Books have page breaks and table of contents
for every level 0 title.

This means that the existing hierarchy should be moved one step down.
Level 1 uses "----" and level 2 uses "~~~~".  I guess your objection is
that the visual distinction between level 1 and level 2 is insignificant
in the original ASCII file.  I agree.

It's possible to override the underline rules by placing asciidoc.conf
in the same directory as the document.  I think "####" would be just
fine for the level 0.  Then we can keep the rest.

Also, I've added a makefile.  It's not used by default, but those who
want to read a tutorial, can generate it in html or pdf format.

Here's the new patch.
---

Make tutorial a valid asciidoc article.

From: Pavel Roskin <proski@gnu.org>

There should be only one level 0 title, so redefine underline rules in
asciidoc.conf to keep the existing underlines when possible.  Form a new
level 1 part "Technical Information" from the text at the end.  Make
introduction a preamble - it's too short to be a level 1 section.

Add doc/Makefile to process the tutorial automatically.  make needs to
be run explicitly in the doc directory.

Signed-off-by: Pavel Roskin <proski@gnu.org>
---

 doc/Makefile      |   17 +++++++++++++++++
 doc/asciidoc.conf |    3 +++
 doc/tutorial.txt  |   14 ++++++++------
 3 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/doc/Makefile b/doc/Makefile
new file mode 100644
index 0000000..07704b8
--- /dev/null
+++ b/doc/Makefile
@@ -0,0 +1,17 @@
+DOCS = tutorial.txt
+DOCS_HTML = $(DOCS:.txt=.html)
+DOCS_PDF = $(DOCS:.txt=.pdf)
+
+all: $(DOCS_HTML) $(DOCS_PDF)
+
+%.html: %.txt
+	asciidoc $<
+
+%.xml: %.txt
+	asciidoc --backend=docbook $<
+
+%.pdf: %.xml
+	xmlto pdf $<
+
+clean:
+	rm -f *.xml *.html *.pdf
diff --git a/doc/asciidoc.conf b/doc/asciidoc.conf
new file mode 100644
index 0000000..5b8d95f
--- /dev/null
+++ b/doc/asciidoc.conf
@@ -0,0 +1,3 @@
+[titles]
+underlines="##","==","--","~~","^^"
+
diff --git a/doc/tutorial.txt b/doc/tutorial.txt
index 7183e41..5899c38 100644
--- a/doc/tutorial.txt
+++ b/doc/tutorial.txt
@@ -1,8 +1,6 @@
 StGIT Tutorial
-==============
+##############
 
-Introduction
-------------
 
 StGIT is a Python application that provides functionality similar to
 quilt (i.e. pushing/popping patches to/from a stack) using GIT instead
@@ -334,8 +332,11 @@ result in an empty patch (StGIT notifyin
 deleted.
 
 
-A Bit of StGIT Patch Theory
-===========================
+Technical Information
+=====================
+
+A bit of StGIT patch theory
+---------------------------
 
 We assume that a patch is a diff between two nodes - bottom and top. A
 node is a commit SHA1 id or tree SHA1 id in the GIT terminology:
@@ -374,8 +375,9 @@ The above operation allows easy patch re
 Removing (popping) a patch from the stack is done by simply setting the
 Nst to Nb.
 
-.git/ Directory Structure
 
+Layout of the .git directory
+----------------------------
 
   HEAD			-> refs/heads/<something>
   objects/


-- 
Regards,
Pavel Roskin
