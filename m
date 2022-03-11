Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBB9EC433F5
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 16:25:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350352AbiCKQ0g (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 11:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350276AbiCKQZt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 11:25:49 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDEB8114741
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:44 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id x15so13653522wru.13
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 08:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cddlK2DHn71ATImx9jmVveScMo/mO/reBHq9IgEf/mc=;
        b=TFpiF3dLk4MvKl65XzYWDzu5PVCbYFyP2wnmfyLGaLjqQEX/ehg3/OMRpERfhqzKvv
         PsTTId5uKpRnzb/jdJr3zUG/Ie+9Xhl3caCyuQwn3i5pD6wbnVaDj+DgH10xUSJrkaMo
         pcV71ZGv6xcvnwJmZzOjsLtOqrZANOBxfCQb8xwDZux1YjCqTpHJ0ycf+GnJwHBNk0oi
         /DX7tZHbOuuHVTL5edRnALBhdIXzR/eh4cl2LAwbZkOm7ok+pkPJy+1DgJOmf7kDi1ky
         J+zMUfkfFyTxQxuGsrmn3Pc9wOfv+DjlKLHp+9pPFDogaWchFafZBl9+9S0ph/ZITOLt
         er7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cddlK2DHn71ATImx9jmVveScMo/mO/reBHq9IgEf/mc=;
        b=GjiF87lKxu4eNHMlUNNkZ36pKfFLX9lZeK0P0W+ncCHhnhVr3bl0lcEOD2DKAnulJC
         GpdFWYxPaPrZhkKw6zllAbyNbMKajVt5eV8mIZGqc+U8WAhVxh8fNAFfTUbgI/l+5uXP
         io8GIZoaaKbYDA5+TLVQgbNBY+w/B9iR/XFk16f0WVRMd6+zpqkR4ceq6y1+ddZG/8XM
         skQLBsNTpKkqL6xvYkZG606mNxnEKZh7h/VmCNgrExXZHxxn9owT4OYnX7Oe086AMEn0
         tLcGFo/uDjN8JPhDxHZAnCgNQITCAtRa77+o63II3VNy5T5wlC+0sbfzSjEul77Lye82
         sfFg==
X-Gm-Message-State: AOAM5331KFLaiWW6mAhK9y08Sy7HZxuFUiRYOklGO5VhDWFV61q+tSAJ
        fdi4NV8GXTeeny/Us67ZVqzloGnJBsi8Zw==
X-Google-Smtp-Source: ABdhPJwPDj3GBdhoolF4Lp7HqAtDer9KaO3gWLgCGmm/6oivLcW/YiqYOAIK7C6HDZrCVPJCA5cROQ==
X-Received: by 2002:adf:e3d2:0:b0:1f1:d9b1:b5a8 with SMTP id k18-20020adfe3d2000000b001f1d9b1b5a8mr7721031wrm.499.1647015882507;
        Fri, 11 Mar 2022 08:24:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f22-20020a1cc916000000b00380d3e49e89sm7318667wmb.22.2022.03.11.08.24.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 08:24:41 -0800 (PST)
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
Subject: [RFC PATCH v2 12/13] bundle-uri client: support for bundle-uri with "clone"
Date:   Fri, 11 Mar 2022 17:24:24 +0100
Message-Id: <RFC-patch-v2-12.13-bb0d681f5f0-20220311T155841Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1337.g7e32d794afe
In-Reply-To: <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211025T211159Z-avarab@gmail.com> <RFC-cover-v2-00.13-00000000000-20220311T155841Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In an earlier commit ("bundle-uri client: add minimal NOOP client") a
transport_get_remote_bundle_uri() call was added to builtin/clone.c to
get any advertised bundle URIs from the server during cloning, but
nothing was being done with them yet.

This implements real support for bundle-uri during the "clone"
phase. It's not used at all by "fetch", but the code to support it is
mostly here already, and will be finished later.

Using the new transfer.injectBundleURI support it's easy to test this
method of cloning on a live server that doesn't support bundle-uri. In
a git.git checkout.

First let's prepare two bundles:

    git bundle create /tmp/git-master-only.bdl origin/master
    git bundle create /tmp/git-master-to-next.bdl origin/master..origin/next

And next, let's do a "fake" clone where we bootstrap from these
bundles. The fetch.uriProtocols is needed because we'd otherwise
ignore "file://" URIs. This uses --no-tags --single-branch for
simplicity:

    rm -rf /tmp/git.git &&
    git \
	-c protocol.version=2 \
        -c fetch.uriProtocols=file \
        -c transfer.injectBundleURI="file:///tmp/git-master-only.bdl" \
	-c transfer.injectBundleURI="file:///tmp/git-master-to-next.bdl" \
	clone --bare --no-tags --single-branch --branch next --template= \
	--verbose --verbose \
	https://github.com/git/git.git /tmp/git.git

We'll then get output like:

    Receiving bundle (1/2): 100% (300529/300529), 87.57 MiB | 32.70 MiB/s, done.
    Resolving deltas: 100% (226765/226765), done.
    have eb27b338a3e71c7c4079fbac8aeae3f8fbb5c687 commit via bundle-uri
    Receiving bundle (2/2): 100% (725/725), 221.11 KiB | 22.11 MiB/s, done.
    Resolving deltas: 100% (539/539), completed with 153 local objects.
    have e1b32706d8dd5db1dc2e13f8e391651214f1d987 commit via bundle-uri
    Marking e1b32706d8dd5db1dc2e13f8e391651214f1d987 as complete
    already have e1b32706d8dd5db1dc2e13f8e391651214f1d987 (refs/heads/next)
    Checking connectivity: 301210, done.

I.e. we did an ls-refs on connection to the server, then retrieved the
advertised bundles (faked up via config in this case).

We then got all the data leading up to the current "master" from
there, and also the commit that's currently on "next. In this case we
found that we didn't need to proceed further with the dialog.

I.e. other than an ls-refs and the server waiting until we downloaded
the bundles, the server didn't need to do any work creating a PACK for
us.

If we change "--branch next" into "--branch seen" in the above command
we'll get the same output at the start until the "want" line, then:

    [...]
    want 93021c12c9f91e0d750d3ca8750a62416f4ea81a (refs/heads/seen)
    POST git-upload-pack (212 bytes)
    remote: Enumerating objects: 2265, done.
    remote: Counting objects: 100% (1576/1576), done.
    remote: Compressing objects: 100% (233/233), done.
    remote: Total 2265 (delta 1378), reused 1480 (delta 1341), pack-reused 689
    Receiving objects: 100% (2265/2265), 2.17 MiB | 10.77 MiB/s, done.
    Resolving deltas: 100% (1673/1673), completed with 339 local objects.
    Checking connectivity: 303225, done.

I.e. the server needed to send us an incremental update on top after
we'd unpacked the bundles, but this was a fairly minimal set of ~2k
objects. It didn't need to service a full clone.

We can see the savings on the server by setting up a local server at
the tip of "next":

    rm -rf /tmp/git-server.git &&
    git init --bare /tmp/git-server.git &&
    git -C /tmp/git-server.git bundle unbundle /tmp/git-master-only.bdl &&
    git -C /tmp/git-server.git bundle unbundle /tmp/git-master-to-next.bdl
    git -C /tmp/git-server.git update-ref refs/heads/master $(git ls-remote /tmp/git-master-only.bdl | cut -f 1) &&
    git -C /tmp/git-server.git update-ref refs/heads/next $(git ls-remote /tmp/git-master-to-next.bdl | cut -f 1) &&
    git -C /tmp/git-server.git for-each-ref

Let's then clone from it, and record the time we spend.

    rm -rf /tmp/git.git /tmp/{client,server}.time &&
    /usr/bin/time -o /tmp/client.time -v git \
	-c protocol.version=2 \
        -c fetch.uriProtocols=file \
        -c transfer.injectBundleURI="file:///tmp/git-master-only.bdl" \
	clone \
	--upload-pack '/usr/bin/time -o /tmp/server.time -v git-upload-pack' \
	--bare --no-tags --single-branch --branch next --template= \
	--verbose --verbose \
	file:///tmp/git-server.git /tmp/git.git &&
    for i in client server
    do
        echo $i: &&
        grep -e seconds -e wall -e Maximum -e context /tmp/$i.time
    done

This gives us something like these results:

    client:
        User time (seconds): 46.34
        System time (seconds): 0.67
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:18.67
        Maximum resident set size (kbytes): 207096
        Voluntary context switches: 116058
        Involuntary context switches: 220
    server:
        User time (seconds): 0.13
        System time (seconds): 0.00
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:14.08
        Maximum resident set size (kbytes): 53168
        Voluntary context switches: 255
        Involuntary context switches: 7

Whereas doing a normal "clone" (by e.g. adding "-c
transfer.bundleURI=false" to the above) will give something like:

    client:
        User time (seconds): 47.24
        System time (seconds): 0.92
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:18.55
        Maximum resident set size (kbytes): 288104
        Voluntary context switches: 136350
        Involuntary context switches: 296
    server:
        User time (seconds): 5.73
        System time (seconds): 0.24
        Elapsed (wall clock) time (h:mm:ss or m:ss): 0:07.45
        Maximum resident set size (kbytes): 288104
        Voluntary context switches: 26568
        Involuntary context switches: 111

I.e. we can see that the win on the client in this case is negative,
but we use around over 2% of the CPU time on the server, and around
20% of the memory. The client-visible time is a bit slower, by around
2%.

In practice I think this will be more of a win-win. These results are
on an unloaded local machine, and don't account for the benefit of the
server being more likely to have a network-local version of most of
the repository via dumb CDNs.

Real servers are also usually in a messier state of having various
loose objects and more fragmented pack collections, and needing to
spend CPU to assemble these. Frequent repacking and e.g. local caching
e.g. via the uploadpack.packObjectsHook helps, but using this should
make it more accessible to run a highly performance git server.

This feature also makes things like resumable clones rather trivial to
implement, this approach was discussed in the past[1] as a means to
get that feature.

1. https://lore.kernel.org/git/20111110074330.GA27925@sigill.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fetch-pack.c                          | 255 ++++++++++++++++++++++++++
 fetch-pack.h                          |   6 +
 t/lib-t5730-protocol-v2-bundle-uri.sh | 107 ++++++++++-
 transport.c                           |   1 +
 4 files changed, 368 insertions(+), 1 deletion(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 0010867e5f5..4f1a7acb20d 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -26,6 +26,7 @@
 #include "commit-reach.h"
 #include "commit-graph.h"
 #include "sigchain.h"
+#include "bundle.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -1020,6 +1021,133 @@ static int get_pack(struct fetch_pack_args *args,
 	return 0;
 }
 
+static int unbundle_bundle_uri(const char *bundle_uri, unsigned int nth,
+			       unsigned int total_nr, FILE *in, int in_fd,
+			       struct oid_array *bundle_oids,
+			       unsigned int use_thin_pack)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct bundle_header header = BUNDLE_HEADER_INIT;
+	int ret = 0;
+	struct string_list_item *item;
+	struct strbuf progress_title = STRBUF_INIT;
+	int code;
+
+	ret = read_bundle_header_fd(in_fd, &header, bundle_uri);
+	if (ret < 0) {
+		ret = error("could not read_bundle_header(%s)", bundle_uri);
+		goto cleanup;
+	}
+
+	for_each_string_list_item(item, &header.references) {
+		/*
+		 * The bundle's idea of the ref name is
+		 * item->string.
+		 *
+		 * Here's where we could do concurrent negotiation
+		 * with the server (and possibly start the fetch!)
+		 * before or while we unpack the bundle with
+		 * index-pack.
+		 *
+		 * The negotiator would need a small change to trust
+		 * arbitrary OIDs instead of assuming it has existing
+		 * in-repo "struct commit *", but ad-hoc testing
+		 * reveals that it'll work & speed up the fetch even
+		 * more, as we could proceed in parallel with the full
+		 * bundle fetching as soon as we get the headers.
+		 */
+		struct object_id *oid = item->util;
+
+		oid_array_append(bundle_oids, oid);
+	}
+
+	if (git_env_bool("GIT_TEST_BUNDLE_URI_FAIL_UNBUNDLE", 0))
+		lseek(in_fd, 0, SEEK_SET);
+
+	strbuf_addf(&progress_title, "Receiving bundle (%d/%d)", nth, total_nr);
+	strvec_pushl(&cmd.args, "index-pack", "--stdin", "-v",
+		     "--progress-title", progress_title.buf, NULL);
+
+	if (header.prerequisites.nr && use_thin_pack)
+		strvec_push(&cmd.args, "--fix-thin");
+	strvec_push(&cmd.args, "--check-self-contained-and-connected");
+	add_index_pack_keep_option(&cmd.args);
+
+	cmd.git_cmd = 1;
+	cmd.in = in_fd;
+	cmd.no_stdout = 1;
+	cmd.git_cmd = 1;
+
+	if (start_command(&cmd)) {
+		ret = error(_("fetch-pack: unable to spawn index-pack"));
+		goto cleanup;
+	}
+
+	code = finish_command(&cmd);
+
+	if (header.prerequisites.nr && code == 1)
+		/*
+		 * index-pack returns -1 on
+		 * --check-self-contained-and-connected to indicate
+		 * that the pack was indeed not self contained and
+		 * connected. We know from the bundle header
+		 * prerequisites.
+		 */
+		code = 0;
+
+	if (code) {
+		ret = error(_("fetch-pack: unable to finish index-pack, exited with %d"), code);
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&progress_title);
+	bundle_header_release(&header);
+	return ret;
+}
+
+static int get_bundle_uri(struct string_list_item *item, unsigned int nth,
+			  unsigned int total_nr, struct oid_array *bundle_oids,
+			  unsigned int use_thin_pack)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf tempfile = STRBUF_INIT;
+	int ret = 0;
+	const char *uri = item->string;
+	FILE *out;
+	int out_fd;
+
+	strvec_push(&cmd.args, "curl");
+	strvec_push(&cmd.args, "--silent");
+	strvec_push(&cmd.args, "--output");
+	strvec_push(&cmd.args, "-");
+	strvec_push(&cmd.args, "--");
+	strvec_push(&cmd.args, item->string);
+	cmd.git_cmd = 0;
+	cmd.no_stdin = 1;
+	cmd.out = -1;
+
+	if (start_command(&cmd)) {
+		ret = error("fetch-pack: unable to spawn http-fetch");
+		goto cleanup;
+	}
+
+	out = xfdopen(cmd.out, "r");
+	out_fd = fileno(out);
+	ret = unbundle_bundle_uri(uri, nth, total_nr, out, out_fd,
+				  bundle_oids, use_thin_pack);
+
+	if (finish_command(&cmd)) {
+		ret = error("fetch-pack: unable to finish http-fetch");
+		goto cleanup;
+	}
+
+cleanup:
+	strbuf_release(&tempfile);
+
+	return ret;
+}
+
 static int cmp_ref_by_name(const void *a_, const void *b_)
 {
 	const struct ref *a = *((const struct ref **)a_);
@@ -1577,6 +1705,130 @@ static void do_check_stateless_delimiter(int stateless_rpc,
 				  _("git fetch-pack: expected response end packet"));
 }
 
+static int get_bundle_uri_add_known_common(struct string_list_item *item,
+					   unsigned int nth, unsigned int total_nr,
+					   struct fetch_negotiator *negotiator,
+					   struct fetch_pack_args *args,
+					   unsigned int use_thin_pack)
+{
+	int i;
+	struct oid_array bundle_oids = OID_ARRAY_INIT;
+
+	/*
+	 * We don't use OBJECT_INFO_QUICK here unlike in the rest of
+	 * the fetch routines, that's because the rest of them don't
+	 * need to consider a commit object that's just been
+	 * downloaded for further negotiation, but bundle-uri does for
+	 * adding newly downloaded OIDs to the negotiator.
+	 */
+	unsigned oi_flags = OBJECT_INFO_SKIP_FETCH_OBJECT;
+
+	if (get_bundle_uri(item, nth, total_nr, &bundle_oids, use_thin_pack) < 0)
+		return error(_("could not get the bundle URI #%d"), nth);
+
+	for (i = 0; i < bundle_oids.nr; i++) {
+		struct object_id *oid = &bundle_oids.oid[i];
+		enum object_type type = OBJ_NONE;
+		struct commit *c = deref_without_lazy_fetch_extended(oid, 0,
+								     &type,
+								     oi_flags);
+		if (!c) {
+			if (type == OBJ_BLOB || type == OBJ_TREE) {
+				print_verbose(args, "have %s %s via bundle-uri (ignoring due to type)",
+					      oid_to_hex(oid), type_name(type));
+				continue;
+			} else if (type) {
+				/*
+				 * OBJ_TAG should have been peeled,
+				 * and OBJ_COMMIT should have a
+				 * non-NULL "c".
+				 *
+				 * Should be a BUG() if we were not
+				 * bending over backwards to make
+				 * bundle-uri soft-fail.
+				 */
+				return error(_("bundle-uri says it has %s, got it at unexpected type %s"),
+					     oid_to_hex(oid), type_name(type));
+			}
+		}
+
+		print_verbose(args, "have %s %s via bundle-uri",
+			      oid_to_hex(oid), type_name(type));
+
+		negotiator->known_common(negotiator, c);
+		mark_complete(oid);
+	}
+	return 0;
+}
+
+static void do_fetch_pack_v2_bundle_uri(struct fetch_pack_args *args,
+					struct string_list  *bundle_uri,
+					struct fetch_negotiator *negotiator)
+{
+	struct string_list_item *item;
+	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list default_protocols = STRING_LIST_INIT_NODUP;
+	struct string_list *ok_protocols;
+
+	if (!bundle_uri)
+		return;
+
+	if (!bundle_uri->nr)
+		return;
+
+	if (uri_protocols.nr) {
+		ok_protocols = &uri_protocols;
+	} else {
+		string_list_append(&default_protocols, "http");
+		string_list_append(&default_protocols, "https");
+		ok_protocols = &default_protocols;
+	}
+
+	for_each_string_list_item(item, bundle_uri) {
+		const char *uri = item->string;
+		int protocol_ok = 0;
+		struct string_list_item *item2;
+
+		for_each_string_list_item(item2, ok_protocols) {
+			const char *s = item2->string;
+			const char *p;
+
+			if (skip_prefix(item->string, s, &p) &&
+			    starts_with(p, "://")) {
+				protocol_ok = 1;
+				break;
+			}
+		}
+
+		if (!protocol_ok) {
+			print_verbose(args, "skipping bundle-uri not on protocol whitelist: %s",
+				      item->string);
+			continue;
+		}
+
+		string_list_append(&list, uri)->util = item->util;
+	}
+
+	if (list.nr) {
+		int i;
+		unsigned int total_nr = list.nr;
+
+		trace2_region_enter("fetch-pack", "bundle-uri", the_repository);
+		for (i = 0; i < total_nr; i++) {
+			struct string_list_item item = list.items[i];
+			unsigned int nth = i + 1;
+
+			get_bundle_uri_add_known_common(&item, nth, total_nr,
+							negotiator, args,
+							args->use_thin_pack);
+		}
+		trace2_region_leave("fetch-pack", "bundle-uri", the_repository);
+	}
+
+	string_list_clear(&default_protocols, 0);;
+}
+
+
 static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 				    int fd[2],
 				    const struct ref *orig_ref,
@@ -1600,10 +1852,13 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 	struct string_list packfile_uris = STRING_LIST_INIT_DUP;
 	int i;
 	struct strvec index_pack_args = STRVEC_INIT;
+	struct string_list *bundle_uri = args->bundle_uri;
 
 	negotiator = &negotiator_alloc;
 	fetch_negotiator_init(r, negotiator);
 
+	do_fetch_pack_v2_bundle_uri(args, bundle_uri, negotiator);
+
 	packet_reader_init(&reader, fd[0], NULL, 0,
 			   PACKET_READ_CHOMP_NEWLINE |
 			   PACKET_READ_DIE_ON_ERR_PACKET);
diff --git a/fetch-pack.h b/fetch-pack.h
index 7f94a2a5831..b19fd7d93be 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -24,6 +24,12 @@ struct fetch_pack_args {
 	 */
 	const struct oid_array *negotiation_tips;
 
+	/*
+	 * A pointer to the already populated transport.bundle_uri
+	 * struct.
+	 */
+	struct string_list *bundle_uri;
+
 	unsigned deepen_relative:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
diff --git a/t/lib-t5730-protocol-v2-bundle-uri.sh b/t/lib-t5730-protocol-v2-bundle-uri.sh
index 3be47bacc5f..ab9b725f038 100644
--- a/t/lib-t5730-protocol-v2-bundle-uri.sh
+++ b/t/lib-t5730-protocol-v2-bundle-uri.sh
@@ -7,6 +7,8 @@ case "$T5730_PROTOCOL" in
 file)
 	T5730_PARENT=file_parent
 	T5730_URI="file://$PWD/file_parent"
+	T5730_URI_BDL_PROTO="file://"
+	T5730_URI_BDL="$T5730_URI_BDL_PROTO$PWD/file_parent"
 	T5730_BUNDLE_URI="$T5730_URI/fake.bdl"
 	test_set_prereq T5730_FILE
 	;;
@@ -15,6 +17,8 @@ git)
 	start_git_daemon --export-all --enable=receive-pack
 	T5730_PARENT="$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
 	T5730_URI="$GIT_DAEMON_URL/parent"
+	T5730_URI_BDL_PROTO="file://"
+	T5730_URI_BDL="$T5730_URI_BDL_PROTO$GIT_DAEMON_DOCUMENT_ROOT_PATH/parent"
 	T5730_BUNDLE_URI="https://example.com/fake.bdl"
 	test_set_prereq T5730_GIT
 	;;
@@ -24,6 +28,8 @@ http)
 	T5730_PARENT="$HTTPD_DOCUMENT_ROOT_PATH/http_parent"
 	T5730_URI="$HTTPD_URL/smart/http_parent"
 	T5730_BUNDLE_URI="https://example.com/fake.bdl"
+	T5730_URI_BDL_PROTO="http://"
+	T5730_URI_BDL="$HTTPD_URL/dumb/http_parent"
 	test_set_prereq T5730_HTTP
 	;;
 *)
@@ -33,7 +39,20 @@ esac
 
 test_expect_success "setup protocol v2 $T5730_PROTOCOL:// tests" '
 	git init "$T5730_PARENT" &&
-	test_commit -C "$T5730_PARENT" one
+	test_commit -C "$T5730_PARENT" one &&
+	test_commit -C "$T5730_PARENT" two &&
+	test_commit -C "$T5730_PARENT" three &&
+	test_commit -C "$T5730_PARENT" four &&
+	test_commit -C "$T5730_PARENT" five &&
+	test_commit -C "$T5730_PARENT" six &&
+
+	mkdir "$T5730_PARENT"/bdl &&
+	git -C "$T5730_PARENT" bundle create bdl/1.bdl one &&
+	git -C "$T5730_PARENT" bundle create bdl/1-2.bdl one..two &&
+	git -C "$T5730_PARENT" bundle create bdl/2-3.bdl two..three &&
+	git -C "$T5730_PARENT" bundle create bdl/3-4.bdl three..four &&
+	git -C "$T5730_PARENT" bundle create bdl/4-5.bdl four..five &&
+	git -C "$T5730_PARENT" bundle create bdl/5-6.bdl five..six
 '
 
 # Poor man's URI escaping. Good enough for the test suite whose trash
@@ -317,3 +336,89 @@ test_expect_success "ls-remote-bundle-uri with bad -c transfer.injectBundleURI p
 	test_cmp err.expect err.actual &&
 	test_path_is_missing log
 '
+
+test_cmp_repo_refs() {
+	one="$1"
+	two="$2"
+	shift 2
+
+	git -C "$one" for-each-ref "$@" >expect &&
+	git -C "$two" for-each-ref "$@" >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success "clone with bundle-uri protocol v2 over $T5730_PROTOCOL:// 1.bdl via $T5730_URI_BDL_PROTO" '
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
+
+	test_when_finished "rm -rf log child" &&
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		-c fetch.uriProtocols=file,http \
+		clone --verbose --verbose \
+		"$T5730_URI" child >out 2>err &&
+	grep -F "Receiving bundle (1/1)" err &&
+	grep "clone> want " log &&
+	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags
+'
+
+test_expect_success "fetch with bundle-uri protocol v2 over $T5730_PROTOCOL:// 1.bdl via $T5730_URI_BDL_PROTO" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
+
+	test_when_finished "rm -rf log child" &&
+	git init --bare child &&
+	git -C child remote add --mirror=fetch origin "$T5730_URI" &&
+	GIT_TRACE_PACKET="$PWD/log" \
+	git -C child \
+		-c protocol.version=2 \
+		-c fetch.uriProtocols=file,http \
+		fetch --verbose --verbose >out 2>err &&
+	# Fetch is not supported yet
+	! grep -F "Receiving bundle (1/1)" err &&
+	grep "fetch> want " log &&
+	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags
+'
+
+test_expect_success "clone with bundle-uri protocol v2 with $T5730_PROTOCOL:// 1 + 1-2 + [...].bdl via $T5730_URI_BDL_PROTO" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1-2.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/2-3.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/3-4.bdl | test_uri_escape)" --add &&
+
+	test_when_finished "rm -rf log child" &&
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		-c fetch.uriProtocols=file,http \
+		clone --verbose --verbose \
+		"$T5730_URI" child >out 2>err &&
+	grep -F "Receiving bundle (4/4)" err &&
+	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags &&
+	grep "clone> want " log
+'
+
+test_expect_success "clone with bundle-uri protocol v2 with $T5730_PROTOCOL:// ALL.bdl via $T5730_URI_BDL_PROTO" '
+	test_when_finished "rm -f log" &&
+
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1.bdl | test_uri_escape)" &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/1-2.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/2-3.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/3-4.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/4-5.bdl | test_uri_escape)" --add &&
+	test_config -C "$T5730_PARENT" uploadpack.bundleURI "$(echo $T5730_URI_BDL/bdl/5-6.bdl | test_uri_escape)" --add &&
+
+	test_when_finished "rm -rf log child" &&
+	GIT_TRACE_PACKET="$PWD/log" \
+	git \
+		-c protocol.version=2 \
+		-c fetch.uriProtocols=file,http \
+		clone --verbose --verbose \
+		"$T5730_URI" child >out 2>err &&
+	grep -F "Receiving bundle (6/6)" err &&
+	test_cmp_repo_refs "$T5730_PARENT" child refs/heads refs/tags &&
+	! grep "clone> want " log
+'
diff --git a/transport.c b/transport.c
index 7085bfb3db8..ebc3ed9b608 100644
--- a/transport.c
+++ b/transport.c
@@ -426,6 +426,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.server_options = transport->server_options;
 	args.negotiation_tips = data->options.negotiation_tips;
 	args.reject_shallow_remote = transport->smart_options->reject_shallow;
+	args.bundle_uri = &transport->bundle_uri;
 
 	if (!data->got_remote_heads) {
 		int i;
-- 
2.35.1.1337.g7e32d794afe

