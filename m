Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5D320193
	for <e@80x24.org>; Fri,  2 Sep 2016 16:23:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932423AbcIBQXR (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Sep 2016 12:23:17 -0400
Received: from mout.gmx.net ([212.227.17.22]:53422 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754240AbcIBQXP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Sep 2016 12:23:15 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx102) with
 ESMTPSA (Nemesis) id 0LlXnX-1b7tH52Isx-00bJqT; Fri, 02 Sep 2016 18:23:12
 +0200
Date:   Fri, 2 Sep 2016 18:23:10 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/9] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <cover.1472833365.git.johannes.schindelin@gmx.de>
Message-ID: <fe53c109c757ede9cd1b0d2944d2b5e16575c49b.1472833365.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:KvShJrsEW8yjx0DK3P0N/37X50RQnffNsJu+1sTuXg/QcS2pufJ
 JZn6VAZm5HUppNVKbnjzh8yDcJroSIpSGe3cl0sP/aYFHgpWvGJ8lxJdUFsKCsyu81ahrzz
 WMWzBqU08Avg4wfr6HcSNn5fKBORYPQ9nsdTNwLxNo0g0P+nBDVVGMHGRFC1e7qPECHk1O2
 N7TxD7htXw8XFkdVSzfOg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zlIBSNkLkZo=:2lwO3OVskFIhuvgJ/WIQ1G
 gD2UUWbI5SHerrv0fsYXJ/yisyP7Whdc6+owVYKWt2wyOKp1JkDqTvVgP+2HXIz5VxE1PHgcX
 7tWKdqpYtFH3VX0BcjcjwSCBLhEKbtaBXBlhuM2QrVzL80kEcQ3xXynl63GkOpySxGfFStZ6u
 aWGQGmuwT9ZPBATWdQk/culbJiWrKMIorf7PEjIiUtkZjo4NA3jbjGXqAcglS7bmKFBWLmpyd
 Ce8xCSxxcX2TO1UXzOGogGNKPflI8yw6cE2W8C2Y1RZUI8sNW9x9RjfhCrw2wF++be6SaVsi7
 kO2KLLPwzY1skZGf/kxgy15TM7mLDK6mEb5oAmZmoGz4vn25Av3Db5WE/QOW3zhMrTb24KIi+
 +4seTwNWqG6vUrF1wXU4LD/lkMqVRHGbtRhgNkCWQ6c2m7kYHnDmvgv+mg5QCoW4vVgAenSIc
 LN2e5aHdgWtrgUjdwYHI8F4BiKtlpXM+zA5Sdbv6FNDVZc9JZzYPFu5Ubb2kz6LCVa98rPyBN
 OV/57/PkHGWt3ICbUSEaH/K3zgT1UDpCCDxMGHBYxMm/Qsvk0hPytKcBmtcD8APVcaKcI+B/Y
 x5r/DQeJTHOD9OayojWEb9HJPEaru56zXFuf2jaMH7Zmh0sJxRm31Yoh8wRVSgLWS2Oy2tV3n
 QHOfY0TPC/aMFDAGEz9I4VIsYYk/HWrPmrVPxjUIoaXSjZXWy7vBQQL0FrWxzRSCAR0jnHVmd
 NUm4kA59ZIuHKMVTG7aw+unlIpXKRupITqLnksqiNfEtMbBbPgo4MwlFNBosyQmqpsixCrtCS
 dXnsRYa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is crucial to improve performance on Windows, as the speed is now
mostly dominated by the SHA-1 transformation (because it spawns a new
rev-parse process for *every* line, and spawning processes is pretty
slow from Git for Windows' MSYS2 Bash).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/rebase--helper.c   | 10 +++++++-
 git-rebase--interactive.sh |  4 ++--
 sequencer.c                | 59 ++++++++++++++++++++++++++++++++++++++++++++++
 sequencer.h                |  2 ++
 4 files changed, 72 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase--helper.c b/builtin/rebase--helper.c
index 821058d..9444c8d 100644
--- a/builtin/rebase--helper.c
+++ b/builtin/rebase--helper.c
@@ -13,7 +13,7 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 	struct replay_opts opts = REPLAY_OPTS_INIT;
 	int keep_empty = 0;
 	enum {
-		CONTINUE = 1, ABORT, MAKE_SCRIPT
+		CONTINUE = 1, ABORT, MAKE_SCRIPT, SHORTEN_SHA1S, EXPAND_SHA1S
 	} command = 0;
 	struct option options[] = {
 		OPT_BOOL(0, "ff", &opts.allow_ff, N_("allow fast-forward")),
@@ -24,6 +24,10 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 				ABORT),
 		OPT_CMDMODE(0, "make-script", &command,
 			N_("make rebase script"), MAKE_SCRIPT),
+		OPT_CMDMODE(0, "shorten-sha1s", &command,
+			N_("shorten SHA-1s in the todo list"), SHORTEN_SHA1S),
+		OPT_CMDMODE(0, "expand-sha1s", &command,
+			N_("expand SHA-1s in the todo list"), EXPAND_SHA1S),
 		OPT_END()
 	};
 
@@ -42,5 +46,9 @@ int cmd_rebase__helper(int argc, const char **argv, const char *prefix)
 		return !!sequencer_remove_state(&opts);
 	if (command == MAKE_SCRIPT && argc > 1)
 		return !!sequencer_make_script(keep_empty, stdout, argc, argv);
+	if (command == SHORTEN_SHA1S && argc == 1)
+		return !!transform_todo_ids(1);
+	if (command == EXPAND_SHA1S && argc == 1)
+		return !!transform_todo_ids(0);
 	usage_with_options(builtin_rebase_helper_usage, options);
 }
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0eb5583..f642ec2 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -764,11 +764,11 @@ transform_todo_ids () {
 }
 
 expand_todo_ids() {
-	transform_todo_ids
+	git rebase--helper --expand-sha1s
 }
 
 collapse_todo_ids() {
-	transform_todo_ids --short
+	git rebase--helper --shorten-sha1s
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
diff --git a/sequencer.c b/sequencer.c
index 43e078a..ee4fdb0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2391,3 +2391,62 @@ int sequencer_make_script(int keep_empty, FILE *out,
 	strbuf_release(&buf);
 	return 0;
 }
+
+
+int transform_todo_ids(int shorten_sha1s)
+{
+	const char *todo_file = rebase_path_todo();
+	struct todo_list todo_list = TODO_LIST_INIT;
+	int fd, res, i;
+	FILE *out;
+
+	strbuf_reset(&todo_list.buf);
+	fd = open(todo_file, O_RDONLY);
+	if (fd < 0)
+		return error_errno(_("Could not open '%s'"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("Could not read %s."), todo_file);
+	}
+	close(fd);
+
+	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	if (res) {
+		todo_list_release(&todo_list);
+		return error(_("Unusable instruction sheet: %s"), todo_file);
+	}
+
+	out = fopen(todo_file, "w");
+	if (!out) {
+		todo_list_release(&todo_list);
+		return error(_("Unable to open '%s' for writing"), todo_file);
+	}
+	for (i = 0; i < todo_list.nr; i++) {
+		struct todo_item *item = todo_list.items + i;
+		int bol = item->offset_in_buf;
+		const char *p = todo_list.buf.buf + bol;
+		int eol = i + 1 < todo_list.nr ?
+			todo_list.items[i + 1].offset_in_buf :
+			todo_list.buf.len;
+
+		if (item->command >= TODO_EXEC && item->command != TODO_DROP)
+			fwrite(p, eol - bol, 1, out);
+		else {
+			int eoc = strcspn(p, " \t");
+			const char *sha1 = shorten_sha1s ?
+				short_commit_name(item->commit) :
+				oid_to_hex(&item->commit->object.oid);
+
+			if (!eoc) {
+				p += strspn(p, " \t");
+				eoc = strcspn(p, " \t");
+			}
+
+			fprintf(out, "%.*s %s %.*s\n",
+				eoc, p, sha1, item->arg_len, item->arg);
+		}
+	}
+	fclose(out);
+	todo_list_release(&todo_list);
+	return 0;
+}
diff --git a/sequencer.h b/sequencer.h
index bc524be..5feb525 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -61,6 +61,8 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
+int transform_todo_ids(int shorten_sha1s);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.9.3.windows.3


