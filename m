From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 2/4] builtin-fast-export.c: turn error into warning
Date: Mon, 30 Mar 2009 11:08:55 +0200
Message-ID: <1238404137-6693-2-git-send-email-kusmabite@gmail.com>
References: <1238404137-6693-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 30 11:11:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoDVu-0001sG-Ef
	for gcvg-git-2@gmane.org; Mon, 30 Mar 2009 11:10:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704AbZC3JJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Mar 2009 05:09:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757787AbZC3JJG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Mar 2009 05:09:06 -0400
Received: from mx.getmail.no ([84.208.15.66]:43824 "EHLO
	get-mta-out01.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755609AbZC3JJD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 30 Mar 2009 05:09:03 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB008QKAQZTID0@get-mta-out01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:08:59 +0200 (MEST)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KHB000Q8AQYPG60@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Mon, 30 Mar 2009 11:08:59 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.30.84610
X-Mailer: git-send-email 1.6.2.1
In-reply-to: <1238404137-6693-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115115>

fast-import doesn't have a syntax to support tree-objects (and some other
object-types), so fast-export shouldn't handle them. However, aborting the
operation is a bit drastic. This patch turns the error into a warning instead.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index 34a419c..027c4aa 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -379,8 +379,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			}
 			break;
 		default:
-			die ("Unexpected object of type %s",
-			     typename(e->item->type));
+			warning("%s: Unexpected object of type %s, skipping.",
+			        e->name,
+			        typename(e->item->type));
+			continue;
 		}
 		if (commit->util)
 			/* more than one name for the same object */
-- 
1.6.2.1
