Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AF6C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:24:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350273AbiCKQZt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:25:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350250AbiCKQZi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:38 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD73107D02
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:33 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id i8so13720232wrr.8
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqxJNJYD78ta3kVwBh7gAzBuMvN0MJDx+7M+5V/Ljoo=;
        b=SiIRuxzDP9jGFHrJWbicXyO6u/jpghH4zIJpz5TWzSiD4RGMO4PauX3KYBdgKsOSTo
         KCVAneZW6KoAY4wTuVI4IgTenJeKqERKsCka8jrwe+QQrWbQm8ByHH8Pj2RoPvh2F/oZ
         RRUZYnVCLn6+pRFVatkB6Ff5hCz+vmVlCzsx5PBoOaa0cEfjUhdz2SgiPbpWviW85CJt
         BTaS1XWqlz2pzQPfQvuZDMFgxzve9nu8Wjh1RpVv93ugHwp7r2RoX76FXWScryCBwBgL
         QRyvHLBs2ckh28v2scHj3iJTnsboXIHrXhMDKKuRYfw1Ut4XfwyABTBUt1M13YTN480Q
         FmLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqxJNJYD78ta3kVwBh7gAzBuMvN0MJDx+7M+5V/Ljoo=;
        b=cf8vRqq3IywHMn6rPGUjM7ILhcUzL25tg2NAvRJoLcSdmCRxdKwZgw9R65khlAbAk3
         96PuQOxbFTFMg7AjTRuhWtKHjcW9v9YsA+3oj7HVK5Wtkm36FbpsnOw1XZwgjEhuIvdG
         JXC2sMCIKIFxQuaoZrCft5XRqyf4U7MstoEU8LiOkCf6Zn3TcAK0vhjDr0s4JjdYX7qF
         alMMMmA/xf96dhHh7XdHxHwLZX667COA8beVM+taidtqK7BDLMGXe/gDFCVwqxxgQW0q
         e2AyQ7hjEq2LNbEqqyknXna7/oYvThABN0aDUm9/P0wWTtV2+K/FXtp3cvZeDb0Czlmz
         e2KA==
X-Gm-Message-State: AOAM531PCJuxgHz2Nt76ZCAVgvnjhoHgQJCPMJU1NPnlvqqCeobfwNzE
        ypDW/n+pjbMUy4ELDWPHZutu8Tt6XnnxXQ==
X-Google-Smtp-Source: ABdhPJyYyASzuNf8ZkYPQfZGJt1UqixmLI/x8NmhCsZeRXGboGB9iTL8EgiO61bZ44me+6GXymb/vg==
X-Received: by 2002:adf:ebd0:0:b0:1e3:f9b:7b77 with SMTP id v16-20020adfebd0000000b001e30f9b7b77mr7662448wrn.691.1647015871323;
        Fri, 11 Mar 2022 08:24:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:30 -0800 (PST)
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
Subject: [RFC PATCH v2 01/13] protocol v2: add server-side "bundle-uri" skeleton
Date:   Fri, 11 Mar 2022 17:24:13 +0100
Message-Id: <RFC-patch-v2-01.13-2fc87ce092b-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
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
 Documentation/technical/protocol-v2.txt | 209 ++++++++++++++++++++++++
 Makefile                                |   1 +
 bundle-uri.c                            |  55 +++++++
 bundle-uri.h                            |  13 ++
 serve.c                                 |   6 +
 t/t5701-git-serve.sh                    | 124 +++++++++++++-
 6 files changed, 407 insertions(+), 1 deletion(-)
 create mode 100644 bundle-uri.c
 create mode 100644 bundle-uri.h

diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 8a877d27e23..3ea96add398 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -566,3 +566,212 @@ and associated requested information, each separated by a single space.
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
+command. To be useful to clients it's expected that it'll be issued
+after an `ls-refs` and before `fetch`, but CAN be issued at any time
+in the dialog.
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
+Clients are still expected to fully parse the line according to the
+above format, lines that do not conform to the format SHOULD be
+discarded. The user MAY be warned in such a case.
+
+bundle-uri CLIENT AND SERVER EXPECTATIONS
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+".bundle" FORMAT
+++++++++++++++++
+
+The advertised bundle(s) MUST be in a format that "git bundle verify"
+would accept. I.e. they MUST contain one or more reference tips for
+use by the client, MUST indicate prerequisites (in any) with standard
+"-" prefixes, and MUST indicate their "object-format", if
+applicable. Create "*.bundle" files with "git bundle create".
+
+bundle-uri CLIENT ERROR RECOVERY
+++++++++++++++++++++++++++++++++
+
+A client MUST above all gracefully degrade on errors, whether that
+error is because of bad missing/data in the bundle URI(s), because
+that client is too dumb to e.g. understand and fully parse out bundle
+headers and their prerequisite relationships, or something else.
+
+Server operators should feel confident in turning on "bundle-uri" and
+not worry if e.g. their CDN goes down that clones or fetches will run
+into hard failures. Even if the server bundle bundle(s) are
+incomplete, or bad in some way the client should still end up with a
+functioning repository, just as if it had chosen not to use this
+protocol extension.
+
+All subsequent discussion on client and server interaction MUST keep
+this in mind.
+
+bundle-uri SERVER TO CLIENT
++++++++++++++++++++++++++++
+
+The ordering of the returned bundle uris is not significant. Clients
+MUST parse their headers to discover their contained OIDS and
+prerequisites. A client MUST consider the content of the bundle(s)
+themselves and their header as the ultimate source of truth.
+
+A server MAY even return bundle(s) that don't have any direct
+relationship to the repository being cloned (either through accident,
+or intentional "clever" configuration), and expect a client to sort
+out what data they'd like from the bundle(s), if any.
+
+bundle-uri CLIENT TO SERVER
++++++++++++++++++++++++++++
+
+The client SHOULD provide reference tips found in the bundle header(s)
+as 'have' lines in any subsequent `fetch` request. A client MAY also
+ignore the bundle(s) entirely if doing so is deemed worse for some
+reason, e.g. if the bundles can't be downloaded, it doesn't like the
+tips it finds etc.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE NO FURTHER NEGOTIATION
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+If after issuing `bundle-uri` and `ls-refs`, and getting the header(s)
+of the bundle(s) the client finds that the ref tips it wants can be
+retrieved entirety from advertised bundle(s), it MAY disconnect. The
+results of such a 'clone' or 'fetch' should be indistinguishable from
+the state attained without using bundle-uri.
+
+EARLY CLIENT DISCONNECTIONS AND ERROR RECOVERY
+++++++++++++++++++++++++++++++++++++++++++++++
+
+A client MAY perform an early disconnect while still downloading the
+bundle(s) (having streamed and parsed their headers). In such a case
+the client MUST gracefully recover from any errors related to
+finishing the download and validation of the bundle(s).
+
+I.e. a client might need to re-connect and issue a 'fetch' command,
+and possibly fall back to not making use of 'bundle-uri' at all.
+
+This "MAY" behavior is specified as such (and not a "SHOULD") on the
+assumption that a server advertising bundle uris is more likely than
+not to be serving up a relatively large repository, and to be pointing
+to URIs that have a good chance of being in working order. A client
+MAY e.g. look at the payload size of the bundles as a heuristic to see
+if an early disconnect is worth it, should falling back on a full
+"fetch" dialog be necessary.
+
+WHEN ADVERTISED BUNDLE(S) REQUIRE FURTHER NEGOTIATION
++++++++++++++++++++++++++++++++++++++++++++++++++++++
+
+A client SHOULD commence a negotiation of a PACK from the server via
+the "fetch" command using the OID tips found in advertised bundles,
+even if's still in the process of downloading those bundle(s).
+
+This allows for aggressive early disconnects from any interactive
+server dialog. The client blindly trusts that the advertised OID tips
+are relevant, and issues them as 'have' lines, it then requests any
+tips it would like (usually from the "ls-refs" advertisement) via
+'want' lines. The server will then compute a (hopefully small) PACK
+with the expected difference between the tips from the bundle(s) and
+the data requested.
+
+The only connection the client then needs to keep active is to the
+concurrently downloading static bundle(s), when those and the
+incremental PACK are retrieved they should be inflated and
+validated. Any errors at this point should be gracefully recovered
+from, see above.
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
+ * A "oid=<OID>" shortcut and "prerequisite=<OID>" shortcut. For
+   expressing the common case of a bundle with one tip and no
+   prerequisites, or one tip and one prerequisite.
++
+This would allow for optimizing the common case of servers who'd like
+to provide one "big bundle" containing only their "main" branch,
+and/or incremental updates thereof.
++
+A client receiving such a a response MAY assume that they can skip
+retrieving the header from a bundle at the indicated URI, and thus
+save themselves and the server(s) the request(s) needed to inspect the
+headers of that bundle or bundles.
diff --git a/Makefile b/Makefile
index 6f0b4b775fe..5a3d35109a1 100644
--- a/Makefile
+++ b/Makefile
@@ -855,6 +855,7 @@ LIB_OBJS += blob.o
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
2.35.1.1337.g7e32d794afe

