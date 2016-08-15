Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 367CF1F859
	for <e@80x24.org>; Mon, 15 Aug 2016 21:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753130AbcHOVxy (ORCPT <rfc822;e@80x24.org>);
	Mon, 15 Aug 2016 17:53:54 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36744 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753103AbcHOVxu (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Aug 2016 17:53:50 -0400
Received: by mail-pa0-f45.google.com with SMTP id pp5so19416078pac.3
        for <git@vger.kernel.org>; Mon, 15 Aug 2016 14:53:45 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SH/F2LmheTA3emiHB0gHoZs+k3IJw4N5vp/hQzJU1zw=;
        b=QH+yWuO9AvQlRHJ6NTBQtH6luawJVh4SmD18MWcA3l0eUpyz2m/biH9GAjM0HTkeHi
         FE+/EbcpGmF4QCz9l/6LyA82yKZzRt2bdqa/nae4ts0AOUlFfu/41snUGZnsD/pKv73N
         9njyQjVV3hBuwdIr38K0v2EBxBtuXzCIxcf4hw7axjr0RJRaOjdDDF0XN+EVeVQTD1un
         hoU4/VT+/kAv90DlvGYYJffDPSOsvvylkWjnRFKwgMTp2BheIS1rfSbHM7EPkvOB/ORU
         rBBCn32Aj1k7lpRsjpXIybaf0BhKuee6sjtL+dNqmEIP93zERfDK5GGizcgXlR36WXm3
         nHEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SH/F2LmheTA3emiHB0gHoZs+k3IJw4N5vp/hQzJU1zw=;
        b=l5x/xx/oh402hvxO6rRlKkgePUm9sVxalzZocTAAGsLg96bXIGk/bhe9lnQ06kLleJ
         Ndye0rEWDbmXvQtI8QjQv4STe1XPoEJHnkvbdpWPPfIFK8p3ZfGh9jPpMdcgAP6wa0N7
         2WY4JFmfhCDvZ2+dNourbUKdpIH2Z4o8t3l/gPXRTdwHdvU0uhFB5/RF8KRF+Gk1Bamc
         8iqGaztgU4SYivChO1aiwA4ulyEV3iYaZW/lNAyf+AxPEyxRxH7n5nm0qlAW7vrERh9g
         Nf9IJ89HDbd79qwobsx9FyyzxIpblaGK3wONl5/tZNJCTyR4WzC+3AhVaOfexEuTUvCR
         YM8A==
X-Gm-Message-State: AEkoout+eCMqYwqUITI5iYt14LKImB7Pe/wzoo+a3sLx8fi2GSK4NGdtVp46rxVJI8w2kjyI
X-Received: by 10.66.159.170 with SMTP id xd10mr58475033pab.41.1471298024938;
        Mon, 15 Aug 2016 14:53:44 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:fd0c:5bce:d30d:9f4d])
        by smtp.gmail.com with ESMTPSA id tm1sm33775981pac.23.2016.08.15.14.53.43
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 15 Aug 2016 14:53:43 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, jrnieder@gmail.com, Jens.Lehmann@web.de,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv5 3/8] submodule--helper module-clone: allow multiple references
Date:	Mon, 15 Aug 2016 14:53:22 -0700
Message-Id: <20160815215327.15682-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.730.g525ad04.dirty
In-Reply-To: <20160815215327.15682-1-sbeller@google.com>
References: <20160815215327.15682-1-sbeller@google.com>
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
index 6f6d67a..ce9b3e9 100644
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
2.9.2.730.g525ad04.dirty

