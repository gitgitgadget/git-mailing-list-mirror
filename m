Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 641A2205C9
	for <e@80x24.org>; Mon,  2 Jan 2017 15:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933057AbdABPfq (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 10:35:46 -0500
Received: from mout.gmx.net ([212.227.15.15]:62493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932874AbdABPfo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 10:35:44 -0500
Received: from virtualbox ([37.24.141.236]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMk99-1cR5hx1bIt-008XPF; Mon, 02
 Jan 2017 16:35:26 +0100
Date:   Mon, 2 Jan 2017 16:35:25 +0100 (CET)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>, Kevin Daudt <me@ikke.info>,
        Dennis Kaarsemaker <dennis@kaarsemaker.net>,
        Stephan Beyer <s-beyer@gmx.net>, Jeff King <peff@peff.net>
Subject: [PATCH v3 31/38] sequencer: make reading author-script more
 elegant
In-Reply-To: <cover.1483370556.git.johannes.schindelin@gmx.de>
Message-ID: <f688d6b0aba5cc761a15c0305af8c8250e953352.1483370556.git.johannes.schindelin@gmx.de>
References: <cover.1481642927.git.johannes.schindelin@gmx.de> <cover.1483370556.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:xcqC//extl3euEiu9klpacivAPF6ysDfirXhcHbd5SuEtDS3l88
 QjF7h258SArNXjibSh2mKLzM03wmCW9GkuLxmuFirXJsySfV7RwSq/JFZf+cN7TFA/T7gCZ
 y5sl0jaAtOi185z0zpfSs6YpSVIA6TZuGS3K9WRkXzfvgeIXlH2FWdqIe6TmkTYHbaj0BST
 julM6PQ3O2ll8e5Wzg6QQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:QVNszTN6M00=:jkWh9neiMo0BEpEiQ+Q6WY
 fXDZNGM4Cr5IULTLYuGFjSkYHuhNOyR5tPqitSc5yNbtmalNrHK8n5amSEkIwaBmfz0XTh1im
 R5MsOBfxYFdm3Hr0Ir66ZRoNpMzAGV8wWrZWOOeXZDrSeTkNhnsTOZCEt0vcnYhLaqk45UvHp
 Phfp4xHPDxTEACoguAt2XdHO48wuSj4Pw9c2Ojc9va0BoNY1V+iSjbSM8Ho9NqU2mnpFxs31X
 dl9Kq1mm8qPBbq89VBa5gMreL2ZaA+PZm+CVgvTA0qREAHu4hbUCpJCI14iO10PTwjpb/XW2F
 iUCbzu26j9lidA9Rsgaorew1OApMgCLuovCOcdpaRWMzs3urPPmhrzP/lUdPpG72SMaY8asoT
 hKP7vJRtaanzP43DCVbWPSZi+a4OqFflBykUwvvExUpY51SxycD7CMIeRQzfK8tyzND/4x9sy
 OtNgc0RZBm2JIvWMt3uhz+KpsjFv8FShzXRGqdH38v7khdZQdePNRq9fWALO3DWn4unnBOh5y
 fAJgqnCBLPw1gkG+31zy4bybxKzZxnQbj8uIXg3KvUModLrsyVjN1OPW6fGAJ0WDfMXJXg+uE
 bwJIuT9aSjGCYZ1EpY/BB/5JuKF0p0X8zty76UvoreKdvuLMJQ6r/Pluc/um6GFmF4TPz/cGo
 pUGVvl94997z0pFBJYQ2IslDlXlwhSWSxBEldN9UZBmpb7UmaAnQasmc350+Rz1WsULittlDU
 65yzYk3z4TmPZeokIPa0+WvV4hI5kZbv5K7A0pLxJMz2fUjK37AdcC0X4CPSHDJB3lfzYZx8+
 YymngyO
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than abusing a strbuf to come up with an environment block, let's
just use the argv_array structure which serves the same purpose much
better.

While at it, rename the function to reflect the fact that it does not
really care exactly what environment variables are defined in said file.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 41f80ea2c4..a0d0aaeaf8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -544,18 +544,17 @@ static int write_author_script(const char *message)
 }
 
 /*
- * Read the author-script file into an environment block, ready for use in
- * run_command(), that can be free()d afterwards.
+ * Read a list of environment variable assignments (such as the author-script
+ * file) into an environment block. Returns -1 on error, 0 otherwise.
  */
-static char **read_author_script(void)
+static int read_env_script(struct argv_array *env)
 {
 	struct strbuf script = STRBUF_INIT;
 	int i, count = 0;
-	char *p, *p2, **env;
-	size_t env_size;
+	char *p, *p2;
 
 	if (strbuf_read_file(&script, rebase_path_author_script(), 256) <= 0)
-		return NULL;
+		return -1;
 
 	for (p = script.buf; *p; p++)
 		if (skip_prefix(p, "'\\\\''", (const char **)&p2))
@@ -567,19 +566,12 @@ static char **read_author_script(void)
 			count++;
 		}
 
-	env_size = (count + 1) * sizeof(*env);
-	strbuf_grow(&script, env_size);
-	memmove(script.buf + env_size, script.buf, script.len);
-	p = script.buf + env_size;
-	env = (char **)strbuf_detach(&script, NULL);
-
 	for (i = 0; i < count; i++) {
-		env[i] = p;
+		argv_array_push(env, p);
 		p += strlen(p) + 1;
 	}
-	env[count] = NULL;
 
-	return env;
+	return 0;
 }
 
 static const char staged_changes_advice[] =
@@ -612,14 +604,12 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 			  int allow_empty, int edit, int amend,
 			  int cleanup_commit_message)
 {
-	char **env = NULL;
-	struct argv_array array;
+	struct argv_array env = ARGV_ARRAY_INIT, array;
 	int rc;
 	const char *value;
 
 	if (is_rebase_i(opts)) {
-		env = read_author_script();
-		if (!env) {
+		if (!read_env_script(&env)) {
 			const char *gpg_opt = gpg_sign_opt_quoted(opts);
 
 			return error(_(staged_changes_advice),
@@ -655,9 +645,9 @@ static int run_git_commit(const char *defmsg, struct replay_opts *opts,
 		argv_array_push(&array, "--allow-empty-message");
 
 	rc = run_command_v_opt_cd_env(array.argv, RUN_GIT_CMD, NULL,
-			(const char *const *)env);
+			(const char *const *)env.argv);
 	argv_array_clear(&array);
-	free(env);
+	argv_array_clear(&env);
 
 	return rc;
 }
-- 
2.11.0.rc3.windows.1


