Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B51EB64D9
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231983AbjGJVMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbjGJVMg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:36 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A71E77
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so8901004276.0
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023546; x=1691615546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R+z07fKh9BBAq18u3BttAlDWhemyUYrdbgJIH0yVj9k=;
        b=0Sc9uUG/QUjFpXG1o8bL/5KBqCdeJewvXSi9FVQzafrIaFXTpjFDwaA7ocyXQt3hyG
         f2CNRpfJpT91ZQRcEOWSo3s2sYrdYouquxASMhqzwn27Fokr5QnrOa72c32/uoWJvlnz
         yD5YVSXVY2PUb4p8hsbP/89iyN1l8hUHVtzh+U9kVYuQSouYmb2h+ZSaeBUTjPMYUImZ
         jIABGy89QF4nuie+b4dYQlhiVpEh2mIibBRKvfnxoO0Go9dJsdMPQiilK0jcZI4w46ei
         N8aTxWN7geiC8V/SyH8pvA3P5NIHznPrygrADWVuZh11qyENfDQrN7o+vc1AXexIZUKK
         bpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023546; x=1691615546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R+z07fKh9BBAq18u3BttAlDWhemyUYrdbgJIH0yVj9k=;
        b=lWhTNVEYQECA31CdkDJOf/Q1wcnTKF7x1F06XcfT0sXmQ3LynFdxMUAG7V+dFEl/qS
         gIEbBjJzTTUh9v9JasxIWOxsZAPyMbBHJbjPpPXGJNK90EuWalLr9l+ywEqJcPSePn35
         V5lJ7eUq5Gqu7IonoCZu7vpkkErxK6huCyxA3TMnhmFWDnUqr3He6nLxbNqIbKcmDF37
         BT4ujJ6L+RL87NZCS4iRF0GeTBLdM5TtYzTtT/ESc3aysKVnYOfNxkmxmyNGuVvXHXdA
         HE/6i+JmX8J2dTtTp85dL85nEEGIUoKul/xA1r6UcW2ZzUiKCU2Lm5mop8/rt1b/uo2f
         F0aw==
X-Gm-Message-State: ABy/qLYfH4ZoI5BGj2nr0myf1p2pKQMeM2cNFUTSD0DlTsODVBZ6clcZ
        kPvZV7x5uxFvFeLEKKHF0XFUmhAi6Ilh1LFZkHov2A==
X-Google-Smtp-Source: APBJJlE9suFWBC443GGIxzO7fhbxXPJ33A3EKEpzrKPwd1pzZrX0RTgnqDI++dKjYY7PN6u3j3ARvA==
X-Received: by 2002:a0d:df8a:0:b0:577:3225:818d with SMTP id i132-20020a0ddf8a000000b005773225818dmr15407651ywe.11.1689023546621;
        Mon, 10 Jul 2023 14:12:26 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j9-20020a816e09000000b0054f50f71834sm180489ywc.124.2023.07.10.14.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:26 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 08/16] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <25c099a528c87651aeea3dfbd667fb51770dd24a.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
index dec15dee31e..e36334e3320 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -528,22 +528,8 @@ static int load_contents(struct snapshot *snapshot)
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
@@ -589,6 +575,26 @@ static const char *find_reference_location(struct snapshot *snapshot,
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
2.41.0.343.gdff068c469f

