Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E7C433FE
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 17:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347013AbiDRR1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 13:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347038AbiDRR1G (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 13:27:06 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747A33E3E
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id b19so19266732wrh.11
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 10:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=35q45BKPP89o8jW0QCI96ixI0vzFCB83+K/slwmIoAY=;
        b=dQvePalFHyc8G3wrIT0u5erBMaK5KiH7BtfyDFd61yfufMjgnEO70paEI6+iGUDFFr
         DW+MXf3LWf84Xrcum96yDGUqeVxRu1/v9bvb5VwNbg5tvdm3HwoD/19mlBLhl71mfeId
         8N8UZl0XW/WUKkOGGWz5Y6jIljZTPdVVRMLfLwdOTCSqHjzY4OQaTTWV/aPpee7xhUSF
         MbL9u752j5DiSa8ybDZmiKCrP7BPI0sUCzRnEHU5zqKOdBJbfzVkkCS2I+2ibnZQT8tF
         aECauySqoVOfCJF+LoozwgztOOziJBFrtXmxRADoAHzd8P6jr6HqxfKmHkef4MS0iL3B
         KLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=35q45BKPP89o8jW0QCI96ixI0vzFCB83+K/slwmIoAY=;
        b=cIL3WHekO9REVW3BbskT5iJu8svz1L3XHNwlH7WG8FsmYF45RtKlryQqxezkJB3a4z
         Ije+04ZI7iUIcqvnjP5RCDmGq+G5fqjnS8xF6Coyfv3oV9fhKfRCPq+5vDxL37Nr1I8q
         nQg8imdSWrZIHuIFIQZWPO9cVX7IO33VtSPvBzwFX/aAAfUH/lP1EZAiOsJKHzyo1415
         9MrP972kZVBp35MFToJrzPx1lfvkm5/DeBrGYn0fJpv2TF+E6gdi5rywItj1eNH+JWVf
         qcf6N7J2+U4j5dWFkVLTCOG6fkQXgSFDbO15RI0phphm0FH/hOu82WfH6dcikmVqKHqL
         bCdQ==
X-Gm-Message-State: AOAM533Jr581HFJ1LIRuNrieCIryMibiePy8Es6UuyIEt3NGXsOVBMSR
        urJxiJ9PUb+wnRg1t+QYTRnfRd41yr0N0A==
X-Google-Smtp-Source: ABdhPJyg5wI4OohuN5pCGYkFASStpA9sZ4TKeFpzoI31Bx5N38C5VPfhO14w76pJBfM1XZCOsQdCsA==
X-Received: by 2002:a5d:6208:0:b0:203:dde4:c76e with SMTP id y8-20020a5d6208000000b00203dde4c76emr8729219wru.273.1650302649450;
        Mon, 18 Apr 2022 10:24:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m20-20020a05600c3b1400b0038ebbbb2ad2sm16803066wms.44.2022.04.18.10.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 10:24:08 -0700 (PDT)
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
Subject: [RFC PATCH v2 09/36] protocol v2: add server-side "bundle-uri" skeleton
Date:   Mon, 18 Apr 2022 19:23:26 +0200
Message-Id: <RFC-patch-v2-09.36-1496b89ea6a-20220418T165545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
References: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com> <RFC-cover-v2-00.36-00000000000-20220418T165545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a skeleton server-side implementation of a new "bundle-uri"
command to protocol v2. This will allow conforming clients to
optionally seed their initial clones or incremental fetches from URLs
containing "*.bundle" files created with "git bundle create".

The use-cases are similar to those of the existing "Packfile URIs",
and the two feature can be combined within a single request, but
"bundle-uri" has a few advantages over packfile-uris in some some
common scenarios, discussed below.

This change does not give us a working "bundle-uri" client, subsequent
commits will do that. Let's first establish what the protocol for this
should be like first. The client implementation will then implement
this specification.

With this change when the uploadpack.bundleURI config is set to a
URI (or URIs, if set >1 times), advertise a "bundle-uri" command. Then
when the client requests "bundle-uri" emit those URIs back at them.

Differences between this and the existing packfile-uri facility:

 A. There is no "real" support for packfile-uri in git.git. The
    uploadpack.blobPackfileUri setting allows carving out a list of
    blobs (actually any OIDs), but as alluded to in bfc2a36ff2a (Doc:
    clarify contents of packfile sent as URI, 2021-01-20) the only
    "real" implementation is JGit based.

 B. The uploadpack.blobPackfileUri is a MUST where this is a
    "CAN". I.e. once a client says they support packfile-uri of given
    list of protocols the server will send them a PACK response
    assuming they've downloaded the URI they client was sent, if the
    client doesn't do that they don't have a valid repository.

    Pointing at a bundle and having the client send us "have"
    lines (or not, maybe they couldn't fetch it, or decided they
    didn't want to) is more flexible, and can gracefully recover
    e.g. if the CDN isn't reachable (maybe you do support "https", but
    the CDN provider is down, or blocked your whole country).

 C. The client, after executing "ls-refs" will disconnect if it has
    also grabbed the "bundle-uris" and knows the server won't send it
    anything it doesn't already have (or expect to have, if it's
    downloading the bundles concurrent to an early disconnect).

    This is in (small) contrast to packfile-uri where a client would
    enter a negotiation dialog, which may or may not result in a
    packfile-uri and/or an inline PACK.

 D. Because of "C" clients can, if the bundles are up-to-date, get an
    up-to-date repository with just "bundle-uri" and "ls-refs" commands,
    with no need to enter a dialog with "git upload-pack".

    That small dialog is unlikely to matter for performance purposes,
    this section is just noting differences between "bundle-uri" and
    "packfile-uri".

As noted above the features are compatible, a client that supports
"bundle-uri" and "packfile-uri" might download a bundle, and then
proceed with a "fetch" dialog, that dialog might then result in
"packfile-uri" response.

In practice server operators are unlikely to want to mix the two,
since the main benefit of either approach is the ability to offload
large "clone" responses to CDNs. A server operator would have little
reason not to go with one approach or the other.

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

Finally, there's currently a concurrent (submitted after the v1 of
this commit, but before the subsequent client parts of this
implementation) RFC of a somewhat similar "bundle-uri" facility at
[7].

1. https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/
2. https://lore.kernel.org/git/20190514092900.GA11679@sigill.intra.peff.net/
3. https://lore.kernel.org/git/YFJWz5yIGng+a16k@coredump.intra.peff.net/
4. https://lore.kernel.org/git/cover.1591821067.git.jonathantanmy@google.com/
   Merged as 34e849b05a4 (Merge branch 'jt/cdn-offload', 2020-06-25)
5. https://lore.kernel.org/git/cover.1614021092.git.jonathantanmy@google.com/
   Merged as 6ee353d42f3 (Merge branch 'jt/transfer-fsck-across-packs',
   2021-03-01)
6. 69571dfe219 (Merge branch 'jt/clone-unborn-head', 2021-02-17)
7. https://lore.kernel.org/git/pull.1160.git.1645641063.gitgitgadget@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile             |   1 +
 bundle-uri.c         |  55 +++++++++++++++++++
 bundle-uri.h         |  13 +++++
 serve.c              |   6 +++
 t/t5701-git-serve.sh | 124 ++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 198 insertions(+), 1 deletion(-)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Makefile b/Makefile
index f8bccfab5e9..8f27310836d 100644
--- a/Makefile
+++ b/Makefile
@@ -887,6 +887,7 @@ LIB_OBJS += blob.o
 LIB_OBJS += bloom.o
 LIB_OBJS += branch.o
 LIB_OBJS += bulk-checkin.o
+LIB_OBJS += bundle-uri.o
 LIB_OBJS += bundle.o
 LIB_OBJS += cache-tree.o
 LIB_OBJS += cbtree.o
diff --git a/bundle-uri.c b/bundle-uri.c
new file mode 100644
index 00000000000..ff054ddc690
--- /dev/null
+++ b/bundle-uri.c
@@ -0,0 +1,55 @@
+#include "cache.h"
+#include "bundle-uri.h"
+#include "pkt-line.h"
+#include "config.h"
+
+static void send_bundle_uris(struct packet_writer *writer,
+			     struct string_list *uris)
+{
+	struct string_list_item *item;
+
+	for_each_string_list_item(item, uris)
+		packet_writer_write(writer, "%s", item->string);
+}
+
+static int advertise_bundle_uri = -1;
+static struct string_list bundle_uris = STRING_LIST_INIT_DUP;
+static int bundle_uri_config(const char *var, const char *value, void *data)
+{
+	if (!strcmp(var, "uploadpack.bundleuri")) {
+		advertise_bundle_uri = 1;
+		string_list_append(&bundle_uris, value);
+	}
+
+	return 0;
+}
+
+int bundle_uri_advertise(struct repository *r, struct strbuf *value)
+{
+	if (advertise_bundle_uri != -1)
+		goto cached;
+
+	git_config(bundle_uri_config, NULL);
+	advertise_bundle_uri = !!bundle_uris.nr;
+
+cached:
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
+		die(_("bundle-uri: unexpected argument: '%s'"), request->line);
+	if (request->status != PACKET_READ_FLUSH)
+		die(_("bundle-uri: expected flush after arguments"));
+
+	send_bundle_uris(&writer, &bundle_uris);
+
+	packet_writer_flush(&writer);
+
+	return 0;
+}
diff --git a/bundle-uri.h b/bundle-uri.h
new file mode 100644
index 00000000000..5a7e556a0ba
--- /dev/null
+++ b/bundle-uri.h
@@ -0,0 +1,13 @@
+#ifndef BUNDLE_URI_H
+#define BUNDLE_URI_H
+#include "repository.h"
+#include "pkt-line.h"
+#include "strbuf.h"
+
+/**
+ * API used by serve.[ch].
+ */
+int bundle_uri_advertise(struct repository *r, struct strbuf *value);
+int bundle_uri_command(struct repository *r, struct packet_reader *request);
+
+#endif /* BUNDLE_URI_H */
diff --git a/serve.c b/serve.c
index b3fe9b5126a..f3e0203d2c6 100644
--- a/serve.c
+++ b/serve.c
@@ -8,6 +8,7 @@
 #include "protocol-caps.h"
 #include "serve.h"
 #include "upload-pack.h"
+#include "bundle-uri.h"
 
 static int advertise_sid = -1;
 static int client_hash_algo = GIT_HASH_SHA1;
@@ -136,6 +137,11 @@ static struct protocol_capability capabilities[] = {
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
index 1896f671cb3..9d053f77a93 100755
--- a/t/t5701-git-serve.sh
+++ b/t/t5701-git-serve.sh
@@ -13,7 +13,7 @@ test_expect_success 'test capability advertisement' '
 	wrong_algo sha1:sha256
 	wrong_algo sha256:sha1
 	EOF
-	cat >expect <<-EOF &&
+	cat >expect.base <<-EOF &&
 	version 2
 	agent=git/$(git version | cut -d" " -f3)
 	ls-refs=unborn
@@ -21,8 +21,11 @@ test_expect_success 'test capability advertisement' '
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
@@ -342,4 +345,123 @@ test_expect_success 'basics of object-info' '
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
2.36.0.rc2.902.g60576bbc845

