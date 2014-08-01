From: Tanay Abhra <tanayabh@gmail.com>
Subject: [PATCH v7 0/8] Rewrite `git_config()` using config-set API
Date: Fri,  1 Aug 2014 10:05:48 -0700
Message-ID: <1406912756-15517-1-git-send-email-tanayabh@gmail.com>
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 01 19:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDGI0-0001Wa-4E
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 19:06:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754714AbaHARGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 13:06:40 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:63728 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750851AbaHARGj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 13:06:39 -0400
Received: by mail-pd0-f171.google.com with SMTP id z10so5877469pdj.30
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 10:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=pwp99b5gniXdvczGbql/igzUV3tt1vXxxrqlSwU8Giw=;
        b=gvM+JukZ28JezLGl4hsvQTSCge59kptSp/WaMCW3XWq/2cPyxfjPr05gmjWIlsssdk
         JnTh49CHqlazKjNHlqVbffiP9aZsXeP4yau83y3L8dwaYK8c5fAF4Rd/qcSWAYhFvpFB
         xrZHKIlhEsES0OzD3Zd/l9Y21fBwvY5giv9r7ieCghIWGRug36wuOTEzKmHag5DnMJd3
         AH1RCaF5gzEy+IOQVaspjHpckAJ8QOlmMUiin4DepA2CW5QjpRWq8qBtMuKH6Tb1LbKY
         eTLwDyK+3xwz4tg4B7oJ78YfTt7auDJMFiBH4yonpbH15f+poGiNeSKQOF98dK3/zux9
         2SbA==
X-Received: by 10.66.139.164 with SMTP id qz4mr4386537pab.151.1406912799090;
        Fri, 01 Aug 2014 10:06:39 -0700 (PDT)
Received: from localhost.localdomain ([110.225.111.156])
        by mx.google.com with ESMTPSA id pz10sm9241121pbb.33.2014.08.01.10.06.34
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 10:06:38 -0700 (PDT)
X-Mailer: git-send-email 1.9.0.GIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254633>

[Patch v7]: style nit corrected. (1/8) is Matthieu's translation patch.
	git_die_config_linenr() helper function added. Diff between v6
	and v7 appended for review.

[Patch v6]: Added _(....) to error messages.
	Diff between v6 and v4 at the bottom.

[PATCH v5]: New patch added (3/7). git_config() now returns void.

[PATCH v4]: One style nit corrected, also added key to error messages.

[PATCH V3]:All the suggestions in [3] applied. Built on top of [1].

[PATCH V2]: All the suggestions in [2] incorporated. git_config() now follows
	correct parsing order. Reordered the patches. Removed xfuncname patch
	as it was unnecssary.

This series builds on the top of topic[1] in the mailing list with name
"git config cache & special querying API utilizing the cache".

This series aims to do these three things,

* Use the config-set API to rewrite git_config().

* Solve any legacy bugs in the previous system while at it.

* To be feature complete compared to the previous git_config() implementation,
	which I think it is now. (added the line number and file name info just for
	completeness)

Also, I haven't yet checked the exact improvements but still as a teaser,
git status now only rereads the configuration files twice instead of four
times.

[1]: http://thread.gmane.org/gmane.comp.version-control.git/254286
[2]: http://thread.gmane.org/gmane.comp.version-control.git/254101
[3]: http://thread.gmane.org/gmane.comp.version-control.git/254211

Matthieu Moy (1):
  config.c: mark error and warnings strings for translation

Tanay Abhra (7):
  config.c: fix accuracy of line number in errors
  add line number and file name info to `config_set`
  change `git_config()` return value to void
  config: add `git_die_config()` to the config-set API
  rewrite git_config() to use the config-set API
  add a test for semantic errors in config files
  add tests for `git_config_get_string_const()`

 Documentation/technical/api-config.txt |  12 +++
 branch.c                               |   5 +-
 cache.h                                |  28 +++++-
 config.c                               | 152 +++++++++++++++++++++++++++------
 t/t1308-config-set.sh                  |  21 +++++
 t/t4055-diff-context.sh                |   2 +-
 test-config.c                          |  10 +++
 7 files changed, 200 insertions(+), 30 deletions(-)

-- 
1.9.0.GIT

-- 8< --
diff --git a/Documentation/technical/api-config.txt b/Documentation/technical/api-config.txt
index e7ec7cc..d6a2c39 100644
--- a/Documentation/technical/api-config.txt
+++ b/Documentation/technical/api-config.txt
@@ -160,6 +160,13 @@ as well as retrieval for the queried variable, including:
 	Dies printing the line number and the file name of the highest
 	priority value for the configuration variable `key`.
 
+`void git_die_config_linenr(const char *key, const char *filename, int linenr)`::
+
+	Helper function which formats the die error message according to the
+	parameters entered. Used by `git_die_config()`. It can be used by callers
+	handling `git_config_get_value_multi()` to print the correct error message
+	for the desired value.
+
 See test-config.c for usage examples.
 
 Value Parsing Helpers
diff --git a/cache.h b/cache.h
index 243f618..ff17889 100644
--- a/cache.h
+++ b/cache.h
@@ -1407,6 +1407,7 @@ extern int git_config_get_bool_or_int(const char *key, int *is_bool, int *dest);
 extern int git_config_get_maybe_bool(const char *key, int *dest);
 extern int git_config_get_pathname(const char *key, const char **dest);
 extern void git_die_config(const char *key);
+extern void git_die_config_linenr(const char *key, const char *filename, int linenr);
 
 extern int committer_ident_sufficiently_given(void);
 extern int author_ident_sufficiently_given(void);
diff --git a/config.c b/config.c
index 15fcd91..cf9124f 100644
--- a/config.c
+++ b/config.c
@@ -461,9 +461,9 @@ static int git_parse_source(config_fn_t fn, void *data)
 			break;
 	}
 	if (cf->die_on_error)
-		die("bad config file line %d in %s", cf->linenr, cf->name);
+		die(_("bad config file line %d in %s"), cf->linenr, cf->name);
 	else
-		return error("bad config file line %d in %s", cf->linenr, cf->name);
+		return error(_("bad config file line %d in %s"), cf->linenr, cf->name);
 }
 
 static int parse_unit_factor(const char *end, uintmax_t *val)
@@ -579,9 +579,9 @@ static void die_bad_number(const char *name, const char *value)
 		value = "";
 
 	if (cf && cf->name)
-		die("bad numeric config value '%s' for '%s' in %s: %s",
+		die(_("bad numeric config value '%s' for '%s' in %s: %s"),
 		    value, name, cf->name, reason);
-	die("bad numeric config value '%s' for '%s': %s", value, name, reason);
+	die(_("bad numeric config value '%s' for '%s': %s"), value, name, reason);
 }
 
 int git_config_int(const char *name, const char *value)
@@ -666,7 +666,7 @@ int git_config_pathname(const char **dest, const char *var, const char *value)
 		return config_error_nonbool(var);
 	*dest = expand_user_path(value);
 	if (!*dest)
-		die("Failed to expand user dir in: '%s'", value);
+		die(_("failed to expand user dir in: '%s'"), value);
 	return 0;
 }
 
@@ -744,7 +744,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		zlib_compression_level = level;
 		zlib_compression_seen = 1;
 		return 0;
@@ -755,7 +755,7 @@ static int git_default_core_config(const char *var, const char *value)
 		if (level == -1)
 			level = Z_DEFAULT_COMPRESSION;
 		else if (level < 0 || level > Z_BEST_COMPRESSION)
-			die("bad zlib compression level %d", level);
+			die(_("bad zlib compression level %d"), level);
 		core_compression_level = level;
 		core_compression_seen = 1;
 		if (!zlib_compression_seen)
@@ -877,7 +877,7 @@ static int git_default_core_config(const char *var, const char *value)
 		else if (!strcmp(value, "link"))
 			object_creation_mode = OBJECT_CREATION_USES_HARDLINKS;
 		else
-			die("Invalid mode for object creation: %s", value);
+			die(_("invalid mode for object creation: %s"), value);
 		return 0;
 	}
 
@@ -1177,7 +1177,7 @@ int git_config_early(config_fn_t fn, void *data, const char *repo_config)
 
 	switch (git_config_from_parameters(fn, data)) {
 	case -1: /* error */
-		die("unable to parse command-line config");
+		die(_("unable to parse command-line config"));
 		break;
 	case 0: /* found nothing */
 		break;
@@ -1260,13 +1260,7 @@ static void configset_iter(struct config_set *cs, config_fn_t fn, void *data)
 		values = &entry->value_list;
 		if (fn(entry->key, values->items[value_index].string, data) < 0) {
 			kv_info = values->items[value_index].util;
-			if (!kv_info->linenr)
-				die(_("unable to parse '%s' from command-line config"), entry->key);
-			else
-				die(_("bad config variable '%s' at file line %d in %s"),
-					entry->key,
-					kv_info->linenr,
-					kv_info->filename);
+			git_die_config_linenr(entry->key, kv_info->filename, kv_info->linenr);
 		}
 	}
 }
@@ -1569,20 +1563,27 @@ int git_config_get_pathname(const char *key, const char **dest)
 	return ret;
 }
 
+NORETURN
+void git_die_config_linenr(const char *key, const char *filename, int linenr)
+{
+	if (!linenr)
+		die(_("unable to parse '%s' from command-line config"), key);
+	else
+		die(_("bad config variable '%s' at file line %d in %s"),
+			key,
+			linenr,
+			filename);
+}
+
+NORETURN
 void git_die_config(const char *key)
 {
 	const struct string_list *values;
 	struct key_value_info *kv_info;
 	values = git_config_get_value_multi(key);
 	kv_info = values->items[values->nr - 1].util;
-	if (!kv_info->linenr)
-		die(_("unable to parse '%s' from command-line config"), key);
-	else
-		die(_("bad config variable '%s' at file line %d in %s"),
-			key,
-			kv_info->linenr,
-			kv_info->filename);
- }
+	git_die_config_linenr(key, kv_info->filename, kv_info->linenr);
+}
 
 /*
  * Find all the stuff for git_config_set() below.
@@ -1617,7 +1618,7 @@ static int store_aux(const char *key, const char *value, void *cb)
 	case KEY_SEEN:
 		if (matches(key, value)) {
 			if (store.seen == 1 && store.multi_replace == 0) {
-				warning("%s has multiple values", key);
+				warning(_("%s has multiple values"), key);
 			}
 
 			ALLOC_GROW(store.offset, store.seen + 1,
-- 8< --
