Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3245C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64A0524671
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 08:08:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6Hd05Qn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbfLMIIO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 03:08:14 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:44065 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725991AbfLMIIN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 03:08:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id q10so5564730wrm.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hCQ3VjN0zYeZFnaFoZziCAsGb0n59gqkKfW5eGg8oO8=;
        b=X6Hd05Qn8jJxh/9lIQ/6WD4VFfRkFw2B/DCMlsVQxrXpol8VrO74X641IWEHrQhgH/
         Lj7DpM9/RKcgRfMbSb0iWp/OvMfk2wQiy77FQEJXQeLxtSybwJrR2Tt1LuMFbyu1y/2C
         DG6+wI7CEht43DCPkxapoqs3M2PfqdzKkXCN+Zii1pTHbdsWMiBLyo+Zfby2uSNVkU4y
         yopLH5Y/b3/oqrTtubCe29PFH+p/iKzCCzIOl5hOrqVlr1+T6DFxgElXw50lMz+7qRGz
         6A6KyrkvO8n5qn/yqC4ZHrBYMYXJI/uc5xO2UcB9jvCqNcrIGikr/StQXi2M7113JzVZ
         tyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hCQ3VjN0zYeZFnaFoZziCAsGb0n59gqkKfW5eGg8oO8=;
        b=NIuIcYFkAmyRtnA2fWZAFGHJ/EvgigaM38KOx8MvJo0xhCmXWz+abIGolA7/kgmQQA
         wkRbDBcIPCDyZ9/GUM9U/pnG2povHX6ckrgyhE0VnCh8dNZ75czhkEGzIeIlJfE6AQYc
         VNUgSrakloN+AjPhhvMbOWUACsannJK1wIVmIvBP6RWXYNxzKxI4WHqwTM+X/TwNLKPE
         QwklnR08c7/mS6z/BOWhtWPzzMXWfysmivjQOvyqERssgaYOzq+z3DYSSXghlPgma/2z
         hu2CTo23Push9tPYwER+T4YFIr8tbFigJyYYX+x75iO6042N4zPpEMYWeoonAzUn32NC
         SYVg==
X-Gm-Message-State: APjAAAWQ2mVw/apJxCbhjw6MHH92ySTa2Id2RE/G13Zud/Y9e9M0K4yM
        YvhtCWGZC7dVPPuiPbWWWe9Wnk6i
X-Google-Smtp-Source: APXvYqx6/62v0iw//SnqdHYk/utcEyJ6HrgnUUBsDuCzkomQ0+xGo0YXMK9JpBUisAi4oqcH2VUhHQ==
X-Received: by 2002:adf:f604:: with SMTP id t4mr11765767wrp.33.1576224488990;
        Fri, 13 Dec 2019 00:08:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n3sm9513688wmc.27.2019.12.13.00.08.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 00:08:08 -0800 (PST)
Message-Id: <63b571f351beb95828fb754bc94dac36347e1083.1576224486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.173.git.1576224486.gitgitgadget@gmail.com>
References: <pull.173.git.1576224486.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 13 Dec 2019 08:07:48 +0000
Subject: [PATCH 01/19] built-in add -i: start implementing the `patch`
 functionality in C
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the previous steps, we re-implemented the main loop of `git add -i`
in C, and most of the commands.

Notably, we left out the actual functionality of `patch`, as the
relevant code makes up more than half of `git-add--interactive.perl`,
and is actually pretty independent of the rest of the commands.

With this commit, we start to tackle that `patch` part. For better
separation of concerns, we keep the code in a separate file,
`add-patch.c`. The new code is still guarded behind the
`add.interactive.useBuiltin` config setting, and for the moment,
it can only be called via `git add -p`.

The actual functionality follows the original implementation of
5cde71d64aff (git-add --interactive, 2006-12-10), but not too closely
(for example, we use string offsets rather than copying strings around,
and after seeing whether the `k` and `j` commands are applicable, in the
C version we remember which previous/next hunk was undecided, and use it
rather than looking again when the user asked to jump).

As a further deviation from that commit, We also use a comma instead of
a slash to separate the available commands in the prompt, as the current
version of the Perl script does this, and we also add a line about the
question mark ("print help") to the help text.

While it is tempting to use this conversion of `git add -p` as an excuse
to work on `apply_all_patches()` so that it does _not_ want to read a
file from `stdin` or from a file, but accepts, say, an `strbuf` instead,
we will refrain from this particular rabbit hole at this stage.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile          |   1 +
 add-interactive.h |   1 +
 add-patch.c       | 265 ++++++++++++++++++++++++++++++++++++++++++++++
 builtin/add.c     |  15 ++-
 4 files changed, 277 insertions(+), 5 deletions(-)
 create mode 100644 add-patch.c

diff --git a/Makefile b/Makefile
index 6c4a1e0ee5..0345d7408b 100644
--- a/Makefile
+++ b/Makefile
@@ -824,6 +824,7 @@ LIB_H := $(sort $(patsubst ./%,%,$(shell git ls-files '*.h' ':!t/' ':!Documentat
 
 LIB_OBJS += abspath.o
 LIB_OBJS += add-interactive.o
+LIB_OBJS += add-patch.o
 LIB_OBJS += advice.o
 LIB_OBJS += alias.o
 LIB_OBJS += alloc.o
diff --git a/add-interactive.h b/add-interactive.h
index 7043b8741d..0e3d93acc9 100644
--- a/add-interactive.h
+++ b/add-interactive.h
@@ -4,5 +4,6 @@
 struct repository;
 struct pathspec;
 int run_add_i(struct repository *r, const struct pathspec *ps);
+int run_add_p(struct repository *r, const struct pathspec *ps);
 
 #endif
diff --git a/add-patch.c b/add-patch.c
new file mode 100644
index 0000000000..d1b1a080e4
--- /dev/null
+++ b/add-patch.c
@@ -0,0 +1,265 @@
+#include "cache.h"
+#include "add-interactive.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "argv-array.h"
+#include "pathspec.h"
+
+struct hunk {
+	size_t start, end;
+	enum { UNDECIDED_HUNK = 0, SKIP_HUNK, USE_HUNK } use;
+};
+
+struct add_p_state {
+	struct repository *r;
+	struct strbuf answer, buf;
+
+	/* parsed diff */
+	struct strbuf plain;
+	struct hunk head;
+	struct hunk *hunk;
+	size_t hunk_nr, hunk_alloc;
+};
+
+static void setup_child_process(struct add_p_state *s,
+				struct child_process *cp, ...)
+{
+	va_list ap;
+	const char *arg;
+
+	va_start(ap, cp);
+	while ((arg = va_arg(ap, const char *)))
+		argv_array_push(&cp->args, arg);
+	va_end(ap);
+
+	cp->git_cmd = 1;
+	argv_array_pushf(&cp->env_array,
+			 INDEX_ENVIRONMENT "=%s", s->r->index_file);
+}
+
+static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
+{
+	struct strbuf *plain = &s->plain;
+	struct child_process cp = CHILD_PROCESS_INIT;
+	char *p, *pend;
+	size_t i;
+	struct hunk *hunk = NULL;
+	int res;
+
+	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
+	setup_child_process(s, &cp,
+			 "diff-files", "-p", "--no-color", "--", NULL);
+	for (i = 0; i < ps->nr; i++)
+		argv_array_push(&cp.args, ps->items[i].original);
+
+	res = capture_command(&cp, plain, 0);
+	if (res)
+		return error(_("could not parse diff"));
+	if (!plain->len)
+		return 0;
+	strbuf_complete_line(plain);
+
+	/* parse hunks */
+	p = plain->buf;
+	pend = p + plain->len;
+	while (p != pend) {
+		char *eol = memchr(p, '\n', pend - p);
+		if (!eol)
+			eol = pend;
+
+		if (starts_with(p, "diff ")) {
+			if (p != plain->buf)
+				BUG("multi-file diff not yet handled");
+			hunk = &s->head;
+		} else if (p == plain->buf)
+			BUG("diff starts with unexpected line:\n"
+			    "%.*s\n", (int)(eol - p), p);
+		else if (starts_with(p, "@@ ")) {
+			s->hunk_nr++;
+			ALLOC_GROW(s->hunk, s->hunk_nr,
+				   s->hunk_alloc);
+			hunk = s->hunk + s->hunk_nr - 1;
+			memset(hunk, 0, sizeof(*hunk));
+
+			hunk->start = p - plain->buf;
+		}
+
+		p = eol == pend ? pend : eol + 1;
+		hunk->end = p - plain->buf;
+	}
+
+	return 0;
+}
+
+static void render_hunk(struct add_p_state *s, struct hunk *hunk,
+			struct strbuf *out)
+{
+	strbuf_add(out, s->plain.buf + hunk->start,
+		   hunk->end - hunk->start);
+}
+
+static void reassemble_patch(struct add_p_state *s, struct strbuf *out)
+{
+	struct hunk *hunk;
+	size_t i;
+
+	render_hunk(s, &s->head, out);
+
+	for (i = 0; i < s->hunk_nr; i++) {
+		hunk = s->hunk + i;
+		if (hunk->use == USE_HUNK)
+			render_hunk(s, hunk, out);
+	}
+}
+
+static const char help_patch_text[] =
+N_("y - stage this hunk\n"
+   "n - do not stage this hunk\n"
+   "a - stage this and all the remaining hunks\n"
+   "d - do not stage this hunk nor any of the remaining hunks\n"
+   "j - leave this hunk undecided, see next undecided hunk\n"
+   "J - leave this hunk undecided, see next hunk\n"
+   "k - leave this hunk undecided, see previous undecided hunk\n"
+   "K - leave this hunk undecided, see previous hunk\n"
+   "? - print help\n");
+
+static int patch_update_file(struct add_p_state *s)
+{
+	size_t hunk_index = 0;
+	ssize_t i, undecided_previous, undecided_next;
+	struct hunk *hunk;
+	char ch;
+	struct child_process cp = CHILD_PROCESS_INIT;
+
+	if (!s->hunk_nr)
+		return 0;
+
+	strbuf_reset(&s->buf);
+	render_hunk(s, &s->head, &s->buf);
+	fputs(s->buf.buf, stdout);
+	for (;;) {
+		if (hunk_index >= s->hunk_nr)
+			hunk_index = 0;
+		hunk = s->hunk + hunk_index;
+
+		undecided_previous = -1;
+		for (i = hunk_index - 1; i >= 0; i--)
+			if (s->hunk[i].use == UNDECIDED_HUNK) {
+				undecided_previous = i;
+				break;
+			}
+
+		undecided_next = -1;
+		for (i = hunk_index + 1; i < s->hunk_nr; i++)
+			if (s->hunk[i].use == UNDECIDED_HUNK) {
+				undecided_next = i;
+				break;
+			}
+
+		/* Everything decided? */
+		if (undecided_previous < 0 && undecided_next < 0 &&
+		    hunk->use != UNDECIDED_HUNK)
+			break;
+
+		strbuf_reset(&s->buf);
+		render_hunk(s, hunk, &s->buf);
+		fputs(s->buf.buf, stdout);
+
+		strbuf_reset(&s->buf);
+		if (undecided_previous >= 0)
+			strbuf_addstr(&s->buf, ",k");
+		if (hunk_index)
+			strbuf_addstr(&s->buf, ",K");
+		if (undecided_next >= 0)
+			strbuf_addstr(&s->buf, ",j");
+		if (hunk_index + 1 < s->hunk_nr)
+			strbuf_addstr(&s->buf, ",J");
+		printf("(%"PRIuMAX"/%"PRIuMAX") ",
+		       (uintmax_t)hunk_index + 1, (uintmax_t)s->hunk_nr);
+		printf(_("Stage this hunk [y,n,a,d%s,?]? "), s->buf.buf);
+		fflush(stdout);
+		if (strbuf_getline(&s->answer, stdin) == EOF)
+			break;
+		strbuf_trim_trailing_newline(&s->answer);
+
+		if (!s->answer.len)
+			continue;
+		ch = tolower(s->answer.buf[0]);
+		if (ch == 'y') {
+			hunk->use = USE_HUNK;
+soft_increment:
+			hunk_index = undecided_next < 0 ?
+				s->hunk_nr : undecided_next;
+		} else if (ch == 'n') {
+			hunk->use = SKIP_HUNK;
+			goto soft_increment;
+		} else if (ch == 'a') {
+			for (; hunk_index < s->hunk_nr; hunk_index++) {
+				hunk = s->hunk + hunk_index;
+				if (hunk->use == UNDECIDED_HUNK)
+					hunk->use = USE_HUNK;
+			}
+		} else if (ch == 'd') {
+			for (; hunk_index < s->hunk_nr; hunk_index++) {
+				hunk = s->hunk + hunk_index;
+				if (hunk->use == UNDECIDED_HUNK)
+					hunk->use = SKIP_HUNK;
+			}
+		} else if (hunk_index && s->answer.buf[0] == 'K')
+			hunk_index--;
+		else if (hunk_index + 1 < s->hunk_nr &&
+			 s->answer.buf[0] == 'J')
+			hunk_index++;
+		else if (undecided_previous >= 0 &&
+			 s->answer.buf[0] == 'k')
+			hunk_index = undecided_previous;
+		else if (undecided_next >= 0 && s->answer.buf[0] == 'j')
+			hunk_index = undecided_next;
+		else
+			puts(_(help_patch_text));
+	}
+
+	/* Any hunk to be used? */
+	for (i = 0; i < s->hunk_nr; i++)
+		if (s->hunk[i].use == USE_HUNK)
+			break;
+
+	if (i < s->hunk_nr) {
+		/* At least one hunk selected: apply */
+		strbuf_reset(&s->buf);
+		reassemble_patch(s, &s->buf);
+
+		discard_index(s->r->index);
+		setup_child_process(s, &cp, "apply", "--cached", NULL);
+		if (pipe_command(&cp, s->buf.buf, s->buf.len,
+				 NULL, 0, NULL, 0))
+			error(_("'git apply --cached' failed"));
+		if (!repo_read_index(s->r))
+			repo_refresh_and_write_index(s->r, REFRESH_QUIET, 0,
+						     1, NULL, NULL, NULL);
+	}
+
+	putchar('\n');
+	return 0;
+}
+
+int run_add_p(struct repository *r, const struct pathspec *ps)
+{
+	struct add_p_state s = { r, STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
+
+	if (discard_index(r->index) < 0 || repo_read_index(r) < 0 ||
+	    repo_refresh_and_write_index(r, REFRESH_QUIET, 0, 1,
+					 NULL, NULL, NULL) < 0 ||
+	    parse_diff(&s, ps) < 0) {
+		strbuf_release(&s.plain);
+		return -1;
+	}
+
+	if (s.hunk_nr)
+		patch_update_file(&s);
+
+	strbuf_release(&s.answer);
+	strbuf_release(&s.buf);
+	strbuf_release(&s.plain);
+	return 0;
+}
diff --git a/builtin/add.c b/builtin/add.c
index d4686d5218..1deb59a642 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -189,12 +189,17 @@ int run_add_interactive(const char *revision, const char *patch_mode,
 	int use_builtin_add_i =
 		git_env_bool("GIT_TEST_ADD_I_USE_BUILTIN", -1);
 
-	if (!patch_mode) {
-		if (use_builtin_add_i < 0)
-			git_config_get_bool("add.interactive.usebuiltin",
-					    &use_builtin_add_i);
-		if (use_builtin_add_i == 1)
+	if (use_builtin_add_i < 0)
+		git_config_get_bool("add.interactive.usebuiltin",
+				    &use_builtin_add_i);
+
+	if (use_builtin_add_i == 1) {
+		if (!patch_mode)
 			return !!run_add_i(the_repository, pathspec);
+		if (strcmp(patch_mode, "--patch"))
+			die("'%s' not yet supported in the built-in add -p",
+			    patch_mode);
+		return !!run_add_p(the_repository, pathspec);
 	}
 
 	argv_array_push(&argv, "add--interactive");
-- 
gitgitgadget

