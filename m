Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 585D61F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:33:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752503AbeCNSdB (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:33:01 -0400
Received: from mail-it0-f73.google.com ([209.85.214.73]:35553 "EHLO
        mail-it0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeCNSc5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:57 -0400
Received: by mail-it0-f73.google.com with SMTP id n73-v6so3687326itg.0
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=X/YL8/ArG8Cb9ZH5w3fdLrlhpsSowuKY+j54Dws9VRo=;
        b=uXg+YJGb1h5WlTTwtUEiWJoxPGggNTKrBCE0mVrkgc+VbwtCubhEEdXhK2dqeNBkrx
         32tgrrsDD1TQzs5cCczA6DktR2KHxGRE3FNVxyw72wFsXKLADEG52aygvFawGmqDvhdT
         QNt/P3k9wCdALPaA4MIOH2e5kiTJD19+zcxW7ZiZiyqGAiWj89kwVCag1XDQaY8szwBi
         2hymO6DvTUyKd+6VjCOhTHizLeJSsWRwa611jBNNyK1pyLUUJhgxqg4JLqR3/aD0akEJ
         hgFQuXZTBA00n1VE8CsPQdkHNExAtavCizTbci/tBIwbFYP9gVHDaQjSakVk8g+UCu6P
         MiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=X/YL8/ArG8Cb9ZH5w3fdLrlhpsSowuKY+j54Dws9VRo=;
        b=efhAbQNaFMjHIZa6/ck6KZCxq7XrU3W/RfjpNaTvBlgCAy8mnWbNCtQ0pIUS29vmzh
         OJ0rfc9GlZWj99zm2tn4mi4Yd57osIgfJF1pTppQ13sOu4BNoIhSROVDLr7AjzviA0EY
         yBrwhLx68j2b7sHZHbXB1Qzf2UkR0A2kNbTaQMD1LOPuwtB4VyTUEBoXbALBHNfy9Cok
         IpziQEsTUPNFK6SLmt/Fx+LGNBhOrLAq5WZBHj3UXjeljATM8lHDiJ3fsa1i794GmpD4
         5bwQcRAzqy4zCYtROj9ihwyq5GHmOK40e364T9nTbAigiuDyrjb3TOH4RPXLJwGVQIhm
         X4aQ==
X-Gm-Message-State: AElRT7EUE9WXAyNQXLQPn0uqt7RvHJQLcOl0sZKF3YoXDDq48uZq5Dv4
        /yP3EzHOIPZ5V4rpwTkJSBmY5hfsJlwSlbgZ9Lmp9Iil4NTjiRJxzRsMh15OPrI+UrFT8uLEDVo
        0y3dln26zs1pPOVK5RVFcof5XqtiYTS02NhL5uk6AniNBEFyNiAVhRYiZ3Q==
X-Google-Smtp-Source: AG47ELvoSvwF96bSvB0XucSpf3ojSWBea0JpWtXPtR+WXCdpwfEnv+lkz3WtM8/o+91mylJconEEaZi75Wg=
MIME-Version: 1.0
X-Received: by 2002:a24:3a90:: with SMTP id m138-v6mr1332540itm.37.1521052376681;
 Wed, 14 Mar 2018 11:32:56 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:54 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-18-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 17/35] ls-remote: pass ref prefixes when requesting a
 remote's refs
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

Construct an argv_array of ref prefixes based on the patterns supplied
via the command line and pass them to 'transport_get_remote_refs()' to
be used when communicating protocol v2 so that the server can limit the
ref advertisement based on those prefixes.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/ls-remote.c    | 15 +++++++++++++--
 refs.c                 | 14 ++++++++++++++
 refs.h                 |  7 +++++++
 t/t5702-protocol-v2.sh | 26 ++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 2 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index c6e9847c5c..4276bf97d5 100644
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
+	struct argv_array ref_prefixes = ARGV_ARRAY_INIT;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -74,8 +76,17 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (argc > 1) {
 		int i;
 		pattern = xcalloc(argc, sizeof(const char *));
-		for (i = 1; i < argc; i++)
+		for (i = 1; i < argc; i++) {
+			const char *glob;
 			pattern[i - 1] = xstrfmt("*/%s", argv[i]);
+
+			glob = strchr(argv[i], '*');
+			if (glob)
+				argv_array_pushf(&ref_prefixes, "%.*s",
+						 (int)(glob - argv[i]), argv[i]);
+			else
+				expand_ref_prefix(&ref_prefixes, argv[i]);
+		}
 	}
 
 	remote = remote_get(dest);
@@ -96,7 +107,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (uploadpack != NULL)
 		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
 
-	ref = transport_get_remote_refs(transport, NULL);
+	ref = transport_get_remote_refs(transport, &ref_prefixes);
 	if (transport_disconnect(transport))
 		return 1;
 
diff --git a/refs.c b/refs.c
index 20ba82b434..cefbad2076 100644
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
+ * Given a 'prefix' expand it by the rules in 'ref_rev_parse_rules' and add
+ * the results to 'prefixes'
+ */
+void expand_ref_prefix(struct argv_array *prefixes, const char *prefix)
+{
+	const char **p;
+	int len = strlen(prefix);
+
+	for (p = ref_rev_parse_rules; *p; p++)
+		argv_array_pushf(prefixes, *p, len, prefix);
+}
+
 /*
  * *string and *len will only be substituted, and *string returned (for
  * later free()ing) if the string passed in is a magic short-hand form
diff --git a/refs.h b/refs.h
index 01be5ae32f..93b6dce944 100644
--- a/refs.h
+++ b/refs.h
@@ -139,6 +139,13 @@ int resolve_gitlink_ref(const char *submodule, const char *refname,
  */
 int refname_match(const char *abbrev_name, const char *full_name);
 
+/*
+ * Given a 'prefix' expand it by the rules in 'ref_rev_parse_rules' and add
+ * the results to 'prefixes'
+ */
+struct argv_array;
+void expand_ref_prefix(struct argv_array *prefixes, const char *prefix);
+
 int expand_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_ref(const char *str, int len, struct object_id *oid, char **ref);
 int dwim_log(const char *str, int len, struct object_id *oid, char **ref);
diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index dc5f813beb..562610fd25 100755
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
2.16.2.804.g6dcf76e118-goog

