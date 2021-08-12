Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BC8C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E6160C3F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 08:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235549AbhHLJAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 05:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235158AbhHLJAD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 05:00:03 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D162C061765
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:59:39 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id w13-20020a17090aea0db029017897a5f7bcso9631333pjy.5
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 01:59:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=17hrpRDNSSHc6Xh9SaQRlxZZds40q0XL7WN3NR6Aopc=;
        b=PPis7kJYNIAYce4+Lyyz5YRB/VyD/FvjoDas4B7kSS24zEQDkDa5a2mjOVrgR/2RAq
         BZVid/sajHk0RNEi3ntLXxmFL4ocbFyMC28m4e7voFZneoHcMvU2ZNry1sgZfHZlIie7
         OWv2w9XEbRSD0EBrJ+f9kRjuTCG4+32EWe1kDQPcwLssDtIpucbnQ+ta8++wcNMBShBn
         iNDoIlLjuIleUtzA2ORrWsfzDRD9gzaAZZ0jykugxNQsvM2yTX6mvosx5KQBSGWfR51Q
         394I2l/p2Km8LoGMGfMs+WS3Kl2i6NFo2YNek+oIudsfMsYmX6PtO/xBhRLo5zQzJeko
         GiRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=17hrpRDNSSHc6Xh9SaQRlxZZds40q0XL7WN3NR6Aopc=;
        b=YUQTXZXZrUN1x/UxswAKhf31QJNi3LPVCG74TT+K1I8MyvVdvbNlgeVrLkGz6vbEDy
         bWJ8G9D085YFzrcUuyZV+gJoETsPWRTl4YRGvR0Ujh5tIxsQJy0X4evWRT1te7p1cxu/
         tcd3HqHbgEYran46XVBGFr4Pbn6Yn2YYTHpaW0OwEijvFb8PesP/VFVOTjO6X6UtyvV9
         S4ZZsAlVZmVps03hMeCBgwMOEWJ7HWtJWNWURRjpD6DR5F4CJQIWwMg74m9irOhasdSj
         8NSbvK8PqApGAqlMHnpxklpFxAg0Em4D9AERkXn/S8nxSYyD9aZOgSibgx84B2m0SH6k
         8WUQ==
X-Gm-Message-State: AOAM531qjmz4ddGrs7egEXEDH5JPYh6YhFM8BHAYU8cXe/otpwzbeN3j
        qx0g23bmIfI896X2UT77Px5+J78JIWq09Y6lYd8=
X-Google-Smtp-Source: ABdhPJwaTAUiZnujVvY4Gb3MYaV4PoJZb14uwPUHZ7DTyFrYOBS10VEYZOAR3CQ18Lbvg6Foiywxog==
X-Received: by 2002:a62:8491:0:b029:3dd:a29a:a1e4 with SMTP id k139-20020a6284910000b02903dda29aa1e4mr3131227pfd.13.1628758778663;
        Thu, 12 Aug 2021 01:59:38 -0700 (PDT)
Received: from localhost.localdomain ([47.246.98.159])
        by smtp.gmail.com with ESMTPSA id e35sm9892264pjk.28.2021.08.12.01.59.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Aug 2021 01:59:38 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net
Subject: [PATCH v3 0/1] list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
Date:   Thu, 12 Aug 2021 16:59:30 +0800
Message-Id: <cover.1628758416.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.32.0.1.g4c9ac18d93.dirty
In-Reply-To: <cover.1628757762.git.dyroneteng@gmail.com>
References: <cover.1628757762.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch-v3 fix the indent problem in v2.


Teng Long (1):
  list-objects.c: rename "traverse_trees_and_blobs" to
    "traverse_non_commits"

 list-objects.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Range-diff against v2:
1:  2d19f0901c ! 1:  8548aa8bb1 list-objects.c: rename "traverse_trees_and_blobs" to "traverse_non_commits"
    @@ list-objects.c: static void add_pending_tree(struct rev_info *revs, struct tree
      }
      
     -static void traverse_trees_and_blobs(struct traversal_context *ctx,
    +-				     struct strbuf *base)
     +static void traverse_non_commits(struct traversal_context *ctx,
    - 				     struct strbuf *base)
    ++				 struct strbuf *base)
      {
      	int i;
    + 
     @@ list-objects.c: static void do_traverse(struct traversal_context *ctx)
      			 * needs a reallocation for each commit. Can we pass the
      			 * tree directory without allocation churn?
-- 
2.32.0.1.g4c9ac18d93.dirty

