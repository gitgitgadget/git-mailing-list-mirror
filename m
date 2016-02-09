From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv9 0/6]  Expose submodule parallelism to the user
Date: Tue,  9 Feb 2016 12:54:28 -0800
Message-ID: <1455051274-15256-1-git-send-email-sbeller@google.com>
Cc: Stefan Beller <sbeller@google.com>
To: gitster@pobox.com, jrnieder@gmail.com, git@vger.kernel.org,
	Jens.Lehmann@web.de
X-From: git-owner@vger.kernel.org Tue Feb 09 21:54:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTFJD-0001em-Dk
	for gcvg-git-2@plane.gmane.org; Tue, 09 Feb 2016 21:54:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755394AbcBIUyq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 15:54:46 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:35441 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbcBIUyp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 15:54:45 -0500
Received: by mail-pf0-f171.google.com with SMTP id c10so66639384pfc.2
        for <git@vger.kernel.org>; Tue, 09 Feb 2016 12:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kJuje471fGkhIL4RrL8ka/MSEvFsJcmjslHKXR5OZWo=;
        b=Nr6NNUCP0TC9OaFEabzfK+wjcIGN4F5nfOrwKC6Y8o1hQiR7PCRLhKrM6KbrCqVaoB
         aL/AcN0+PewICJ56rOQDupL6UwcVCVFSK81GPbRimOEzZARiYpRcgrGB+JlFnQYemxMc
         +Q38R8/indYxm1fKgrLnVpWkyY0SdeYGSHW/Jd9lrMSLTrNGWW+bIDWKBwfvKRLVmbxc
         JsBlzlKIyYWWoXCLWxi6DGMDrSt7UC0iUG1fhK7tvKwv1wcMPhsANJIheXuXTnfTwwka
         m/is7kdiI77d67TNLU/d/QvrQV7V76JeFFPsKDqbPISphgjRawj73SzqlxWARAh7KToo
         /XQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=kJuje471fGkhIL4RrL8ka/MSEvFsJcmjslHKXR5OZWo=;
        b=DpJRh5pddNE/KzRWuJouIRN6ENtDx7jJGbIm1+DSr+rvzj3jyMSyKhKqAKk3wgEZ+Z
         UpwY8TL2DSy/67VSEyZ4N0EHoAUvbn/JnOPzq11QWIMeb8M7C6FyapbXTaj+cOindsbG
         VLeVWZhD7XYZPas4vxuCc9YvycBKSW4GP9j8dcaYonzmMlyHp6aGK4HDHrla53Y6pIGU
         VrrLHU1jy9euThDVZEoBhZ2Fg0V/cVXeuOT+35Ahp/U1p6B2HceJQCcNQCmWD973ZpGv
         JjudN0WH0pVyOFNtrT4NP/ODzq+Gy6TMQrh6JFZKJLiyk66K6Rc0w4oOM+ojAMFROkEr
         cHvg==
X-Gm-Message-State: AG10YOSMIe8v6YOHsFKUbILaeoAKM3RPdxHDIHSuga+gAyBWKP0Rt8SkVkKMzr2I5YlLozkn
X-Received: by 10.98.18.207 with SMTP id 76mr52357975pfs.53.1455051284413;
        Tue, 09 Feb 2016 12:54:44 -0800 (PST)
Received: from localhost ([2620:0:1000:5b00:9085:4567:f3b3:63e9])
        by smtp.gmail.com with ESMTPSA id sm8sm52594263pac.43.2016.02.09.12.54.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 09 Feb 2016 12:54:43 -0800 (PST)
X-Mailer: git-send-email 2.7.0.rc0.35.gb0f7869.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285861>

This replaces sb/submodule-parallel-update.
(which is based on sb/submodule-parallel-fetch)

Thanks to Junio and Jonathan for review!

* s/config_parallel_submodules/parallel_submodules/ as it is not in config any
  more. Also ease up the default setting. 

* use an enum for submodule update strategy

* parsing of submodule.fetchJobs in submodule.c instead of submodule-config.
  -> no need for 2 refactoring patches
  
* This seems to clash with 00/20] refs backend.
> Applied this on top of a merge between the current 'master' and
> 'sb/submodule-parallel-update' topic to untangle the dependency;
> otherwise there is no way for this topic to make progress X-<.

Anything I can do to help with easing the clash?

Thanks,
Stefan

interdiff to v8:

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 7e01b85..6c74474 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -257,7 +257,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 
 static int git_submodule_config(const char *var, const char *value, void *cb)
 {
-	return parse_submodule_config_option(var, value);
+	return submodule_config(var, value, cb);
 }
 
 struct submodule_update_clone {
@@ -316,7 +316,6 @@ static int update_clone_get_next_task(struct child_process *cp,
 		struct strbuf displaypath_sb = STRBUF_INIT;
 		struct strbuf sb = STRBUF_INIT;
 		const char *displaypath = NULL;
-		const char *update_module = NULL;
 		char *url = NULL;
 		int needs_cloning = 0;
 
@@ -340,13 +339,8 @@ static int update_clone_get_next_task(struct child_process *cp,
 		else
 			displaypath = ce->name;
 
-		if (pp->update)
-			update_module = pp->update;
-		if (!update_module)
-			update_module = sub->update;
-		if (!update_module)
-			update_module = "checkout";
-		if (!strcmp(update_module, "none")) {
+		if ((pp->update && !strcmp(pp->update, "none")) ||
+		    (!pp->update && sub->update == SM_UPDATE_NONE)) {
 			strbuf_addf(err, "Skipping submodule '%s'\n",
 				    displaypath);
 			goto cleanup_and_continue;
@@ -479,9 +473,7 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	git_config(git_submodule_config, NULL);
 
 	if (max_jobs < 0)
-		max_jobs = config_parallel_submodules();
-	if (max_jobs < 0)
-		max_jobs = 1;
+		max_jobs = parallel_submodules();
 
 	run_processes_parallel(max_jobs,
 			       update_clone_get_next_task,
diff --git a/submodule-config.c b/submodule-config.c
index 339b59d..d6c8d9c 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -32,7 +32,6 @@ enum lookup_type {
 
 static struct submodule_cache cache;
 static int is_cache_init;
-static unsigned long parallel_jobs = -1;
 
 static int config_path_cmp(const struct submodule_entry *a,
 			   const struct submodule_entry *b,
@@ -162,10 +161,27 @@ static struct submodule *cache_lookup_name(struct submodule_cache *cache,
 	return NULL;
 }
 
+static int name_and_item_from_var(const char *var, struct strbuf *name,
+				  struct strbuf *item)
+{
+	const char *subsection, *key;
+	int subsection_len, parse;
+	parse = parse_config_key(var, "submodule", &subsection,
+			&subsection_len, &key);
+	if (parse < 0 || !subsection)
+		return 0;
+
+	strbuf_add(name, subsection, subsection_len);
+	strbuf_addstr(item, key);
+
+	return 1;
+}
+
 static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 		const unsigned char *gitmodules_sha1, const char *name)
 {
 	struct submodule *submodule;
+	struct strbuf name_buf = STRBUF_INIT;
 
 	submodule = cache_lookup_name(cache, gitmodules_sha1, name);
 	if (submodule)
@@ -173,10 +189,13 @@ static struct submodule *lookup_or_create_by_name(struct submodule_cache *cache,
 
 	submodule = xmalloc(sizeof(*submodule));
 
-	submodule->name = xstrdup(name);
+	strbuf_addstr(&name_buf, name);
+	submodule->name = strbuf_detach(&name_buf, NULL);
+
 	submodule->path = NULL;
 	submodule->url = NULL;
-	submodule->update = NULL;
+	submodule->update = SM_UPDATE_UNSPECIFIED;
+	submodule->update_command = NULL;
 	submodule->fetch_recurse = RECURSE_SUBMODULES_NONE;
 	submodule->ignore = NULL;
 
@@ -229,34 +248,22 @@ struct parse_config_parameter {
 	int overwrite;
 };
 
-static int parse_generic_submodule_config(const char *key,
-					  const char *var,
-					  const char *value,
-					  struct parse_config_parameter *me)
+static int parse_config(const char *var, const char *value, void *data)
 {
-	if (!strcmp(key, "fetchjobs")) {
-		if (!git_parse_ulong(value, &parallel_jobs)) {
-			warning(_("Error parsing submodule.fetchJobs; Defaulting to 1."));
-			parallel_jobs = 1;
-		}
-	}
+	struct parse_config_parameter *me = data;
+	struct submodule *submodule;
+	struct strbuf name = STRBUF_INIT, item = STRBUF_INIT;
+	int ret = 0;
 
-	return 0;
-}
+	/* this also ensures that we only parse submodule entries */
+	if (!name_and_item_from_var(var, &name, &item))
+		return 0;
 
-static int parse_specific_submodule_config(const char *subsection,
-					   const char *key,
-					   const char *var,
-					   const char *value,
-					   struct parse_config_parameter *me)
-{
-	int ret = 0;
-	struct submodule *submodule;
 	submodule = lookup_or_create_by_name(me->cache,
 					     me->gitmodules_sha1,
-					     subsection);
+					     name.buf);
 
-	if (!strcmp(key, "path")) {
+	if (!strcmp(item.buf, "path")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->path)
@@ -269,7 +276,7 @@ static int parse_specific_submodule_config(const char *subsection,
 			submodule->path = xstrdup(value);
 			cache_put_path(me->cache, submodule);
 		}
-	} else if (!strcmp(key, "fetchrecursesubmodules")) {
+	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
@@ -280,7 +287,7 @@ static int parse_specific_submodule_config(const char *subsection,
 			submodule->fetch_recurse = parse_fetch_recurse(
 								var, value,
 								die_on_error);
-	} else if (!strcmp(key, "ignore")) {
+	} else if (!strcmp(item.buf, "ignore")) {
 		if (!value)
 			ret = config_error_nonbool(var);
 		else if (!me->overwrite && submodule->ignore)
@@ -296,7 +303,7 @@ static int parse_specific_submodule_config(const char *subsection,
 			free((void *) submodule->ignore);
 			submodule->ignore = xstrdup(value);
 		}
-	} else if (!strcmp(key, "url")) {
+	} else if (!strcmp(item.buf, "url")) {
 		if (!value) {
 			ret = config_error_nonbool(var);
 		} else if (!me->overwrite && submodule->url) {
@@ -306,39 +313,31 @@ static int parse_specific_submodule_config(const char *subsection,
 			free((void *) submodule->url);
 			submodule->url = xstrdup(value);
 		}
-	} else if (!strcmp(key, "update")) {
+	} else if (!strcmp(item.buf, "update")) {
 		if (!value)
 			ret = config_error_nonbool(var);
-		else if (!me->overwrite && submodule->update)
+		else if (!me->overwrite &&
+		    submodule->update != SM_UPDATE_UNSPECIFIED)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					     "update");
 		else {
-			free((void *) submodule->update);
-			submodule->update = xstrdup(value);
+			submodule->update_command = NULL;
+			if (!strcmp(value, "none"))
+				submodule->update = SM_UPDATE_NONE;
+			else if (!strcmp(value, "checkout"))
+				submodule->update = SM_UPDATE_CHECKOUT;
+			else if (!strcmp(value, "rebase"))
+				submodule->update = SM_UPDATE_REBASE;
+			else if (!strcmp(value, "merge"))
+				submodule->update = SM_UPDATE_MERGE;
+			else if (!skip_prefix(value, "!", &submodule->update_command))
+				die(_("invalid value for %s"), var);
 		}
 	}
 
-	return ret;
-}
-
-static int parse_config(const char *var, const char *value, void *data)
-{
-	struct parse_config_parameter *me = data;
-	int subsection_len, ret;
-	const char *subsection, *key;
-	char *sub;
-
-	if (parse_config_key(var, "submodule", &subsection,
-			     &subsection_len, &key) < 0)
-		return 0;
-
-	if (!subsection)
-		return parse_generic_submodule_config(key, var, value, me);
+	strbuf_release(&name);
+	strbuf_release(&item);
 
-	sub = xmemdupz(subsection, subsection_len);
-	ret = parse_specific_submodule_config(sub, key,
-					      var, value, me);
-	free(sub);
 	return ret;
 }
 
@@ -487,8 +486,3 @@ void submodule_free(void)
 	cache_free(&cache);
 	is_cache_init = 0;
 }
-
-unsigned long config_parallel_submodules(void)
-{
-	return parallel_jobs;
-}
diff --git a/submodule-config.h b/submodule-config.h
index bab1e8d..e3bd56e 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -4,6 +4,15 @@
 #include "hashmap.h"
 #include "strbuf.h"
 
+enum submodule_update_type {
+	SM_UPDATE_CHECKOUT,
+	SM_UPDATE_REBASE,
+	SM_UPDATE_MERGE,
+	SM_UPDATE_NONE,
+	SM_UPDATE_COMMAND,
+	SM_UPDATE_UNSPECIFIED
+};
+
 /*
  * Submodule entry containing the information about a certain submodule
  * in a certain revision.
@@ -14,7 +23,8 @@ struct submodule {
 	const char *url;
 	int fetch_recurse;
 	const char *ignore;
-	const char *update;
+	enum submodule_update_type update;
+	const char *update_command;
 	/* the sha1 blob id of the responsible .gitmodules file */
 	unsigned char gitmodules_sha1[20];
 };
@@ -27,6 +37,4 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
-unsigned long config_parallel_submodules(void);
-
 #endif /* SUBMODULE_CONFIG_H */
diff --git a/submodule.c b/submodule.c
index eb7d54b..fd763f5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -15,6 +15,7 @@
 #include "thread-utils.h"
 
 static int config_fetch_recurse_submodules = RECURSE_SUBMODULES_ON_DEMAND;
+static int parallel_jobs = 1;
 static struct string_list changed_submodule_paths;
 static int initialized_fetch_ref_tips;
 static struct sha1_array ref_tips_before_fetch;
@@ -169,7 +170,13 @@ void set_diffopt_flags_from_submodule_config(struct diff_options *diffopt,
 
 int submodule_config(const char *var, const char *value, void *cb)
 {
-	if (starts_with(var, "submodule."))
+	if (!strcmp(var, "submodule.fetchjobs")) {
+		unsigned long val;
+		if (!git_parse_ulong(value, &val) || 0 > val || val >= INT_MAX)
+			die(_("Error parsing submodule.fetchJobs %s"), value);
+		parallel_jobs = val;
+		return 0;
+	} else if (starts_with(var, "submodule."))
 		return parse_submodule_config_option(var, value);
 	else if (!strcmp(var, "fetch.recursesubmodules")) {
 		config_fetch_recurse_submodules = parse_fetch_recurse_submodules_arg(var, value);
@@ -752,9 +759,7 @@ int fetch_populated_submodules(const struct argv_array *options,
 	/* default value, "--submodule-prefix" and its value are added later */
 
 	if (max_parallel_jobs < 0)
-		max_parallel_jobs = config_parallel_submodules();
-	if (max_parallel_jobs < 0)
-		max_parallel_jobs = 1;
+		max_parallel_jobs = parallel_jobs;
 
 	calculate_changed_submodule_paths();
 	run_processes_parallel(max_parallel_jobs,
@@ -1102,3 +1107,8 @@ void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir)
 	strbuf_release(&rel_path);
 	free((void *)real_work_tree);
 }
+
+int parallel_submodules(void)
+{
+	return parallel_jobs;
+}
diff --git a/submodule.h b/submodule.h
index cbc0003..95babc5 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,5 +41,6 @@ int find_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_nam
 		struct string_list *needs_pushing);
 int push_unpushed_submodules(unsigned char new_sha1[20], const char *remotes_name);
 void connect_work_tree_and_git_dir(const char *work_tree, const char *git_dir);
+int parallel_submodules(void);
 
 #endif


Stefan Beller (6):
  submodule-config: keep update strategy around
  submodule-config: drop check against NULL
  fetching submodules: respect `submodule.fetchJobs` config option
  git submodule update: have a dedicated helper for cloning
  submodule update: expose parallelism to the user
  clone: allow an explicit argument for parallel submodule clones

 Documentation/config.txt        |   6 +
 Documentation/git-clone.txt     |   6 +-
 Documentation/git-submodule.txt |   7 +-
 builtin/clone.c                 |  19 +++-
 builtin/fetch.c                 |   2 +-
 builtin/submodule--helper.c     | 238 ++++++++++++++++++++++++++++++++++++++++
 git-submodule.sh                |  54 ++++-----
 submodule-config.c              |  28 ++++-
 submodule-config.h              |  11 ++
 submodule.c                     |  17 ++-
 submodule.h                     |   1 +
 t/t5526-fetch-submodules.sh     |  14 +++
 t/t7400-submodule-basic.sh      |   4 +-
 t/t7406-submodule-update.sh     |  27 +++++
 14 files changed, 385 insertions(+), 49 deletions(-)

-- 
2.7.0.rc0.35.gb0f7869.dirty
