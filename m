Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83AA51F404
	for <e@80x24.org>; Tue,  3 Apr 2018 21:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752675AbeDCVFw (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Apr 2018 17:05:52 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:37918 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752525AbeDCVFv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Apr 2018 17:05:51 -0400
Received: by mail-pl0-f67.google.com with SMTP id k6-v6so5606073pls.5
        for <git@vger.kernel.org>; Tue, 03 Apr 2018 14:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DSaNjnmvn0QJouXR5vJ7gITf3zDPXK6ddfCFejd50lc=;
        b=bEMzitkq32rL93UtYLlgBoDoVvpRBLLWj4zT9AVn/+ij/4B9pVNl7HdmgOZmXtDQN0
         SZrFWBeZYLOd7uYVtC8mVv8qPyYVIis4iAYd0UPG6LPm7zzzCUKaaZ0kh5SOLsOmUDAH
         ieI3N0+GTN7RN4l1baRoE0YpSG+8uxuPpf2osIFBCigeAadJsWxkTU16jzcYfhZEbF7C
         iTTNULwatRsw7GkWXWsNnEV4AQqpI9TIsrWmN+kUhWfLP20+oudxhVNjhma1Zz6FbuWG
         i79BvSnACdPBuTEmvlT12A1jVH6HIK0oSRgyVD3MP/BPU42NkQuxyn9BHVpvlpVR+E1f
         VhMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DSaNjnmvn0QJouXR5vJ7gITf3zDPXK6ddfCFejd50lc=;
        b=pwh2qlDN1pCIuHb76Rse+6fJlnM5Xo3EImCr78X+gANHgUBGS+v1fIzxJ1xiePN3IS
         +tOFkZz185OwB78b6pqjjlhyGsTjUP525BjAuIfQVruGy1VxFuyzPOYwZixmfZSEced1
         vD8ypt1pMscAnvTFdBCTfs9llun9LrK9RgSMu/GzqgSpoSov6Kww5UsoeRmyZsh7N55k
         WkfZzrQvl1L4KL/+Eq8VF13ak85DjPX9BTAVfZbxfEJtJy71BIRwEWVO/V0OwZJqwpO6
         w5rcismRjrdmc2tuMp6W1QZg751HaZxsCBaKkzFlTfUFL/JEl11egds8DcCxNvrX7mQ2
         9eqw==
X-Gm-Message-State: AElRT7Fh4QTsZoww9B13GmbHxmRUnNEU2M4D1v4WCZqSVMy/rENXXIxt
        wheqJMn1pkRDTUvMF3BoZ/P+jg==
X-Google-Smtp-Source: AIpwx4+oVMD8JTF68QDwckgWBCz893Yn8u4ZwzAbPj5tNywa+XPFNLLHiGNUel2m8sqcMGyWE1jgJQ==
X-Received: by 10.167.129.217 with SMTP id c25mr11844632pfn.143.1522789550540;
        Tue, 03 Apr 2018 14:05:50 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id j10sm6901595pfj.1.2018.04.03.14.05.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Apr 2018 14:05:49 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, sbeller@google.com, simon@ruderich.org
Subject: [PATCH] diff: add a blocks mode for moved code detection
Date:   Tue,  3 Apr 2018 14:05:36 -0700
Message-Id: <20180403210536.33798-1-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <87muykuij7.fsf@evledraar.gmail.com>
References: <87muykuij7.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Currently we have plain, zebra & dimmed_zebra, and zebra is the
> default.
>
> I got an internal report from someone who had, because zebra looked
> crappy in his terminal, moved to "plain", and was reporting getting
> worse moved diffs as a result.
>
> I found that there's essentially a missing setting between "plain" and
> "zebra", in git command terms:
>
>     # The "plain" setting
>     git -c diff.colorMoved=true \
>         -c diff.colorMoved=plain \
>         show <commit>
>
>     # We don't have this, it's "plain" but with "zebra" heuristics,
>     # plain_zebra?
>     git -c diff.colorMoved=true \
>         -c color.diff.oldMovedAlternative="bold magenta" \
>         -c color.diff.newMovedAlternative="bold yellow" \
>         -c diff.colorMoved=zebra \
>         show <commit>
>
>     # The "zebra" setting.
>     git -c diff.colorMoved=true \
>         -c diff.colorMoved=zebra \
>         show <commit>
>
> Which is what I mean by the current config conflating two (to me)
> unrelated things. One is how we, via any method, detect what's moved or
> not, and the other is what color/format we use to present this to the
> user.

Oh I see.

Reading the docs again, maybe we want to have a "blocks" mode,
that is zebra with the same color for any block?

> You can feed that plain_zebra invocation input where it'll color-wise
> produce something that looks *almost* like "plain", but will differ (and
> usually be better) in what lines it decides to show as moved, which of
> course is due to *MovedAlternative.

I would think this is close to what you want (module implementation errors,
I did not run/test this code).

One could also argue that this is *too* weak, as when there are
multiple blocks of say 15 chars adjacent, they might be one large block.

---8<----

From dde04f6afa35a313fac3575100fe83b554ec2b59 Mon Sep 17 00:00:00 2001
From: Stefan Beller <sbeller@google.com>
Date: Tue, 3 Apr 2018 14:03:01 -0700
Subject: [PATCH] diff: add a blocks mode for moved code detection

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 Documentation/diff-options.txt | 5 +++++
 diff.c                         | 4 +++-
 diff.h                         | 5 +++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index c330c01ff0..abce5142d2 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -268,6 +268,11 @@ plain::
 	that are added somewhere else in the diff. This mode picks up any
 	moved line, but it is not very useful in a review to determine
 	if a block of code was moved without permutation.
+blocks:
+	Blocks of moved text of at least 20 alphanumeric characters
+	are detected greedily. The detected blocks are
+	painted using either the 'color.diff.{old,new}Moved' color.
+	Adjacent blocks cannot be told apart.
 zebra::
 	Blocks of moved text of at least 20 alphanumeric characters
 	are detected greedily. The detected blocks are
diff --git a/diff.c b/diff.c
index 21c3838b25..80dd8cbd9a 100644
--- a/diff.c
+++ b/diff.c
@@ -271,6 +271,8 @@ static int parse_color_moved(const char *arg)
 		return COLOR_MOVED_NO;
 	else if (!strcmp(arg, "plain"))
 		return COLOR_MOVED_PLAIN;
+	else if (!strcmp(arg, "blocks"))
+		return COLOR_MOVED_BLOCKS;
 	else if (!strcmp(arg, "zebra"))
 		return COLOR_MOVED_ZEBRA;
 	else if (!strcmp(arg, "default"))
@@ -899,7 +901,7 @@ static void mark_color_as_moved(struct diff_options *o,
 
 		block_length++;
 
-		if (flipped_block)
+		if (flipped_block && o->color_moved != COLOR_MOVED_BLOCKS)
 			l->flags |= DIFF_SYMBOL_MOVED_LINE_ALT;
 	}
 	adjust_last_block(o, n, block_length);
diff --git a/diff.h b/diff.h
index 6bd278aac1..3a228861d9 100644
--- a/diff.h
+++ b/diff.h
@@ -207,8 +207,9 @@ struct diff_options {
 	enum {
 		COLOR_MOVED_NO = 0,
 		COLOR_MOVED_PLAIN = 1,
-		COLOR_MOVED_ZEBRA = 2,
-		COLOR_MOVED_ZEBRA_DIM = 3,
+		COLOR_MOVED_BLOCKS = 2,
+		COLOR_MOVED_ZEBRA = 3,
+		COLOR_MOVED_ZEBRA_DIM = 4,
 	} color_moved;
 	#define COLOR_MOVED_DEFAULT COLOR_MOVED_ZEBRA
 	#define COLOR_MOVED_MIN_ALNUM_COUNT 20
-- 
2.17.0.484.g0c8726318c-goog

