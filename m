From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/7] notes.c: mark private file-scope symbols as static
Date: Sat, 15 Sep 2012 14:10:52 -0700
Message-ID: <1347743452-2487-7-git-send-email-gitster@pobox.com>
References: <5054AA62.2040603@ramsay1.demon.co.uk>
 <1347743452-2487-1-git-send-email-gitster@pobox.com>
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 15 23:11:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TCze3-0004wn-Jm
	for gcvg-git-2@plane.gmane.org; Sat, 15 Sep 2012 23:11:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753386Ab2IOVLJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Sep 2012 17:11:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:61955 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753096Ab2IOVLG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Sep 2012 17:11:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7459D8577;
	Sat, 15 Sep 2012 17:11:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=zYD8
	GOuyV9bZGiAweghM2yh/I88=; b=pzePbWZ91o6Zmky/D+lfJ0I5QAe2repbghRk
	cqAm2jJ0gDhSc6FHt7MyBqX6WSWv1/ZYGMKLTii7jn5nWpP5CpUtRICZm8r7ZWFB
	fPLDfRKmG1bobpcpn83jh1qYievBZeoyKRCIc7hD1mp0eKs83JGrthVNK1RkAYBL
	hXowzt8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	A1jB8uigjrxpC+bZRSuH4tj8inQQUnTcRKfFRpeZuQ+mupogTsqNKcWfl45Cdcr2
	ShysPUK0NMT1m/A1VQMAX2rRhPkBWbi2VzADgkCTz/gzGI8DPnnxY0ndVhnsfUBv
	HTdap/p+fAsQUs4yjZ/gUpeo9eCeDUSIzB72MGvv+Ic=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 60EE38576;
	Sat, 15 Sep 2012 17:11:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id BAF398574; Sat, 15 Sep 2012
 17:11:05 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.508.g4d78187
In-Reply-To: <1347743452-2487-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DCC32074-FF79-11E1-857B-18772E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205576>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 notes.c | 14 ++++++++++++--
 notes.h | 14 --------------
 2 files changed, 12 insertions(+), 16 deletions(-)

diff --git a/notes.c b/notes.c
index 93e9868..bc454e1 100644
--- a/notes.c
+++ b/notes.c
@@ -1196,8 +1196,18 @@ void free_notes(struct notes_tree *t)
 	memset(t, 0, sizeof(struct notes_tree));
 }
 
-void format_note(struct notes_tree *t, const unsigned char *object_sha1,
-		struct strbuf *sb, const char *output_encoding, int flags)
+/*
+ * Fill the given strbuf with the notes associated with the given object.
+ *
+ * If the given notes_tree structure is not initialized, it will be auto-
+ * initialized to the default value (see documentation for init_notes() above).
+ * If the given notes_tree is NULL, the internal/default notes_tree will be
+ * used instead.
+ *
+ * 'flags' is a bitwise combination of the flags for format_display_notes.
+ */
+static void format_note(struct notes_tree *t, const unsigned char *object_sha1,
+			struct strbuf *sb, const char *output_encoding, int flags)
 {
 	static const char utf8[] = "utf-8";
 	const unsigned char *sha1;
diff --git a/notes.h b/notes.h
index c716694..3592b19 100644
--- a/notes.h
+++ b/notes.h
@@ -241,20 +241,6 @@ void free_notes(struct notes_tree *t);
 #define NOTES_SHOW_HEADER 1
 #define NOTES_INDENT 2
 
-/*
- * Fill the given strbuf with the notes associated with the given object.
- *
- * If the given notes_tree structure is not initialized, it will be auto-
- * initialized to the default value (see documentation for init_notes() above).
- * If the given notes_tree is NULL, the internal/default notes_tree will be
- * used instead.
- *
- * 'flags' is a bitwise combination of the above formatting flags.
- */
-void format_note(struct notes_tree *t, const unsigned char *object_sha1,
-		struct strbuf *sb, const char *output_encoding, int flags);
-
-
 struct string_list;
 
 struct display_notes_opt {
-- 
1.7.12.508.g4d78187
