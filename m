From: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH] git for each ref improve the documentation on scripting modes
Date: Thu, 21 Sep 2006 10:19:17 +0100
Message-ID: <20060921091917.GA6373@shadowen.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Sep 21 11:19:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQKie-0003Lg-2v
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 11:19:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751077AbWIUJTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 05:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWIUJTl
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 05:19:41 -0400
Received: from 85-210-218-110.dsl.pipex.com ([85.210.218.110]:57016 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S1751076AbWIUJTk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 05:19:40 -0400
Received: from apw by localhost.localdomain with local (Exim 4.63)
	(envelope-from <apw@shadowen.org>)
	id 1GQKiD-0001es-Oa; Thu, 21 Sep 2006 10:19:17 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27471>

git-for-each-ref: improve the documentation on scripting modes

When reading the synopsis for git-for-each-ref it is easy to miss
the obvious power of --shell and family.  Call this feature out in
the primary paragragh.  Also add more description to the examples
to indicate which features we are demonstrating.  Finally add a
very simple eval based example in addition to the very complex one
to give a gentler introduction.

Signed-off-by: Andy Whitcroft <apw@shadowen.org>
---
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 6649f79..d5fdcef 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -17,7 +17,7 @@ according to the given `<format>`, after
 to the given set of `<key>`s.  If `<max>` is given, stop after
 showing that many refs.  The interporated values in `<format>`
 can optionally be quoted as string literals in the specified
-host language.
+host language allowing their direct evaluation in that language.
 
 OPTIONS
 -------
@@ -97,7 +97,8 @@ returns an empty string instead.
 EXAMPLES
 --------
 
-Show the most recent 3 tagged commits::
+An example directly producing formatted text.  Show the most recent
+3 tagged commits::
 
 ------------
 #!/bin/sh
@@ -112,7 +113,23 @@ Ref: %(*refname)
 ' 'refs/tags'
 ------------
 
-A bit more elaborate report on tags::
+
+A simple example showing the use of shell eval on the output,
+demonstrating the use of --shell.  List the prefixes of all heads::
+------------
+#!/bin/sh
+
+git-for-each-ref --shell --format="ref=%(refname)" refs/heads | \
+while read entry
+do
+	eval "$entry"
+	echo `dirname $ref`
+done
+------------
+
+
+A bit more elaborate report on tags, demonstrating that the format
+may be an entire script::
 ------------
 #!/bin/sh
 
@@ -156,7 +173,7 @@ Its message reads as:
 	fi
 '
 
-eval=`git-for-each-ref -s --format="$fmt" \
+eval=`git-for-each-ref --shell --format="$fmt" \
 	--sort='*objecttype' \
 	--sort=-taggerdate \
 	refs/tags`
