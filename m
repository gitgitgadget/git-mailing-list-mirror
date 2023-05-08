Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C64A1C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234508AbjEHWAb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234503AbjEHWAP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 18:00:15 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C8F902A
        for <git@vger.kernel.org>; Mon,  8 May 2023 15:00:07 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-55cc8aadc97so76718147b3.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 15:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583206; x=1686175206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AQdeURv9Ds0ZzUIXG/mLerajMScjALRyBD6QMAArqy8=;
        b=EaqcsrAZXXtUWaUy7W5IppN5b+PZRkXcFP4qJ70Kyy6Lf23TmzGmXcQfQ870N7pD12
         dfXr0p1FBJ+p7Ov3M8bg8fXnQdOtXQWJiMiOIGZy8t/m1ELqhHX1fdfWv2kzI6Kz7a8E
         S41GtKGfywQHwIKy/+F+tSrAoYKcLLfqOVe78x3O0m44sE2woVMs+RgiLO0XKXppw2xh
         Lk/kDt+GTbQOwOy3n9kn8ePSKTaRvr2itqXY79M59TR7VYXMHECpuXodeMtyW9mY54DX
         HjQNKMNspFfKR7ewck4ctsAeaJFo5tnHscuuoc1AGVJSv1byS/CXSAXKj/qqnjC1HaNx
         Y8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583206; x=1686175206;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQdeURv9Ds0ZzUIXG/mLerajMScjALRyBD6QMAArqy8=;
        b=C0/m0nXyIJBBtObbxglf+Aw/1VfO2kuhyMh0mwkCZV/2ZWgbZXy4mpFQhsmkHunavb
         NXRypmrgEYV9Of7j82OHV8JmVfjMig4Kgm8PqVJSpP8yROMTq0JaTI9+pLqERpPKnZXI
         ps2Sz1mjvf3dtwI4nvXjr+BsCPNRTwCFLuJ3xion+8abZyu9BhD94aR6fw0ST4UAuSMJ
         S2AwjNow2NJscMc8/FFgWAtuSV/GHMXZsBcZaMfhKPImOL8P84a8DLrI0HI0ydrQYvvt
         uNslTpSXDHBJ7TCTD70hoUq0nTuZCZFZjqj8TkrUdekKMcs7NbBPkK2t5VWg0BC8P8xM
         jzSA==
X-Gm-Message-State: AC+VfDxuRHoHI05UxclZxl304XBuoF0lInKfPODnAq612c9PDFNZjdZl
        TuYgJw4VHOT21OGl4rcaqljFJqTlfDkJNnWQWK/WmA==
X-Google-Smtp-Source: ACHHUZ4sc5XWO7+M/wHel5YQgkhnCzCVm6s176LVg46dt/OTf+aXtNPsdxP58GTOH8KNx4kIBbshcQ==
X-Received: by 2002:a0d:e853:0:b0:55c:2511:b30c with SMTP id r80-20020a0de853000000b0055c2511b30cmr13119834ywe.5.1683583206662;
        Mon, 08 May 2023 15:00:06 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u205-20020a8147d6000000b00545a08184cesm2779077ywa.94.2023.05.08.15.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 15:00:06 -0700 (PDT)
Date:   Mon, 8 May 2023 18:00:05 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 08/15] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <836a5665b7df065811edc678cb8e70004f7b7c49.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The function `find_reference_location()` is used to perform a
binary search-like function over the contents of a repository's
`$GIT_DIR/packed-refs` file.

The search it implements is unlike a standard binary search in that the
records it searches over are not of a fixed width, so the comparison
must locate the end of a record before comparing it.

Extract the core routine of `find_reference_location()` in order to
implement a function in the following patch which will find the first
location in the `packed-refs` file that *doesn't* match the given
pattern.

The behavior of `find_reference_location()` is unchanged.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 refs/packed-backend.c | 46 +++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index e54e78e540..98f96bf3ee 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -302,7 +302,8 @@ static int cmp_packed_ref_records(const void *v1, const void *v2)
  * Compare a snapshot record at `rec` to the specified NUL-terminated
  * refname.
  */
-static int cmp_record_to_refname(const char *rec, const char *refname)
+static int cmp_record_to_refname(const char *rec, const char *refname,
+				 int start)
 {
 	const char *r1 = rec + the_hash_algo->hexsz + 1;
 	const char *r2 = refname;
@@ -311,7 +312,7 @@ static int cmp_record_to_refname(const char *rec, const char *refname)
 		if (*r1 == '\n')
 			return *r2 ? -1 : 0;
 		if (!*r2)
-			return 1;
+			return start ? 1 : -1;
 		if (*r1 != *r2)
 			return (unsigned char)*r1 < (unsigned char)*r2 ? -1 : +1;
 		r1++;
@@ -526,22 +527,9 @@ static int load_contents(struct snapshot *snapshot)
 	return 1;
 }
 
-/*
- * Find the place in `snapshot->buf` where the start of the record for
- * `refname` starts. If `mustexist` is true and the reference doesn't
- * exist, then return NULL. If `mustexist` is false and the reference
- * doesn't exist, then return the point where that reference would be
- * inserted, or `snapshot->eof` (which might be NULL) if it would be
- * inserted at the end of the file. In the latter mode, `refname`
- * doesn't have to be a proper reference name; for example, one could
- * search for "refs/replace/" to find the start of any replace
- * references.
- *
- * The record is sought using a binary search, so `snapshot->buf` must
- * be sorted.
- */
-static const char *find_reference_location(struct snapshot *snapshot,
-					   const char *refname, int mustexist)
+static const char *find_reference_location_1(struct snapshot *snapshot,
+					     const char *refname, int mustexist,
+					     int start)
 {
 	/*
 	 * This is not *quite* a garden-variety binary search, because
@@ -571,7 +559,7 @@ static const char *find_reference_location(struct snapshot *snapshot,
 
 		mid = lo + (hi - lo) / 2;
 		rec = find_start_of_record(lo, mid);
-		cmp = cmp_record_to_refname(rec, refname);
+		cmp = cmp_record_to_refname(rec, refname, start);
 		if (cmp < 0) {
 			lo = find_end_of_record(mid, hi);
 		} else if (cmp > 0) {
@@ -587,6 +575,26 @@ static const char *find_reference_location(struct snapshot *snapshot,
 		return lo;
 }
 
+/*
+ * Find the place in `snapshot->buf` where the start of the record for
+ * `refname` starts. If `mustexist` is true and the reference doesn't
+ * exist, then return NULL. If `mustexist` is false and the reference
+ * doesn't exist, then return the point where that reference would be
+ * inserted, or `snapshot->eof` (which might be NULL) if it would be
+ * inserted at the end of the file. In the latter mode, `refname`
+ * doesn't have to be a proper reference name; for example, one could
+ * search for "refs/replace/" to find the start of any replace
+ * references.
+ *
+ * The record is sought using a binary search, so `snapshot->buf` must
+ * be sorted.
+ */
+static const char *find_reference_location(struct snapshot *snapshot,
+					   const char *refname, int mustexist)
+{
+	return find_reference_location_1(snapshot, refname, mustexist, 1);
+}
+
 /*
  * Create a newly-allocated `snapshot` of the `packed-refs` file in
  * its current state and return it. The return value will already have
-- 
2.40.1.477.g956c797dfc

