Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2DCBECAAA1
	for <git@archiver.kernel.org>; Mon,  5 Sep 2022 08:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237599AbiIEI1I (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Sep 2022 04:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbiIEI06 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Sep 2022 04:26:58 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07A0FB5F
        for <git@vger.kernel.org>; Mon,  5 Sep 2022 01:26:57 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b5so10289163wrr.5
        for <git@vger.kernel.org>; Mon, 05 Sep 2022 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=TL5TyHrZ5XUY0hICgosvk+kk2BnltBeCOX3iFWPwstY=;
        b=npcAaTaBxvsa7bVuPyqH0KJvElVKeHHYm/SgPV3mrnMjgOUUQVyjPtztcFv0x4ghG1
         0q2A/oN0yASR2vtoJEIlHWCIGPT3/NRYWdWTBzvZzNHXPdUi47kb4qiodWq8Q2T/z1rY
         LXzdlOvO1DRo1ps5IXjcKVjebSp2/Av5zvOrUy4pE4RyQO/1CXBCLe1AsLJe0PWfMiGi
         1YaYgKIIDLmixdpDCfxedJ1+/3HnalsQ3jX3jkVrse6cdfe44tCLLwdYtP5rP+4T7bHZ
         KHO7fdm31ZulZgyeAyPWu+UTzSFhiz72bG5WqQO0lcAwHsWlBn56BHOdYn+pVdbvXT55
         4iSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=TL5TyHrZ5XUY0hICgosvk+kk2BnltBeCOX3iFWPwstY=;
        b=tb1loTOHuioeKETQR+HI5rsiZyZCtNodCnOMM8D/FXu+iRL+RnfZYwcCdi8j/qNV2b
         AFWcXa2pAmeQJdon8a8XOJESRsPFz0tmQyQvuRa0Xr787gso02v3QTGtr88HH3nYg22g
         PNgSxFVvs8/UtZn6mls/AJgU/JPqXX2DXfuzV/kM2SXGprvJlTRK9yxT/dM6n0qRdPXz
         k21akt2B01Kk21H1VptXKH9TDrYnvPVmj8njrd9+PB8lgsSOwsKcS4qt8Y4w2Y8HR5KM
         3abxYEXVVtcToXLHsKw6XKxSpRO9SS9h3DMOlFvqYGi7znhNPsDK6GgT4FMTqa9a3yiX
         8vnQ==
X-Gm-Message-State: ACgBeo2rNw7L6mG3CamvCieLCT6vfXy2HjF5Yku5qYjY5mFH4Tmpxd5Y
        esL1a94rYfSHIPYUB+3i+CWmCM/UPaBmcw==
X-Google-Smtp-Source: AA6agR5+1khTx6cnsrdgXQdnn5EGxduBYe+Sx1JG5Sn0MyKDNnUrFQruDXLWV8nvJqV6MeLV83/Dsg==
X-Received: by 2002:a05:6000:1d99:b0:228:4727:54cb with SMTP id bk25-20020a0560001d9900b00228472754cbmr7575554wrb.694.1662366415188;
        Mon, 05 Sep 2022 01:26:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b003a2f6367049sm10564258wmq.48.2022.09.05.01.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 01:26:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 04/34] blame: use a more detailed usage_msg_optf() error on bad -L
Date:   Mon,  5 Sep 2022 10:26:15 +0200
Message-Id: <patch-04.34-22c3d1a73dc-20220902T092734Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1425.g73df845bcb2
In-Reply-To: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Improve the error message emitted when there's a bad -L argument, and
do so using the parse-options.c flavor of "usage()", instead of using
the non-parse-options.c usage() function. This was the last user of
usage() in this file.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/blame.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index a9fe8cf7a68..8ec59fa2096 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1108,12 +1108,13 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	anchor = 1;
 	range_set_init(&ranges, range_list.nr);
 	for (range_i = 0; range_i < range_list.nr; ++range_i) {
+		const char *arg = range_list.items[range_i].string;
 		long bottom, top;
-		if (parse_range_arg(range_list.items[range_i].string,
-				    nth_line_cb, &sb, lno, anchor,
+		if (parse_range_arg(arg, nth_line_cb, &sb, lno, anchor,
 				    &bottom, &top, sb.path,
 				    the_repository->index))
-			usage(blame_usage);
+			usage_msg_optf(_("failed to parse -L argument '%s'"),
+				       blame_opt_usage, options, arg);
 		if ((!lno && (top || bottom)) || lno < bottom)
 			die(Q_("file %s has only %lu line",
 			       "file %s has only %lu lines",
-- 
2.37.3.1425.g73df845bcb2

