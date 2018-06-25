Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4251A1F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:54:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965066AbeFYSyB (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:54:01 -0400
Received: from mail-qt0-f201.google.com ([209.85.216.201]:51531 "EHLO
        mail-qt0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965046AbeFYSx4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:53:56 -0400
Received: by mail-qt0-f201.google.com with SMTP id k8-v6so1181788qtj.18
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:53:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=NQqKiskxr+IdjLPJH3dqwGXNtCOEV5qf7DFU8wNXrKg=;
        b=qyC6Hdbov9C3CVYVd/IypghexZS+KX29ukVM3fMQNcK+aNhrCQCtM0Il7142jl+tGA
         eRtzGm4HzgJdbUpNhLZpz4tFU2Qj8m7BHa9jNjEvcMgGIJHy0sf5ERwabTllFLXjTNI+
         E+iU24ne/jr2A5cAo/QDwvymMpMuCCW5pKrZbYBVPPJCZYNKKDssHxPQc6fJrM4J769Q
         LG8QIsX2uEmhV/NT82/gCVzrwLhh/HRT6NcqSFuDZZAZBs4s/Rbyp0VzNj0RxGnWFikW
         VLzxcULdb9xl5Uxpb9u6/Uby/Paz5HdrCgMd9ZyLcmN8rPJ2/kbKvrF4Ki7CD5+uCE73
         dcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=NQqKiskxr+IdjLPJH3dqwGXNtCOEV5qf7DFU8wNXrKg=;
        b=qB+vasYiNhmfdS8X3LBvjSKZ4YOA7MgjVLmpYKK5euwjCRMlF79AQUvfGhh+zx43BZ
         E3z0zJ8p4V+EiQpTMvOT3fWXVaapI8dtVR/FlqWj/i/yOZT9r7hqJOjwIocDA4kkOhiP
         V+ftvtV9bmzOBaScMYLlmoxbXdwyWWLdfbwAO6X54ZmSZ2kev3cAjfClLh4hsqY1pCIU
         y75mkcLomI+aj9IWguuhbK0DIxVdUojAnvyIuDTUS35wRU4yKg9vfvekxaDlq0V5GKD/
         gz4fmf0F/PpnTbvqtGu0ovjE8xI1oLQ9UiQB0QAimS06wu3yIySwUBHW9GCHwoI4J5wy
         yAzQ==
X-Gm-Message-State: APt69E27qG2YrkNzTrBXPTksQ2KfUIuFd+77uErADbOmsfAo8I1nt8K4
        Zf+O6jZCLnpvPodkBq7LI03y3B7yIu0gfzRLu6kNgVbvCBrz+LFC2hLrydt3Rm6AvsXFxXhe2Aa
        WMzGmg+nB9498BWBSFdznQ+2HHP0q46CHA+RvbNkEuMChuUuEjnTMiYQXGw==
X-Google-Smtp-Source: AAOMgped9aKJduoyHvCbIC4jKwiaz0i8AwpquErhibVYWIloNl1ppv6teh8a0vuoKC9j50F5Z1pjTLV1hbg=
MIME-Version: 1.0
X-Received: by 2002:a0c:cdcc:: with SMTP id a12-v6mr7220390qvn.44.1529952835305;
 Mon, 25 Jun 2018 11:53:55 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:53:32 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180625185332.164142-9-bmwill@google.com>
References: <20180620213235.10952-1-bmwill@google.com> <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v4 8/8] fetch-pack: implement ref-in-want
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
 fetch-pack.c                       | 35 +++++++++++++++++++++++++++---
 remote.c                           |  1 +
 remote.h                           |  1 +
 t/t5703-upload-pack-ref-in-want.sh |  4 ++--
 4 files changed, 36 insertions(+), 5 deletions(-)

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
2.18.0.rc2.346.g013aa6912e-goog

