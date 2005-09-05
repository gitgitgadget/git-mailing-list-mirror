From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 2/4] Add function to append to an object_list.
Date: Mon, 5 Sep 2005 02:04:18 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0509050203540.23242@iabervon.org>
References: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Sep 05 08:01:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECA1t-0003qj-P4
	for gcvg-git@gmane.org; Mon, 05 Sep 2005 08:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbVIEGA0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Sep 2005 02:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932223AbVIEGA0
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Sep 2005 02:00:26 -0400
Received: from iabervon.org ([66.92.72.58]:33554 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932221AbVIEGAZ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Sep 2005 02:00:25 -0400
Received: (qmail 22871 invoked by uid 1000); 5 Sep 2005 02:04:18 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Sep 2005 02:04:18 -0400
To: git@vger.kernel.org
In-Reply-To: <Pine.LNX.4.63.0509050151240.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8086>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---

 object.c |   11 +++++++++++
 object.h |    3 +++
 2 files changed, 14 insertions(+), 0 deletions(-)

88cf2db55848e7a2cf655171c7e9fd74c70a0281
diff --git a/object.c b/object.c
--- a/object.c
+++ b/object.c
@@ -184,6 +184,17 @@ struct object_list *object_list_insert(s
         return new_list;
 }
 
+void object_list_append(struct object *item,
+			struct object_list **list_p)
+{
+	while (*list_p) {
+		list_p = &((*list_p)->next);
+	}
+	*list_p = xmalloc(sizeof(struct object_list));
+	(*list_p)->next = NULL;
+	(*list_p)->item = item;
+}
+
 unsigned object_list_length(struct object_list *list)
 {
 	unsigned ret = 0;
diff --git a/object.h b/object.h
--- a/object.h
+++ b/object.h
@@ -41,6 +41,9 @@ void mark_reachable(struct object *obj, 
 struct object_list *object_list_insert(struct object *item, 
 				       struct object_list **list_p);
 
+void object_list_append(struct object *item,
+			struct object_list **list_p);
+
 unsigned object_list_length(struct object_list *list);
 
 int object_list_contains(struct object_list *list, struct object *obj);
