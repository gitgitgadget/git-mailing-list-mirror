Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67CCFC433EF
	for <git@archiver.kernel.org>; Fri, 10 Dec 2021 10:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237787AbhLJKil (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Dec 2021 05:38:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237753AbhLJKij (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Dec 2021 05:38:39 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A81CEC0617A1
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:04 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id gx15-20020a17090b124f00b001a695f3734aso7208363pjb.0
        for <git@vger.kernel.org>; Fri, 10 Dec 2021 02:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8RIOZi6mNEfRi49dnVxnJHTjMXcQln8hiHrUNS8zAww=;
        b=MlyZSeNS8OHOh6KPERV4fDyYcNVhPHKjQye702jD71xwRkgs9UbcrdmM5e1MZpQyk3
         H6dTPBX3TBBuZ+48BvU5b4MhCPvY8RtyCM1mIeCOmbDIr6oFy/vCpVghYVirAE/UMrpT
         5FafccmLzEEZt9RYujWQdinHWFdd5r5/LtRq00oFoCMNh5MkRwMxlRR+YUMuj5n0X+N5
         6KX9RPmnLSIQTEmDgd+d0B4gtLyZJ7+8uF+MKfj+SeIIJUfS/+dhb+Rmqqc9/kD6+t3n
         jFrjMvXIJXQH7JLwRYLhIYprHu+OEilL33+ue6bzG/2JmjtDqZH8ajORSzIyZXYRPyyU
         Salw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8RIOZi6mNEfRi49dnVxnJHTjMXcQln8hiHrUNS8zAww=;
        b=hvTOYhErdKu7UwhrS9lQEcJT+wRVKhm9RqzZnCnyWWfcR0wPljHoJ6Qfd3fEUX5xto
         Lv7idS1rhGxLMS4HFoI3VOg5Yt5khBfdjlHQxrEBOLJJ3WGeCGU2TI+V9zWuyIsp6tmU
         KE/GKhzholICPZnj+J3M6a3u0JPrV94oOHkHIeu3UO1uW/MNmsliyRcrm2M257JH6rhM
         atdjVP6L1xhLw+y2HR1Wbc7sIsxzYhhjo35o6wXT01YS6r5mBjIVnziH4ozcv1yeNXQ2
         YD5bDeGsNIOVCYL2fsqmkcd/+1FuvgAvoYR8ByNPAXLb2+f6ubLKJGIdRrp07GJhX0LG
         CGAg==
X-Gm-Message-State: AOAM530OZr4V1FDNr057leojegJjk8GnMnBxcv75FBSYm1TPKPdaxRV+
        4IYbiyEZaIFYiDYH/jpezJU=
X-Google-Smtp-Source: ABdhPJyztp9RPAe8OxRnm5yKKJCgrUoDjUComAK31KHXa9Ppj5aWTD9a1QGQK9js9A6DWPPrqbI3zQ==
X-Received: by 2002:a17:90a:c297:: with SMTP id f23mr22903293pjt.138.1639132504251;
        Fri, 10 Dec 2021 02:35:04 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.96])
        by smtp.gmail.com with ESMTPSA id 204sm2396250pgb.63.2021.12.10.02.35.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Dec 2021 02:35:03 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v5 2/6] object-file.c: handle undetermined oid in write_loose_object()
Date:   Fri, 10 Dec 2021 18:34:31 +0800
Message-Id: <20211210103435.83656-3-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

When streaming a large blob object to "write_loose_object()", we have no
chance to run "write_object_file_prepare()" to calculate the oid in
advance. So we need to handle undetermined oid in function
"write_loose_object()".

In the original implementation, we know the oid and we can write the
temporary file in the same directory as the final object, but for an
object with an undetermined oid, we don't know the exact directory for
the object, so we have to save the temporary file in ".git/objects/"
directory instead.

The promise that "oid" is constant in "write_loose_object()" has been
removed because it will be filled after reading all stream data.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 48 +++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 9 deletions(-)

diff --git a/object-file.c b/object-file.c
index 06375a90d6..41099b137f 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1860,11 +1860,11 @@ static int create_tmpfile(struct strbuf *tmp, const char *filename)
 	return fd;
 }
 
-static int write_loose_object(const struct object_id *oid, char *hdr,
+static int write_loose_object(struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
 {
-	int fd, ret;
+	int fd, ret, err = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_hash_ctx c;
@@ -1872,16 +1872,21 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 	static struct strbuf tmp_file = STRBUF_INIT;
 	static struct strbuf filename = STRBUF_INIT;
 
-	loose_object_path(the_repository, &filename, oid);
+	if (flags & HASH_STREAM)
+		/* When oid is not determined, save tmp file to odb path. */
+		strbuf_addf(&filename, "%s/", get_object_directory());
+	else
+		loose_object_path(the_repository, &filename, oid);
 
 	fd = create_tmpfile(&tmp_file, filename.buf);
 	if (fd < 0) {
 		if (flags & HASH_SILENT)
-			return -1;
+			err = -1;
 		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
+			err = error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
 		else
-			return error_errno(_("unable to create temporary file"));
+			err = error_errno(_("unable to create temporary file"));
+		goto cleanup;
 	}
 
 	/* Set it up */
@@ -1923,12 +1928,34 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
 		    ret);
 	the_hash_algo->final_oid_fn(&parano_oid, &c);
-	if (!oideq(oid, &parano_oid))
+	if (!(flags & HASH_STREAM) && !oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
 	close_loose_object(fd);
 
+	if (flags & HASH_STREAM) {
+		int dirlen;
+
+		oidcpy((struct object_id *)oid, &parano_oid);
+		loose_object_path(the_repository, &filename, oid);
+
+		/* We finally know the object path, and create the missing dir. */
+		dirlen = directory_size(filename.buf);
+		if (dirlen) {
+			struct strbuf dir = STRBUF_INIT;
+			strbuf_add(&dir, filename.buf, dirlen - 1);
+			if (mkdir(dir.buf, 0777) && errno != EEXIST)
+				err = -1;
+			else if (adjust_shared_perm(dir.buf))
+				err = -1;
+			else
+				strbuf_release(&dir);
+			if (err < 0)
+				goto cleanup;
+		}
+	}
+
 	if (mtime) {
 		struct utimbuf utb;
 		utb.actime = mtime;
@@ -1938,7 +1965,10 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 			warning_errno(_("failed utime() on %s"), tmp_file.buf);
 	}
 
-	return finalize_object_file(tmp_file.buf, filename.buf);
+	err = finalize_object_file(tmp_file.buf, filename.buf);
+cleanup:
+	strbuf_release(&filename);
+	return err;
 }
 
 static int freshen_loose_object(const struct object_id *oid)
@@ -2015,7 +2045,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	if (!buf)
 		return error(_("cannot read object for %s"), oid_to_hex(oid));
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
+	ret = write_loose_object((struct object_id*) oid, hdr, hdrlen, buf, len, mtime, 0);
 	free(buf);
 
 	return ret;
-- 
2.34.0

