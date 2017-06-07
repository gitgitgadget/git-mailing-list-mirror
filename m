Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B720C1FACB
	for <e@80x24.org>; Wed,  7 Jun 2017 16:07:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751535AbdFGQHB (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Jun 2017 12:07:01 -0400
Received: from mout.gmx.net ([212.227.15.19]:63794 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751531AbdFGQHA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2017 12:07:00 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MbxJ8-1dbx3B47ss-00JNWh; Wed, 07
 Jun 2017 18:06:56 +0200
Date:   Wed, 7 Jun 2017 18:06:55 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 7/9] alias_lookup(): optionally return top-level directory
In-Reply-To: <cover.1496851544.git.johannes.schindelin@gmx.de>
Message-ID: <a5bf8684025908e395a9ff664539ba8b3b83e1a3.1496851544.git.johannes.schindelin@gmx.de>
References: <cover.1496851544.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:gXwTwYx132q60O91s+DpRaUJb2FzBxRNB64uxR9z8zKNTSI9bz9
 TL+0CnvIas4KDYapwHatEH3AwVHo2olw7pvfPNQ7aPEoGADR6tULWwC2AmopmeiL2dD6g5l
 1RoyKQENekcoEdkBh+WKEHTwJ5vBbxNWQvbnh/p/YLn1yWHzN6/TjtZtZQrji8Mmperm4PA
 gPG7r4V8rrWvK3gUJ2FJQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lyrWs5Z9O+A=:zJPAnQyOpMmxcKxLq1ZGJ6
 8PycwGoOi/dI95bbCoI8I4D0JuSHnbuPXfrwR5cYcahvdBRZd6cw6qYkXbD4YDIhxVdrLUWef
 TOmtos7dRPa6kwHfHdIjTPAtC22nDdJCWwZ9GWpeEg3P285bP/hscedmlhdphAxL/WqmEongP
 Y+YZ41io3kS48qZl/0nSR29rKWvbZt7rBaZMDqswM89ZUw4VJf0g4BoFd9nlixLGVT/t94XoD
 mj7ZmvONlxKT2aXjNhmrcBTyOqE0hDDnKdb2drRmCAiqg0CUPEZ2/XFUXuB/esDdc2vTbCR9W
 HuaZRGyp/o7l99orLs6N6HyuLawQ6z/aaSagFnHt9kVmsSV6B+2zP3lRX7JBLwm1qAhAlOLzU
 nzOo3i6TdWW4EkU8x5bYs8+NK2TntYqR0MB/r1hji1voPDNi7NLYk2Jy/uuPvh9IbN88vuu/H
 uA/4sOQL0XY2czpU4QGGqhMfbz80A/Z9XXrAeITwHMdOEtTrgHy7glPOfMSfo27vi/uGEydmh
 UdU2uSM1f/XlF2aXV+b51A2L1YiK0tUi6d8mBC0OpD8+SQUDRTigtaYhvcberW1UGqkkHJtIC
 8ymoKQ8aBgdK6MDNKLXZ9Ks8S91kW82m+rYdxzIYD2xxen6vplP7i3S6KOlE8FF/ztv6U76Q4
 aq3f/re4U4Xzv4qTztt3P7Vn4JqxGqab4vmphOygKf/BFd2bUevmjaCoC/L6/2duMSxJBM9r0
 710RyEQ5d6ehJsB3y+3TcuJ6sR4PabRuG9mDb05cKrPkXySIcjr3y1ue9krtgtq5cPu8BKJ7p
 d/wskiW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When an alias expands to a shell command, and when we are inside a
regular worktree's subdirectory (i.e. not inside the .git/ directory nor
in a worktree initialized via `git worktree add`), and only then, the
current working directory is switched to the top-level directory of the
worktree before running the expanded alias.

While this behavior is somewhat confusing, it is well-established and
needs to be preserved, even with the upcoming change to use the early
config machinery to expand aliases.

That means that alias_lookup() needs to determine the working directory
to switch to, in case the alias turns out to expand to a shall command.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 alias.c        | 33 +++++++++++++++++++++++++--------
 builtin/help.c |  2 +-
 cache.h        |  2 +-
 git.c          |  2 +-
 4 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/alias.c b/alias.c
index 3b90397a99d..c1b87154944 100644
--- a/alias.c
+++ b/alias.c
@@ -1,14 +1,31 @@
 #include "cache.h"
 
-char *alias_lookup(const char *alias)
+struct config_alias_data
 {
-	char *v = NULL;
-	struct strbuf key = STRBUF_INIT;
-	strbuf_addf(&key, "alias.%s", alias);
-	if (git_config_key_is_valid(key.buf))
-		git_config_get_string(key.buf, &v);
-	strbuf_release(&key);
-	return v;
+	struct strbuf key;
+	char *v;
+};
+
+static int config_alias_cb(const char *key, const char *value, void *d)
+{
+	struct config_alias_data *data = d;
+
+	if (!strcmp(key, data->key.buf))
+		return git_config_string((const char **)&data->v, key, value);
+
+	return 0;
+}
+
+char *alias_lookup(const char *alias, struct strbuf *worktree_dir)
+{
+	struct config_alias_data data = { STRBUF_INIT, NULL };
+
+	strbuf_addf(&data.key, "alias.%s", alias);
+	if (git_config_key_is_valid(data.key.buf))
+		read_early_config(config_alias_cb, &data, worktree_dir);
+	strbuf_release(&data.key);
+
+	return data.v;
 }
 
 #define SPLIT_CMDLINE_BAD_ENDING 1
diff --git a/builtin/help.c b/builtin/help.c
index 49f7a07f85d..6f208ff1ab3 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -435,7 +435,7 @@ static const char *check_git_cmd(const char* cmd)
 	if (is_git_command(cmd))
 		return cmd;
 
-	alias = alias_lookup(cmd);
+	alias = alias_lookup(cmd, NULL);
 	if (alias) {
 		printf_ln(_("`git %s' is aliased to `%s'"), cmd, alias);
 		free(alias);
diff --git a/cache.h b/cache.h
index a8bbddf5955..77ce8e8c80b 100644
--- a/cache.h
+++ b/cache.h
@@ -2189,7 +2189,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 /* ls-files */
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
-char *alias_lookup(const char *alias);
+char *alias_lookup(const char *alias, struct strbuf *worktree_dir);
 int split_cmdline(char *cmdline, const char ***argv);
 /* Takes a negative value returned by split_cmdline */
 const char *split_cmdline_strerror(int cmdline_errno);
diff --git a/git.c b/git.c
index 8ff44f081d4..4163beaead4 100644
--- a/git.c
+++ b/git.c
@@ -256,7 +256,7 @@ static int handle_alias(int *argcp, const char ***argv)
 	setup_git_directory_gently(&unused_nongit);
 
 	alias_command = (*argv)[0];
-	alias_string = alias_lookup(alias_command);
+	alias_string = alias_lookup(alias_command, NULL);
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			struct child_process child = CHILD_PROCESS_INIT;
-- 
2.13.0.windows.1.460.g13f583bedb5


