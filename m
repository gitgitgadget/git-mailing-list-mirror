From: Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 00/14] fetch submodules in parallel and a preview on parallel "submodule update"
Date: Tue, 22 Sep 2015 18:45:18 -0700
Message-ID: <1442972732-12118-1-git-send-email-sbeller@google.com>
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	vlovich@gmail.com, sunshine@sunshineco.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 03:45:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZeZ7x-0006pK-Vp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Sep 2015 03:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759919AbbIWBpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Sep 2015 21:45:38 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:33706 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217AbbIWBph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Sep 2015 21:45:37 -0400
Received: by pacex6 with SMTP id ex6so25229924pac.0
        for <git@vger.kernel.org>; Tue, 22 Sep 2015 18:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=0f+6okzBzCCiQJ0OAKRj5a5YM4IkHLMk4SwZL1hKNVI=;
        b=cnl7I1MAnTsxTmWN5Xunae/nEbNnqfIGTDE3LsaZRsQTstnNt6mYlmptDEJLH+dY8o
         jLndtvue9dzHiNeCwjWrZDPqHDkjFlZgBbX2BUkCZr8YruQQ/D3f812Xk9bfDsHVtFjZ
         Ku0ApmTQmLHTCv7MsSPs7sUCphPgRhu32djN8lumdx4E/ag5B5uSiaMSW57gI9xsoDyp
         doMEpPwR/Rzs5JbEb9Oh9U3Fg5qWqz7mZTlO2latAs1jk2AZeb+v4ixAZVI0Mrrwrb7t
         atW98E398WxkIgPHoUQng8xd4uR3PLYJOSqHkkyKWJ9BzssC3b8QBlZP4WoE97AbkokC
         aymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0f+6okzBzCCiQJ0OAKRj5a5YM4IkHLMk4SwZL1hKNVI=;
        b=GszckutvmMIFqiPWK2baR9FHQFlhL7lpTwvTP3SBI67rWb7OpLOMMJCCD+ZCSx7rzC
         5CHAkEChxGr+Ox3dr5Y8CKQnNeBJGAxytezzfDdkivz6iT7f9+OM//xOiYGHyyQjgbzR
         5WYnAVjKaYKzpciTuxCbBPQ84KhL+8l/alZBIlgBcCnzZHMWMGe/TCrIYNL1q35V/KHb
         0+zhLneNjKbHc7lO4GOJsvhZ/EhTthWnYFrlFSHDVkn6MmBAr7xRrCprOJ35o4bgoJLh
         +5kjd6+VhnFqIWeSJiC920cnjtcJS8GfmcdZ8MgIILwPVQlbzSdY98MGLrgSwsp72AKu
         LVxw==
X-Gm-Message-State: ALoCoQlIhI8dfIbEce6h2+cisBs8Aecmy5fZOtmqvHalsZyRyApmKPFTwrCKpw2jTdq0AJYYLMpt
X-Received: by 10.68.163.5 with SMTP id ye5mr33943526pbb.120.1442972735872;
        Tue, 22 Sep 2015 18:45:35 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:c149:8175:4df1:ed3a])
        by smtp.gmail.com with ESMTPSA id u3sm4618823pbs.33.2015.09.22.18.45.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 22 Sep 2015 18:45:35 -0700 (PDT)
X-Mailer: git-send-email 2.5.0.272.ga84127c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278456>

Today there was lots of discussion on the correct way of reading the
strbufs as well as some discussion on the structure of the
asynchronous parallel process loop.

Patches 1-8 bring parallel fetching of submodules, and have had some good exposure
to review and feedback is incorporated.

Patches 9-14 bring parallel submodule updates.
Patch 14 is not ready yet (i.e. test suite failures), but the cleanups before
in patch 9-13 can be reviewed without wasting time.

Any feedback welcome,
Thanks,
Stefan

Diff to v3 below. The patches can also be found at [1]
[1] https://github.com/stefanbeller/git/tree/submodulec_nonthreaded_parallel_4

Jonathan Nieder (1):
  submodule: Send "Fetching submodule <foo>" to standard error

Stefan Beller (13):
  xread: poll on non blocking fds
  xread_nonblock: add functionality to read from fds without blocking
  strbuf: add strbuf_read_once to read without blocking
  run-command: factor out return value computation
  run-command: add an asynchronous parallel child processor
  fetch_populated_submodules: use new parallel job processing
  submodules: allow parallel fetching, add tests and documentation
  submodule-config: Untangle logic in parse_config
  submodule config: keep update strategy around
  git submodule update: cmd_update_recursive
  git submodule update: cmd_update_clone
  git submodule update: cmd_update_fetch
  Rewrite submodule update in C

 Documentation/fetch-options.txt |   7 +
 builtin/fetch.c                 |   6 +-
 builtin/pull.c                  |   6 +
 builtin/submodule--helper.c     | 251 +++++++++++++++++++++++++++++
 git-compat-util.h               |   1 +
 git-submodule.sh                | 339 ++++++++++++++--------------------------
 run-command.c                   | 320 ++++++++++++++++++++++++++++++++++---
 run-command.h                   |  36 +++++
 strbuf.c                        |  11 ++
 strbuf.h                        |   9 ++
 submodule-config.c              |  85 +++++-----
 submodule-config.h              |   1 +
 submodule.c                     | 120 +++++++++-----
 submodule.h                     |   2 +-
 t/t0061-run-command.sh          |  20 +++
 t/t5526-fetch-submodules.sh     |  70 ++++++---
 test-run-command.c              |  24 +++
 wrapper.c                       |  35 ++++-
 18 files changed, 987 insertions(+), 356 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index baa7563..b79117a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -382,10 +382,14 @@ static int update_next_task(void *data,
 		argv_array_pushf(&cp->env_array, "sm_path=%s", sub->path);
 		argv_array_pushf(&cp->env_array, "name=%s", sub->name);
 		argv_array_pushf(&cp->env_array, "url=%s", sub->url);
+		argv_array_pushf(&cp->env_array, "sha1=%s", sha1_to_hex(ce->sha1));
 		argv_array_pushf(&cp->env_array, "update_module=%s", update_module);
 
 		cp->git_cmd = 1;
+		cp->no_stdin = 1;
 		cp->stdout_to_stderr = 1;
+		cp->err = -1;
+		argv_array_init(&cp->args);
 		argv_array_push(&cp->args, "submodule");
 		if (!file_exists(sm_gitdir))
 			argv_array_push(&cp->args, "update_clone");
diff --git a/run-command.c b/run-command.c
index 06d5a5d..494e1f8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -276,8 +276,10 @@ static int wait_or_whine(pid_t pid, const char *argv0)
 		failed_errno = errno;
 		error("waitpid for %s failed: %s", argv0, strerror(errno));
 	} else {
-		if (waiting != pid
-		   || (determine_return_value(status, &code, &failed_errno, argv0) < 0))
+		if (waiting != pid || (determine_return_value(status,
+							      &code,
+							      &failed_errno,
+							      argv0) < 0))
 			error("waitpid is confused (%s)", argv0);
 	}
 
@@ -870,7 +872,6 @@ struct parallel_processes {
 
 	int max_processes;
 	int nr_processes;
-	unsigned all_tasks_started : 1;
 
 	get_next_task_fn get_next_task;
 	start_failure_fn start_failure;
@@ -899,9 +900,9 @@ void default_start_failure(void *data,
 	struct strbuf sb = STRBUF_INIT;
 
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(&sb, "%s ", cp->argv[i]);
+		strbuf_addf(&sb, " %s", cp->argv[i]);
 
-	die_errno("Starting a child failed:\n%s", sb.buf);
+	die_errno("Starting a child failed:%s", sb.buf);
 }
 
 void default_return_value(void *data,
@@ -915,12 +916,12 @@ void default_return_value(void *data,
 		return;
 
 	for (i = 0; cp->argv[i]; i++)
-		strbuf_addf(&sb, "%s ", cp->argv[i]);
+		strbuf_addf(&sb, " %s", cp->argv[i]);
 
-	die_errno("A child failed with return code:\n%s\n%d", sb.buf, result);
+	die_errno("A child failed with return code %d:%s", result, sb.buf);
 }
 
-static void run_processes_parallel_init(struct parallel_processes *pp,
+static void pp_init(struct parallel_processes *pp,
 					int n, void *data,
 					get_next_task_fn get_next_task,
 					start_failure_fn start_failure,
@@ -941,7 +942,6 @@ static void run_processes_parallel_init(struct parallel_processes *pp,
 	pp->return_value = return_value ? return_value : default_return_value;
 
 	pp->nr_processes = 0;
-	pp->all_tasks_started = 0;
 	pp->output_owner = 0;
 	pp->children = xcalloc(n, sizeof(*pp->children));
 	pp->pfd = xcalloc(n, sizeof(*pp->pfd));
@@ -954,9 +954,10 @@ static void run_processes_parallel_init(struct parallel_processes *pp,
 	}
 }
 
-static void run_processes_parallel_cleanup(struct parallel_processes *pp)
+static void pp_cleanup(struct parallel_processes *pp)
 {
 	int i;
+
 	for (i = 0; i < pp->max_processes; i++)
 		strbuf_release(&pp->children[i].err);
 
@@ -976,7 +977,8 @@ static void set_nonblocking(int fd)
 			"output will be degraded");
 }
 
-static void run_processes_parallel_start_one(struct parallel_processes *pp)
+/* returns 1 if a process was started, 0 otherwise */
+static int pp_start_one(struct parallel_processes *pp)
 {
 	int i;
 
@@ -988,10 +990,9 @@ static void run_processes_parallel_start_one(struct parallel_processes *pp)
 
 	if (!pp->get_next_task(pp->data,
 			       &pp->children[i].process,
-			       &pp->children[i].err)) {
-		pp->all_tasks_started = 1;
-		return;
-	}
+			       &pp->children[i].err))
+		return 1;
+
 	if (start_command(&pp->children[i].process))
 		pp->start_failure(pp->data,
 				  &pp->children[i].process,
@@ -1002,23 +1003,17 @@ static void run_processes_parallel_start_one(struct parallel_processes *pp)
 	pp->nr_processes++;
 	pp->children[i].in_use = 1;
 	pp->pfd[i].fd = pp->children[i].process.err;
+	return 0;
 }
 
-static void run_processes_parallel_start_as_needed(struct parallel_processes *pp)
-{
-	while (pp->nr_processes < pp->max_processes &&
-	       !pp->all_tasks_started)
-		run_processes_parallel_start_one(pp);
-}
-
-static void run_processes_parallel_buffer_stderr(struct parallel_processes *pp)
+static void pp_buffer_stderr(struct parallel_processes *pp)
 {
 	int i;
 
 	while ((i = poll(pp->pfd, pp->max_processes, 100)) < 0) {
 		if (errno == EINTR)
 			continue;
-		run_processes_parallel_cleanup(pp);
+		pp_cleanup(pp);
 		die_errno("poll");
 	}
 
@@ -1033,7 +1028,7 @@ static void run_processes_parallel_buffer_stderr(struct parallel_processes *pp)
 	}
 }
 
-static void run_processes_parallel_output(struct parallel_processes *pp)
+static void pp_output(struct parallel_processes *pp)
 {
 	int i = pp->output_owner;
 	if (pp->children[i].in_use &&
@@ -1043,7 +1038,7 @@ static void run_processes_parallel_output(struct parallel_processes *pp)
 	}
 }
 
-static void run_processes_parallel_collect_finished(struct parallel_processes *pp)
+static void pp_collect_finished(struct parallel_processes *pp)
 {
 	int i = 0;
 	pid_t pid;
@@ -1063,17 +1058,11 @@ static void run_processes_parallel_collect_finished(struct parallel_processes *p
 			    pid == pp->children[i].process.pid)
 				break;
 		if (i == pp->max_processes)
-			/*
-			 * waitpid returned another process id
-			 * which we are not waiting for.
-			 */
-			return;
-
-		if (strbuf_read_once(&pp->children[i].err,
-				     pp->children[i].process.err, 0) < 0 &&
-		    errno != EAGAIN)
-			die_errno("strbuf_read_once");
+			die("BUG: found a child process we were not aware of");
 
+		if (strbuf_read(&pp->children[i].err,
+				pp->children[i].process.err, 0) < 0)
+			die_errno("strbuf_read");
 
 		if (determine_return_value(wait_status, &code, &errno,
 					   pp->children[i].process.argv[0]) < 0)
@@ -1122,18 +1111,20 @@ int run_processes_parallel(int n, void *data,
 			   return_value_fn return_value)
 {
 	struct parallel_processes pp;
-	run_processes_parallel_init(&pp, n, data,
-				    get_next_task,
-				    start_failure,
-				    return_value);
-
-	while (!pp.all_tasks_started || pp.nr_processes > 0) {
-		run_processes_parallel_start_as_needed(&pp);
-		run_processes_parallel_buffer_stderr(&pp);
-		run_processes_parallel_output(&pp);
-		run_processes_parallel_collect_finished(&pp);
+	pp_init(&pp, n, data, get_next_task, start_failure, return_value);
+
+	while (1) {
+		while (pp.nr_processes < pp.max_processes &&
+		       !pp_start_one(&pp))
+			; /* nothing */
+		if (!pp.nr_processes)
+			break;
+		pp_buffer_stderr(&pp);
+		pp_output(&pp);
+		pp_collect_finished(&pp);
 	}
-	run_processes_parallel_cleanup(&pp);
+
+	pp_cleanup(&pp);
 
 	return 0;
 }
diff --git a/run-command.h b/run-command.h
index 0c1b363..3807fd1 100644
--- a/run-command.h
+++ b/run-command.h
@@ -155,6 +155,4 @@ int run_processes_parallel(int n, void *data,
 			   start_failure_fn,
 			   return_value_fn);
 
-void run_processes_parallel_schedule_error(struct strbuf *err);
-
 #endif
diff --git a/strbuf.h b/strbuf.h
index 4d4e5b1..ea69665 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -367,8 +367,11 @@ extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
 
 /**
- * Same as strbuf_read, just returns non-blockingly by ignoring EAGAIN.
- * The fd must have set O_NONBLOCK.
+ * Read from a file descriptor that is marked as O_NONBLOCK without
+ * blocking.  Returns the number of new bytes appended to the sb.
+ * Negative return value signals there was an error returned from
+ * underlying read(2), in which case the caller should check errno.
+ * e.g. errno == EAGAIN when the read may have blocked.
  */
 extern ssize_t strbuf_read_once(struct strbuf *, int fd, size_t hint);
 
diff --git a/submodule-config.c b/submodule-config.c
index 0298a60..8b8c7d1 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -258,93 +258,72 @@ static int parse_config(const char *var, const char *value, void *data)
 	if (!name_and_item_from_var(var, &name, &item))
 		return 0;
 
-	submodule = lookup_or_create_by_name(me->cache, me->gitmodules_sha1,
-			name.buf);
+	submodule = lookup_or_create_by_name(me->cache,
+					     me->gitmodules_sha1,
+					     name.buf);
 
 	if (!strcmp(item.buf, "path")) {
-		struct strbuf path = STRBUF_INIT;
-		if (!value) {
+		if (!value)
 			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (!me->overwrite && submodule->path != NULL) {
+		else if (!me->overwrite && submodule->path != NULL)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"path");
-			goto release_return;
+		else {
+			if (submodule->path)
+				cache_remove_path(me->cache, submodule);
+			free((void *) submodule->path);
+			submodule->path = xstrdup(value);
+			cache_put_path(me->cache, submodule);
 		}
-
-		if (submodule->path)
-			cache_remove_path(me->cache, submodule);
-		free((void *) submodule->path);
-		strbuf_addstr(&path, value);
-		submodule->path = strbuf_detach(&path, NULL);
-		cache_put_path(me->cache, submodule);
 	} else if (!strcmp(item.buf, "fetchrecursesubmodules")) {
 		/* when parsing worktree configurations we can die early */
 		int die_on_error = is_null_sha1(me->gitmodules_sha1);
 		if (!me->overwrite &&
-		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE) {
+		    submodule->fetch_recurse != RECURSE_SUBMODULES_NONE)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"fetchrecursesubmodules");
-			goto release_return;
-		}
-
-		submodule->fetch_recurse = parse_fetch_recurse(var, value,
+		else
+			submodule->fetch_recurse = parse_fetch_recurse(
+								var, value,
 								die_on_error);
 	} else if (!strcmp(item.buf, "ignore")) {
-		struct strbuf ignore = STRBUF_INIT;
-		if (!me->overwrite && submodule->ignore != NULL) {
+		if (!value)
+			ret = config_error_nonbool(var);
+		else if (!me->overwrite && submodule->ignore != NULL)
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"ignore");
-			goto release_return;
-		}
-		if (!value) {
-			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (strcmp(value, "untracked") && strcmp(value, "dirty") &&
-		    strcmp(value, "all") && strcmp(value, "none")) {
+		else if (strcmp(value, "untracked") &&
+			 strcmp(value, "dirty") &&
+			 strcmp(value, "all") &&
+			 strcmp(value, "none"))
 			warning("Invalid parameter '%s' for config option "
 					"'submodule.%s.ignore'", value, var);
-			goto release_return;
+		else {
+			free((void *) submodule->ignore);
+			submodule->ignore = xstrdup(value);
 		}
-
-		free((void *) submodule->ignore);
-		strbuf_addstr(&ignore, value);
-		submodule->ignore = strbuf_detach(&ignore, NULL);
 	} else if (!strcmp(item.buf, "url")) {
-		struct strbuf url = STRBUF_INIT;
 		if (!value) {
 			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (!me->overwrite && submodule->url != NULL) {
+		} else if (!me->overwrite && submodule->url != NULL) {
 			warn_multiple_config(me->commit_sha1, submodule->name,
 					"url");
-			goto release_return;
+		} else {
+			free((void *) submodule->url);
+			submodule->url = xstrdup(value);
 		}
-
-		free((void *) submodule->url);
-		strbuf_addstr(&url, value);
-		submodule->url = strbuf_detach(&url, NULL);
 	} else if (!strcmp(item.buf, "update")) {
-		struct strbuf update = STRBUF_INIT;
-		if (!value) {
+		if (!value)
 			ret = config_error_nonbool(var);
-			goto release_return;
-		}
-		if (!me->overwrite && submodule->update != NULL) {
+		else if (!me->overwrite && submodule->update != NULL)
 			warn_multiple_config(me->commit_sha1, submodule->name,
-					"update");
-			goto release_return;
+					     "update");
+		else {
+			free((void *)submodule->update);
+			submodule->update = xstrdup(value);
 		}
-
-		free((void *) submodule->update);
-		strbuf_addstr(&update, value);
-		submodule->update = strbuf_detach(&update, NULL);
 	}
 
-release_return:
 	strbuf_release(&name);
 	strbuf_release(&item);
 
diff --git a/submodule.c b/submodule.c
index d15364f..fdaf3e4 100644
--- a/submodule.c
+++ b/submodule.c
@@ -650,10 +650,12 @@ int fetch_populated_submodules(const struct argv_array *options,
 {
 	int i;
 	struct submodule_parallel_fetch spf = SPF_INIT;
+
 	spf.work_tree = get_git_work_tree();
 	spf.command_line_option = command_line_option;
 	spf.quiet = quiet;
 	spf.prefix = prefix;
+
 	if (!spf.work_tree)
 		goto out;
 
@@ -738,12 +740,11 @@ int get_next_submodule(void *data, struct child_process *cp,
 		if (is_directory(git_dir)) {
 			child_process_init(cp);
 			cp->dir = strbuf_detach(&submodule_path, NULL);
+			cp->env = local_repo_env;
 			cp->git_cmd = 1;
-			cp->no_stdout = 1;
 			cp->no_stdin = 1;
 			cp->stdout_to_stderr = 1;
 			cp->err = -1;
-			cp->env = local_repo_env;
 			if (!spf->quiet)
 				strbuf_addf(err, "Fetching submodule %s%s\n",
 					    spf->prefix, ce->name);
diff --git a/wrapper.c b/wrapper.c
index 54ce231..41a21e1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -206,16 +206,10 @@ ssize_t xread(int fd, void *buf, size_t len)
 				continue;
 			if (errno == EAGAIN || errno == EWOULDBLOCK) {
 				struct pollfd pfd;
-				int i;
 				pfd.events = POLLIN;
 				pfd.fd = fd;
-				i = poll(&pfd, 1, 100);
-				if (i < 0) {
-					if (errno == EINTR || errno == ENOMEM)
-						continue;
-					else
-						die_errno("poll");
-				}
+				/* We deliberately ignore the return value */
+				poll(&pfd, 1, -1);
 			}
 		}
 		return nr;
@@ -225,13 +219,13 @@ ssize_t xread(int fd, void *buf, size_t len)
 /*
  * xread_nonblock() is the same a read(), but it automatically restarts read()
  * interrupted operations (EINTR). xread_nonblock() DOES NOT GUARANTEE that
- * "len" bytes is read even if the data is available.
+ * "len" bytes is read. EWOULDBLOCK is turned into EAGAIN.
  */
 ssize_t xread_nonblock(int fd, void *buf, size_t len)
 {
 	ssize_t nr;
 	if (len > MAX_IO_SIZE)
-	    len = MAX_IO_SIZE;
+		len = MAX_IO_SIZE;
 	while (1) {
 		nr = read(fd, buf, len);
 		if (nr < 0) {

-- 
2.5.0.272.ga84127c.dirty
