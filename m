From: Jim Meyering <jim@meyering.net>
Subject: [PATCH] gitk: make "git describe" output clickable, too
Date: Sat, 10 Dec 2011 16:08:57 +0100
Message-ID: <87mxb0foqe.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 10 16:09:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZOY9-0000E3-RW
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 16:09:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549Ab1LJPJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Dec 2011 10:09:10 -0500
Received: from smtp5-g21.free.fr ([212.27.42.5]:57549 "EHLO smtp5-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341Ab1LJPJH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Dec 2011 10:09:07 -0500
Received: from mx.meyering.net (unknown [88.168.87.75])
	by smtp5-g21.free.fr (Postfix) with ESMTP id 27CB5D48539
	for <git@vger.kernel.org>; Sat, 10 Dec 2011 16:08:58 +0100 (CET)
Received: from rho.meyering.net (localhost.localdomain [127.0.0.1])
	by rho.meyering.net (Acme Bit-Twister) with ESMTP id 661DA60092
	for <git@vger.kernel.org>; Sat, 10 Dec 2011 16:08:57 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186780>


I noticed that automake's contribution guidelines suggest using
"git describe" output in commit logs to reference previous commits.
By contrast, in coreutils, I had acquired the habit of using a bare SHA1
prefix (8 hex digits), since gitk creates clickable links for that, and
not for "git describe" output.

I prefer the readability of the full "git describe" output, yet want to
retain the gitk links, so wrote the following that renders as clickable
not just SHA1-like strings, but also an SHA1-like string that is
prefixed by "-g".

Signed-off-by: Jim Meyering <meyering@redhat.com>
---
This is relative to master.
Think of this as mere proof-of-concept:

Ideally, the string preceding the -g would be used to disambiguate
the SHA1 prefix, but that would require more code.

I confess that I haven't looked to see if documentation needs
to be updated or if this would merit test suite additions.

 gitk-git/gitk |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 4cde0c4..f8eb613 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -6688,7 +6688,7 @@ proc appendwithlinks {text tags} {

     set start [$ctext index "end - 1c"]
     $ctext insert end $text $tags
-    set links [regexp -indices -all -inline {\m[0-9a-f]{6,40}\M} $text]
+    set links [regexp -indices -all -inline {(?:\m|-g)[0-9a-f]{6,40}\M} $text]
     foreach l $links {
 	set s [lindex $l 0]
 	set e [lindex $l 1]
@@ -6704,6 +6704,10 @@ proc appendwithlinks {text tags} {
 proc setlink {id lk} {
     global curview ctext pendinglinks

+    if {[string range $id 0 1] eq "-g"} {
+      set id [string range $id 2 end]
+    }
+
     set known 0
     if {[string length $id] < 40} {
 	set matches [longid $id]
--
1.7.8.163.g9859a
