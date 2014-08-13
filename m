From: Ronnie Sahlberg <sahlberg@google.com>
Subject: [PATCH v2 07/23] refs-common.c: move the hidden refs functions to the common code
Date: Wed, 13 Aug 2014 13:14:51 -0700
Message-ID: <1407960907-18189-8-git-send-email-sahlberg@google.com>
References: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Cc: Ronnie Sahlberg <sahlberg@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 13 22:16:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XHexn-00009i-8J
	for gcvg-git-2@plane.gmane.org; Wed, 13 Aug 2014 22:16:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753850AbaHMUP7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Aug 2014 16:15:59 -0400
Received: from mail-vc0-f201.google.com ([209.85.220.201]:46798 "EHLO
	mail-vc0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753536AbaHMUPL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Aug 2014 16:15:11 -0400
Received: by mail-vc0-f201.google.com with SMTP id le20so36034vcb.0
        for <git@vger.kernel.org>; Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=maC0ZPLjBchgjygw6FWJzNi+lKhU9NR7Nnq3Lboj3JE=;
        b=ntGmPETFTk+Z8D///4eVhUQIcwm3syj9YnoZ1ovGP5FXJd7cgqNekUFR4cKjMdySf0
         fdhjMY6hihRtkJZBKH1jUryWrnyNX+V2o5kWEc9GTpJIGgXaorSIf81rGNcr7TjzyGBW
         CeFOfQfQWjhgKOLn4wikH+1hHYfWn/6drZRTVbVSPFa4wYHB0KlqcHVdZBF/akIobAq8
         lp/jUZUIGWLd7xgfId9qKp4eib2bFuIuO8+lQh5WA558uexaXr2Oo3C+FD5ZO0CpZzbA
         KbnPV2uLkcaoO3oCNXFoWO0qy+AyOBO9DtJUDXFWCh3RXednWRpir8gkNuYopyFBc2tt
         ZDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=maC0ZPLjBchgjygw6FWJzNi+lKhU9NR7Nnq3Lboj3JE=;
        b=WS/xwPm6oxjgnWCBrkpexFo4tDs3v5ZF3YRafpM3PJduVM6nUd2ugiq4W0F4tmlHli
         S29j5PuY9OUp+CnZBOkB4yAPtNqimDZHR1jsXNfmXXiwTj5E5tK8fMAfSXy+TZOQzixa
         iuEdu4AkzKf4c5GmR3xTKh4RimrEHM2aVuLmgRGZJX/BJxOeloYYz32ZAvUZGnt52H2x
         UfPq4qqSAhwk0xf3mROpTfSolq9JOZRT0aoL/XNjxiqdqziYmDEQ61Lw0vOZrxJ48EB3
         bsAxwGlF7AQq7R70UszH65ZOiuiRqBwriAQvfeiIzwZ0GVK7F8Y7/ih30oRpGJhSsVsV
         jKgw==
X-Gm-Message-State: ALoCoQm2qhZlI+9TabWSeT11xV2GhADbaKNIG+qq4/EWXepEea5rr1Hbq8nWhqT5Lgrr+VEOzltI
X-Received: by 10.236.207.164 with SMTP id n24mr221229yho.5.1407960910365;
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id a66si207151yhg.7.2014.08.13.13.15.10
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: from sahlberg1.mtv.corp.google.com (sahlberg1.mtv.corp.google.com [172.27.69.52])
	by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 3071C5A441C;
	Wed, 13 Aug 2014 13:15:10 -0700 (PDT)
Received: by sahlberg1.mtv.corp.google.com (Postfix, from userid 177442)
	id D3A9AE107B; Wed, 13 Aug 2014 13:15:09 -0700 (PDT)
X-Mailer: git-send-email 2.0.1.556.gfa712f7
In-Reply-To: <1407960907-18189-1-git-send-email-sahlberg@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255241>

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
2.0.1.556.g3edca4c
