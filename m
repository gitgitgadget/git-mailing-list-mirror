Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4C641F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965003AbeB1XYG (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:24:06 -0500
Received: from mail-yb0-f202.google.com ([209.85.213.202]:52905 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964894AbeB1XYD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:24:03 -0500
Received: by mail-yb0-f202.google.com with SMTP id w11-v6so2378768ybi.19
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:24:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=o0l1a4vxHTCvd63rrTHlADIedk1cea++8oTgFrGQR1w=;
        b=GSl628dxuGICjicBa9p3r+N2EIfJ4pwPylvBXowE8BVDIbtN9JQA0wxx6biHAul9Od
         FCQ2gVvJeS8zQNnQ1RVFY+O417pQGez//savlZBOuzXCuJOVOq7EYOdW6QkXay+4VIaZ
         lpbHu87c32umEr4cQB8ceNCZP/7h5KaRJOtcbphvh3HqWUo6vhe6VSf9G44wcQcPMotk
         opg9ch/jn3slghKkTIk4Caxm1WoKngUZocFQw0uaTLVmvGDu53MCxPcZ9Mm/8isXAC2R
         os9DyqhACU5tIb47sfdaAmDo1IE4UiqTQMongEOIqQvZvp/uufXkS1HxZlekd21U8+5W
         gIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=o0l1a4vxHTCvd63rrTHlADIedk1cea++8oTgFrGQR1w=;
        b=lUr/87zym7PXbUtAR/I/7OpbEupelTvoBZBFcBq1YCLSTF6IrCWtXjWbOUtOYb9vBd
         6JC0JhU/7RI7Sgz1J9ECYyKrO50LuXPzOxu8g+CdoKUTwiNwzWfqqlZm8KRxBVoq+dTn
         uCVJfrdS3Ff8AhuiSaak+d15nlt2ZWfzzvRD3S9dg+8QtmIjyBOg+rssbvnusgyF4jza
         GvTjKHuta2tVMvKg8ANxZ4BQeW4wbLeH8XdVDbAvaeX8cdQ0sIJskEQlCahkndJNjPsI
         D9ueHyppnaJwqUU7sjfpCQ7Ie6VlAj1abh7JDduUpSGN9eJpDrxe/KWaJTyl4C2mHlJ7
         jbWA==
X-Gm-Message-State: APf1xPBogmGFNt7BdV3iijKijsjRCsrNNkQKdAG/xx9AUiQ9EZJV7KkP
        DEvKNUr4oXcv7uER5Xh0g1MheHObf+7DNoP4fLMnNgpl0jpm97CvkeQVlRMCMMDAvy5NHNY+58t
        8H7tKlS+s5XB4AzAxyDB9WaMpASgF5bmu55W4MG6o+R14cW2ISwN2ztv/wQ==
X-Google-Smtp-Source: AH8x2250xWe04o8zNc+9+uovzDf8ZjPKeJgcW+FpYYrIJBwCJMuGGYGWfHGepan7a6MePFVAD2eNnDh+PKY=
MIME-Version: 1.0
X-Received: by 10.129.165.196 with SMTP id c187mr9231664ywh.165.1519860242508;
 Wed, 28 Feb 2018 15:24:02 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:34 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-18-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 17/35] ls-remote: pass ref patterns when requesting a
 remote's refs
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Construct an argv_array of the ref patterns supplied via the command
line and pass them to 'transport_get_remote_refs()' to be used when
communicating protocol v2 so that the server can limit the ref
advertisement based on the supplied patterns.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-remote.c    | 12 ++++++++++--
 refs.c                 | 14 ++++++++++++++
 refs.h                 |  7 +++++++
 t/t5702-protocol-v2.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c6e9847c5..083ba8b29 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -2,6 +2,7 @@
 #include "cache.h"
 #include "transport.h"
 #include "remote.h"
+#include "refs.h"
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
@@ -43,6 +44,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int show_symref_target = 0;
 	const char *uploadpack = NULL;
 	const char **pattern = NULL;
+	struct argv_array ref_patterns = ARGV_ARRAY_INIT;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -74,8 +76,14 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (argc > 1) {
 		int i;
 		pattern = xcalloc(argc, sizeof(const char *));
-		for (i = 1; i < argc; i++)
+		for (i = 1; i < argc; i++) {
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
+
+			if (strchr(argv[i], '*'))
+				argv_array_push(&ref_patterns, argv[i]);
+			else
+				expand_ref_pattern(&ref_patterns, argv[i]);
+		}
 	}
 
 	remote = remote_get(dest);
@@ -96,7 +104,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-	ref = transport_get_remote_refs(transport, NULL);
+	ref = transport_get_remote_refs(transport, &ref_patterns);
 	if (transport_disconnect(transport))
 		return 1;
 
diff --git a/refs.c b/refs.c
index 20ba82b43..58e9f88fb 100644
--- a/refs.c
+++ b/refs.c
@@ -13,6 +13,7 @@
 #include "tag.h"
 #include "submodule.h"
 #include "worktree.h"
+#include "argv-array.h"
 
 /*
  * List of all available backends
@@ -501,6 +502,19 @@ int refname_match(const char *abbrev_name, const char *full_name)
 	return 0;
 }
 
+/*
+ * Given a 'pattern' expand it by the rules in 'ref_rev_parse_rules' and add
+ * the results to 'patterns'
+ */
+void expand_ref_pattern(struct argv_array *patterns, const char *pattern)
+{
+	const char **p;
+	for (p = ref_rev_parse_rules; *p; p++) {
+		int len = strlen(pattern);
+		argv_array_pushf(patterns, *p, len, pattern);
+	}
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index 01be5ae32..292ca35ce 100644
--- a/refs.h
+++ b/refs.h
@@ -139,6 +139,13 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
  */
 int refname_match(const char *abbrev_name, const char *full_name);
 
+/*
+ * Given a 'pattern' expand it by the rules in 'ref_rev_parse_rules' and add
+ * the results to 'patterns'
+ */
+struct argv_array;
+void expand_ref_pattern(struct argv_array *patterns, const char *pattern);
+
 int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index dc5f813be..562610fd2 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -32,6 +32,19 @@ test_expect_success 'list refs with git:// using protocol v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		ls-remote "$GIT_DAEMON_URL/parent" master >actual &&
+
+	cat >expect <<-EOF &&
+	$(git -C "$daemon_parent" rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	EOF
+
+	test_cmp actual expect
+'
+
 stop_git_daemon
 
 # Test protocol v2 with 'file://' transport
@@ -54,4 +67,17 @@ test_expect_success 'list refs with file:// using protocol v2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'ref advertisment is filtered with ls-remote using protocol v2' '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$(pwd)/log" git -c protocol.version=2 \
+		ls-remote "file://$(pwd)/file_parent" master >actual &&
+
+	cat >expect <<-EOF &&
+	$(git -C file_parent rev-parse refs/heads/master)$(printf "\t")refs/heads/master
+	EOF
+
+	test_cmp actual expect
+'
+
 test_done
-- 
2.16.2.395.g2e18187dfd-goog

