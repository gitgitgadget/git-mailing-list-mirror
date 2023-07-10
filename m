Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8654EB64DA
	for <git@archiver.kernel.org>; Mon, 10 Jul 2023 21:12:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231708AbjGJVMb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jul 2023 17:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjGJVMX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jul 2023 17:12:23 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A51F18D
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:19 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5700b15c12fso60369867b3.1
        for <git@vger.kernel.org>; Mon, 10 Jul 2023 14:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689023538; x=1691615538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cUVzHTQWi61QjEMUzZyauEUKckXze3BriO7vJyiP3WM=;
        b=QT8Vdp1XYQ5PiqQ7Hmzm6kxuB0XaWHXE0P0Lz0rqOlwrEkkynMTA/v4UGI8VAwomG2
         vbeX0w/YiILqMCYa9Z9n8a6vDrKUfBAix4DzieDMGuHhoV4HXwgVzNTVtYXOvhdJxAI2
         FxWInzl0eePHSw61k3KWd0NiUgic/9815PWFJrT9zy5YQbeaPp7gLFNJecZXXRu5l/xq
         PlKRgWHvleBA+W7HKpuJoqhbXsj1ct22IgiqggPEG+UTQQ9+pHB2ChCPUOBoLK6ztYDa
         31CkhRGRiiP6gQdSTy8vKKX6+l+7jvK4fRSIOBQJnIR3jiEJqWv7kypHyEhkyyD5YhLz
         lGAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689023538; x=1691615538;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cUVzHTQWi61QjEMUzZyauEUKckXze3BriO7vJyiP3WM=;
        b=X8RtVRdqGv+qTU7QRmE40jnLCd4j5ptvmZfeg4EJLiy4qUclR+IaFAZWGiFbOl1I8p
         2JL3CxQ0iONJ1n1K5VvQrIs6AiphWfV/OqCwwT+UUNd+Uqulw54ysJILVC8vvrcv67b9
         +B5yTGxJ8IRp97YPYgm0VYPfNiFFgEc7h2GQ9zH0c3j6b858Sdxjil/d2u0IkCAZltP6
         rLsIa0liLrERiQ+me024fUsi6UYi6Vq0fhw2POwNxB/YyS/pmrboCimJcjmrVi+QoCJQ
         3ELgkIg5e3YxRNmvl+rlrvZSAOwR5cOMWIe6w3D65OlcyIf3PfateRmYFlZNdwSLpLeE
         mDWg==
X-Gm-Message-State: ABy/qLZkQ9kn4cilJ+ySLKDs6eWSmHcpNFOqP3vVHOhyJUfFqLTZvhrt
        vkX56VYvSVUUAdtthyxQ/s0XDLZG4+UXj9fllv/wrA==
X-Google-Smtp-Source: APBJJlF9iWyzFM6oFgHLFRBvZYJ2LGLGzB0immVxzBrzpEPF6SH6ftvDlgf9l20RP6Cymcp7H8xy7Q==
X-Received: by 2002:a81:49c9:0:b0:56d:4d7:4a45 with SMTP id w192-20020a8149c9000000b0056d04d74a45mr11497276ywa.52.1689023537995;
        Mon, 10 Jul 2023 14:12:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id v186-20020a8161c3000000b005612fc707bfsm179830ywb.120.2023.07.10.14.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jul 2023 14:12:17 -0700 (PDT)
Date:   Mon, 10 Jul 2023 17:12:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Chris Torek <chris.torek@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v5 05/16] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <3ab03ac20dfd83acd5e00e027cf0da362529b7e1.1689023520.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
 <cover.1689023520.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689023520.git.me@ttaylorr.com>
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
 ref-filter.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 84cd3921307..c70a430adf3 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2104,12 +2104,12 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
  * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
  * matches "refs/heads/mas*", too).
  */
-static int match_pattern(const struct ref_filter *filter, const char *refname)
+static int match_pattern(const char **patterns, const char *refname,
+			 int ignore_case)
 {
-	const char **patterns = filter->name_patterns;
 	unsigned flags = 0;
 
-	if (filter->ignore_case)
+	if (ignore_case)
 		flags |= WM_CASEFOLD;
 
 	/*
@@ -2134,13 +2134,13 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
  * matches a pattern "refs/heads/" but not "refs/heads/m") or a
  * wildcard (e.g. the same ref matches "refs/heads/m*", too).
  */
-static int match_name_as_path(const struct ref_filter *filter, const char *refname)
+static int match_name_as_path(const char **pattern, const char *refname,
+			      int ignore_case)
 {
-	const char **pattern = filter->name_patterns;
 	int namelen = strlen(refname);
 	unsigned flags = WM_PATHNAME;
 
-	if (filter->ignore_case)
+	if (ignore_case)
 		flags |= WM_CASEFOLD;
 
 	for (; *pattern; pattern++) {
@@ -2165,8 +2165,10 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	if (!*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
-		return match_name_as_path(filter, refname);
-	return match_pattern(filter, refname);
+		return match_name_as_path(filter->name_patterns, refname,
+					  filter->ignore_case);
+	return match_pattern(filter->name_patterns, refname,
+			     filter->ignore_case);
 }
 
 /*
-- 
2.41.0.343.gdff068c469f

