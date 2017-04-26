Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73F3E207D6
	for <e@80x24.org>; Wed, 26 Apr 2017 11:59:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2999201AbdDZL7p (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 07:59:45 -0400
Received: from mout.gmx.net ([212.227.15.18]:57215 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1954315AbdDZL7m (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 07:59:42 -0400
Received: from virtualbox ([95.208.59.147]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQI1-1dKAS00Oir-00Gmj4; Wed, 26
 Apr 2017 13:59:25 +0200
Date:   Wed, 26 Apr 2017 13:59:23 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.org>, Jeff King <peff@peff.net>
Subject: [PATCH v3 4/9] rebase -i: also expand/collapse the SHA-1s via the
 rebase--helper
In-Reply-To: <cover.1493207864.git.johannes.schindelin@gmx.de>
Message-ID: <df5263cc0cad5cffbd1932d4b9b8e5c0507536e6.1493207864.git.johannes.schindelin@gmx.de>
References: <cover.1493128210.git.johannes.schindelin@gmx.de> <cover.1493207864.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:glHg2fgVMBtQ1spOx8afzfOSCPcu/BptXxLSUfJsAb/UqGj3NXc
 Jx6Q+xdNY+vRu+e0JMLD8Z2XS8D1eCIOWhjBKkcbDPImQKKA53GHY/MRVaucotfsCo6bXTn
 eVdsHICZdTG6gMR1DiOtJKmSgk2NU2oeFXha9GQYPKHBGwFCcxVQAUxBRezPfHNwdYw52mr
 t5LmbgPthRZujFbZbe4Rw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:r5nI/a25hRs=:tq52T6Iz7V4LOLoxI3+MuO
 9Jf7w0pO86P335R5wcOV+Bu4LeuuRq8QJVfmya4M8VEYVE0aRKAAsbXVQaKnPmxqoYl0xIYjy
 aVf7SNp8fkyKERer46zvIJuA4IZ8wUOYOOHkNCX9mfKV0uBJzoRyr0W8HtELR7tHb0QKqcu1v
 uju45qpzgs5FIVJDHrLMEMIFQ/y/0tNihphEmZr4f/nKRGP5m70CSYUFbQ6ycsEGrnCeyqgiL
 dMp+qQp02ylyaYfZe45F3qEUxS4ORsMJYbFIujnhyweNCX0AZ6g85SftCLyJN420b4dKzXqiH
 nNHgu70zM265PSgYM/c4zNF/ZiUV8Ak94LPp0hyVP7SU8rxM3nMUOQXFgBcqk1L4AUljfdhTN
 gJJPLZKOXzm2Y5LALbrjuMMuNA5AhEKMT0NRyqS5aWUgKTAz730spZx+xpQeo9PVXHhgguOcb
 lGQQYPLVtIR3v2O5ZSYgkWED5eY04Ny041DWGVdf1zGdtdBKfbTAmSgtyATpFCyQnxc4Ltt+a
 +F4ON3S1xAfODf703FlC2wwqSsUCUsFWnurUsFsY20NLYYSpoQv6cRMbgFd1jzXSgKBKCWKoQ
 yJ7EWyOQnVpFsYC/Wb8a11LGCKKJPV5zkwL/xyq4iaV83Bu6BwFSHvh/cTDfHLJIQQGEPFtu6
 OwCulXZJuXGuYRraNmuZpO8R7msfPAt3PSFyaTGB2hsNInLZY+Sf9wtmPAF/YBCBryfcFPqAA
 AKuRpwbbYRpi/4ZyoS9TGxxhWcPguEbvCbyFDeB8up1lZ2DFOkeJ9WePA1ilfZ9OAcjpZX1sQ
 93dyg46
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
index e858a976279..4b7f88b338f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -2433,3 +2433,62 @@ int sequencer_make_script(int keep_empty, FILE *out,
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


