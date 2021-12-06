Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8274CC433F5
	for <git@archiver.kernel.org>; Mon,  6 Dec 2021 20:48:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349824AbhLFUwR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Dec 2021 15:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238973AbhLFUwQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Dec 2021 15:52:16 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353F0C061746
        for <git@vger.kernel.org>; Mon,  6 Dec 2021 12:48:47 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p18so9109246wmq.5
        for <git@vger.kernel.org>; Mon, 06 Dec 2021 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=UDjcsFrC04xfORpMQuRDcYTm+NcN2AlN8Ua1oYD57Lg=;
        b=cYG89AFrGGwtkRHeDI78du9MNU70ERRd4DRNOclH2/zTf7KZIOmN/fTkbLWGRa84vw
         ec+r6I1XCv52hRgOasyycmcnzztsX4fEwpBNpiEJXHBXy2bm7B5gPqQOf1glZ2s4SHgR
         QNJVogG6PY16hZZruyjsxKhGwDTrg1moci/ir1S2Q6UW+tjYqrPwFXtttTLJysDxadWp
         QJL3S4IIzcTDAIIIFbtmi4xmZ0YWvcHa4BNHFFrMybfAgN8VJ2qQY1Y8pt2cX0gtPXCS
         +K0KTv6dZg4Y6bI1qVsfaOlBj9YChDw7kJ8IWf3xnxTvr0jFzDMemZX1ntEM5nTShD1n
         MWYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UDjcsFrC04xfORpMQuRDcYTm+NcN2AlN8Ua1oYD57Lg=;
        b=cnI3lMPuIJbCeMr9rlLEFfeM+p9oSHmZU8QrZGkoni0yCRaVgf1HGavqeKPQZUA+J4
         SZFl/GjhDnxWj49nwRyvMVdyE3D4uvydo3XjYbIenPQLF63H0EyxTBRPySGTLyg5IIgg
         K212HJZY/hlVHGO5hWhbZ+54Y5X6+bUwPAfIRm0DzhPellLKa39afypSSVArd9TVypY7
         PuxuwsWwquyo4chTWS6xOvrcC9fEY7ISVM/fCjuUpTMEGHoDsGGub1K+aLee1NAQF7i6
         q4s7xb/1vWOe4RVgNPXdbG/+lHcgWbG6iQqHgFtFjOc8o6w2CtnoiJMdFk36VIil/9WQ
         Viqw==
X-Gm-Message-State: AOAM530cT9Re9Ic/CqxzqjtxstK2veGYpTAnNSR9+07ePViuUvoUS3hR
        4jdkx/BSx61+A2n0zHlaHYb+sa7MQKc=
X-Google-Smtp-Source: ABdhPJyhg4pyv0farzBcVaE24Wa0W91WPq9/ghk5tnHJP0wLF2if7vREICXMXx74Pe1aGQ5GI3UVdA==
X-Received: by 2002:a7b:c76e:: with SMTP id x14mr1180272wmk.27.1638823725642;
        Mon, 06 Dec 2021 12:48:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j40sm451341wms.19.2021.12.06.12.48.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 12:48:45 -0800 (PST)
Message-Id: <pull.1094.git.1638823724410.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 06 Dec 2021 20:48:44 +0000
Subject: [PATCH] git-compat-util(msvc): C11 does not imply support for
 zero-sized arrays
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This seems to be required to define `FLEX_ARRAY` in a manner that MSVC
in C11 mode accepts. Without this fix, building Git for Windows'
experimental FSCache code would fail thusly:

	error C2229: struct 'heap_fsentry' has an illegal zero-sized array

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    git-compat-util(msvc): C11 does not imply support for zero-sized arrays
    
    In Git for Windows' continuously-rebased branches, I found this problem
    [https://github.com/git-for-windows/git/runs/4431149285?check_suite_focus=true#step:9:14507]
    (which uses FLEX_ARRAY correctly, but fails because FLEX_ARRAY is no
    longer defined as required by MS Visual C).
    
    This patch is based on bc/require-c99.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1094%2Fdscho%2Fflex-array-and-msvc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1094/dscho/flex-array-and-msvc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1094

 git-compat-util.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 19943e214ba..c9f508b3a83 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -46,7 +46,7 @@
 /*
  * See if our compiler is known to support flexible array members.
  */
-#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
+#if defined(__STDC_VERSION__) && (__STDC_VERSION__ >= 199901L) && !defined(_MSC_VER) && (!defined(__SUNPRO_C) || (__SUNPRO_C > 0x580))
 # define FLEX_ARRAY /* empty */
 #elif defined(__GNUC__)
 # if (__GNUC__ >= 3)

base-commit: 7bc341e21b566c6685b7d993ca80459f9994be38
-- 
gitgitgadget
