Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 974921F403
	for <e@80x24.org>; Tue,  5 Jun 2018 17:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753149AbeFER6u (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 13:58:50 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:42234 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752726AbeFERwO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 13:52:14 -0400
Received: by mail-it0-f74.google.com with SMTP id c7-v6so2816831itd.7
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 10:52:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=aQZhKDSaTlgV+q5c1WqgXZUpmzDEDSI89x9Be7zyCpk=;
        b=Kbtqvtmalfm2n/rw7PztXTNFjmMrAIpZjN8xwjS/RNclZ2zSGbhxwY2ap7veb71olF
         CKLRh9n0sL9EunQeC9pBOwO2XQXPrAExEC0aIhc+rPOvhPDtZcn14hPF2Orhiob8Ch8L
         pUaOUV+I9l46ETZszQBfhSIsZ/nastOW8vcousZJEB9b5Wh4z1KCOsd8hE8PiMA0y3ti
         8PN8V+7Fo88ltLMjLzeJlz1nIApdYBOEDSvl1SaSIh6Q8HvKZei0d9F7GpI1SsdXGnzf
         d/1u4OSdrPJZYsRwAsmCeVvihz+tVHHJqtYmPpydUTYwvCT6RZywRTVOhXcBeovzUdU0
         wcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=aQZhKDSaTlgV+q5c1WqgXZUpmzDEDSI89x9Be7zyCpk=;
        b=DvWvKP3v1iYNJdAZEd9ax+2Kv4j26lFiZwKo6ZodRsm4XPpnJVQt2zZmACsf3XrZCZ
         Erg/UwTPqNSXB/+7YBWcoYgKd+uIl1YBBf0DWjWySqa0izkT9/bIZVEKY2pZ4V+KTXhi
         ZRMbLFb0mZciFWTL9sEf+Um1x0TcGEYnU2GmcpTU9vHNpvPpmCRuv/n7Tw9YklNjQ9Zr
         azx6zJibr+/0qDCL4CiMLfZG2IH/yuZ2KnlT4sUcFFWNxqKiRXUx3NzRy9vaa/6Pra8M
         KeWgqlJwCJIb7imjy0/VuY0Z/kriMJmO/7FzPCDbykB5nFifGWe/OKI2zf53PanZZEGQ
         vcXg==
X-Gm-Message-State: APt69E0/6pFDCRPN/1EFh83BqzszxXKqEivXkD+POClBDs3lB312I5I5
        CAGMY9qtsJpR++y5l+AuCWchCu3viWKetsj7HsKPNY2wXwZmdYwI4poogF5ph1w3SYa35ZefwHE
        UJL87dNcyPkJdmoojsdFXEIPHnbVPVgCcBvJTn8I2N1nT0DtyXeoeFHCGJg==
X-Google-Smtp-Source: ADUXVKLvV0zbyYzySFa+/vsFUIHB7iRMTCU5PN3l7PJWdGK3ms+ZobmQ5YEYckk9YkfRKRk/fnTS954hCxo=
MIME-Version: 1.0
X-Received: by 2002:a24:b51b:: with SMTP id v27-v6mr72422ite.17.1528221133459;
 Tue, 05 Jun 2018 10:52:13 -0700 (PDT)
Date:   Tue,  5 Jun 2018 10:51:44 -0700
In-Reply-To: <20180605175144.4225-1-bmwill@google.com>
Message-Id: <20180605175144.4225-9-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com>
X-Mailer: git-send-email 2.17.1.1185.g55be947832-goog
Subject: [PATCH 8/8] fetch-pack: implement ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
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
2.17.1.1185.g55be947832-goog

