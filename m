From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Improve and fix git-check-attr(1)
Date: Mon, 13 Oct 2008 19:57:05 +0200
Message-ID: <20081013175705.GA9538@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 20:00:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpRgW-00074H-63
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 19:58:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754700AbYJMR5L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2008 13:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754662AbYJMR5L
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Oct 2008 13:57:11 -0400
Received: from mgw1.diku.dk ([130.225.96.91]:43344 "EHLO mgw1.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754524AbYJMR5J (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2008 13:57:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw1.diku.dk (Postfix) with ESMTP id F00D152C32A;
	Mon, 13 Oct 2008 19:57:06 +0200 (CEST)
X-Virus-Scanned: amavisd-new at diku.dk
Received: from mgw1.diku.dk ([127.0.0.1])
	by localhost (mgw1.diku.dk [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ViXa9DNfYbd7; Mon, 13 Oct 2008 19:57:05 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw1.diku.dk (Postfix) with ESMTP id A2EB752C320;
	Mon, 13 Oct 2008 19:57:05 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id AE1416DFB75; Mon, 13 Oct 2008 19:56:03 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 88F641A4001; Mon, 13 Oct 2008 19:57:05 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98134>

Always use 'verse' for multi-line synopsis sections. Add output and
example sections to document what output can be expected.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
 Documentation/git-check-attr.txt |   63 +++++++++++++++++++++++++++++++++++++-
 1 files changed, 62 insertions(+), 1 deletions(-)

 At least the first chunk should be applied. The last is a quick attempt
 at documenting the expected output formally and with examples.

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 14e4374..09c5234 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -8,8 +8,9 @@ git-check-attr - Display gitattributes information.
 
 SYNOPSIS
 --------
+[verse]
 'git check-attr' attr... [--] pathname...
-'git check-attr' --stdin [-z] attr... < <list-of-paths
+'git check-attr' --stdin [-z] attr... < <list-of-paths>
 
 DESCRIPTION
 -----------
@@ -30,6 +31,66 @@ OPTIONS
 	arguments as path names. If not supplied, only the first argument will
 	be treated as an attribute.
 
+OUTPUT
+------
+
+The output is of the form:
+<path> COLON SP <attribute> COLON SP <info> LF
+
+Where <path> is the path of a file being queried, <attribute> is an attribute
+being queried and <info> can be either:
+
+'unspecified';; when the attribute is not defined for the path.
+'unset';; when the attribute is defined to false.
+'set';; when the attribute is defined to true.
+<value>;; when a value has been assigned to the attribute.
+
+EXAMPLES
+--------
+
+In the following examples, the following '.gitattributes' file is used:
+---------------
+*.java diff=java -crlf myAttr
+README caveat=unspecified
+---------------
+
+* Output for an unspecified attribute:
+---------------
+$ git check-attr filter src/org/example/lib/MyClass.java
+src/org/example/lib/MyClass.java: filter: unspecified
+---------------
+
+* Output for an unset attribute:
+---------------
+$ git check-attr crlf src/org/example/lib/MyClass.java
+src/org/example/lib/MyClass.java: crlf: unset
+---------------
+
+* Output for an attribute that has been set:
+---------------
+$ git check-attr myAttr src/org/example/lib/MyClass.java
+src/org/example/lib/MyClass.java: myAttr: set
+---------------
+
+* Output for an attribute set to a value:
+---------------
+$ git check-attr diff src/org/example/lib/MyClass.java
+src/org/example/lib/MyClass.java: diff: java
+---------------
+
+* Listing multiple attributes for a file:
+---------------
+$ git check-attr crlf diff myAttr -- src/org/example/lib/MyClass.java
+src/org/example/lib/MyClass.java: crlf: unset
+src/org/example/lib/MyClass.java: diff: java
+src/org/example/lib/MyClass.java: myAttr: set
+---------------
+
+* Not all values are equally unambiguous:
+---------------
+$ git check-attr caveat README
+src/org/example/lib/MyClass.java: caveat: unspecified
+---------------
 
 SEE ALSO
 --------
-- 
tg: (340fcf4..) jf/man-git-check-attr (depends on: next)

-- 
Jonas Fonseca
