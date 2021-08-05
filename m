Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F284C4320A
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EBFFE60EEA
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241821AbhHEPIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241799AbhHEPHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:55 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F3C061799
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:40 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id k4so7049267wrc.0
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DJBWBNRJ22Ea59m490UARLLFkDsa+NdsEYVAWGP4px0=;
        b=jK/MvXxj8pqMwi+GTwe8RhZ7I0g4T5K2XbSVMJjuNDdiHSgzLbWD/5ZWqlxpd+DR66
         hh7OEn2Oe4nSpotrcJ673kTYug5BNwFcPzt2Exsq0zb5q6YzPNDcr2dHjv1dhZQg62lz
         +EyShORRKQyKmWHC3ksk4NS3Via7/rJ0U8b7t9buFMG7qol4F0Z/B5a/byXmqNkVUblo
         +bkQGp60nOFKlFDA8NoNvAi41jdRlh3yA9oXkGqH4r2gXiurgzPdojSbIVoYLE04dmZr
         nWWEwVamIvIPkPEY/FDIaS+Wb8hsy0bvNdOp9tdjJ8G/qs7FIsKHP4GJE0hqC0mMvBt0
         zmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DJBWBNRJ22Ea59m490UARLLFkDsa+NdsEYVAWGP4px0=;
        b=gQ8wajWU1Kymjn8ZThPOcOuiQhbKaebyo0lUCtJT52QP21YSdX4PW54mJ8HL4IoUuh
         qAFYQOjz1gjI5+FHnkq/Vpu112XgghaieKzIB+O/x7eTZDEnv3L5RJ0NEYQQWz1Rk8Cq
         i1BKIiLorBNzIeQAEruKzFaV31casG4GEccs2VMAJWZ7d/cqn/QvEqGLYKpIOOq9ZDVu
         OgN+TgSgegNkEcSoIdCRz3tDse/JX+cBa8EtfonkQO1IL+09sLnB8B1evWXuBsfzVC6o
         XJjpCvPeQUO4HrvvENq0gkr5ngLAoJnCYD0E446tnaioBDfHLMaZ3MfV18DdzF0sl83J
         V8Og==
X-Gm-Message-State: AOAM530aLnX904sfspkUjAyTK5cnhfd/R6V+xKCtnkx+HLUntK1JKl3q
        IYQ9WFf+sK7uB+f/ugq7eUk2nzJ34yUGSg==
X-Google-Smtp-Source: ABdhPJzSl8PzPVxHyvzzoeAvTZymbRfiDCirhu45qnw/kbKX6/hc1Cpbd44+Wj8qBKJkjo6c9S5/Kg==
X-Received: by 2002:adf:d4c6:: with SMTP id w6mr5866160wrk.353.1628176059213;
        Thu, 05 Aug 2021 08:07:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 04/13] bundle-uri client: add minimal NOOP client
Date:   Thu,  5 Aug 2021 17:07:20 +0200
Message-Id: <RFC-patch-04.13-21caf01775-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
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
 bundle-uri.c                           |  10 +-
 connect.c                              |  47 +++++++++
 remote.h                               |   4 +
 t/lib-t5730-protocol-v2-bundle-uri.sh  | 140 +++++++++++++++++++++++++
 t/t5730-protocol-v2-bundle-uri-file.sh |  36 +++++++
 t/t5731-protocol-v2-bundle-uri-git.sh  |  17 +++
 t/t5732-protocol-v2-bundle-uri-http.sh |  17 +++
 transport-helper.c                     |  13 +++
 transport-internal.h                   |   7 ++
 transport.c                            |  48 +++++++++
 transport.h                            |  18 ++++
 12 files changed, 362 insertions(+), 2 deletions(-)
 create mode 100644 t/lib-t5730-protocol-v2-bundle-uri.sh
 create mode 100755 t/t5730-protocol-v2-bundle-uri-file.sh
 create mode 100755 t/t5731-protocol-v2-bundle-uri-git.sh
 create mode 100755 t/t5732-protocol-v2-bundle-uri-http.sh

diff --git a/builtin/clone.c b/builtin/clone.c
index 66fe66679c..1e4e6be57d 100644
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
@@ -1292,6 +1293,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	refs = transport_get_remote_refs(transport, &transport_ls_refs_options);
 
+	/*
+	 * Populate transport->got_remote_bundle_uri and
+	 * transport->bundle_uri. We might get nothing.
+	 */
+	transport_get_remote_bundle_uri(transport);
+
 	if (refs) {
 		int hash_algo = hash_algo_by_ptr(transport_get_hash_algo(transport));
 
diff --git a/bundle-uri.c b/bundle-uri.c
index d48bb78012..56619bde22 100644
--- a/bundle-uri.c
+++ b/bundle-uri.c
@@ -38,11 +38,16 @@ static int bundle_uri_startup_config(const char *var, const char *value,
 
 int bundle_uri_advertise(struct repository *r, struct strbuf *value)
 {
+	if (value &&
+	    git_env_bool("GIT_TEST_BUNDLE_URI_UNKNOWN_CAPABILITY_VALUE", 0))
+		strbuf_addstr(value, "test-unknown-capability-value");
+
 	if (advertise_bundle_uri == -1) {
 		git_config(bundle_uri_startup_config, NULL);
 		if (advertise_bundle_uri == -1)
 			advertise_bundle_uri = 0;
 	}
+
 	return advertise_bundle_uri;
 }
 
@@ -53,9 +58,10 @@ int bundle_uri_command(struct repository *r,
 	packet_writer_init(&writer, 1);
 
 	while (packet_reader_read(request) == PACKET_READ_NORMAL)
-		die("bundle-uri: unexpected argument: '%s'", request->line);
+		die(_("bundle-uri: unexpected argument: '%s'"), request->line);
+
 	if (request->status != PACKET_READ_FLUSH)
-		die("bundle-uri: expected flush after arguments");
+		die(_("bundle-uri: expected flush after arguments"));
 
 	send_bundle_uris(&writer, &bundle_uris);
 
diff --git a/connect.c b/connect.c
index 18dfeae2b8..c7601ffd83 100644
--- a/connect.c
+++ b/connect.c
@@ -15,6 +15,7 @@
 #include "version.h"
 #include "protocol.h"
 #include "alias.h"
+#include "bundle-uri.h"
 
 static char *server_capabilities_v1;
 static struct strvec server_capabilities_v2 = STRVEC_INIT;
@@ -489,6 +490,52 @@ static void send_capabilities(int fd_out, struct packet_reader *reader)
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
index 5a59198252..a0823fe4e9 100644
--- a/remote.h
+++ b/remote.h
@@ -202,6 +202,10 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
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
index 0000000000..6bd9d2dcfb
--- /dev/null
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -0,0 +1,140 @@
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
index 0000000000..89203d3a23
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
index 0000000000..282847b311
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
index 0000000000..fcc1cf3fae
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
index e8dbdd1153..aff27bcf78 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1260,9 +1260,22 @@ static struct ref *get_refs_list_using_list(struct transport *transport,
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
index c4ca0b733a..90ea749e5c 100644
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
index f9400b9b0b..444cf74756 100644
--- a/transport.c
+++ b/transport.c
@@ -22,6 +22,7 @@
 #include "protocol.h"
 #include "object-store.h"
 #include "color.h"
+#include "bundle-uri.h"
 
 static int transport_use_color = -1;
 static char transport_colors[][COLOR_MAXLEN] = {
@@ -345,6 +346,21 @@ static struct ref *get_refs_via_connect(struct transport *transport, int for_pus
 	return handshake(transport, for_push, options, 1);
 }
 
+static int get_bundle_uri(struct transport *transport)
+{
+	struct git_transport_data *data = transport->data;
+	struct packet_reader reader;
+	int stateless_rpc = transport->stateless_rpc;
+	string_list_init(&transport->bundle_uri, 1);
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
@@ -884,6 +900,7 @@ static int disconnect_git(struct transport *transport)
 
 static struct transport_vtable taken_over_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.disconnect	= disconnect_git
@@ -1037,6 +1054,7 @@ static struct transport_vtable bundle_vtable = {
 
 static struct transport_vtable builtin_smart_vtable = {
 	.get_refs_list	= get_refs_via_connect,
+	.get_bundle_uri = get_bundle_uri,
 	.fetch_refs	= fetch_refs_via_pack,
 	.push_refs	= git_transport_push,
 	.connect	= connect_git,
@@ -1050,6 +1068,7 @@ struct transport *transport_get(struct remote *remote, const char *url)
 
 	ret->progress = isatty(2);
 	string_list_init_dup(&ret->pack_lockfiles);
+	string_list_init_dup(&ret->bundle_uri);
 
 	if (!remote)
 		BUG("No remote provided to transport_get()");
@@ -1453,6 +1472,34 @@ int transport_fetch_refs(struct transport *transport, struct ref *refs)
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
 void transport_unlock_pack(struct transport *transport)
 {
 	int i;
@@ -1478,6 +1525,7 @@ int transport_disconnect(struct transport *transport)
 		ret = transport->vtable->disconnect(transport);
 	if (transport->got_remote_refs)
 		free_refs((void *)transport->remote_refs);
+	bundle_uri_string_list_clear(&transport->bundle_uri);
 	free(transport);
 	return ret;
 }
diff --git a/transport.h b/transport.h
index 1cbab11373..fb9f89f956 100644
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
@@ -270,6 +282,12 @@ struct transport_ls_refs_options {
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
2.33.0.rc0.646.g585563e77f

