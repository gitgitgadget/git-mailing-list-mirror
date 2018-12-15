Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B556E20A1E
	for <e@80x24.org>; Sat, 15 Dec 2018 00:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729963AbeLOAJx (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Dec 2018 19:09:53 -0500
Received: from mail-pf1-f201.google.com ([209.85.210.201]:36507 "EHLO
        mail-pf1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726772AbeLOAJx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Dec 2018 19:09:53 -0500
Received: by mail-pf1-f201.google.com with SMTP id p9so5734028pfj.3
        for <git@vger.kernel.org>; Fri, 14 Dec 2018 16:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=MVDX573Eb6d7l4R6Y1nGqeqlAFP9pdIUA95wEwEWBJI=;
        b=JWIz4Sit1eq4TYpx7xMWQIerQWPbb1G03cs+db7DG2oHac+EF5kY7vukIx9Pa/1Sr2
         W+3y8PM/XhzSv0TYx+EzNGvYvcv9OuAOnAbSU4bj/+JCPT7v6diVkmFI5JGeDgNf2lv4
         Q/UqOLVtlJrHqSUFg1mMAyr+wQKnYzDsY+00K7scR4G+yMg5od8dHtsZkeklJzs3k9Iv
         nfHEPbXaOLvFaeG9ULjGaMmTrzomhub1POJ+/HX+/Hzhq9mxvJkT4ktbv8bsJXkuKSgX
         rdWNvmUcbrecZu62rv0mymo5pgfHkUH/lpNgdyTlJ5s8G0Ds8220QMmTOYuFX0QqQn6D
         dyGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=MVDX573Eb6d7l4R6Y1nGqeqlAFP9pdIUA95wEwEWBJI=;
        b=orYcux855dg5h5irtrnwsV/4M07EEpeJuzfOiLGrsE5ifBluaag5syhrr8FZznLk/W
         HiJ4SR2MEwpVxcGwxFAiP60SYu7rQXGVvxjUKEvm4O+wDkv2pr0X/6mcW/Xq1Qbploo0
         PID8gEbN5LJDMVEpbFU9J2qfKLv6Kv4hEX0dQ39qAD3PgVxGcOd5hUdgk3BWnRoyhgBJ
         /9UAGQUJsUiGOc7ujsh56VyotW36CMHYmSrJ/pJsnTOeQZxzskBiaspLmLSd7TdeLrvu
         QghDrICkQM7CZLfPaUNdF4Jm6clG7Cdj9JoxDWyYdGeSGUNVIYO1JKfJ77Mr+99jwedc
         MvQQ==
X-Gm-Message-State: AA+aEWYS+S2oWOUp5RT1FuMJ8nH+N/qwcMLG3AzzMEIBcvPd7ACGc33P
        Lsktv4iFNtBwClqrZeoKc3y8DR/df9rhEaR6RtxLNaD9nz2rmObBbUeAzWrY8HMsdezHrMPXLvw
        u+3XNAhKJqTYssYgjQBx5xiypfFiYpjUs+d9Mdd9ahENkqmtVyqhEDXP3nYgd
X-Google-Smtp-Source: AFSGD/WnYFzS9JF4Q4OrlCgFcO7zKIbURcv8LHnMM4yiOjddQfM9DN/hqu+ZtrmovnWOJ1qDoMtLuiqdl59R
X-Received: by 2002:a17:902:70c9:: with SMTP id l9mr2241527plt.86.1544832592417;
 Fri, 14 Dec 2018 16:09:52 -0800 (PST)
Date:   Fri, 14 Dec 2018 16:09:22 -0800
In-Reply-To: <20181215000942.46033-1-sbeller@google.com>
Message-Id: <20181215000942.46033-4-sbeller@google.com>
Mime-Version: 1.0
References: <20181215000942.46033-1-sbeller@google.com>
X-Mailer: git-send-email 2.20.0.405.gbc1bbc6f85-goog
Subject: [PATCH 03/23] object-store: allow read_object_file_extended to read
 from any repo
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

read_object_file_extended is not widely used, so migrate it all at once.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 object-store.h |  5 +++--
 sha1-file.c    | 11 ++++++-----
 streaming.c    |  2 +-
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/object-store.h b/object-store.h
index 63b7605a3e..3d98a682b2 100644
--- a/object-store.h
+++ b/object-store.h
@@ -161,12 +161,13 @@ void sha1_file_name(struct repository *r, struct strbuf *buf, const unsigned cha
 
 void *map_sha1_file(struct repository *r, const unsigned char *sha1, unsigned long *size);
 
-extern void *read_object_file_extended(const struct object_id *oid,
+extern void *read_object_file_extended(struct repository *r,
+				       const struct object_id *oid,
 				       enum object_type *type,
 				       unsigned long *size, int lookup_replace);
 static inline void *read_object_file(const struct object_id *oid, enum object_type *type, unsigned long *size)
 {
-	return read_object_file_extended(oid, type, size, 1);
+	return read_object_file_extended(the_repository, oid, type, size, 1);
 }
 
 /* Read and unpack an object file into memory, write memory to an object file */
diff --git a/sha1-file.c b/sha1-file.c
index 856e000ee1..c5b704aec5 100644
--- a/sha1-file.c
+++ b/sha1-file.c
@@ -1403,7 +1403,8 @@ int pretend_object_file(void *buf, unsigned long len, enum object_type type,
  * deal with them should arrange to call read_object() and give error
  * messages themselves.
  */
-void *read_object_file_extended(const struct object_id *oid,
+void *read_object_file_extended(struct repository *r,
+				const struct object_id *oid,
 				enum object_type *type,
 				unsigned long *size,
 				int lookup_replace)
@@ -1413,10 +1414,10 @@ void *read_object_file_extended(const struct object_id *oid,
 	const char *path;
 	struct stat st;
 	const struct object_id *repl = lookup_replace ?
-		lookup_replace_object(the_repository, oid) : oid;
+		lookup_replace_object(r, oid) : oid;
 
 	errno = 0;
-	data = read_object(the_repository, repl->hash, type, size);
+	data = read_object(r, repl->hash, type, size);
 	if (data)
 		return data;
 
@@ -1428,11 +1429,11 @@ void *read_object_file_extended(const struct object_id *oid,
 		die(_("replacement %s not found for %s"),
 		    oid_to_hex(repl), oid_to_hex(oid));
 
-	if (!stat_sha1_file(the_repository, repl->hash, &st, &path))
+	if (!stat_sha1_file(r, repl->hash, &st, &path))
 		die(_("loose object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), path);
 
-	if ((p = has_packed_and_bad(the_repository, repl->hash)) != NULL)
+	if ((p = has_packed_and_bad(r, repl->hash)) != NULL)
 		die(_("packed object %s (stored in %s) is corrupt"),
 		    oid_to_hex(repl), p->pack_name);
 
diff --git a/streaming.c b/streaming.c
index d1e6b2dce6..c843a1230f 100644
--- a/streaming.c
+++ b/streaming.c
@@ -490,7 +490,7 @@ static struct stream_vtbl incore_vtbl = {
 
 static open_method_decl(incore)
 {
-	st->u.incore.buf = read_object_file_extended(oid, type, &st->size, 0);
+	st->u.incore.buf = read_object_file_extended(the_repository, oid, type, &st->size, 0);
 	st->u.incore.read_ptr = 0;
 	st->vtbl = &incore_vtbl;
 
-- 
2.20.0.405.gbc1bbc6f85-goog

