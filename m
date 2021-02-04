Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB605C433E0
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A733664F6A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 04:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhBDEAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Feb 2021 23:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbhBDD7x (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Feb 2021 22:59:53 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD7EC061788
        for <git@vger.kernel.org>; Wed,  3 Feb 2021 19:59:12 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id o18so1488253qtp.10
        for <git@vger.kernel.org>; Wed, 03 Feb 2021 19:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=x73HYCTvK80b0qs1/doa9iy8Ofke50OU26ioocYcYBk=;
        b=QnwYXzffsC6fxiPJXu9Ie4Aybj7QQ4bJtoqQHGqieDLlhAu4J42YTmkEiwe+fDWztA
         XuiuUeQXTD3Jjj3nPuNs+kJqHsl2F64GKsqR9ggT1FtVKzdby6JhfUzAxIQapqWKuV3y
         7DdNqYXaFQZ+i8JCpt3oNm7CNVzby5gRD4Ltz4WhAZUZqbrgPMkES0He2XlW8AaXahqm
         Yl+3xn1gjr8NeK4/Eb6fME2fnMEQA+r/dkJOcF4/eVUHViQ6sqPGglQJ+YAKonTg8xTn
         4RSi8QzfJxFxu5wkFrm4/XQAQbfXHcgIbKX8MrBSiiGnkEqTacHvFWenPN+DoirFR/va
         F+xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=x73HYCTvK80b0qs1/doa9iy8Ofke50OU26ioocYcYBk=;
        b=m0Siu82M8+mSPIKNV8XYt0Rf37bj75UDamEHKircn/+p3rp8mGEgaMbNQ9seDjDIhR
         aIAOKQ37IExGnMtH+yH4by1hsWqGhpZBdGY9BKmMoIr9/3QvcZUt0tAO3FICSbPim2Rz
         e5696oziV69UT2unzrJdmWh7gIwKZe39w8fg+yR7GlGPwSImtTgK/JtlXcTYxozj/MMx
         J5PkxzoQVQoaySskILygLlOj8ugMR8wkU7IdEAh1ak9D0YQLet6n4ZtCoNlyseVrDqAE
         JyAuTY+LIzyqcrXagSXAuu4eMzB/CKL5Us4tIOHS5u6E0yDP0sa9VmV0fb1HaDGCkBIi
         tUrA==
X-Gm-Message-State: AOAM533Bme7/ATwD9oaXBpQFR3DpuO1xq3+NUA0oMsOGrAVm2XdzKbZ0
        We0RMjIVJOnh5bUPEAPRLz4D/GjoFSooZA==
X-Google-Smtp-Source: ABdhPJz/XpEbjnUvZH0C8b1WN3BWRIRKSZPXcNsV/U8popnENYgwruFM/MZP+HqPk6wdRfBy6zdMgw==
X-Received: by 2002:ac8:3683:: with SMTP id a3mr5490318qtc.367.1612411151700;
        Wed, 03 Feb 2021 19:59:11 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:3a5f:649:7bf7:4ac8])
        by smtp.gmail.com with ESMTPSA id x134sm3994339qka.1.2021.02.03.19.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Feb 2021 19:59:11 -0800 (PST)
Date:   Wed, 3 Feb 2021 22:59:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, peff@peff.net
Subject: [PATCH v2 4/8] p5303: add missing &&-chains
Message-ID: <a46b7002b42a9f948154c4d276bf31a0a3e7b552.1612411124.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1612411123.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1612411123.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

These are in a helper function, so the usual chain-lint doesn't notice
them. This function is still not perfect, as it has some git invocations
on the left-hand-side of the pipe, but it's primary purpose is timing,
not finding bugs or correctness issues.

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/perf/p5303-many-packs.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/perf/p5303-many-packs.sh b/t/perf/p5303-many-packs.sh
index ce0c42cc9f..d90d714923 100755
--- a/t/perf/p5303-many-packs.sh
+++ b/t/perf/p5303-many-packs.sh
@@ -28,11 +28,11 @@ repack_into_n () {
 			push @commits, $_ if $. % 5 == 1;
 		}
 		print reverse @commits;
-	' "$1" >pushes
+	' "$1" >pushes &&
 
 	# create base packfile
 	head -n 1 pushes |
-	git pack-objects --delta-base-offset --revs staging/pack
+	git pack-objects --delta-base-offset --revs staging/pack &&
 
 	# and then incrementals between each pair of commits
 	last= &&
-- 
2.30.0.533.g2f8b6b552f.dirty

