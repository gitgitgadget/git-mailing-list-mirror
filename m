Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06ABAC77B76
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjDQU5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjDQU4q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:56:46 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338A5C672
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:36 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id n193so4927724ybf.12
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764860; x=1684356860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YhgS/HETCgTYAYvaTLBae15oddw5fwQFfwH4eFCw1Z8=;
        b=WRLceu4EdOomuu47MZXUeMr9/4FOZsn7iaoG9KTgNcu+zNqa1hLGzdHedSevweqADc
         AAX21123l/PiL4KRfOiy+bq6CaKy7fR+6ZpvShby7TkySF6F4HbLRIRszOhSVatAAloc
         kGkYKHFmz1fowPKcOQFi+UXiXDErnZKUckLXcStRoyJ4tUgP1tDLbY0bdULJFV/z3xw5
         lt+aAGjTa8nzH77zAASAksY+9iwBHtiVsPlUvyO2j7U17HvVerR/8FBxEcFGhxvLk4vT
         1Fnang2JGxSjbP+RBG6E2Ek/vprY65XbozIAMzQD3XoNpvaFBRdgjWPhXqNUKfLxoKkG
         mgOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764860; x=1684356860;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YhgS/HETCgTYAYvaTLBae15oddw5fwQFfwH4eFCw1Z8=;
        b=E7IELMlPERnssXdH5LZKajwA/e0ftq6O/IFrVsRfIZEQzsGeH6jiiTIC0hZxeyI3FB
         irEDyD3zzk7nsU2nw9fTtACtGT+dkfm0GOJixFTHmkNUF+nIsREczP1D10CaifpQDdz8
         pfaA4ftwS6rCU0LsN3RtmdDsyNwgqu8TGvUv3ICcKwsWMK+4mSp2jLvZjZoPAR32UvFQ
         bjVmWjYtkHoKES61XhhxDR4tyj75gYM8tM2QrafGHkJjtBs/QfzZA5haRmCyvtgeaXr9
         IpGVCGMwFIDjLXXs5T9XJaDgaVWTfgU7gtogUOXD8gDd5avQzlYjFAqg3m2wPzTY7XWB
         wutA==
X-Gm-Message-State: AAQBX9eWtHJ0xn3fnYskwhgnONMGKrZRvJhgMK7/D06LGXRzx7jbuJBw
        IHOXQV7b8d5F+dWhf3jieWUQoW5n91Cn7gYmKYweqw==
X-Google-Smtp-Source: AKy350a/nzgdPhqtJH174yxMrEC9NQojmEuzLfSugGxOWPEoe3FI/HoQVJNlCtQh1F6x5MWrtShDvQ==
X-Received: by 2002:a25:55c1:0:b0:b92:4a08:4830 with SMTP id j184-20020a2555c1000000b00b924a084830mr4171720ybb.26.1681764859734;
        Mon, 17 Apr 2023 13:54:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h82-20020a252155000000b00b8d65899d76sm3223881ybh.47.2023.04.17.13.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:19 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 02/10] builtin/repack.c: fix incorrect reference to '-C'
Message-ID: <fbc8d15032e356cb742d1156629ad252a21e6d8c.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When cruft packs were originally being developed, `-C` was designated as
the short-form for `--cruft` (as in `git repack -C`).

This was dropped due to confusion with Git's top-level `-C` option
before submitting to the list. But the reference to it in
`--cruft-expiration`'s help text was never updated. Fix that dangling
reference in this patch.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/repack.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index df4d8e0f0b..d9eee15c2f 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -774,7 +774,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 				N_("same as -a, pack unreachable cruft objects separately"),
 				   PACK_CRUFT),
 		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
-				N_("with -C, expire objects older than this")),
+				N_("with --cruft, expire objects older than this")),
 		OPT_BOOL('d', NULL, &delete_redundant,
 				N_("remove redundant packs, and run git-prune-packed")),
 		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
-- 
2.38.1

