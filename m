Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDD71FF76
	for <e@80x24.org>; Tue, 20 Dec 2016 23:20:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935542AbcLTXU3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Dec 2016 18:20:29 -0500
Received: from mail-pg0-f44.google.com ([74.125.83.44]:34158 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933142AbcLTXUW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Dec 2016 18:20:22 -0500
Received: by mail-pg0-f44.google.com with SMTP id y62so25700023pgy.1
        for <git@vger.kernel.org>; Tue, 20 Dec 2016 15:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/XvVBiyg8MCqx6CZFFWMvKS4HRY+IIVXNs2psNbM5TE=;
        b=RMMtYU+MJBFR4UrNXfqCJCIjGq2nxlcQoQOhQGBw9iDVL2o2p0ByThjIXs3C3Cw5OF
         /qiiHW5362xeoc0cW9DK/rX9uANTY+1JQx/U06OMcvZ+vPaq+mnW1eM0uHskH2Y72T88
         DA79e7iiMd8JBRSi4FaJn7+ykSpE2lMxtmR16OSJdTwkyo7SiC+zfj/cOeYEfepempX6
         PxRmD8cFxW2d0ZceOl7WDvRl4duwhNFsSYY3Vs1r8puH/MN4sftwDdatMk5K0FxGq9L8
         aY6GJ7CjJoNe6ccDALKkrflnadOfFW30A2W52tydjNua9y4DVKSSZid8FhvaV/NatGPR
         3EYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/XvVBiyg8MCqx6CZFFWMvKS4HRY+IIVXNs2psNbM5TE=;
        b=KQF+QnJ/q9bb41f5Ix4pgm36Xcpp4LBrTaquC29qj30EC4mq4oTJWFFPz6Rsf8fRgx
         4ZgjECnWp1vIem2wCqDEFGc1GRLWFnZ+Cde9oc6UHedcuPCsdDrm5nTmImOvr26liimp
         quE2tCIqu6smNFeuCuoEop6JMqdQWFyNIl24GHQUikpJLEjL7ihLrsTAVApImYrqRPic
         UDHwO7R+EGorVjpILYSod3wuCql2Y3RvRXrV6kQwZ6M+irRBSCZauun3535c993CZ001
         hsZpNRCyPadS+r6gtx+Liwz5db/RcqZ6t1lhv4pInhut9D689enNFEj9Zx94tJ7dcDO3
         3gzg==
X-Gm-Message-State: AIkVDXL104MAtQTffEXIc/b20w5J/TEactw9SSvlheSMnI4bCCdRt7N99+66+w7k0Iy3LRbU
X-Received: by 10.84.202.163 with SMTP id x32mr3113983pld.46.1482276021505;
        Tue, 20 Dec 2016 15:20:21 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:6c5b:c771:3806:a807])
        by smtp.gmail.com with ESMTPSA id a22sm41527525pfg.7.2016.12.20.15.20.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 20 Dec 2016 15:20:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, David.Turner@twosigma.com,
        sandals@crustytoothpaste.net, j6t@kdbg.org,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/4] submodule: rename and add flags to ok_to_remove_submodule
Date:   Tue, 20 Dec 2016 15:20:11 -0800
Message-Id: <20161220232012.15997-4-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161220232012.15997-1-sbeller@google.com>
References: <20161220232012.15997-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In different contexts the question "Is it ok to delete a submodule?"
may be answered differently.

In 293ab15eea (submodule: teach rm to remove submodules unless they
contain a git directory, 2012-09-26) a case was made that we can safely
ignore ignored untracked files for removal as we explicitely ask for the
removal of the submodule.

In a later patch we want to remove submodules even when the user doesn't
explicitly ask for it (e.g. checking out a tree-ish in which the submodule
doesn't exist).  In that case we want to be more careful when it comes
to deletion of untracked files. As of this patch it is unclear how this
will be implemented exactly, so we'll offer flags in which the caller
can specify how the different untracked files ought to be handled.

As the flags allow the function to not die on an error when spawning
a child process, we need to find an appropriate return code for the
case when the child process could not be started. As in that case we
cannot tell if the submodule is ok to remove, we'd want to return 'false'.

As only 0 is understood as false, rename the function to invert the
meaning, i.e. the return code of 0 signals the removal of the submodule
is fine, and other values can be used to return a more precise answer
what went wrong.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c |  4 +++-
 submodule.c  | 49 +++++++++++++++++++++++++++++++++++++------------
 submodule.h  |  6 +++++-
 3 files changed, 45 insertions(+), 14 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3f3e24eb36..5a5a66272b 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -187,7 +187,9 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 */
 		if (ce_match_stat(ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
-		     !ok_to_remove_submodule(ce->name)))
+		     bad_to_remove_submodule(ce->name,
+				SUBMODULE_REMOVAL_DIE_ON_ERROR |
+				SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)))
 			local_changes = 1;
 
 		/*
diff --git a/submodule.c b/submodule.c
index 9f0b544ebe..1cc04d24e5 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1019,39 +1019,64 @@ int submodule_uses_gitfile(const char *path)
 	return 1;
 }
 
-int ok_to_remove_submodule(const char *path)
+/*
+ * Check if it is a bad idea to remove a submodule, i.e. if we'd lose data
+ * when doing so.
+ *
+ * Return 1 if we'd lose data, return 0 if the removal is fine,
+ * and negative values for errors.
+ */
+int bad_to_remove_submodule(const char *path, unsigned flags)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf buf = STRBUF_INIT;
-	int ok_to_remove = 1;
+	int ret = 0;
 
 	if (!file_exists(path) || is_empty_dir(path))
-		return 1;
+		return 0;
 
 	if (!submodule_uses_gitfile(path))
-		return 0;
+		return 1;
 
-	argv_array_pushl(&cp.args, "status", "--porcelain", "-u",
+	argv_array_pushl(&cp.args, "status", "--porcelain",
 				   "--ignore-submodules=none", NULL);
+
+	if (flags & SUBMODULE_REMOVAL_IGNORE_UNTRACKED)
+		argv_array_push(&cp.args, "-uno");
+	else
+		argv_array_push(&cp.args, "-uall");
+
+	if (!(flags & SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED))
+		argv_array_push(&cp.args, "--ignored");
+
 	prepare_submodule_repo_env(&cp.env_array);
 	cp.git_cmd = 1;
 	cp.no_stdin = 1;
 	cp.out = -1;
 	cp.dir = path;
-	if (start_command(&cp))
-		die(_("could not run 'git status --porcelain -u --ignore-submodules=none' in submodule %s"), path);
+	if (start_command(&cp)) {
+		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
+			die(_("could not start 'git status in submodule '%s'"),
+				path);
+		ret = -1;
+		goto out;
+	}
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
-		ok_to_remove = 0;
+		ret = 1;
 	close(cp.out);
 
-	if (finish_command(&cp))
-		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
-
+	if (finish_command(&cp)) {
+		if (flags & SUBMODULE_REMOVAL_DIE_ON_ERROR)
+			die(_("could not run 'git status in submodule '%s'"),
+				path);
+		ret = -1;
+	}
+out:
 	strbuf_release(&buf);
-	return ok_to_remove;
+	return ret;
 }
 
 static int find_first_merges(struct object_array *result, const char *path,
diff --git a/submodule.h b/submodule.h
index 61fb610749..21b1569413 100644
--- a/submodule.h
+++ b/submodule.h
@@ -59,7 +59,11 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
-extern int ok_to_remove_submodule(const char *path);
+
+#define SUBMODULE_REMOVAL_DIE_ON_ERROR (1<<0)
+#define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<1)
+#define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<2)
+extern int bad_to_remove_submodule(const char *path, unsigned flags);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.11.0.rc2.53.gb7b3fba.dirty

