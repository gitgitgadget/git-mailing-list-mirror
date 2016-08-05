Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A28F62018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S942956AbcHEUjM (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:39:12 -0400
Received: from mout.web.de ([212.227.17.11]:54718 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762074AbcHEUjI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:39:08 -0400
Received: from [192.168.178.36] ([79.213.113.59]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0M5wrF-1bKoXs2Pph-00xso2; Fri, 05 Aug 2016 22:38:45
 +0200
To:	Git List <git@vger.kernel.org>
Cc:	Junio C Hamano <gitster@pobox.com>
From:	=?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] use CHILD_PROCESS_INIT to initialize automatic variables
Message-ID: <57A4F954.5090607@web.de>
Date:	Fri, 5 Aug 2016 22:38:44 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:jsnlAhHmbSekNJmwTt/h5DmJYomiGJA5s4tNe6aKTLrTamsRUDu
 E+CWf/Sv2INDPg5NayxkOia6WV6+xU0O1JusRFz0u8fYlwJYK2CTy4AZVd3Ajvz5SaJI/QU
 aT3zFnVY6p0mEk1ohx2Z9fFxgW2meRP/ny6XItLgBrrjXPddp4arvVq2iyEYmz/2LQ1Ej3h
 a5n4sPwnlTb1AmXyUGJmA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:ylNBe1ffOsM=:iWIjxp7M7EwruPNoEIJzJN
 7bSa5hDdtmk5iF/ucL6f/zVMLMtzP8ThjQbmwT4euw3ilsDRKN83ODRDUT7T3MF9xcBnEPF52
 7ptrODXHnwLfYfwDW4E6sSA0QsCV5SdrbP64lSNGMQoa+3ECu30Ovt7KxLa03S2DEBD6lToPH
 ruMmi9GvAgBGRjTonSOLgff0uDHG1MfhAKKLu2jw6xEw28360XD7mis238wEqdjutwLUvNHIz
 KT8VweDv72qvU39XbSh+WboccQC3qnxrhOeH8q89z8z5zrSwpk6L9O34MQNV1Ql1pci0T19GF
 VwZgXdFbrhPdxEsHklV6CDcfWsFuHMxyDDRnhfUtcATARQ724Z5nCMNgNONU3ZmQS83y81TVT
 2n9H6uFq6TnWc8+Qzu/efLWsbPBDOawMyHbinDvJUM4yX5A0QaONd9yRPUKWkw+tgU2jBToos
 T3+J95izxIpyYy3H0ChHaurXKysuU2cgft1o7dVh9t5L6PxWs5jszvBMaHJjIPurS0S39/Exf
 ySZvVPqCpb+9Q01x7en/V3U5JTA57XBQi2xQPK1vJitsXDERejCaWx9WCq7lNg1nUtIMlF7XP
 PK1dYCFEUAMGiOmlk6Hf0aRp8u12nOyWGtPFWGnB2WghR+H6pe6QT9TPBoS0sNVsrqXBtSEYG
 Wp/KHQnbb7rSPbVL7ttnSjiAVDMbkeSMqBHTIG4ykJeBP+PYD+qJQ/khI9n8zdtFRRf3VZC7l
 JCNl57FNzWrfrNdxqp2eLVzxWrtU1Dgm5zy3Z5MdQRmhGlz5zqFvzxvERJ//4ssV8i/mtvOFm
 Qiu5+Vg
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Initialize struct child_process variables already when they're defined.
That's shorter and saves a function call.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 builtin/submodule--helper.c | 3 +--
 builtin/worktree.c          | 6 ++----
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b22352b..957f42a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,8 +444,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
 			   const char *depth, const char *reference, int quiet)
 {
-	struct child_process cp;
-	child_process_init(&cp);
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	argv_array_push(&cp.args, "clone");
 	argv_array_push(&cp.args, "--no-checkout");
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 5a41788..6dcf7bd 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -194,7 +194,7 @@ static int add_worktree(const char *path, const char *refname,
 	struct strbuf sb = STRBUF_INIT;
 	const char *name;
 	struct stat st;
-	struct child_process cp;
+	struct child_process cp = CHILD_PROCESS_INIT;
 	struct argv_array child_env = ARGV_ARRAY_INIT;
 	int counter = 0, len, ret;
 	struct strbuf symref = STRBUF_INIT;
@@ -273,7 +273,6 @@ static int add_worktree(const char *path, const char *refname,
 
 	argv_array_pushf(&child_env, "%s=%s", GIT_DIR_ENVIRONMENT, sb_git.buf);
 	argv_array_pushf(&child_env, "%s=%s", GIT_WORK_TREE_ENVIRONMENT, path);
-	memset(&cp, 0, sizeof(cp));
 	cp.git_cmd = 1;
 
 	if (commit)
@@ -365,8 +364,7 @@ static int add(int ac, const char **av, const char *prefix)
 	}
 
 	if (opts.new_branch) {
-		struct child_process cp;
-		memset(&cp, 0, sizeof(cp));
+		struct child_process cp = CHILD_PROCESS_INIT;
 		cp.git_cmd = 1;
 		argv_array_push(&cp.args, "branch");
 		if (opts.force_new_branch)
-- 
2.9.2

