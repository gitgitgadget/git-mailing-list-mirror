Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 621B31F454
	for <e@80x24.org>; Sun, 21 Oct 2018 18:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbeJVDB1 (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 23:01:27 -0400
Received: from mout.gmx.net ([212.227.15.19]:50069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727999AbeJVDB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 23:01:26 -0400
Received: from p2520la.lan ([217.235.92.200]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbOoG-1fvXOw3CXk-00Ioza; Sun, 21
 Oct 2018 20:46:10 +0200
Received: from p2520la.lan ([217.235.92.200]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbOoG-1fvXOw3CXk-00Ioza; Sun, 21
 Oct 2018 20:46:10 +0200
From:   Tim Schumacher <timschumi@gmx.de>
To:     git@vger.kernel.org
Cc:     timschumi@gmx.de
Subject: [PATCH 2/2] alias: Move checking code into a seperate function
Date:   Sun, 21 Oct 2018 20:46:19 +0200
Message-Id: <20181021184619.6688-2-timschumi@gmx.de>
X-Mailer: git-send-email 2.19.1.450.ga4b8ab536
In-Reply-To: <20181021184619.6688-1-timschumi@gmx.de>
References: <20181021184619.6688-1-timschumi@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:deAdfgkfrRfr68uCpq6hhE0kkyUlyURjBcpP8FXjPPDooFod/PL
 Rg63pL8wzQGl/hIxWYKoz1AAi65IUMxi6BK9/SD0Utl03TBJVMqbE+Jm+eowBktLO4ECdlO
 iH/QswPCxZf9LEllCpJR5j6gz61BGZZ6j2w7LY1aCgW/uu6dLpmFin0OiwerVKuJGbOMg5E
 n5AXwEYK7AbHgZ3gtWnvg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:yUZV1FKSkvE=:fBisPAB4Qy48pLg39efZyU
 WVb76zZutTLaR9Km4emuiAxT53zXY5Ph7rigs9F+jPbEbrCXjd4mEZdrtbof6Y0/rpu7t3Ibm
 EHE81OOaHwg1jNYgn/VXABnm7FX4uM+oXBr6zbiTyQ7isGLc9XihxkPevDkG0ZGbrj4egr0DH
 gEiy5c50GzOzIQWKA35Fbh38bLlKukKSR+BEKN+rJAOt6lSyMz0sWJMifafwUwi2AYvwoLho/
 LySF6QU65eGKmlaIQIP/E4shkTg/h0mbgTf/FQjO3/VJwijVnRmFrrCrNqiS1BMk767fsDZRY
 dEZZVsAx6OXcNPE8hGpd+S6E67mDN9ueHZL+NwiVIJNpQ6KkWYl4qLbU98DGp5CCDxQksTZpw
 4+rmK9Zwk6KWNu+NJJr8frgjj1k3n5yK4NqON4YWXC4xo1wTlg+xljfnKwON06Be++4L7MlPV
 4LqyGfJGGJw/s5W3UKyY1bOOm7WMzRS3mOvQDmlSzA4aPkJhhGo35U9qWnpiw7Av0GtpxlStR
 Hq5G66veqeWse/36Q2JFl8H/PJ7rzerFSHlhse+IcAeBxI8LTkErHbR9xjduCkxo/YgKN12tV
 Y+2L8RflNiK0ZPVXBtlY+UX0bovl2IcWolagKKegbFTM9xl7uvenDrn2FAH6VH+g2AQP2JuOn
 Gvz6PA3KIELOtIILNHUw6gIcNPdnCA50BaM//hXaBBBfMuiW4lLrf7+GpaAizN4f5e8L19VaY
 tHkAAbJ6dw7TUyO9NJz6ryPb5HZmdjLUxRanPXbFHwT7qwu/BufZarERpA26c9a5qelCx9kqt
 gfF+KTJEc6YB+9nIH4/G68kqceJ0g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can save a few indentations (and possibly brain cells of people
that don't care about that code) by moving the code that checks for
a looping alias (and that prints the error message if one is found)
into a seperate function.

This restores a lot of readablility to the run_argv() function as
well, because it was only concerned with the high-level routing of
the command and alias logic before.
---
 git.c | 40 +++++++++++++++++++++++-----------------
 1 file changed, 23 insertions(+), 17 deletions(-)

diff --git a/git.c b/git.c
index 0f77bce7d..b6fdd9708 100644
--- a/git.c
+++ b/git.c
@@ -710,11 +710,32 @@ static void add_cmd_history(struct strbuf *env, struct string_list *cmd_list,
 	setenv(COMMAND_HISTORY_ENVIRONMENT, env->buf, 1);
 }
 
+static void cmd_unique_or_die(struct string_list *cmd_list, const char *cmd)
+{
+	struct string_list_item *seen;
+
+	seen = unsorted_string_list_lookup(cmd_list, cmd);
+	if (!seen)
+		return;
+
+	int i;
+	struct strbuf sb = STRBUF_INIT;
+	for (i = 0; i < cmd_list->nr; i++) {
+		struct string_list_item *item = &cmd_list->items[i];
+		strbuf_addf(&sb, "\n  %s", item->string);
+		if (item == seen)
+			strbuf_addstr(&sb, " <==");
+		else if (i == cmd_list->nr - 1)
+			strbuf_addstr(&sb, " ==>");
+	}
+	die(_("alias loop detected: expansion of '%s' does not terminate:%s"),
+	    cmd_list->items[0].string, sb.buf);
+}
+
 static int run_argv(int *argcp, const char ***argv)
 {
 	int done_alias = 0;
 	struct string_list cmd_list = STRING_LIST_INIT_DUP;
-	struct string_list_item *seen;
 	struct strbuf env = STRBUF_INIT;
 
 	init_cmd_history(&env, &cmd_list);
@@ -739,22 +760,7 @@ static int run_argv(int *argcp, const char ***argv)
 		/* .. then try the external ones */
 		execv_dashed_external(*argv);
 
-		seen = unsorted_string_list_lookup(&cmd_list, *argv[0]);
-		if (seen) {
-			int i;
-			struct strbuf sb = STRBUF_INIT;
-			for (i = 0; i < cmd_list.nr; i++) {
-				struct string_list_item *item = &cmd_list.items[i];
-
-				strbuf_addf(&sb, "\n  %s", item->string);
-				if (item == seen)
-					strbuf_addstr(&sb, " <==");
-				else if (i == cmd_list.nr - 1)
-					strbuf_addstr(&sb, " ==>");
-			}
-			die(_("alias loop detected: expansion of '%s' does"
-			      " not terminate:%s"), cmd_list.items[0].string, sb.buf);
-		}
+		cmd_unique_or_die(&cmd_list, *argv[0]);
 
 		add_cmd_history(&env, &cmd_list, *argv[0]);
 
-- 
2.19.1.450.ga4b8ab536

