Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3797F1F461
	for <e@80x24.org>; Tue, 14 May 2019 21:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726429AbfENVLF (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 17:11:05 -0400
Received: from mail-oi1-f201.google.com ([209.85.167.201]:43879 "EHLO
        mail-oi1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENVLE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 17:11:04 -0400
Received: by mail-oi1-f201.google.com with SMTP id l12so182834oii.10
        for <git@vger.kernel.org>; Tue, 14 May 2019 14:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ljS0W6FVKQYnkZNyAH2XaU6gTPEF8XCjTfmlTU+yS5w=;
        b=O8ni3XHxoLC0b0nbrvDr/xajmMcKTnEXHlF3gql+Hoz/CEgoPOXdULxSMEELYuAB3W
         NZrKvlTiUk6F3i+VtJnAmDl5pFAMiUnGnZ4AzDgHJIxaoYIa1nHr0DwlRHqK9f8AWD0h
         Uds/dCJ+Ldrd8ma1gz06p2c1b1OMY2P93rYvNNy4upBeEyp45dCp5RHVJJ8StfTIv6O3
         hhCeJQ3alUR6p47M2S1FsXO1T+rTa2hSUfxcamWJJoxJut4ZkHybNw4F1Nsw31ba7OJn
         PeyMrf/kkaQZ/IihKvzOdcEsMuHsJlzkn4J0ztEV2zdraUGw0unmDPH0U7SrwG0SyPls
         YuRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ljS0W6FVKQYnkZNyAH2XaU6gTPEF8XCjTfmlTU+yS5w=;
        b=YINSpM5V+tL22ZATQVNJpt0mMcBSU6tKTCO0sL9rVoVKgfe5kYXWetZZZyg2IYGwFV
         HCzw/blosNLCGwsC8iVQ1If+RA9FEuvrHw5q6uJ4PyH62Rnzf5dZnCb91zUttrzUN9hN
         uZKk79fpxemGqvh01DsD4o3GzCT4ofy22ySoT7IJoK9jclFKP46G4yWd7tAughpY44Ju
         o/yng4SXzuDwyeeSB8euUfyie3r4n7oDTQXl+Qetj1RiTetcubZTEm+V3MYFXbvxTlBL
         z2x5zY8+V62exQR5lm+azRz49VxRAcJCso8w5yaqcjYsRSerQpRtepT/Iz1sDh8iGs9N
         EjNA==
X-Gm-Message-State: APjAAAWVGSvTc+QkjDJy8KRESxH8CFGgBP6IQk6lA4lcADxn2sOBzM4i
        bZNeyC/KzFbNVxKzAGnbfxxRPQxI3xna33qAgm8OmNVQ7EtETuFwxFx1wiqAPoFHoME6IfuTbZe
        eb26mGAsTqKz+JG6+Rxq5jfv1EuaZf1ax842aIdXWIVvEd6d7IuNqkvDkNuFUqDCfoZkU9xZqyw
        mk
X-Google-Smtp-Source: APXvYqyEA5BQZ/rfAWTvKCCfZcgldgWLAVY9gm02A4GUNn0zE00bjv1+m8IA8hPA9cogn9+4n/osY3MHypwnw+COMsmv
X-Received: by 2002:aca:40c1:: with SMTP id n184mr72924oia.73.1557868263350;
 Tue, 14 May 2019 14:11:03 -0700 (PDT)
Date:   Tue, 14 May 2019 14:10:55 -0700
In-Reply-To: <cover.1557868134.git.jonathantanmy@google.com>
Message-Id: <4fcaa4481b5fd2a76aa21263f997e00913db0e0f.1557868134.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1557868134.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: [PATCH 2/2] index-pack: prefetch missing REF_DELTA bases
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When fetching, the client sends "have" commit IDs indicating that the
server does not need to send any object referenced by those commits,
reducing network I/O. When the client is a partial clone, the client
still sends "have"s in this way, even if it does not have every object
referenced by a commit it sent as "have".

If a server omits such an object, it is fine: the client could lazily
fetch that object before this fetch, and it can still do so after.

The issue is when the server sends a thin pack containing an object that
is a REF_DELTA against such a missing object: index-pack fails to fix
the thin pack. When support for lazily fetching missing objects was
added in 8b4c0103a9 ("sha1_file: support lazily fetching missing
objects", 2017-12-08), support in index-pack was turned off in the
belief that it accesses the repo only to do hash collision checks.
However, this is not true: it also needs to access the repo to resolve
REF_DELTA bases.

Support for lazy fetching should still generally be turned off in
index-pack because it is used as part of the lazy fetching process
itself (if not, infinite loops may occur), but we do need to fetch the
REF_DELTA bases. (When fetching REF_DELTA bases, it is unlikely that
those are REF_DELTA themselves, because we do not send "have" when
making such fetches.)

To resolve this, prefetch all missing REF_DELTA bases before attempting
to resolve them. This both ensures that all bases are attempted to be
fetched, and ensures that we make only one request per index-pack
invocation, and not one request per missing object.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/index-pack.c     | 26 +++++++++++++++--
 t/t5616-partial-clone.sh | 61 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index ccf4eb7e9b..0d55f73b0b 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -14,6 +14,7 @@
 #include "thread-utils.h"
 #include "packfile.h"
 #include "object-store.h"
+#include "fetch-object.h"
 
 static const char index_pack_usage[] =
 "git index-pack [-v] [-o <index-file>] [--keep | --keep=<msg>] [--verify] [--strict] (<pack-file> | --stdin [--fix-thin] [<pack-file>])";
@@ -1351,6 +1352,25 @@ static void fix_unresolved_deltas(struct hashfile *f)
 		sorted_by_pos[i] = &ref_deltas[i];
 	QSORT(sorted_by_pos, nr_ref_deltas, delta_pos_compare);
 
+	if (repository_format_partial_clone) {
+		/*
+		 * Prefetch the delta bases.
+		 */
+		struct oid_array to_fetch = OID_ARRAY_INIT;
+		for (i = 0; i < nr_ref_deltas; i++) {
+			struct ref_delta_entry *d = sorted_by_pos[i];
+			if (!oid_object_info_extended(the_repository, &d->oid,
+						      NULL,
+						      OBJECT_INFO_FOR_PREFETCH))
+				continue;
+			oid_array_append(&to_fetch, &d->oid);
+		}
+		if (to_fetch.nr)
+			fetch_objects(repository_format_partial_clone,
+				      to_fetch.oid, to_fetch.nr);
+		oid_array_clear(&to_fetch);
+	}
+
 	for (i = 0; i < nr_ref_deltas; i++) {
 		struct ref_delta_entry *d = sorted_by_pos[i];
 		enum object_type type;
@@ -1650,8 +1670,10 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 	int report_end_of_input = 0;
 
 	/*
-	 * index-pack never needs to fetch missing objects, since it only
-	 * accesses the repo to do hash collision checks
+	 * index-pack never needs to fetch missing objects except when
+	 * REF_DELTA bases are missing (which are explicitly handled). It only
+	 * accesses the repo to do hash collision checks and to check which
+	 * REF_DELTA bases need to be fetched.
 	 */
 	fetch_if_missing = 0;
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 7cc0c71556..f1baf83502 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -339,4 +339,65 @@ test_expect_success 'when partial cloning, tolerate server not sending target of
 	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
 '
 
+test_expect_success 'tolerate server sending REF_DELTA against missing promisor objects' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	test_create_repo "$SERVER" &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	# Create a commit with a blob to be used as a delta base.
+	for i in $(test_seq 10)
+	do
+		echo "this is a line" >>"$SERVER/foo.txt"
+	done &&
+	git -C "$SERVER" add foo.txt &&
+	git -C "$SERVER" commit -m bar &&
+	git -C "$SERVER" rev-parse HEAD:foo.txt >deltabase &&
+
+	git -c protocol.version=2 clone --no-checkout \
+		--filter=blob:none $HTTPD_URL/one_time_sed/server repo &&
+
+	# Sanity check to ensure that the client does not have that blob.
+	git -C repo rev-list --objects --exclude-promisor-objects \
+		-- $(cat deltabase) >objlist &&
+	test_line_count = 0 objlist &&
+
+	# Another commit. This commit will be fetched by the client.
+	echo "abcdefghijklmnopqrstuvwxyz" >>"$SERVER/foo.txt" &&
+	git -C "$SERVER" add foo.txt &&
+	git -C "$SERVER" commit -m baz &&
+
+	# Pack a thin pack containing, among other things, HEAD:foo.txt
+	# delta-ed against HEAD^:foo.txt.
+	printf "%s\n--not\n%s\n" \
+		$(git -C "$SERVER" rev-parse HEAD) \
+		$(git -C "$SERVER" rev-parse HEAD^) |
+		git -C "$SERVER" pack-objects --thin --stdout >thin.pack &&
+
+	# Ensure that the pack contains one delta against HEAD^:foo.txt. Since
+	# the delta contains at least 26 novel characters, the size cannot be
+	# contained in 4 bits, so the object header will take up 2 bytes. The
+	# most significant nybble of the first byte is 0b1111 (0b1 to indicate
+	# that the header continues, and 0b111 to indicate REF_DELTA), followed
+	# by any 3 nybbles, then the OID of the delta base.
+	git -C "$SERVER" rev-parse HEAD^:foo.txt >deltabase &&
+	printf "f.,..%s" $(intersperse "," <deltabase) >want &&
+	hex_unpack <thin.pack | intersperse "," >have &&
+	grep $(cat want) have &&
+
+	replace_packfile thin.pack &&
+
+	# Use protocol v2 because the sed command looks for the "packfile"
+	# section header.
+	test_config -C "$SERVER" protocol.version 2 &&
+
+	# Fetch the thin pack and ensure that index-pack is able to handle the
+	# REF_DELTA object with a missing promisor delta base.
+	git -C repo -c protocol.version=2 fetch &&
+
+	# Ensure that the one-time-sed script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+'
+
 test_done
-- 
2.21.0.1020.gf2820cf01a-goog

