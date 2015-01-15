From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH] string-list: remove print_string_list from string-list's API
Date: Thu, 15 Jan 2015 23:42:05 +0600
Message-ID: <1421343725-3973-1-git-send-email-kuleshovmail@gmail.com>
Cc: git@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 15 18:42:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YBoQz-0003bb-65
	for gcvg-git-2@plane.gmane.org; Thu, 15 Jan 2015 18:42:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763AbbAORmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2015 12:42:13 -0500
Received: from mail-lb0-f182.google.com ([209.85.217.182]:34225 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752483AbbAORmM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2015 12:42:12 -0500
Received: by mail-lb0-f182.google.com with SMTP id u10so14436743lbd.13
        for <git@vger.kernel.org>; Thu, 15 Jan 2015 09:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=CW5YYUWAoCnJQwsuKmX4S0D8VFHULNOTG/H3lFyFCVQ=;
        b=XoubyoV4MnrbKnzx1pp7GBcLeAYeWBWv5FO/NzIG7ghbKu3+I+FFEk6nFyG0OTGtHk
         A6mR1QkrIOVcRJygbI04cuG7aKIaPmCK5Ff7RL/d12X0v3eagUCeMToBnhy1VRKbUf/y
         E53XMr8zJrxmLWF9b2Mj0u7q+aX2LGz/Ef3mWcidJsfev6LxGPjBOGrycK1IW+gmS61P
         1rZm23Cg7jHQ++S4fs6T+Ho+lFZCELzzhlmpVPiR8XEAblc8JWy7VR38R3mU8ww2RlOc
         ijqYZh9trmoXkj38/zBdVecH2dgk6A68fFgzpLG2OyM3bGLU++gSvCMGlxRLaf6KZx+q
         UsHQ==
X-Received: by 10.153.6.6 with SMTP id cq6mr11257028lad.23.1421343731042;
        Thu, 15 Jan 2015 09:42:11 -0800 (PST)
Received: from localhost.localdomain ([95.59.93.191])
        by mx.google.com with ESMTPSA id wq1sm210966lbb.24.2015.01.15.09.42.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Jan 2015 09:42:10 -0800 (PST)
X-Mailer: git-send-email 2.3.0.rc0.315.g0e14eda
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262491>

print_string_list routine has no callers anywhere.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 Documentation/technical/api-string-list.txt |  6 ------
 string-list.c                               | 10 ----------
 string-list.h                               |  1 -
 3 files changed, 17 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index c08402b..99e12e9 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -87,12 +87,6 @@ Functions
 	call free() on the util members of any items that have to be
 	deleted.  Preserve the order of the items that are retained.
 
-`print_string_list`::
-
-	Dump a string_list to stdout, useful mainly for debugging purposes. It
-	can take an optional header argument and it writes out the
-	string-pointer pairs of the string_list, each one in its own line.
-
 `string_list_clear`::
 
 	Free a string_list. The `string` pointer of the items will be freed in
diff --git a/string-list.c b/string-list.c
index 2a32a3f..ba832da 100644
--- a/string-list.c
+++ b/string-list.c
@@ -182,16 +182,6 @@ void string_list_clear_func(struct string_list *list, string_list_clear_func_t c
 	list->nr = list->alloc = 0;
 }
 
-
-void print_string_list(const struct string_list *p, const char *text)
-{
-	int i;
-	if ( text )
-		printf("%s\n", text);
-	for (i = 0; i < p->nr; i++)
-		printf("%s:%p\n", p->items[i].string, p->items[i].util);
-}
-
 struct string_list_item *string_list_append_nodup(struct string_list *list,
 						  char *string)
 {
diff --git a/string-list.h b/string-list.h
index d3809a1..c417bd5 100644
--- a/string-list.h
+++ b/string-list.h
@@ -20,7 +20,6 @@ struct string_list {
 
 void string_list_init(struct string_list *list, int strdup_strings);
 
-void print_string_list(const struct string_list *p, const char *text);
 void string_list_clear(struct string_list *list, int free_util);
 
 /* Use this function to call a custom clear function on each util pointer */
-- 
2.3.0.rc0.315.g0e14eda
