From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH 2/4] builtin-fast-export.c: turn error into warning
Date: Mon, 23 Mar 2009 12:53:07 +0000
Message-ID: <1237812789-1360-2-git-send-email-kusmabite@gmail.com>
References: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: gitster@pobox.com, Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 23 13:54:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lljft-0006Lx-QB
	for gcvg-git-2@gmane.org; Mon, 23 Mar 2009 13:54:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755719AbZCWMxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Mar 2009 08:53:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755471AbZCWMxH
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Mar 2009 08:53:07 -0400
Received: from mx.getmail.no ([84.208.15.66]:47911 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752788AbZCWMxG (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Mar 2009 08:53:06 -0400
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY00LTYMGD4E70@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:02 +0100 (MET)
Received: from localhost.localdomain ([84.215.187.169])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGY00AGTMGCW510@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Mon, 23 Mar 2009 13:53:01 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.23.123715
X-Mailer: git-send-email 1.6.2.GIT
In-reply-to: <1237812789-1360-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114296>

fast-import doesn't have a syntax to support tree-objects (and some other
object-types), so fast-export shouldn't handle them. However, aborting the
operation is a bit drastic. This patch turns the error into a warning instead.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index fdf4ae9..02bad1f 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -378,8 +378,10 @@ static void get_tags_and_duplicates(struct object_array *pending,
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
1.6.2.1.225.g9a4a0.dirty
