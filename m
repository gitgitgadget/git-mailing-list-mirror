Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 945D32070F
	for <e@80x24.org>; Fri, 16 Sep 2016 00:12:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756976AbcIPAM3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Sep 2016 20:12:29 -0400
Received: from mail-qt0-f195.google.com ([209.85.216.195]:33950 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752117AbcIPAM0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Sep 2016 20:12:26 -0400
Received: by mail-qt0-f195.google.com with SMTP id e5so2169643qtb.1
        for <git@vger.kernel.org>; Thu, 15 Sep 2016 17:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=7CgPX8VxoBuTLYpWgT23RCUxwi3fDufGVKLiVgXuAWE=;
        b=knzw32qt/uyZ5O4IP+H5IxRTG1zWKgLRKz/f0Vm/NYCCDTAd2SAxFxqy8pGfXkevW+
         uIKih/ngVAcM/bHlHvQqcYD6AViLH/GX4EbyzMZvdBj6EOj/hvzhum6P0nPQkq6HfLKK
         8vIcDyN+niPKkKOc7OnbCNvWvxfyRd09uzwUPpC8ps2ltZxB1DHpN4Ko0u+t5+qkTs6O
         F6pSg8z/4KIBqwxZe5XyyegKE+jL86X/wzqNpo2vpWGPk4rm/qSqiQ3BX2DahebZNmgB
         nTYgaCqs4fsZgv+GLK7HdksQLd4tXD6tqRjqPXyZ5a72rmycRWUgfoLEEQ0mxcwW9eb2
         0BcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=7CgPX8VxoBuTLYpWgT23RCUxwi3fDufGVKLiVgXuAWE=;
        b=I0V8C6uPj62PbLEvAxkmy8/IcZQldhSIyGq1UkSiaMFjCg2J0iXUqQ2/JTEDAnG4Ak
         kiCt/n9o5YUDZ5NFI8f/UF5dgDG7lVDOmGPT+Ud8WTE1rYk3GxRO2PsbwJgihV8RBkuN
         8efJN483Zah0uh5OUwo/vOBDcYr6dMxwc5jxerbkuivzU57H6ecLXBnlJKl1PKC55Nkl
         rly//mpLNSby7ealbXZK/RgpOz+vdVcH4Y9U7nGDwFmnj0Lxq2NBuQBUpE6i8VZvQrMi
         0gtq6wjNrAxahPUPiyt2upjTOpSJKHMxRD9jMPpiWeV65lw6dGRjRJOdPGFuCW4+rlvd
         zR2w==
X-Gm-Message-State: AE9vXwMZwx5msSl8kUJlXPADA+pxqlJLaHhFDYksZtCeLTAR9Xf+DfpeumXdSiQ/YyE1Fg==
X-Received: by 10.237.57.162 with SMTP id m31mr3911990qte.158.1473984745167;
        Thu, 15 Sep 2016 17:12:25 -0700 (PDT)
Received: from localhost.localdomain (ool-457850cc.dyn.optonline.net. [69.120.80.204])
        by smtp.gmail.com with ESMTPSA id d27sm3227196qtd.37.2016.09.15.17.12.24
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Sep 2016 17:12:24 -0700 (PDT)
From:   Kevin Wern <kevin.m.wern@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 01/11] Resumable clone: create service git-prime-clone
Date:   Thu, 15 Sep 2016 20:12:12 -0400
Message-Id: <1473984742-12516-2-git-send-email-kevin.m.wern@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
References: <1473984742-12516-1-git-send-email-kevin.m.wern@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create git-prime-clone, a program to be executed on the server that
returns the location and type of static resource to download before
performing the rest of a clone.

Additionally, as this executable's location will be configurable (see:
upload-pack and receive-pack), add the program to
BINDIR_PROGRAMS_NEED_X, in addition to the usual builtin places. Add
git-prime-clone executable to gitignore, as well

Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
---
 .gitignore                        |  1 +
 Documentation/git-prime-clone.txt | 39 ++++++++++++++++++++
 Makefile                          |  2 +
 builtin.h                         |  1 +
 builtin/prime-clone.c             | 77 +++++++++++++++++++++++++++++++++++++++
 git.c                             |  1 +
 6 files changed, 121 insertions(+)
 create mode 100644 Documentation/git-prime-clone.txt
 create mode 100644 builtin/prime-clone.c

diff --git a/.gitignore b/.gitignore
index 5087ce1..bfea25c 100644
--- a/.gitignore
+++ b/.gitignore
@@ -106,6 +106,7 @@
 /git-pack-refs
 /git-parse-remote
 /git-patch-id
+/git-prime-clone
 /git-prune
 /git-prune-packed
 /git-pull
diff --git a/Documentation/git-prime-clone.txt b/Documentation/git-prime-clone.txt
new file mode 100644
index 0000000..fc5917d
--- /dev/null
+++ b/Documentation/git-prime-clone.txt
@@ -0,0 +1,39 @@
+git-prime-clone(1)
+============
+
+NAME
+----
+git-prime-clone - Get the location of an alternate resource
+to fetch before clone
+
+
+SYNOPSIS
+--------
+[verse]
+'git prime-clone' [--strict] <dir>
+
+DESCRIPTION
+-----------
+
+Outputs the resource, if configured to do so. Otherwise, returns
+nothing (packet flush 0000).
+
+CONFIGURE
+---------
+
+primeclone.url::
+	The full url of the resource (e.g.
+	http://examplehost/pack-$NAME.pack).
+
+primeclone.filetype::
+	The type of the resource (e.g. pack).
+
+primeclone.enabled::
+	When 'false', git-prime-clone will return an empty response,
+	regardless of what the rest of the configuration specifies;
+	otherwise, it will return the configured response. Is 'true'
+	by default.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 24bef8d..f2564ec 100644
--- a/Makefile
+++ b/Makefile
@@ -648,6 +648,7 @@ OTHER_PROGRAMS = git$X
 # what test wrappers are needed and 'install' will install, in bindir
 BINDIR_PROGRAMS_NEED_X += git
 BINDIR_PROGRAMS_NEED_X += git-upload-pack
+BINDIR_PROGRAMS_NEED_X += git-prime-clone
 BINDIR_PROGRAMS_NEED_X += git-receive-pack
 BINDIR_PROGRAMS_NEED_X += git-upload-archive
 BINDIR_PROGRAMS_NEED_X += git-shell
@@ -904,6 +905,7 @@ BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
+BUILTIN_OBJS += builtin/prime-clone.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/pull.o
diff --git a/builtin.h b/builtin.h
index 6b95006..c9e2254 100644
--- a/builtin.h
+++ b/builtin.h
@@ -97,6 +97,7 @@ extern int cmd_notes(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
+extern int cmd_prime_clone(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_pull(int argc, const char **argv, const char *prefix);
diff --git a/builtin/prime-clone.c b/builtin/prime-clone.c
new file mode 100644
index 0000000..ce914d3
--- /dev/null
+++ b/builtin/prime-clone.c
@@ -0,0 +1,77 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "pkt-line.h"
+
+static char const * const prime_clone_usage[] = {
+	N_("git prime-clone [--strict] <dir>"),
+	NULL
+};
+
+static unsigned int enabled = 1;
+static const char *url = NULL, *filetype = NULL;
+static int strict;
+
+static struct option prime_clone_options[] = {
+	OPT_BOOL(0, "strict", &strict, N_("Do not attempt <dir>/.git if <dir> "
+					  "is not a git directory")),
+	OPT_END(),
+};
+
+static void prime_clone(void)
+{
+	if (!enabled) {
+		fprintf(stderr, _("prime-clone not enabled\n"));
+	}
+	else if (url && filetype){
+		packet_write(1, "%s %s\n", filetype, url);
+	}
+	else if (url || filetype) {
+		if (filetype)
+			fprintf(stderr, _("prime-clone not properly "
+					  "configured: missing url\n"));
+		else if (url)
+			fprintf(stderr, _("prime-clone not properly "
+					  "configured: missing filetype\n"));
+	}
+	packet_flush(1);
+}
+
+static int prime_clone_config(const char *var, const char *value, void *unused)
+{
+	if (!strcmp("primeclone.url",var)) {
+		return git_config_pathname(&url, var, value);
+	}
+	if (!strcmp("primeclone.enabled",var)) {
+		enabled = git_config_bool(var, value);
+		return 0;
+	}
+	if (!strcmp("primeclone.filetype",var)) {
+		return git_config_string(&filetype, var, value);
+	}
+	return git_default_config(var, value, unused);
+}
+
+int cmd_prime_clone(int argc, const char **argv, const char *prefix)
+{
+	const char *dir;
+	argc = parse_options(argc, argv, prefix, prime_clone_options,
+			     prime_clone_usage, 0);
+	if (argc == 0) {
+		usage_msg_opt(_("No repository specified."), prime_clone_usage,
+			      prime_clone_options);
+	}
+	else if (argc > 1) {
+		usage_msg_opt(_("Too many arguments."), prime_clone_usage,
+			      prime_clone_options);
+	}
+
+	dir = argv[0];
+
+	if (!enter_repo(dir, 0)){
+		die(_("'%s' does not appear to be a git repository"), dir);
+	}
+
+	git_config(prime_clone_config, NULL);
+	prime_clone();
+	return 0;
+}
diff --git a/git.c b/git.c
index 6cc0c07..a5681fb 100644
--- a/git.c
+++ b/git.c
@@ -447,6 +447,7 @@ static struct cmd_struct commands[] = {
 	{ "pack-refs", cmd_pack_refs, RUN_SETUP },
 	{ "patch-id", cmd_patch_id },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
+	{ "prime-clone", cmd_prime_clone },
 	{ "prune", cmd_prune, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "pull", cmd_pull, RUN_SETUP | NEED_WORK_TREE },
-- 
2.7.4

