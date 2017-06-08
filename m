Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F3281FAE5
	for <e@80x24.org>; Thu,  8 Jun 2017 19:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751711AbdFHTyF (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Jun 2017 15:54:05 -0400
Received: from mout.gmx.net ([212.227.15.19]:54549 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751522AbdFHTyE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Jun 2017 15:54:04 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0M4GRv-1eA3Ui0HdD-00rlAb; Thu, 08
 Jun 2017 21:53:51 +0200
Date:   Thu, 8 Jun 2017 21:53:50 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 7/8] alias_lookup(): optionally return top-level
 directory
In-Reply-To: <cover.1496951503.git.johannes.schindelin@gmx.de>
Message-ID: <aa6601bbfa50c728b7820e0a2991da76288509a5.1496951503.git.johannes.schindelin@gmx.de>
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:GnP0ZlGUeSAJqavRHf9VdnybIab1H60TfswbHD1llr+eEGnpFUf
 2iSNh4aP0ILYf8z5rdrOipnl4nrbxL4qOcq8I38M+JGmOAu08Y9dVX+gVEb8O6j6e+yaB8d
 tOINFIFkQdqOvnP1M7514kg7R2164pVIUCj5McIGkfnAVFK+OudBr6Brp3aUjeXX4POjEnC
 GRHUj97RJMCBYiMvLUlkA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lF9QBbMYu58=:+DvLUWL0gFB50KQ/qnPtEn
 3YpEa0uno3HWq+vjuvKIlA/xqgpleCCm/vilfa01/3FskxCVtUQ5SVsYgA1zpmj9PyAD3XF0E
 PJHuTNRlWL3pLlwmbpNDB94PGMSUYXKfpXbtsNGxRCI+1EXxHoe1qwzmJ4i7gDVX8HKbu27S+
 EfvpVY1fFybMzI8cwLKPQ05wV5f42XT5D1/WHwi25MFmtpoSPnaS3hlD1vbO1xzna1IHavThS
 UcekVPfqX3QRwa5VcUvhyy8RZTyl9WA08ZyVdCfs1bU+T9CD+o1diQNkFCpB9C1HyHq2fCf5j
 jmw3b4bM/t8yPBL7jSEEsRdWq1uMEJQR8dVYMCIwLJTwBkM5WxybmrYb7zLTGgKXJ9yF/jvhj
 i5XApYPhuGxLhMvedgBbXZIwBdV9QBgcGtqgDxqkJWtiqRNlyqk4NnoE+hMDgH9CARn2NIpJ4
 cfwEKnEgdd672ilIiygcgKUPRvC+Zau/sfHMcYuGoDbrexVsHiUWrI6UwL8nDauSKOvE9jLny
 k5jUXrxIOHtpAE3PAbHkI4SYnbnk90oLzqXPXs85GhXj9uXq4Ze4BCHQNIbAZOZV3Kt8C4sau
 kfezwru3glxWuzCcjfFVQ0lDmfT4I2SFhzFF8Yb0DxqnvWTpWsS6KupTI6jpu0Wxn3KY5IJg6
 hZYmJlPRMVyd5pmAr1gUBe61vER5kQ5e13xySkSBvkMhK23QbpKL0jvKYphdrg42urBRT+kik
 ZDfpgSVR2LvJC3WG2kQfbGSjj/mac+GsgUCKSDi61WzahEzrAVdhyu8nkEca6P+dD3FKlnBC4
 NgkTKKt
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
index 3b90397a99d..b7c4a4f0217 100644
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
+char *alias_lookup(const char *alias, struct strbuf *cdup_dir)
+{
+	struct config_alias_data data = { STRBUF_INIT, NULL };
+
+	strbuf_addf(&data.key, "alias.%s", alias);
+	if (git_config_key_is_valid(data.key.buf))
+		read_early_config(config_alias_cb, &data, cdup_dir);
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
index f769ef1779c..65f2e5bf04c 100644
--- a/cache.h
+++ b/cache.h
@@ -2189,7 +2189,7 @@ extern int ws_blank_line(const char *line, int len, unsigned ws_rule);
 /* ls-files */
 void overlay_tree_on_cache(const char *tree_name, const char *prefix);
 
-char *alias_lookup(const char *alias);
+char *alias_lookup(const char *alias, struct strbuf *cdup_dir);
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


