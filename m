From: Julian Phillips <julian@quantumfyre.co.uk>
Subject: [PATCH 4/6] string_list: Fix argument order for
	string_list_insert_at_index
Date: Tue, 06 Apr 2010 02:11:36 +0100
Message-ID: <20100406011139.71279.16319.julian@quantumfyre.co.uk>
References: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 06 03:28:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nyxb4-0007HK-KU
	for gcvg-git-2@lo.gmane.org; Tue, 06 Apr 2010 03:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932072Ab0DFB2v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 21:28:51 -0400
Received: from positron.quantumfyre.co.uk ([213.165.84.138]:45404 "EHLO
	positron.quantumfyre.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756659Ab0DFB2q (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 5 Apr 2010 21:28:46 -0400
Received: from reaper.quantumfyre.co.uk (reaper.quantumfyre.co.uk [212.159.54.234])
	by positron.quantumfyre.co.uk (Postfix) with ESMTP id 74824819C3A6;
	Tue,  6 Apr 2010 02:28:40 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id E09F220C8F2;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-Virus-Scanned: amavisd-new at reaper
Received: from reaper.quantumfyre.co.uk ([127.0.0.1])
	by localhost (reaper.quantumfyre.co.uk [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pUZZB8zisUeT; Tue,  6 Apr 2010 02:28:44 +0100 (BST)
Received: from rayne.quantumfyre.co.uk (rayne.quantumfyre.co.uk [192.168.0.18])
	by reaper.quantumfyre.co.uk (Postfix) with ESMTP id 86D5420C8E7;
	Tue,  6 Apr 2010 02:28:44 +0100 (BST)
X-git-sha1: 17db25ce493cfddeb78d3cb2fd58d1e8b141f800 
X-Mailer: git-mail-commits v0.5.3
In-Reply-To: <20100406011106.71279.92681.julian@quantumfyre.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144078>

Update the definition and callers of string_list_insert_at_index to
use the string_list as the first argument.  This helps make the
string_list API easier to use by being more consistent.

Signed-off-by: Julian Phillips <julian@quantumfyre.co.uk>
---
 mailmap.c     |    2 +-
 string-list.c |    6 +++---
 string-list.h |    4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/mailmap.c b/mailmap.c
index badf6a4..8b6dc36 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -69,7 +69,7 @@ static void add_mapping(struct string_list *map,
 		index = -1 - index;
 	} else {
 		/* create mailmap entry */
-		struct string_list_item *item = string_list_insert_at_index(index, old_email, map);
+		struct string_list_item *item = string_list_insert_at_index(map, index, old_email);
 		item->util = xmalloc(sizeof(struct mailmap_entry));
 		memset(item->util, 0, sizeof(struct mailmap_entry));
 		((struct mailmap_entry *)item->util)->namemap.strdup_strings = 1;
diff --git a/string-list.c b/string-list.c
index de89efd..84444c2 100644
--- a/string-list.c
+++ b/string-list.c
@@ -53,11 +53,11 @@ static int add_entry(int insert_at, struct string_list *list, const char *string
 
 struct string_list_item *string_list_insert(struct string_list *list, const char *string)
 {
-	return string_list_insert_at_index(-1, string, list);
+	return string_list_insert_at_index(list, -1, string);
 }
 
-struct string_list_item *string_list_insert_at_index(int insert_at,
-						     const char *string, struct string_list *list)
+struct string_list_item *string_list_insert_at_index(struct string_list *list,
+						     int insert_at, const char *string)
 {
 	int index = add_entry(insert_at, list, string);
 
diff --git a/string-list.h b/string-list.h
index 3d5a8de..a4e1919 100644
--- a/string-list.h
+++ b/string-list.h
@@ -30,8 +30,8 @@ int string_list_has_string(const struct string_list *list, const char *string);
 int string_list_find_insert_index(const struct string_list *list, const char *string,
 				  int negative_existing_index);
 struct string_list_item *string_list_insert(struct string_list *list, const char *string);
-struct string_list_item *string_list_insert_at_index(int insert_at,
-						     const char *string, struct string_list *list);
+struct string_list_item *string_list_insert_at_index(struct string_list *list,
+						     int insert_at, const char *string);
 struct string_list_item *string_list_lookup(const char *string, struct string_list *list);
 
 /* Use these functions only on unsorted lists: */
-- 
1.7.0.2
