Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A24A209FD
	for <e@80x24.org>; Fri, 26 May 2017 03:35:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946834AbdEZDfd (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 23:35:33 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34204 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1946803AbdEZDfW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 23:35:22 -0400
Received: by mail-pf0-f195.google.com with SMTP id w69so43045295pfk.1
        for <git@vger.kernel.org>; Thu, 25 May 2017 20:35:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MejVLM2VYymU70AJWIlXtuRhhkTIASA0ffh4oOis10I=;
        b=MiUy6hhDqW7y3WmlqfBPqQDAIN9QWq8l5FS7QBVovyACuVqRqdptiE8+R757hfj20v
         XG7HAlJFSYrRcnG82DhRxcbaZuHvhq+kt7halbx1VRNRAbBd27ExYD1n3UatLn1+zhSx
         TRTJaEhr17mjD5UsaPMqI1uUH8ulnKEFtP2hlBj8qyOkmAQRtBv0UX/DGPQ+/xBRMlpe
         5AUBlZ0ERWYFsF9jUR/AAiOO7aL844mZpO/ybTLrDMZ2MohKHryzlLAi9NffSROK1qQT
         1aTS3DaiJzrZDkzqWH1GIDKmb0sFK3uk2V6K5BWOXaBZCCKqdDFAOSkvkbZB2MnmPHQe
         Su9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=MejVLM2VYymU70AJWIlXtuRhhkTIASA0ffh4oOis10I=;
        b=A8cuoCebCekyLyRiQDgBKK7qx53Dt2KQFOQhD8fN/cIEvvhhuM1ofztZiN+FyqBMw8
         804T/1s3rWqlNi30AmJhAHsqzqF5FEu54dJd++1yfZQw3nk0nm/oDsQQ7WMMaFqy7WpX
         yXEgaiq4UEZ0zgjwoFBeCVzQhCa+5Gjpyse9NjEQRallA3eO7NQyrTnk9ZILTiah6ixB
         eYFjFJL5nlRWh+wm2IONAmDw6F+LZPd6z40qbsd4XzZMXKlYf8c3BkDFVVW0ib5zWQnJ
         bh9WtvQLtalC+8drUw86n4FgGh32/3wO9vLinbeQc0gCC5EMI4VEVkMJ/gzfLmrAgkhN
         y6hg==
X-Gm-Message-State: AODbwcA7dFnurDJ3e2BmW8q+zlkCxF+bk6njdu+90AX+YdueFPl8MQaR
        DttJ7toGbSI8TdJCttc=
X-Received: by 10.84.135.101 with SMTP id 92mr31048044pli.114.1495769721043;
        Thu, 25 May 2017 20:35:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:546a:ce73:1719:5041])
        by smtp.gmail.com with ESMTPSA id x73sm18008054pfa.71.2017.05.25.20.35.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 25 May 2017 20:35:20 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 07/13] wrapper.c: add and use fopen_or_warn()
Date:   Fri, 26 May 2017 12:35:04 +0900
Message-Id: <20170526033510.1793-8-gitster@pobox.com>
X-Mailer: git-send-email 2.13.0-491-g71cfeddc25
In-Reply-To: <20170526033510.1793-1-gitster@pobox.com>
References: <CACsJy8CzgHc=qe5w=FGJJ=ZU0a+JiqBrjWHV7SH3rAPKmOOKoA@mail.gmail.com>
 <20170526033510.1793-1-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

When fopen() returns NULL, it could be because the given path does not
exist, but it could also be some other errors and the caller has to
check. Add a wrapper so we don't have to repeat the same error check
everywhere.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 attr.c                |  7 ++-----
 bisect.c              |  2 +-
 builtin/blame.c       |  2 +-
 commit.c              |  2 +-
 config.c              |  2 +-
 git-compat-util.h     |  1 +
 ident.c               |  8 +++-----
 remote.c              |  4 ++--
 rerere.c              |  2 +-
 sequencer.c           |  8 ++++----
 server-info.c         |  2 +-
 t/t1308-config-set.sh |  2 ++
 t/t5512-ls-remote.sh  | 13 ++++++++++---
 wrapper.c             | 11 +++++++++++
 wt-status.c           |  3 ++-
 15 files changed, 43 insertions(+), 26 deletions(-)

diff --git a/attr.c b/attr.c
index 7e2134471c..821203e2a9 100644
--- a/attr.c
+++ b/attr.c
@@ -720,16 +720,13 @@ void git_attr_set_direction(enum git_attr_direction new_direction,
 
 static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 {
-	FILE *fp = fopen(path, "r");
+	FILE *fp = fopen_or_warn(path, "r");
 	struct attr_stack *res;
 	char buf[2048];
 	int lineno = 0;
 
-	if (!fp) {
-		if (errno != ENOENT && errno != ENOTDIR)
-			warn_on_inaccessible(path);
+	if (!fp)
 		return NULL;
-	}
 	res = xcalloc(1, sizeof(*res));
 	while (fgets(buf, sizeof(buf), fp)) {
 		char *bufp = buf;
diff --git a/bisect.c b/bisect.c
index 469a3e9061..bb28bf63b2 100644
--- a/bisect.c
+++ b/bisect.c
@@ -666,7 +666,7 @@ static int is_expected_rev(const struct object_id *oid)
 	if (stat(filename, &st) || !S_ISREG(st.st_mode))
 		return 0;
 
-	fp = fopen(filename, "r");
+	fp = fopen_or_warn(filename, "r");
 	if (!fp)
 		return 0;
 
diff --git a/builtin/blame.c b/builtin/blame.c
index 07506a3e45..34445d7894 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2071,7 +2071,7 @@ static int prepare_lines(struct scoreboard *sb)
  */
 static int read_ancestry(const char *graft_file)
 {
-	FILE *fp = fopen(graft_file, "r");
+	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
diff --git a/commit.c b/commit.c
index 73c78c2b80..3eeda081f9 100644
--- a/commit.c
+++ b/commit.c
@@ -167,7 +167,7 @@ struct commit_graft *read_graft_line(char *buf, int len)
 
 static int read_graft_file(const char *graft_file)
 {
-	FILE *fp = fopen(graft_file, "r");
+	FILE *fp = fopen_or_warn(graft_file, "r");
 	struct strbuf buf = STRBUF_INIT;
 	if (!fp)
 		return -1;
diff --git a/config.c b/config.c
index 2894fbb6d0..e54d99d519 100644
--- a/config.c
+++ b/config.c
@@ -1422,7 +1422,7 @@ int git_config_from_file(config_fn_t fn, const char *filename, void *data)
 	int ret = -1;
 	FILE *f;
 
-	f = fopen(filename, "r");
+	f = fopen_or_warn(filename, "r");
 	if (f) {
 		flockfile(f);
 		ret = do_config_from_file(fn, CONFIG_ORIGIN_FILE, filename, filename, f, data);
diff --git a/git-compat-util.h b/git-compat-util.h
index eb5c18c7fd..f74b401810 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -802,6 +802,7 @@ extern int xmkstemp(char *template);
 extern int xmkstemp_mode(char *template, int mode);
 extern char *xgetcwd(void);
 extern FILE *fopen_for_writing(const char *path);
+extern FILE *fopen_or_warn(const char *path, const char *mode);
 
 #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
 #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
diff --git a/ident.c b/ident.c
index bea871c8e0..91c7609055 100644
--- a/ident.c
+++ b/ident.c
@@ -72,12 +72,10 @@ static int add_mailname_host(struct strbuf *buf)
 	FILE *mailname;
 	struct strbuf mailnamebuf = STRBUF_INIT;
 
-	mailname = fopen("/etc/mailname", "r");
-	if (!mailname) {
-		if (errno != ENOENT)
-			warning_errno("cannot open /etc/mailname");
+	mailname = fopen_or_warn("/etc/mailname", "r");
+	if (!mailname)
 		return -1;
-	}
+
 	if (strbuf_getline(&mailnamebuf, mailname) == EOF) {
 		if (ferror(mailname))
 			warning_errno("cannot read /etc/mailname");
diff --git a/remote.c b/remote.c
index 801137c72e..1f2453d0f6 100644
--- a/remote.c
+++ b/remote.c
@@ -251,7 +251,7 @@ static const char *skip_spaces(const char *s)
 static void read_remotes_file(struct remote *remote)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("remotes/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(git_path("remotes/%s", remote->name), "r");
 
 	if (!f)
 		return;
@@ -277,7 +277,7 @@ static void read_branches_file(struct remote *remote)
 {
 	char *frag;
 	struct strbuf buf = STRBUF_INIT;
-	FILE *f = fopen(git_path("branches/%s", remote->name), "r");
+	FILE *f = fopen_or_warn(git_path("branches/%s", remote->name), "r");
 
 	if (!f)
 		return;
diff --git a/rerere.c b/rerere.c
index 3bd55caf3b..971bfedfb2 100644
--- a/rerere.c
+++ b/rerere.c
@@ -200,7 +200,7 @@ static struct rerere_id *new_rerere_id(unsigned char *sha1)
 static void read_rr(struct string_list *rr)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *in = fopen(git_path_merge_rr(), "r");
+	FILE *in = fopen_or_warn(git_path_merge_rr(), "r");
 
 	if (!in)
 		return;
diff --git a/sequencer.c b/sequencer.c
index 10c3b4ff81..11b5c7c114 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -897,8 +897,8 @@ static void flush_rewritten_pending(void) {
 	FILE *out;
 
 	if (strbuf_read_file(&buf, rebase_path_rewritten_pending(), 82) > 0 &&
-			!get_sha1("HEAD", newsha1) &&
-			(out = fopen(rebase_path_rewritten_list(), "a"))) {
+	    !get_sha1("HEAD", newsha1) &&
+	    (out = fopen_or_warn(rebase_path_rewritten_list(), "a"))) {
 		char *bol = buf.buf, *eol;
 
 		while (*bol) {
@@ -917,7 +917,7 @@ static void flush_rewritten_pending(void) {
 
 static void record_in_rewritten(struct object_id *oid,
 		enum todo_command next_command) {
-	FILE *out = fopen(rebase_path_rewritten_pending(), "a");
+	FILE *out = fopen_or_warn(rebase_path_rewritten_pending(), "a");
 
 	if (!out)
 		return;
@@ -1378,7 +1378,7 @@ static int read_populate_todo(struct todo_list *todo_list,
 
 	if (is_rebase_i(opts)) {
 		struct todo_list done = TODO_LIST_INIT;
-		FILE *f = fopen(rebase_path_msgtotal(), "w");
+		FILE *f = fopen_or_warn(rebase_path_msgtotal(), "w");
 
 		if (strbuf_read_file(&done.buf, rebase_path_done(), 0) > 0 &&
 				!parse_insn_buffer(done.buf.buf, &done))
diff --git a/server-info.c b/server-info.c
index f6c1a3dfb0..e01ac154a8 100644
--- a/server-info.c
+++ b/server-info.c
@@ -133,7 +133,7 @@ static int read_pack_info_file(const char *infofile)
 	char line[1000];
 	int old_cnt = 0;
 
-	fp = fopen(infofile, "r");
+	fp = fopen_or_warn(infofile, "r");
 	if (!fp)
 		return 1; /* nonexistent is not an error. */
 
diff --git a/t/t1308-config-set.sh b/t/t1308-config-set.sh
index df92fdcd40..e495a61616 100755
--- a/t/t1308-config-set.sh
+++ b/t/t1308-config-set.sh
@@ -187,6 +187,7 @@ test_expect_success 'proper error on directory "files"' '
 	echo "Error (-1) reading configuration file a-directory." >expect &&
 	mkdir a-directory &&
 	test_expect_code 2 test-config configset_get_value foo.bar a-directory 2>output &&
+	grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
@@ -196,6 +197,7 @@ test_expect_success POSIXPERM,SANITY 'proper error on non-accessible files' '
 	test_when_finished "chmod +r .git/config" &&
 	echo "Error (-1) reading configuration file .git/config." >expect &&
 	test_expect_code 2 test-config configset_get_value foo.bar .git/config 2>output &&
+	grep "^warning:" output &&
 	grep "^Error" output >actual &&
 	test_cmp expect actual
 '
diff --git a/t/t5512-ls-remote.sh b/t/t5512-ls-remote.sh
index 94fc9be9ce..02106c9226 100755
--- a/t/t5512-ls-remote.sh
+++ b/t/t5512-ls-remote.sh
@@ -85,8 +85,15 @@ test_expect_success 'use branch.<name>.remote if possible' '
 '
 
 test_expect_success 'confuses pattern as remote when no remote specified' '
-	cat >exp <<-\EOF &&
-	fatal: '\''refs*master'\'' does not appear to be a git repository
+	if test_have_prereq MINGW
+	then
+		# Windows does not like asterisks in pathname
+		does_not_exist=master
+	else
+		does_not_exist="refs*master"
+	fi &&
+	cat >exp <<-EOF &&
+	fatal: '\''$does_not_exist'\'' does not appear to be a git repository
 	fatal: Could not read from remote repository.
 
 	Please make sure you have the correct access rights
@@ -98,7 +105,7 @@ test_expect_success 'confuses pattern as remote when no remote specified' '
 	# fetch <branch>.
 	# We could just as easily have used "master"; the "*" emphasizes its
 	# role as a pattern.
-	test_must_fail git ls-remote refs*master >actual 2>&1 &&
+	test_must_fail git ls-remote "$does_not_exist" >actual 2>&1 &&
 	test_i18ncmp exp actual
 '
 
diff --git a/wrapper.c b/wrapper.c
index 20c25e7e65..6e513c904a 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -428,6 +428,17 @@ int warn_on_fopen_errors(const char *path)
 	return 0;
 }
 
+FILE *fopen_or_warn(const char *path, const char *mode)
+{
+	FILE *fp = fopen(path, mode);
+
+	if (fp)
+		return fp;
+
+	warn_on_fopen_errors(path);
+	return NULL;
+}
+
 int xmkstemp(char *template)
 {
 	int fd;
diff --git a/wt-status.c b/wt-status.c
index 0375484962..cdf9f5eed2 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1065,7 +1065,8 @@ static void show_am_in_progress(struct wt_status *s,
 static char *read_line_from_git_path(const char *filename)
 {
 	struct strbuf buf = STRBUF_INIT;
-	FILE *fp = fopen(git_path("%s", filename), "r");
+	FILE *fp = fopen_or_warn(git_path("%s", filename), "r");
+
 	if (!fp) {
 		strbuf_release(&buf);
 		return NULL;
-- 
2.13.0-491-g71cfeddc25

