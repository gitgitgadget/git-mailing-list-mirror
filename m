Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74E89C77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:24:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245207AbjEOTYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245100AbjEOTXk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:40 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4316613282
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:33 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-559e53d1195so187972877b3.2
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178612; x=1686770612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l2eMPZSz3knvl7ffREsnuCcw1LESbq6TfN+DVqj8seY=;
        b=wrpBYicBrTMlo5Qu7MBpNVMqH+b4J5BKlJHlK5lnalpVFFtTHxZ2zfSWT3jIt82Nle
         RYdJEZCgwanjEz7bGDM05vilo2rSM8kzKo5FLsA0bZYQhMBRAYtveq5g3pPObJrOO1r8
         eeeulyj0vPSOT8kxXbWZfBaFkvgxtoUFzWQou8OHseZBtUe7bywusYE3l7+rr2R5Sxzi
         k+D0Qjazs6GYSUt7kp8sNZsgncoGC9tOkouupbaKgkW/0jJoCxLMWcBQ3lcJON2dRaJO
         5hvIRs+TFlZG5Q0JoP/jwgG+X2xLyRxBHcmy/nuKw3kg2DKIyB5wEVfQr8PcGYEfaEHW
         5MwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178612; x=1686770612;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l2eMPZSz3knvl7ffREsnuCcw1LESbq6TfN+DVqj8seY=;
        b=fM+PGBbhRWt+9wPjf8H+o2ygCSPGfvIELH3zf+Btn6VazWCOPmQgd4KqYiaa0OT2XM
         Pc+w9DuZaFTIHwdRwf+0ARFnkCaAg3GL0fshWpud+1CVgl6EPS2EAaIDh4nZYeG3oX4N
         0FsBFA8Tag021y/vI1NQOL1R23Bc4TFS59eZkZ8TtwiCK6TE4GbrxAUvcrWjHaKmri5+
         Csjm16PcCGKBbZK/Tj9vaWTXnodF2z4i9DMmDsgq5N50zCKbAPN2wi3HrEJYlthMyleH
         NmrX2NGFqGrxxLH32UK8BOh3rA03d7cLtiRM/jnLcWAvPNbSMGqTP5HEMVfL8KMpPKeg
         0khQ==
X-Gm-Message-State: AC+VfDw1KIxz4THQtJWyg/MoXcyZhlQrnIqBGHzUcwtJO3/jDPL85gbp
        Nbz1qCtHIHbvuhZbVtfWCeM0qvSzlwtuvIyf6mXTZg==
X-Google-Smtp-Source: ACHHUZ6wwTRV/zoWb1pKV6L0uubx867xEkt/N1SE57rbOnM6eKopOKc/9DJaBw67GYOvrBKs2qKYxA==
X-Received: by 2002:a81:920c:0:b0:55a:a635:7e1e with SMTP id j12-20020a81920c000000b0055aa6357e1emr36164488ywg.31.1684178612287;
        Mon, 15 May 2023 12:23:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w191-20020a0dd4c8000000b0054f50f71834sm9506ywd.124.2023.05.15.12.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:32 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:31 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 08/16] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <6002c568b54a3ea2b87f4eed13d342f6e63ec420.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
 refs/packed-backend.c | 38 ++++++++++++++++++++++----------------
 1 file changed, 22 insertions(+), 16 deletions(-)

diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 176bd3905b..33639f73e1 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -527,22 +527,8 @@ static int load_contents(struct snapshot *snapshot)
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
+					     const char *refname, int mustexist)
 {
 	/*
 	 * This is not *quite* a garden-variety binary search, because
@@ -588,6 +574,26 @@ static const char *find_reference_location(struct snapshot *snapshot,
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
+	return find_reference_location_1(snapshot, refname, mustexist);
+}
+
 /*
  * Create a newly-allocated `snapshot` of the `packed-refs` file in
  * its current state and return it. The return value will already have
-- 
2.40.1.572.g5c4ab523ef

