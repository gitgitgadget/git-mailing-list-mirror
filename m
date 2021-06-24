Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33124C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EDDE610C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232999AbhFXT1H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233005AbhFXT0q (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:46 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B47C0613A4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:20 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso6960592wmh.4
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m0yTtma1BMczrDwck/fpOLf3OntEx8FhES6ksWbl8iA=;
        b=drrFTGZ2DjVLDDZNfVz+Lp4lNpSBJH/JjBiI26CF25SZX8C5F5W/AIMUmJuEbnblVd
         nF1vhHUMVb9kWAGH5IJngl8w0FQwjCyJMxsPBAkSTcxFfuZLpkMHHfI2emg+Bt3Injd8
         /SvFPUU9/UHWe4pZoYMdk5lDZCvmAqtTrzBf2jNlYRNXR6mj8UcYBY7BNt191BglQs6N
         p4mH3Byto7zOlSOXrp7BlYJN+hlpFby0U2cVXbwdDAklEnuWtUOnNeOMKcSV/8san45z
         /18HIzQGYl+NFAVUMpSYz8Wqh4lKcWrP5nQimMQufTCYmAxbwRCL/Z4WCwosHwlRpYJa
         zL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m0yTtma1BMczrDwck/fpOLf3OntEx8FhES6ksWbl8iA=;
        b=C0I8bTsrzVvNAckyKids6alSkUgxhfgbUys3up+qwE15zgJWth/FfBoLIIAOfJIQLx
         +Zc7V1SiAQZiXQi2yrkgaY08u3GKKGZqhW3S1vHQCVjBrbGXu5T/CFVhilQCILiy1Sl/
         gBRjYJ1kPznvMnRvdOG+BYZ+twXJFhMAIm2riu5W1+VQldErNxYW1AvPDlZOZ1r43CcW
         obZBaem+NQLjLxlRQy5sO1mukMC9qja5rwtEFwVvS0UimW/orO8ez2IYHYfWZ3Q28iht
         WlLkNKxV1+Kwg7+ZiPyTJSEFaP/Qv1jvBgprygM5n6POPzOIWxNqaxR6RM1M5+UpxyjP
         1bJA==
X-Gm-Message-State: AOAM531AzrUXbvhdDKN2vfbcbbBhdULaeGl8MO9kBBM+iW8VkrBk//SR
        qbI1/CyXdCFoIMMV86bWn7YZRpiSf3akaA==
X-Google-Smtp-Source: ABdhPJzdi9ET4rnvJCcDN1NKAzOEf5rKONE1p0M+StaUTY5gW8BqandnAkUcpi4s5z2KfffgMSFSPw==
X-Received: by 2002:a1c:2584:: with SMTP id l126mr6053527wml.83.1624562659120;
        Thu, 24 Jun 2021 12:24:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 17/21] object-file.c: return -2 on "header too long" in unpack_loose_header()
Date:   Thu, 24 Jun 2021 21:23:55 +0200
Message-Id: <patch-17.21-78e3152fd94-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
2.32.0.606.g2e440ee2c94

