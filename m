Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D79E5C11F6E
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD3AD613B9
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232286AbhGJNki (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhGJNkd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:33 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 141A8C061786
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id d12so15872629wre.13
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y2u6VsoElTul7SYGEO8+qocLzqltnHY0SDx6Uasol4M=;
        b=PU0Rd7XrXryyGBLE2Z/QFqPJj4UkZH9fDGWVucNSWqSS34RWxsg1c9ifuwbqtz/4w1
         n6xFhEXdDUHTbuWCOme3K1jo31yO4q+VIOepUr/bhcTHl8Cieb2ehuFFHk1D034ZDD3s
         gWjh/KbYmsO7KCN0d1aCwguw5x9+ER+VnjRpoLx/M9LQA86JARqq28qZLxmX349x9SxC
         BjQQYNd0pMsdDTkIM7s0seld/CRZKChHvjXh2RECS7to6rWL8+jpwIzWvG5JH/nYgPYo
         3GXOAmG0cp0FyfatWIApHH8ZmQFAc6fWn/LSeLAP7+NnEZ/LgJGmMaUDEtpygrZzxkQV
         3m/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2u6VsoElTul7SYGEO8+qocLzqltnHY0SDx6Uasol4M=;
        b=TbUEmUGWmRAwU2RLe1VWDhpew/pOqwqbCtoftQEpMVnl3CsY3xJsif0PdElC8QsbkK
         zOkqgVMXZ++G7rILohctsUnb0qfA4wjWx7EyknRRUDUi+BoUKsUaxsGew3J9U7agryEw
         XH2j/xKfPdlUJL/9wrjPPDEeA3TfBPcZJwvn5lroZOuXm5s2vOh3IvIIWS5+al/6TMuN
         qWrHKdyXBV+tlyqh/P1N8yCSGuibAxMruUDyyFURVRUvMSU7T79AM4tgdleTC5KQQ75f
         3mEWWlXYdV5wNxc5uSYl0w1nAzkaDERMvvk4/OkvTaVrkFpjk7l3F4j6r0YjCcsJNewa
         Lr/Q==
X-Gm-Message-State: AOAM532e4ebziGfNDbjLERCNcUSqXAWWdldF3B55iVrZmJjBLgUp0x6M
        uIG19767zzVv8w1PQ7G8kAXjUJjMUbLOCA==
X-Google-Smtp-Source: ABdhPJwhSr6Fuyq3pp7k9+JXb9PjJ3bA8mPUHVw2d7sygXwqyyiAHYmcvGmK0LvHe73GvDa+uO6tFA==
X-Received: by 2002:a5d:4351:: with SMTP id u17mr47210971wrr.47.1625924263317;
        Sat, 10 Jul 2021 06:37:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 17/21] object-file.c: return -2 on "header too long" in unpack_loose_header()
Date:   Sat, 10 Jul 2021 15:37:20 +0200
Message-Id: <patch-17.21-7e101f97646-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the return code for "header too long" from the generic
negative return value unpack_loose_header() returns, and report via
error() if we exceed MAX_HEADER_LEN.

As a test added earlier in this series in t1006-cat-file.sh shows
we'll correctly emit zlib errors from zlib.c already in this case, so
we have no need to carry those return codes further down the
stack. Let's instead just return -2 saying we ran into the
MAX_HEADER_LEN limit, or other negative values for "unable to unpack
<OID> header".

I tried setting up an enum just for these three return values, but I
think the result was less readable. Let's consider doing that if we
gain even more return values. For now let's do the next best thing and
enumerate our known return values, and BUG() if we encounter one we
don't know about.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c       | 16 +++++++++++++---
 object-store.h      |  6 ++++--
 t/t1006-cat-file.sh |  2 +-
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/object-file.c b/object-file.c
index 956ca260518..1866115a1c5 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1243,7 +1243,7 @@ int unpack_loose_header(git_zstream *stream,
 	 * --allow-unknown-type".
 	 */
 	if (!header)
-		return -1;
+		return -2;
 
 	/*
 	 * buffer[0..bufsiz] was not large enough.  Copy the partial
@@ -1264,7 +1264,7 @@ int unpack_loose_header(git_zstream *stream,
 		stream->next_out = buffer;
 		stream->avail_out = bufsiz;
 	} while (status != Z_STREAM_END);
-	return -1;
+	return -2;
 }
 
 static void *unpack_loose_rest(git_zstream *stream,
@@ -1433,9 +1433,19 @@ static int loose_object_info(struct repository *r,
 
 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				      allow_unknown ? &hdrbuf : NULL);
-	if (hdr_ret < 0) {
+	switch (hdr_ret) {
+	case 0:
+		break;
+	case -1:
 		status = error(_("unable to unpack %s header"),
 			       oid_to_hex(oid));
+		break;
+	case -2:
+		status = error(_("header for %s too long, exceeds %d bytes"),
+			       oid_to_hex(oid), MAX_HEADER_LEN);
+		break;
+	default:
+		BUG("unknown hdr_ret value %d", hdr_ret);
 	}
 	if (!status) {
 		if (!parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi))
diff --git a/object-store.h b/object-store.h
index 65a8e4dc6a8..1151ce8e820 100644
--- a/object-store.h
+++ b/object-store.h
@@ -481,13 +481,15 @@ int for_each_packed_object(each_packed_object_fn, void *,
  * unpack_loose_header() initializes the data stream needed to unpack
  * a loose object header.
  *
- * Returns 0 on success. Returns negative values on error.
+ * Returns 0 on success. Returns negative values on error. If the
+ * header exceeds MAX_HEADER_LEN -2 will be returned.
  *
  * It will only parse up to MAX_HEADER_LEN bytes unless an optional
  * "hdrbuf" argument is non-NULL. This is intended for use with
  * OBJECT_INFO_ALLOW_UNKNOWN_TYPE to extract the bad type for (error)
  * reporting. The full header will be extracted to "hdrbuf" for use
- * with parse_loose_header().
+ * with parse_loose_header(), -2 will still be returned from this
+ * function to indicate that the header was too long.
  */
 int unpack_loose_header(git_zstream *stream, unsigned char *map,
 			unsigned long mapsize, void *buffer,
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 86fd2a90ca7..06d38e1fae6 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -440,7 +440,7 @@ bogus_sha1=$(echo_without_newline "$bogus_content" | git hash-object -t $bogus_t
 
 test_expect_success 'die on broken object with large type under -t and -s without --allow-unknown-type' '
 	cat >err.expect <<-EOF &&
-	error: unable to unpack $bogus_sha1 header
+	error: header for $bogus_sha1 too long, exceeds 32 bytes
 	fatal: git cat-file: could not get object info
 	EOF
 
-- 
2.32.0.636.g43e71d69cff

