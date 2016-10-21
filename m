Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FD0620229
	for <e@80x24.org>; Fri, 21 Oct 2016 12:25:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932247AbcJUMZY (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 08:25:24 -0400
Received: from mout.gmx.net ([212.227.17.22]:51235 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755487AbcJUMZV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 08:25:21 -0400
Received: from virtualbox ([37.24.142.40]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0M3NEK-1coZ6v1VQ0-00qxLH; Fri, 21 Oct 2016 14:25:13
 +0200
Date:   Fri, 21 Oct 2016 14:25:12 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Jakub_Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 15/27] sequencer: allow editing the commit message on a
 case-by-case basis
In-Reply-To: <cover.1477052405.git.johannes.schindelin@gmx.de>
Message-ID: <0ffa14bdac0c6be9ccc4cf3852e3b8a1a0c828b2.1477052405.git.johannes.schindelin@gmx.de>
References: <cover.1476450940.git.johannes.schindelin@gmx.de> <cover.1477052405.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:4xCIQzdq7C9NgN7dsnpaoGPhCmoFxz21OAgtWDYrbrjFHDCVvSf
 uUs9gLnzzStXNkWeL/ZhuVBe4t4X6MVm3nomVA2fqEOnatFARXYZAM89aUOKhc240Y3ko9A
 WS2JBlYoG3OzgXQCRNhS0FPB9r4Qy7zT13AigIm7aNpxA6vvYhp7XdqlSPo0k18A5HbB5a6
 bT7BoFdaMISvA1voYY4Xw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:fex5h5kz3/A=:5Z6asqfHiW0lHUfP6/c+9H
 D8vTkQvG5Gd7TElw59viN57QFJ/t1jyUWmbj//ss2tgiR1uKOTHgZcwQJ6TecOZg9bo+qsWCT
 h1EyqAf8CT4IO6iN1yDaHsWS3LQpBgBC6HXbpwolbdzvVda0hDrf880xzy3bRsoCcDL4ZGTRq
 /nqN01wJIvKoOYLaAcTinHOcPW1D26XdJUVdStCBSpiyXhzpHRxVSkpfSz4SAF7eri/ljSQrj
 Haz+rxrMMDhWkNo1ECWWwJfHZgWqYs9cwPuiYdyW1TYuIybFeCV1VXAThoVs5LTUOUoU22z8Z
 FehUY2tU3I6rS05V9IZRD3BVRN3S3gpRx7GBUYVA1Qr2tjEd/rOW4w71Z1PdSHAtbGqv+G9eG
 bJURXWCDhRpaf0UhkK5iW6Iyjea4bh+2Z/B4N6eApVZVP5gbhYCMEVFrYCDNjL2aHGa2fsFWc
 ZdD6KS4IWe81d/lO1gAC8KM1zarbLn2IUA0F0UPmeCwjjsv2ssnvkjQJHGG8QMonbXN9M2yq9
 jwakEPQxd5Cze8PIWYevQz5zmIrg6sJemD15+/XR3a11KlZu9CynXXyTSxgBM5RdlBNRFSMLA
 CI6ecCde2H/YQ8LAfaj4uUJrmSLGxXdwluXGymJkFVry2J5WkRBbdR27ryu94Xz01nl+8nd0V
 WFyfeS128wu8BzhZ6wT5QWYyXiEAs/NRLfGC3tFq0bY9fUD74Hl+FNNFhjiLdEJ8SjZFRvdTT
 Vhxe+offhpObjNCUrWSuu8fBt0ik0Hq1BYxjfBhQBESCxuDk1NyiN/xao1m07oaBGUB4y/boN
 CVkO/QP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the upcoming commits, we will implement more and more of rebase -i's
functionality inside the sequencer. One particular feature of the
commands to come is that some of them allow editing the commit message
while others don't, i.e. we cannot define in the replay_opts whether the
commit message should be edited or not.

Let's add a new parameter to the run_git_commit() function. Previously,
it was the duty of the caller to ensure that the opts->edit setting
indicates whether to let the user edit the commit message or not,
indicating that it is an "all or nothing" setting, i.e. that the
sequencer wants to let the user edit *all* commit message, or none at
all. In the upcoming rebase -i mode, it will depend on the particular
command that is currently executed, though.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 48 ++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 40 insertions(+), 8 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 282c4d1..c0a0aa0 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -15,6 +15,7 @@
 #include "merge-recursive.h"
 #include "refs.h"
 #include "argv-array.h"
+#include "quote.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -33,6 +34,11 @@ static GIT_PATH_FUNC(git_path_head_file, "sequencer/head")
  * being rebased.
  */
 static GIT_PATH_FUNC(rebase_path_author_script, "rebase-merge/author-script")
+/*
+ * The following files are written by git-rebase just after parsing the
+ * command-line (and are only consumed, not modified, by the sequencer).
+ */
+static GIT_PATH_FUNC(rebase_path_gpg_sign_opt, "rebase-merge/gpg_sign_opt")
 
 /* We will introduce the 'interactive rebase' mode later */
 static inline int is_rebase_i(const struct replay_opts *opts)
@@ -132,6 +138,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
 	return 1;
 }
 
+static const char *gpg_sign_opt_quoted(struct replay_opts *opts)
+{
+	static struct strbuf buf = STRBUF_INIT;
+
+	strbuf_reset(&buf);
+	if (opts->gpg_sign)
+		sq_quotef(&buf, "-S%s", opts->gpg_sign);
+	return buf.buf;
+}
+
 int sequencer_remove_state(struct replay_opts *opts)
 {
 	struct strbuf dir = STRBUF_INIT;
@@ -468,7 +484,7 @@ static char **read_author_script(void)
  * author metadata.
  */
 static int run_git_commit(const char *defmsg, struct replay_opts *opts,
-			  int allow_empty)
+			  int allow_empty, int edit)
 {
 	char **env = NULL;
 	struct argv_array array;
@@ -477,17 +493,20 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 
 	if (is_rebase_i(opts)) {
 		env = read_author_script();
-		if (!env)
+		if (!env) {
+			const char *gpg_opt = gpg_sign_opt_quoted(opts);
+
 			return error("You have staged changes in your working "
 				"tree. If these changes are meant to be\n"
 				"squashed into the previous commit, run:\n\n"
-				"  git commit --amend $gpg_sign_opt_quoted\n\n"
+				"  git commit --amend %s\n\n"
 				"If they are meant to go into a new commit, "
 				"run:\n\n"
-				"  git commit $gpg_sign_opt_quoted\n\n"
+				"  git commit %s\n\n"
 				"In both cases, once you're done, continue "
 				"with:\n\n"
-				"  git rebase --continue\n");
+				"  git rebase --continue\n", gpg_opt, gpg_opt);
+		}
 	}
 
 	argv_array_init(&array);
@@ -500,7 +519,7 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "-s");
 	if (defmsg)
 		argv_array_pushl(&array, "-F", defmsg, NULL);
-	if (opts->edit)
+	if (edit)
 		argv_array_push(&array, "-e");
 	else if (!opts->signoff && !opts->record_origin &&
 		 git_config_get_value("commit.cleanup", &value))
@@ -767,7 +786,7 @@ static int do_pick_commit(enum todo_command command, struct commit *commit,
 	}
 	if (!opts->no_commit)
 		res = run_git_commit(opts->edit ? NULL : git_path_merge_msg(),
-				     opts, allow);
+				     opts, allow, opts->edit);
 
 leave:
 	free_message(commit, &msg);
@@ -989,8 +1008,21 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
-	if (is_rebase_i(opts))
+	if (is_rebase_i(opts)) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+			if (!starts_with(buf.buf, "-S"))
+				strbuf_reset(&buf);
+			else {
+				free(opts->gpg_sign);
+				opts->gpg_sign = xstrdup(buf.buf + 2);
+			}
+		}
+		strbuf_release(&buf);
+
 		return 0;
+	}
 
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-- 
2.10.1.583.g721a9e0


