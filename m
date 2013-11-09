From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 22/86] help: replace prefixcmd() with has_prefix()
Date: Sat, 09 Nov 2013 08:06:15 +0100
Message-ID: <20131109070720.18178.26715.chriscool@tuxfamily.org>
References: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Max Horn <max@quendi.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Nov 09 08:11:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vf2hB-0004uI-2w
	for gcvg-git-2@plane.gmane.org; Sat, 09 Nov 2013 08:11:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933357Ab3KIHKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Nov 2013 02:10:53 -0500
Received: from mail-3y.bbox.fr ([194.158.98.45]:54162 "EHLO mail-3y.bbox.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933266Ab3KIHIe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Nov 2013 02:08:34 -0500
Received: from [127.0.1.1] (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr [128.78.31.246])
	by mail-3y.bbox.fr (Postfix) with ESMTP id D6E2580;
	Sat,  9 Nov 2013 08:08:28 +0100 (CET)
X-git-sha1: 508d78bcf7400d3ca6c89834f6e72863d4bd26a7 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20131109070358.18178.40248.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237522>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 help.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/help.c b/help.c
index f068925..b41d2d5 100644
--- a/help.c
+++ b/help.c
@@ -148,7 +148,7 @@ static void list_commands_in_dir(struct cmdnames *cmds,
 	while ((de = readdir(dir)) != NULL) {
 		int entlen;
 
-		if (prefixcmp(de->d_name, prefix))
+		if (!has_prefix(de->d_name, prefix))
 			continue;
 
 		strbuf_setlen(&buf, len);
@@ -255,7 +255,7 @@ static int git_unknown_cmd_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "help.autocorrect"))
 		autocorrect = git_config_int(var,value);
 	/* Also use aliases for command lookup */
-	if (!prefixcmp(var, "alias."))
+	if (has_prefix(var, "alias."))
 		add_cmdname(&aliases, var + 6, strlen(var + 6));
 
 	return git_default_config(var, value, cb);
@@ -329,7 +329,7 @@ const char *help_unknown_cmd(const char *cmd)
 		if ((n < ARRAY_SIZE(common_cmds)) && !cmp) {
 			/* Yes, this is one of the common commands */
 			n++; /* use the entry from common_cmds[] */
-			if (!prefixcmp(candidate, cmd)) {
+			if (has_prefix(candidate, cmd)) {
 				/* Give prefix match a very good score */
 				main_cmds.names[i]->len = 0;
 				continue;
@@ -414,7 +414,7 @@ static int append_similar_ref(const char *refname, const unsigned char *sha1,
 	struct similar_ref_cb *cb = (struct similar_ref_cb *)(cb_data);
 	char *branch = strrchr(refname, '/') + 1;
 	/* A remote branch of the same name is deemed similar */
-	if (!prefixcmp(refname, "refs/remotes/") &&
+	if (has_prefix(refname, "refs/remotes/") &&
 	    !strcmp(branch, cb->base_ref))
 		string_list_append(cb->similar_refs,
 				   refname + strlen("refs/remotes/"));
-- 
1.8.4.1.566.geca833c
