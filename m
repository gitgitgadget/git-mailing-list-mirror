Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5B55C432BE
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5FB6104F
	for <git@archiver.kernel.org>; Thu,  5 Aug 2021 15:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241797AbhHEPHx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Aug 2021 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241788AbhHEPHx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Aug 2021 11:07:53 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAD6C061765
        for <git@vger.kernel.org>; Thu,  5 Aug 2021 08:07:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h14so6982311wrx.10
        for <git@vger.kernel.org>; Thu, 05 Aug 2021 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=op9PMwrZGHenow0iKHSaxGmGiBEb30e6FhbfZYWo6S8=;
        b=MBCEQs4BSt4/krPkX/3Rf5jwOS5YQyT1CMIXtBzivoRY+uTnXEMEqtBQrHEWvGHb8t
         oTYHkjGr2XlhYOpEqEfw4NLyvVdPRkc0X2SPneL1HZVEA43XTOWtVd5Ch3u2VnS5jE0K
         qOCCidiINECn79c0+WtE8RVF4H99jyeWiJFxhVfUYXDPFwGf6lLw/hp7kgkC/gRrGiaG
         Husk6RV1Xmd+ZZXT6Jvr3rd63U8wlwnhVzOJRIcj/2c7IFO6v+51aaNOddIwXiKWjbuS
         lBF7ZmzkMyBW4Q8S6M0caCiJ3aeXRCK/aSOHOCwflsgHPhY8mZ+O/+TCbhSeSJohA6UL
         uUGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=op9PMwrZGHenow0iKHSaxGmGiBEb30e6FhbfZYWo6S8=;
        b=gt92rqenDu+5HlmKO6O5cA8YHVTUFa0mqzuEBaKq4+wr6VS7j8GmwluDLOA/IlbzIh
         ljT44acyFZXY3nsx1tM3itzsVOI7UMEUQLpz1ik+JyiTpuWxGnh0jzcPyGkJjJMJ37XP
         xiOfWd0s8xDs6RO2JqTq1nR2HyufrvD6oybhstYdpA79XVH7xoyP1K9RTCuS6MwQKkYj
         H4R8UJwp+swa0cqYMUlkTyeif1osu02syNw3m/cDpJBHnTHrjxGEldfqg8nbafbgCiJD
         V/PmIi8cw7Tqb9HxxO13ZUdbzphAEM49LD8dTzD5wCAi0AU+mONO0HPo7+lgE9qxyiD7
         lF7g==
X-Gm-Message-State: AOAM533DHQbvhBeHkyT24KVyCd1OeX7sNMQhlV7eQkMBJyOe4GDcCCsR
        teDqkR4TUnTXVJyGrT9XCBZInUYMdzzxrA==
X-Google-Smtp-Source: ABdhPJzTUdtSwn5iT8tbX4RSWuEWBhI6VUgKeX6EAo5ZQx2g+pSXgOssjoByTwtn9eleTsf6C28KJA==
X-Received: by 2002:adf:dfcb:: with SMTP id q11mr5895565wrn.16.1628176056716;
        Thu, 05 Aug 2021 08:07:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w4sm6856340wrm.24.2021.08.05.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 08:07:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>,
        Albert Cui <albertqcui@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 01/13] serve: add command to advertise bundle URIs
Date:   Thu,  5 Aug 2021 17:07:17 +0200
Message-Id: <RFC-patch-01.13-4e1a0dbef5-20210805T150534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.646.g585563e77f
In-Reply-To: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
References: <RFC-cover-00.13-0000000000-20210805T150534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the uploadpack.bundleURI config is set to a URI (or URIs, if set
>1 times), advertise a "bundle-uri" command, then when the client
requests "bundle-uri" emit those URIs back at them.

The client CAN then request those URIs out of bounds, and after
they've done (after either disconnecting & coming back, or leaving us
hanging), proceed with the rest of request flow. I.e. issuing a
"ls-refs" followed by a "fetch". The client MAY then send us "have"
lines with the tips they've unpacked from their newly acquired
bundle(s).

This commit doesn't implement any of that required client behavior,
only the trivial server behavior of spewing a list of URLs at the
client on request.

There is already a uploadpack.blobPackfileUri setting for the server,
so why is this needed? The Documentation/technical/bundle-uri.txt
added in a preceding commit discusses that in more detail, but in
summary:

 1. There is no "real" support for in git.git. The
    uploadpack.blobPackfileUri setting allows carving out a list of
    blobs (actually any OIDs), but as alluded to in bfc2a36ff2a (Doc:
    clarify contents of packfile sent as URI, 2021-01-20) the only
    "real" implementation is JGit based.

 2. The uploadpack.blobPackfileUri is a MUST where this is a
    "CAN". I.e. once a client says they support packfile-uri of given
    list of protocols the server will send them a PACK response
    assuming they've downloaded the URI they client was sent, if the
    client doesn't do that they don't have a valid repository.

    Pointing at a bundle and having the client send us "have"
    lines (or not, maybe they couldn't fetch it, or decided they
    didn't want to) is more flexible, and can gracefully recover
    e.g. if the CDN isn't reachable (maybe you do support "https", but
    the CDN provider is down, or blocked your whole country).

 3. Because of the disconnect in #2 "dumb" servers can seed
    pre-clients, e.g. we might point to a repo.bundle whose exact
    state we aren't sure of (a cronjob updates it, sometimes). The
    client will discover its contents, and give us the "have" lines,
    the "packfile-uri" method effectively requires the server to have
    those exact "have" lines (or rather, it will produce a similar
    PACK using give-or-take the same exclusions).

 4. This provides an easy way to the long sought after "resumable
    clones". I.e. since we can assume that it's in the server's
    interest to keep their bundle(s) as up-to-date as possible, most
    or all of the history we need to fetch will be in the bundle. If
    we fail midway through the "clone" we can offload the problem of
    resuming to wget/curl/rsync/whatever, instead of (as has been
    suggested, but not implemented for the "normal" dialog)
    "repairing" a partial PACK response or something.

There was a suggestion of implementing a similar feature long ago[1]
by Jeff King. The main difference between it and this approach is that
we've since gained protocol v2, so we can add this as an optional path
in the dialog between client and server. The 2011 implementation
hooked into the transport mechanism to try to clone from a bundle
directly. See also [2] and [3] for some later mentions of that
approach.

See also [4] for the series that implemented
uploadpack.blobPackfileUri, and [5] for a series on top that did the
.gitmodules check in that context. See [6] for the "ls-refs unborn"
feature which modified code in similar areas of the request flow.

1. https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/
2. https://lore.kernel.org/git/20190514092900.GA11679@sigill.intra.peff.net/
3. https://lore.kernel.org/git/YFJWz5yIGng+a16k@coredump.intra.peff.net/
4. https://lore.kernel.org/git/cover.1591821067.git.jonathantanmy@google.com/
   Merged as 34e849b05a4 (Merge branch 'jt/cdn-offload', 2020-06-25)
5. https://lore.kernel.org/git/cover.1614021092.git.jonathantanmy@google.com/
   Merged as 6ee353d42f3 (Merge branch 'jt/transfer-fsck-across-packs',
   2021-03-01)
6. 69571dfe219 (Merge branch 'jt/clone-unborn-head', 2021-02-17)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/protocol-v2.txt | 140 ++++++++++++++++++++++++
 Makefile                                |   1 +
 bundle-uri.c                            |  65 +++++++++++
 bundle-uri.h                            |  14 +++
 serve.c                                 |   6 +
 t/t5701-git-serve.sh                    | 124 ++++++++++++++++++++-
 6 files changed, 349 insertions(+), 1 deletion(-)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 213538f1d0..d10d5e9ef6 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -556,3 +556,143 @@ and associated requested information, each separated by a single space.
 	attr = "size"
 
 	obj-info = obj-id SP obj-size
+
+bundle-uri
+~~~~~~~~~~
+
+If the 'bundle-uri' capability is advertised, the server supports the
+`bundle-uri' command.
+
+The capability is currently advertised with no value (i.e. not
+"bundle-uri=somevalue"), a value may be added in the future for
+supporting command-wide extensions. Clients MUST ignore any unknown
+capability values and proceed with the 'bundle-uri` dialog they
+support.
+
+The 'bundle-uri' command is intended to be issued before `fetch` to
+get URIs to bundle files (see linkgit:git-bundle[1]) to "seed" and
+inform the subsequent `fetch` command.
+
+The client CAN issue `bundle-uri` before or after any other valid
+command. It's expected that it'll be issued after an `ls-refs` and
+before `fetch`.
+
+DISCUSSION of bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^^
+
+The intent of the feature is optimize for server resource consumption
+in the common case by changing the common case of fetching a very
+large PACK during linkgit:git-clone[1] into a smaller incremental
+fetch.
+
+It also allows servers to achieve better caching in combination with
+an `uploadpack.packObjectsHook` (see linkgit:git-config[1]).
+
+By having new clones or fetches be a more predictable and common
+negotiation against the tips of recently produces *.bundle file(s).
+Servers might even pre-generate the results of such negotiations for
+the `uploadpack.packObjectsHook` as new pushes come in.
+
+I.e. the server would anticipate that fresh clones will download a
+known bundle, followed by catching up to the current state of the
+repository using ref tips found in that bundle (or bundles).
+
+PROTOCOL for bundle-uri
+^^^^^^^^^^^^^^^^^^^^^^^
+
+A `bundle-uri` request takes no arguments, and as noted above does not
+currently advertise a capability value. Both may be added in the
+future.
+
+When the client issues a `command=bundle-uri` the response is a list
+of URIs the server would like the client to fetch out-of-bounds before
+proceeding with the `fetch` request in this format:
+
+	output = bundle-uri-line
+		 bundle-uri-line* flush-pkt
+
+	bundle-uri-line = PKT-LINE(bundle-uri)
+			  *(SP bundle-feature-key *(=bundle-feature-val))
+			  LF
+
+	bundle-uri = A URI such as a https://, ssh:// etc. URI
+
+	bundle-feature-key = Any printable ASCII characters except SP or "="
+	bundle-feature-val = Any printable ASCII characters except SP or "="
+
+No `bundle-feature-key`=`bundle-feature-value` fields are currently
+defined. See the discussion of features below.
+
+bundle-uri CLIENT AND SERVER EXPECTATIONS
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+The advertised bundles MUST contain one or more reference tips for use
+by the client. Bundles that are not self-contained MUST use the
+standard "-" prefixes in the bundle format to indicate their
+prerequisites. I.e. they must be in the standard format "git bundle
+create" would create.
+
+If after an `ls-refs` the client finds that the ref tips it wants can
+be retrieved entirety from advertised bundle(s), it MAY
+disconnect. The results of such a "clone" or "fetch" should be
+indistinguishable from the state attained without using bundle-uri.
+
+The client MAY also keep the connection open pending download of the
+bundle-uris, e.g. should on or more downloads (or their validation)
+fail.
+
+The client MAY provide reference tips found in the bundle(s) to be
+downloaded out-of-bounds as `have` lines in the `fetch` request. They
+MAY also ignore the bundle(s) entirely (e.g. if they can't be
+downloaded) or some combination of the two.
+
+For the convenience of clients bundles SHOULD be provided in the order
+that they must be unpacked in if processed one-at-a-time by a dumber client.
+
+That usually means a "big bundle" first with most of the history
+that's self-contained, optionally followed by incremental updates on
+that "big bundle".
+
+This ordering is a mere convention and not a MUST, e.g. a repository
+with N branches with disconnected histories might have N "big
+bundles", each with their own self-contained history. A server might
+also only provide "incremental updates".
+
+A client MUST consider the content of the bundles themselves and their
+header as the ultimate source of truth. Servers MAY be tolerant of
+simpler clients by using the convention outlined above.
+
+As noted before a client MUST gracefully degrade on errors, whether
+that error is because of bad missing/data in the bundle URI(s), or
+because that client is too dumb to e.g. understand and fully parse out
+bundle headers and their prerequisite relationships.
+
+bundle-uri PROTOCOL FEATURES
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+As noted above no `bundle-feature-key`=`bundle-feature-value` fields
+are currently defined.
+
+They are intended for future per-URI metadata which older clients MUST
+ignore and gracefully degrade on. Any fields they do recognize they
+CAN also ignore.
+
+Any backwards-incompatible addition of pre-URI key-value will be
+guarded by a new value or values in 'bundle-uri' capability
+advertisement itself, and/or by new future `bundle-uri` request
+arguments.
+
+While no per-URI key-value are currently supported currently they're
+intended to support future features such as:
+
+ * Add a "hash=<val>" or "size=<bytes>" advertise the expected hash or
+   size of the bundle file.
+
+ * Advertise that one or more bundle files are the same (to e.g. have
+   clients round-robin or otherwise choose one of N possible files).
+
+ * A "tip=<OID>" shortcut. A client who'd have the advertised <OID>
+   would know there was no need to download the relevant bundle(s),
+   they've got that OID already (for multi-tips the client would need
+   to fetch the bundle, or do e.g. HTTP range requests to get its
+   header).
diff --git a/Makefile b/Makefile
index 9573190f1d..877c6c47b6 100644
--- a/Makefile
+++ b/Makefile
@@ -850,6 +850,7 @@ LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
+LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += cbtree.o
diff --git a/bundle-uri.c b/bundle-uri.c
new file mode 100644
index 0000000000..2d93e8b003
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,65 @@
+#include "cache.h"
+#include "bundle-uri.h"
+#include "pkt-line.h"
+#include "config.h"
+
+/**
+ * serve.[ch] API.
+ */
+
+/*
+ * "uploadpack.bundleURI" is advertised only if there's URIs to serve
+ * up per the config.
+ */
+static int advertise_bundle_uri = -1;
+
+static void send_bundle_uris(struct packet_writer *writer,
+			     struct string_list *uris)
+{
+	struct string_list_item *item;
+	for_each_string_list_item(item, uris) {
+		const char *uri = item->string;
+
+		packet_writer_write(writer, "%s", uri);
+	}
+}
+
+static struct string_list bundle_uris = STRING_LIST_INIT_DUP;
+
+static int bundle_uri_startup_config(const char *var, const char *value,
+				     void *data)
+{
+	if (!strcmp(var, "uploadpack.bundleuri")) {
+		advertise_bundle_uri = 1;
+		string_list_append(&bundle_uris, value);
+	}
+	return 0;
+}
+
+int bundle_uri_advertise(struct repository *r, struct strbuf *value)
+{
+	if (advertise_bundle_uri == -1) {
+		git_config(bundle_uri_startup_config, NULL);
+		if (advertise_bundle_uri == -1)
+			advertise_bundle_uri = 0;
+	}
+	return advertise_bundle_uri;
+}
+
+int bundle_uri_command(struct repository *r,
+		       struct packet_reader *request)
+{
+	struct packet_writer writer;
+	packet_writer_init(&writer, 1);
+
+	while (packet_reader_read(request) == PACKET_READ_NORMAL)
+		die("bundle-uri: unexpected argument: '%s'", request->line);
+	if (request->status != PACKET_READ_FLUSH)
+		die("bundle-uri: expected flush after arguments");
+
+	send_bundle_uris(&writer, &bundle_uris);
+
+	packet_writer_flush(&writer);
+
+	return 0;
+}
diff --git a/bundle-uri.h b/bundle-uri.h
new file mode 100644
index 0000000000..6a40efeb39
--- /dev/null
+++ b/bundle-uri.h
@@ -0,0 +1,14 @@
+#ifndef BUNDLE_URI_H
+#define BUNDLE_URI_H
+
+struct repository;
+struct packet_reader;
+struct packet_writer;
+
+/**
+ * serve.[ch] API.
+ */
+int bundle_uri_advertise(struct repository *r, struct strbuf *value);
+int bundle_uri_command(struct repository *r, struct packet_reader *request);
+
+#endif /* BUNDLE_URI_H */
diff --git a/serve.c b/serve.c
index 1817edc7f5..789bf5fc38 100644
--- a/serve.c
+++ b/serve.c
@@ -8,6 +8,7 @@
 #include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
+#include "bundle-uri.h"
 
 static int advertise_sid = -1;
 
@@ -104,6 +105,11 @@ static struct protocol_capability capabilities[] = {
 		.advertise = always_advertise,
 		.command = cap_object_info,
 	},
+	{
+		.name = "bundle-uri",
+		.advertise = bundle_uri_advertise,
+		.command = bundle_uri_command,
+	},
 };
 
 void protocol_v2_advertise_capabilities(void)
diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
index 930721f053..21d5314d83 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -12,7 +12,7 @@ test_expect_success 'test capability advertisement' '
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
-	cat >expect <<-EOF &&
+	cat >expect.base <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs=unborn
@@ -20,8 +20,11 @@ test_expect_success 'test capability advertisement' '
 	server-option
 	object-format=$(test_oid algo)
 	object-info
+	EOF
+	cat >expect.trailer <<-EOF &&
 	0000
 	EOF
+	cat expect.base expect.trailer >expect &&
 
 	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
 		--advertise-capabilities >out &&
@@ -266,4 +269,123 @@ test_expect_success 'basics of object-info' '
 	test_cmp expect actual
 '
 
+# Test the basics of bundle-uri
+#
+test_expect_success 'test capability advertisement with uploadpack.bundleURI' '
+	test_config uploadpack.bundleURI FAKE &&
+
+	cat >expect.extra <<-EOF &&
+	bundle-uri
+	EOF
+	cat expect.base \
+	    expect.extra \
+	    expect.trailer >expect &&
+
+	GIT_TEST_SIDEBAND_ALL=0 test-tool serve-v2 \
+		--advertise-capabilities >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: dies if not enabled' '
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	0000
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	cat >expect <<-\EOF &&
+	ERR serve: invalid command '"'"'bundle-uri'"'"'
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out
+'
+
+
+test_expect_success 'basics of bundle-uri: enabled with single URI' '
+	test_config uploadpack.bundleURI https://cdn.example.com/repo.bdl &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	object-format=$(test_oid algo)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	https://cdn.example.com/repo.bdl
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: enabled with single URI' '
+	test_config uploadpack.bundleURI https://cdn.example.com/repo.bdl &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	object-format=$(test_oid algo)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	https://cdn.example.com/repo.bdl
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: enabled with two URIs' '
+	test_config uploadpack.bundleURI https://cdn.example.com/repo.bdl &&
+	test_config uploadpack.bundleURI https://cdn.example.com/recent.bdl --add &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	object-format=$(test_oid algo)
+	0000
+	EOF
+
+	cat >expect <<-EOF &&
+	https://cdn.example.com/repo.bdl
+	https://cdn.example.com/recent.bdl
+	0000
+	EOF
+
+	test-tool serve-v2 --stateless-rpc <in >out &&
+	test-tool pkt-line unpack <out >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'basics of bundle-uri: unknown future feature(s)' '
+	test_config uploadpack.bundleURI https://cdn.example.com/fake.bdl &&
+
+	test-tool pkt-line pack >in <<-EOF &&
+	command=bundle-uri
+	object-format=$(test_oid algo)
+	0001
+	some-feature
+	we-do-not
+	know=about
+	0000
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: bundle-uri: unexpected argument: '"'"'some-feature'"'"'
+	EOF
+
+	test_must_fail test-tool serve-v2 --stateless-rpc <in >out 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out
+'
+
 test_done
-- 
2.33.0.rc0.646.g585563e77f

