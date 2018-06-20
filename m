Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 28C821F403
	for <e@80x24.org>; Wed, 20 Jun 2018 21:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933644AbeFTVdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Jun 2018 17:33:03 -0400
Received: from mail-yw0-f201.google.com ([209.85.161.201]:56113 "EHLO
        mail-yw0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933600AbeFTVdB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jun 2018 17:33:01 -0400
Received: by mail-yw0-f201.google.com with SMTP id w8-v6so603870ywg.22
        for <git@vger.kernel.org>; Wed, 20 Jun 2018 14:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=oavWb7kigCTj9Q9X9UL0Ki1pvB1OVpU6EhurbLYw++4=;
        b=c6h9KlJz6RfXM9bkcpSMMfIRR+wG736GxIucJSEmOH7YGyhZumY9EQv0aE9vb1QsRx
         JmNAJXEPQ4Wz4IOEFsePm0XhqgIXY16FwzbRELq4GzaFEyAcOBA/PVXUnsC3/Vokfu2r
         8o/u+oSUH4Jgnu67Y33szVEMi5YsTFZPX7PNHjL4ubxE2oCzmNMCRxELQv/PCxFJlK5G
         lgoWcSDg/0LG9b+V/+Ki432x1hj9CjRbGvqEQmvLId6GR5OrOFbhZ5888+/lqN5bevB+
         ic78SGzDj6Wbcez0t6p4CruIVdTjoJEJa3PLLk45IRdGOKMgJQ/ay/pfjvLbTrKYKpxw
         gpGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=oavWb7kigCTj9Q9X9UL0Ki1pvB1OVpU6EhurbLYw++4=;
        b=ZtqkRxp4O4htNyUdPcLulVsVZfHcE/hlZNkY6gVL9R+S0fKLfLrz3FRf/YGRJ1YD+Q
         c1AZiXfqinSSC1t0GxrI+dLrTepQMpktszsncKOLAOftE0xLJ1djtre2JYm3aAFnn19j
         vysJiwiv8MUXWpRqszO/zw4trsfAC07LFRYvXgNBqfRxJh102NNfePYQhGEX1yow4lSs
         eTln9h7lTrcRUnO5n3kh8MYmlEsbUZfkUrzK0ArmWHE4FBqncABRi5vAU/CFrllv3d2p
         s35PIyxzehRSLyJpjIDOLNPtQCHGwhROeM02cLn3Tq1hvncMEUgIJxtVNckSrIhDiYJq
         kySw==
X-Gm-Message-State: APt69E3qlAcj7jWCtx3hl4BMtWgbVjfYZUIiIojo2IZETWf6xqw6lVpA
        DppKS4p6vE9+cslVQBOqYlEZZr2tK7TxhdWFrw9DbWr23H0Bcs+Oz983NNCiqaXuXAxL6uYbe2I
        Y+n9GT80LEBL1xNhVmQ9A+VctRwJroBERZvhI2DOHBstUHkY9tIMIaKGZjg==
X-Google-Smtp-Source: ADUXVKIvDJ5tkrdttPl6fljaRi0jdTOkn0gzJLc//ENmci0rU3WQgs3PmPTfYYsWPfaGUZSY34GIZJ7Xhjg=
MIME-Version: 1.0
X-Received: by 2002:a25:5d08:: with SMTP id r8-v6mr6147525ybb.64.1529530380445;
 Wed, 20 Jun 2018 14:33:00 -0700 (PDT)
Date:   Wed, 20 Jun 2018 14:32:35 -0700
In-Reply-To: <20180620213235.10952-1-bmwill@google.com>
Message-Id: <20180620213235.10952-9-bmwill@google.com>
References: <20180613213925.10560-1-bmwill@google.com> <20180620213235.10952-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.244.gcf134e6275-goog
Subject: [PATCH v3 8/8] fetch-pack: implement ref-in-want
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
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
index f1709e816..681b44061 100644
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
2.18.0.rc1.244.gcf134e6275-goog

