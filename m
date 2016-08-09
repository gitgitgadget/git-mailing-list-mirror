Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00F222018E
	for <e@80x24.org>; Tue,  9 Aug 2016 04:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbcHIEIX (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 00:08:23 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:34861 "EHLO
	mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789AbcHIEIW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 00:08:22 -0400
Received: by mail-pf0-f176.google.com with SMTP id x72so672998pfd.2
        for <git@vger.kernel.org>; Mon, 08 Aug 2016 21:08:22 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=dV1MZ504J+BYwTl5V1tBByGcGauG+h2ttq+QrEjD3eY=;
        b=HcNy8iaOzx4XB1tt3PdfhTliG3DAKmfUtLO64EnymQvX5Kcksqjy92zb7z8vdegPhB
         oFfnVEdJdmQshDEf3Zh26VZ3YdbTQlFDt5Ve2jmu8bRr51RnDwON4q+xCAICvut3Mt/q
         wRFIe08eXlpH+GnWYKAYPDbTBzYYvU/dLMLjjOpmbTmDndPGP4gPXDE5ClrHYQTqx6EC
         4REGayDj6cs89tHhkA35w/PFLFyo05Gs5kFlq6mqX0R5ty2tsmQu5kPn3gVG55rqkWW4
         2smNIeW+e09SL+c7yxXPIMEPsfmtCKcVhhfzl5whaMdu4J0uemsFQ4BEt0JAeaNVzxwI
         Rw8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=dV1MZ504J+BYwTl5V1tBByGcGauG+h2ttq+QrEjD3eY=;
        b=f8uwyv3QI1UFwu/V56XDxP+DNXGkgfkQcrq6WBuzhppAsMAJKWmIGvGuQH6qmQvqbp
         1Ol9DAF9sQ2QDKuEI+xuFtgopyNheX3iQzf3PV+idwyFKSfES6wXEdmTKmzpFNKx7tPc
         D2UvB/iraO43ajDN2fEYJq16HGWH0mzMxUDHQoyBlt+XRif5Q0E4DTOIo0k8l7f5Gnnh
         /Z4S1nbbcIoGDx2rho0WLCoUYujwkq+sNzecpU8X53FPcNIdvrPpIavTSzz9NePSx7Er
         Q/j8izc6QIAe2Te9EHo36klICpMVwgIqeNrQroBp3Dl5GXFXnJaa1j/ioqi06xemDFZF
         UARw==
X-Gm-Message-State: AEkoouvrXfeteulxBH47fCHL8eQaw3HF/hA37izBMfqMfrIzgnTRpet4lJm6Yd/IqaUOTeFl
X-Received: by 10.98.87.138 with SMTP id i10mr168525297pfj.16.1470715701571;
        Mon, 08 Aug 2016 21:08:21 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ad25:78d3:1e25:67ef])
        by smtp.gmail.com with ESMTPSA id g27sm51504097pfd.47.2016.08.08.21.08.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 08 Aug 2016 21:08:20 -0700 (PDT)
From:	Stefan Beller <sbeller@google.com>
To:	gitster@pobox.com
Cc:	git@vger.kernel.org, Jens.Lehmann@web.de, mst@redhat.com,
	Stefan Beller <sbeller@google.com>
Subject: [PATCHv3 3/9] submodule--helper module-clone: allow multiple references
Date:	Mon,  8 Aug 2016 21:08:03 -0700
Message-Id: <20160809040811.21408-4-sbeller@google.com>
X-Mailer: git-send-email 2.9.2.583.gd6329be.dirty
In-Reply-To: <20160809040811.21408-1-sbeller@google.com>
References: <20160809040811.21408-1-sbeller@google.com>
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
2.9.2.583.gd6329be.dirty

