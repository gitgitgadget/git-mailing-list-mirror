Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19A8E1F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbeG1E3p (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:45 -0400
Received: from mail-it0-f74.google.com ([209.85.214.74]:53643 "EHLO
        mail-it0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725962AbeG1E3p (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:45 -0400
Received: by mail-it0-f74.google.com with SMTP id e5-v6so6838769itf.3
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=QcRn02+ViiELc/jhfuBzo79LVOh64NkAkaLVCae9gyE=;
        b=tHLpvu81cj9qoLYX3KVSwYtLjK3WANY/Q+IYT0vq5GNP9iBGDxfWDpW75beZ9U3wxM
         CoRvojS4V3/qTdFUDJmh+t0F0iOeFH2K0OJNiyEnUVmQrzVMjg7oPegfkw9rxEaEjQM4
         +OGDHRntYuS1HlncIO8Xen1DaJxdWo4/Z2fWgW9mVKC9o/MD0xt/v29eyrSqZrPfxpYJ
         6J0y36K8xeyu4ZGNedIjcdU4DguBTAuqO6yFmTDiaY+FVeTDAHxbkvnXLoKbgGPB82cq
         Q7tumSdTGNJ0tlLdut8ymMKWanfAVKylm7jXIj00WFGKQZNdYVcNPvDTuqECjbABRKMC
         loaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=QcRn02+ViiELc/jhfuBzo79LVOh64NkAkaLVCae9gyE=;
        b=QjMjM6fXirq/ZBnk6DHnUOc74Zmf/Fks7oe/dQlbZPLvh/ZVraBk1UWPe/NhyA/oYH
         Hva0hc6yDZPfYf/AwY5KZAVng6eIpCqL5A1tn+lsDG/4mtqIzkRQWpoNlNxAl73a9FH3
         GaxZ2ypZB2VqqL6aCHsTmF90Rp0FbCVHj73rZQbMzzl/q8tnsT6nk+0sO8uin3CtdMcO
         TYfkb6i+c0zIN8iHX8GuogyDnW/6Vr/B6E+LLzjP4VqmrKxZdXMQhH7RtWECIGGvnGTm
         /DG/eNUz8rF6IImo8y5SXh8UvTi8j0DAZDGceYWvHI3/ea3DzlWHurgG5pw3erPk5L/N
         Pj2w==
X-Gm-Message-State: AOUpUlFzoOUsP69t87paddOPlYlhAZGOgLnIpxBAN6aQpocklbT3C45k
        uTxJ+PBd4MOW5aA9Hn796+ZBALJU/aPW2mrSZEhJWyoUrVKpQ9/HVJG7v8WBuYkD/QP5P+KfnKh
        mBQwzwEYY0YY08AWzlKVy0go/lnLxyiphYte04/QOtopGBVokJ35Q62432UM/
X-Google-Smtp-Source: AAOMgpex9uq8balVcC2ps3W/ybV8yThp9Qngvvw8t/K7WL1KhjtMeCf6BrEdmRbBPM7XGImx4u+xu4S9lk1g
X-Received: by 2002:a6b:88a0:: with SMTP id s32-v6mr3212466ioi.45.1532747099830;
 Fri, 27 Jul 2018 20:04:59 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:43 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-4-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 3/8] diff.c: simplify caller of emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Due to the previous condition we know "set_sign != NULL" at that point.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 272b0b93834..f7251c89cbb 100644
--- a/diff.c
+++ b/diff.c
@@ -997,8 +997,7 @@ static void emit_line_ws_markup(struct diff_options *o,
 		emit_line_0(o, set, 0, reset, sign, line, len);
 	else if (!ws) {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign ? set_sign : set, !!set_sign, reset,
-			    sign, "", 0);
+		emit_line_0(o, set_sign, !!set_sign, reset, sign, "", 0);
 		emit_line_0(o, set, 0, reset, 0, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-- 
2.18.0.345.g5c9ce644c3-goog

