From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 2/3] deref_tag: handle tag->tagged = NULL
Date: Mon, 18 Feb 2008 08:31:55 +0100
Message-ID: <1203319916670-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 08:32:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR0UM-0007Ep-DN
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 08:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753635AbYBRHb7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 02:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYBRHb6
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 02:31:58 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:58472 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753134AbYBRHb5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 02:31:57 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id 9B618680BF8C;
	Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rwpW7KR7DQ0s; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 73100680BF7A; Mon, 18 Feb 2008 08:31:56 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033199162949-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74235>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 tag.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/tag.c b/tag.c
index 38bf913..990134f 100644
--- a/tag.c
+++ b/tag.c
@@ -9,7 +9,10 @@ const char *tag_type = "tag";
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
 {
 	while (o && o->type == OBJ_TAG)
-		o = parse_object(((struct tag *)o)->tagged->sha1);
+		if (((struct tag *)o)->tagged)
+			o = parse_object(((struct tag *)o)->tagged->sha1);
+		else
+			o = NULL;
 	if (!o && warn) {
 		if (!warnlen)
 			warnlen = strlen(warn);
-- 
1.5.4.1.gaf0ae
