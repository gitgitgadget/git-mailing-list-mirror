From: Brian Gesiak <modocache@gmail.com>
Subject: [PATCH 11/15] notes.c: rearrange xcalloc arguments
Date: Tue, 27 May 2014 00:33:52 +0900
Message-ID: <1401118436-66090-12-git-send-email-modocache@gmail.com>
References: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Cc: Brian Gesiak <modocache@gmail.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 26 17:35:15 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wowvf-0005AU-LD
	for gcvg-git-2@plane.gmane.org; Mon, 26 May 2014 17:35:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041AbaEZPfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 May 2014 11:35:05 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:37472 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753019AbaEZPfB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 May 2014 11:35:01 -0400
Received: by mail-pb0-f46.google.com with SMTP id rq2so7865444pbb.33
        for <git@vger.kernel.org>; Mon, 26 May 2014 08:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=kqoLaoYQ+kAIrkC4gFchdw6Lh4Y9gsMj6YxZ92bJS7E=;
        b=jjJdqJqBpm/oQMOA0z1+WZJIJ+dxBtmkx3nNKYfCogZ8LLEr8ND+684efrqdUVWX3b
         RKSzNWe6tZjVsgOUrKHc9X1v6OJoMU2sx2QXfmB0f6V52nhDH3EZKuVO5ol99UTcGLMy
         YfI8F2o6DB4iPdT7r0NeXyw0y0PJExFCkqKyDoY/XoJBbi56YoeOO9B587Zypz9WFLHs
         TVSBMZvVY04lE8JrRX8REHMwO9LNYfaZSzgDEN0keBGEUaStWubLuLTJKesZFlbtBqXT
         OIBYg55RfHhtCmnnJGxHgvBDsiKv8psSNAOhAl0ZDaDDtY/m6V17DeEzlkXcCd63VYZ3
         /wrA==
X-Received: by 10.68.211.195 with SMTP id ne3mr28532980pbc.121.1401118500870;
        Mon, 26 May 2014 08:35:00 -0700 (PDT)
Received: from localhost.localdomain (p3080-ipbf5805marunouchi.tokyo.ocn.ne.jp. [60.46.42.80])
        by mx.google.com with ESMTPSA id mt1sm18850446pbb.31.2014.05.26.08.34.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 26 May 2014 08:35:00 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.rc1.543.gc8042da
In-Reply-To: <1401118436-66090-1-git-send-email-modocache@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250101>

xcalloc takes two arguments: the number of elements and their size.
notes.c includes several calls to xcalloc that pass the arguments in
reverse order. Rearrgange them so they are in the correct order.

Signed-off-by: Brian Gesiak <modocache@gmail.com>
---
 notes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/notes.c b/notes.c
index 5f07c0b..5fe691d 100644
--- a/notes.c
+++ b/notes.c
@@ -303,7 +303,7 @@ static int note_tree_insert(struct notes_tree *t, struct int_node *tree,
 		free(entry);
 		return 0;
 	}
-	new_node = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
+	new_node = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	ret = note_tree_insert(t, new_node, n + 1, l, GET_PTR_TYPE(*p),
 			       combine_notes);
 	if (ret)
@@ -443,7 +443,7 @@ static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
 		if (len <= 20) {
 			type = PTR_TYPE_NOTE;
 			l = (struct leaf_node *)
-				xcalloc(sizeof(struct leaf_node), 1);
+				xcalloc(1, sizeof(struct leaf_node));
 			hashcpy(l->key_sha1, object_sha1);
 			hashcpy(l->val_sha1, entry.sha1);
 			if (len < 20) {
@@ -1003,7 +1003,7 @@ void init_notes(struct notes_tree *t, const char *notes_ref,
 	if (!combine_notes)
 		combine_notes = combine_notes_concatenate;
 
-	t->root = (struct int_node *) xcalloc(sizeof(struct int_node), 1);
+	t->root = (struct int_node *) xcalloc(1, sizeof(struct int_node));
 	t->first_non_note = NULL;
 	t->prev_non_note = NULL;
 	t->ref = notes_ref ? xstrdup(notes_ref) : NULL;
-- 
2.0.0.rc1.543.gc8042da
