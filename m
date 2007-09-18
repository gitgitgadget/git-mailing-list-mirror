From: =?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
Subject: [PATCH] Fixed update-hook example allow-users format.
Date: Tue, 18 Sep 2007 15:26:09 +0300
Message-ID: <1190118369327-git-send-email-v@pp.inet.fi>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?utf-8?q?V=C3=A4in=C3=B6=20J=C3=A4rvel=C3=A4?= <v@pp.inet.fi>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 14:27:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXcAT-0003hl-OL
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 14:27:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755451AbXIRM07 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 08:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755455AbXIRM07
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 08:26:59 -0400
Received: from gw01.mail.saunalahti.fi ([195.197.172.115]:47327 "EHLO
	gw01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753718AbXIRM06 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 08:26:58 -0400
Received: from localhost.localdomain (GYKMMMCCLXXV.dsl.saunalahti.fi [85.77.38.176])
	by gw01.mail.saunalahti.fi (Postfix) with ESMTP id CCDAA1510CC;
	Tue, 18 Sep 2007 15:26:48 +0300 (EEST)
X-Mailer: git-send-email 1.5.3.1.2.gd7c01
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58593>

The example provided with the update-hook-example does not work on
either bash 2.05b.0(1)-release nor 3.1.17(1)-release. The matcher did
not match the lines that it advertised to match, such as:

refs/heads/bw/        linus
refs/heads/tmp/*      *

In POSIX 1003.2 regular expressions, the star (*), is not an wildcard
meaning "match everything", it matches 0 or more matches of the atom
preceding it.

So to match "refs/heads/bw/topic-branch", the matcher should be written
as "refs/heads/bw/.*" to match "refs/heads/bw/" and everything after it.
---
 Documentation/howto/update-hook-example.txt |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/howto/update-hook-example.txt b/Documentation/howto/update-hook-example.txt
index 3a33696..88765b5 100644
--- a/Documentation/howto/update-hook-example.txt
+++ b/Documentation/howto/update-hook-example.txt
@@ -158,11 +158,11 @@ This uses two files, $GIT_DIR/info/allowed-users and
 allowed-groups, to describe which heads can be pushed into by
 whom.  The format of each file would look like this:
 
-	refs/heads/master	junio
+        refs/heads/master	junio
         refs/heads/cogito$	pasky
-	refs/heads/bw/		linus
-        refs/heads/tmp/		*
-        refs/tags/v[0-9]*	junio
+        refs/heads/bw/.*	linus
+        refs/heads/tmp/.*	.*
+        refs/tags/v[0-9].*	junio
 
 With this, Linus can push or create "bw/penguin" or "bw/zebra"
 or "bw/panda" branches, Pasky can do only "cogito", and JC can
-- 
1.5.3.1.2.gd7c01
