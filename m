From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v3 08/23] refs.c: move the hidden refs functions to the common code
Date: Tue, 19 Aug 2014 09:30:32 -0700
Message-ID: <1408465847-30384-9-git-send-email-sahlberg@google.com>
References: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 19 18:32:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJmKZ-0002zZ-7p
	for gcvg-git-2@plane.gmane.org; Tue, 19 Aug 2014 18:32:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbaHSQb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 12:31:28 -0400
Received: from mail-pa0-f73.google.com ([209.85.220.73]:59903 "EHLO
	mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752503AbaHSQa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 12:30:58 -0400
Received: by mail-pa0-f73.google.com with SMTP id kx10so1761436pab.0
        for <git@vger.kernel.org>; Tue, 19 Aug 2014 09:30:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=u2gqUJBoCXf/EB8Ue937KVy35fIzzn0a53zw6IIXw5s=;
        b=SDlLo3NzmDeofwHe3cSo/g6jK/PdvsrvdOM7/Jh1HYyg+5Gtu4zZD6dDlQeknXXGAv
         N8uOGHfrZXAbutsxJ22xegPdZh7RyVgshBq+pHHusMZPgJOaIcVDkq7ah0h5QoGpSif4
         jHFpBAomOtmIYli0SeL+49amOciztpwp251M6oKG/iqwZfx16duwrJrZjW6tYymYkQf+
         6W1HuB20j6KEYyBKiU3fiifgSUwXcET679CuvPI10u6sQBG3P7561FnYpJq4qgQ7nJHK
         25Sw65zaK3nmNaeAnJJMUs9bfTgQJEQvcGLlTdgME9WjUHqN2XV3CXktoAsX/h505Loi
         NZCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=u2gqUJBoCXf/EB8Ue937KVy35fIzzn0a53zw6IIXw5s=;
        b=LcJp09rxg5TlJ8ToNW+pP/x3fBeOG/IPUk1iss1caSpWrOYzEBT3JU+CAPmVWosjN5
         kWdo+3fohc5hzhGwzpvODtPHVbs3nH0VA9x+1sjRY7VMYBEO3eGWVCaaCMWz+TBVB1+0
         sOXmfKBkxiS3tscvPaq+aoiMDLfK8QjKmePL4nSEkcIcoZJ2rkezJskqNqeLhyewLReF
         WXaE42g1FXtrsfci1rlOaceQqqPWdxqKez5hxfThb1AAmQLj9nMCKB1hi3pjZaaU9vPc
         AeZLt1lR7aGtzXgYpmd05FBUlC9CAi3/bDcmMGXUR31xtVimqRhPADd0++Wnf6tq8Fbd
         q77A==
X-Gm-Message-State: ALoCoQlFY9tvwOFXuGRrRFDsraxD0THqgiOzLDL8yDO0XjLwlct35AakkRfnYd3CrHLjpqnd5a03
X-Received: by 10.66.136.71 with SMTP id py7mr20280509pab.35.1408465853416;
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from corp2gmr1-1.hot.corp.google.com (corp2gmr1-1.hot.corp.google.com [172.24.189.92])
        by gmr-mx.google.com with ESMTPS id o69si329355yhp.6.2014.08.19.09.30.53
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-1.hot.corp.google.com (Postfix) with ESMTP id 32AFF31C534;
	Tue, 19 Aug 2014 09:30:53 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id A2C39E0E84; Tue, 19 Aug 2014 09:30:52 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.552.g1af257a
In-Reply-To: <1408465847-30384-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255492>

This change moves the hidden refs functions to the refs.c file since
these functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-be-files.c | 43 -------------------------------------------
 refs.c          | 44 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/refs-be-files.c b/refs-be-files.c
index 52ca0bb..6181edf 100644
--- a/refs-be-files.c
+++ b/refs-be-files.c
@@ -3796,46 +3796,3 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 	free(short_name);
 	return xstrdup(refname);
 }
-
-static struct string_list *hide_refs;
-
-int parse_hide_refs_config(const char *var, const char *value, const char *section)
-{
-	if (!strcmp("transfer.hiderefs", var) ||
-	    /* NEEDSWORK: use parse_config_key() once both are merged */
-	    (starts_with(var, section) && var[strlen(section)] == '.' &&
-	     !strcmp(var + strlen(section), ".hiderefs"))) {
-		char *ref;
-		int len;
-
-		if (!value)
-			return config_error_nonbool(var);
-		ref = xstrdup(value);
-		len = strlen(ref);
-		while (len && ref[len - 1] == '/')
-			ref[--len] = '\0';
-		if (!hide_refs) {
-			hide_refs = xcalloc(1, sizeof(*hide_refs));
-			hide_refs->strdup_strings = 1;
-		}
-		string_list_append(hide_refs, ref);
-	}
-	return 0;
-}
-
-int ref_is_hidden(const char *refname)
-{
-	struct string_list_item *item;
-
-	if (!hide_refs)
-		return 0;
-	for_each_string_list_item(item, hide_refs) {
-		int len;
-		if (!starts_with(refname, item->string))
-			continue;
-		len = strlen(item->string);
-		if (!refname[len] || refname[len] == '/')
-			return 1;
-	}
-	return 0;
-}
diff --git a/refs.c b/refs.c
index 072cd39..9e2059b 100644
--- a/refs.c
+++ b/refs.c
@@ -3,6 +3,7 @@
  */
 #include "cache.h"
 #include "refs.h"
+#include "string-list.h"
 
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
@@ -251,3 +252,46 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 
 	return 1;
 }
+
+static struct string_list *hide_refs;
+
+int parse_hide_refs_config(const char *var, const char *value, const char *section)
+{
+	if (!strcmp("transfer.hiderefs", var) ||
+	    /* NEEDSWORK: use parse_config_key() once both are merged */
+	    (starts_with(var, section) && var[strlen(section)] == '.' &&
+	     !strcmp(var + strlen(section), ".hiderefs"))) {
+		char *ref;
+		int len;
+
+		if (!value)
+			return config_error_nonbool(var);
+		ref = xstrdup(value);
+		len = strlen(ref);
+		while (len && ref[len - 1] == '/')
+			ref[--len] = '\0';
+		if (!hide_refs) {
+			hide_refs = xcalloc(1, sizeof(*hide_refs));
+			hide_refs->strdup_strings = 1;
+		}
+		string_list_append(hide_refs, ref);
+	}
+	return 0;
+}
+
+int ref_is_hidden(const char *refname)
+{
+	struct string_list_item *item;
+
+	if (!hide_refs)
+		return 0;
+	for_each_string_list_item(item, hide_refs) {
+		int len;
+		if (!starts_with(refname, item->string))
+			continue;
+		len = strlen(item->string);
+		if (!refname[len] || refname[len] == '/')
+			return 1;
+	}
+	return 0;
+}
-- 
2.0.1.552.g1af257a
