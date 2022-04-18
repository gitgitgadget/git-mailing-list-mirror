Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C20CC433EF
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347078AbiDRR1X (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiDRR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD5933EBD
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:14 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id c10so19324612wrb.1
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D45sG+hzI4zIoR7FHO+luJjvxLBkny+SPzPP11oYGjA=;
        b=Bv4Qo1GQN8CsKhp9n1xs2heOu4AYkSXda43ISKPkYrXvW3VaDcyRFLNrld2VqsljOG
         xhWkpcMZU6AsymuCbC105dm5oG6dKEVko/5jwvSx+juYLPYK1DHpxQHIqbdvtXZX+qOy
         8R6jXGBhHvoHdYn/Lxa9Iiv1a0MGiqadFCDGg+YZ7j5rSa6KsupiPa675T2FR1SFrdEy
         KMDpTvpaWt5r8a+0oQE/HYR/q64NZFwztJFisbowf4NkLPCuk7c5FgvIi3KcNX2ElDOx
         JKGgdGb/NESe2WV3O15zO6AnQIZ5r6ulSvpflC+MvC7SkmfZHor3QmDfg3LQlbhUYjpm
         PXuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D45sG+hzI4zIoR7FHO+luJjvxLBkny+SPzPP11oYGjA=;
        b=W8/jkaSAYCWPqxXe8WBaNyqvY2rOGlStnoSmU5dZOt/bVD0PR1dPTWn7sgpeynFpcD
         dvzEMR2eWzQXzrQnRGVHkPxZK+EzccWGd968zxiGU+8RX+W25WnfS6INfAnNC9pkQCG3
         sNwZWko78Lnt4LWi9/Y1rMa9gO0BzwNF55kljw51/XopNjDk1IyulMjEAOvZovX7n1Tq
         Kb6ZJqoZZsPzrU4GsKO6STVC8nFdaKiRDaM/JdrhE9q33t1OQe6mnIok1KU9PCxPTc12
         FJ5gJFVfhqoZ3GGHRGtpHpMmLF4wnD1MZ1nH4xJGNzNZ0C92/AJ3R/ViMZikCpNg4KhT
         0JYg==
X-Gm-Message-State: AOAM533c/Da/ALPVL4EkkDsA2h3LXFOeLzpQ+AE3VZx09BAQwLpAf2Nv
        Fh5N7vjz511EMHyCk/Dr2nDY8fC0j95avg==
X-Google-Smtp-Source: ABdhPJyKOf7w+kWO5+Ye30XmcPIxxa8L0pdeIYuhWjKScTwj54wbtSxeIdXVPV1D3NL/pBn2PyC65A==
X-Received: by 2002:a5d:66d0:0:b0:207:a53f:5c2d with SMTP id k16-20020a5d66d0000000b00207a53f5c2dmr8871211wrw.440.1650302652635;
        Mon, 18 Apr 2022 10:24:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v2 12/36] bundle-uri client: add "git ls-remote-bundle-uri"
Date:   Mon, 18 Apr 2022 19:23:29 +0200
Message-Id: <RFC-patch-v2-12.36-54149dcb0aa-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a git-ls-remote-bundle-uri command, this is a thin wrapper for
issuing protocol v2 "bundle-uri" commands to a server, and to the
parsing routines in bundle-uri.c.

Since in the "git clone" case we'll have already done the handshake(),
but not here, introduce a "got_advertisement" state along with
"got_remote_heads". It seems to me that the "got_remote_heads" is
badly named in the first place, and the whole logic of eagerly getting
ls-refs on handshake() or not could be refactored somewhat, but let's
not do that now, and instead just add another self-documenting state
variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-ls-remote-bundle-uri.txt |  62 +++++++++++
 Documentation/git-ls-remote.txt            |   1 +
 Makefile                                   |   1 +
 builtin.h                                  |   1 +
 builtin/clone.c                            |   2 +-
 builtin/ls-remote-bundle-uri.c             |  90 +++++++++++++++
 command-list.txt                           |   1 +
 git.c                                      |   1 +
 t/lib-t5730-protocol-v2-bundle-uri.sh      | 124 +++++++++++++++++++++
 transport.c                                |  43 +++++--
 transport.h                                |   6 +-
 11 files changed, 321 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/git-ls-remote-bundle-uri.txt
 create mode 100644 builtin/ls-remote-bundle-uri.c

diff --git a/Documentation/git-ls-remote-bundle-uri.txt b/Documentation/git-ls-remote-bundle-uri.txt
new file mode 100644
index 00000000000..793d7677f2f
--- /dev/null
+++ b/Documentation/git-ls-remote-bundle-uri.txt
@@ -0,0 +1,62 @@
+git-ls-remote-bundle-uri(1)
+===========================
+
+NAME
+----
+git-ls-remote-bundle-uri - List 'bundle-uri' in a remote repository
+
+SYNOPSIS
+--------
+[verse]
+'git ls-remote-bundle-uri' [-q |--quiet] [--uri] [--upload-pack=<exec>]
+			 [[-o | --server-option=]<option>] <repository>
+
+
+DESCRIPTION
+-----------
+
+Displays the `bundle-uri`s advertised by a remote repository. See
+`bundle-uri` in link:technical/protocol-v2.html[the Git Wire Protocol,
+Version 2] documentation for what the output format looks like.
+
+OPTIONS
+-------
+
+-q::
+--quiet::
+	Do not print remote URL to stderr in cases where the remote
+	name is inferred from config.
++
+When the remote name is not inferred (e.g. `git ls-remote-bundle-uri
+origin`, or `git ls-remote-bundle-uri https://[...]`) the remote URL
+is not printed in any case.
+
+--uri::
+	Print only the URIs, and not any of their optional attributes.
+
+--upload-pack=<exec>::
+	Specify the full path of 'git-upload-pack' on the remote
+	host. This allows listing references from repositories accessed via
+	SSH and where the SSH daemon does not use the PATH configured by the
+	user.
+
+-o <option>::
+--server-option=<option>::
+	Transmit the given string to the server when communicating using
+	protocol version 2.  The given string must not contain a NUL or LF
+	character.
+	When multiple `--server-option=<option>` are given, they are all
+	sent to the other side in the order listed on the command line.
+
+<repository>::
+	The "remote" repository to query.  This parameter can be
+	either a URL or the name of a remote (see the GIT URLS and
+	REMOTES sections of linkgit:git-fetch[1]).
+
+SEE ALSO
+--------
+linkgit:git-ls-remote[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index 492e573856f..86c07eff832 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -114,6 +114,7 @@ c5db5456ae3b0873fc659c19fafdde22313cc441	refs/tags/v0.99.2
 
 SEE ALSO
 --------
+linkgit:git-ls-remote-bundle-uri[1].
 linkgit:git-check-ref-format[1].
 
 GIT
diff --git a/Makefile b/Makefile
index c8a14793005..badb87bed78 100644
--- a/Makefile
+++ b/Makefile
@@ -1161,6 +1161,7 @@ BUILTIN_OBJS += builtin/init-db.o
 BUILTIN_OBJS += builtin/interpret-trailers.o
 BUILTIN_OBJS += builtin/log.o
 BUILTIN_OBJS += builtin/ls-files.o
+BUILTIN_OBJS += builtin/ls-remote-bundle-uri.o
 BUILTIN_OBJS += builtin/ls-remote.o
 BUILTIN_OBJS += builtin/ls-tree.o
 BUILTIN_OBJS += builtin/mailinfo.o
diff --git a/builtin.h b/builtin.h
index 40e9ecc8485..c80bec94abe 100644
--- a/builtin.h
+++ b/builtin.h
@@ -173,6 +173,7 @@ int cmd_log(int argc, const char **argv, const char *prefix);
 int cmd_log_reflog(int argc, const char **argv, const char *prefix);
 int cmd_ls_files(int argc, const char **argv, const char *prefix);
 int cmd_ls_tree(int argc, const char **argv, const char *prefix);
+int cmd_ls_remote_bundle_uri(int argc, const char **argv, const char *prefix);
 int cmd_ls_remote(int argc, const char **argv, const char *prefix);
 int cmd_mailinfo(int argc, const char **argv, const char *prefix);
 int cmd_mailsplit(int argc, const char **argv, const char *prefix);
diff --git a/builtin/clone.c b/builtin/clone.c
index 709f1502f91..e11f4019b87 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1240,7 +1240,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	 * Populate transport->got_remote_bundle_uri and
 	 * transport->bundle_uri. We might get nothing.
 	 */
-	transport_get_remote_bundle_uri(transport);
+	transport_get_remote_bundle_uri(transport, 1);
 
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
diff --git a/builtin/ls-remote-bundle-uri.c b/builtin/ls-remote-bundle-uri.c
new file mode 100644
index 00000000000..dadb21043c0
--- /dev/null
+++ b/builtin/ls-remote-bundle-uri.c
@@ -0,0 +1,90 @@
+#include "builtin.h"
+#include "cache.h"
+#include "transport.h"
+#include "ref-filter.h"
+#include "remote.h"
+#include "refs.h"
+
+static const char * const ls_remote_bundle_uri_usage[] = {
+	N_("git ls-remote-bundle-uri <repository>"),
+	NULL
+};
+
+int cmd_ls_remote_bundle_uri(int argc, const char **argv, const char *prefix)
+{
+	int quiet = 0;
+	int uri = 0;
+	const char *uploadpack = NULL;
+	struct string_list server_options = STRING_LIST_INIT_DUP;
+	struct option options[] = {
+		OPT__QUIET(&quiet, N_("do not print remote URL")),
+		OPT_BOOL(0, "uri", &uri, N_("limit to showing uri field")),
+		OPT_STRING(0, "upload-pack", &uploadpack, N_("exec"),
+			   N_("path of git-upload-pack on the remote host")),
+		OPT_STRING_LIST('o', "server-option", &server_options,
+				N_("server-specific"),
+				N_("option to transmit")),
+		OPT_END()
+	};
+	const char *dest = NULL;
+	struct remote *remote;
+	struct transport *transport;
+	int status = 0;
+	struct string_list_item *item;
+
+	argc = parse_options(argc, argv, prefix, options, ls_remote_bundle_uri_usage,
+			     PARSE_OPT_STOP_AT_NON_OPTION);
+	dest = argv[0];
+
+	packet_trace_identity("ls-remote-bundle-uri");
+
+	remote = remote_get(dest);
+	if (!remote) {
+		if (dest)
+			die(_("bad repository '%s'"), dest);
+		die(_("no remote configured to get bundle URIs from"));
+	}
+	if (!remote->url_nr)
+		die(_("remote '%s' has no configured URL"), dest);
+
+	transport = transport_get(remote, NULL);
+	if (uploadpack)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK, uploadpack);
+	if (server_options.nr)
+		transport->server_options = &server_options;
+
+	if (!dest && !quiet)
+		fprintf(stderr, "From %s\n", *remote->url);
+
+	if (transport_get_remote_bundle_uri(transport, 0) < 0) {
+		error(_("could not get the bundle-uri list"));
+		status = 1;
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, &transport->bundle_uri) {
+		struct string_list_item *kv_item;
+		struct string_list *kv = item->util;
+
+		fprintf(stdout, "%s", item->string);
+		if (uri || !kv) {
+			fprintf(stdout, "\n");
+			continue;
+		}
+		for_each_string_list_item(kv_item, kv) {
+			const char *k = kv_item->string;
+			const char *v = kv_item->util;
+
+			if (v)
+				fprintf(stdout, " %s=%s", k, v);
+			else
+				fprintf(stdout, " %s", k);
+		}
+		fprintf(stdout, "\n");
+	}
+
+cleanup:
+	if (transport_disconnect(transport))
+		return 1;
+	return status;
+}
diff --git a/command-list.txt b/command-list.txt
index 9bd6f3c48f4..a50eebd4aa2 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -115,6 +115,7 @@ git-interpret-trailers                  purehelpers
 git-log                                 mainporcelain           info
 git-ls-files                            plumbinginterrogators
 git-ls-remote                           plumbinginterrogators
+git-ls-remote-bundle-uri                plumbinginterrogators
 git-ls-tree                             plumbinginterrogators
 git-mailinfo                            purehelpers
 git-mailsplit                           purehelpers
diff --git a/git.c b/git.c
index 3d8e48cf555..352e76cedaf 100644
--- a/git.c
+++ b/git.c
@@ -551,6 +551,7 @@ static struct cmd_struct commands[] = {
 	{ "log", cmd_log, RUN_SETUP },
 	{ "ls-files", cmd_ls_files, RUN_SETUP },
 	{ "ls-remote", cmd_ls_remote, RUN_SETUP_GENTLY },
+	{ "ls-remote-bundle-uri", cmd_ls_remote_bundle_uri, RUN_SETUP_GENTLY },
 	{ "ls-tree", cmd_ls_tree, RUN_SETUP },
 	{ "mailinfo", cmd_mailinfo, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "mailsplit", cmd_mailsplit, NO_PARSEOPT },
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index 7a90c80f0b1..d0b15a47ec2 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -143,3 +143,127 @@ test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protoc
 	grep "clone> test-bad-client$" log >sent-bad-request &&
 	test_file_not_empty sent-bad-request
 '
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	$T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp expect actual &&
+
+	# Only the URIs
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri --uri \
+		"$T5730_URI" \
+		>actual2 &&
+	test_cmp actual actual2
+'
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	ATTR="foo bar=baz" &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED $ATTR" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	$T5730_BUNDLE_URI_ESCAPED $ATTR
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "ls-remote-bundle-uri with $T5730_PROTOCOL:// using protocol v2: --uri" '
+	test_when_finished "rm -f log" &&
+
+	ATTR="foo bar=baz" &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED $ATTR" &&
+
+	# All data about bundle URIs
+	cat >expect <<-EOF &&
+	$T5730_BUNDLE_URI_ESCAPED
+	EOF
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--uri \
+		"$T5730_URI" \
+		>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success "ls-remote-bundle-uri --[no-]quiet with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+	test_when_finished "rm -rf child" &&
+	env GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		 clone "$T5730_URI" child &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	# Without --[no-]quiet
+	cat >out.expect <<-EOF &&
+	$T5730_BUNDLE_URI_ESCAPED
+	EOF
+	cat >err.expect <<-EOF &&
+	From $T5730_URI
+	EOF
+	git \
+		-C child \
+		 -c protocol.version=2 \
+		ls-remote-bundle-uri \
+		>out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp out.expect out.actual &&
+
+	# --no-quiet is the default
+	git \
+		-C child \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--no-quiet \
+		>out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_cmp out.expect out.actual &&
+
+	# --quiet quiets the "From" line
+	git \
+		-C child \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		--quiet \
+		>out.actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp out.expect out.actual &&
+
+	# --quiet is implicit if the remote is not implicit
+	git \
+		-c protocol.version=2 \
+		ls-remote-bundle-uri \
+		"$T5730_URI" \
+		>out.actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp out.expect out.actual
+'
diff --git a/transport.c b/transport.c
index 9a31e3f996b..e648d3110bb 100644
--- a/transport.c
+++ b/transport.c
@@ -198,6 +198,7 @@ struct git_transport_data {
 	struct git_transport_options options;
 	struct child_process *conn;
 	int fd[2];
+	unsigned got_advertisement : 1;
 	unsigned got_remote_heads : 1;
 	enum protocol_version version;
 	struct oid_array extra_have;
@@ -346,6 +347,7 @@ static struct ref *handshake(struct transport *transport, int for_push,
 		BUG("unknown protocol version");
 	}
 	data->got_remote_heads = 1;
+	data->got_advertisement = 1;
 	transport->hash_algo = reader.hash_algo;
 
 	if (reader.line_peeked)
@@ -367,6 +369,33 @@ static int get_bundle_uri(struct transport *transport)
 	int stateless_rpc = transport->stateless_rpc;
 	string_list_init_dup(&transport->bundle_uri);
 
+	if (!data->got_advertisement) {
+		struct ref *refs;
+		struct git_transport_data *data = transport->data;
+		enum protocol_version version;
+
+		refs = handshake(transport, 0, NULL, 0);
+		version = data->version;
+
+		switch (version) {
+		case protocol_v2:
+			assert(!refs);
+			break;
+		case protocol_v0:
+		case protocol_v1:
+		case protocol_unknown_version:
+			assert(refs);
+			break;
+		}
+	}
+
+	/*
+	 * "Support" protocol v0 and v2 without bundle-uri support by
+	 * silently degrading to a NOOP.
+	 */
+	if (!server_supports_v2("bundle-uri", 0))
+		return 0;
+
 	packet_reader_init(&reader, data->fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_GENTLE_ON_EOF);
@@ -1492,7 +1521,7 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
-int transport_get_remote_bundle_uri(struct transport *transport)
+int transport_get_remote_bundle_uri(struct transport *transport, int quiet)
 {
 	const struct transport_vtable *vtable = transport->vtable;
 
@@ -1500,20 +1529,16 @@ int transport_get_remote_bundle_uri(struct transport *transport)
 	if (transport->got_remote_bundle_uri++)
 		return 0;
 
-	/*
-	 * "Support" protocol v0 and v2 without bundle-uri support by
-	 * silently degrading to a NOOP.
-	 */
-	if (!server_supports_v2("bundle-uri", 0))
-		return 0;
-
 	/*
 	 * This is intentionally below the transport.injectBundleURI,
 	 * we want to be able to inject into protocol v0, or into the
 	 * dialog of a server who doesn't support this.
 	 */
-	if (!vtable->get_bundle_uri)
+	if (!vtable->get_bundle_uri) {
+		if (quiet)
+			return -1;
 		return error(_("bundle-uri operation not supported by protocol"));
+	}
 
 	if (vtable->get_bundle_uri(transport) < 0)
 		return error(_("could not retrieve server-advertised bundle-uri list"));
diff --git a/transport.h b/transport.h
index 90568845876..ed5ebcf1466 100644
--- a/transport.h
+++ b/transport.h
@@ -295,8 +295,12 @@ const struct ref *transport_get_remote_refs(struct transport *transport,
 /**
  * Retrieve bundle URI(s) from a remote. Populates "struct
  * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ *
+ * With `quiet=1` it will not complain if the serve doesn't support
+ * the protocol, but only if we discover the server uses it, and
+ * encounter issues then.
  */
-int transport_get_remote_bundle_uri(struct transport *transport);
+int transport_get_remote_bundle_uri(struct transport *transport, int quiet);
 
 /*
  * Fetch the hash algorithm used by a remote.
-- 
2.36.0.rc2.902.g60576bbc845

