From: Stefan Beller <sbeller@google.com>
Subject: [PATCH 7/9] submodule config: remove name_and_item_from_var
Date: Tue, 27 Oct 2015 11:15:51 -0700
Message-ID: <1445969753-418-8-git-send-email-sbeller@google.com>
References: <1445969753-418-1-git-send-email-sbeller@google.com>
Cc: jacob.keller@gmail.com, peff@peff.net, gitster@pobox.com,
	jrnieder@gmail.com, johannes.schindelin@gmail.com,
	Jens.Lehmann@web.de, ericsunshine@gmail.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 27 19:16:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zr8nN-0003IA-UY
	for gcvg-git-2@plane.gmane.org; Tue, 27 Oct 2015 19:16:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbbJ0SQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 14:16:12 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33559 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965115AbbJ0SQK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 14:16:10 -0400
Received: by pabla5 with SMTP id la5so36455308pab.0
        for <git@vger.kernel.org>; Tue, 27 Oct 2015 11:16:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RS4PGSLlqJ4vsQfqRwhTBOqM1cZoQazc6fFO6lUt2og=;
        b=kD+8y3inHbCINVQs5vtNxxaazSe9U8NeZGOIOhVXg+1ruoJax1g+C/CXDhPphSirpG
         YTD3A92EGy2FzpENIWm2oUq6i8EnL9i48t0x4FpYJW1Tglv4BM20aLds/07YzBe7OR/q
         70gDTMJRWvy9Jd0FxCDImZ2vbrtKPQhD5iGgpp20RD/5jEflgpp5UwlDAvLx/r+HXaKX
         ViJX4el5rXNxxTVboxUrjKQzYA+rd2Scz1H5KUVeW5Fb+kQupRf4rcFY+IRjIk9tYEiC
         dCz/yUCzh0fdpjhyuNNsoJGugbYTrRRn5pUMEiEIyTA/WzJYVf2qR5sOLNAkNl6sEAKl
         6Stg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RS4PGSLlqJ4vsQfqRwhTBOqM1cZoQazc6fFO6lUt2og=;
        b=TS39y/LBOUh/Qb9ow8DMg3ilSduC5pwxkhtaMiyG6xejKSXHueeCICEgfsLBeHeHC3
         Z7Zxb/EP5Htrf7fgP0eJPnyw2UxX1ukDCfsznFnLzYBwRwDRc4t6QDzkxO79QMsyJ8NS
         rjCoOASLlY0NIuFHD/vIu6bNXPvkhHKNjOIh2fL9NAwrEqyTeKUkDoeTU3Tpf9v6w/FJ
         h+kGb8XXaROtX80P3/zXFORcCzd3KvIiCvfNoFRMtqGTSS3RFQOob98ATUAI1xgMM5x9
         OaLeGMCvgTrf6iduwmYyxSuyEg8x7Dy5nZF1XEDEd8jKeGU+5XMxTSo57j1VkKhi0u7P
         KVzw==
X-Gm-Message-State: ALoCoQkvO4rfTNuzCRupjeEDAtMws7WpbYC2OyeSA+289tT0i/y3DXWeucGRJlSTMq0l5f6g0Lv6
X-Received: by 10.67.2.34 with SMTP id bl2mr17163791pad.63.1445969769768;
        Tue, 27 Oct 2015 11:16:09 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:582c:77b:3135:2d26])
        by smtp.gmail.com with ESMTPSA id wq1sm6491169pbc.49.2015.10.27.11.16.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 27 Oct 2015 11:16:09 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.283.g1a79c94.dirty
In-Reply-To: <1445969753-418-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280277>

By inlining `name_and_item_from_var` it is easy to add later options
which are not required to have a submodule name.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 46 +++++++++++++++++-----------------------------
 1 file changed, 17 insertions(+), 29 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 8b8c7d1..4d0563c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -161,22 +161,6 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
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
 		const unsigned char *gitmodules_sha1, const char *name)
 {
@@ -251,18 +235,25 @@ static int parse_config(const char *var, const char *value, void *data)
 {
 	struct parse_config_parameter *me = data;
 	struct submodule *submodule;
-	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
-	int ret = 0;
+	int subsection_len, ret = 0;
+	const char *subsection, *key;
+	char *name;
 
-	/* this also ensures that we only parse submodule entries */
-	if (!name_and_item_from_var(var, &name, &item))
+	if (parse_config_key(var, "submodule", &subsection,
+			     &subsection_len, &key) < 0)
 		return 0;
 
+	if (!subsection_len)
+		return 0;
+
+	/* subsection is not null terminated */
+	name = xmemdupz(subsection, subsection_len);
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     name.buf);
+					     name);
+	free(name);
 
-	if (!strcmp(item.buf, "path")) {
+	if (!strcmp(key, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path != NULL)
@@ -275,7 +266,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -286,7 +277,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(item.buf, "ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore != NULL)
@@ -302,7 +293,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "url")) {
+	} else if (!strcmp(key, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url != NULL) {
@@ -312,7 +303,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "update")) {
+	} else if (!strcmp(key, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->update != NULL)
@@ -324,9 +315,6 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	}
 
-	strbuf_release(&name);
-	strbuf_release(&item);
-
 	return ret;
 }
 
-- 
2.5.0.283.g1a79c94.dirty
