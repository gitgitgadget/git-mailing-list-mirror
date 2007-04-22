From: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Subject: [PATCH 3/5] add add_object_array_with_mode
Date: Sun, 22 Apr 2007 18:43:58 +0200
Message-ID: <1177260240928-git-send-email-mkoegler@auto.tuwien.ac.at>
References: <1177260240326-git-send-email-mkoegler@auto.tuwien.ac.at> <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at>
Cc: git@vger.kernel.org, Martin Koegler <mkoegler@auto.tuwien.ac.at>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 22 18:44:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HffAt-0001Lv-2I
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 18:44:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161492AbXDVQo1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Apr 2007 12:44:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161479AbXDVQoH
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Apr 2007 12:44:07 -0400
Received: from thor.auto.tuwien.ac.at ([128.130.60.15]:51159 "EHLO
	thor.auto.tuwien.ac.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161397AbXDVQoE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Apr 2007 12:44:04 -0400
Received: from localhost (localhost [127.0.0.1])
	by thor.auto.tuwien.ac.at (Postfix) with ESMTP id BE8867833E06;
	Sun, 22 Apr 2007 18:44:01 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at auto.tuwien.ac.at
Received: from thor.auto.tuwien.ac.at ([127.0.0.1])
	by localhost (thor.auto.tuwien.ac.at [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tjLwjsi1zs8b; Sun, 22 Apr 2007 18:44:01 +0200 (CEST)
Received: by thor.auto.tuwien.ac.at (Postfix, from userid 3001)
	id A4E517A522BE; Sun, 22 Apr 2007 18:44:00 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.5
In-Reply-To: <11772602402479-git-send-email-mkoegler@auto.tuwien.ac.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45249>

Each object in struct object_array is extended with the mode.
If not specified, S_IFINVALID is used. An object with an mode value
can be added with add_object_array_with_mode.

Signed-off-by: Martin Koegler <mkoegler@auto.tuwien.ac.at>
---
 object.c |    6 ++++++
 object.h |    2 ++
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/object.c b/object.c
index 78a44a6..fcf06bd 100644
--- a/object.c
+++ b/object.c
@@ -240,6 +240,11 @@ int object_list_contains(struct object_list *list, struct object *obj)
 
 void add_object_array(struct object *obj, const char *name, struct object_array *array)
 {
+	add_object_array_with_mode(obj, name, array, S_IFINVALID);
+}
+
+void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode)
+{
 	unsigned nr = array->nr;
 	unsigned alloc = array->alloc;
 	struct object_array_entry *objects = array->objects;
@@ -252,5 +257,6 @@ void add_object_array(struct object *obj, const char *name, struct object_array
 	}
 	objects[nr].item = obj;
 	objects[nr].name = name;
+	objects[nr].mode = mode;
 	array->nr = ++nr;
 }
diff --git a/object.h b/object.h
index bdbbc18..d0b5298 100644
--- a/object.h
+++ b/object.h
@@ -17,6 +17,7 @@ struct object_array {
 	struct object_array_entry {
 		struct object *item;
 		const char *name;
+		unsigned mode;
 	} *objects;
 };
 
@@ -77,5 +78,6 @@ int object_list_contains(struct object_list *list, struct object *obj);
 
 /* Object array handling .. */
 void add_object_array(struct object *obj, const char *name, struct object_array *array);
+void add_object_array_with_mode(struct object *obj, const char *name, struct object_array *array, unsigned mode);
 
 #endif /* OBJECT_H */
-- 
1.5.1.1.206.g4a12-dirty
