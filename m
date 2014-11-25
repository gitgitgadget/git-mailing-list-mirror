From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 2/3] mailmap: use higher level string list functions
Date: Mon, 24 Nov 2014 19:44:14 -0800
Message-ID: <1416887054-27204-1-git-send-email-sbeller@google.com>
References: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>
Cc: Stefan Beller <sbeller@google.com>
To: marius@trolltech.com, gitster@pobox.com, julian@quantumfyre.co.uk,
	sunshine@sunshineco.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 25 04:44:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xt739-0005Yy-R8
	for gcvg-git-2@plane.gmane.org; Tue, 25 Nov 2014 04:44:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751304AbaKYDoT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Nov 2014 22:44:19 -0500
Received: from mail-ie0-f180.google.com ([209.85.223.180]:33936 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750841AbaKYDoS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Nov 2014 22:44:18 -0500
Received: by mail-ie0-f180.google.com with SMTP id rp18so10273919iec.39
        for <git@vger.kernel.org>; Mon, 24 Nov 2014 19:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rFxi6YqTdQemnR/ns5Sd9HkDDWg5sNe5dUxRQwclHMo=;
        b=RNxlqiO6inE3tedrGG8GQpI2MP1aw7XEqS1W7j5JhuywJ0HhzzvbllyGR8lPlCxGyF
         q1SFmX6lrtf34/nSG0jHRvWaX2oFr+mwNl6XBK/9YZLCBbDPcPNPh0eGJ/GTpybLg84y
         w0OlTZ5vSi++gXWuBYWS9fWpLV8Z0mxkyf9xsHgoJPFEaIZ4wHovHflwExBGfWAkeVet
         l4i9T/723352hhMkdMYNyol4OJHk2v70fDmRM3ZcrMWN+k8DyVL0Nsf9kjPlqmC2wxa0
         eZummNooeflUVsD+IjRyDp8MeFOjKCG2KGMtI4qKmqU5bCJW7zSrxTkfdIZN7EW5efaR
         iO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rFxi6YqTdQemnR/ns5Sd9HkDDWg5sNe5dUxRQwclHMo=;
        b=SoE+E6MD8n3gntBKHtMz489CT2ptp5A9KMKRfBlzNDurVefwOex5C2PNvWfwvpokLS
         yeWxNbZm7j1htzhtofAwpAQ7MPNt24DRmpxf40IDBig4X6OkyGqW3mzxckZojLZoOwMD
         5HBsMISXPdZk7IutlJvdwj58vqn/2W2ohBML73Q68JO7lZyKTHZNsYp3ZznnNBHsh2JO
         3yGB5uIwxS9rbc4zQ1NoydVzdhZGbF5NZpO1/Y/xqH0Sbhe5pSPBi4iTCgJVKf1fWuTN
         S20T4ZIMQSz6BN2fXcA8f+izMbY0GTiCwfHUeFjR/buc1Wf+yjhNCwOso5JM4rtp8ejM
         kyTw==
X-Gm-Message-State: ALoCoQnRrRHA5xd6npDVD37n3EjXjvO72bZIV9CDgrxdoHNjDsjf4X/prVv6zBvsBXYB8881VFNK
X-Received: by 10.107.7.91 with SMTP id 88mr20705467ioh.70.1416887057826;
        Mon, 24 Nov 2014 19:44:17 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:79de:6365:bed8:92ea])
        by mx.google.com with ESMTPSA id k191sm27082iok.1.2014.11.24.19.44.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 24 Nov 2014 19:44:17 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc3
In-Reply-To: <CAPig+cQ_4A-0LOgXXG5qLeHOev+g8KMq5osKz34AFijGuyRidQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260185>

No functional changes intended. This commit makes use of higher level
and better documented functions of the string list API, so the code is
more understandable.

Note that also the required computational amount should not change
in principal as we need to look up the item no matter if it is already
part of the list or not. Once looked up, insertion comes for free.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
Changes since Version 1:
* Remove declaration-after-statement.

Changes Version 1 to Version 2:
* typo in commit message

 mailmap.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index 81890a6..3b00a65 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -71,6 +71,7 @@ static void add_mapping(struct string_list *map,
 			char *old_name, char *old_email)
 {
 	struct mailmap_entry *me;
+	struct string_list_item *item;
 	int index;
 
 	if (old_email == NULL) {
@@ -78,15 +79,10 @@ static void add_mapping(struct string_list *map,
 		new_email = NULL;
 	}
 
-	if ((index = string_list_find_insert_index(map, old_email, 1)) < 0) {
-		/* mailmap entry exists, invert index value */
-		index = -1 - index;
-		me = (struct mailmap_entry *)map->items[index].util;
+	item = string_list_insert(map, old_email);
+	if (item->util) {
+		me = (struct mailmap_entry *)item->util;
 	} else {
-		/* create mailmap entry */
-		struct string_list_item *item;
-
-		item = string_list_insert_at_index(map, index, old_email);
 		me = xcalloc(1, sizeof(struct mailmap_entry));
 		me->namemap.strdup_strings = 1;
 		me->namemap.cmp = namemap_cmp;
-- 
2.2.0.rc3
