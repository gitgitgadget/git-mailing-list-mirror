From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 1/4] git-gui: de-dup entries from gui.recentrepo
Date: Wed, 16 Dec 2015 23:58:04 +0000
Message-ID: <1450310287-4936-2-git-send-email-philipoakley@iee.org>
References: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>,
	Philip Oakley <philipoakley@iee.org>
To: GitList <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Dec 17 00:58:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a9Lxi-00037l-4M
	for gcvg-git-2@plane.gmane.org; Thu, 17 Dec 2015 00:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755302AbbLPX6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 18:58:24 -0500
Received: from out1.ip03ir2.opaltelecom.net ([62.24.128.239]:37301 "EHLO
	out1.ip03ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754889AbbLPX6T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Dec 2015 18:58:19 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2A4CADm+XFWPMm3YwJeGQEBAg8BAQEBgjlRUm27UIQJIYVmBAICgShNAQEBAQEBBwEBAQFBP4Q1AQEEViMQUSEYChQGE4gaAxYKshSHWg2EKQEBAQcCHQSGVodQgVWFGAWWfIU5hheXOIdbhGg+NIMjgUsBAQE
X-IPAS-Result: A2A4CADm+XFWPMm3YwJeGQEBAg8BAQEBgjlRUm27UIQJIYVmBAICgShNAQEBAQEBBwEBAQFBP4Q1AQEEViMQUSEYChQGE4gaAxYKshSHWg2EKQEBAQcCHQSGVodQgVWFGAWWfIU5hheXOIdbhGg+NIMjgUsBAQE
X-IronPort-AV: E=Sophos;i="5.20,438,1444690800"; 
   d="scan'208";a="571788357"
Received: from host-2-99-183-201.as13285.net (HELO localhost.localdomain) ([2.99.183.201])
  by out1.ip03ir2.opaltelecom.net with ESMTP; 17 Dec 2015 00:21:55 +0000
X-Mailer: git-send-email 2.6.4.windows.1
In-Reply-To: <1450310287-4936-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282623>

The git gui's recent repo list may become contaminated with duplicate
entries. The git gui would barf when attempting to remove one entry.
Remove them all - there is no option within 'git config' to selectively
remove one of the entries.

This issue was reported on the 'Git User' list
(https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
"Warning: gui.recentrepo has multiply values while executing").

On startup the gui checks that entries in the recentrepo list are still
valid repos and deletes those that are not. If duplicate entries are
present, then 'git config --unset' will barf and this prevents the gui
from starting.

Subsequent patches fix other parts of recentrepo logic used for syncing
internal lists with the external .gitconfig.

Reported-by: Alexey Astakhov <asstv7@gmail.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
tightened the patch title
user report thread title now quoted
spelling corrected
fixed grammar (comma)
Eric's comments $gmane/282430
---
 git-gui/lib/choose_repository.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
index 75d1da8..133ca0a 100644
--- a/git-gui/lib/choose_repository.tcl
+++ b/git-gui/lib/choose_repository.tcl
@@ -247,7 +247,7 @@ proc _get_recentrepos {} {
 
 proc _unset_recentrepo {p} {
 	regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
-	git config --global --unset gui.recentrepo "^$p\$"
+	git config --global --unset-all gui.recentrepo "^$p\$"
 	load_config 1
 }
 
-- 
2.6.4.windows.1
