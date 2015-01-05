From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3] doc: core.ignoreStat update, and clarify the --assume-unchanged effect
Date: Mon,  5 Jan 2015 22:22:53 +0000
Message-ID: <1420496573-3260-1-git-send-email-philipoakley@iee.org>
Cc: GitList <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 05 23:23:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8G39-0006GG-N3
	for gcvg-git-2@plane.gmane.org; Mon, 05 Jan 2015 23:23:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753071AbbAEWWz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Jan 2015 17:22:55 -0500
Received: from out1.ip05ir2.opaltelecom.net ([62.24.128.241]:53882 "EHLO
	out1.ip05ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751511AbbAEWWz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Jan 2015 17:22:55 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvAZAK8Nq1ROl3RPPGdsb2JhbABcgwUBAYEphi+BV69PjkKFfAQCgQoXAQEBAQEBBQEBAQE4O4RpHgUYgQIKGhOIML1+LI93hDAFhC2TaIoyhhGBZ22BPD4xgkMBAQE
X-IPAS-Result: AvAZAK8Nq1ROl3RPPGdsb2JhbABcgwUBAYEphi+BV69PjkKFfAQCgQoXAQEBAQEBBQEBAQE4O4RpHgUYgQIKGhOIML1+LI93hDAFhC2TaIoyhhGBZ22BPD4xgkMBAQE
X-IronPort-AV: E=Sophos;i="5.07,702,1413241200"; 
   d="scan'208";a="580176811"
Received: from host-78-151-116-79.as13285.net (HELO localhost) ([78.151.116.79])
  by out1.ip05ir2.opaltelecom.net with ESMTP; 05 Jan 2015 22:22:53 +0000
X-Mailer: git-send-email 1.9.5.msysgit.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262038>

The assume-unchanged bit, and consequently core.ignoreStat, can be
misunderstood. Be assertive about the expectation that file changes should
notified to Git.

Overhaul the general wording thus:
    1. direct description of what is ignored given first.
    2. example instruction of the user manual action required.
    3. use sideways indirection for assume-unchanged and update-index
       references.
    4. add a 'normally' to give leeway for the change detection.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---

This is the corrected patch which now applies on top of next and has been
checked on AsciiDoc. (was $gmane/261974/focus=262022)

I have included the previous 'after three-dashes' comment and included
them in the commit message. I'm happy for it to be tweaked as appropriate.

---
 Documentation/config.txt | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 52eeadd..fe179d0 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -375,15 +375,18 @@ This is useful for excluding servers inside a firewall from
 proxy use, while defaulting to a common proxy for external domains.
 
 core.ignoreStat::
-	If true, commands which modify both the working tree and the index
-	will mark the updated paths with the "assume unchanged" bit in the
-	index. These marked files are then expected to stay unchanged in the
-	working tree. If you change them you should mark their update manually.
-	Git will normally not detect the file changes by lstat() calls.
-	This is useful on systems where those calls are very slow, such as
-	cifs/Microsoft Windows.
-	See linkgit:git-update-index[1].
-	False by default.
+	If true, Git will avoid using lstat() calls to detect if files have
+	changed. Git will set the "assume-unchanged" bit for those tracked files
+	which it has updated identically in both the index and working tree.
++
+When files are modified outside of Git, the user will need to stage
+the modified files explicitly (e.g. see 'Examples' section in
+linkgit:git-update-index[1]).
+Git will not normally detect changes to those files.
++
+This is useful on systems where lstat() calls are very slow, such as
+CIFS/Microsoft Windows.
+False by default.
 
 core.preferSymlinkRefs::
 	Instead of the default "symref" format for HEAD
-- 
1.9.5.msysgit.0
