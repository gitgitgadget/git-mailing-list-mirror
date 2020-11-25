Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6D7C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 041E7206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="egUXoa/a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731064AbgKYRRh (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:17:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgKYRRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:17:36 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF96C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:36 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id b63so2921498pfg.12
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=H1bZ0lj9xGSJTWkocKn/mshKb+Tw72RucmICD7z5Ruc=;
        b=egUXoa/ayDW/6+J66xsalL4ULH7KhAJ27HL9s8RYwvlaI8110/FgEn6WjJ8GsjZqr6
         TRsdIOmNtLSY0oxfWCeC3FkgrQatf+rHtsypBSXxXXLsfm0Nw3JqeZd+o2kvla2YUcPd
         NRspZ++P4FnGvvqDE5xiCaxee/YYORtX4RPp5Z2HQYa+C0LStWP9nDzAK6qywNbD8R5F
         YRagXzEzaBgPXCQ9IQ8mdsXkYxTtD9ctSkDaiGZozTHgyj4tOX4QhLkF2QCofaa2JHzy
         nF7O3qTHyULwRc90TJ4Pl4htdzxoH2keLXQc4AX1tAqOIoyetdPTHuslMB4oXkmTGRIU
         Wdtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=H1bZ0lj9xGSJTWkocKn/mshKb+Tw72RucmICD7z5Ruc=;
        b=E5zJSNvn73w3JDrs1PaYXg3NnxWnhbmQin6JyAN++cpxCdLZ2GKAfRzpavGQ39tDxe
         5hWvr7YTloEOtsdbrx3G9jfeKTIle2Kvy8f89yVIZ66XMX4RdfHfoSa1UDU86HA1d52k
         pqoCPpvFWPOQUkwGjIXBmpVz/37E+QpwsTQdt3yflPk1A5oR1iHyz793ypMdCKR05f/C
         0dS/tXGElWeuAToejIL1ErsQEbfU4fui8Cjj81uiG4OIOzRR6AwW12HxmSvBWAtIZqGc
         nY9V+TNDiyt8sy6Hmf2+rqv5XULNxP5Hr//FebOw/HKnFtD0vgCHyZm5eSUf312Rhz7Z
         YcTg==
X-Gm-Message-State: AOAM5300iiu2KrktMwv9ArX+d3h6WFNDyEAJrdlN9eoOuvsRqwGfnd57
        bxKRLPxoNlYgWrmFOStAo/NSxCBLRZrGSKW2
X-Google-Smtp-Source: ABdhPJw3zFazljIgTEpaU3KAbSm2zg2JMVNASU3ZWOmap0ybxVL1uhyHSDlJzCZvYfVZKwJd7P56Jg==
X-Received: by 2002:a62:1896:0:b029:197:491c:be38 with SMTP id 144-20020a6218960000b0290197491cbe38mr3985394pfy.15.1606324656064;
        Wed, 25 Nov 2020 09:17:36 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id m18sm2618374pff.144.2020.11.25.09.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:17:35 -0800 (PST)
Date:   Wed, 25 Nov 2020 12:17:33 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 2/2] midx.c: protect against disappearing packs
Message-ID: <e1806d1bdc0da8061c78608e56138424ad24bed0.1606324509.git.me@ttaylorr.com>
References: <cover.1606324509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1606324509.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a packed object is stored in a multi-pack index, but that pack has
racily gone away, the MIDX code simply calls die(), when it could be
returning an error to the caller, which would in turn lead to
re-scanning the pack directory.

A pack can racily disappear, for example, due to a simultaneous 'git
repack -ad',

You can also reproduce this with two terminals, where one is running:

    git init
    while true; do
      git commit -q --allow-empty -m foo
      git repack -ad
      git multi-pack-index write
    done

(in effect, constantly writing new MIDXs), and the other is running:

    obj=$(git rev-parse HEAD)
    while true; do
      echo $obj | git cat-file --batch-check='%(objectsize:disk)' || break
    done

That will sometimes hit the error preparing packfile from
multi-pack-index message, which this patch fixes.

Right now, that path to discovering a missing pack looks something like
'find_pack_entry()' calling 'fill_midx_entry()' and eventually making
its way to call 'nth_midxed_pack_entry()'.

'nth_midxed_pack_entry()' already checks 'is_pack_valid()' and
propagates an error if the pack is invalid. So, this works if the pack
has gone away between calling 'prepare_midx_pack()' and before calling
'is_pack_valid()', but not if it disappears before then.

Catch the case where the pack has already disappeared before
'prepare_midx_pack()' by returning an error in that case, too.

Co-authored-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 midx.c                      | 2 +-
 t/t5319-multi-pack-index.sh | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index d233b54ac7..1d2179a61f 100644
--- a/midx.c
+++ b/midx.c
@@ -298,7 +298,7 @@ static int nth_midxed_pack_entry(struct repository *r,
 	pack_int_id = nth_midxed_pack_int_id(m, pos);
 
 	if (prepare_midx_pack(r, m, pack_int_id))
-		die(_("error preparing packfile from multi-pack-index"));
+		return 0;
 	p = m->packs[pack_int_id];
 
 	/*
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d4607daec1..297de502a9 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -755,7 +755,7 @@ test_expect_success 'repack --batch-size=<large> repacks everything' '
 	)
 '
 
-test_expect_success 'load reverse index when missing .idx' '
+test_expect_success 'load reverse index when missing .idx, .pack' '
 	git init repo &&
 	test_when_finished "rm -fr repo" &&
 	(
@@ -768,9 +768,15 @@ test_expect_success 'load reverse index when missing .idx' '
 		git multi-pack-index write &&
 
 		git rev-parse HEAD >tip &&
+		pack=$(ls .git/objects/pack/pack-*.pack) &&
 		idx=$(ls .git/objects/pack/pack-*.idx) &&
 
 		mv $idx $idx.bak &&
+		git cat-file --batch-check="%(objectsize:disk)" <tip &&
+
+		mv $idx.bak $idx &&
+
+		mv $pack $pack.bak &&
 		git cat-file --batch-check="%(objectsize:disk)" <tip
 	)
 '
-- 
2.29.2.368.ge1806d1bdc
