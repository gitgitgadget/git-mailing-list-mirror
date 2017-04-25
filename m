Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E4421FE90
	for <e@80x24.org>; Tue, 25 Apr 2017 13:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1431356AbdDYNwT (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 09:52:19 -0400
Received: from mout.gmx.net ([212.227.17.21]:55907 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S945974AbdDYNwL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 09:52:11 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LfGo0-1cEZzM2cLQ-00onbH; Tue, 25
 Apr 2017 15:52:00 +0200
Date:   Tue, 25 Apr 2017 15:51:59 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: [PATCH v2 4/9] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <cover.1493128210.git.johannes.schindelin@gmx.de>
Message-ID: <449c8cf3819b92dfcc86a614815972c25f4974a2.1493128210.git.johannes.schindelin@gmx.de>
References: <cover.1472833365.git.johannes.schindelin@gmx.de> <cover.1493128210.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:DbThybr7IHrSmXF1irMHGsHP9mJO7ULQ/fgQHAn+Nz7wUMifuvZ
 DjxkLmQoF+xuNZqAEqZ5PdoAMZuIHLkRFEbaWsmex2z0/OMqvvFJRhziV9Kx1FZ/20+d7s/
 avOMs+KSLFZTF47CXB+htbQTlxc9lxZFBaqPwGTIesNsLQTnOfWcXMZ/0riOzrlaQcYI6k4
 D3f8KxIjBxGozEiluvvXw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:L4Zic/kWguU=:neF+pqzglat4JsGToFPwIT
 yoE79FFf7Ig8qIu+1sbeBje/6aLOmJXePrggmFCO3C0JUn3KOqtxW70wNyt+F4ke9mbiEJB/6
 Q73SulvTSrpw2MsH6UJl71obx72Y2xTB0P//hYDQa3aI8Hhlz8FBITpj9WV5LcLm0VGFgJxrx
 MA725scYFhRTkzNwJk1510VMFZtvSy+1uJttO7cow5mY3aRN9Yk2MPWR2NDcPsN8gX4JaGcTK
 FdDvt8opoMLromS8YIq3uXOK+iTrk9W9ct8nYRNFJVl1suvOqHZ3B3kcBzrTIAPv/CExByPws
 gfRt3xzj6sM3VRtgAgc98WNVd2yy95UX6LcLTCls0pijz6ZRpiqwhHWyFabF9F5K/xsrPwnIG
 8rIstvzkTmsjBkGll/vHCj7HOxHmjm4sFlctk+JSCO34g3OM3OZekx/ZqVvxMAvFKUo4Wqmu0
 zut3hKEwXuIPgP5PqGO9m4zCvrpuG58jWdN+XDtQX84MpRCDs9MwWFXn8H7F9ZDD0LHGMtitR
 groIwL4mJ8COBhSoanTpCRYik1cCtElf/EkDr4G16j/r6I7J2Hnbs9RLIgtzaSM9pRLHX9aS5
 Lj1OS7WQFXd9NH7Qz1zlmVzAb63Aq6lfFkgc18xSEaSCt3kd356fmwP0sRD8Fegs0vjneCOTE
 iy3sKA5t9O+4HixEbMB2r/C3ywicxZgnkk7s3k6VtnrwZWnPBQxL/0FueL/4luaVxe9wYePX7
 NCYPG0j9OW2Jo1zjlqPp/PjEjtsryi+snkZaR3L9yU6C68cHW+8cQNrxObu13xNMW8eesuAvZ
 lvpstmc
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
index 821058d452d..9444c8d6c60 100644
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
index 214af0372ba..52a19e0bdb3 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -774,11 +774,11 @@ transform_todo_ids () {
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
index d2d5bcd9b43..d6ae6407546 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2432,3 +2432,62 @@ int sequencer_make_script(int keep_empty, FILE *out,
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
+		return error_errno(_("could not open '%s'"), todo_file);
+	if (strbuf_read(&todo_list.buf, fd, 0) < 0) {
+		close(fd);
+		return error(_("could not read '%s'."), todo_file);
+	}
+	close(fd);
+
+	res = parse_insn_buffer(todo_list.buf.buf, &todo_list);
+	if (res) {
+		todo_list_release(&todo_list);
+		return error(_("unusable instruction sheet: '%s'"), todo_file);
+	}
+
+	out = fopen(todo_file, "w");
+	if (!out) {
+		todo_list_release(&todo_list);
+		return error(_("unable to open '%s' for writing"), todo_file);
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
index 83f2943b7a9..47a81034e76 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -48,6 +48,8 @@ int sequencer_remove_state(struct replay_opts *opts);
 int sequencer_make_script(int keep_empty, FILE *out,
 		int argc, const char **argv);
 
+int transform_todo_ids(int shorten_sha1s);
+
 extern const char sign_off_header[];
 
 void append_signoff(struct strbuf *msgbuf, int ignore_footer, unsigned flag);
-- 
2.12.2.windows.2.406.gd14a8f8640f


