From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v3 4/4] git gui: allow for a long recentrepo list
Date: Thu, 17 Dec 2015 22:40:07 +0000
Message-ID: <1450392007-600-1-git-send-email-philipoakley@iee.org>
References: <2F62ABA2EE734F5F926C9E102969895F@PhilipOakley>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Dec 17 23:40:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9hDi-0007pr-IO
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 23:40:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933612AbbLQWkR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2015 17:40:17 -0500
Received: from out1.ip02ir2.opaltelecom.net ([62.24.128.238]:36134 "EHLO
	out1.ip02ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933531AbbLQWkQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Dec 2015 17:40:16 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CLAwCfOHNWPK4lFlxeGQEBAQELAQIBAQEBAYI5UYE/hmC0YIIZAQ2BYoYHBAICgTw5FAEBAQEBAQEGAQEBAUABP4Q1AQEEViMQUTkKFAYBEogzsWKMGgEBCCOGVokzhQsFln2qZSABAYRGPjSDIIFKAQEB
X-IPAS-Result: A2CLAwCfOHNWPK4lFlxeGQEBAQELAQIBAQEBAYI5UYE/hmC0YIIZAQ2BYoYHBAICgTw5FAEBAQEBAQEGAQEBAUABP4Q1AQEEViMQUTkKFAYBEogzsWKMGgEBCCOGVokzhQsFln2qZSABAYRGPjSDIIFKAQEB
X-IronPort-AV: E=Sophos;i="5.20,443,1444690800"; 
   d="scan'208";a="70451857"
Received: from host-92-22-37-174.as13285.net (HELO localhost.localdomain) ([92.22.37.174])
  by out1.ip02ir2.opaltelecom.net with ESMTP; 17 Dec 2015 23:04:41 +0000
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <2F62ABA2EE734F5F926C9E102969895F@PhilipOakley>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282685>

The gui.recentrepo list may be longer than the maxrecent setting.
Use the actual length determined earlier, now saved as $lenrecent.

In an ideal world, the git gui would limit the number of entries
to the maxrecent setting, however the recentrepo config list may
have been extended outside of the gui, or the maxrecent setting changed
to a reduced value. Further, when testing the gui's recentrepo
logic it is useful to show these extra, but valid, entries.

The list length will be trimmed to $maxrecent after the user selects
a repo to open.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
V2:
word usage corrected.
Eric's comments $gmane/282432
V3: 
Updated list length measure following Junio's comments $gmane/282669

Replaces the previous V2 Patch 4/4.

---
 git-gui/lib/choose_repository.tcl | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index ad7a888..b4cc7dd 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -134,7 +134,8 @@ constructor pick {} {
 	$opts conf -state disabled
 
 	set sorted_recent [_get_recentrepos]
-	if {[llength $sorted_recent] > 0} {
+	set lenrecent [llength $sorted_recent]
+	if {$lenrecent > 0} {
 		if {$m_repo ne {}} {
 			$m_repo add separator
 			$m_repo add command \
@@ -153,7 +154,7 @@ constructor pick {} {
 			-background [get_bg_color $w_body.recentlabel] \
 			-wrap none \
 			-width 50 \
-			-height $maxrecent
+			-height $lenrecent
 		$w_recentlist tag conf link \
 			-foreground blue \
 			-underline 1
-- 
2.6.4.windows.1
