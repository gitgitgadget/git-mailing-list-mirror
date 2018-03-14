Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74F1A1F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751903AbeCNSce (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:34 -0400
Received: from mail-oi0-f74.google.com ([209.85.218.74]:48291 "EHLO
        mail-oi0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752172AbeCNSc1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:27 -0400
Received: by mail-oi0-f74.google.com with SMTP id o4so2179443oib.15
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=9yt+hi0cOzkpXoovsJa0gnIESbhDewSu0PSZCY0aJr4=;
        b=n5eKm5Yv33TK6+RuculroO3D1JuPnJ8ENPH9aWn+s/G7uPuUnlZkZWYP9N8X14d7ra
         jDSZskYVJVxdUQJAJ8PdrUHtHCCIc9T41pgr939zcsAiXgseYItY1bf7/J2v3/hPOOPU
         dqcHUsaCqlx/WO5NVnH78kNamAXsDV/zTDtpKs5zSaKtqVrKsgr5HGRzJuAejhM4IcPj
         uKgP111C8rnGfLOm8MsoEkjhjXxy2Qjyaqw2DKBCq7wFzDaB7fOzmWGWokZRx4GPxreJ
         nS4urTVZ+qT9tw4Z8unrPLrQkzEbSDh7Su1IKg0CHdXnfCNFHDDTyIE9n/tfQReRq98s
         /Urw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=9yt+hi0cOzkpXoovsJa0gnIESbhDewSu0PSZCY0aJr4=;
        b=kYP9D4cKZreBHb9porhYF7lOXBZUt4xA9Jjmgoezie9HeSny6/MCbSMlSA0YAri4gr
         xwqnfKzhJ3WEwXEq3etp++XexRbHEoQsv18mCiG8aHavazlgQoe3FznNs7q1mAA8oNuj
         o15EHILGWnpcByXoi/RUtgmShvlZaMASUOa9d+g5H+zvwyGT/zmGyqdRao1Ys9Hq9z1Y
         MAOdaAGNgzEdEMvRWk252g7VCztgQqpKw/9QSLHBsiQTfoHc/t+8VB6H0GNhXOmw/Als
         vmUd6NlUvf4wSqKXY9k5wU5GAyKD0LOHaoiri9twGb8t28Amimhi/CpxiLjS+KyegYJV
         wRDg==
X-Gm-Message-State: AElRT7GEUBIbuctXfiyObkREEL8CdkI632Nwq4Um2ZqtzmfFaKlLNLHv
        T8x1KRXeKUigZ63W8LviCa0Kw9CY/05//8vjMyNHB26iWK7Gjlo+4JWJEinXLr9In4aYoFcdWqj
        FDtnYnZhvn3Sw2CpBtMml3YUFrGffYOgA3VUTbQ1lLxltsidsD3rjpDf+Yw==
X-Google-Smtp-Source: AG47ELvkOlCcPPHcV2bE2swtJWc+zXw9wOiRpui448IFkkt749M0mOkGnwbjzjO9CrDDi9v86bqEHduguII=
MIME-Version: 1.0
X-Received: by 10.157.0.153 with SMTP id w25mr2425089oti.54.1521052346594;
 Wed, 14 Mar 2018 11:32:26 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:41 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-5-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 04/35] upload-pack: convert to a builtin
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In order to allow for code sharing with the server-side of fetch in
protocol-v2 convert upload-pack to be a builtin.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile              |   3 +-
 builtin.h             |   1 +
 builtin/upload-pack.c |  67 ++++++++++++++++++++++++++
 git.c                 |   1 +
 upload-pack.c         | 107 ++++++++++--------------------------------
 upload-pack.h         |  13 +++++
 6 files changed, 109 insertions(+), 83 deletions(-)
 create mode 100644 builtin/upload-pack.c
 create mode 100644 upload-pack.h

diff --git a/Makefile b/Makefile
index 1a9b23b679..b7ccc05fac 100644
--- a/Makefile
+++ b/Makefile
@@ -639,7 +639,6 @@ PROGRAM_OBJS += imap-send.o
 PROGRAM_OBJS += sh-i18n--envsubst.o
 PROGRAM_OBJS += shell.o
 PROGRAM_OBJS += show-index.o
-PROGRAM_OBJS += upload-pack.o
 PROGRAM_OBJS += remote-testsvn.o
 
 # Binary suffix, set to .exe for Windows builds
@@ -909,6 +908,7 @@ LIB_OBJS += tree-diff.o
 LIB_OBJS += tree.o
 LIB_OBJS += tree-walk.o
 LIB_OBJS += unpack-trees.o
+LIB_OBJS += upload-pack.o
 LIB_OBJS += url.o
 LIB_OBJS += urlmatch.o
 LIB_OBJS += usage.o
@@ -1026,6 +1026,7 @@ BUILTIN_OBJS += builtin/update-index.o
 BUILTIN_OBJS += builtin/update-ref.o
 BUILTIN_OBJS += builtin/update-server-info.o
 BUILTIN_OBJS += builtin/upload-archive.o
+BUILTIN_OBJS += builtin/upload-pack.o
 BUILTIN_OBJS += builtin/var.o
 BUILTIN_OBJS += builtin/verify-commit.o
 BUILTIN_OBJS += builtin/verify-pack.o
diff --git a/builtin.h b/builtin.h
index 42378f3aa4..f332a12574 100644
--- a/builtin.h
+++ b/builtin.h
@@ -231,6 +231,7 @@ extern int cmd_update_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_update_server_info(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive(int argc, const char **argv, const char *prefix);
 extern int cmd_upload_archive_writer(int argc, const char **argv, const char *prefix);
+extern int cmd_upload_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_var(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_commit(int argc, const char **argv, const char *prefix);
 extern int cmd_verify_tag(int argc, const char **argv, const char *prefix);
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
new file mode 100644
index 0000000000..2cb5cb35b0
--- /dev/null
+++ b/builtin/upload-pack.c
@@ -0,0 +1,67 @@
+#include "cache.h"
+#include "builtin.h"
+#include "exec_cmd.h"
+#include "pkt-line.h"
+#include "parse-options.h"
+#include "protocol.h"
+#include "upload-pack.h"
+
+static const char * const upload_pack_usage[] = {
+	N_("git upload-pack [<options>] <dir>"),
+	NULL
+};
+
+int cmd_upload_pack(int argc, const char **argv, const char *prefix)
+{
+	const char *dir;
+	int strict = 0;
+	struct upload_pack_options opts = { 0 };
+	struct option options[] = {
+		OPT_BOOL(0, "stateless-rpc", &opts.stateless_rpc,
+			 N_("quit after a single request/response exchange")),
+		OPT_BOOL(0, "advertise-refs", &opts.advertise_refs,
+			 N_("exit immediately after initial ref advertisement")),
+		OPT_BOOL(0, "strict", &strict,
+			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
+		OPT_INTEGER(0, "timeout", &opts.timeout,
+			    N_("interrupt transfer after <n> seconds of inactivity")),
+		OPT_END()
+	};
+
+	packet_trace_identity("upload-pack");
+	check_replace_refs = 0;
+
+	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
+
+	if (argc != 1)
+		usage_with_options(upload_pack_usage, options);
+
+	if (opts.timeout)
+		opts.daemon_mode = 1;
+
+	setup_path();
+
+	dir = argv[0];
+
+	if (!enter_repo(dir, strict))
+		die("'%s' does not appear to be a git repository", dir);
+
+	switch (determine_protocol_version_server()) {
+	case protocol_v1:
+		/*
+		 * v1 is just the original protocol with a version string,
+		 * so just fall through after writing the version string.
+		 */
+		if (opts.advertise_refs || !opts.stateless_rpc)
+			packet_write_fmt(1, "version 1\n");
+
+		/* fallthrough */
+	case protocol_v0:
+		upload_pack(&opts);
+		break;
+	case protocol_unknown_version:
+		BUG("unknown protocol version");
+	}
+
+	return 0;
+}
diff --git a/git.c b/git.c
index c870b9719c..f71073dc8d 100644
--- a/git.c
+++ b/git.c
@@ -478,6 +478,7 @@ static struct cmd_struct commands[] = {
 	{ "update-server-info", cmd_update_server_info, RUN_SETUP },
 	{ "upload-archive", cmd_upload_archive },
 	{ "upload-archive--writer", cmd_upload_archive_writer },
+	{ "upload-pack", cmd_upload_pack },
 	{ "var", cmd_var, RUN_SETUP_GENTLY },
 	{ "verify-commit", cmd_verify_commit, RUN_SETUP },
 	{ "verify-pack", cmd_verify_pack },
diff --git a/upload-pack.c b/upload-pack.c
index d5de18127c..2ad73a98b1 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -6,7 +6,6 @@
 #include "tag.h"
 #include "object.h"
 #include "commit.h"
-#include "exec_cmd.h"
 #include "diff.h"
 #include "revision.h"
 #include "list-objects.h"
@@ -15,15 +14,10 @@
 #include "sigchain.h"
 #include "version.h"
 #include "string-list.h"
-#include "parse-options.h"
 #include "argv-array.h"
 #include "prio-queue.h"
 #include "protocol.h"
-
-static const char * const upload_pack_usage[] = {
-	N_("git upload-pack [<options>] <dir>"),
-	NULL
-};
+#include "upload-pack.h"
 
 /* Remember to update object flag allocation in object.h */
 #define THEY_HAVE	(1u << 11)
@@ -61,7 +55,6 @@ static int keepalive = 5;
  * otherwise maximum packet size (up to 65520 bytes).
  */
 static int use_sideband;
-static int advertise_refs;
 static int stateless_rpc;
 static const char *pack_objects_hook;
 
@@ -977,33 +970,6 @@ static int find_symref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static void upload_pack(void)
-{
-	struct string_list symref = STRING_LIST_INIT_DUP;
-
-	head_ref_namespaced(find_symref, &symref);
-
-	if (advertise_refs || !stateless_rpc) {
-		reset_timeout();
-		head_ref_namespaced(send_ref, &symref);
-		for_each_namespaced_ref(send_ref, &symref);
-		advertise_shallow_grafts(1);
-		packet_flush(1);
-	} else {
-		head_ref_namespaced(check_ref, NULL);
-		for_each_namespaced_ref(check_ref, NULL);
-	}
-	string_list_clear(&symref, 1);
-	if (advertise_refs)
-		return;
-
-	receive_needs();
-	if (want_obj.nr) {
-		get_common_commits();
-		create_pack_file();
-	}
-}
-
 static int upload_pack_config(const char *var, const char *value, void *unused)
 {
 	if (!strcmp("uploadpack.allowtipsha1inwant", var)) {
@@ -1032,58 +998,35 @@ static int upload_pack_config(const char *var, const char *value, void *unused)
 	return parse_hide_refs_config(var, value, "uploadpack");
 }
 
-int cmd_main(int argc, const char **argv)
+void upload_pack(struct upload_pack_options *options)
 {
-	const char *dir;
-	int strict = 0;
-	struct option options[] = {
-		OPT_BOOL(0, "stateless-rpc", &stateless_rpc,
-			 N_("quit after a single request/response exchange")),
-		OPT_BOOL(0, "advertise-refs", &advertise_refs,
-			 N_("exit immediately after initial ref advertisement")),
-		OPT_BOOL(0, "strict", &strict,
-			 N_("do not try <directory>/.git/ if <directory> is no Git directory")),
-		OPT_INTEGER(0, "timeout", &timeout,
-			    N_("interrupt transfer after <n> seconds of inactivity")),
-		OPT_END()
-	};
-
-	packet_trace_identity("upload-pack");
-	check_replace_refs = 0;
-
-	argc = parse_options(argc, argv, NULL, options, upload_pack_usage, 0);
-
-	if (argc != 1)
-		usage_with_options(upload_pack_usage, options);
-
-	if (timeout)
-		daemon_mode = 1;
-
-	setup_path();
-
-	dir = argv[0];
+	struct string_list symref = STRING_LIST_INIT_DUP;
 
-	if (!enter_repo(dir, strict))
-		die("'%s' does not appear to be a git repository", dir);
+	stateless_rpc = options->stateless_rpc;
+	timeout = options->timeout;
+	daemon_mode = options->daemon_mode;
 
 	git_config(upload_pack_config, NULL);
 
-	switch (determine_protocol_version_server()) {
-	case protocol_v1:
-		/*
-		 * v1 is just the original protocol with a version string,
-		 * so just fall through after writing the version string.
-		 */
-		if (advertise_refs || !stateless_rpc)
-			packet_write_fmt(1, "version 1\n");
-
-		/* fallthrough */
-	case protocol_v0:
-		upload_pack();
-		break;
-	case protocol_unknown_version:
-		BUG("unknown protocol version");
+	head_ref_namespaced(find_symref, &symref);
+
+	if (options->advertise_refs || !stateless_rpc) {
+		reset_timeout();
+		head_ref_namespaced(send_ref, &symref);
+		for_each_namespaced_ref(send_ref, &symref);
+		advertise_shallow_grafts(1);
+		packet_flush(1);
+	} else {
+		head_ref_namespaced(check_ref, NULL);
+		for_each_namespaced_ref(check_ref, NULL);
 	}
+	string_list_clear(&symref, 1);
+	if (options->advertise_refs)
+		return;
 
-	return 0;
+	receive_needs();
+	if (want_obj.nr) {
+		get_common_commits();
+		create_pack_file();
+	}
 }
diff --git a/upload-pack.h b/upload-pack.h
new file mode 100644
index 0000000000..a71e4dc7e2
--- /dev/null
+++ b/upload-pack.h
@@ -0,0 +1,13 @@
+#ifndef UPLOAD_PACK_H
+#define UPLOAD_PACK_H
+
+struct upload_pack_options {
+	int stateless_rpc;
+	int advertise_refs;
+	unsigned int timeout;
+	int daemon_mode;
+};
+
+void upload_pack(struct upload_pack_options *options);
+
+#endif /* UPLOAD_PACK_H */
-- 
2.16.2.804.g6dcf76e118-goog

