Received: from 7of9.schinagl.nl (7of9.schinagl.nl [185.238.129.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF4A79D8
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 08:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.238.129.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711786307; cv=none; b=h6pcho0ZI1z9+zBrAJmFdAQsBZftAlQaDCrTEpINq7nxXP353jiSN1AQ/AR5gAMxB+Mk0LjJFBROmPK+s+gGmXeGKWvYxTSKTe9jkUh4cF5aJXf+NrNvv7KnBB+fj7UmgNZ+ywwdxbQX3YyQ3bQbxEKlTWTcJQMvHcqtQ3gY29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711786307; c=relaxed/simple;
	bh=+ip4Gdq1shhEWR8BYlq+QEc3ATA7ClSerVDIREZwEFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FJBh8UUgDThkM0kPBtMOCj3sDUcUZKjnhCb5vOilLbBofMAgZFcCaqAanAxY3KsQPVqxKbqaEPKizzt1HOilIT11SrwTewmAt/Zcg+huv0VAn7tpvf75e5tbZ7mW1BGuES2+Q75EjTD1Uur7goGe9TMJXDjf9JErqtvfJiN3Qf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl; spf=pass smtp.mailfrom=schinagl.nl; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=Widzi2fh; dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b=A9tzBa23; arc=none smtp.client-ip=185.238.129.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=schinagl.nl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="Widzi2fh";
	dkim=pass (1024-bit key) header.d=schinagl.nl header.i=@schinagl.nl header.b="A9tzBa23"
Received: from localhost (7of9.are-b.org [127.0.0.1])
	by 7of9.schinagl.nl (Postfix) with ESMTP id BD3D71A0A7C4;
	Sat, 30 Mar 2024 09:11:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711786294; bh=+ip4Gdq1shhEWR8BYlq+QEc3ATA7ClSerVDIREZwEFY=;
	h=From:To:Cc:Subject:Date;
	b=Widzi2fh8/zFK/RYjIiAUmbA0ayIsRsrBnV7lyqyThgf55WJpwKsm0BPzSaIGJTB6
	 5R9QqJKwC9/Avf7g61g0s8Dgatz9Ho1JAvGCPl2ORnKsRf2EkquybYihqF/ZAL67mJ
	 d0qUHP2x5Q1VbXcKa6BqTQzayXcDMejkpmcY1ESE=
X-Virus-Scanned: amavisd-new at schinagl.nl
Received: from 7of9.schinagl.nl ([127.0.0.1])
	by localhost (7of9.schinagl.nl [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id o_8nqL_Xo1Dm; Sat, 30 Mar 2024 09:11:33 +0100 (CET)
Received: from 2of9.are-b.org (unknown [10.2.12.48])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by 7of9.schinagl.nl (Postfix) with ESMTPSA id CECF61A0A7BF;
	Sat, 30 Mar 2024 09:11:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=schinagl.nl; s=7of9;
	t=1711786292; bh=+ip4Gdq1shhEWR8BYlq+QEc3ATA7ClSerVDIREZwEFY=;
	h=From:To:Cc:Subject:Date;
	b=A9tzBa23KNk3kMc1D0HaReIji99WuHKLlO4SvbBZgU8uHTzFNyb8K+DcXmGBMNoFS
	 wuCNJTcuXV89rNON4Pxc13sAbJLEft385WxLAw65FUHycpIl4D01/XBoHpavL1Z4+/
	 bI4LDVRqEOmUXXnA8xHogKBJ/1r+2KR7yDKx4FaQ=
From: Olliver Schinagl <oliver@schinagl.nl>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Stefan Haller <lists@haller-berlin.de>,
	Olliver Schinagl <oliver@schinagl.nl>
Subject: [RFC] bisect: Introduce skip-when to automatically skip commits
Date: Sat, 30 Mar 2024 09:10:27 +0100
Message-ID: <20240330081026.362962-2-oliver@schinagl.nl>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before I go dig myself in deeper, I'd like some feedback and opinions on
whether this is the correct direction.

If I got it right, do say so, as then I can start adding some tests and
update the documentation.

Olliver

---

In some situations, it is needed to skip certain commits when bisecting,
because the compile doesn't work, or tests are known to fail.

For this purpose, we introduce the `--skip-when` flag which takes a
script as an input and is expected to return exit code 125 if a commit
is to be skipped, which uses a regular `git bisect skip` and the commit
thus ends up on the skipped pile.

In addition we also offer a git-hook, to make this as predictable and
painless as possible.

The script can do whatever it wants to to determine if a commit is to be
skipped; From comparing the hash against a known list, to checking git
notes for a keyword or, as the included example, the commit body.

Signed-off-by: Olliver Schinagl <oliver@schinagl.nl>
---
 bisect.c                                 |  2 +
 builtin/bisect.c                         | 93 +++++++++++++++++++++++-
 templates/hooks--bisect-skip_when.sample | 10 +++
 3 files changed, 101 insertions(+), 4 deletions(-)
 create mode 100755 templates/hooks--bisect-skip_when.sample

diff --git a/bisect.c b/bisect.c
index 60aae2fe50..185909cca9 100644
--- a/bisect.c
+++ b/bisect.c
@@ -476,6 +476,7 @@ static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_skip_when, "BISECT_SKIP_WHEN")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
@@ -1179,6 +1180,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_log());
 	unlink_or_warn(git_path_bisect_names());
 	unlink_or_warn(git_path_bisect_run());
+	unlink_or_warn(git_path_bisect_skip_when());
 	unlink_or_warn(git_path_bisect_terms());
 	unlink_or_warn(git_path_bisect_first_parent());
 	/*
diff --git a/builtin/bisect.c b/builtin/bisect.c
index 9891cf2604..6870142b85 100644
--- a/builtin/bisect.c
+++ b/builtin/bisect.c
@@ -4,6 +4,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "hook.h"
 #include "object-name.h"
 #include "oid-array.h"
 #include "parse-options.h"
@@ -14,19 +15,21 @@
 #include "revision.h"
 #include "run-command.h"
 #include "strvec.h"
+#include "wrapper.h"
 
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_skip_when, "BISECT_SKIP_WHEN")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 
 #define BUILTIN_GIT_BISECT_START_USAGE \
-	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]" \
-	   "    [--no-checkout] [--first-parent] [<bad> [<good>...]] [--]" \
-	   "    [<pathspec>...]")
+	N_("git bisect start [--term-(new|bad)=<term> --term-(old|good)=<term>]\n" \
+	   "                 [--no-checkout] [--first-parent] [--skip-when=<script>]\n" \
+	   "                 [<bad> [<good>...]] [--] [<pathspec>...]")
 #define BUILTIN_GIT_BISECT_STATE_USAGE \
 	N_("git bisect (good|bad) [<rev>...]")
 #define BUILTIN_GIT_BISECT_TERMS_USAGE \
@@ -89,6 +92,7 @@ static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
 static int bisect_autostart(struct bisect_terms *terms);
+static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc, const char **argv);
 
 /*
  * Check whether the string `term` belongs to the set of strings
@@ -680,14 +684,74 @@ static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
 	return res;
 }
 
+static int get_skip_when(const char **skip_when)
+{
+	struct strbuf str = STRBUF_INIT;
+	FILE *fp = NULL;
+	int res = 0;
+
+	fp = fopen(git_path_bisect_skip_when(), "r");
+	if (!fp) {
+		res = -1;
+		goto finish;
+	}
+
+	strbuf_getline_lf(&str, fp);
+	*skip_when = strbuf_detach(&str, NULL);
+
+finish:
+	if (fp)
+		fclose(fp);
+	strbuf_release(&str);
+
+	return res;
+}
+
 static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
 {
+	int no_checkout = ref_exists("BISECT_HEAD");
+	enum bisect_error res;
+	struct object_id oid;
+
 	if (bisect_next_check(terms, NULL)) {
 		bisect_print_status(terms);
 		return BISECT_OK;
 	}
 
-	return bisect_next(terms, prefix);
+	res = bisect_next(terms, prefix);
+	if (res)
+		return res;
+
+	if (!read_ref(no_checkout ? "BISECT_HEAD" : "HEAD", &oid)) {
+		struct run_hooks_opt opt = RUN_HOOKS_OPT_INIT;
+		char *rev = oid_to_hex(&oid);
+		const char *skip_when = NULL;
+		int ret = 0;
+
+		get_skip_when(&skip_when);
+		if (skip_when != NULL) {
+			struct child_process cmd = CHILD_PROCESS_INIT;
+
+			cmd.use_shell = 1;
+			cmd.no_stdin = 1;
+			strvec_pushl(&cmd.args, skip_when, rev, NULL);
+
+			printf(_("running '%s'\n"), skip_when);
+			ret = run_command(&cmd);
+		}
+
+		strvec_push(&opt.args, rev);
+		if ((ret == 125) ||
+		    (run_hooks_opt("bisect-skip_when", &opt) == 125)) {
+			struct strvec argv = STRVEC_INIT;
+
+			printf(_("auto skipping commit [%s]...\n"), rev);
+			sq_dequote_to_strvec("skip", &argv);
+			res = bisect_skip(terms, argv.nr, argv.v);
+		}
+	}
+
+	return res;
 }
 
 static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
@@ -703,6 +767,7 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 	struct strbuf start_head = STRBUF_INIT;
 	struct strbuf bisect_names = STRBUF_INIT;
 	struct object_id head_oid;
+	char *skip_when = NULL;
 	struct object_id oid;
 	const char *head;
 
@@ -727,6 +792,15 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--first-parent")) {
 			first_parent_only = 1;
+		} else if (!strcmp(arg, "--skip-when")) {
+			i++;
+
+			if (argc <= i)
+				return error(_("'' is not a valid skip-when script"));
+
+			skip_when = xstrdup(argv[i]);
+		} else if (skip_prefix(arg, "--skip-when=", &arg)) {
+			skip_when = xstrdup(arg);
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -867,11 +941,22 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
 		goto finish;
 	}
 
+	if (skip_when) {
+		if (access(skip_when, X_OK)) {
+			res = error(_("%s: no such path in the working tree.\n"), skip_when);
+			goto finish;
+		}
+		write_to_file(git_path_bisect_skip_when(), "%s\n", skip_when);
+	}
+
 	res = bisect_append_log_quoted(argv);
 	if (res)
 		res = BISECT_FAILED;
 
 finish:
+	if (skip_when)
+		free(skip_when);
+
 	string_list_clear(&revs, 0);
 	string_list_clear(&states, 0);
 	strbuf_release(&start_head);
diff --git a/templates/hooks--bisect-skip_when.sample b/templates/hooks--bisect-skip_when.sample
new file mode 100755
index 0000000000..ff3960841f
--- /dev/null
+++ b/templates/hooks--bisect-skip_when.sample
@@ -0,0 +1,10 @@
+#!/bin/sh
+#
+# usage: ${0} <commit_object_name>
+# expected to exit with 125 when the commit should be skipped
+
+if git cat-file commit "${1:-HEAD}" | grep -q "^GIT_BISECT_SKIP=1$"; then
+	exit 125
+fi
+
+exit 0
-- 
2.44.0

