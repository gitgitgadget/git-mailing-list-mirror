Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3956CC7EE2E
	for <git@archiver.kernel.org>; Wed,  7 Jun 2023 10:41:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239513AbjFGKlV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jun 2023 06:41:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239555AbjFGKlS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jun 2023 06:41:18 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6271C1BEA
        for <git@vger.kernel.org>; Wed,  7 Jun 2023 03:41:17 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-565c9109167so66716857b3.2
        for <git@vger.kernel.org>; Wed, 07 Jun 2023 03:41:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1686134476; x=1688726476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0Z9oMo7gji4/HCNUlzvLTKEiXc1PfBMlilRXhV63s74=;
        b=IJdC+LKHyAep+HUJZKzwxqZZYxrifQTnjc2zYgD2OnmyKkOFdwKoCHolDmzN6tjXeo
         tEODGdBnxQYvfu4Szp7Bs2PmN6JJ7CWdZeHs/RSN+eXPxOKghEP5DS+hhDkVzoYixVxD
         VrnJz8elizVR2M/NJ7BHmFPE5FyoX5pzCFS9kYo1ST2ITmN/sekbpICz0tR1LenLm+E+
         BuUmIuQPIyoQilNtzSAPs81p3YAoKtT4LOWvfoadBdf1HkPvAX/Web5GfLcoLI4nB4GJ
         0djX5N9m3rRBTjG1vpJ226RONetTX3WEjzZs3xQV67tGApOFJL+OerOq6zJa62P9Usyy
         CN3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686134476; x=1688726476;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0Z9oMo7gji4/HCNUlzvLTKEiXc1PfBMlilRXhV63s74=;
        b=VRgEWdbs/WtxlyM+qt2Jc06lTfcB2OUSe7Tc6zuXl1RrI6ci9QNiRAzmcIYWbbh4zR
         7XwUNAkQqtjy9Kb3019ikHwmjRcE3Vt+MM+4FQDaqdz2OAPxQ8cRAs5jqlCeCoMaFoIC
         bipjNBJajUdpUTFTjseAkopjvn0RO0IWuj/3jZDXvKiFVovDEzIE7XhX7ZzpfjN/rh17
         VojDHiyu+BUTPBFbmIKFLpFlm2TctrV7jko+X4SHV5kPoLZOZezpzt03e7yr2dguvnN2
         dFCXAAslgAMjYdk77ZTYFgXUkbXveKMm3jDSyDjc3iQ9JPn3/z1bKOhCa6ip8/6KKEU5
         6doQ==
X-Gm-Message-State: AC+VfDzNk0UXq5Y7bm5upVgz8JmOzDAbeRzjNrRLgmM4uYEtse1Dg93u
        mRLBKu0/sldGwEed+/Cm5BaflaMXe9F8ennCgp0SY6vy
X-Google-Smtp-Source: ACHHUZ4O7Z94OMMl34PaznJKFW4rC0/glpsGJzVW4X3FF+tBWJt7HsasoHxsnhxj3g2wLXJ6n4g65Q==
X-Received: by 2002:a0d:cb47:0:b0:565:c96b:f526 with SMTP id n68-20020a0dcb47000000b00565c96bf526mr5526431ywd.19.1686134476403;
        Wed, 07 Jun 2023 03:41:16 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p17-20020a25b511000000b00b9e5b28dbd8sm3771833ybj.17.2023.06.07.03.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jun 2023 03:41:16 -0700 (PDT)
Date:   Wed, 7 Jun 2023 06:41:13 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <1988ca4c0a79065a1893259da8abe63919e05cf3.1686134440.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1686134440.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1686134440.git.me@ttaylorr.com>
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
2.41.0.16.g26cd413590

