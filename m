Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE7C4203BD
	for <e@80x24.org>; Thu, 11 Aug 2016 23:14:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbcHKXOT (ORCPT <rfc822;e@80x24.org>);
	Thu, 11 Aug 2016 19:14:19 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34631 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676AbcHKXOR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2016 19:14:17 -0400
Received: by mail-pa0-f42.google.com with SMTP id fi15so2739526pac.1
        for <git@vger.kernel.org>; Thu, 11 Aug 2016 16:14:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=q7AHhnfEU3NXC16TBXE4RaiX84FL6XwAvcYsT9vTSjY=;
        b=jrf6pgjZYGDFsbUnyrEo8uX0wgQEIxmFCP4EzafEhAE2sVxHOEdHVcbJzwEhHVG55F
         YNN/jQl9D3mua4I5CFh1t8K7z6MiOZUizalo+KoIYFaxwNvBdIGj+YD9hkiOOmLtXTqd
         KOd/0Hj6Bpsst9/kKkB93t1RD7jDO5avprc2K+pp1WTbMHJSI4jLhQA7o9sEH6vOBm10
         4n+WSa8P6HNN0rUcuzO1fB9j6jGkwx7KmvCNeT0kg9phEU4qwNx9bd7ElVR5u7juLd4C
         dz6QOtKOrBHhL9APNyYlo1gZWr6CenECDVJeR8TE6BpKuqbW+DvSrsrc0WgQ1c76mLZD
         2fNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=q7AHhnfEU3NXC16TBXE4RaiX84FL6XwAvcYsT9vTSjY=;
        b=MdkzJZposW7NGgq61ENrAU4WHER316qH6V0CL97w3W3QmMEGOV6hm4lHqPamKy4KA/
         5OglsNPvXV5imG5cXGuEojn5leM0iUUt3E/RCNyrWEyla4jbUIS0tTZyUOQb8LlDlK8d
         XNqCahJOz/gTrdSVpYsICTJmRWgRT8oqmmVqQrcj0z9GpLhvReEkw+Oo+Nm35tujWxKe
         gllLZGLUpBZ2QMZCsqUvw+hGQYFCjwLiOir+phnlDbnh/t2FS1Srt7dIeRe9gydHzat5
         rXomfwFMp+j7PaCwJIipdTxWiGRQqsPp1tIVyuvTXheUJDEfBEk87AHFiXXR4UAznuHZ
         /6Ww==
X-Gm-Message-State: AEkoousgdqR9yAMvc7z48tL3XfJTORJUWIe1jVTyOYvOYHJswhxl1/79ri/cJS9SFKCyRU9P
X-Received: by 10.66.136.49 with SMTP id px17mr21500349pab.122.1470957256118;
        Thu, 11 Aug 2016 16:14:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:2879:1504:a6e4:e441])
        by smtp.gmail.com with ESMTPSA id n10sm7735291pap.16.2016.08.11.16.14.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 16:14:15 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 3/8] submodule--helper module-clone: allow multiple references
Date:	Thu, 11 Aug 2016 16:14:00 -0700
Message-Id: <20160811231405.17318-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.737.g4a14654
In-Reply-To: <20160811231405.17318-1-sbeller@google.com>
References: <20160811231405.17318-1-sbeller@google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Allow users to pass in multiple references, just as clone accepts multiple
references as well.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/submodule--helper.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b09632e..db9270e 100644
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
@@ -453,8 +453,12 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 		argv_array_push(&cp.args, "--quiet");
 	if (depth && *depth)
 		argv_array_pushl(&cp.args, "--depth", depth, NULL);
-	if (reference && *reference)
-		argv_array_pushl(&cp.args, "--reference", reference, NULL);
+	if (reference->nr) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, reference)
+			argv_array_pushl(&cp.args, "--reference",
+					 item->string, NULL);
+	}
 	if (gitdir && *gitdir)
 		argv_array_pushl(&cp.args, "--separate-git-dir", gitdir, NULL);
 
@@ -470,13 +474,13 @@ static int clone_submodule(const char *path, const char *gitdir, const char *url
 
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
@@ -491,8 +495,8 @@ static int module_clone(int argc, const char **argv, const char *prefix)
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
@@ -528,7 +532,7 @@ static int module_clone(int argc, const char **argv, const char *prefix)
 	if (!file_exists(sm_gitdir)) {
 		if (safe_create_leading_directories_const(sm_gitdir) < 0)
 			die(_("could not create directory '%s'"), sm_gitdir);
-		if (clone_submodule(path, sm_gitdir, url, depth, reference, quiet))
+		if (clone_submodule(path, sm_gitdir, url, depth, &reference, quiet))
 			die(_("clone of '%s' into submodule path '%s' failed"),
 			    url, path);
 	} else {
-- 
2.9.2.737.g4a14654

