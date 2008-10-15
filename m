From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH 1/2] git-check-attr(1): add output and example sections
Date: Wed, 15 Oct 2008 09:10:58 +0200
Message-ID: <20081015071058.GA32094@diku.dk>
References: <20081013175705.GA9538@diku.dk> <7vabd6686n.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 15 09:12:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kq0YM-0008Cs-Dc
	for gcvg-git-2@gmane.org; Wed, 15 Oct 2008 09:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751576AbYJOHLE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Oct 2008 03:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751598AbYJOHLD
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Oct 2008 03:11:03 -0400
Received: from mgw2.diku.dk ([130.225.96.92]:55399 "EHLO mgw2.diku.dk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751567AbYJOHLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Oct 2008 03:11:01 -0400
Received: from localhost (localhost [127.0.0.1])
	by mgw2.diku.dk (Postfix) with ESMTP id 9E37719BC5A;
	Wed, 15 Oct 2008 09:10:59 +0200 (CEST)
Received: from mgw2.diku.dk ([127.0.0.1])
 by localhost (mgw2.diku.dk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 30199-08; Wed, 15 Oct 2008 09:10:58 +0200 (CEST)
Received: from nhugin.diku.dk (nhugin.diku.dk [130.225.96.140])
	by mgw2.diku.dk (Postfix) with ESMTP id 503AE19BC59;
	Wed, 15 Oct 2008 09:10:58 +0200 (CEST)
Received: from tyr.diku.dk (tyr.diku.dk [130.225.96.226])
	by nhugin.diku.dk (Postfix) with ESMTP
	id F163E6DF8B9; Wed, 15 Oct 2008 09:09:53 +0200 (CEST)
Received: by tyr.diku.dk (Postfix, from userid 3873)
	id 3B7901A4001; Wed, 15 Oct 2008 09:10:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vabd6686n.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
X-Virus-Scanned: amavisd-new at diku.dk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98242>

Plumbing tools should document what output can be expected.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>
---
 Documentation/git-check-attr.txt |   50 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 50 insertions(+), 0 deletions(-)

 Junio C Hamano <gitster@pobox.com> wrote Tue, Oct 14, 2008:
 > Should this really have to depend on next?

 This is just topgit listing the patch dependencies.

 > Could you split this into two patches, one for 'maint' to describe the
 > output format, and another for 'next' (or 'dp/checkattr') to update the
 > SYNOPSIS part?

 Done. The example has been updated to also show '!' in action.

diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 2b821f2..8460a87 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -22,6 +22,56 @@ OPTIONS
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
+'unset';;	when the attribute is defined to false.
+'set';;		when the attribute is defined to true.
+<value>;;	when a value has been assigned to the attribute.
+
+EXAMPLES
+--------
+
+In the examples, the following '.gitattributes' file is used:
+---------------
+*.java diff=java -crlf myAttr
+NoMyAttr.java !myAttr
+README caveat=unspecified
+---------------
+
+* Listing a single attribute:
+---------------
+$ git check-attr diff org/example/MyClass.java
+org/example/MyClass.java: diff: java
+---------------
+
+* Listing multiple attributes for a file:
+---------------
+$ git check-attr crlf diff myAttr -- org/example/MyClass.java
+org/example/MyClass.java: crlf: unset
+org/example/MyClass.java: diff: java
+org/example/MyClass.java: myAttr: set
+---------------
+
+* Listing attribute for multiple files:
+---------------
+$ git check-attr myAttr -- org/example/MyClass.java org/example/NoMyAttr.java
+org/example/MyClass.java: myAttr: set
+org/example/NoMyAttr.java: myAttr: unspecified
+---------------
+
+* Not all values are equally unambiguous:
+---------------
+$ git check-attr caveat README
+README: caveat: unspecified
+---------------
 
 SEE ALSO
 --------
-- 
tg: (6c16792..) jf/man-git-check-attr-output (depends on: maint)

-- 
Jonas Fonseca
