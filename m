Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D64B820D13
	for <e@80x24.org>; Fri,  2 Jun 2017 19:10:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751168AbdFBTKY (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Jun 2017 15:10:24 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34295 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750971AbdFBTKU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2017 15:10:20 -0400
Received: by mail-wm0-f65.google.com with SMTP id d127so20334244wmf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2017 12:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kDCbxOlrFEkZpqcZ/YvnMxUf0jf/SbjaL00jBXpb8g8=;
        b=nM31VqR/b4/857yO+1A3FKIO8E28Hwj3X6EtQV4widklY15Ea2bkb93PdUp5JLT7SE
         PzqUBM4we8kmIhQbcy7+HsFnxuA2uBQl2riZHPo0YL7mSfYcFLxuG6FZtJ08qvFJyRcy
         m0L8g79ilKDTASr+ynGkZLxSRP4QPipv7JeXig/I0lNDmiPZpc5KUXQUz7MTvbqfm2Dy
         VWLTC8ZOaPbGw7lRLSbWAe5gRfOnP+ROQRyIErghG5nOiAx4ONeGJOfoEDDjgmmP/ErC
         bRed7QK6kMAwuCfgTEFFkdXDelyblvO58ZRnGIS2JFpLDq22ME0BfTLWpp1xH1QeN4E5
         OsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kDCbxOlrFEkZpqcZ/YvnMxUf0jf/SbjaL00jBXpb8g8=;
        b=PshM7atPjCKvjn+NAcqazE0yV1oETfY86fm7Wi5QkEeyT4WoFscpRWR6m3cLK7jcrY
         4Leq26EHAOBMUy5qWkheyAlW1rg2kjNDFfXZbFIxA4xBmG+yAjkSH+DmAfKC5f8XAKpn
         bLHOohhpzSVLpTsu5gMzBv+5cdAmkmBAfjMAeQlVP2jFd41y14SgW0nMMP/HjjzC2cpY
         oi5GttwkQ7aAaZe9+LV3Dy24i1EnYpU/jkrjqFzAGYP4oiHTr1ci1KcZO2J+gVQ0sS98
         yB64OFF+FA+e8c48U8fqZ4oLmU9Mur6gUzvtghWkERyRwPB2DfWd3cgt9c3Ig/BqZdQt
         2hbw==
X-Gm-Message-State: AODbwcAi1g1vM1BnmoZ73/e120526JB7W9xJyihmgwY5PQUtmJwRS0e0
        OzEZPpdDsVhBog==
X-Received: by 10.80.144.200 with SMTP id d8mr6954510eda.162.1496430618710;
        Fri, 02 Jun 2017 12:10:18 -0700 (PDT)
Received: from localhost.localdomain (x4db0e5ea.dyn.telefonica.de. [77.176.229.234])
        by smtp.gmail.com with ESMTPSA id j50sm8552465eda.44.2017.06.02.12.10.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Jun 2017 12:10:17 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 3/3] revision.c: use skip_prefix() in handle_revision_pseudo_opt()
Date:   Fri,  2 Jun 2017 21:10:10 +0200
Message-Id: <20170602191010.16834-4-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.13.0.420.g54001f015
In-Reply-To: <20170602191010.16834-1-szeder.dev@gmail.com>
References: <20170602191010.16834-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of starts_with() and a bunch of magic numbers.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 revision.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/revision.c b/revision.c
index 2b64b7e0e..ab0279572 100644
--- a/revision.c
+++ b/revision.c
@@ -2142,20 +2142,20 @@ static int handle_revision_pseudo_opt(const char *submodule,
 	} else if ((argcount = parse_long_opt("exclude", argv, &optarg))) {
 		add_ref_exclusion(&revs->ref_excludes, optarg);
 		return argcount;
-	} else if (starts_with(arg, "--branches=")) {
+	} else if (skip_prefix(arg, "--branches=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 11, "refs/heads/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/heads/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--tags=")) {
+	} else if (skip_prefix(arg, "--tags=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 7, "refs/tags/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/tags/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
-	} else if (starts_with(arg, "--remotes=")) {
+	} else if (skip_prefix(arg, "--remotes=", &optarg)) {
 		struct all_refs_cb cb;
 		init_all_refs_cb(&cb, revs, *flags);
-		for_each_glob_ref_in(handle_one_ref, arg + 10, "refs/remotes/", &cb);
+		for_each_glob_ref_in(handle_one_ref, optarg, "refs/remotes/", &cb);
 		clear_ref_exclusion(&revs->ref_excludes);
 	} else if (!strcmp(arg, "--reflog")) {
 		add_reflogs_to_pending(revs, *flags);
@@ -2165,14 +2165,14 @@ static int handle_revision_pseudo_opt(const char *submodule,
 		*flags ^= UNINTERESTING | BOTTOM;
 	} else if (!strcmp(arg, "--no-walk")) {
 		revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-	} else if (starts_with(arg, "--no-walk=")) {
+	} else if (skip_prefix(arg, "--no-walk=", &optarg)) {
 		/*
 		 * Detached form ("--no-walk X" as opposed to "--no-walk=X")
 		 * not allowed, since the argument is optional.
 		 */
-		if (!strcmp(arg + 10, "sorted"))
+		if (!strcmp(optarg, "sorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_SORTED;
-		else if (!strcmp(arg + 10, "unsorted"))
+		else if (!strcmp(optarg, "unsorted"))
 			revs->no_walk = REVISION_WALK_NO_WALK_UNSORTED;
 		else
 			return error("invalid argument to --no-walk");
-- 
2.13.0.420.g54001f015

