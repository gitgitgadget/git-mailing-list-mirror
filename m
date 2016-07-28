Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B17A21F955
	for <e@80x24.org>; Thu, 28 Jul 2016 16:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759077AbcG1QDV (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:03:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35970 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759053AbcG1QDN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:03:13 -0400
Received: by mail-wm0-f67.google.com with SMTP id x83so11814099wma.3
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:03:12 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PHIY0YebH28bQ/fYd8ZxyFG97GlPDkzlJYl4O64Znbk=;
        b=VN3H9WhF4lOKobzwDNFuIlFlan5ICxNjebPvIfPr9Kvq+MrpN3EmPuXxun4TnfCXzO
         oUWiyAA11vRcyLrqOA/lu/tSw5VslrNFZ+FxsKAAXSlZq1+6D7XA95QWiYlkMKDYxoEF
         HzP1G7fyUS6IoYwDpaEVht3LiGirpsByaygaCQ34Z0CdYmzAI/nDYqpDekHbazdNA0Bb
         l5GoQnH0+n8/sXzbu4By4S6dWzsgBiqpMIMP27+JVPUiy6sJuTP7QEMHYEAOQKN2tkgF
         JnAjEkaCAXSiX8s3qvjRyvbQX6q3RtwxIP98xSmdbLAvpZdZnrYT9s6LlxofD3SdiyQv
         x6sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PHIY0YebH28bQ/fYd8ZxyFG97GlPDkzlJYl4O64Znbk=;
        b=gyICjya0mtagBQ+O9AYo27su8IsIVGPJx7jY1h3eloN5inh6mIwxdbw2LAMEOvAPJr
         2KbWiMswRKgPubQx+rSVy5aUlEQUMMA95dvVrnG+33t81j57593dZe7r8H5SyH+kseo+
         i3EWzYYQjlD72LE0nF7KGdFOSjtwcs08sqYJGtTWBXV8vmQM2g8naOteOLs6hXa70+lR
         VfK2oYAQBNZhKuja9w64+TNQKqwS8U/NxmvVFWtkPE20FTSozt99WUzS5ld90bTT/YG2
         eMF9BZiE5V2xH/CIDr67qh6qlXhtbcdRoGtwlS+uUm3g7J6SwcfW576Wxw2Hu/7FWfQN
         bsVQ==
X-Gm-Message-State: AEkoouuELfsN/sp0AWAO8TjyPIlpI4H7RgLAXK/VhRneLiVDq3W/Sju/dj56DCSqUKbL2A==
X-Received: by 10.194.23.39 with SMTP id j7mr34444014wjf.4.1469721791622;
        Thu, 28 Jul 2016 09:03:11 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.03.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:03:10 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 6/7] clone: add sparse-prefix option
Date:	Thu, 28 Jul 2016 18:02:25 +0200
Message-Id: <20160728160226.24018-7-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
In-Reply-To: <20160728160226.24018-1-r.ruede@gmail.com>
References: <20160728160226.24018-1-r.ruede@gmail.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

For example

    git clone git@remote:repo --sparse-prefix=/contrib/

would create a repository, cloning only the relevant files for the
contrib subdirectory, and also setting the sparse-checkout option, so
only those files will be checked out.

Signed-off-by: Robin Ruede <r.ruede@gmail.com>
---
 builtin/clone.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 31ea247..dc0d364 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -41,7 +41,7 @@ static const char * const builtin_clone_usage[] = {
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared, option_recursive;
 static int option_shallow_submodules;
-static char *option_template, *option_depth;
+static char *option_template, *option_depth, *option_sparse_prefix;
 static char *option_origin = NULL;
 static char *option_branch = NULL;
 static const char *real_git_dir;
@@ -91,6 +91,8 @@ static struct option builtin_clone_options[] = {
 		   N_("path to git-upload-pack on the remote")),
 	OPT_STRING(0, "depth", &option_depth, N_("depth"),
 		    N_("create a shallow clone of that depth")),
+	OPT_STRING(0, "sparse-prefix", &option_sparse_prefix, N_("path-prefix"),
+	            N_("only fetch the blobs for the specified path-prefix")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
@@ -959,9 +961,22 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 	init_db(option_template, INIT_DB_QUIET);
 	write_config(&option_config);
-
+	if (option_sparse_prefix) {
+		FILE *f;
+		const char *name;
+		if (option_sparse_prefix[0] != '/')
+			die(N_("sparse prefix must start with /"));
+		name = mkpath("%s/info/sparse-checkout", git_dir);
+		git_config_set("core.sparsecheckout", "true");
+		safe_create_leading_directories_const(name);
+		f = fopen(name, "w");
+		if(f == NULL) die("Could not open %s", name);
+		fprintf(f, "%s\n", option_sparse_prefix);
+		fclose(f);
+	}
 	git_config(git_default_config, NULL);
 
+
 	if (option_bare) {
 		if (option_mirror)
 			src_ref_prefix = "refs/";
@@ -977,6 +992,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
+
 	if (option_reference.nr)
 		setup_reference();
 
@@ -995,6 +1011,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (is_local) {
 		if (option_depth)
 			warning(_("--depth is ignored in local clones; use file:// instead."));
+		if (option_sparse_prefix)
+			warning(_("--sparse-prefix is ignored in local clones; use file:// instead."));
 		if (!access(mkpath("%s/shallow", path), F_OK)) {
 			if (option_local > 0)
 				warning(_("source repository is shallow, ignoring --local"));
@@ -1013,6 +1031,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (option_depth)
 		transport_set_option(transport, TRANS_OPT_DEPTH,
 				     option_depth);
+	if (option_sparse_prefix)
+		transport_set_option(transport, TRANS_OPT_SPARSE_PREFIX,
+		                     option_sparse_prefix);
 	if (option_single_branch)
 		transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "1");
 
@@ -1020,7 +1041,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK,
 				     option_upload_pack);
 
-	if (transport->smart_options && !option_depth)
+	if (transport->smart_options && !option_depth && !option_sparse_prefix)
 		transport->smart_options->check_self_contained_and_connected = 1;
 
 	refs = transport_get_remote_refs(transport);
-- 
2.9.1.283.g3ca5b4c.dirty

