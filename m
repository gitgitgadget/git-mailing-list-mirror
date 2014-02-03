From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH v3 23/26] file-watcher: tests for the daemon
Date: Mon,  3 Feb 2014 11:29:11 +0700
Message-ID: <1391401754-15347-24-git-send-email-pclouds@gmail.com>
References: <1389952060-12297-1-git-send-email-pclouds@gmail.com>
 <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 03 05:31:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WABC5-0001b9-Iz
	for gcvg-git-2@plane.gmane.org; Mon, 03 Feb 2014 05:31:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753013AbaBCEbd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Feb 2014 23:31:33 -0500
Received: from mail-pa0-f51.google.com ([209.85.220.51]:56709 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753008AbaBCEbc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Feb 2014 23:31:32 -0500
Received: by mail-pa0-f51.google.com with SMTP id ld10so6657159pab.10
        for <git@vger.kernel.org>; Sun, 02 Feb 2014 20:31:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=quf/MAiYnT//2ioYrz+JAqRoSVP3ME8anhuaSgjVNP0=;
        b=CMOa1EZJILUOJ6iHapr2YVWgWGF3pd4LplZIoM161Z4318UkX9b31sC1qW4o1X90TX
         jmjkayBwKS8O+e4/ENtOQH8GNyAdjlICtYRMlprAgGArt2xEwX630QOk1XV/KV3j56b1
         nVXVzx7yXlG6NvX9jarTn/cW+QmuVpGUhcOTeYkECS7Th0GlRnom+IIKgR3k9I3Chn5v
         z9/N1v/joY1FU0RrzMpSn6XSg75Q4TUiExW40NZ7b958kq2B1gQefWtbGA3A8UrQdjwl
         QErqE6mQv4ouCEsv2N0lFRpN2B8ItA9JVUIhWyWomMqSUcVFFpRq7rmfdxBzRXMWvCDx
         vjeQ==
X-Received: by 10.66.149.73 with SMTP id ty9mr35049866pab.36.1391401891549;
        Sun, 02 Feb 2014 20:31:31 -0800 (PST)
Received: from lanh ([115.73.226.68])
        by mx.google.com with ESMTPSA id vn10sm51418815pbc.21.2014.02.02.20.31.28
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sun, 02 Feb 2014 20:31:30 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Mon, 03 Feb 2014 11:31:29 +0700
X-Mailer: git-send-email 1.8.5.2.240.g8478abd
In-Reply-To: <1391401754-15347-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241418>

test-file-watcher is a simple chat program to talk to file
watcher. Typically you would write something like this

  cat >expect <<EOF
  # send "hello". Oh and this is a comment!
  <hello
  # Wait for reply and print to stdout.
  # test-file-watcher does not care about anything after '>'
  >hello
  <index foo bar
  >ok
  EOF
  test-file-watcher . <expect >actual

and test-file-watcher will execute the commands and get responses. If
all go well, "actual" should be the same as "expect". '<' and '>'
denote send and receive packets respectively. '<<' and '>>' can be
used to send and receive a list of NUL-terminated paths.

$GIT_TEST_WATCHER enables a few more commands for testing purposes.
The most important one is 'test-mode' where system inotify is taken
out and inotify events could be injected via test-file-watcher.

There are two debug commands in file-watcher that's not used by the
test suite, but would help debugging: setenv and log. They can be used
to turn on GIT_TRACE_PACKET then any "log" command will show, which
functions as barrier between events file watcher.

GIT_TRACE_WATCHER can also be enabled (dynamically or at startup) to
track inotify events.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 .gitignore                       |   1 +
 Makefile                         |   1 +
 file-watcher.c                   | 181 ++++++++++++++++++-
 t/t7513-file-watcher.sh (new +x) | 382 +++++++++++++++++++++++++++++++=
++++++++
 test-file-watcher.c (new)        |  96 ++++++++++
 5 files changed, 657 insertions(+), 4 deletions(-)
 create mode 100755 t/t7513-file-watcher.sh
 create mode 100644 test-file-watcher.c

diff --git a/.gitignore b/.gitignore
index 12c78f0..277f929 100644
--- a/.gitignore
+++ b/.gitignore
@@ -181,6 +181,7 @@
 /test-date
 /test-delta
 /test-dump-cache-tree
+/test-file-watcher
 /test-scrap-cache-tree
 /test-genrandom
 /test-index-version
diff --git a/Makefile b/Makefile
index 1c4d659..f0dc2cc 100644
--- a/Makefile
+++ b/Makefile
@@ -555,6 +555,7 @@ TEST_PROGRAMS_NEED_X +=3D test-ctype
 TEST_PROGRAMS_NEED_X +=3D test-date
 TEST_PROGRAMS_NEED_X +=3D test-delta
 TEST_PROGRAMS_NEED_X +=3D test-dump-cache-tree
+TEST_PROGRAMS_NEED_X +=3D test-file-watcher
 TEST_PROGRAMS_NEED_X +=3D test-genrandom
 TEST_PROGRAMS_NEED_X +=3D test-index-version
 TEST_PROGRAMS_NEED_X +=3D test-line-buffer
diff --git a/file-watcher.c b/file-watcher.c
index 1e45b25..3ab0a11 100644
--- a/file-watcher.c
+++ b/file-watcher.c
@@ -65,7 +65,8 @@ struct connection {
 static struct connection **conns;
 static struct pollfd *pfd;
 static int conns_alloc, pfd_nr, pfd_alloc;
-static int inotify_fd;
+static int inotify_fd, test_mode;
+static int wd_counter =3D 1;
=20
 /*
  * IN_DONT_FOLLOW does not matter now as we do not monitor
@@ -78,10 +79,19 @@ static struct dir *create_dir(struct dir *parent, c=
onst char *path,
 			      const char *basename)
 {
 	struct dir *d;
-	int wd =3D inotify_add_watch(inotify_fd, path, INOTIFY_MASKS);
+	int wd;
+	if (!test_mode)
+		wd =3D inotify_add_watch(inotify_fd, path, INOTIFY_MASKS);
+	else {
+		wd =3D wd_counter++;
+		if (wd > 8)
+			wd =3D -1;
+	}
 	if (wd < 0)
 		return NULL;
=20
+	trace_printf_key("GIT_TRACE_WATCHER", "inotify: watch %d %s\n",
+			 wd, path);
 	d =3D xmalloc(sizeof(*d));
 	memset(d, 0, sizeof(*d));
 	d->wd =3D wd;
@@ -124,7 +134,9 @@ static void free_dir(struct dir *d, int topdown)
 	if (d->repo)
 		d->repo->root =3D NULL;
 	wds[d->wd] =3D NULL;
-	inotify_rm_watch(inotify_fd, d->wd);
+	if (!test_mode)
+		inotify_rm_watch(inotify_fd, d->wd);
+	trace_printf_key("GIT_TRACE_WATCHER", "inotify: unwatch %d\n", d->wd)=
;
 	if (topdown) {
 		int i;
 		for (i =3D 0; i < d->nr_subdirs; i++)
@@ -265,6 +277,7 @@ static inline void queue_file_changed(struct file *=
f, struct strbuf *sb)
 	int len =3D sb->len;
 	strbuf_addf(sb, "%s%s", f->parent->parent ? "/" : "", f->name);
 	string_list_append(&f->repo->updated, sb->buf);
+	trace_printf_key("GIT_TRACE_WATCHER", "watcher: changed %s\n", sb->bu=
f);
 	f->repo->updated_sorted =3D 0;
 	strbuf_setlen(sb, len);
 }
@@ -324,6 +337,10 @@ static int do_handle_inotify(const struct inotify_=
event *event)
 	struct dir *d;
 	int pos;
=20
+	trace_printf_key("GIT_TRACE_WATCHER", "inotify: event %08x wd %d %s\n=
",
+			 event->mask, event->wd,
+			 event->len ? event->name : "N/A");
+
 	if (event->mask & (IN_Q_OVERFLOW | IN_UNMOUNT)) {
 		int i;
 		for (i =3D 0; i < nr_repos; i++)
@@ -385,6 +402,81 @@ static int handle_inotify(int fd)
 	return ret;
 }
=20
+struct constant {
+	const char *name;
+	int value;
+};
+
+#define CONSTANT(x) { #x, x }
+static const struct constant inotify_masks[] =3D {
+	CONSTANT(IN_DELETE_SELF),
+	CONSTANT(IN_MOVE_SELF),
+	CONSTANT(IN_ATTRIB),
+	CONSTANT(IN_DELETE),
+	CONSTANT(IN_MODIFY),
+	CONSTANT(IN_MOVED_FROM),
+	CONSTANT(IN_MOVED_TO),
+	CONSTANT(IN_Q_OVERFLOW),
+	CONSTANT(IN_UNMOUNT),
+	{ NULL, 0 },
+};
+
+static void inject_inotify(const char *msg)
+{
+	char buf[sizeof(struct inotify_event) + NAME_MAX + 1];
+	struct inotify_event *event =3D (struct inotify_event *)buf;
+	char *end, *p;
+	int i;
+	memset(event, 0, sizeof(*event));
+	event->wd =3D strtol(msg, &end, 0);
+	if (*end++ !=3D ' ')
+		die("expect a space after watch descriptor");
+	p =3D end;
+	end =3D strchrnul(p, ' ');
+	if (*end)
+		strcpy(event->name, end + 1);
+	while (p < end) {
+		char *sep =3D strchrnul(p, '|');
+		if (sep > end)
+			sep =3D end;
+		*sep =3D '\0';
+		for (i =3D 0; inotify_masks[i].name; i++)
+			if (!strcmp(inotify_masks[i].name, p))
+				break;
+		if (!inotify_masks[i].name)
+			die("unrecognize event mask %s", p);
+		event->mask |=3D inotify_masks[i].value;
+		p =3D sep + 1;
+	}
+	do_handle_inotify(event);
+}
+
+static void dump_watches(struct dir *d, struct strbuf *sb, struct strb=
uf *out)
+{
+	int i, len =3D sb->len;
+	strbuf_addstr(sb, d->name);
+	strbuf_addf(out, "%s %d%c", sb->buf[0] ? sb->buf : ".", d->wd, '\0');
+	if (d->name[0])
+		strbuf_addch(sb, '/');
+	for (i =3D 0; i < d->nr_subdirs; i++)
+		dump_watches(d->subdirs[i], sb, out);
+	for (i =3D 0; i < d->nr_files; i++)
+		strbuf_addf(out, "%s%s%c", sb->buf, d->files[i]->name, '\0');
+	strbuf_setlen(sb, len);
+}
+
+static void dump_changes(struct repository *repo, struct strbuf *sb)
+{
+	int i;
+	if (!repo->updated_sorted) {
+		sort_string_list(&repo->updated);
+		repo->updated_sorted =3D 1;
+	}
+	for (i =3D 0; i < repo->updated.nr; i++)
+		strbuf_add(sb, repo->updated.items[i].string,
+			   strlen(repo->updated.items[i].string) + 1);
+}
+
 static void get_changed_list(int conn_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
@@ -483,11 +575,13 @@ static void unchange(int conn_id, unsigned long s=
ize)
 			item =3D string_list_lookup(&repo->updated, p);
 			if (!item)
 				continue;
+			trace_printf_key("GIT_TRACE_WATCHER", "watcher: unchange %s\n", p);
 			unsorted_string_list_delete_item(&repo->updated,
 							 item - repo->updated.items, 0);
 		}
 		strbuf_release(&sb);
 	}
+	trace_printf_key("GIT_TRACE_WATCHER", "watcher: unchange complete\n")=
;
 	memcpy(repo->index_signature, conn->new_index, 40);
 	/*
 	 * If other connections on this repo are in some sort of
@@ -540,6 +634,13 @@ static void reset_watches(struct repository *repo)
=20
 static void reset_repo(struct repository *repo, ino_t inode)
 {
+	if (test_mode)
+		/*
+		 * test-mode is designed for single repo, we can
+		 * safely reset wd counter because all wd should be
+		 * deleted
+		 */
+		wd_counter =3D 1;
 	reset_watches(repo);
 	string_list_clear(&repo->updated, 0);
 	memcpy(repo->index_signature, invalid_signature, 40);
@@ -560,6 +661,7 @@ static int shutdown_connection(int id)
 	return 0;
 }
=20
+static void cleanup(void);
 static int handle_command(int conn_id)
 {
 	int fd =3D conns[conn_id]->sock;
@@ -754,6 +856,71 @@ static int handle_command(int conn_id)
 		}
 		unchange(conn_id, n);
 	}
+
+	/*
+	 * Testing and debugging support
+	 */
+	else if (!strcmp(msg, "test-mode") && getenv("GIT_TEST_WATCHER")) {
+		test_mode =3D 1;
+		packet_write(fd, "test mode on");
+	}
+	else if (starts_with(msg, "setenv ")) {
+		/* useful for setting GIT_TRACE_WATCHER or GIT_TRACE_PACKET */
+		char *sep =3D strchr(msg + 7, ' ');
+		if (!sep) {
+			packet_write(fd, "error invalid setenv line %s", msg);
+			return shutdown_connection(conn_id);
+		}
+		*sep =3D '\0';
+		setenv(msg + 7, sep + 1, 1);
+	}
+	else if (starts_with(msg, "log ")) {
+		; /* do nothing, if GIT_TRACE_PACKET is on, it's already logged */
+	}
+	else if (!strcmp(msg, "die") && getenv("GIT_TEST_WATCHER")) {
+		/*
+		 * The client will wait for "see you" before it may
+		 * run another daemon with the same path. So there's
+		 * no racing on unlink() and listen() on the same
+		 * socket path.
+		 */
+		cleanup();
+		packet_write(fd, "see you");
+		close(fd);
+		exit(0);
+	}
+	else if (starts_with(msg, "dump ") && getenv("GIT_TEST_WATCHER")) {
+		struct strbuf sb =3D STRBUF_INIT;
+		struct strbuf out =3D STRBUF_INIT;
+		const char *reply =3D NULL;
+		if (!strcmp(msg + 5, "watches")) {
+			if (conns[conn_id]->repo) {
+				if (conns[conn_id]->repo->root)
+					dump_watches(conns[conn_id]->repo->root, &sb, &out);
+			} else {
+				int i;
+				for (i =3D 0; i < nr_repos; i++) {
+					strbuf_addf(&out, "%s%c", repos[i]->work_tree, '\0');
+					if (repos[i]->root)
+						dump_watches(repos[i]->root, &sb, &out);
+					strbuf_reset(&out);
+					strbuf_reset(&sb);
+				}
+			}
+			reply =3D "watching";
+		} else if (!strcmp(msg + 5, "changes")) {
+			dump_changes(conns[conn_id]->repo, &out);
+			reply =3D "changed";
+		}
+		packet_write(fd, "%s %d", reply, (int)out.len);
+		if (out.len)
+			write_in_full(fd, out.buf, out.len);
+		strbuf_release(&out);
+		strbuf_release(&sb);
+	}
+	else if (starts_with(msg, "inotify ") && getenv("GIT_TEST_WATCHER")) =
{
+		inject_inotify(msg + 8);
+	}
 	else {
 		packet_write(fd, "error unrecognized command %s", msg);
 		return shutdown_connection(conn_id);
@@ -848,11 +1015,13 @@ int main(int argc, const char **argv)
 {
 	struct strbuf sb =3D STRBUF_INIT;
 	int i, new_nr, fd, quit =3D 0, nr_common;
-	int daemon =3D 0;
+	int daemon =3D 0, check_support =3D 0;
 	time_t last_checked;
 	struct option options[] =3D {
 		OPT_BOOL(0, "detach", &daemon,
 			 N_("run in background")),
+		OPT_BOOL(0, "check-support", &check_support,
+			 N_("return zero file watcher is available")),
 		OPT_END()
 	};
=20
@@ -865,6 +1034,10 @@ int main(int argc, const char **argv)
=20
 	argc =3D parse_options(argc, argv, NULL, options,
 			     file_watcher_usage, 0);
+
+	if (check_support)
+		return 0;
+
 	if (argc < 1)
 		die(_("socket path missing"));
 	else if (argc > 1)
diff --git a/t/t7513-file-watcher.sh b/t/t7513-file-watcher.sh
new file mode 100755
index 0000000..bf64fc4
--- /dev/null
+++ b/t/t7513-file-watcher.sh
@@ -0,0 +1,382 @@
+#!/bin/sh
+
+test_description=3D'File watcher daemon tests'
+
+. ./test-lib.sh
+
+if git file-watcher --check-support && test_have_prereq POSIXPERM; the=
n
+	:				# good
+else
+	skip_all=3D"file-watcher not supported on this system"
+	test_done
+fi
+
+kill_it() {
+	test-file-watcher "$1" <<EOF >/dev/null
+<die
+>see you
+EOF
+}
+
+GIT_TEST_WATCHER=3D1
+export GIT_TEST_WATCHER
+
+test_expect_success 'test-file-watcher can kill the daemon' '
+	chmod 700 . &&
+	git file-watcher --detach . &&
+	cat >expect <<EOF &&
+<die
+>see you
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	! test -S socket
+'
+
+test_expect_success 'exchange hello' '
+	git file-watcher --detach . &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<die
+>see you
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'normal index sequence' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>inconsistent
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	cat >expect2 <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+# inconsistent again because new-index has not been issued yet
+>inconsistent
+<new-index $SIG
+<<unchange
+<<
+EOF
+	test-file-watcher . >actual2 <expect2 &&
+	test_cmp expect2 actual2 &&
+	cat >expect3 <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<die
+>see you
+EOF
+	test-file-watcher . >actual3 <expect3 &&
+	test_cmp expect3 actual3
+'
+
+test_expect_success 'unaccepted index: hello not sent' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<index $SIG $TRASH_DIRECTORY
+>error why did you not greet me? go away
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	kill_it .
+'
+
+test_expect_success 'unaccepted index: signature too short' '
+	git file-watcher --detach . &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index 1234 $TRASH_DIRECTORY
+>error invalid index line index 1234 $TRASH_DIRECTORY
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	kill_it .
+'
+
+test_expect_success 'unaccepted index: worktree unavailable' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY/non-existent
+>error work tree does not exist: No such file or directory
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	kill_it .
+'
+
+test_expect_success 'watch foo and abc/bar' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>inconsistent
+<test-mode
+>test mode on
+<<watch
+<<foo
+<<abc/bar
+<<
+>watched 2
+<dump watches
+>>watching
+>>. 1
+>>abc 2
+>>abc/bar
+>>foo
+<new-index $SIG
+<<unchange
+<<
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'modify abc/bar' '
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<inotify 2 IN_MODIFY bar
+<dump watches
+>>watching
+>>. 1
+>>foo
+<dump changes
+>>changed
+>>abc/bar
+<die
+>see you
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete abc makes abc/bar changed' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>inconsistent
+<test-mode
+>test mode on
+<<watch
+<<foo/abc/bar
+<<
+>watched 1
+<dump watches
+>>watching
+>>. 1
+>>foo 2
+>>foo/abc 3
+>>foo/abc/bar
+<inotify 2 IN_DELETE_SELF
+<dump watches
+>>watching
+<dump changes
+>>changed
+>>foo/abc/bar
+<new-index $SIG
+<<unchange
+<<
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'get changed list' '
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<get-changed
+>>changed
+>>foo/abc/bar
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'incomplete new-index request' '
+	SIG=3D0123456789012345678901234567890123456789 &&
+	SIG2=3D9123456789012345678901234567890123456780 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<new-index $SIG2
+<dump changes
+>>changed
+>>foo/abc/bar
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'delete abc/bar from changed list' '
+	SIG=3D0123456789012345678901234567890123456789 &&
+	SIG2=3D9123456789012345678901234567890123456780 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>ok
+<new-index $SIG2
+<<unchange
+<<foo/abc/bar
+<<
+<dump changes
+>>changed
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'file-watcher index updated after new-index' '
+	SIG2=3D9123456789012345678901234567890123456780 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG2 $TRASH_DIRECTORY
+>ok
+<die
+>see you
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+# When test-mode is on, file-watch only accepts 8 directories
+test_expect_success 'watch too many directories' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>inconsistent
+# Do not call inotify_add_watch()
+<test-mode
+>test mode on
+# First batch should be all ok
+<<watch
+<<dir1/foo
+<<dir2/foo
+<<dir3/foo
+<<dir4/foo
+<<
+>watched 4
+# Second batch hits the limit
+<<watch
+<<dir5/foo
+<<dir6/foo
+<<dir7/foo
+<<dir8/foo
+<<dir9/foo
+<<
+>watched 3
+# The third batch is already registered, should accept too
+<<watch
+<<dir5/foo
+<<dir6/foo
+<<dir7/foo
+<<
+>watched 3
+# Try again, see if it still rejects
+<<watch
+<<dir8/foo
+<<dir9/foo
+<<
+>watched 0
+<dump watches
+>>watching
+>>. 1
+>>dir1 2
+>>dir1/foo
+>>dir2 3
+>>dir2/foo
+>>dir3 4
+>>dir3/foo
+>>dir4 5
+>>dir4/foo
+>>dir5 6
+>>dir5/foo
+>>dir6 7
+>>dir6/foo
+>>dir7 8
+>>dir7/foo
+<die
+>see you
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'event overflow' '
+	git file-watcher --detach . &&
+	SIG=3D0123456789012345678901234567890123456789 &&
+	cat >expect <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+>inconsistent
+<test-mode
+>test mode on
+<<watch
+<<foo
+<<abc/bar
+<<
+>watched 2
+<inotify 2 IN_MODIFY bar
+<dump watches
+>>watching
+>>. 1
+>>foo
+<dump changes
+>>changed
+>>abc/bar
+<inotify -1 IN_Q_OVERFLOW
+<dump watches
+>>watching
+<dump changes
+>>changed
+EOF
+	test-file-watcher . >actual <expect &&
+	test_cmp expect actual &&
+	cat >expect2 <<EOF &&
+<hello
+>hello
+<index $SIG $TRASH_DIRECTORY
+# Must be inconsistent because of IN_Q_OVERFLOW
+>inconsistent
+<die
+>see you
+EOF
+	test-file-watcher . >actual2 <expect2 &&
+	test_cmp expect2 actual2
+'
+
+test_done
diff --git a/test-file-watcher.c b/test-file-watcher.c
new file mode 100644
index 0000000..ffff198
--- /dev/null
+++ b/test-file-watcher.c
@@ -0,0 +1,96 @@
+#include "cache.h"
+#include "unix-socket.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+
+int main(int ac, char **av)
+{
+	struct strbuf sb =3D STRBUF_INIT;
+	struct strbuf packed =3D STRBUF_INIT;
+	char *packing =3D NULL;
+	int last_command_is_reply =3D 0;
+	int fd;
+
+	strbuf_addf(&sb, "%s/socket", av[1]);
+	fd =3D unix_stream_connect(sb.buf);
+	if (fd < 0)
+		die_errno("connect");
+	strbuf_reset(&sb);
+
+	/*
+	 * test-file-watcher crashes sometimes, make sure to flush
+	 */
+	setbuf(stdout, NULL);
+
+	while (!strbuf_getline(&sb, stdin, '\n')) {
+		if (sb.buf[0] =3D=3D '#') {
+			puts(sb.buf);
+			continue;
+		}
+		if (sb.buf[0] =3D=3D '>') {
+			if (last_command_is_reply)
+				continue;
+			last_command_is_reply =3D 1;
+		} else
+			last_command_is_reply =3D 0;
+
+		if (sb.buf[0] =3D=3D '<' && sb.buf[1] =3D=3D '<') {
+			puts(sb.buf);
+			if (!packing) {
+				packing =3D xstrdup(sb.buf + 2);
+				strbuf_reset(&packed);
+				continue;
+			}
+			if (!sb.buf[2]) {
+				packet_write(fd, "%s %d", packing, (int)packed.len);
+				if (packed.len)
+					write_in_full(fd, packed.buf, packed.len);
+				free(packing);
+				packing =3D NULL;
+			} else
+				strbuf_add(&packed, sb.buf + 2, sb.len - 2 + 1);
+			continue;
+		}
+		if (sb.buf[0] =3D=3D '<') {
+			packet_write(fd, "%s", sb.buf + 1);
+			puts(sb.buf);
+			continue;
+		}
+		if (sb.buf[0] =3D=3D '>' && sb.buf[1] =3D=3D '>') {
+			int len;
+			char *p, *reply =3D packet_read_line(fd, &len);
+			if (!starts_with(reply, sb.buf + 2) ||
+			    reply[sb.len - 2] !=3D ' ') {
+				printf(">%s\n", reply);
+				continue;
+			} else {
+				p =3D reply + sb.len - 2;
+				printf(">>%.*s\n", (int)(p - reply), reply);
+				len =3D atoi(p + 1);
+				if (!len)
+					continue;
+			}
+			strbuf_reset(&packed);
+			strbuf_grow(&packed, len);
+			if (read_in_full(fd, packed.buf, len) <=3D 0)
+				return 1;
+			strbuf_setlen(&packed, len);
+			for (p =3D packed.buf; p - packed.buf < packed.len; p +=3D len + 1)=
 {
+				len =3D strlen(p);
+				printf(">>%s\n", p);
+			}
+			continue;
+		}
+		if (sb.buf[0] =3D=3D '>') {
+			int len;
+			char *reply =3D packet_read_line(fd, &len);
+			if (!reply)
+				puts(">");
+			else
+				printf(">%s\n", reply);
+			continue;
+		}
+		die("unrecognize command %s", sb.buf);
+	}
+	return 0;
+}
--=20
1.8.5.2.240.g8478abd
