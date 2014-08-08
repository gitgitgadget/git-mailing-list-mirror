From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH 07/22] refs-common.c: move the hidden refs functions to the common code
Date: Fri,  8 Aug 2014 09:44:54 -0700
Message-ID: <1407516309-27989-8-git-send-email-sahlberg@google.com>
References: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 08 18:45:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XFnIV-0007cZ-Gv
	for gcvg-git-2@plane.gmane.org; Fri, 08 Aug 2014 18:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988AbaHHQph (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2014 12:45:37 -0400
Received: from mail-qg0-f73.google.com ([209.85.192.73]:54232 "EHLO
	mail-qg0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756397AbaHHQpR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2014 12:45:17 -0400
Received: by mail-qg0-f73.google.com with SMTP id q107so765288qgd.2
        for <git@vger.kernel.org>; Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2/VmmMBGXXsncydBcK7JOhqlFVmjngzS5jgCldv/NeU=;
        b=GhsYnQLGfiNUgaBBybvrwmkE3m/K8R854detO42iUyDoMPt8gOkc3YY7GfGyBTl9Ln
         VwjS8s5mBjepClTpRl7GYgIKR8CU+h78do7BbRmi+kbZgRgg3uECgEkAW8ltu5Kz4GSM
         4x2ujm5C9Rm3JFd27jGjhVL0xJRomb/AE9BnX7VS2WYxSpAZB5Kao5dGeCUOyBLA7ZJY
         C4+bH6/g/EnjNvZpUIDgVkFTc/uCvaF85Zq16pPaFExJM/6xXxOlzGjt7tkjNCEcs7R7
         R7kWgZ73k1h12sO8uQDYNcjOGGUijvTvCEEONvdFnwiJRGyL/FlEiiXNuuncfG7H4Pfm
         cPoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2/VmmMBGXXsncydBcK7JOhqlFVmjngzS5jgCldv/NeU=;
        b=IQIWmtC7UE9RjIRILV2Fuw9LO5N6n/38orZVdd9eLtU6yczZCJq9lEpLZl5HID/G9i
         EdvrtYms7NPgwOmzT98hhpL9xtoiZeUWDVIVSslm5z2A/BDx6iCsa4wpeG/fsT/Jhtyr
         c0DISWhF6U64U2uIJmrrxsxSm8IpnTipal1f4KnEmxJS0xqIn6pmz463wFd98v1CyN9O
         cLNo911YxxiFc4qtK6SPAYWFWGseuZc8ogk2CfLjzQjTY9aiWoTytPkuBdPJkBDVRsJb
         EJKc7s0r/qtbdKb/5L+IF+rnMptWSOUIFc/DQdBznDwGk3DgL06R4c6xVsXC2kv9mhcU
         z7/g==
X-Gm-Message-State: ALoCoQm9Eb4gkttSd1IBZwQ3PZN7B8iIIqcMWW1E4rLDGOkvXMDuRmI95wQfqjbtCvCvqGZRmOMd
X-Received: by 10.236.112.6 with SMTP id x6mr5279225yhg.42.1407516315836;
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id y50si504380yhk.4.2014.08.08.09.45.15
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 08 Aug 2014 09:45:15 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id A12E35A4616;
	Fri,  8 Aug 2014 09:45:15 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id 479AAE0C50; Fri,  8 Aug 2014 09:45:14 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.553.geee1b3e
In-Reply-To: <1407516309-27989-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255029>

This change moves the hidden refs functions to the refs-common.c file since
these functions do not contain any backend specific code.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
---
 refs-common.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 refs.c        | 43 -------------------------------------------
 2 files changed, 44 insertions(+), 43 deletions(-)

diff --git a/refs-common.c b/refs-common.c
index 3d7354e..c40fa96 100644
--- a/refs-common.c
+++ b/refs-common.c
@@ -1,6 +1,7 @@
 /* common code for all ref backends */
 #include "cache.h"
 #include "refs.h"
+#include "string-list.h"
 
 int update_ref(const char *action, const char *refname,
 	       const unsigned char *sha1, const unsigned char *oldval,
@@ -249,3 +250,46 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
 
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
diff --git a/refs.c b/refs.c
index 52ca0bb..6181edf 100644
--- a/refs.c
+++ b/refs.c
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
-- 
2.0.1.553.geee1b3e
