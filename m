From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] pre-commit.sample: don't use [...] around a tr range
Date: Mon, 21 Sep 2009 11:09:49 +0200
Message-ID: <871vm0k6jm.fsf@meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 21 11:10:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpeuK-0000Ql-Fi
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 11:10:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755703AbZIUJJy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 05:09:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755667AbZIUJJy
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 05:09:54 -0400
Received: from smtp3-g21.free.fr ([212.27.42.3]:55490 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755545AbZIUJJx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 05:09:53 -0400
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id CECD381818B
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 11:09:52 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g21.free.fr (Postfix) with ESMTP id EBABC818135
	for <git@vger.kernel.org>; Mon, 21 Sep 2009 11:09:49 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id D06D628886; Mon, 21 Sep 2009 11:09:49 +0200 (CEST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128872>

Using square brackets in tr ranges is risky.
From the documentation of GNU tr:

  Ranges
       The notation `M-N' expands to all of the characters from M through
       N, in ascending order.  M should collate before N; if it doesn't,
       an error results.  As an example, `0-9' is the same as
       `0123456789'.

       GNU `tr' does not support the System V syntax that uses square
       brackets to enclose ranges.  Translations specified in that format
       sometimes work as expected, since the brackets are often
       transliterated to themselves.  However, they should be avoided
       because they sometimes behave unexpectedly.  For example, `tr -d
       '[0-9]'' deletes brackets as well as digits.

However, if the use of [] is deliberate, because git still
cares about portability to ancient SYSV versions of tr that
require that notation, then let me know and I'll undo that part
of the change and add a comment to that effect.

>From cd3c17c6a48c67d2a598001272f3283714b1df19 Mon Sep 17 00:00:00 2001
From: Jim Meyering <meyering@redhat.com>
Date: Mon, 21 Sep 2009 10:58:02 +0200
Subject: [PATCH] pre-commit.sample: don't use [...] around a tr range

Using square brackets around a tr range is especially risky when using
tr's -d (delete) option.  In this case, the brackets happen to be harmless,
since the two bracket bytes happen to be included in the desired range.
Correct spelling and grammar.

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
 templates/hooks--pre-commit.sample |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/templates/hooks--pre-commit.sample b/templates/hooks--pre-commit.sample
index b11ad6a..06a5afa 100755
--- a/templates/hooks--pre-commit.sample
+++ b/templates/hooks--pre-commit.sample
@@ -15,14 +15,14 @@ allownonascii=$(git config hooks.allownonascii)
 # printable range starts at the space character and ends with tilde.
 if [ "$allownonascii" != "true" ] &&
 	test "$(git diff --cached --name-only --diff-filter=A -z |
-	  LC_ALL=C tr -d '[ -~]\0')"
+	  LC_ALL=C tr -d ' -~\0')"
 then
-	echo "Error: Attempt to add a non-ascii filename."
+	echo "Error: Attempt to add a non-ascii file name."
 	echo
-	echo "This can cause problems if you want to work together"
-	echo "with people on other platforms than you."
+	echo "This can cause problems if you want to work"
+	echo "with people on other platforms."
 	echo
-	echo "To be portable it is adviseable to rename the file ..."
+	echo "To be portable it is advisable to rename the file ..."
 	echo
 	echo "If you know what you are doing you can disable this"
 	echo "check using:"
--
1.6.5.rc1.214.g13c5a
