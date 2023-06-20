Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4FEB64D7
	for <git@archiver.kernel.org>; Tue, 20 Jun 2023 14:21:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjFTOVh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jun 2023 10:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233210AbjFTOV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jun 2023 10:21:28 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C62BD170D
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:25 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-570282233ceso40761917b3.1
        for <git@vger.kernel.org>; Tue, 20 Jun 2023 07:21:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687270885; x=1689862885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Wfu9OtmPwtYwpkyE7or+8oRAM6ezTRikvzNXNddnEzE=;
        b=I8NURfFEE0H2eUqVULoyg6tcjp2R7sclIzwxgOe9s2wgUPI0RihGCjFDPBCnLk0yb+
         IVsDAz5DHm36Vb5TXTrM/XnyWwE2cj+T5jsPD1Q0Y5QXA8Lwi/LnQLMwTBOYRbU96oX2
         oyzEN+5D18Tn4OGp/ZIXQDuBYNx4gZoDdgY7qogIfZYQstk3hq7DhwqKgiP9KNj8Dt7i
         jei1D5+4q+n/0AiLO2itvF3l942qStDIikxh4M2BWSSceSBj3N3gWG7C+P4mgORnkkZ2
         IT4HtWzH2rRMBtDlIO398Gpf3M2JOH5mORYRYOS2ySe6Noiz7wPzkEgATmN27wZqZN/B
         Nadg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687270885; x=1689862885;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wfu9OtmPwtYwpkyE7or+8oRAM6ezTRikvzNXNddnEzE=;
        b=JZgMd9xAr8USrAxRQ0UijQLqZqHziOtnzfP7/hoWvXgKh9iRl7yFGAptxRlNfGs2sY
         S80ovRD2/FgqoZnRGgXIqx7MUFbbwLmzTGtisOZDtowAUpBBFKs9ta2lIFevFUUcYblq
         OFIDGn1XhemcsDOTYLWWd2O+Edv96bK85foaNxMiKUTbSsVJLLhn1cHQu3ivH0CMhXLe
         vPTc0xu9+9lFQ4/mog7zL4LlL6vV0wv4tZTySbTy6Ysxpf1yL1BYE9nS6HxbpzXj7ZGN
         0NRBtrAtlqnh4XApSEF+SCnAi6jJMjkzIxrzYI1GcDZqL4WIlRVCYYiOqTPcOmD6yGEW
         TwPA==
X-Gm-Message-State: AC+VfDwzkqB2a5b2+/p0VPB6lNLCKciXDnqoQv6l1UHQH6m/RJ47OOI4
        La4rLKmb6JKvCTURJEi9XsJcY3GYTaQRMlHaLyjDMwbf
X-Google-Smtp-Source: ACHHUZ6GqCgvSONXJ0/j9f74DVahEZxdu/XPfPcJGVxc0ZvRhAGvLFPlBGTLw8+waWoYa29pdqjNRA==
X-Received: by 2002:a0d:eb89:0:b0:56d:3d83:15cb with SMTP id u131-20020a0deb89000000b0056d3d8315cbmr11139660ywe.44.1687270884846;
        Tue, 20 Jun 2023 07:21:24 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id e128-20020a0df586000000b0054f83731ad2sm526460ywf.0.2023.06.20.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 07:21:24 -0700 (PDT)
Date:   Tue, 20 Jun 2023 10:21:21 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v4 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <39e9b0f50d07cc75219325e7c7e72a801ca0cf16.1687270849.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1687270849.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1687270849.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

`match_pattern()` and `match_name_as_path()` both take a `struct
ref_filter *`, and then store a stack variable `patterns` pointing at
`filter->patterns`.

The subsequent patch will add a new array of patterns to match over (the
excluded patterns, via a new `git for-each-ref --exclude` option),
treating the return value of these functions differently depending on
which patterns are being used to match.

Tweak `match_pattern()` and `match_name_as_path()` to take an array of
patterns to prepare for passing either in.

Once we start passing either in, `match_pattern()` will have little to
do with a particular `struct ref_filter *` instance. To clarify this,
drop it from the argument list, and replace it with the only bit of the
`ref_filter` that we care about (`filter->ignore_case`).

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index d32f426898..6d91c7cb0d 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2104,12 +2104,12 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
  * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
  * matches "refs/heads/mas*", too).
  */
-static int match_pattern(const struct ref_filter *filter, const char *refname)
+static int match_pattern(const char **patterns, const char *refname,
+			 const int ignore_case)
 {
-	const char **patterns = filter->name_patterns;
 	unsigned flags = 0;
 
-	if (filter->ignore_case)
+	if (ignore_case)
 		flags |= WM_CASEFOLD;
 
 	/*
@@ -2134,9 +2134,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
  * matches a pattern "refs/heads/" but not "refs/heads/m") or a
  * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
-static int match_name_as_path(const struct ref_filter *filter, const char *refname)
+static int match_name_as_path(const struct ref_filter *filter,
+			      const char **pattern,
+			      const char *refname)
 {
-	const char **pattern = filter->name_patterns;
 	int namelen = strlen(refname);
 	unsigned flags = WM_PATHNAME;
 
@@ -2165,8 +2166,9 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	if (!*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
-		return match_name_as_path(filter, refname);
-	return match_pattern(filter, refname);
+		return match_name_as_path(filter, filter->name_patterns, refname);
+	return match_pattern(filter->name_patterns, refname,
+			     filter->ignore_case);
 }
 
 /*
-- 
2.41.0.44.gf2359540d2

