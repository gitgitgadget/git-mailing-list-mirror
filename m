Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9559FC433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7225560EFD
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 09:42:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbhKLJow (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 04:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234855AbhKLJov (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 04:44:51 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB99C061766
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:01 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id gb13-20020a17090b060d00b001a674e2c4a8so7139176pjb.4
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 01:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIGGY4gMqk8UtNQzWhaZzUHKIEXuvW8JN2xdt8ujWtg=;
        b=PqImHcybrXM9uRLuSvWRYqYB/oLBbrQrcIbrqoRQG47uv3gkX7+a6fxXUxSpo4o3nW
         EaBayLbWVpxUFOQth2R6Z0V7NhculFD+fqjFDUyl9l/L8wmJ44McxRN/NhVPRCoGLskt
         3P4j4r6QZI/tAXNKsPHmdvydI63wp2vF8XCLaU82lVqKPx6osQIibNkPVglr8ljUta3Q
         KJxqcMLMQ7HFDa24KhT4JOAYPVwSVftXMLI+acTkI6IMZypTr/oZbnk5OgPYp0Rexjmk
         Xu53FBWGu0CciPDINljyQ+iuvZJhi0P5xSjucQCyrerMI70N36TtrFka+fWtYtTLpQrg
         bPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIGGY4gMqk8UtNQzWhaZzUHKIEXuvW8JN2xdt8ujWtg=;
        b=hKshss6IjiKlSvrqE1MxMp/OtQl9x9XaJAAh/UuU6Js5o/WhYHGHUTWwyUR7IELYpQ
         ZPw8FHGHZM/gUFOhR69FaqDk2D90eD6l25jT2JH0nunFS+9bbaA8W/SF39XkrFAwo6/i
         rSX/o3S/cx1c2HSnVHXEUmY13Tn+h1xODgGmf36/JNVnFCGdFHb3sLEd/F/9Q6vVwaZu
         0j2ey3a2j958y/OAhF4qJNYPMRd9tlQCV5Af9jZbnepPd8jnxJ66v2ms3qnYgJ4oDIf+
         o/TjrUYHTTyIUp66jgVSIlHy460/5yxpWoSXr1YTYb7k8VBTCNe8oRuO40/0qWtpWYMI
         sbjw==
X-Gm-Message-State: AOAM531tDuLkw+Jn76NlgHsaO5HtahAHjRzmVrJc5tVgTGrvdvzcy7oa
        Sesa10pC38/T92Xs/+wGbvg=
X-Google-Smtp-Source: ABdhPJxGPV8akuMU+kKP/N3ztL60KqD6DNbNIZsjtMhvSVKoPJTmXXDyfQTBb67YhGi9Fu5UmNkRBQ==
X-Received: by 2002:a17:90b:1c02:: with SMTP id oc2mr16350857pjb.65.1636710120790;
        Fri, 12 Nov 2021 01:42:00 -0800 (PST)
Received: from localhost.localdomain ([205.204.117.100])
        by smtp.gmail.com with ESMTPSA id q18sm6310103pfj.46.2021.11.12.01.41.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Nov 2021 01:42:00 -0800 (PST)
From:   Han Xin <chiyutianyi@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
Subject: [PATCH v2 2/6] object-file.c: add dry_run mode for write_loose_object()
Date:   Fri, 12 Nov 2021 17:40:06 +0800
Message-Id: <20211112094010.73468-2-chiyutianyi@gmail.com>
X-Mailer: git-send-email 2.33.1.44.g9344627884.agit.6.5.4
In-Reply-To: <20211009082058.41138-1-chiyutianyi@gmail.com>
References: <20211009082058.41138-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han Xin <hanxin.hx@alibaba-inc.com>

We will use "write_loose_object()" later to handle large blob object,
which needs to work in dry_run mode.

Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
---
 object-file.c | 32 +++++++++++++++++++-------------
 1 file changed, 19 insertions(+), 13 deletions(-)

diff --git a/object-file.c b/object-file.c
index 1ad2cb579c..b0838c847e 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1880,9 +1880,10 @@ static const char *read_input_stream_from_buffer(void *data, unsigned long *len)
 
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, struct input_stream *in_stream,
+			      int dry_run,
 			      time_t mtime, unsigned flags)
 {
-	int fd, ret;
+	int fd, ret = 0;
 	unsigned char compressed[4096];
 	git_zstream stream;
 	git_hash_ctx c;
@@ -1894,14 +1895,16 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 
 	loose_object_path(the_repository, &filename, oid);
 
-	fd = create_tmpfile(&tmp_file, filename.buf);
-	if (fd < 0) {
-		if (flags & HASH_SILENT)
-			return -1;
-		else if (errno == EACCES)
-			return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
-		else
-			return error_errno(_("unable to create temporary file"));
+	if (!dry_run) {
+		fd = create_tmpfile(&tmp_file, filename.buf);
+		if (fd < 0) {
+			if (flags & HASH_SILENT)
+				return -1;
+			else if (errno == EACCES)
+				return error(_("insufficient permission for adding an object to repository database %s"), get_object_directory());
+			else
+				return error_errno(_("unable to create temporary file"));
+		}
 	}
 
 	/* Set it up */
@@ -1925,7 +1928,7 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		unsigned char *in0 = stream.next_in;
 		ret = git_deflate(&stream, Z_FINISH);
 		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
-		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
+		if (!dry_run && write_buffer(fd, compressed, stream.next_out - compressed) < 0)
 			die(_("unable to write loose object file"));
 		stream.next_out = compressed;
 		stream.avail_out = sizeof(compressed);
@@ -1943,6 +1946,9 @@ static int write_loose_object(const struct object_id *oid, char *hdr,
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
 
+	if (dry_run)
+		return 0;
+
 	close_loose_object(fd);
 
 	if (mtime) {
@@ -1996,7 +2002,7 @@ int write_object_file_flags(const void *buf, unsigned long len,
 				  &hdrlen);
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		return 0;
-	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, flags);
+	return write_loose_object(oid, hdr, hdrlen, &in_stream, 0, 0, flags);
 }
 
 int hash_object_file_literally(const void *buf, unsigned long len,
@@ -2023,7 +2029,7 @@ int hash_object_file_literally(const void *buf, unsigned long len,
 		goto cleanup;
 	if (freshen_packed_object(oid) || freshen_loose_object(oid))
 		goto cleanup;
-	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0);
+	status = write_loose_object(oid, header, hdrlen, &in_stream, 0, 0, 0);
 
 cleanup:
 	free(header);
@@ -2052,7 +2058,7 @@ int force_object_loose(const struct object_id *oid, time_t mtime)
 	data.buf = buf;
 	data.len = len;
 	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), (uintmax_t)len) + 1;
-	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, mtime, 0);
+	ret = write_loose_object(oid, hdr, hdrlen, &in_stream, 0, mtime, 0);
 	free(buf);
 
 	return ret;
-- 
2.33.1.44.g9344627884.agit.6.5.4

