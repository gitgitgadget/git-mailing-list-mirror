Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B2DC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B7B460FE9
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232145AbhFUW1g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhFUW1f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:27:35 -0400
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2999CC061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:20 -0700 (PDT)
Received: by mail-il1-x130.google.com with SMTP id h3so16729975ilc.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OqGRm3pg+O/AiftNk5fRF2XsCUvLD0T9jIAgs3Vf6m0=;
        b=vZ5lAoMgcLFmOpgSR7w9G0O26i4dp4AAWbeSIV9RslZYGZshSBFkhJhOvxxb99ZoJ4
         idoqvXiOfWzVbfe/JoieBysb2zgJp0+7RHoYmTN/BPEsa03EBQ3Ul+H/mW/wQonBW/Cf
         dRrObovSeGFae8/ZYjqk2s6TJMaOEusq/r0M4nGW4uzYrTJaKEQh01ngCjCIpRQ2bJKW
         szjxN7tbhh8IyLU/Jw46NblhPfbwChMmlbr9YouxaE6A0t3o6JUmXRqc8xficcPtEbs/
         cNBQPMjLysYlCblsxK8tIAeLrxp3OdFz6IiIbSjD4HsVeSkSIbmEbOFl2ZXmdX7ppPv7
         wt5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OqGRm3pg+O/AiftNk5fRF2XsCUvLD0T9jIAgs3Vf6m0=;
        b=RoVn4RqtY6wXc3efe6AoWGWjyRy8cKS6h68AMAmE0zlyg9+ZxN62n+89S7ztG7AAlk
         LJ1qKzSPY3/D79VP/0kVa66aFdLGe/sy4M/nQ86b3txtg+Uv+JMrSONs/T3Kk9gwIt7H
         InyRJcztUxVKsVIyzjI0V8aJGwhG9ipoRiHnVXBsQyJ7ufhMXSgVS/xPWAgDkVcFxKzo
         NjPEXIu2WRN5BP1gP3NdmaKWTIzVMI7spfVdJMyYRzPBqjLcqfwN2rpYzYCIe2glF3xI
         nnSeYya3OUlh2y4oudvV+8B6Hr3eQSnFmXCmzsn4EaxuavSUXrWk+XES+b27nFixhR/D
         F7Hw==
X-Gm-Message-State: AOAM533SniKJh6Syh2Y3ck6u8YK46oJYZVR0WmvvBkbvVJv/+v3yrbTe
        lWn+WjtxvDXjhD8lzR9qeznzMTeZT7p2BMft
X-Google-Smtp-Source: ABdhPJz2ak0iPqHQgYhtIataahXVY0Gi5PcMT6IIiNli+/781CWUatJ1uNbC4GKxaaZHjYbVH1DGZQ==
X-Received: by 2002:a05:6e02:20c2:: with SMTP id 2mr350507ilq.222.1624314319309;
        Mon, 21 Jun 2021 15:25:19 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id c3sm6435735ils.54.2021.06.21.15.25.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:25:18 -0700 (PDT)
Date:   Mon, 21 Jun 2021 18:25:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com,
        jonathantanmy@google.com
Subject: [PATCH v2 08/24] midx: respect 'core.multiPackIndex' when writing
Message-ID: <dfd1daacc5b12d470bb6deec3448cf7dbde2bf0f.1624314293.git.me@ttaylorr.com>
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1624314293.git.me@ttaylorr.com>
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
index 40eb7974ba..759007d5a8 100644
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

