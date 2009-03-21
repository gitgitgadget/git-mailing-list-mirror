From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH] builtin-fast-export.c: add default case to avoid crash on
 corrupt repo
Date: Sat, 21 Mar 2009 22:37:31 +0000
Message-ID: <1237675051-6688-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Erik Faye-Lund <kusmabite@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 00:39:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlAmT-0002rK-0P
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 00:39:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754117AbZCUXhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Mar 2009 19:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754099AbZCUXhb
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Mar 2009 19:37:31 -0400
Received: from mx.getmail.no ([84.208.15.66]:43531 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753750AbZCUXha (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Mar 2009 19:37:30 -0400
X-Greylist: delayed 3601 seconds by postgrey-1.27 at vger.kernel.org; Sat, 21 Mar 2009 19:37:30 EDT
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGV00FP9O6EMSD0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sat, 21 Mar 2009 23:37:26 +0100 (MET)
Received: from localhost.localdomain ([84.215.140.47])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KGV003JCO6CGM00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Sat, 21 Mar 2009 23:37:26 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.21.222221
X-Mailer: git-send-email 1.6.2.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114099>

This small issue was discovered by Benjamin Kramers Clang-runs on the git
code-base. If a tag object points to an object that is not a commit or a blob,
an invalid pointer is dereferenced in the code that followed.

This patch fixes this issue, by giving an error instead. This should also be
more useful when debugging corrupted repos.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 builtin-fast-export.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin-fast-export.c b/builtin-fast-export.c
index fdf4ae9..26b2a93 100644
--- a/builtin-fast-export.c
+++ b/builtin-fast-export.c
@@ -375,6 +375,9 @@ static void get_tags_and_duplicates(struct object_array *pending,
 			case OBJ_BLOB:
 				handle_object(tag->object.sha1);
 				continue;
+			default:
+				die ("Unexpected object of type %s",
+				     typename(tag->object.type));
 			}
 			break;
 		default:
-- 
1.6.2.1.215.gf786.dirty
