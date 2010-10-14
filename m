From: Andreas Gruenbacher <agruen@suse.de>
Subject: Re: [PATCH] Improve the "diff --git" format documentation
Date: Thu, 14 Oct 2010 12:53:11 +0200
Organization: SUSE Labs, Novell Inc.
Message-ID: <201010141253.11640.agruen@suse.de>
References: <201010061823.47475.agruen@suse.de> <201010070103.17689.agruen@suse.de> <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 14 12:53:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6LRW-0007vE-5m
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 12:53:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752545Ab0JNKxp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 06:53:45 -0400
Received: from cantor2.suse.de ([195.135.220.15]:36800 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750976Ab0JNKxo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 06:53:44 -0400
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.221.2])
	by mx2.suse.de (Postfix) with ESMTP id 6CA3A8655F;
	Thu, 14 Oct 2010 12:53:43 +0200 (CEST)
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <7v8w21fsgr.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159046>

On Thursday 14 October 2010 03:55:48 Junio C Hamano wrote:
> [some more objections]

Okay, here are the changes we seem to be able to agree on.  Let's address the 
rest separately.

Andreas

--

[PATCH] Clarify and extend the "git diff" format documentation

Move the similarity and dissimilarity index header description closer to
where those extended headers are described.

Describe and/or clarify the format used for file modes, pathnames, and
the index header.

Document that all "old" files refer to the state before applying the
*entire* output, and all "new" files refer to the state thereafter.

Signed-off-by: Andreas Gruenbacher <agruen@suse.de>
---
 Documentation/diff-generate-patch.txt |   40 ++++++++++++++++++++++++--------
 1 files changed, 30 insertions(+), 10 deletions(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-
generate-patch.txt
index 8f9a241..3ac2bea 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -9,16 +9,15 @@ patch file.  You can customize the creation of such patches 
via the
 GIT_EXTERNAL_DIFF and the GIT_DIFF_OPTS environment variables.
 
 What the -p option produces is slightly different from the traditional
-diff format.
+diff format:
 
-1.   It is preceded with a "git diff" header, that looks like
-     this:
+1.   It is preceded with a "git diff" header that looks like this:
 
        diff --git a/file1 b/file2
 +
 The `a/` and `b/` filenames are the same unless rename/copy is
 involved.  Especially, even for a creation or a deletion,
-`/dev/null` is _not_ used in place of `a/` or `b/` filenames.
+`/dev/null` is _not_ used in place of the `a/` or `b/` filenames.
 +
 When rename/copy is involved, `file1` and `file2` show the
 name of the source file of the rename/copy and the name of
@@ -37,18 +36,39 @@ the file that rename/copy produces, respectively.
        similarity index <number>
        dissimilarity index <number>
        index <hash>..<hash> <mode>
-
-3.  TAB, LF, double quote and backslash characters in pathnames
-    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
-    If there is need for such substitution then the whole
-    pathname is put in double quotes.
-
++
+File modes are printed as 6-digit octal numbers including the file type
+and file permission bits.
++
+Path names in extended headers do not include the `a/` and `b/` prefixes.
++
 The similarity index is the percentage of unchanged lines, and
 the dissimilarity index is the percentage of changed lines.  It
 is a rounded down integer, followed by a percent sign.  The
 similarity index value of 100% is thus reserved for two equal
 files, while 100% dissimilarity means that no line from the old
 file made it into the new one.
++
+The index line includes the SHA-1 checksum before and after the change.
+The <mode> is included if the file mode does not change; otherwise,
+separate lines indicate the old and the new mode.
+
+3.  TAB, LF, double quote and backslash characters in pathnames
+    are represented as `\t`, `\n`, `\"` and `\\`, respectively.
+    If there is need for such substitution then the whole
+    pathname is put in double quotes.
+
+4.  All the `file1` files in the output refer to files before the
+    commit, and all the `file2` files refer to files after the commit.
+    It is incorrect to apply each change to each file sequentially.  For
+    example, this patch will swap a and b:
+
+      diff --git a/a b/b
+      rename from a
+      rename to b
+      diff --git a/b b/a
+      rename from b
+      rename to a
 
 
 combined diff format
