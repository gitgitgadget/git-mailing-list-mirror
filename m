Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A3FCC6FA82
	for <git@archiver.kernel.org>; Tue, 20 Sep 2022 01:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiITBzz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 21:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiITBzt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 21:55:49 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9F504BD1A
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:45 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id w4so1100071qvp.2
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 18:55:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=ABm4tY4qo3i+haS2c9bVXzHyAN0zInwF5tuOJboIi20=;
        b=l+7yJa4HbYsF5Q0d64v9Slbf0WBVRvOgaHPR20Q8Guo4whsNukt5Z//UVBqpYvuN80
         kpjbDb+qKA/V+/186TnXCTzeUt9l2p+2LGGnfllKfFqRqomSE8Tz4kStML6LsRb0FltI
         WyZsxOC2Xz4ZE8Kc0XoG9VNREwXeIeRQ77THYEkzeuBBkuaqBVBR8SIMbDfrxckovP2T
         497KHlxj25i7g7MFUZMEmJWzm1Wr8cFNKGxDiaVuusalqjI/4/zsNbAd6iYEcU7i8Q7C
         T6zOdc9f5yIFqDaGO9lprs/TEerPavOOqf1mWusfx8G0ZtwRlAwiZDBS3U8NYePeoJtD
         Jk3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=ABm4tY4qo3i+haS2c9bVXzHyAN0zInwF5tuOJboIi20=;
        b=dDUyTjGlDAzqsmDd0590Zq/VCzHBWlYtuEQX2nKSMy1i5sRxPmrT7s5Xia0DYBTLRR
         48YteUQeSBe3uOPVlz5rzj7SvEGiRCmXnlXTRGUlPdUxVLbPGPZmulbBYxzaC7K/Ra1k
         aGgC6SJN2y7sTsGGLQm8FVYoznuGY6vYzjZlC7gm8xsQzaN7tyLUAEJskMoaqTRJp9zk
         WVHfassQedwW7deHRDQwO8vci5kIw8Q6L5hU6kepWmZgbQ1OJbc01zvZ1gu4m+dCPWqr
         PBho/YHAq4YZmvOMdTLL3DCmVKAQ4ZfWhDG8Mtsb7FfMXE09Ba/ick1NJBVXo3QUOMf1
         4WEQ==
X-Gm-Message-State: ACrzQf0wsBgPYKBD1n2HMicFga0AhPmyAqbJezW3aygomhl7rYGJx2TS
        8wboJ4HXxHXfu8M9GAHBIegzbWB/WTWGGw==
X-Google-Smtp-Source: AMsMyM4MLj6IX0khrHpayXJqXTGHNZDbbq3P+HVU+a+otoD5sixPze7OWzAz38DaFhu1mD5UGNXxUQ==
X-Received: by 2002:a0c:8dc9:0:b0:473:14fe:7c4e with SMTP id u9-20020a0c8dc9000000b0047314fe7c4emr17006546qvb.44.1663638943941;
        Mon, 19 Sep 2022 18:55:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a4-20020ac85b84000000b0035ce8965045sm24657qta.42.2022.09.19.18.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Sep 2022 18:55:43 -0700 (PDT)
Date:   Mon, 19 Sep 2022 21:55:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, derrickstolee@github.com,
        gregory.szorc@gmail.com
Subject: [PATCH 2/7] Documentation/git-multi-pack-index.txt: clarify expire
 behavior
Message-ID: <4c9296c0ea6f5048c429ccb24fc202c1eb58f2ef.1663638929.git.me@ttaylorr.com>
References: <cover.1663638929.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1663638929.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The `expire` sub-command of `git multi-pack-index` will never expire
`.keep` packs, regardless of whether or not any of their objects were
selected in the MIDX.

This has always been the case since 19575c7c8e (multi-pack-index:
implement 'expire' subcommand, 2019-06-10), which came after cff9711616
(multi-pack-index: prepare for 'expire' subcommand, 2019-06-10), when
this documentation was originally written.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/git-multi-pack-index.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index b4a2378cd8..11e6dc53e3 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -71,8 +71,9 @@ verify::
 
 expire::
 	Delete the pack-files that are tracked by the MIDX file, but
-	have no objects referenced by the MIDX. Rewrite the MIDX file
-	afterward to remove all references to these pack-files.
+	have no objects referenced by the MIDX (with the exception of
+	`.keep` packs). Rewrite the MIDX file afterward to remove all
+	references to these pack-files.
 
 repack::
 	Create a new pack-file containing objects in small pack-files
-- 
2.37.0.1.g1379af2e9d

