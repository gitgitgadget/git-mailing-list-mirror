Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C760B20954
	for <e@80x24.org>; Tue, 28 Nov 2017 23:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751901AbdK1XWu (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 18:22:50 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:46694 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752187AbdK1XWt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 18:22:49 -0500
Received: by mail-pg0-f68.google.com with SMTP id b11so623353pgu.13
        for <git@vger.kernel.org>; Tue, 28 Nov 2017 15:22:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xBv3z4mSgsPaouapDxsJJ2r5gWNhe9BMPLZeN0Sfc5M=;
        b=tsKbuzWimEDPC405yrn2BdeCk/6qZOlfhREANKSdKqNy0Ua/2F8ObFx6Coo4ddavCU
         VaZ57ZDcX67O5RoIfvxbbH0rX+LxdBOD2XDhQ9YOXM0IPe228aaGMpyHMVaBD/PmMAWr
         9bPJ+shj2imzLyjumZ6ASYsAQPwvtlakQNwEonnVv4PGGX6dHDn5QHS3sQ/xaONqJNcA
         1QAOO/vnQ1AjFRx2Tl/pemFjdKKZ7qyeFuqwfBL9kRr7NLwdyV66zp2RM+MxGDH3Jc0W
         saVCdLXfWgK/+QQWb0/6ePDKUVGd5uXzDf+Oh+y33bRqb4I24HssLOMQKo2yksUHp+Pu
         Sm3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xBv3z4mSgsPaouapDxsJJ2r5gWNhe9BMPLZeN0Sfc5M=;
        b=mjrsVL3ZtgXtmddrBsbFB3TXO+5l1O7nwYtm+wi5wbYBNpeoYDvG6h9gyjLNrAjRA+
         ZSIdxYYwfkzKGqNl7tSJRoMIEvNGy5SH5cgfoqdk6EBT3X7Dqd0TR73pwHwyRJbc89fR
         dW8kFB0kQenbecndRS+C49upA8i/NvbfFcUBBPFPHc9FsJvgY84p24dAjkpfVyKmeI46
         XCm1nHJn39gtm9wrbUSqK+e52ldtjt4rXZT58q0CYabeiVpNSqJqkRZuXb80TKayovQZ
         gJELCovHI3ATwN7JsZVsfsFrgnqKOGQ22votHMdmwYJcDPCv1pYel1wFzXQ+HT0OI1j+
         PY9w==
X-Gm-Message-State: AJaThX7pcTmCh7rzF233aASTlHyS1gfSscFEHmX3FLpXs/0lxhR7Xe4U
        V6liprzdqdwsk22wM9gKH4H+BdILfgY=
X-Google-Smtp-Source: AGs4zMb4E6VbiwvT5Ng1qOMnkMgkPBIumAxvZjt8iY5s8nJESbSUaH1Bz1KtA+ZaWGdEEwKENz4X5w==
X-Received: by 10.98.99.68 with SMTP id x65mr870569pfb.56.1511911368382;
        Tue, 28 Nov 2017 15:22:48 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x77sm273093pfe.61.2017.11.28.15.22.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 28 Nov 2017 15:22:47 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, pclouds@gmail.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH] pathspec: only match across submodule boundaries when requested
Date:   Tue, 28 Nov 2017 15:22:37 -0800
Message-Id: <20171128232237.54453-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.0.531.g2ccb3012c9-goog
In-Reply-To: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
References: <alpine.DEB.2.21.1.1711260210060.6482@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 74ed43711fd (grep: enable recurse-submodules to work on <tree>
objects, 2016-12-16) taught 'tree_entry_interesting()' to be able to
match across submodule boundaries in the presence of wildcards.  This is
done by performing literal matching up to the first wildcard and then
punting to the submodule itself to perform more accurate pattern
matching.  Instead of introducing a new flag to request this behavior,
commit 74ed43711fd overloaded the already existing 'recursive' flag in
'struct pathspec' to request this behavior.

This leads to a bug where whenever any other caller has the 'recursive'
flag set as well as a pathspec with wildcards that all submodules will
be indicated as matches.  One simple example of this is:

	git init repo
	cd repo

	git init submodule
	git -C submodule commit -m initial --allow-empty

	touch "[bracket]"
	git add "[bracket]"
	git commit -m bracket
	git add submodule
	git commit -m submodule

	git rev-list HEAD -- "[bracket]"

Fix this by introducing the new flag 'recurse_submodules' in 'struct
pathspec' and using this flag to determine if matches should be allowed
to cross submodule boundaries.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/grep.c                |  1 +
 pathspec.h                    |  1 +
 t/t4208-log-magic-pathspec.sh | 17 +++++++++++++++++
 tree-walk.c                   |  5 +++--
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5a6cfe6b4..3ca4ac80d 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1015,6 +1015,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 		       prefix, argv + i);
 	pathspec.max_depth = opt.max_depth;
 	pathspec.recursive = 1;
+	pathspec.recurse_submodules = !!recurse_submodules;
 
 #ifndef NO_PTHREADS
 	if (list.nr || cached || show_in_pager)
diff --git a/pathspec.h b/pathspec.h
index 6420d1080..099a170c2 100644
--- a/pathspec.h
+++ b/pathspec.h
@@ -24,6 +24,7 @@ struct pathspec {
 	int nr;
 	unsigned int has_wildcard:1;
 	unsigned int recursive:1;
+	unsigned int recurse_submodules:1;
 	unsigned magic;
 	int max_depth;
 	struct pathspec_item {
diff --git a/t/t4208-log-magic-pathspec.sh b/t/t4208-log-magic-pathspec.sh
index 935df6a65..bd583af0e 100755
--- a/t/t4208-log-magic-pathspec.sh
+++ b/t/t4208-log-magic-pathspec.sh
@@ -93,4 +93,21 @@ test_expect_success 'command line pathspec parsing for "git log"' '
 	git log --merge -- a
 '
 
+test_expect_success 'tree_entry_interesting does not match past submodule boundaries' '
+	test_when_finished "rm -rf repo submodule" &&
+	git init submodule &&
+	test_commit -C submodule initial &&
+	git init repo &&
+	>"repo/[bracket]" &&
+	git -C repo add "[bracket]" &&
+	git -C repo commit -m bracket &&
+	git -C repo rev-list HEAD -- "[bracket]" >expect &&
+
+	git -C repo submodule add ../submodule &&
+	git -C repo commit -m submodule &&
+
+	git -C repo rev-list HEAD -- "[bracket]" >actual &&
+	test_cmp expect actual
+'
+
 test_done
diff --git a/tree-walk.c b/tree-walk.c
index 684f0e337..63a87ed66 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -1011,7 +1011,8 @@ static enum interesting do_match(const struct name_entry *entry,
 				 * character.  More accurate matching can then
 				 * be performed in the submodule itself.
 				 */
-				if (ps->recursive && S_ISGITLINK(entry->mode) &&
+				if (ps->recurse_submodules &&
+				    S_ISGITLINK(entry->mode) &&
 				    !ps_strncmp(item, match + baselen,
 						entry->path,
 						item->nowildcard_len - baselen))
@@ -1060,7 +1061,7 @@ static enum interesting do_match(const struct name_entry *entry,
 		 * character.  More accurate matching can then
 		 * be performed in the submodule itself.
 		 */
-		if (ps->recursive && S_ISGITLINK(entry->mode) &&
+		if (ps->recurse_submodules && S_ISGITLINK(entry->mode) &&
 		    !ps_strncmp(item, match, base->buf + base_offset,
 				item->nowildcard_len)) {
 			strbuf_setlen(base, base_offset + baselen);
-- 
2.15.0.531.g2ccb3012c9-goog

