Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A29A31F859
	for <e@80x24.org>; Sat,  6 Aug 2016 20:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbcHFUU7 (ORCPT <rfc822;e@80x24.org>);
	Sat, 6 Aug 2016 16:20:59 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33762 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbcHFUU6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Aug 2016 16:20:58 -0400
Received: by mail-pa0-f50.google.com with SMTP id ti13so23898843pac.0
        for <git@vger.kernel.org>; Sat, 06 Aug 2016 13:20:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V8KDlbdRAhjKqKEJuneThbSOhjPepL++bQLO5EM2J3Y=;
        b=WrEGu8C8qbEBMrU7qOQwzeBkqADQ28+el+DcjdUDF8ifSwIF0e6jN91Whi2c+ineNx
         IRVEL+8Nd9KW1Ohi6uKgS1r9wcoaNDo19R1B5glcek+4P4Vrq8F1jt8RcItyfk1NOBIa
         aM6zHYj5Hcr0z3hmcP0bxvU1zuChC0shnPVqSkMmzGSqV9EUKq6VU2VrGZ5XwlxvfyX4
         FXa3z6I3USe/Uw9HNHqfCUR5SiZEoGqktrKX/zJzxsClpnFqjDi9IfP5hjQJM5Cbxmbd
         8RkMQ/lwGoV2ZdR5jjUs5EzQ6hUL5GNQBDo6MiHo64fVGTTlD3FCbtKi/vgbhjR/PV09
         awYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V8KDlbdRAhjKqKEJuneThbSOhjPepL++bQLO5EM2J3Y=;
        b=dRUAUr/9Lo3F2qbdIlcHxoAoTFKnZ69Mr20qcu9ILQUTiZjII2GI5HprPVis51u4kc
         u69O7iFbo2SxYVsS0kCVZ3Jo4Rlolm4bq8a/OYh4R/aSlbP6+TRD+L6xLyDejQdGk13r
         8BB7AsKoxkkSz+dxyoufJZZG9AHjZKb2MTT0LMT1sFsbW/6N9jviu4CbTMZ9KT2ik1WI
         fPugiw9nlsaW/lT0hA/MmyBQ4IqTauO7iYwJcj5ftX3KuG7Bmitx0HrbxB1aZHcJq4Hy
         GtqDKqGu4AbDofliYH9WwryqXDcIDdfpG9Z2gmv8mvni+srvkjn2GeP/auG/vJWmGmtE
         1Ecw==
X-Gm-Message-State: AEkoouu52tuh9S3DNL6p9c8O16yvAMLcxbQlpZbtV6c2fkxvjW+EGt2NPgTpSPVSJblh9YZw
X-Received: by 10.66.21.167 with SMTP id w7mr140615132pae.62.1470446617666;
        Fri, 05 Aug 2016 18:23:37 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c0da:b815:bea9:a8ab])
        by smtp.gmail.com with ESMTPSA id b68sm30628585pfg.85.2016.08.05.18.23.36
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 05 Aug 2016 18:23:37 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com, Jens.Lehmann@web.de
Cc:	git@vger.kernel.org, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 3/6] submodule--helper module-clone: allow multiple references
Date:	Fri,  5 Aug 2016 18:23:15 -0700
Message-Id: <20160806012318.17968-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.572.g9d9644e.dirty
In-Reply-To: <20160806012318.17968-1-sbeller@google.com>
References: <20160806012318.17968-1-sbeller@google.com>
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
index 6f6d67a..f2b19ea 100644
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

