From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] string_list: use string-list API in unsorted_string_list_lookup()
Date: Fri, 22 Apr 2016 19:35:00 +0200
Message-ID: <20160422173500.32329-1-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 22 19:35:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1atez4-0004Td-01
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 19:35:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbcDVRfI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 13:35:08 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35154 "EHLO
	mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932122AbcDVRfH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 13:35:07 -0400
Received: by mail-wm0-f51.google.com with SMTP id e201so25785465wme.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2016 10:35:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=WD7zKr6reaJDn3nUGV+NxQL21xS/Xeyl4qUVkw9GnkY=;
        b=KRSuBZHPeeoAY9TC+emTXsuBpK78qU1AJUxbPOxPLgF6nV6T3nfMpb7b2PjIGGYD4P
         aFYUCpXl0NPtTeTlVUO673CLygvDXeN7QeQWzkYuZuo3N25xIJ4xKtYHCao3h6eC2w2E
         BeWq6eL2Ho//rMIQqoAq8ZRSihMqxYve+hlCPUp6ZCIe7SWArc5CHZd0vMty68vC2niQ
         WjHL7upe/Mq+mgtOAG6EUL0LyzRqGglmwD2hq1ST3WYTPLJCD687k5iPSSsTF5m7fg/6
         Yr5MHf6XDAUNrQku7z3aJbtJc8yWRQ11w0fY0eoGrBsKlVCrET/FNUZMSuqy0EgHPx4S
         htlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WD7zKr6reaJDn3nUGV+NxQL21xS/Xeyl4qUVkw9GnkY=;
        b=F8NL2tlFYyW1QA+AEOIKBzBEEuxGCNOaWJBFdw8uXn9Sv9fBfFYUE6wAtyndcgmTfw
         HpH+ICcEvlz98zvP8SC7lnUUvW/yy4aomd1kIA5Vw8T+S24I4er330aqwE5jR4hykJYj
         d046jl0mp6mWD0JkzXYU2a6zflLNIseVuNTdi5VYcaZW19XAAuFr/gAuQswJ6zCXQI82
         r9I/gjrAqED8K22vcrX6anW0b5AG8z1l/vL6obEckpreWQKDz5XtHCSqFe65fljzd1I+
         us2nWA3Xb/K5r2O0aw4A1FML5QLxcQzh8WCXk2ufRvuvmTPrfpfrldnA3zHndvoLrTJO
         MNaw==
X-Gm-Message-State: AOPr4FUM5KWlG47YWpWb3O+WArKAioaksYrlQkmxxC2stWRZro2/yLUyuNH6FNBkemRhrg==
X-Received: by 10.194.116.9 with SMTP id js9mr24956259wjb.112.1461346504712;
        Fri, 22 Apr 2016 10:35:04 -0700 (PDT)
Received: from localhost (cable-86-56-73-63.cust.telecolumbus.net. [86.56.73.63])
        by smtp.gmail.com with ESMTPSA id i194sm4392237wmf.6.2016.04.22.10.35.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 Apr 2016 10:35:04 -0700 (PDT)
X-Mailer: git-send-email 2.8.1.382.g1352ede
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292235>

Using the string-list API in function unsorted_string_list_lookup()
makes the code more readable.  So let's do this.

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 string-list.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/string-list.c b/string-list.c
index 2a32a3f..8127e12 100644
--- a/string-list.c
+++ b/string-list.c
@@ -231,12 +231,13 @@ void string_list_sort(struct string_list *list)
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string)
 {
-	int i;
+	struct string_list_item *item;
 	compare_strings_fn cmp = list->cmp ? list->cmp : strcmp;
 
-	for (i = 0; i < list->nr; i++)
-		if (!cmp(string, list->items[i].string))
-			return list->items + i;
+	for_each_string_list_item(item, list) {
+		if (!cmp(string, item->string))
+			return item;
+	}
 	return NULL;
 }
 
-- 
2.8.1.382.g1352ede
