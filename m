Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F73CC77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 22:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234401AbjEHWAC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 18:00:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234346AbjEHV76 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 17:59:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD2A7102
        for <git@vger.kernel.org>; Mon,  8 May 2023 14:59:57 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso6893176276.3
        for <git@vger.kernel.org>; Mon, 08 May 2023 14:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683583197; x=1686175197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OZd3f4LH9FIps4H7kT3AlcP2vjt1ARQg19e8+HO6wZ4=;
        b=k7m6VTBwTr8rAf8zwDG5KA+5iFOj4DQK0lQ9rpvF8DLKNbfkbEHBvsdjBxreM2XRL3
         hhZXEhgF3J995KdDQXoK1FurYiteGT/XbtjUS6UmJKrF7FjI8jZbFmDF6UpyOfTo/B51
         eFUaBRNgCttkEPLUWTpbCrCszTA+F7K4kWOs/wrHXkG7Dtq2svH9OJ9R03I5wGileLzg
         ZnyoySyzb68d4kZ9ilo8dWDT7WYb+tpoZl/idcmwKeabMFRp8DNM/Ko98asptRrJ4bsZ
         hcsM9bn93zFvv0puDViYmPijB/1o4FXffHz9VQMLHbQrg7uu1XuPKAmSZ58+HxLW6Hv1
         4cRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683583197; x=1686175197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZd3f4LH9FIps4H7kT3AlcP2vjt1ARQg19e8+HO6wZ4=;
        b=bEwfI5cDi26ifFpUH22ycSnmLsHc46mONbKd+W/+nSQdvFYHj100q7vkxJwZJogvu6
         wjfKJIH3m3Au17Op2AdJxJ0iaoIzIgk+FAKzIbyru9s8u+8RmwTeQaZH/0e36brLNf/a
         N5eBWL7I9HP3Gm5Zskxos1087WNF70jVHiE5cr3aDn8hpe+RFbn35LEzR3IMNnaI7Bss
         YOYFLTHH82g9EpHS2/ww7B8FtWoZfdKusZmgHIMQXyx0giJ7MdpDtPuMlIAWpBBp5Jkf
         8eMA6HNBsnBVeSgiUdk1TeNWbpur29WToNbs7NM7n1W+tvrRnI9WaSTE9I0YU3cOuUfz
         /05Q==
X-Gm-Message-State: AC+VfDwJ6WwZ0OXwAziD6B7FYgzW12aLvx3yEQLSUywcsl+kBN/r6Aua
        z/A/5k2UGIxscCssXw1ILx9ZBbPbk80o1qazdGwatw==
X-Google-Smtp-Source: ACHHUZ4LRssufuqPKR+Gl8yV9qGIxu4TgJUzCuw2ny2omb19g2IgVx/5tFGAMPwOaARxzIeS8yekfQ==
X-Received: by 2002:a25:addf:0:b0:b8f:599c:c43f with SMTP id d31-20020a25addf000000b00b8f599cc43fmr14077836ybe.19.1683583196860;
        Mon, 08 May 2023 14:59:56 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k3-20020a25ed03000000b00b8f4916294csm2577988ybh.10.2023.05.08.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 14:59:56 -0700 (PDT)
Date:   Mon, 8 May 2023 17:59:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 05/15] ref-filter.c: parameterize match functions over
 patterns
Message-ID: <c54000f5f5122c4ca3ac9b16828a8fd77050768c.1683581621.git.me@ttaylorr.com>
References: <cover.1683581621.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1683581621.git.me@ttaylorr.com>
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

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 ref-filter.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 9ea92b9637..6c5eed144f 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -2102,9 +2102,10 @@ static int get_ref_atom_value(struct ref_array_item *ref, int atom,
  * matches a pattern "refs/heads/mas") or a wildcard (e.g. the same ref
  * matches "refs/heads/mas*", too).
  */
-static int match_pattern(const struct ref_filter *filter, const char *refname)
+static int match_pattern(const struct ref_filter *filter,
+			 const char **patterns,
+			 const char *refname)
 {
-	const char **patterns = filter->name_patterns;
 	unsigned flags = 0;
 
 	if (filter->ignore_case)
@@ -2132,9 +2133,10 @@ static int match_pattern(const struct ref_filter *filter, const char *refname)
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
 
@@ -2163,8 +2165,8 @@ static int filter_pattern_match(struct ref_filter *filter, const char *refname)
 	if (!*filter->name_patterns)
 		return 1; /* No pattern always matches */
 	if (filter->match_as_path)
-		return match_name_as_path(filter, refname);
-	return match_pattern(filter, refname);
+		return match_name_as_path(filter, filter->name_patterns, refname);
+	return match_pattern(filter, filter->name_patterns, refname);
 }
 
 /*
-- 
2.40.1.477.g956c797dfc

