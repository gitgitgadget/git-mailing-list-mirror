Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ACE391F70F
	for <e@80x24.org>; Thu, 26 Jan 2017 16:16:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753034AbdAZQQ3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Jan 2017 11:16:29 -0500
Received: from mout.gmx.net ([212.227.15.18]:53082 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753366AbdAZQQN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Jan 2017 11:16:13 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MKYsh-1cXbHa3CvX-001zYo; Thu, 26
 Jan 2017 17:08:41 +0100
Date:   Thu, 26 Jan 2017 17:08:41 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Guillaume Pages <guillaume.pages@ensimag.grenoble-inp.fr>
Subject: [PATCH v2 1/1] status: be prepared for not-yet-started interactive
 rebase
In-Reply-To: <cover.1485446899.git.johannes.schindelin@gmx.de>
Message-ID: <alpine.DEB.2.20.1701261708370.3469@virtualbox>
References: <99f6de4be107044fdf01ee796f42e124ac147891.1453480067.git.johannes.schindelin@gmx.de> <cover.1485446899.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:zHOkY+uZp3tk+dYgXfUpLLeZe8F7SnpokxPJxSQ6BmiH9ALGbaZ
 jUhuLQNCO7mXmV6zkezquQ1b1PXRzQIdmxYXRTj1jp2xegWXoQL6Pl8Ciu9shMhiwccExcr
 w5B9f2pkOnM/DHuMV45dbqg5v/zrah5g2miAALNsTwgMoRIbELSwJPDigdvr0+ic0QEjiqh
 w0Ne5cphdVge3+ZQxWj/w==
X-UI-Out-Filterresults: notjunk:1;V01:K0:NwLb+/Rq/Rk=:6NYyz6odYxr/+2o+ve3OqO
 N7KqbocjH/HD/KttHubJM8pNjkgyFWFLFTR3YUplnL1r5goIb60lzMj0h0SWJ2A82KHvpUjFc
 Xvcu+NdqhaNeD+ORSRC7pfa28qmMDmHawJH7IxQVMqUg21mr6ATp3T2BD6wXSiqYJSy1c4ACy
 h9PLKyYeh9K7RoCFYQ3RuNaQAg36TTWHnzwXj5U03/1eQbzNGosZBbjGiPzibQzQBXzwr+a77
 A1JWKsE6sA5znx+wy7ZgqipW+HWB2Ze+S48mUHqZe42fEaGndtoi2eXsucubypJM+ZdFXy4qM
 uijvtLWHAEeSYgWUFh/CJo5JinaycGaS7nVWJhe8Wjao5aVk7EP4rZOMnz/80Y64Q8XfFQvEB
 loDElrzcgGpGOADHwsOxikEhTJuKgxLX52HZnlrdoyw+3gvcq8YZFtXE+LaAM9eNtHUQPwbEC
 joaETha7rB0mFw2+8UdSiUVNm+5GXU+XxHXJeFcNkg9FERLWPMEesYs8+inQXpiOsmKPeUorB
 YyLya71y/ARPCSzSiMkj5BexgIHlL9Qv7498sYznOx/Mo/idScx9bJl3Oc5clOY0SWGkyaLPx
 O1XbAuecCEWkEsBQhT6s7Kzzx1GHmDkVTuBVAf8yTTB/UGgulXIP90Mf1FsM0OeZHPVCZ96XV
 QcnATf2jylVXKZx2Ii9BXe7Vh+82dLhAk1N5i7Ecn5EvCNnFgbj6t6wIYnr/GQJNICCE7q+z5
 wn+kSSDZr1CqwOgzA45IslErtPwsd7XAh3BJlAe7k6yaAiz2JDHhX7hIDEvbEw322syav28bf
 oTxttKp
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some developers might want to call `git status` in a working
directory where they just started an interactive rebase, but the
edit script is still opened in the editor.

Let's show a meaningful message in such cases.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7512-status-help.sh | 19 +++++++++++++++++++
 wt-status.c            | 14 ++++++++++----
 2 files changed, 29 insertions(+), 4 deletions(-)

diff --git a/t/t7512-status-help.sh b/t/t7512-status-help.sh
index 5c3db656df..458608cc1e 100755
--- a/t/t7512-status-help.sh
+++ b/t/t7512-status-help.sh
@@ -944,4 +944,23 @@ EOF
 	test_i18ncmp expected actual
 '
 
+test_expect_success 'status: handle not-yet-started rebase -i gracefully' '
+	ONTO=$(git rev-parse --short HEAD^) &&
+	COMMIT=$(git rev-parse --short HEAD) &&
+	EDITOR="git status --untracked-files=no >actual" git rebase -i HEAD^ &&
+	cat >expected <<EOF &&
+On branch several_commits
+No commands done.
+Next command to do (1 remaining command):
+   pick $COMMIT four_commit
+  (use "git rebase --edit-todo" to view and edit)
+You are currently editing a commit while rebasing branch '\''several_commits'\'' on '\''$ONTO'\''.
+  (use "git commit --amend" to amend the current commit)
+  (use "git rebase --continue" once you are satisfied with your changes)
+
+nothing to commit (use -u to show untracked files)
+EOF
+	test_i18ncmp expected actual
+'
+
 test_done
diff --git a/wt-status.c b/wt-status.c
index a715e71906..4dff0b3e21 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -1135,14 +1135,17 @@ static void abbrev_sha1_in_line(struct strbuf *line)
 	strbuf_list_free(split);
 }
 
-static void read_rebase_todolist(const char *fname, struct string_list *lines)
+static int read_rebase_todolist(const char *fname, struct string_list *lines)
 {
 	struct strbuf line = STRBUF_INIT;
 	FILE *f = fopen(git_path("%s", fname), "r");
 
-	if (!f)
+	if (!f) {
+		if (errno == ENOENT)
+			return -1;
 		die_errno("Could not open file %s for reading",
 			  git_path("%s", fname));
+	}
 	while (!strbuf_getline_lf(&line, f)) {
 		if (line.len && line.buf[0] == comment_line_char)
 			continue;
@@ -1152,6 +1155,7 @@ static void read_rebase_todolist(const char *fname, struct string_list *lines)
 		abbrev_sha1_in_line(&line);
 		string_list_append(lines, line.buf);
 	}
+	return 0;
 }
 
 static void show_rebase_information(struct wt_status *s,
@@ -1166,8 +1170,10 @@ static void show_rebase_information(struct wt_status *s,
 		struct string_list yet_to_do = STRING_LIST_INIT_DUP;
 
 		read_rebase_todolist("rebase-merge/done", &have_done);
-		read_rebase_todolist("rebase-merge/git-rebase-todo", &yet_to_do);
-
+		if (read_rebase_todolist("rebase-merge/git-rebase-todo",
+					 &yet_to_do))
+			status_printf_ln(s, color,
+				_("git-rebase-todo is missing."));
 		if (have_done.nr == 0)
 			status_printf_ln(s, color, _("No commands done."));
 		else {
-- 
2.11.1.windows.prerelease.2.9.g3014b57
