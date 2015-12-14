From: Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v1 1/4] git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
Date: Mon, 14 Dec 2015 15:09:00 +0000
Message-ID: <1450105743-2432-2-git-send-email-philipoakley@iee.org>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
 <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Cc: Alexey Astakhov <asstv7@gmail.com>, sender <philipoakley@iee.org>
To: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Dec 14 16:09:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8Ukb-0003dW-3b
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 16:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752551AbbLNPJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 10:09:04 -0500
Received: from out1.ip01ir2.opaltelecom.net ([62.24.128.237]:12859 "EHLO
	out1.ip01ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751812AbbLNPJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 10:09:03 -0500
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: A2CoCgBw2m5WPCSzBlxeGQEBAgsBAgEBAQEBgjlRU26CYoVWsmKECiGFZwQCAoEiTQEBAQEBAQcBAQEBQAE/hDUBAQRWIxAISSEYChQGARKIGgMWCbhZDYQ9AQEBBwIdBIZWh1CBVYUYBZZ2hTWGF5cxh1uDJ4FAPjSDO4FLAQEB
X-IPAS-Result: A2CoCgBw2m5WPCSzBlxeGQEBAgsBAgEBAQEBgjlRU26CYoVWsmKECiGFZwQCAoEiTQEBAQEBAQcBAQEBQAE/hDUBAQRWIxAISSEYChQGARKIGgMWCbhZDYQ9AQEBBwIdBIZWh1CBVYUYBZZ2hTWGF5cxh1uDJ4FAPjSDO4FLAQEB
X-IronPort-AV: E=Sophos;i="5.20,427,1444690800"; 
   d="scan'208";a="812657822"
Received: from host-92-6-179-36.as43234.net (HELO localhost) ([92.6.179.36])
  by out1.ip01ir2.opaltelecom.net with ESMTP; 14 Dec 2015 15:09:00 +0000
X-Mailer: git-send-email 1.9.5
In-Reply-To: <1450105743-2432-1-git-send-email-philipoakley@iee.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282362>

The git gui's recent repo list may become contaminated with duplicate
entries. The git gui would barf when attempting to remove one entry.
Remove them all - there is no option within 'git config' to selectively
remove one of the entries.

This issue was reported on the 'Git User' list
(https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
Warning: gui.recentrepo has multiply values while executing).

On startup the gui checks that entries in the recentrepo list are still
valid repos and deletes thoses that are not. If duplicate entries are
present the 'git config --unset' will barf and this prevents the gui
from starting.

Subsequent patches fix other parts of recentrepo logic used for syncing
internal lists with the external .gitconfig.

Reported-by: Alexey Astakhov <asstv7@gmail.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
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
2.5.2.windows.2
