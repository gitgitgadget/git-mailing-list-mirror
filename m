Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC7A0C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EF91611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhETM16 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233106AbhETM0x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F82AC0AF7BD
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w12so11189051edx.1
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5s47HNmbDVPDWoUxUQJgwmK6VMW/ZEK0NUqt7d71NvQ=;
        b=KNCpE4KoErmoN5zMGAm7wx1fk2FRVhU+5XTRZ9I1eWsoYDyl6Nc00yoU4Lg2689tha
         gozo9tCxYP5jM8D7Hfiih858u/YyEOj66Uvd++A+LhmVM0zgjJcUeSZ31mDZ1oaCF/QL
         Wk915Fa85lUhxkyDlxbHoMZbrpJim5zBzgu4bOpy2yRvl8XV2ZeA+dhjEuFDFU7fCt/e
         Fp3FUYyGGfdW3xXvfRuapF4YmGx4yb/V4y5cabdUvXs82xkYvOGHwb4IB49BFGFe63v1
         td5U/CndxNd6KFDbirkaeeT4QhKBXwsy6yzJokQRlnur8CmEJrSe4PYcIsaHKJ9oX2Hh
         cnIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5s47HNmbDVPDWoUxUQJgwmK6VMW/ZEK0NUqt7d71NvQ=;
        b=MZMwVKes1lu4SJlY6yHCb0NoEie8ZI6naVYPPIYo2YMgO34NcwKhvfTKkrQqSC9Xzk
         2JQZYh1lTzPHSxKm/Mx5BRaGKyFcLdUY07wrieYMxl/dhJNcUzAexI0ZYz/cmHaEha6W
         /czyVVLAu2ZRWTvabi7t3jL8YwleJN3kXHu6RtduFrO3L6nVDtsca8FrmqNzUCNV6EYr
         xxL8xGEapFydUTwznJZjsL7/3aBLOX4LtSbaXtC9gEmUuZjoV/MNwKAg1FcnKeTgyPim
         OVgMzo8hl/pF7movgG1T0ZywUbBapvwGnqSwolYWCKng++fg5QTYFB8a5gJEUnjaLykV
         ENjQ==
X-Gm-Message-State: AOAM532Nu2l51hXDjFj7357GFhF4GdP62UeUfbpGHlt3gfSj4UQGVT6/
        zdB+swpvaOcwmtELz6EJtDj9Hm4jd/yIRQ==
X-Google-Smtp-Source: ABdhPJzn0uqxGy4iH64N3XC2LgdS5Dif6j4b9sdJQaEbLh8eh4UIsSvGEWB9t5zm73KOTAi7CwMO+g==
X-Received: by 2002:a05:6402:42cc:: with SMTP id i12mr4579669edc.272.1621509804835;
        Thu, 20 May 2021 04:23:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 12/17] object-file.c: return -2 on "header too long" in unpack_loose_header()
Date:   Thu, 20 May 2021 13:23:06 +0200
Message-Id: <patch-12.17-77f2cd439c-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
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

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c       | 15 ++++++++++-----
 object-store.h      |  6 ++++--
 t/t1006-cat-file.sh |  2 +-
 3 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/object-file.c b/object-file.c
index d4bdf86657..7623ada1aa 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1240,10 +1240,10 @@ int unpack_loose_header(git_zstream *stream,
 	/*
 	 * We have a header longer than MAX_HEADER_LEN. We abort early
 	 * unless under we're running as e.g. "cat-file
-	 * --allow-unknown-type".
+	 * --allow-unknown-type". A -2 is "header too long"
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
@@ -1433,9 +1433,14 @@ static int loose_object_info(struct repository *r,
 	hdr_ret = unpack_loose_header(&stream, map, mapsize, hdr, sizeof(hdr),
 				      allow_unknown ? &hdrbuf : NULL);
 	if (hdr_ret < 0) {
-		status = error(_("unable to unpack %s header"),
-			       oid_to_hex(oid));
+		if (hdr_ret == -2)
+			status = error(_("header for %s too long, exceeds %d bytes"),
+				       oid_to_hex(oid), MAX_HEADER_LEN);
+		else
+			status = error(_("unable to unpack %s header"),
+				       oid_to_hex(oid));
 	}
+
 	if (!status && parse_loose_header(hdrbuf.len ? hdrbuf.buf : hdr, oi) < 0) {
 		status = error(_("unable to parse %s header"), oid_to_hex(oid));
 	}
diff --git a/object-store.h b/object-store.h
index 740edcac30..9accb614fc 100644
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
index d3d3fd733a..f12b06150e 100755
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
2.32.0.rc0.406.g73369325f8d

