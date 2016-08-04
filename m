Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDF8520228
	for <e@80x24.org>; Thu,  4 Aug 2016 19:52:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965423AbcHDTwX (ORCPT <rfc822;e@80x24.org>);
	Thu, 4 Aug 2016 15:52:23 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33210 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758986AbcHDTwM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Aug 2016 15:52:12 -0400
Received: by mail-pf0-f171.google.com with SMTP id y134so89498560pfg.0
        for <git@vger.kernel.org>; Thu, 04 Aug 2016 12:52:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=k6wiUzt7C4swNFSWcw0DmTXjHWx+BP13PCUQkj69Im0=;
        b=Yy1N6NB/G0CCEYnRf2zLi/6yo097V++gKHfuHIaDELR230f76Dm2Av9dnlHJeIVQTF
         WFdFOR78EIL3jiKGq4QQz93lSd7ZzjeSMipCj8byXbm1ggoYaS1dXXBHYfHusGatiX1D
         91SOwM7aKngmlNt8j2EW4mcxmMrJpR0/0BXL7oW7/5poCH736HaB+fQOVvgaSgFAt9Ga
         xXi51iz99fCKUg+itxRVEM64o8/GC+xwGPRlumQQyHpQAqkTf3N7fgWOzW/XfALuBw0O
         6Gj4SSTrZ6MzLmRSIKcgxbsF0cHmbojidS+HpEYpjEF1MI6pOAE+6MqT3dEqi1K6Mve2
         1XjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=k6wiUzt7C4swNFSWcw0DmTXjHWx+BP13PCUQkj69Im0=;
        b=Pm4yjp+TdzzK3Xut2AlN431fznuxZrR6mxdub23w0lYRzLj+PcebnBIds+ysiEQs3e
         wvtAC9GYkqrxfAcAAupGYEw8Twiy7QAvfJWcc5KbJQrJXRvNFfe7tq9Nn781LAArkAlX
         eCcAz1evM4LbZZUb6BQQJ63pe+N9fU6BLpCsty550rMoiNa1f4GN6MuqmEJOHQoSX3SD
         Dm8nFrnTOSUol4sV+HjAi3WD7ho7mbY/6X8+50XV3AuCfFnWQ70R8ZvMAEHgCxnZ5dTL
         dUfL9qFpWA1gW7puNv/5xRWMjdPQBePYcsr9fUHwvtxYmYh8XglijiI333WEIPklgfok
         KcJQ==
X-Gm-Message-State: AEkoousIUy96SnMHF4+rZ065Mq/kvLW7TuVZB+0HQgdGuh3bpdFYUix1qs4OdNuch3AfVtEy
X-Received: by 10.98.68.148 with SMTP id m20mr125577701pfi.0.1470340331527;
        Thu, 04 Aug 2016 12:52:11 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:b86b:a022:8342:c00c])
        by smtp.gmail.com with ESMTPSA id h86sm22296482pfh.46.2016.08.04.12.52.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 04 Aug 2016 12:52:10 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/6] submodule--helper module-clone: allow multiple references
Date:	Thu,  4 Aug 2016 12:51:56 -0700
Message-Id: <20160804195159.7788-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160804195159.7788-1-sbeller@google.com>
References: <20160804195159.7788-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow users to pass in multiple references, just as clone accepts multiple
references as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b22352b..896a3ec 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -442,7 +442,7 @@ static int module_name(int argc, const char **argv, const char *prefix)
 }
 
 static int clone_submodule(const char *path, const char *gitdir, const char *url,
-			   const char *depth, const char *reference, int quiet)
+			   const char *depth, struct string_list *reference, int quiet)
 {
 	struct child_process cp;
 	child_process_init(&cp);
@@ -453,8 +453,11 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--quiet");
 	if (depth && *depth)
 		argv_array_pushl(&cp.args, "--depth", depth, NULL);
-	if (reference && *reference)
-		argv_array_pushl(&cp.args, "--reference", reference, NULL);
+	if (reference->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, reference)
+			argv_array_pushl(&cp.args, "--reference", item->string, NULL);
+	}
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
@@ -470,13 +473,13 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 
 static int module_clone(int argc, const char **argv, const char *prefix)
 {
-	const char *name = NULL, *url = NULL;
-	const char *reference = NULL, *depth = NULL;
+	const char *name = NULL, *url = NULL, *depth = NULL;
 	int quiet = 0;
 	FILE *submodule_dot_git;
 	char *p, *path = NULL, *sm_gitdir;
 	struct strbuf rel_path = STRBUF_INIT;
 	struct strbuf sb = STRBUF_INIT;
+	struct string_list reference = STRING_LIST_INIT_NODUP;
 
 	struct option module_clone_options[] = {
 		OPT_STRING(0, "prefix", &prefix,
@@ -491,8 +494,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "url", &url,
 			   N_("string"),
 			   N_("url where to clone the submodule from")),
-		OPT_STRING(0, "reference", &reference,
-			   N_("string"),
+		OPT_STRING_LIST(0, "reference", &reference,
+			   N_("repo"),
 			   N_("reference repository")),
 		OPT_STRING(0, "depth", &depth,
 			   N_("string"),
@@ -528,7 +531,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
-		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
-- 
2.9.2.572.g9d9644e.dirty

