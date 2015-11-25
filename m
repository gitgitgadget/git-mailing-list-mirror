From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 4/9] submodule-config: remove name_and_item_from_var
Date: Tue, 24 Nov 2015 17:14:51 -0800
Message-ID: <1448414096-22021-5-git-send-email-sbeller@google.com>
References: <1448414096-22021-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 25 02:15:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Og5-000180-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 02:15:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755432AbbKYBPQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2015 20:15:16 -0500
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34571 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755051AbbKYBPH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2015 20:15:07 -0500
Received: by padhx2 with SMTP id hx2so39242097pad.1
        for <git@vger.kernel.org>; Tue, 24 Nov 2015 17:15:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fRQ+93aL1cn+u0naGjBY+G3EyxHWVSuxo4ENRLBZtNI=;
        b=DAOTDjvkdkXfdGX9w9JLJSriF33BIA+4IbSq8hyXa0u2TYO00h3dm0fONVJVGmauXs
         QcfCCCQwvbNBnlMX637msgusyF+Ax2qy1bLMxz9bp9x/4stmDiqyCi7Ev0uEzOMMVbYA
         bkH3WncI6kmOIxx9FZtBrRADvUwTN2mkxCdc2QKtC4xF+eFu2TW1oxI/TgOEVlWYWYlZ
         FvBovuR507DbMgF7Bw9Dgs0lf5AnJVI+94HeIsTkfupVY3Ix8u8MAGMmd6ephiC8WKOg
         0DVd9dJEb59PT2H3hft7FHrM6KGziuaSJq1aN9X0Zim2Hxglz5IMtVnzMm9sw9sGPmxA
         GNwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fRQ+93aL1cn+u0naGjBY+G3EyxHWVSuxo4ENRLBZtNI=;
        b=j8X3mkh8qUCgbxFLc8jpqgK+4McT+PBVQKD0ouHYt1ufvzm7G0bfVs1pT68/kfYo1l
         527LcC/1L1aMoSg0t/3l+eOqTwvTcX9CKFWGAfuj98q6OEhdh85qnnfvTISr3MiMI2Vg
         KXgGKKhcJ8lTQS3bsuujn0Vj+gJB6JyI0MAaQduARb5MVFQu8hf1YBDTatpY7YMnDWBx
         KVFkURG88SbS6+ZkEE0iWytbEHDf4go2kRnFyEHFVnfLi44n6ZRd2AFcrPwRVsGemzgD
         vqV5sTKsNoMpQ5oFPqJs2nykgjWdllN+UE3ddYfnaMiGmo2TCD4iueEvN56wDQauhHmh
         RtvQ==
X-Gm-Message-State: ALoCoQljUDoOlpttmr1//4CYW7Vhm3Kncf8rUASQhHTQHkjVyKR3lcW8K30SRUJJbtF/743xX+d5
X-Received: by 10.98.12.8 with SMTP id u8mr27785118pfi.76.1448414106968;
        Tue, 24 Nov 2015 17:15:06 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5407:71cc:c14:4343])
        by smtp.gmail.com with ESMTPSA id c1sm17332186pas.1.2015.11.24.17.15.06
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 24 Nov 2015 17:15:06 -0800 (PST)
X-Mailer: git-send-email 2.6.1.261.g0d9c4c1
In-Reply-To: <1448414096-22021-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281664>

`name_and_item_from_var` does not provide the proper abstraction
we need here in a later patch.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 48 ++++++++++++++++--------------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6d01941..b826841 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -161,31 +161,17 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	return NULL;
 }
 
-static int name_and_item_from_var(const char *var, struct strbuf *name,
-				  struct strbuf *item)
-{
-	const char *subsection, *key;
-	int subsection_len, parse;
-	parse = parse_config_key(var, "submodule", &subsection,
-			&subsection_len, &key);
-	if (parse < 0 || !subsection)
-		return 0;
-
-	strbuf_add(name, subsection, subsection_len);
-	strbuf_addstr(item, key);
-
-	return 1;
-}
-
 static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
-		const unsigned char *gitmodules_sha1, const char *name)
+						  const unsigned char *gitmodules_sha1,
+						  const char *name_ptr, int name_len)
 {
 	struct submodule *submodule;
 	struct strbuf name_buf = STRBUF_INIT;
+	char *name = xmemdupz(name_ptr, name_len);
 
 	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
 	if (submodule)
-		return submodule;
+		goto out;
 
 	submodule = xmalloc(sizeof(*submodule));
 
@@ -201,7 +187,8 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 	hashcpy(submodule->gitmodules_sha1, gitmodules_sha1);
 
 	cache_add(cache, submodule);
-
+out:
+	free(name);
 	return submodule;
 }
 
@@ -251,18 +238,18 @@ static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
-	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
-	int ret = 0;
+	int subsection_len, ret = 0;
+	const char *subsection, *key;
 
-	/* this also ensures that we only parse submodule entries */
-	if (!name_and_item_from_var(var, &name, &item))
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0 || !subsection_len)
 		return 0;
 
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     name.buf);
+					     subsection, subsection_len);
 
-	if (!strcmp(item.buf, "path")) {
+	if (!strcmp(key, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
@@ -275,7 +262,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -286,7 +273,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(item.buf, "ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
@@ -302,7 +289,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "url")) {
+	} else if (!strcmp(key, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
@@ -312,7 +299,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "update")) {
+	} else if (!strcmp(key, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->update)
@@ -324,9 +311,6 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	}
 
-	strbuf_release(&name);
-	strbuf_release(&item);
-
 	return ret;
 }
 
-- 
2.6.1.261.g0d9c4c1
