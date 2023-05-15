Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E7AC7EE25
	for <git@archiver.kernel.org>; Mon, 15 May 2023 19:23:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244979AbjEOTXp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 15:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245062AbjEOTXa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 15:23:30 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09341155E
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba76528fe31so57816276.1
        for <git@vger.kernel.org>; Mon, 15 May 2023 12:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1684178604; x=1686770604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0VwrK4QtQjt4LdWZCL8Ln21wC0ftrl3HZBTsJM5ENs=;
        b=c9kFsVuqM8TIaRBIyqfal0Sz8Rk9HAmiE1GJqSnDMGVVhGna8Twn0/nx4lZ4juWw06
         4cWHvEODjNzGd/Pom8iAWc6VvX4n9tB8hlOcOcTri4HOCaM64DUGhUFFAkeh73cxoo6r
         fsjpuHicXVRF485eM1ZnaletCzBodGiQsdFbCwtkwtpd9R/j1+whe72PMDXAIdDALHPV
         gmuawFbx7Rb/ViyX0crazH7vpo7MHiNqwoEmFLmLdpY7TqJsaLeazfPd4rxAVvLJJ71Y
         W2cSZOsil2nBPd41n6Q0RPNJ09Ewt4JxuqsVtQO4T4Lr6yivCCBzREompyc1/e4Iy+/i
         H6kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684178604; x=1686770604;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0VwrK4QtQjt4LdWZCL8Ln21wC0ftrl3HZBTsJM5ENs=;
        b=c8z3BEXXCwdH0GC13dPjhunapk/HzkmXzW/uy37/TNOLyLByQAs91+tKilqoIFwqET
         eeef10D5iJWh/XlP4O6yI84HpbyukY1wCbFAPIlECuKk2d3ertzcPeIen7pOEQ9u1gQ/
         uzf7Do9F5XN/xm6an/REh8cqbmr3MC8SoVsPiF5IceuOi9LjBh72WcR8ySVO/Ub3zyl3
         Bz5uo5bRUjV0oy2MdcB9miY4RxRW/4WoI8f9GO7q/RncYE8S9vyi5MqQDotAgBcqYY9X
         0jeaMFvk+28PtVPw+A17NGJbBqXgZw+tRQBowiECMv/GOc0iqrBTDWiMWmfbs/0DfAfO
         Ob4Q==
X-Gm-Message-State: AC+VfDzTWCNPlPpFY2nvCLtPoZKLygTXOBpjhO38zJMmFDyTEL10ozJz
        Q+CO0aYbgiqsgKyQcbErlP0gmTf7DNruBe+afoLfow==
X-Google-Smtp-Source: ACHHUZ5JZwDOyJVg/iiHVcAUrU7B1av/hF6wGu1jtnc2YZ8Niyb6S9erUgyPlBbawhjJBOvEISALzQ==
X-Received: by 2002:a81:bd7:0:b0:561:1127:30e0 with SMTP id 206-20020a810bd7000000b00561112730e0mr10073257ywl.3.1684178603785;
        Mon, 15 May 2023 12:23:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id i2-20020a816d02000000b0055a3420b25asm24522ywc.50.2023.05.15.12.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 12:23:23 -0700 (PDT)
Date:   Mon, 15 May 2023 15:23:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <385890b45960556cdffe5c09211baf4f8d3df0ad.1684178576.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1684178576.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1684178576.git.me@ttaylorr.com>
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
2.40.1.572.g5c4ab523ef

