Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 717671F597
	for <e@80x24.org>; Fri, 27 Jul 2018 22:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388556AbeG0XsF (ORCPT <rfc822;e@80x24.org>);
        Fri, 27 Jul 2018 19:48:05 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:53862 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730953AbeG0XsE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jul 2018 19:48:04 -0400
Received: by mail-vk0-f74.google.com with SMTP id x78-v6so2522520vkd.20
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 15:24:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=f31ZkYQTAmhn9MZ3KlEBBluRBRvB34b0H0c1Evv7HBo=;
        b=NZVnIVa8jldVdg1Cx3b/obdffghvN98jmA8MLtv75Q1ir/TDTyGlTcJ4+GsgawXli+
         7sWyQp/b9caHJNoZsOYMHUW7IHoplgkmMM/bay74TF7Pw8nqzBXQ3O4oEmA/oVr+tQco
         qMxQWZdpqfBSGSTt034VAl/aqNRJfipVexMs9Xc4f7RU7YKxRRRXLHBwfjQgYvjXIxLp
         chEsVpCaQvHDhpYlw2cG6mpTfJ9CPrUAy/Px47ealTlQsRBz7DZ3v33P9iOSvvUzgMKw
         KYq1VTAYaclfFcGllJ19y3d0QzjLA6z5pLX5loEF7LcIdzIFQX8LEOpKAe2mmvwigGFP
         5QpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=f31ZkYQTAmhn9MZ3KlEBBluRBRvB34b0H0c1Evv7HBo=;
        b=jqNW05T7xg2UVkqmvr0zhrouJnghFVFkQAfe0ElqC7WpIj3Yv724QhhpKBNPUWo3T4
         UyHXLMk1dMqvygw1hAgOvp09H1Pp8M5L9oURRYFFukucmdG6RlBUqVCGr48QKc6ekHYr
         /PylwvKGZ6t0XAf9U0ZLsQIqZWfBWdjW5lkltTuI4s/ODW7mF8OEF0nXNU4/P3BVUyOd
         vDpzBm3NXhWxxWxJXHX1nMZABiLIFNS3OLtl/FmeshHipxjeDL4js/Zm2hFlUGCKT41o
         B109j5UifV8nTocpeeKCnq6+YmGKB+jICxkRLOF+P9rr3CzB2FaWjWKRXX6JyOyF1aBW
         ZMBg==
X-Gm-Message-State: AOUpUlG9rg+EzlQFM+lsiKAhucFBgPMr4AITqmDWl79jk68RuUtSZSD8
        KBWUdhMxmxl+cSktkZ+jT/5+dMQbbe8a
X-Google-Smtp-Source: AAOMgpe7V+vVPLOxDO8hrO/wVKAEHrc9hW04PZOai68HsFfqVSWQaEVtQQFiPpXz5LtaXEOyAVR5np1xOsRG
X-Received: by 2002:a1f:b3c3:: with SMTP id c186-v6mr3815534vkf.7.1532730247582;
 Fri, 27 Jul 2018 15:24:07 -0700 (PDT)
Date:   Fri, 27 Jul 2018 15:23:56 -0700
In-Reply-To: <CAMy9T_HUdszkq8c545puzCpjvh1pKAL7MWtnrZFagNndyyxK7A@mail.gmail.com>
Message-Id: <20180727222356.96396-1-sbeller@google.com>
Mime-Version: 1.0
References: <CAMy9T_HUdszkq8c545puzCpjvh1pKAL7MWtnrZFagNndyyxK7A@mail.gmail.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH] xdiff: reduce indent heuristic overhead
From:   Stefan Beller <sbeller@google.com>
To:     mhagger@alum.mit.edu
Cc:     git@vger.kernel.org, jamill@microsoft.com, mh@glandium.org,
        quark@fb.com, sbeller@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Skip searching for better indentation heuristics if we'd slide a hunk more
than its size. This is the easiest fix proposed in the analysis[1] in
response to a patch that mercurial took for xdiff to limit searching
by a constant. Using a performance test as:

     #!python
     open('a', 'w').write(" \n" * 1000000)
     open('b', 'w').write(" \n" * 1000001)

This patch reduces the execution of "git diff --no-index a b" from
0.70s to 0.31s. However limiting the sliding to the size of the diff hunk,
which was proposed as a solution (that I found easiest to implement for
now) is not optimal for cases like

     open('a', 'w').write(" \n" * 1000000)
     open('b', 'w').write(" \n" * 2000000)

as then we'd still slide 1000000 times.

In addition to limiting the sliding to size of the hunk, also limit by a
constant. Choose 100 lines as the constant as that fits more than a screen,
which really means that the diff sliding is probably not providing a lot
of benefit anyway.

[1] https://public-inbox.org/git/72ac1ac2-f567-f241-41d6-d0f83072e0b3@alum.mit.edu/

Reported-by: Jun Wu <quark@fb.com>
Analysis-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Stefan Beller <sbeller@google.com>
---

> Plus, it should always give the right answer.

I was tempted to do just that, but I caved. The diff is correct,
and the hunk sliding is purely to appease the visual aspect of
humans looking at diffs. If your diff can slide more than a
monitor height, you're not interested in the best slided diff,
but something else is going on.

> There are cases where it will be
> more expensive than a fixed `MAX_BORING`, but I bet on average it will
> be faster.

So I did both, settling for performance as the utmost desire. ;-)

 xdiff/xdiffi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 0de1ef463bf..91e98ee9869 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -591,6 +591,11 @@ static void measure_split(const xdfile_t *xdf, long split,
  */
 #define INDENT_WEIGHT 60
 
+/*
+ * How far do we slide a hunk at most?
+ */
+#define INDENT_HEURISTIC_MAX_SLIDING 100
+
 /*
  * Compute a badness score for the hypothetical split whose measurements are
  * stored in m. The weight factors were determined empirically using the tools and
@@ -903,7 +908,12 @@ int xdl_change_compact(xdfile_t *xdf, xdfile_t *xdfo, long flags) {
 			long shift, best_shift = -1;
 			struct split_score best_score;
 
-			for (shift = earliest_end; shift <= g.end; shift++) {
+			shift = earliest_end;
+			if (g.end - groupsize - 1 > shift)
+				shift = g.end - groupsize - 1;
+			if (g.end - INDENT_HEURISTIC_MAX_SLIDING > shift)
+				shift = g.end - INDENT_HEURISTIC_MAX_SLIDING;
+			for (; shift <= g.end; shift++) {
 				struct split_measurement m;
 				struct split_score score = {0, 0};
 
-- 
2.18.0.345.g5c9ce644c3-goog

