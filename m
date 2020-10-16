Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E784BC433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9476622201
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 22:51:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aF62Q7kH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391572AbgJPWu7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 18:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391398AbgJPWu6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 18:50:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4831C0613D4
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x7so4836757wrl.3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 15:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YCcBq7uCUv7by2eNnP3fgCW/GjKJ083YCS4vjPAbBEU=;
        b=aF62Q7kHEItEXNmu+3yfiFjlQ8vMusv7xITWlzl7uxIRZ/x9jNUmBpfhFshn6cYhW5
         dPQrJOuKAsZ+74iczUEDzWxjLO8NrMEkE57/9Z1QpbZlI+0TNh2EJk0m10zrD/5va2h5
         ZdbChPeZZoE+08R4ubvlDEyW9ksMx5IzMvNyuD0m3Dwm6IQWaWtQp9zBkIpqZZ7TaOiY
         IeLwgMfB+IAnqCn5e6NK2rKf+SqV16L4fOxlTOcBUD36CpfCOxRTk3PqO1UCMsqsq/y1
         bz+dZdDRggc5MOT9+xDZbBYhhG++vNoMbHfytWiyhU4nAnFkbO4cBopoh3Wz+aW6hLWS
         rxtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YCcBq7uCUv7by2eNnP3fgCW/GjKJ083YCS4vjPAbBEU=;
        b=b23aPPnzPU/InYKfdswdcsR83+RgCSFjOoYDkkjJU108tqndSENPIUSVpfODPONsiZ
         ybZNmReAQ/tlfhrKG6DZFVnMQZ1TnJz2WTo36Va/n++sFSz8JPjCVHwEqVOD7rZVZaz8
         vIKt8aEoRyG+4kNxYonQiZ649kaSde0HOvutpNc2vFMnls3e4gfDGBl8wsxZ4GQRSzdy
         TdffpuEtzGVzzd9+zZg7czOlYXBuBkBPQQUT2V/xkN9rDz/vvnw7QkHEUSfey7iW0a1/
         tEDng/X4S+LuGnVgA6bAk/oSh6Yj8x+vVYzzGDjzAyNU0EmXSHbWoAVpyi5cpMLNMt94
         H8rQ==
X-Gm-Message-State: AOAM533CiILHJihCvOgmlRRpYZxR5PYH9cvwlqxtJSGxYB9+GpHDkA+z
        YZJKIPa28rlO4/0nCthfk2cgrDNIiPs=
X-Google-Smtp-Source: ABdhPJycZeHIOV7lvai9EJB2w0rsz406dLyt1WXoj0ZTmgdEN4YQBb2IxXGF8sVHPDAoLfNE3WVxeQ==
X-Received: by 2002:adf:cd82:: with SMTP id q2mr6971655wrj.118.1602888656621;
        Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w1sm5157194wrp.95.2020.10.16.15.50.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 15:50:56 -0700 (PDT)
Message-Id: <01494bc0ba05cf9258c9445e20d316a4efb32092.1602888652.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
References: <pull.878.v4.git.git.1602876532.gitgitgadget@gmail.com>
        <pull.878.v5.git.git.1602888652.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 16 Oct 2020 22:50:52 +0000
Subject: [PATCH v5 3/3] test-lib: reduce verbosity of skipped tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

When using the --run flag to run just two or three tests from a test
file which contains several dozen tests, having every skipped test print
out dozens of lines of output for the test code for that skipped test
(in addition to the TAP output line) adds up to hundreds or thousands of
lines of irrelevant output that make it very hard to fish out the
relevant results you were looking for.  Simplify the output for skipped
tests to remove this extra output, leaving only the TAP output line
(i.e. the line reading "ok <number> # skip <test-description>", which
already mentions that the test was "skip"ped).

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/test-lib.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index debfd73fd6..e020bcc5e7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1062,7 +1062,6 @@ test_skip () {
 				"      <skipped message=\"$message\" />"
 		fi
 
-		say_color skip >&3 "skipping test: $@"
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
 		;;
-- 
gitgitgadget
