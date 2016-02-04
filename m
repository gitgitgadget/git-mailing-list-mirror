From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv8 3/9] submodule-config: remove name_and_item_from_var
Date: Thu,  4 Feb 2016 14:09:30 -0800
Message-ID: <1454623776-3347-4-git-send-email-sbeller@google.com>
References: <1454623776-3347-1-git-send-email-sbeller@google.com>
Cc: jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Feb 04 23:10:02 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRS69-0007Fz-D4
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 23:09:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbcBDWJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Feb 2016 17:09:51 -0500
Received: from mail-pf0-f182.google.com ([209.85.192.182]:33447 "EHLO
	mail-pf0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965103AbcBDWJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 17:09:48 -0500
Received: by mail-pf0-f182.google.com with SMTP id w123so56960636pfb.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2016 14:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6gWok9xaFZp2CUw3Hc/9tGPH1qemd5qqtNBAG0IA0VY=;
        b=pzpxU2/fuoJia7nZaZ1fPsEGABG6jq1+YMw/vBZHTmF2PbNlCFGEV+6OgE0jkJGmFA
         TPOqKDO6LRBZs+lBWz+woU9YyVviopWApuxDSpseXKNsnwQ3l4/FnWwUTF1YT0CN0qae
         2m0O5CXi+9MavjgCDMn3JO3f/oouePudjVEsAjsJwLIcY/hMns1ga2pCEWjP5r6JsL4i
         HZfKp2oMlAf97K6V6lUf/59jI/v1NOB2waayTzE8+zb/0nP/u1/1Qr4CS1N7K5tEdpwB
         0eEwLxNyap1yXJLA9oKAj7vXA6cbLT3xDNVJw605PaJ7wB0ULOjXnd3kbRy9xFnnqssm
         iApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6gWok9xaFZp2CUw3Hc/9tGPH1qemd5qqtNBAG0IA0VY=;
        b=Bj2KTkj+4o/QuZEngLe1dd2d1crX5A2cFr6KAgVFiPurIa17LAKtaylBWrVQ2t1RTq
         mIQuBh2TlnTq4nsBwuCzcuViaZopXijZFQm8lGqTy5nskwjvCHHaqUkZoa++oqH9V9W+
         bGriG+yp3sz+oGu/8mUC9lhFWvkfeWkK99NarRoJuIAsckgO5nA5PRH2iQFaM1avhloo
         Z+Xoa8Gv+KeaON9eoGe7h6UV1pj+uTvckwOyCMh9E189FmqnYr1S5HJ6z0G/YMP5Hmn4
         uegpL+Vazu/ki7fyNtJDJE7pF4BNX9oCOk4jUcm1rWFzb+/Z3u1YMpf+xBG1ilMzKVXT
         g44A==
X-Gm-Message-State: AG10YOS4sPH9jFRMAeJ1rLrbHVTRDeMZ+igzCCTpHVBS3prVx6VY1OFuWjyii1X9woehCF/g
X-Received: by 10.98.67.14 with SMTP id q14mr14704568pfa.137.1454623787957;
        Thu, 04 Feb 2016 14:09:47 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:5194:ebf5:4051:c1fd])
        by smtp.gmail.com with ESMTPSA id ux2sm19299263pac.46.2016.02.04.14.09.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 14:09:47 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.41.gd102984.dirty
In-Reply-To: <1454623776-3347-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285501>

`name_and_item_from_var` does not provide the proper abstraction
we need here in a later patch. As we have only a single call site
for `name_and_item_from_var`, just inline it. Instead of using
strbufs, use direct char *.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 40 +++++++++++-----------------------------
 1 file changed, 11 insertions(+), 29 deletions(-)

diff --git a/submodule-config.c b/submodule-config.c
index 6d01941..c08ee7f 100644
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
@@ -251,18 +235,19 @@ static int parse_config(const char *var, const char *value, void *data)
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
+			     &subsection_len, &key) < 0 || !subsection)
 		return 0;
 
+	subsection = xmemdupz(subsection, subsection_len);
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     name.buf);
+					     subsection);
 
-	if (!strcmp(item.buf, "path")) {
+	if (!strcmp(key, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
@@ -275,7 +260,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
+	} else if (!strcmp(key, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -286,7 +271,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(item.buf, "ignore")) {
+	} else if (!strcmp(key, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
@@ -302,7 +287,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "url")) {
+	} else if (!strcmp(key, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
@@ -312,7 +297,7 @@ static int parse_config(const char *var, const char *value, void *data)
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(item.buf, "update")) {
+	} else if (!strcmp(key, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->update)
@@ -324,9 +309,6 @@ static int parse_config(const char *var, const char *value, void *data)
 		}
 	}
 
-	strbuf_release(&name);
-	strbuf_release(&item);
-
 	return ret;
 }
 
-- 
2.7.0.rc0.41.gd102984.dirty
