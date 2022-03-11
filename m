Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207FFC433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350256AbiCKQZy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiCKQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:47 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC7310A7CC
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:37 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r10so13742864wrp.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y62alKyHdEQTCNrRjgFAPKPu891DwMg9ckjj4cSa4Ds=;
        b=VOv4tcNZARqf503UBuipGOUztP5DV23aQcUGysWA96YPP1oeOj3uWJwdtD1cfAbiX0
         lmuM04VNyREDiDx3qup00xXlX0plct9zp/JmiWknt6y1YhpV+oGe5wnF//B6Mip1PaQ4
         0VXC/ua6NkBO4J+HIQwYauLCBZ5M6S48rXwdFDwv8eBhz8f57QI1SDOm0CFHKUv6gvO9
         BhitL1h2NfVNya0z7KDLcwARV2HEz2euM2DYbSoy8ss5E/MmEp9hgPzKxwzI7m/F9CUB
         Kk0PpRHn548IgH/rBVeEH7RGnzPdV7O2NFedkYxwT/yW+s9q5/vWCyfOiHHoESDdURX3
         P7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y62alKyHdEQTCNrRjgFAPKPu891DwMg9ckjj4cSa4Ds=;
        b=IB4R6qYwkGVL/ksIU6wPvgjHUYsHRuz8xsIBP6GHp7B8z2tPUZu9iL3GWq1AZAvsEo
         MgQXEAoTVLQ4xoT3LP2zTD2m/sdqGJVrXSqaFyysTRC70Ulm7FqslCWZy1TwosmCwM2u
         WJx2qiiiywbShFU27t9MXEYh3egupBMGbz60ou2urvV6ol3pwyQSmxD+EBeFSTtlCW0c
         2N1mWRarTWrNwNXAG5E20H51VuZCcC8Ldu2invU4YKw0t0PLrnfei85rS1dXxVn2UVdN
         P55//5yQh60s235K67eKU9eebgX+QZ4l/jmeiTSY/zBDxNOx9iaDLprqJzfgNkrwRm02
         BAiA==
X-Gm-Message-State: AOAM533/fkJm8+JdIyyrdrVlW7Xouaak0kj9zdx6IJ3BPKefXG6sKEcN
        MR2UR9xnL+XPtPWxZ5+LYNJTJSogmZeyKw==
X-Google-Smtp-Source: ABdhPJwEdlRwbqMR3Kr4fIoCk4iTJMXrUPOIJdg17k7WeoqmHikTqaROUowIqnQo7+jdtGWrpSBdYw==
X-Received: by 2002:adf:fa45:0:b0:203:954d:d5e3 with SMTP id y5-20020adffa45000000b00203954dd5e3mr3171190wrr.533.1647015875151;
        Fri, 11 Mar 2022 08:24:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:34 -0800 (PST)
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
Subject: [RFC PATCH v2 05/13] bundle-uri client: add minimal NOOP client
Date:   Fri, 11 Mar 2022 17:24:17 +0100
Message-Id: <RFC-patch-v2-05.13-105ced66409-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Set up all the needed client parts of the "bundle-uri" protocol
extension, without actually doing anything with the bundle URIs.

I.e. if the server says it supports "bundle-uri" we'll issue a
command=bundle-uri after command=ls-refs when we're cloning. We'll
parse the returned output using the code already tested for in
t5750-bundle-uri-parse.sh.

What we aren't doing is actually acting on that data, i.e. downloading
the bundle(s) before we get to doing the command=fetch, and adjusting
our negotiation dialog appropriately. I'll do that in subsequent
commits.

There's a question of what level of encapsulation we should use here,
I've opted to use connect.h in clone.c, but we could also e.g. make
transport_get_remote_refs() invoke this, i.e. make it implicitly get
the bundle-uri list for later steps.

This approach means that we don't "support" this in "git fetch" for
now. I'm starting with the case of initial clones, although as noted
in preceding commits to the protocol documentation nothing about this
approach precludes getting bundles on incremental fetches.

For the t5732-protocol-v2-bundle-uri-http.sh it's not easy to set
environment variables for git-upload-pack (it's started by Apache), so
let's skip the test under T5730_HTTP, and add unused T5730_{FILE,GIT}
prerequisites for consistency and future use.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/clone.c                        |   7 ++
 bundle-uri.c                           |   4 +
 connect.c                              |  47 +++++++++
 remote.h                               |   4 +
 t/lib-t5730-protocol-v2-bundle-uri.sh  | 141 +++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh |  36 +++++++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 +++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 +++
 transport-helper.c                     |  13 +++
 transport-internal.h                   |   7 ++
 transport.c                            |  48 +++++++++
 transport.h                            |  18 ++++
 12 files changed, 359 insertions(+)
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index a572cda5030..b2c1b4142ee 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -27,6 +27,7 @@
 #include "iterator.h"
 #include "sigchain.h"
 #include "branch.h"
+#include "connect.h"
 #include "remote.h"
 #include "run-command.h"
 #include "connected.h"
@@ -1220,6 +1221,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	if (refs)
 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
 
+	/*
+	 * Populate transport->got_remote_bundle_uri and
+	 * transport->bundle_uri. We might get nothing.
+	 */
+	transport_get_remote_bundle_uri(transport);
+
 	if (mapped_refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
diff --git a/bundle-uri.c b/bundle-uri.c
index 9827fc5da17..c503ed51ca8 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -26,6 +26,10 @@ static int bundle_uri_config(const char *var, const char *value, void *data)
 
 int bundle_uri_advertise(struct repository *r, struct strbuf *value)
 {
+	if (value &&
+	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
+		strbuf_addstr(value, "test-unknown-capability-value");
+
 	if (advertise_bundle_uri != -1)
 		goto cached;
 
diff --git a/connect.c b/connect.c
index e6d0b1d34bd..a8fdb5255f7 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "protocol.h"
 #include "alias.h"
+#include "bundle-uri.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
@@ -491,6 +492,52 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
 	}
 }
 
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct string_list *bundle_uri, int stateless_rpc)
+{
+	int line_nr = 1;
+
+	/* Assert bundle-uri support */
+	server_supports_v2("bundle-uri", 1);
+
+	/* (Re-)send capabilities */
+	send_capabilities(fd_out, reader);
+
+	/* Send command */
+	packet_write_fmt(fd_out, "command=bundle-uri\n");
+	packet_delim(fd_out);
+
+	/* Send options */
+	if (git_env_bool("GIT_TEST_PROTOCOL_BAD_BUNDLE_URI", 0))
+		packet_write_fmt(fd_out, "test-bad-client\n");
+	packet_flush(fd_out);
+
+	/* Process response from server */
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		const char *line = reader->line;
+		line_nr++;
+
+		if (!bundle_uri_parse_line(bundle_uri, line))
+			continue;
+
+		return error(_("error on bundle-uri response line %d: %s"),
+			     line_nr, line);
+	}
+
+	if (reader->status != PACKET_READ_FLUSH)
+		return error(_("expected flush after bundle-uri listing"));
+
+	/*
+	 * Might die(), but obscure enough that that's OK, e.g. in
+	 * serve.c we'll call BUG() on its equivalent (the
+	 * PACKET_READ_RESPONSE_END check).
+	 */
+	check_stateless_delimiter(stateless_rpc, reader,
+				  _("expected response end packet after ref listing"));
+
+	return 0;
+}
+
 struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     struct ref **list, int for_push,
 			     struct transport_ls_refs_options *transport_options,
diff --git a/remote.h b/remote.h
index 4a1209ae2c8..ca820b60948 100644
--- a/remote.h
+++ b/remote.h
@@ -236,6 +236,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc);
 
+/* Used for protocol v2 in order to retrieve refs from a remote */
+int get_remote_bundle_uri(int fd_out, struct packet_reader *reader,
+			  struct string_list *bundle_uri, int stateless_rpc);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 
 /*
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
new file mode 100644
index 00000000000..724acecda66
--- /dev/null
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -0,0 +1,141 @@
+# Included from t573*-protocol-v2-bundle-uri-*.sh
+
+T5730_PARENT=
+T5730_URI=
+T5730_BUNDLE_URI=
+case "$T5730_PROTOCOL" in
+file)
+	T5730_PARENT=file_parent
+	T5730_URI="file://$PWD/file_parent"
+	T5730_BUNDLE_URI="$T5730_URI/fake.bdl"
+	test_set_prereq T5730_FILE
+	;;
+git)
+	. "$TEST_DIRECTORY"/lib-git-daemon.sh
+	start_git_daemon --export-all --enable=receive-pack
+	T5730_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
+	T5730_URI="$GIT_DAEMON_URL/parent"
+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq T5730_GIT
+	;;
+http)
+	. "$TEST_DIRECTORY"/lib-httpd.sh
+	start_httpd
+	T5730_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
+	T5730_URI="$HTTPD_URL/smart/http_parent"
+	T5730_BUNDLE_URI="https://example.com/fake.bdl"
+	test_set_prereq T5730_HTTP
+	;;
+*)
+	BUG "Need to pass valid T5730_PROTOCOL (was $T5730_PROTOCOL)"
+	;;
+esac
+
+test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
+	git init "$T5730_PARENT" &&
+	test_commit -C "$T5730_PARENT" one
+'
+
+# Poor man's URI escaping. Good enough for the test suite whose trash
+# directory has a space in it. See 93c3fcbe4d4 (git-svn: attempt to
+# mimic SVN 1.7 URL canonicalization, 2012-07-28) for prior art.
+test_uri_escape() {
+	sed 's/ /%20/g'
+}
+
+case "$T5730_PROTOCOL" in
+http)
+	test_expect_success "setup config for $T5730_PROTOCOL:// tests" '
+		git -C "$T5730_PARENT" config http.receivepack true
+	'
+	;;
+*)
+	;;
+esac
+T5730_BUNDLE_URI_ESCAPED=$(echo "$T5730_BUNDLE_URI" | test_uri_escape)
+
+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: no bundle-uri" '
+	test_when_finished "rm -f log" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	! grep bundle-uri log
+'
+
+test_expect_success "connect with $T5730_PROTOCOL:// using protocol v2: have bundle-uri" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	# Server advertised bundle-uri capability
+	grep bundle-uri log
+'
+
+test_expect_success !T5730_HTTP "bad client with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI \
+		"$T5730_BUNDLE_URI_ESCAPED" &&
+
+	cat >err.expect <<-\EOF &&
+	Cloning into '"'"'child'"'"'...
+	EOF
+	case "$T5730_PROTOCOL" in
+	file)
+		cat >fatal-bundle-uri.expect <<-\EOF
+		fatal: bundle-uri: unexpected argument: '"'"'test-bad-client'"'"'
+		EOF
+		;;
+	*)
+		cat >fatal.expect <<-\EOF
+		fatal: read error: Connection reset by peer
+		EOF
+		;;
+	esac &&
+
+	test_when_finished "rm -rf child" &&
+	test_must_fail ok=sigpipe env \
+		GIT_TRACE_PACKET="$PWD/log" \
+		GIT_TEST_PROTOCOL_BAD_BUNDLE_URI=true \
+		git -c protocol.version=2 \
+		clone "$T5730_URI" child \
+		>out 2>err &&
+	test_must_be_empty out &&
+
+	grep -v -e ^fatal: -e ^error: err >err.actual &&
+	test_cmp err.expect err.actual &&
+
+	case "$T5730_PROTOCOL" in
+	file)
+		# Due to general race conditions with client/server replies we
+		# may or may not get "fatal: the remote end hung up
+		# expectedly" here
+		grep "^fatal: bundle-uri:" err >fatal-bundle-uri.actual &&
+		test_cmp fatal-bundle-uri.expect fatal-bundle-uri.actual
+		;;
+	*)
+		grep "^fatal:" err >fatal.actual &&
+		test_cmp fatal.expect fatal.actual
+		;;
+	esac &&
+
+	grep "clone> test-bad-client$" log >sent-bad-request &&
+	test_file_not_empty sent-bad-request
+'
diff --git a/t/t5730-protocol-v2-bundle-uri-file.sh b/t/t5730-protocol-v2-bundle-uri-file.sh
new file mode 100755
index 00000000000..89203d3a23c
--- /dev/null
+++ b/t/t5730-protocol-v2-bundle-uri-file.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'file://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'file://' transport
+#
+T5730_PROTOCOL=file
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_expect_success "unknown capability value with $T5730_PROTOCOL:// using protocol v2" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" \
+		uploadpack.bundleURI "$T5730_BUNDLE_URI_ESCAPED" &&
+
+	GIT_TRACE_PACKET="$PWD/log" \
+	GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE=true \
+	git \
+		-c protocol.version=2 \
+		ls-remote --symref "$T5730_URI" \
+		>actual 2>err &&
+
+	# Server responded using protocol v2
+	grep "< version 2" log &&
+
+	grep "> bundle-uri=test-unknown-capability-value" log
+'
+
+test_done
diff --git a/t/t5731-protocol-v2-bundle-uri-git.sh b/t/t5731-protocol-v2-bundle-uri-git.sh
new file mode 100755
index 00000000000..282847b311f
--- /dev/null
+++ b/t/t5731-protocol-v2-bundle-uri-git.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+T5730_PROTOCOL=git
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_done
diff --git a/t/t5732-protocol-v2-bundle-uri-http.sh b/t/t5732-protocol-v2-bundle-uri-http.sh
new file mode 100755
index 00000000000..fcc1cf3faef
--- /dev/null
+++ b/t/t5732-protocol-v2-bundle-uri-http.sh
@@ -0,0 +1,17 @@
+#!/bin/sh
+
+test_description="Test bundle-uri with protocol v2 and 'git://' transport"
+
+TEST_NO_CREATE_REPO=1
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+# Test protocol v2 with 'git://' transport
+#
+T5730_PROTOCOL=http
+. "$TEST_DIRECTORY"/lib-t5730-protocol-v2-bundle-uri.sh
+
+test_done
diff --git a/transport-helper.c b/transport-helper.c
index a0297b0986c..4ddf2a4be2a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1264,9 +1264,22 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
 	return ret;
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	get_helper(transport);
+
+	if (process_connect(transport, 0)) {
+		do_take_over(transport);
+		return transport->vtable->get_bundle_uri(transport);
+	}
+
+	return -1;
+}
+
 static struct transport_vtable vtable = {
 	.set_option	= set_helper_option,
 	.get_refs_list	= get_refs_list,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs,
 	.push_refs	= push_refs,
 	.connect	= connect_helper,
diff --git a/transport-internal.h b/transport-internal.h
index c4ca0b733ac..90ea749e5cf 100644
--- a/transport-internal.h
+++ b/transport-internal.h
@@ -26,6 +26,13 @@ struct transport_vtable {
 	struct ref *(*get_refs_list)(struct transport *transport, int for_push,
 				     struct transport_ls_refs_options *transport_options);
 
+	/**
+	 * Populates the remote side's bundle-uri under protocol v2,
+	 * if the "bundle-uri" capability was advertised. Returns 0 if
+	 * OK, negative values on error.
+	 */
+	int (*get_bundle_uri)(struct transport *transport);
+
 	/**
 	 * Fetch the objects for the given refs. Note that this gets
 	 * an array, and should ignore the list structure.
diff --git a/transport.c b/transport.c
index 253d6671b1f..7c9a371ed7f 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "bundle-uri.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -349,6 +350,21 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	return handshake(transport, for_push, options, 1);
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	int stateless_rpc = transport->stateless_rpc;
+	string_list_init_dup(&transport->bundle_uri);
+
+	packet_reader_init(&reader, data->fd[0], NULL, 0,
+			   PACKET_READ_CHOMP_NEWLINE |
+			   PACKET_READ_GENTLE_ON_EOF);
+
+	return get_remote_bundle_uri(data->fd[1], &reader,
+				     &transport->bundle_uri, stateless_rpc);
+}
+
 static int fetch_refs_via_pack(struct transport *transport,
 			       int nr_heads, struct ref **to_fetch)
 {
@@ -888,6 +904,7 @@ static int disconnect_git(struct transport *transport)
 
 static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
@@ -1041,6 +1058,7 @@ static struct transport_vtable bundle_vtable = {
 
 static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
@@ -1054,6 +1072,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	ret->progress = isatty(2);
 	string_list_init_dup(&ret->pack_lockfiles);
+	string_list_init_dup(&ret->bundle_uri);
 
 	if (!remote)
 		BUG("No remote provided to transport_get()");
@@ -1462,6 +1481,34 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
 	return rc;
 }
 
+int transport_get_remote_bundle_uri(struct transport *transport)
+{
+	const struct transport_vtable *vtable = transport->vtable;
+
+	/* Lazily configured */
+	if (transport->got_remote_bundle_uri++)
+		return 0;
+
+	/*
+	 * "Support" protocol v0 and v2 without bundle-uri support by
+	 * silently degrading to a NOOP.
+	 */
+	if (!server_supports_v2("bundle-uri", 0))
+		return 0;
+
+	/*
+	 * This is intentionally below the transport.injectBundleURI,
+	 * we want to be able to inject into protocol v0, or into the
+	 * dialog of a server who doesn't support this.
+	 */
+	if (!vtable->get_bundle_uri)
+		return error(_("bundle-uri operation not supported by protocol"));
+
+	if (vtable->get_bundle_uri(transport) < 0)
+		return error(_("could not retrieve server-advertised bundle-uri list"));
+	return 0;
+}
+
 void transport_unlock_pack(struct transport *transport, unsigned int flags)
 {
 	int in_signal_handler = !!(flags & TRANSPORT_UNLOCK_PACK_IN_SIGNAL_HANDLER);
@@ -1492,6 +1539,7 @@ int transport_disconnect(struct transport *transport)
 		ret = transport->vtable->disconnect(transport);
 	if (transport->got_remote_refs)
 		free_refs((void *)transport->remote_refs);
+	bundle_uri_string_list_clear(&transport->bundle_uri);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index a0bc6a1e9eb..7740306b850 100644
--- a/transport.h
+++ b/transport.h
@@ -75,6 +75,18 @@ struct transport {
 	 */
 	unsigned got_remote_refs : 1;
 
+	/**
+	 * Indicates whether we already called get_bundle_uri_list(); set by
+	 * transport.c::transport_get_remote_bundle_uri().
+	 */
+	unsigned got_remote_bundle_uri : 1;
+
+	/*
+	 * The results of "command=bundle-uri", if both sides support
+	 * the "bundle-uri" capability.
+	 */
+	struct string_list bundle_uri;
+
 	/*
 	 * Transports that call take-over destroys the data specific to
 	 * the transport type while doing so, and cannot be reused.
@@ -276,6 +288,12 @@ void transport_ls_refs_options_release(struct transport_ls_refs_options *opts);
 const struct ref *transport_get_remote_refs(struct transport *transport,
 					    struct transport_ls_refs_options *transport_options);
 
+/**
+ * Retrieve bundle URI(s) from a remote. Populates "struct
+ * transport"'s "bundle_uri" and "got_remote_bundle_uri".
+ */
+int transport_get_remote_bundle_uri(struct transport *transport);
+
 /*
  * Fetch the hash algorithm used by a remote.
  *
-- 
2.35.1.1337.g7e32d794afe

