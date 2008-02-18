From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 10/12] revision.c: handle tag->tagged == NULL
Date: Mon, 18 Feb 2008 21:48:01 +0100
Message-ID: <12033676841373-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <12033676833730-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832769-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832231-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676832653-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833341-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676831961-git-send-email-mkoegler@auto.tuwien.ac.at>
 <1203367683563-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676833893-git-send-email-mkoegler@auto.tuwien.ac.at>
 <12033676842301-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 18 21:49:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRCvi-0000iE-Er
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 21:49:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756263AbYBRUsb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 15:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755764AbYBRUsa
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 15:48:30 -0500
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:40288 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761459AbYBRUsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 15:48:08 -0500
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id C24E5680BF93;
	Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id EIUHmPInDLhs; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id 2DCAA6CF006A; Mon, 18 Feb 2008 21:48:04 +0100 (CET)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <12033676842301-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74352>

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index 484e5e7..b1aebf8 100644
--- a/revision.c
+++ b/revision.c
@@ -177,6 +177,8 @@ static struct commit *handle_commit(struct rev_info *revs, struct object *object
 		struct tag *tag = (struct tag *) object;
 		if (revs->tag_objects && !(flags & UNINTERESTING))
 			add_pending_object(revs, object, tag->tag);
+		if (!tag->tagged)
+			die("bad tag");
 		object = parse_object(tag->tagged->sha1);
 		if (!object)
 			die("bad object %s", sha1_to_hex(tag->tagged->sha1));
@@ -689,6 +691,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 		it = get_reference(revs, arg, sha1, 0);
 		if (it->type != OBJ_TAG)
 			break;
+		if (!((struct tag*)it)->tagged)
+			return 0;
 		hashcpy(sha1, ((struct tag*)it)->tagged->sha1);
 	}
 	if (it->type != OBJ_COMMIT)
-- 
1.5.4.1.g96b77
