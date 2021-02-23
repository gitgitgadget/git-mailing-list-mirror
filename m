Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F44AC433E0
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A08064E31
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 02:26:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhBWC0G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 21:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbhBWCZ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 21:25:57 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 949CFC06178B
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:16 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id c1so10912761qtc.1
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 18:25:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=D7a2htNh5TmV1PuPKkr4mM1Sv6UdleXGHbTmlSyJ708=;
        b=MlrecnNLiUXBrRTqbqsy7puDKBy/wEaT5mdFdbdichXPQS3ZHTY7xuMRJcjVlbUJbQ
         jzLqkZs3f4EhCKLpyWzLkHYaTjPveu5h/SqarJSjqzu3gpkcpoYnFK78QindxkpkFKbU
         VoNNzndznoZDUbdbi7ZhZK5utmPqc8WEtnCm3yK+CLGf3RsW0+OxD2Vg3gSPOkNojth9
         P0Z0XSuzqGQvQDqBh+J3jzfkOv7r/KCLQlTbnwLq6B5gllJ1BwSFSeZk6dEmNfXyTbWk
         NG48LdTmLt3Db3uciT2ElBObKryCdoc+bt3VHDh7AwxX2Ze55GCdmyB1gJ473tGNU76F
         1IoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D7a2htNh5TmV1PuPKkr4mM1Sv6UdleXGHbTmlSyJ708=;
        b=Z/nww4tcAYeA36WfuysprBuMUysFsU6JvJocXtCICobT0dAff8sXdaU5OFFE1C5YfW
         ofmLfneE3gxClkU0gYxZfN/C6/tysoihr+09BIaEiF1kNlZQo3z9HRB2NtQvhptZefWQ
         XqvU5b7BuCDY6Tav3HofOcbIniwDiMtb3Ybe+9PdqKEXFHu6miN2gU4JPaJxjsADSgFG
         0PqWO5SbXWyqTKJsVqYF7ONXbHJyuOAEPsF4yD+I4WE9KCCC7NgaZQGv5gBTNNoWpwNy
         7uYq+a6+UGcvh0WwDt8hLGFMpiKEJJK959sTmhKWw56pUJ4XirjIfPV/ziESFdHJiMey
         FI+g==
X-Gm-Message-State: AOAM533MpyVeWZs9lXLye7Ji++Hoec5hYz6prgc8GBTK5zHlt+5bWjbu
        y5DeyWB9++CBDLH9eQ8BSlH8HThghHRSXfk7
X-Google-Smtp-Source: ABdhPJw8u2nILnoSADTNn6oDyhj7gPTNK6fUZCF3XRXOIsMOKh8kbcFIJ9DMGiaXLxg/U8KPY4xYSw==
X-Received: by 2002:ac8:7b4b:: with SMTP id m11mr23267418qtu.208.1614047115646;
        Mon, 22 Feb 2021 18:25:15 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:29df:918f:599f:2c96])
        by smtp.gmail.com with ESMTPSA id o1sm12334283qtq.81.2021.02.22.18.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 18:25:15 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:25:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com, gitster@pobox.com
Subject: [PATCH v4 4/8] p5303: add missing &&-chains
Message-ID: <6de9f0c52bbde21b478fa5e45743b7e687001744.1614047097.git.me@ttaylorr.com>
References: <cover.1611098616.git.me@ttaylorr.com>
 <cover.1614047097.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1614047097.git.me@ttaylorr.com>
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
2.30.0.667.g81c0cbc6fd

