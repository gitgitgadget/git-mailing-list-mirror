Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 980672076C
	for <e@80x24.org>; Mon, 29 Aug 2016 08:06:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756130AbcH2IGR (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 04:06:17 -0400
Received: from mout.gmx.net ([212.227.15.19]:64246 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932511AbcH2IGM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 04:06:12 -0400
Received: from virtualbox ([37.24.141.250]) by mail.gmx.com (mrgmx003) with
 ESMTPSA (Nemesis) id 0MJBRC-1bfvTf0Uhe-002mNy; Mon, 29 Aug 2016 10:06:09
 +0200
Date:   Mon, 29 Aug 2016 10:06:08 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 16/22] sequencer: prepare for rebase -i's GPG settings
In-Reply-To: <cover.1472457609.git.johannes.schindelin@gmx.de>
Message-ID: <c6a37af958f59390c00429a5b38b34d34c9a5b95.1472457609.git.johannes.schindelin@gmx.de>
References: <cover.1472457609.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:FPVVmunCBszAAOwTPpzuAS3JXrJhQdQykzDCaGUdbTRlTJfOYps
 xNv7r924MONCRzZ/4OpvsKgdDQBVlLszpYeRycnkdQaiHNaufTbfiyYfzgPVRt34HpEyvzV
 9QIxKRTKH5X/poCpu4MLZDbr+acjYMHxeBkj+0V4boMBELZ2VeVVAMsqzN4ZkgRqV+75Bog
 NdA/EPVU84rrURJpYPJ9Q==
X-UI-Out-Filterresults: notjunk:1;V01:K0:KJyb7nX0X9A=:6hYYYxxdpUY7uCdJTGElR3
 Pagx8dBxUpSHbwRaIPoEONhn14Q5fipV9FwlHL3jBb4GRNO+eRNfF9tzuCpHPE+QXBgo3D++H
 xsWfvqAF2RO+hw45+1Od7JhitFz0vhX1oWbYmJZ3XDZmCll3F72Wuy5xy1NuuttYq3bhSSZ+A
 WtSmeWXTxCoIRmHhqbVYLmY+eg42Ps62UEtGVvZmfK287PBbDa+IODvL5/8yicsV7hpQzmXc/
 4X18r6yj4jZvQsC29oDGTcVWsQ9fDRH0xF7wftAhNyljFoDMPZ5j8VcXUqRoNN3IPGXg9uI6u
 t6M/23qS0QfES5PqvANCYhggSrMgh2R4BIqBlYD2c2OtRrad76EfnGv9Ph6t52mFFltLUyiCv
 o6cxWfDY2NWoPtFAhYj+NgzAxPdx844N1gUnsYYRnoD6V5rDfKxOkAxFqbL2Z9WBbROKh/rPk
 JkqQgTpgurbgQvj8yKgDlEUOHcpNvC21DrpGmGkptHvwTxK69dDaMWc1KvOud6/08w70WyS+Z
 JA6cEs5U24gK4Bf9AreqL8IRN4N18jLHLC04oooq9L/+F4lL8wpXWtMNOrLi12WEYR7cINADS
 qFwV8b8JatVMdH209sz8kGNweP0MDad1U5RsO8DwpA+hotpTpfMAq4AtfpttPWnZFIQHQiCWR
 OhdfvEy2T5cDBOuWAUHdSWUsbtHaXzXQWwJsbB+fXxfG3sPNDa6bj0RKzMX7UfNPJ/7RJk5z5
 rDsDdJTOQuZIlEkROeCUtg5zt2mauV01IN++w6zeWDiPI/OVNsoazSCJ0jk1Yg/yUYRjyRCyB
 XnQ8vvb
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The rebase command sports a `--gpg-sign` option that is heeded by the
interactive rebase.

This patch teaches the sequencer that trick, as part of the bigger
effort to make the sequencer the work horse of the interactive rebase.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 sequencer.c | 48 +++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index 4204cc8..e094ac2 100644
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
 #define IS_REBASE_I() 0
@@ -129,6 +135,16 @@ static int has_conforming_footer(struct strbuf *sb, struct strbuf *sob,
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
 void *sequencer_entrust(struct replay_opts *opts, void *set_me_free_after_use)
 {
 	ALLOC_GROW(opts->owned, opts->owned_nr + 1, opts->owned_alloc);
@@ -471,17 +487,20 @@ int sequencer_commit(const char *defmsg, struct replay_opts *opts,
 
 	if (IS_REBASE_I()) {
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
 				"In both case, once you're done, continue "
 				"with:\n\n"
-				"  git rebase --continue\n");
+				"  git rebase --continue\n", gpg_opt, gpg_opt);
+		}
 	}
 
 	argv_array_init(&array);
@@ -955,8 +974,27 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
 
 static int read_populate_opts(struct replay_opts *opts)
 {
-	if (IS_REBASE_I())
+	if (IS_REBASE_I()) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (read_oneliner(&buf, rebase_path_gpg_sign_opt(), 1)) {
+			if (buf.len && buf.buf[buf.len - 1] == '\n') {
+				if (--buf.len &&
+				    buf.buf[buf.len - 1] == '\r')
+					buf.len--;
+				buf.buf[buf.len] = '\0';
+			}
+
+			if (!starts_with(buf.buf, "-S"))
+				strbuf_reset(&buf);
+			else {
+				opts->gpg_sign = buf.buf + 2;
+				strbuf_detach(&buf, NULL);
+			}
+		}
+
 		return 0;
+	}
 
 	if (!file_exists(git_path_opts_file()))
 		return 0;
-- 
2.10.0.rc1.114.g2bd6b38


