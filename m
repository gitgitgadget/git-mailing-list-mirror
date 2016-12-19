Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A8741FF40
	for <e@80x24.org>; Mon, 19 Dec 2016 23:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbcLSX3o (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 18:29:44 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:34721 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933089AbcLSX2w (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 18:28:52 -0500
Received: by mail-io0-f174.google.com with SMTP id p42so166235752ioo.1
        for <git@vger.kernel.org>; Mon, 19 Dec 2016 15:28:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=e/ySHIr8fRmQ7g0Wix1U1PcgWPd6U9bxWlH6vujH7Xc=;
        b=dukaI6YxVdaUtIHAa+O7Lj6SwMbgAMVjkIIQM+WGPDc1FqWcZhKojNbazQF15prRur
         7nx9jRBWoTo1Z1jpn7CyZfXfIBixLH5x8htEMzJ0ycyhC3sX8y9TbMAZGqvNUPtNnCPf
         +d9+NKl0sPnYrkykuOxtUiHJDibZnHOHx5BETDk8HuDcOb/OQABUXucEapxxAy0+Fmsg
         oLsC64jlpqmhSCY10CUGNXku2g5rOAe6+VGXZjUPhCNT9GmDUo3DOwilX15dAvxGWMJ7
         1EUySsYp8yaIEQ6uQnAm+4ZLtqCvP+c0/cLDRq6MvASj/iGPHLLfCGT876vdSa/bs86J
         qung==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=e/ySHIr8fRmQ7g0Wix1U1PcgWPd6U9bxWlH6vujH7Xc=;
        b=hSuWo5ByPMtWSSuuWp+CrHvxXIdwsC4mhZe23ngnUIZxezTRH4shESsQ64hi5fjQB8
         emP8wIuJqcJmLqgRiC3HITyB+y9zZzwul2yUqoJs0ml/S69s+uluALrNWw2EjsNP4TE2
         NJEqtCYoD1N38ny/lPmEA6rGM7e6zgRtnUZXK8b4UidLijlF3EvHucp+jU6VkelA2gED
         ZMGuIzea5eQFFFwAa3WHxq5tD/6JLGbWUZsrkuqjsdOJwKL2MJFa62BlR4vcePfoesvL
         jRQXBc2BUD9bPV/jGPLUTk6qz8Sy8QxQIGfrCdvhYt88CTeI2LvxXHDTrDMRolWwVYO/
         TCWw==
X-Gm-Message-State: AIkVDXIQxolofiGji1RpzNOoOJ2mMNdoPEsjvtsmpTPmnLJEZCNF93bURTxkELUXuUpIdoNk
X-Received: by 10.107.48.134 with SMTP id w128mr22469851iow.226.1482190129255;
        Mon, 19 Dec 2016 15:28:49 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2c2e:3e21:f7c2:2ccc])
        by smtp.gmail.com with ESMTPSA id 63sm9237311iof.42.2016.12.19.15.28.48
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Dec 2016 15:28:48 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com,
        sandals@crustytoothpaste.net, David.Turner@twosigma.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 4/5] submodule: add flags to ok_to_remove_submodule
Date:   Mon, 19 Dec 2016 15:28:27 -0800
Message-Id: <20161219232828.5075-5-sbeller@google.com>
X-Mailer: git-send-email 2.11.0.rc2.53.gb7b3fba.dirty
In-Reply-To: <20161219232828.5075-1-sbeller@google.com>
References: <20161219232828.5075-1-sbeller@google.com>
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

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/rm.c |  3 ++-
 submodule.c  | 19 +++++++++++++------
 submodule.h  |  5 ++++-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3f3e24eb36..fdd7183f61 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -187,7 +187,8 @@ static int check_local_mod(struct object_id *head, int index_only)
 		 */
 		if (ce_match_stat(ce, &st, 0) ||
 		    (S_ISGITLINK(ce->ce_mode) &&
-		     !ok_to_remove_submodule(ce->name)))
+		     !ok_to_remove_submodule(ce->name,
+				SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED)))
 			local_changes = 1;
 
 		/*
diff --git a/submodule.c b/submodule.c
index 9f0b544ebe..9aecb8930c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1019,7 +1019,7 @@ int submodule_uses_gitfile(const char *path)
 	return 1;
 }
 
-int ok_to_remove_submodule(const char *path)
+int ok_to_remove_submodule(const char *path, unsigned flags)
 {
 	ssize_t len;
 	struct child_process cp = CHILD_PROCESS_INIT;
@@ -1032,23 +1032,30 @@ int ok_to_remove_submodule(const char *path)
 	if (!submodule_uses_gitfile(path))
 		return 0;
 
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
+	start_command_or_die(&cp);
 
 	len = strbuf_read(&buf, cp.out, 1024);
 	if (len > 2)
 		ok_to_remove = 0;
 	close(cp.out);
 
-	if (finish_command(&cp))
-		die(_("'git status --porcelain -u --ignore-submodules=none' failed in submodule %s"), path);
+	finish_command_or_die(&cp);
 
 	strbuf_release(&buf);
 	return ok_to_remove;
diff --git a/submodule.h b/submodule.h
index 61fb610749..3ed3aa479a 100644
--- a/submodule.h
+++ b/submodule.h
@@ -59,7 +59,10 @@ extern int fetch_populated_submodules(const struct argv_array *options,
 			       int quiet, int max_parallel_jobs);
 extern unsigned is_submodule_modified(const char *path, int ignore_untracked);
 extern int submodule_uses_gitfile(const char *path);
-extern int ok_to_remove_submodule(const char *path);
+
+#define SUBMODULE_REMOVAL_IGNORE_UNTRACKED (1<<0)
+#define SUBMODULE_REMOVAL_IGNORE_IGNORED_UNTRACKED (1<<1)
+extern int ok_to_remove_submodule(const char *path, unsigned flags);
 extern int merge_submodule(unsigned char result[20], const char *path,
 			   const unsigned char base[20],
 			   const unsigned char a[20],
-- 
2.11.0.rc2.53.gb7b3fba.dirty

