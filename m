Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0D64EB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 23:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232866AbjGLXiN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 19:38:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGLXiE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 19:38:04 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B15F1FCC
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:02 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-ca9804dc6e4so123937276.0
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 16:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1689205081; x=1691797081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QMU+hrj/KkvqvT01qIgeQkE5p6eCRwlqqHk9p0tocnE=;
        b=I/j9j3+8uKk1jPwht6WwjvnABN4JU+vNuV1GDairtBa1UkfADfL1fdcbXpxQlgOzUk
         99UBdIsL8YZmKG/8CGvF3JNQar0L3I9QpqzFdg47+VY71xwTt1bIUugXT7MczbNoGhzJ
         OL4koJfGL5cebn6ZvKNoeGCzV9gYyLQpWpkq2XpRSOixTy6X8jXyG8HeBNKKBjgrfV4p
         QrRmkE9UHzBihxsVRfrFINWIWsbSLmQ+hl6T/UCvXZaqBlpZAD6dMkUqS/TMxBGRRvx2
         7LXjscQA1dEmAEN9+kpbBpRGNjTy1Ew5Toizhvjz03THZzfWNab1xOIA+8c4ct/h8Tc/
         BTvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689205081; x=1691797081;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QMU+hrj/KkvqvT01qIgeQkE5p6eCRwlqqHk9p0tocnE=;
        b=I4RxmrtbGF1srx/0vMDFdCae5EwmmDiozVE99lW94lGVdlM8Hc4hGXgOILAMCJbupX
         lD1nuU8SvgQACZi+MbdEVHM8oX+WehT8MA/XCb0c0wi7myt37frjd+/pb4sEiT0glu4+
         ovkjvhr/Y/gRVvToDU/enPHxO183wscITCuE9NIDvKhFO4nsnx6z74FLGFf0TdHaFY5G
         /tBTVgiu1xlfgjNA/iZjEsXUpIbhQrdwLT92H2a4N2NwRU3EEwzGkuZ8p1M0xIbPRJNi
         KcEY48TanvF5kN3uR+rnwfjNJSSS/F2zMCksGra+3DGcsJNdAqhtbVb168P/BaDDmqhI
         MbqA==
X-Gm-Message-State: ABy/qLZROz+073oSDgVB769mcSo+OB+/PxXWDpNPHekfNvwEqH0MSmtF
        rYR8KWzoe65EMU0HRhe9/kMnLk71gvm4Aq7oudR0sw==
X-Google-Smtp-Source: APBJJlH8APaRzmSw0xWVRtscAJ6vfBb4MM+OigXhQS50EzLwpIp3RblVhlzUeJqOkhfZ/D50kc9XwA==
X-Received: by 2002:a25:aa54:0:b0:c4c:b003:17b4 with SMTP id s78-20020a25aa54000000b00c4cb00317b4mr3947902ybi.5.1689205081396;
        Wed, 12 Jul 2023 16:38:01 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t15-20020a252d0f000000b00c5fc63686f1sm1193738ybt.16.2023.07.12.16.38.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 16:38:01 -0700 (PDT)
Date:   Wed, 12 Jul 2023 19:38:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Victoria Dye <vdye@github.com>
Subject: [PATCH 13/20] commit-graph.c: prevent overflow in
 `load_oid_from_graph()`
Message-ID: <0b7aabc23b10c1c3e260848dd8ac500ee7e62d8c.1689205042.git.me@ttaylorr.com>
References: <cover.1689205042.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1689205042.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a similar spirit as previous commits, ensure that we don't overflow
when trying to compute an offset into the `chunk_oid_lookup` table when
the `lex_index` of the item we're trying to look up exceeds
`2^32-1/g->hash_len`.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 99af73e40a..1b70bdb07e 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -753,7 +753,7 @@ static void load_oid_from_graph(struct commit_graph *g,
 
 	lex_index = pos - g->num_commits_in_base;
 
-	oidread(oid, g->chunk_oid_lookup + g->hash_len * lex_index);
+	oidread(oid, g->chunk_oid_lookup + st_mult(g->hash_len, lex_index));
 }
 
 static struct commit_list **insert_parent_or_die(struct repository *r,
-- 
2.41.0.347.g7b976b8871f

