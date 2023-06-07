Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D97FAC7EE2E
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239555AbjFGKlm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239614AbjFGKle (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:34 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3791BE8
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:32 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-565ee3d14c2so79801107b3.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134491; x=1688726491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLAuiGphArCHQszyrtInzCh2h7W2YrDAbAzRk8wtp14=;
        b=5GURjp5XAbNLDxclprkchMmZ9Lqh1euPYJiC+4wIMrxKGLAeWhSp9zw6w2SP4kmUOl
         FTRI0S8jNmlQG9jhwj7Y1zzpdGxWglQ9gcMVdFjsLdnxJ+euWyULFZkPIPTWLp8cK6v/
         g93BfdAd7AS3EzsTx8gfx93K/y5QubY4mc9XBvMxd/fnHxnI6iHast+2DkrweGoGQOI2
         Ge0MFI38WSmsGX5w0PgSOoFs9ynuEjN/kMIgtORgINTfJWhx4LVXqy6Qi77pS5VMkjvq
         bh3z8w9JVD/+kkpZFuHxvd4IbjyfgjoQkb+M3ixYJxzVZy8DzV3U0+cvXMGr04JMEkYW
         gdtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134491; x=1688726491;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xLAuiGphArCHQszyrtInzCh2h7W2YrDAbAzRk8wtp14=;
        b=SxBmzHMNTNofFFSCenv6kJFEViB5o2k4raA8/sANMRul+KAcW8UYzP/+HPFZKso/Cd
         5K/5oNu1flL+cApfIvO6X3a0BHZ2+twA0AuMLrhytsffV4AMLQi6dMWGuITJoLZ5JaM9
         GXfD0C3rj1FcKUmut7YFRKRnA2xdMPUDjYX1uVkF8BZ+6dLV0CeeSCUKEFRfNtiuuRAO
         K+yu3NGO8SInn0DS9fH8+OlkZEISknlXVcn9Wfpv8XXI2WcuxkqD0rBb5mduw8ftPhMY
         YEKU+mcdWNduntotdNPPnd5QG2glhjZTA0V4QYKHfohyz3BdujoPwm8o9BSohf/3Sawd
         ooPg==
X-Gm-Message-State: AC+VfDwDctGN7afsf1nr9JRXWN5FgIjMkNfyQMrjRa++AxMBnIRxNXxo
        BOUW3dherGMchKiRsoGgInjBjP9I9GuD51Hy5pcqZIIn
X-Google-Smtp-Source: ACHHUZ7p/tg87tS5boR0bdBYw50maOd9pKZil4n4UDA8PpUHdj3+FecpBCBJX1x4bU30QOCKdeY8LQ==
X-Received: by 2002:a0d:cd42:0:b0:55d:ba47:5359 with SMTP id p63-20020a0dcd42000000b0055dba475359mr6051892ywd.31.1686134491590;
        Wed, 07 Jun 2023 03:41:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h66-20020a0dde45000000b0055d7f00d4f7sm4658313ywe.22.2023.06.07.03.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:31 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:28 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 08/16] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <9cab5e06996b370e106c965b0e6b92384a744f31.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
2.41.0.16.g26cd413590

