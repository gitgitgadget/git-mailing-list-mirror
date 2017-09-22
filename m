Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B56202A5
	for <e@80x24.org>; Fri, 22 Sep 2017 12:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752441AbdIVMEZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Sep 2017 08:04:25 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:64276 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752435AbdIVMEY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Sep 2017 08:04:24 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue003
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0M4mmf-1dA6lV1Di9-00yveE; Fri, 22
 Sep 2017 14:04:20 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] git-merge: Honor pre-merge hook
Date:   Fri, 22 Sep 2017 14:04:12 +0200
Message-Id: <053ce92e978aff511667669682c9a71830008605.1506081120.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.909.g0fa57a0913
In-Reply-To: <cover.1506081120.git.git@grubix.eu>
References: <cover.1506081120.git.git@grubix.eu>
X-Provags-ID: V03:K0:rEvE5jK76NdgzT759Do9oiSCKNVhl2K+hJiV51MI0NPKM8KDqsk
 5NL5uOBk1YfvfpWGWQ8DZ4I560HcviDf18lPdCm7hnu9AbXVkXFG9iYR5hJaXhpXalmeous
 PZj3AGT2ljQM/Tmd8O3trxpb9BKp7eIOLoGesbdcBrPavQ6Y/3qiEUJX90vOHrqA1HdPBtK
 xCKBEB1U3XME1MKiozZeQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:rJHNvprAMpM=:0Aku1SNuBRBt0iHQjRHvJ+
 IoCZp04SH9zEdEMJsh7baneRczt8ezRo3RgQM4tA7ifsAOkUgPKNhDtKxg5rULyeDq24LIxYJ
 7eFq2s6CjuKs1TwR1xj6EolswPNZsNrqOAx40sQx2iDeR7U7RIOPn9H5dVeA0l3ROb6JGv8uO
 g7GY8pYv+uteyQKXdAPDSvULLAxLoklXpm96Zsnk1XB8QiA1DnzPV7t3+ryTlQw1kUKn9Dzdo
 kDnm5fSDJbOn7Qguxso+KhUSwLEPA5xlbJkXM5+ieuWflENhdeAFtybLadjfzo31GXuK/9x8v
 bDwIDqqsGQbLTjGEQ79azbm2L7vty4CFXpzu8Ww+as6VmaRpeX/CTMnkJQmZrOnkYIDvUV9vt
 iWeTIpqmzUQ5vwude+pOnV0SHZMb+I6Dvy72zD/Mb1gSu+zBjTRnVtU3e5LEViRpgrpVDJbmy
 2e4jpGxgkj4+plSYqwetvKNRUpEO304eMXoHEKoDrsiumfb7dn4yk/lnJ6HrUNXQYT0WO5nNv
 iwnYNERbvpzOgBY7aw+b9LJrLnwYKzvq41q10FMTm1mKK9lpqN8zkINHTb+0SDwo3fGBot54w
 nt9DL+ev/oxzt9n3bawJ7HbUZyqA3c+LNWYG3wjRD/LKX7LDhd/fpeZsulDZycvLXkil8e7qL
 /Hmph2pTfoFL9xTAgrqYPiqFhe1q5dx7Wfn17QtgSyTozBu/xfIn098PpXG3HcAnhWI3Nzbkf
 1y8usavO5AJlYSJGLTcTmHrAQeb2WsxiYvOI1w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Michael J Gruber <git@drmicha.warpmail.net>

git-merge does not honor the pre-commit hook when doing automatic merge
commits, and for compatibility reasons this is going to stay.

Introduce a pre-merge hook which is called for an automatic merge commit
just like pre-commit is called for a non-automatic merge commit (or any
other commit).

Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 Documentation/githooks.txt        |  7 +++++++
 builtin/merge.c                   | 11 +++++++++++
 templates/hooks--pre-merge.sample | 13 +++++++++++++
 3 files changed, 31 insertions(+)
 create mode 100755 templates/hooks--pre-merge.sample

diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 1bb4f92d4d..85bedd208c 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -99,6 +99,13 @@ All the 'git commit' hooks are invoked with the environment
 variable `GIT_EDITOR=:` if the command will not bring up an editor
 to modify the commit message.
 
+pre-merge
+~~~~~~~~~
+
+This hook is invoked by 'git merge' when doing an automatic merge
+commit; it is equivalent to 'pre-commit' for a non-automatic commit
+for a merge.
+
 prepare-commit-msg
 ~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge.c b/builtin/merge.c
index ab5ffe85e8..de254d466b 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -769,6 +769,17 @@ static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
+	const char *index_file = get_index_file();
+
+	if (run_commit_hook(0 < option_edit, index_file, "pre-merge", NULL))
+		abort_commit(remoteheads, NULL);
+	/*
+	 * Re-read the index as pre-merge hook could have updated it,
+	 * and write it out as a tree.  We must do this before we invoke
+	 * the editor and after we invoke run_status above.
+	 */
+	discard_cache();
+	read_cache_from(index_file);
 	strbuf_addbuf(&msg, &merge_msg);
 	strbuf_addch(&msg, '\n');
 	if (squash)
diff --git a/templates/hooks--pre-merge.sample b/templates/hooks--pre-merge.sample
new file mode 100755
index 0000000000..a6313e6d5c
--- /dev/null
+++ b/templates/hooks--pre-merge.sample
@@ -0,0 +1,13 @@
+#!/bin/sh
+#
+# An example hook script to verify what is about to be committed.
+# Called by "git merge" with no arguments.  The hook should
+# exit with non-zero status after issuing an appropriate message if
+# it wants to stop the commit.
+#
+# To enable this hook, rename this file to "pre-merge".
+
+. git-sh-setup
+test -x "$GIT_DIR/hooks/pre-commit" &&
+        exec "$GIT_DIR/hooks/pre-commit"
+:
-- 
2.14.1.909.g0fa57a0913

