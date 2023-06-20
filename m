Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDBFCEB64D8
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233243AbjFTOWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:22:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233268AbjFTOVz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:55 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F12E68
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:41 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-57023c9be80so49803007b3.3
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270900; x=1689862900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wogZybcyeZIzliXds0DpD7HS3Ni2VMFtnaDbRqW11PA=;
        b=ZWZqNvoJwzHbvf3Gh+MFdpgvcXr8xqZbmhh8raHXUCReaTv/5GSSN9Zb1zR/UWrCxw
         HpNLLEjtbD+UEVcu8NoC+ZSQyLQ6SPXcFFBThq1FA2DYW3bFAnPAdU7YGQ6L7o7GyZPj
         NUmA6Cxmjqpt9tjBImvZw027hf4iK1cvQ5uXt79OojNPXnrHT64/ItP8szyCe+1dJYgH
         Z+p4rezelS3oABzCu1mLMNInPObV1CRSi+uS5358nztZ7/90dMCURuXKUHQELPaUFVUM
         sGw/KhgDpRHJuGp8On3Ebqujc/kFRZX9CmlqBVp6LxZ7Z/8ErvCONIXhoNgYlCJs9yNl
         jfTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270900; x=1689862900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wogZybcyeZIzliXds0DpD7HS3Ni2VMFtnaDbRqW11PA=;
        b=dzx6FQ+fCHBlW7fgugfPlif/TORicvG16Cf1/iSATVEGj3yZhRKXoOIGL8R/t1K8ds
         CTE0yd7491XlE6zn6n8MjNJUQKCr1QtgGmNr1p2pwB2SjQgAKlXAvxRva5iGvpYjzmU7
         MSZeKInHUaHxJoSVgDfFY16UsUdil09M7G7y+L17vnI2GhXt+zhWbX0QUlR+F3AkCYjB
         dvdsxHWok2G6ymcvf2xIUhvxTvlzq1pUZ8IIx3xCw6jAdsdbzlUWb8P3MwW89rLNkUO4
         /FxYxpD7J6U09ITTbeJkkzLntSP9prVGvFhFOd44m2Dr2aFjNODoLNPkGfP5CzMExr0x
         7M6g==
X-Gm-Message-State: AC+VfDxw8Ck4vTPRpDwSQNg/bCuNgECgEzXA0W3UtTe6xjXIJvmV0bjg
        w1ZiZNJgOL3Lo8RZBm2vNyLDpvX6/+bTj5ou/y7F/VgK
X-Google-Smtp-Source: ACHHUZ6LL+TYlpobpFZsZfzFzFFer3BPRA+Ut0x6f44+1AbWI2xkNhTTHsHPEbEOTcR7jr4+zzXZrw==
X-Received: by 2002:a0d:cc44:0:b0:56d:3d8d:4f66 with SMTP id o65-20020a0dcc44000000b0056d3d8d4f66mr10969989ywd.10.1687270900582;
        Tue, 20 Jun 2023 07:21:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y191-20020a81a1c8000000b0056d31a089e9sm497674ywg.126.2023.06.20.07.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:40 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 08/16] refs/packed-backend.c: refactor
 `find_reference_location()`
Message-ID: <a0990b2916c36cd8e52cafe71225478879f13433.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
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
index 6855c9a237..d9b61d9e03 100644
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
2.41.0.44.gf2359540d2

