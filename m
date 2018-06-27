Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A56CC1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 22:30:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966494AbeF0Wav (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 18:30:51 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:33721 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966489AbeF0Waq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 18:30:46 -0400
Received: by mail-it0-f74.google.com with SMTP id n66-v6so11931349itg.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 15:30:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=fHW/S26t95dOBBUinzJPF4zbBJt1rglMJsH6VyPQK7I=;
        b=stgttjoCjGbSHkULVDg5icKzK6C2SJftCpQqpKW9qlcQTxvvQLPooT+2CZR5wF5vLb
         5a5vORLhBsd9CSs5Vgwe3gn1EclyY7+HhmEK2ABu1yn9ATr02pvTRW7cdZuB57SuAyzu
         8SGJRngc9YZOagULsot4CU/64OAbG7gbZg/SDt+C2pA3LxJtSrABw0xay7He556j+2+A
         N7kDan054Y3PXDwVhSe2Mdq1VdbqEiUWRDpypzxXIc9q79ltzDpDaLNi4ojTyz6Y0tq6
         oxspMKdwOZtZu2rzuX0jmBgT84cCR3He0yGSKTwSNPJvlfRVhbHwjrT9npXLBvWRnzoM
         9kzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=fHW/S26t95dOBBUinzJPF4zbBJt1rglMJsH6VyPQK7I=;
        b=FKFRgvjFCqGNR9nWd0k+zT9VFXtF6MTkBNQ47W08j5FK2KJ+GC/C4u3Q4lsNolgqRD
         J28lcONwJ3hcEX9xp9VOYDjUrEKgWXQwssnS/LgQaer0V3+FvxG0RgxeiV0I2To3BQA4
         7N0FH4qMTXqKBHqQ0NYsGnpIORBQDFQJIvy75n+8EnVHKoHK3aanR1IvXidXeWNeKHyn
         wkiGR7ViAaJtsVWtOnKFhMMlt2k1BLiT8NnBkpxURnukTu+7FvggRzRaQWvX1jAdXlbP
         BX8cZ3bcNXkhpBIY2ARFbFcJ5+xueJL7wbnElQ8APi75aGr2t0/7ImK7x+f4SAATOKJ3
         Ktbw==
X-Gm-Message-State: APt69E3Q+SdoUbTEKcY1+ZDmQhxOQHAZV2f1INb8LNfNadboiO3t3bJ3
        YMaIFUGH6YyOzILg64BE5FpVjxBh6bD6RWSSwErlNGNz9Q3ta+CM2aq96X003I2OMFf8O4yTTEv
        b0//I3HKI+6pztcjlABsATuiILIdXBeqPfjI9uYP6LCy5E4hv00+CF8rg7Q==
X-Google-Smtp-Source: AAOMgpdKEHAehuUjP2rZeoRd2Fl5N4AaDocS+vXHi+bd7zHjVkqyMWv75MltW2QmgJsJag6qWXNrZs7a2AY=
MIME-Version: 1.0
X-Received: by 2002:a24:7b0e:: with SMTP id q14-v6mr3125324itc.44.1530138645961;
 Wed, 27 Jun 2018 15:30:45 -0700 (PDT)
Date:   Wed, 27 Jun 2018 15:30:23 -0700
In-Reply-To: <20180627223023.49659-1-bmwill@google.com>
Message-Id: <20180627223023.49659-9-bmwill@google.com>
References: <20180626205438.110764-1-bmwill@google.com> <20180627223023.49659-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.399.gad0ab374a1-goog
Subject: [PATCH v6 8/8] fetch-pack: implement ref-in-want
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
 fetch-pack.c                       |  38 +++++++-
 remote.c                           |   1 +
 remote.h                           |   1 +
 t/t5703-upload-pack-ref-in-want.sh | 149 +++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 3 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 73890b894..0b4a9f288 100644
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
 
@@ -1334,6 +1337,32 @@ static void receive_shallow_info(struct fetch_pack_args *args,
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
+
+		if (!r)
+			die("unexpected wanted-ref: '%s'", reader->line);
+	}
+
+	if (reader->status != PACKET_READ_DELIM)
+		die("error processing wanted refs: %d", reader->status);
+}
+
 enum fetch_state {
 	FETCH_CHECK_LOCAL = 0,
 	FETCH_SEND_REQUEST,
@@ -1408,6 +1437,9 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
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
index 32527a59c..a73c55a47 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -211,6 +211,18 @@ test_expect_success 'server is initially ahead - no ref in want' '
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
@@ -223,6 +235,143 @@ test_expect_success 'server is initially behind - no ref in want' '
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
+test_expect_success 'setup repos for fetching with ref-in-want tests' '
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
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
+		$(git -C "$REPO" rev-parse d):refs/heads/actual &&
+
+	git -C "$REPO" rev-parse "d" >expected &&
+	git -C local rev-parse refs/heads/actual >actual &&
+	test_cmp expected actual &&
+	grep "want $(git -C "$REPO" rev-parse d)" log
+'
+
+test_expect_success 'fetching multiple refs' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin master baz &&
+
+	git -C "$REPO" rev-parse "master" "baz" >expected &&
+	git -C local rev-parse refs/remotes/origin/master refs/remotes/origin/baz >actual &&
+	test_cmp expected actual &&
+	grep "want-ref refs/heads/master" log &&
+	grep "want-ref refs/heads/baz" log
+'
+
+test_expect_success 'fetching ref and exact OID' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin \
+		master $(git -C "$REPO" rev-parse b):refs/heads/actual &&
+
+	git -C "$REPO" rev-parse "master" "b" >expected &&
+	git -C local rev-parse refs/remotes/origin/master refs/heads/actual >actual &&
+	test_cmp expected actual &&
+	grep "want $(git -C "$REPO" rev-parse b)" log &&
+	grep "want-ref refs/heads/master" log
+'
+
+test_expect_success 'fetching with wildcard that does not match any refs' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	git -C local fetch origin refs/heads/none*:refs/heads/* >out &&
+	test_must_be_empty out
+'
+
+test_expect_success 'fetching with wildcard that matches multiple refs' '
+	test_when_finished "rm -f log" &&
+
+	rm -rf local &&
+	cp -r "$LOCAL_PRISTINE" local &&
+	GIT_TRACE_PACKET="$(pwd)/log" git -C local fetch origin refs/heads/o*:refs/heads/o* &&
+
+	git -C "$REPO" rev-parse "o/foo" "o/bar" >expected &&
+	git -C local rev-parse "o/foo" "o/bar" >actual &&
+	test_cmp expected actual &&
+	grep "want-ref refs/heads/o/foo" log &&
+	grep "want-ref refs/heads/o/bar" log
+'
+
 test_done
-- 
2.18.0.399.gad0ab374a1-goog

