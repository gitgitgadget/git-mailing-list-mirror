Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FDD21F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935893AbeFMVjw (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:52 -0400
Received: from mail-ot0-f201.google.com ([74.125.82.201]:54775 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935869AbeFMVjt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:49 -0400
Received: by mail-ot0-f201.google.com with SMTP id a9-v6so2338618otl.21
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TrLtrHp58sL12lx2NlmY9oCYQHaRqczIttT6BZlmtxY=;
        b=JOgvEek05P0bcyNO/MKZOAYJhTv+uMfKUh5TEav/x9D0IDqelp1M6J+R8FtanpQSD7
         TNIlkeqnQDvFglmJCJA6BF4pq2vwETBzgAVh8OnfQzSrr3iddpij7GGZoWBrrVUGkyUA
         omQHVLagzBzjeqrH6cMGJmqskksDQG2wDGJk0RebPuFL0f3DXIY5x3ANilF4cE+OZtZG
         +eIe14q9W8lwkioVjbP+CAIJ4Mhgojs/BZu//Vuj8TByIYRb3seroeezNwsD7oAh4HaV
         8JbCoxvZ9opfU+XwYhQgs4petZWUwzv6wb74yOrIXkSlUCWjUvHOniIlzGi7PT2mpJlh
         tu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TrLtrHp58sL12lx2NlmY9oCYQHaRqczIttT6BZlmtxY=;
        b=ayUhCPWw4NRoLnYtQekB8EaQleI1NSt2WRcFz7MXCz9XFMZ4w5gZzs/bKB+bK6zowI
         tR8oPVCAnRA4vYmqSKmIRykASbSVC5Ud8G7bgmvHi0lVyFVW0TyRAMm5hB1arCtJ9i2G
         3FEEL8HEpvPyh4ipZ91ld6y0XPlzkG4wZrlAnDxDz5kD8dThQuqOZKkuZRv0NMv8mYcV
         Ls02R2PHacuH4DoaIM+GRusvbICPk+YKIYSIRU/RAiR6N5snscmqpkBdIjZMfeuvOG4u
         0GdVtiYaKdYB1w6wMn3SMF0lEtoSL8DwD+ZLEFzD1J0ppL1KT7l/Y+g8Cm6xy/b2B2IK
         QpWA==
X-Gm-Message-State: APt69E1Zwd6nbcSMMSdl1JghybXk2x1v3dy7EWhofYITbSSq+bekQp6V
        T/pEITTI8bMSC37jQ3IKsCj30EVz8ZvokZP3eqksRzmuVNz19BLWHkDyHcgLIrQTyBRLkLhUmQ3
        BgLuRYiO4QeuOFjalv6prglxXDoUyNtsGw07FpshyMb247rSOy5XDRs6BJw==
X-Google-Smtp-Source: ADUXVKJ0RfMrC+Ebkd+HJl3vfAX0AyFDCUcTVVredVtb3Og0OyoiQLtC2EIowzGfUrzynFeWJxIQ7yjRYcE=
MIME-Version: 1.0
X-Received: by 2002:a9d:73c7:: with SMTP id m7-v6mr2851214otk.111.1528925988443;
 Wed, 13 Jun 2018 14:39:48 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:25 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-9-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 8/8] fetch-pack: implement ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Implement ref-in-want on the client side so that when a server supports
the "ref-in-want" feature, a client will send "want-ref" lines for each
reference the client wants to fetch.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 fetch-pack.c                       | 35 +++++++++++++++++++++++++++---
 remote.c                           |  1 +
 remote.h                           |  1 +
 t/t5703-upload-pack-ref-in-want.sh |  4 ++--
 4 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7799ee2cd..51e8356ba 100644
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
+		if (!use_ref_in_want || wants->exact_sha1)
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
index abe80c139..c9d452ac0 100644
--- a/remote.c
+++ b/remote.c
@@ -1735,6 +1735,7 @@ int get_fetch_map(const struct ref *remote_refs,
 		if (refspec->exact_sha1) {
 			ref_map = alloc_ref(name);
 			get_oid_hex(name, &ref_map->old_oid);
+			ref_map->exact_sha1 = 1;
 		} else {
 			ref_map = get_remote_ref(remote_refs, name);
 		}
diff --git a/remote.h b/remote.h
index 45ecc6cef..e5338e368 100644
--- a/remote.h
+++ b/remote.h
@@ -73,6 +73,7 @@ struct ref {
 		force:1,
 		forced_update:1,
 		expect_old_sha1:1,
+		exact_sha1:1,
 		deletion:1;
 
 	enum {
diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index 979ab6d03..b94a51380 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -204,7 +204,7 @@ test_expect_success 'server is initially ahead - no ref in want' '
 	grep "ERR upload-pack: not our ref" err
 '
 
-test_expect_failure 'server is initially ahead - ref in want' '
+test_expect_success 'server is initially ahead - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
@@ -228,7 +228,7 @@ test_expect_success 'server is initially behind - no ref in want' '
 	test_cmp expected actual
 '
 
-test_expect_failure 'server is initially behind - ref in want' '
+test_expect_success 'server is initially behind - ref in want' '
 	git -C "$REPO" config uploadpack.allowRefInWant true &&
 	rm -rf local &&
 	cp -r "$LOCAL_PRISTINE" local &&
-- 
2.18.0.rc1.242.g61856ae69a-goog

