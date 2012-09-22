From: Stefan Haller <stefan@haller-berlin.de>
Subject: [PATCH 2/2] gitk: Highlight first search result immediately on incremental search
Date: Sat, 22 Sep 2012 09:40:25 +0200
Message-ID: <1348299625-90207-3-git-send-email-stefan@haller-berlin.de>
References: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Cc: git@vger.kernel.org
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sat Sep 22 09:41:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TFKKy-0008Bh-R7
	for gcvg-git-2@plane.gmane.org; Sat, 22 Sep 2012 09:41:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754290Ab2IVHks (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Sep 2012 03:40:48 -0400
Received: from server90.greatnet.de ([83.133.96.186]:55592 "EHLO
	server90.greatnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754120Ab2IVHkr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Sep 2012 03:40:47 -0400
Received: from localhost.localdomain (dslb-088-073-094-229.pools.arcor-ip.net [88.73.94.229])
	by server90.greatnet.de (Postfix) with ESMTPA id 8DAB93B0E90;
	Sat, 22 Sep 2012 09:40:45 +0200 (CEST)
X-Mailer: git-send-email 1.7.12.1.399.gae20e0d
In-Reply-To: <1348299625-90207-1-git-send-email-stefan@haller-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206195>

When typing in the "Search" field, select the current search result (so
that it gets highlighted in orange). This makes it easier to understand
what will happen if you then type Ctrl-S.

Signed-off-by: Stefan Haller <stefan@haller-berlin.de>
---
 gitk | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/gitk b/gitk
index e2c0f1c..39c40de 100755
--- a/gitk
+++ b/gitk
@@ -8053,9 +8053,12 @@ proc incrsearch {name ix op} {
 	}
     }
     if {$searchstring ne {}} {
-	set here [$ctext search $searchdirn -- $searchstring anchor]
+	set here [$ctext search -count mlen $searchdirn -- $searchstring anchor]
 	if {$here ne {}} {
 	    $ctext see $here
+	    set mend "$here + $mlen c"
+	    $ctext tag remove sel 1.0 end
+	    $ctext tag add sel $here $mend
 	    suppress_highlighting_file_for_current_scrollpos
 	    highlightfile_for_scrollpos $here
 	}
-- 
1.7.12.1.399.gae20e0d
