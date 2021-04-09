Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB820C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56B7610A6
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 18:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhDISLu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 14:11:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234657AbhDISLo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 14:11:44 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32BFCC0613D7
        for <git@vger.kernel.org>; Fri,  9 Apr 2021 11:11:28 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id v26so6807104iox.11
        for <git@vger.kernel.org>; Fri, 09 Apr 2021 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Go+L+Yv0YAe8sLVQCQ1HzOKhlRDJel+G+r6ct2W0Grk=;
        b=D7hlf61dOXPNL8Kv4rgFyX+pROW85d2Ih8jCToE9FfV+/NkptyWm5eSKNxyGGA43dY
         Bw2a0VDUKZonhnQVqNjUcPqMit/069mqdUwzPDbagauGK3Pb5GOCYnwvEp96k58X2uTg
         fTR/JdrNgjpBPiBMsB7luMUt+77sRf8hmAhHnxMuJ9qEWRNNmZDvCKDq3Rk+su2+t5UB
         SvxTNU3cj/irert1FoiRAythqkMAvHx1gy8QtmFwWr6YCa6pcd8s4zrBubhrvhZdsl7o
         50uUUC3ypkZHcX0q3rWOQE/0OYxcaPuLQrYMb4q5astUatW9PrOiE7nDVEXC9s73wQw1
         v2vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Go+L+Yv0YAe8sLVQCQ1HzOKhlRDJel+G+r6ct2W0Grk=;
        b=Y8xrxSnYyrwvbzc7JDSOUeK6KQqfbB2ht4vN0OxV8//OfNDJ+q/nIu2JBspSJBPNkK
         NmFBwF/iVqJ1oSkSVQ3fOYXw4ZTPIbeSMaAkScWegArbe6cTZtwaCGmnnYgVSrhctJhk
         jYsuh+F9t8z9QyXBWuHNW9ORNNHQj9+tTfPfDBiGKmoNNzWpQSC7jW1aynfDpKUB4hUk
         QJAmiXRrylRYIbjcwxRdHoJg7/guM05KQcy3ip/FitmdrGW4+r/QN8e8ELZKVAJazJTd
         E7U+ynF2pkwrXk3nps8/yIWcxfK0EXH1HOdcymnpywou5lmEd2mEQMvBmnItdr3uOiok
         rBpw==
X-Gm-Message-State: AOAM533soQY7k6F35wvWDa/ElcMIn1Dek4L7Ngo0whUylyl5FrYBMRU3
        JueJjGdki+IYHWxWcvlrk4soFzJE1oQe+1fq
X-Google-Smtp-Source: ABdhPJz11P9On5swrLHkresU/KOaaz2Q4jkOXkWrh8Iecrcaj5tcn9rUs5nZ98bWbMKeHnY43S4+bQ==
X-Received: by 2002:a5e:de0d:: with SMTP id e13mr12431067iok.208.1617991887357;
        Fri, 09 Apr 2021 11:11:27 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:64f1:fbc0:31eb:386a])
        by smtp.gmail.com with ESMTPSA id o8sm1549146ilt.4.2021.04.09.11.11.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 11:11:27 -0700 (PDT)
Date:   Fri, 9 Apr 2021 14:11:25 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH 08/22] midx: respect 'core.multiPackIndex' when writing
Message-ID: <8643174a67812f347856bef274d6b971b15dbffc.1617991824.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1617991824.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When writing a new multi-pack index, write_midx_internal() attempts to
load any existing one to fill in some pieces of information. But it uses
load_multi_pack_index(), which ignores the configuration
"core.multiPackIndex", which indicates whether or not Git is allowed to
read an existing multi-pack-index.

Replace this with a routine that does respect that setting, to avoid
reading multi-pack-index files when told not to.

This avoids a problem that would arise in subsequent patches due to the
combination of 'git repack' reopening the object store in-process and
the multi-pack index code not checking whether a pack already exists in
the object store when calling add_pack_to_midx().

This would ultimately lead to a cycle being created along the
'packed_git' struct's '->next' pointer. That is obviously bad, but it
has hard-to-debug downstream effects like saying a bitmap can't be
loaded for a pack because one already exists (for the same pack).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index a24c36968d..567cdf0fcf 100644
--- a/midx.c
+++ b/midx.c
@@ -908,8 +908,18 @@ static int write_midx_internal(const char *object_dir, struct multi_pack_index *
 
 	if (m)
 		ctx.m = m;
-	else
-		ctx.m = load_multi_pack_index(object_dir, 1);
+	else {
+		struct multi_pack_index *cur;
+
+		prepare_multi_pack_index_one(the_repository, object_dir, 1);
+
+		ctx.m = NULL;
+		for (cur = the_repository->objects->multi_pack_index; cur;
+		     cur = cur->next) {
+			if (!strcmp(object_dir, cur->object_dir))
+				ctx.m = cur;
+		}
+	}
 
 	ctx.nr = 0;
 	ctx.alloc = ctx.m ? ctx.m->num_packs : 16;
-- 
2.31.1.163.ga65ce7f831

