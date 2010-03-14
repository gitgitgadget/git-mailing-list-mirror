From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Bri=C3=A8re?= <fbriere@fbriere.net>
Subject: [PATCH] gitk: Skip over AUTHOR/COMMIT_DATE when searching all fields
Date: Sun, 14 Mar 2010 18:59:09 -0400
Message-ID: <1268607549-3440-1-git-send-email-fbriere@fbriere.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paul Mackerras <paulus@samba.org>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Bri=C3=A8re?= <fbriere@fbriere.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 15 00:08:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqwvM-0000ol-OD
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 00:08:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932840Ab0CNXIj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 14 Mar 2010 19:08:39 -0400
Received: from fallback-out2.mxes.net ([216.86.168.191]:63069 "EHLO
	fallback-in2.mxes.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754790Ab0CNXIi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 19:08:38 -0400
X-Greylist: delayed 547 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Mar 2010 19:08:38 EDT
Received: from mxout-07.mxes.net (mxout-07.mxes.net [216.86.168.182])
	by fallback-in1.mxes.net (Postfix) with ESMTP id 371622FD7B7
	for <git@vger.kernel.org>; Sun, 14 Mar 2010 19:00:36 -0400 (EDT)
Received: from toroia.fbriere.dyndns.org (unknown [69.196.143.157])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTPSA id 5B6C522E1F3;
	Sun, 14 Mar 2010 18:59:30 -0400 (EDT)
Received: by toroia.fbriere.dyndns.org (Postfix, from userid 1000)
	id 4D6585F994; Sun, 14 Mar 2010 18:59:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142160>

This prevents searches on "All Fields" from matching against the
author/commit timestamps.  Not only are these timestamps not searchable
by themselves, but the displayed format will not match the query string
anyway.

Signed-off-by: Fr=C3=A9d=C3=A9ric Bri=C3=A8re <fbriere@fbriere.net>
---
 gitk-git/gitk |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1f36a3e..d7e3c45 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4591,8 +4591,9 @@ proc askfindhighlight {row id} {
     }
     set info $commitinfo($id)
     set isbold 0
-    set fldtypes [list [mc Headline] [mc Author] [mc Date] [mc Committ=
er] [mc CDate] [mc Comments]]
+    set fldtypes [list [mc Headline] [mc Author] "" [mc Committer] "" =
[mc Comments]]
     foreach f $info ty $fldtypes {
+	if {$ty eq ""} continue
 	if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 	    [doesmatch $f]} {
 	    if {$ty eq [mc "Author"]} {
@@ -6438,7 +6439,7 @@ proc findmore {} {
     if {![info exists find_dirn]} {
 	return 0
     }
-    set fldtypes [list [mc "Headline"] [mc "Author"] [mc "Date"] [mc "=
Committer"] [mc "CDate"] [mc "Comments"]]
+    set fldtypes [list [mc "Headline"] [mc "Author"] "" [mc "Committer=
"] "" [mc "Comments"]]
     set l $findcurline
     set moretodo 0
     if {$find_dirn > 0} {
@@ -6499,6 +6500,7 @@ proc findmore {} {
 	    }
 	    set info $commitinfo($id)
 	    foreach f $info ty $fldtypes {
+		if {$ty eq ""} continue
 		if {($findloc eq [mc "All fields"] || $findloc eq $ty) &&
 		    [doesmatch $f]} {
 		    set found 1
--=20
1.7.0
