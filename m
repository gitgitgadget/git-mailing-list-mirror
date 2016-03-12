From: Paul Tan <pyokagan@gmail.com>
Subject: [PATCH/RFC/GSoC 13/17] rebase-todo: introduce rebase_todo_list
Date: Sat, 12 Mar 2016 18:46:33 +0800
Message-ID: <1457779597-6918-14-git-send-email-pyokagan@gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>, sam.halliday@gmail.com,
	Paul Tan <pyokagan@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Mar 12 11:47:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aeh5K-0006B3-32
	for gcvg-git-2@plane.gmane.org; Sat, 12 Mar 2016 11:47:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbcCLKrl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Mar 2016 05:47:41 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33217 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751523AbcCLKrf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Mar 2016 05:47:35 -0500
Received: by mail-pa0-f48.google.com with SMTP id fl4so118966450pad.0
        for <git@vger.kernel.org>; Sat, 12 Mar 2016 02:47:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z0dEBqum/ZLYpdEE9e2gcN8bx4a15qG0GbF65i1fM5Y=;
        b=Sznb2iqmRO54jQCKp+ZRykg127EJZuwKL719Kln3idwxU1Mhf65LE0p4ko+jX1F7J2
         2rLjPzikZtzYg2CSN2gZOtREDFK4qA1vWb1flIW4mkIxc3GoZ5eR3lHsFz5L3Eolu0oC
         FlfZ7r9nGS/FCKrF6kJGphXfwpKvI0ECWfmM8nhBrDnznnOd3X1Zn0uu+GdfWa/W8ltR
         yc9/C8JK4z1fJ784HIHH2/9IMYkbv00brcTCypYw0CKn+GHU0LT8YkHKHT0suEfu/zHP
         x++3ZNP27Ehh4mbKgzlTtvdJ+0ZFNEOurRRxZExYKjDZXH9n/FFbd8Bi2qHo4N1cF8dG
         9afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z0dEBqum/ZLYpdEE9e2gcN8bx4a15qG0GbF65i1fM5Y=;
        b=TU0uHTbVSeM6A1mj6pkiYQZk8jg4ksDb5S0FtATffFg6KtArs3fa7Vqt5SvGX1bGOA
         PaP/J3JC/Ot/yWHY/7fxHS8Kl4hMWu2uvrB5U+wNDp9bz1BL8lqcltHEQOdvVPZBSK/3
         p86oLrsgjvmlJ2GSVqkgUwFcKMnkQjf8FRu9PyGjw5kGLVKtjyPyp38mMo7x+9DUoeyo
         LsBnoVyamqV4WieGuVtkbjZg4+MSlTkaH1cdyExqzPNtEqQ902RvwlKAgou0AvfvMBHd
         TkPjAB8P2NTDLSaPM7tek+bqBPqBiA/7jvB6RabFbInbzM54vf024GQ5y8CbQ/IA624m
         v0/A==
X-Gm-Message-State: AD7BkJLIA3Yvb5nA6KZzM+4DwHke79T7Mu+7zbFQOuKerhy09f71s6eENU3xc3lck+J/9g==
X-Received: by 10.66.65.137 with SMTP id x9mr22546750pas.137.1457779655116;
        Sat, 12 Mar 2016 02:47:35 -0800 (PST)
Received: from yoshi.chippynet.com ([116.86.77.230])
        by smtp.gmail.com with ESMTPSA id tb10sm18983519pab.22.2016.03.12.02.47.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 12 Mar 2016 02:47:34 -0800 (PST)
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288745>

Implement rebase_todo_list, which is a resizable array of
rebase_todo_items.

Signed-off-by: Paul Tan <pyokagan@gmail.com>
---
 rebase-todo.c | 107 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 rebase-todo.h |  27 +++++++++++++++
 2 files changed, 134 insertions(+)

diff --git a/rebase-todo.c b/rebase-todo.c
index ac6b222..4f14638 100644
--- a/rebase-todo.c
+++ b/rebase-todo.c
@@ -142,3 +142,110 @@ void strbuf_add_rebase_todo_item(struct strbuf *sb,
 
 	strbuf_addch(sb, '\n');
 }
+
+void rebase_todo_list_init(struct rebase_todo_list *list)
+{
+	list->items = NULL;
+	list->nr = 0;
+	list->alloc = 0;
+}
+
+void rebase_todo_list_clear(struct rebase_todo_list *list)
+{
+	unsigned int i;
+
+	for (i = 0; i < list->nr; i++)
+		rebase_todo_item_release(&list->items[i]);
+	free(list->items);
+	rebase_todo_list_init(list);
+}
+
+void rebase_todo_list_swap(struct rebase_todo_list *dst,
+			   struct rebase_todo_list *src)
+{
+	struct rebase_todo_list tmp = *dst;
+
+	*dst = *src;
+	*src = tmp;
+}
+
+unsigned int rebase_todo_list_count(const struct rebase_todo_list *list)
+{
+	unsigned int i, count = 0;
+
+	for (i = 0; i < list->nr; i++)
+		if (list->items[i].action != REBASE_TODO_NONE)
+			count++;
+	return count;
+}
+
+struct rebase_todo_item *rebase_todo_list_push(struct rebase_todo_list *list, const struct rebase_todo_item *src_item)
+{
+	struct rebase_todo_item *item = rebase_todo_list_push_empty(list);
+
+	rebase_todo_item_copy(item, src_item);
+	return item;
+}
+
+struct rebase_todo_item *rebase_todo_list_push_empty(struct rebase_todo_list *list)
+{
+	struct rebase_todo_item *item;
+
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	item = &list->items[list->nr++];
+	rebase_todo_item_init(item);
+	return item;
+}
+
+struct rebase_todo_item *rebase_todo_list_push_noop(struct rebase_todo_list *list)
+{
+	struct rebase_todo_item *item = rebase_todo_list_push_empty(list);
+
+	item->action = REBASE_TODO_NOOP;
+	return item;
+}
+
+int rebase_todo_list_load(struct rebase_todo_list *list, const char *path, int abbrev)
+{
+	struct strbuf sb = STRBUF_INIT;
+	FILE *fp;
+
+	fp = fopen(path, "r");
+	if (!fp)
+		return error(_("could not open %s for reading"), path);
+
+	while (strbuf_getline(&sb, fp) != EOF) {
+		struct rebase_todo_item *item = rebase_todo_list_push_empty(list);
+		if (rebase_todo_item_parse(item, sb.buf, abbrev) < 0) {
+			rebase_todo_item_release(item);
+			list->nr--;
+			strbuf_release(&sb);
+			fclose(fp);
+			return -1;
+		}
+	}
+	strbuf_release(&sb);
+	fclose(fp);
+	return 0;
+}
+
+void rebase_todo_list_save(const struct rebase_todo_list *list, const char *filename, unsigned int offset, int abbrev)
+{
+	char *tmpfile = mkpathdup("%s.new", filename);
+	struct strbuf sb = STRBUF_INIT;
+	int fd;
+
+	for (; offset < list->nr; offset++)
+		strbuf_add_rebase_todo_item(&sb, &list->items[offset], abbrev);
+
+	fd = xopen(tmpfile, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (write_in_full(fd, sb.buf, sb.len) != sb.len)
+		die_errno(_("could not write to %s"), tmpfile);
+	close(fd);
+	strbuf_release(&sb);
+
+	if (rename(tmpfile, filename))
+		die_errno(_("rename failed"));
+
+	free(tmpfile);
+}
diff --git a/rebase-todo.h b/rebase-todo.h
index 2eedbb0..f602fd2 100644
--- a/rebase-todo.h
+++ b/rebase-todo.h
@@ -25,4 +25,31 @@ int rebase_todo_item_parse(struct rebase_todo_item *, const char *line, int abbr
 
 void strbuf_add_rebase_todo_item(struct strbuf *, const struct rebase_todo_item *, int abbrev);
 
+struct rebase_todo_list {
+	struct rebase_todo_item *items;
+	unsigned int nr, alloc;
+};
+
+#define REBASE_TODO_LIST_INIT { NULL, 0, 0 }
+
+void rebase_todo_list_init(struct rebase_todo_list *);
+
+void rebase_todo_list_clear(struct rebase_todo_list *);
+
+void rebase_todo_list_swap(struct rebase_todo_list *dst, struct rebase_todo_list *src);
+
+unsigned int rebase_todo_list_count(const struct rebase_todo_list *);
+
+struct rebase_todo_item *rebase_todo_list_push(struct rebase_todo_list *,
+					       const struct rebase_todo_item *);
+
+struct rebase_todo_item *rebase_todo_list_push_empty(struct rebase_todo_list *);
+
+struct rebase_todo_item *rebase_todo_list_push_noop(struct rebase_todo_list *);
+
+int rebase_todo_list_load(struct rebase_todo_list *, const char *path, int abbrev);
+
+void rebase_todo_list_save(const struct rebase_todo_list *, const char *path,
+			   unsigned int offset, int abbrev);
+
 #endif /* REBASE_TODO_H */
-- 
2.7.0
