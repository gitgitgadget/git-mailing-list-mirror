From: David Turner <dturner@twopensource.com>
Subject: [PATCH v5 19/26] refs.c: move refname_is_safe to the common code
Date: Tue, 27 Oct 2015 22:14:20 -0400
Message-ID: <1445998467-11511-20-git-send-email-dturner@twopensource.com>
References: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Cc: David Turner <dturner@twopensource.com>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Wed Oct 28 03:16:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrGI8-0002UX-02
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 03:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755261AbbJ1CPS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 22:15:18 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34069 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755227AbbJ1CPO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 22:15:14 -0400
Received: by iody8 with SMTP id y8so86372495iod.1
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 19:15:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource_com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WmLzgv6zrzqL13gEJkLOxWKd/EA1vmn0T8AOfdx0LN8=;
        b=vehOY2PMLkdMO3N9Fvy+9GlEvKjVjQ1eTodmSHdeJYp7px0gNmo72vpKVKWgD54t7d
         M4NwLH8y5rUP3gNVqw0aXXa6O3swfEP8cuO477aiUlYZb/nuoCEI8APphhdy92ZuM7Fe
         lgAhR8Lyzv1IUfzHejo+rEpymsUCCp10/4y6hjKAxSszU34JuvP/6AZlU2dy3gKzJk92
         ncYkqNUG8BcQwQ4KFz7PjHd70ADtBhwpMbz51ShGM6vaN//2jBAVYZMkStV0yDX83CV6
         2IGtNUXLUOu5M3Ppy02j5MoKnWusjYXXT9pzDoQmFKWstWciJp7MeekQ7HI9h0h88ZK5
         prog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WmLzgv6zrzqL13gEJkLOxWKd/EA1vmn0T8AOfdx0LN8=;
        b=OiI9gkuDEiXroVWgvwuf/g1kRepJ/E8wTAIhta8ZtHQGFkWuYHG/BH0VL027PI2B4u
         ZTN6cOCg8mmP4GnRcadVQKIw6g14o1y64WR2Imc2pCBdXoY0lhehsnTU20spDX16Z3N3
         /H8jWvUMSZV82wQBjELv3gn8N0yoz0+hWSnDjs6bJ4s7MYOhZ4hufkdwqtOVsEdWUOmv
         acVOxdtI8e/QHBCb1NCk+dyDwDCkwqJVtpuU9Fhgu0DI/lE9qNJZpSh8ZBldSnhC3aW5
         x8MevIZwe25Rs3aP75UCy9WybRUL1PhJw/j8sRMmanvIhFqhWlOxGoZvzJCUCFMthhRE
         yW/A==
X-Gm-Message-State: ALoCoQnJvSQVpDXhjnmiequG9v8Jf3dyi2SEfY63N115MMjEu7EWPzOd6kw4OS3bSJqbXfwEB3+J
X-Received: by 10.107.169.18 with SMTP id s18mr45078458ioe.190.1445998513620;
        Tue, 27 Oct 2015 19:15:13 -0700 (PDT)
Received: from ubuntu.twitter.corp? ([8.25.196.25])
        by smtp.gmail.com with ESMTPSA id lo2sm9240077igb.17.2015.10.27.19.15.12
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 27 Oct 2015 19:15:12 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.658.g6d8523e-twtrsrc
In-Reply-To: <1445998467-11511-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280346>

This function does not contain any backend specific code so we move it
to the common code. This function might be used by other refs backends.

While we are doing so, we improve the comment's grammar and clarify a
safety rule.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: David Turner <dturner@twopensource.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs-be-files.c | 33 ---------------------------------
 refs.c          | 24 ++++++++++++++++++++++++
 refs.h          | 11 +++++++++++
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 156ab4f..0111282 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -196,39 +196,6 @@ static struct ref_dir *get_ref_dir(struct ref_entry *entry)
 	return dir;
 }
 
-/*
- * Check if a refname is safe.
- * For refs that start with "refs/" we consider it safe as long they do
- * not try to resolve to outside of refs/.
- *
- * For all other refs we only consider them safe iff they only contain
- * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
- * "config").
- */
-static int refname_is_safe(const char *refname)
-{
-	if (starts_with(refname, "refs/")) {
-		char *buf;
-		int result;
-
-		buf = xmalloc(strlen(refname) + 1);
-		/*
-		 * Does the refname try to escape refs/?
-		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
-		 * is not.
-		 */
-		result = !normalize_path_copy(buf, refname + strlen("refs/"));
-		free(buf);
-		return result;
-	}
-	while (*refname) {
-		if (!isupper(*refname) && *refname != '_')
-			return 0;
-		refname++;
-	}
-	return 1;
-}
-
 static struct ref_entry *create_ref_entry(const char *refname,
 					  const unsigned char *sha1, int flag,
 					  int check_name)
diff --git a/refs.c b/refs.c
index 9cafcc9..cd0ab21 100644
--- a/refs.c
+++ b/refs.c
@@ -949,3 +949,27 @@ int ref_transaction_verify(struct ref_transaction *transaction,
 				      NULL, old_sha1,
 				      flags, NULL, err);
 }
+
+int refname_is_safe(const char *refname)
+{
+	if (starts_with(refname, "refs/")) {
+		char *buf;
+		int result;
+
+		buf = xmalloc(strlen(refname) + 1);
+		/*
+		 * Does the refname try to escape refs/?
+		 * For example: refs/foo/../bar is safe but refs/foo/../../bar
+		 * is not.
+		 */
+		result = !normalize_path_copy(buf, refname + strlen("refs/"));
+		free(buf);
+		return result;
+	}
+	while (*refname) {
+		if (!isupper(*refname) && *refname != '_')
+			return 0;
+		refname++;
+	}
+	return 1;
+}
diff --git a/refs.h b/refs.h
index 3d24c79..927b64d 100644
--- a/refs.h
+++ b/refs.h
@@ -396,6 +396,17 @@ extern int for_each_reflog(each_ref_fn, void *);
  */
 extern int check_refname_format(const char *refname, int flags);
 
+/*
+ * Check if a refname is safe.
+ * For a ref that starts with "refs/", we consider it safe as long it does
+ * not try to resolve to outside of refs/.
+ *
+ * For all other refs we only consider them safe iff they only consist of
+ * upper case characters and '_' (like "HEAD" AND "MERGE_HEAD", and not like
+ * "config").
+ */
+extern int refname_is_safe(const char *refname);
+
 extern const char *prettify_refname(const char *refname);
 
 extern char *shorten_unambiguous_ref(const char *refname, int strict);
-- 
2.4.2.658.g6d8523e-twtrsrc
