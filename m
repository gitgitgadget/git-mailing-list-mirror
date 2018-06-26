Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2C321F516
	for <e@80x24.org>; Tue, 26 Jun 2018 20:55:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933810AbeFZUzT (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 16:55:19 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:49917 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933794AbeFZUzB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 16:55:01 -0400
Received: by mail-yw0-f202.google.com with SMTP id a203-v6so14674940ywe.16
        for <git@vger.kernel.org>; Tue, 26 Jun 2018 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ehBm4NjHyO2b3qLBqkAbX7oDCl7moCJBVNTuk6q/jmY=;
        b=OT7c7H29mwhStrPctNIawMvLxFoMXc9ACiS0nN5eO6co+TiqgBMDzRLFOKojHhUjOR
         xmGg4MsYc5VNRQDqLnCbflKkH3qWlOzqqI0Vi4+ygMRVfA/82uYIDn5BwLT+VZMxor4k
         3Hnqhyr1tt2siQL4e7yhdiUP4HMcPcgIbRMwoh7CAZzNhTCe2ndC+rIYxHIIUW7m7V8r
         MIZbbR21PMbQ0m5DqT7p9vCmy56mmf+TTHjXyRGOsaaKvZoXcdL1OZpHGd6AOlptqzBC
         7EzUVShbWI1o8DeQaLkl4YxdCFSTDjYDMo2m3tjLbAYe8E5h30+3FskdhLc4b3vG+enY
         X1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ehBm4NjHyO2b3qLBqkAbX7oDCl7moCJBVNTuk6q/jmY=;
        b=P6DZ6ky0eVGVJS+6UgJci57V1oesnv2aM6mGsx8tLs5KeIMKSuRoNdln0gEjlKJQw2
         EgIYQB1XOlgq+j4Wai+PJNn0ZvUIS1a/pIHbMe61R1jYvVESAcZ3+igcXwaqVmjmYuhm
         GDRAynB8LF4g/inoK0twd9TBRhA0HLINiF1WQyPKH1Ainmlg5hCHXJ95BEhbRpITNoTn
         Xk5kgwFIySdquZJ6AVHVouWhNpmNifpbaDdzHfClYoxEeMenwWSo9qZdePIdcoPheUu9
         kDc4vHhYUDABn44qJvmbODmK6J+YUg82ubHjlbvs6RkHXDIDmzkEKqqR6vB9AJ2TPTP9
         HQcw==
X-Gm-Message-State: APt69E0IxH6hULPIe18UfBfX8mLZwX/ia9MFaOsJtpkJ0Sh33BLzflma
        aYoC36LH0l9+2RYBrSB1WzySeW6b9YFg/T7h7G/10NgoorCi12RbPEgqvH9ZEyrdALB7uX3znE7
        0D9RUk/U1iMdnW7pOIoTdsmEuHZ5BBOo1j6NP/OCTy62aGrCh5hWmIhwYeA==
X-Google-Smtp-Source: ADUXVKLS25MSeD/ozCRFfWZXF+hjrwmDPAiBb9H6cTGfE+CxRswCA9MXdIg2sj8rBPJlAAJ02rJzjL217p8=
MIME-Version: 1.0
X-Received: by 2002:a25:ba8c:: with SMTP id s12-v6mr886817ybg.6.1530046500774;
 Tue, 26 Jun 2018 13:55:00 -0700 (PDT)
Date:   Tue, 26 Jun 2018 13:54:38 -0700
In-Reply-To: <20180626205438.110764-1-bmwill@google.com>
Message-Id: <20180626205438.110764-9-bmwill@google.com>
References: <20180625185332.164142-1-bmwill@google.com> <20180626205438.110764-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v5 8/8] fetch-pack: implement ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement ref-in-want on the client side so that when a server supports
the "ref-in-want" feature, a client will send "want-ref" lines for each
reference the client wants to fetch.  This feature allows clients to
tolerate inconsistencies that exist when a remote repository's refs
change during the course of negotiation.

This allows a client to request to request a particular ref without
specifying the OID of the ref.  This means that instead of hitting an
error when a ref no longer points at the OID it did at the beginning of
negotiation, negotiation can continue and the value of that ref will be
sent at the termination of negotiation, just before a packfile is sent.

More information on the ref-in-want feature can be found in
Documentation/technical/protocol-v2.txt.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 fetch-pack.c                       |  35 +++++++-
 remote.c                           |   1 +
 remote.h                           |   1 +
 t/t5703-upload-pack-ref-in-want.sh | 130 +++++++++++++++++++++++++++++
 4 files changed, 164 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 73890b894..3a18f5bcd 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -1102,9 +1102,10 @@ static void add_shallow_requests(struct strbuf *req_buf,
 
 static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 {
+	int use_ref_in_want = server_supports_feature("fetch", "ref-in-want", 0);
+
 	for ( ; wants ; wants = wants->next) {
 		const struct object_id *remote = &wants->old_oid;
-		const char *remote_hex;
 		struct object *o;
 
 		/*
@@ -1122,8 +1123,10 @@ static void add_wants(const struct ref *wants, struct strbuf *req_buf)
 			continue;
 		}
 
-		remote_hex = oid_to_hex(remote);
-		packet_buf_write(req_buf, "want %s\n", remote_hex);
+		if (!use_ref_in_want || wants->exact_oid)
+			packet_buf_write(req_buf, "want %s\n", oid_to_hex(remote));
+		else
+			packet_buf_write(req_buf, "want-ref %s\n", wants->name);
 	}
 }
 
@@ -1334,6 +1337,29 @@ static void receive_shallow_info(struct fetch_pack_args *args,
 	args->deepen = 1;
 }
 
+static void receive_wanted_refs(struct packet_reader *reader, struct ref *refs)
+{
+	process_section_header(reader, "wanted-refs", 0);
+	while (packet_reader_read(reader) == PACKET_READ_NORMAL) {
+		struct object_id oid;
+		const char *end;
+		struct ref *r = NULL;
+
+		if (parse_oid_hex(reader->line, &oid, &end) || *end++ != ' ')
+			die("expected wanted-ref, got '%s'", reader->line);
+
+		for (r = refs; r; r = r->next) {
+			if (!strcmp(end, r->name)) {
+				oidcpy(&r->old_oid, &oid);
+				break;
+			}
+		}
+	}
+
+	if (reader->status != PACKET_READ_DELIM)
+		die("error processing wanted refs: %d", reader->status);
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1408,6 +1434,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
 			if (process_section_header(&reader, "shallow-info", 1))
 				receive_shallow_info(args, &reader);
 
+			if (process_section_header(&reader, "wanted-refs", 1))
+				receive_wanted_refs(&reader, ref);
+
 			/* get the pack */
 			process_section_header(&reader, "packfile", 0);
 			if (get_pack(args, fd, pack_lockfile))
diff --git a/remote.c b/remote.c
index abe80c139..2c2376fff 100644
--- a/remote.c
+++ b/remote.c
@@ -1735,6 +1735,7 @@ int get_fetch_map(const struct ref *remote_refs,
 		if (refspec->exact_sha1) {
 			ref_map = alloc_ref(name);
 			get_oid_hex(name, &ref_map->old_oid);
+			ref_map->exact_oid = 1;
 		} else {
 			ref_map = get_remote_ref(remote_refs, name);
 		}
diff --git a/remote.h b/remote.h
index 45ecc6cef..976292152 100644
--- a/remote.h
+++ b/remote.h
@@ -73,6 +73,7 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
+		exact_oid:1,
 		deletion:1;
 
 	enum {
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index a4fe0e7e4..392be4959 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -204,6 +204,18 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	grep "ERR upload-pack: not our ref" err
 '
 
+test_expect_success 'server is initially ahead - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master 1234567890123456789012345678901234567890 &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify master >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'server is initially behind - no ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant false &&
 	rm -rf local &&
@@ -216,6 +228,124 @@ test_expect_success 'server is initially behind - no ref in want' '
 	test_cmp expected actual
 '
 
+test_expect_success 'server is initially behind - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	inconsistency master "master^" &&
+	git -C local fetch &&
+
+	git -C "$REPO" rev-parse --verify "master" >expected &&
+	git -C local rev-parse --verify refs/remotes/origin/master >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'server loses a ref - ref in want' '
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	echo "s/master/raster/" >"$HTTPD_ROOT_PATH/one-time-sed" &&
+	test_must_fail git -C local fetch 2>err &&
+
+	grep "ERR unknown ref refs/heads/raster" err
+'
+
 stop_httpd
 
+REPO="$(pwd)/repo"
+LOCAL_PRISTINE="$(pwd)/local_pristine"
+
+# $REPO
+# c(o/foo) d(o/bar)
+#        \ /
+#         b   e(baz)  f(master)
+#          \__  |  __/
+#             \ | /
+#               a
+#
+# $LOCAL_PRISTINE
+#		s32(side)
+#		|
+#		.
+#		.
+#		|
+#		a(master)
+test_expect_success 'setup repos for change-while-negotiating test' '
+	(
+		git init "$REPO" &&
+		cd "$REPO" &&
+		test_commit a &&
+
+		# Local repo with many commits (so that negotiation will take
+		# more than 1 request/response pair)
+		rm -rf "$LOCAL_PRISTINE" &&
+		git clone "file://$REPO" "$LOCAL_PRISTINE" &&
+		cd "$LOCAL_PRISTINE" &&
+		git checkout -b side &&
+		for i in $(seq 1 33); do test_commit s$i; done &&
+
+		# Add novel commits to upstream
+		git checkout master &&
+		cd "$REPO" &&
+		git checkout -b o/foo &&
+		test_commit b &&
+		test_commit c &&
+		git checkout -b o/bar b &&
+		test_commit d &&
+		git checkout -b baz a &&
+		test_commit e &&
+		git checkout master &&
+		test_commit f
+	) &&
+	git -C "$REPO" config uploadpack.allowRefInWant true &&
+	git -C "$LOCAL_PRISTINE" config protocol.version 2
+'
+
+test_expect_success 'fetching with exact OID' '
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin $(git -C "$REPO" rev-parse d):refs/heads/actual &&
+
+	git -C "$REPO" rev-parse "d" >expected &&
+	git -C local rev-parse refs/heads/actual >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetching multiple refs' '
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin master baz &&
+
+	git -C "$REPO" rev-parse "master" "baz" >expected &&
+	git -C local rev-parse refs/remotes/origin/master refs/remotes/origin/baz >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetching ref and exact OID' '
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin master $(git -C "$REPO" rev-parse b):refs/heads/actual &&
+
+	git -C "$REPO" rev-parse "master" "b" >expected &&
+	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'fetching with wildcard that does not match any refs' '
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin refs/heads/none*:refs/heads/* >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'fetching with wildcard that matches multiple refs' '
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin refs/heads/o*:refs/heads/o* &&
+
+	git -C "$REPO" rev-parse "o/foo" "o/bar" >expected &&
+	git -C local rev-parse "o/foo" "o/bar" >actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.18.0.rc2.346.g013aa6912e-goog

