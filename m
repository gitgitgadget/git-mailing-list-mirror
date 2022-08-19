Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB0FC32772
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 20:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351863AbiHSUtm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 16:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351660AbiHSUtS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 16:49:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A2BFA98
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b5so2150374wrr.5
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 13:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=x0ZXedWpqBjN2J00NigXgFYfIAupYdUf2PXG/tIhRcw=;
        b=kC/bXvvrC9c/dRR12nF7zH/JVitc4Y/Uxale5Mzdw56XBnSdR+GAq48CkvYrboYbs0
         du/tQDDHSL6pgEZ4TuE0Z0vh3ym65vpXmOi1F4oznaP9JK4bK+iACF21DHISuX8F8f9v
         YIgI+XbmIA2r3Shoe29D4G/ivjXEIyCr5huD6L4S9Cf8jKIedQuaQ5hiQYX5ZW1V/ig6
         v0FyLCbiZgPC2j3rct4lxTYtg5sQzZGfgpeEV7OuEpx/5+hBpH0Ya7aV6Oko6aydh1Zd
         7TcvLwpjEMrAtsUduxeWkeWNDcHCZxIA8bSnV6qd+w0AwmVZk5p5mAQ0GALg4DL2xG8Y
         mT4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=x0ZXedWpqBjN2J00NigXgFYfIAupYdUf2PXG/tIhRcw=;
        b=yBI0ampbp1d0Vo5wIeDQMPfrN7qaMUVv1aipuvDzE1cshG+CWFr56oFmy5PmiSQGV7
         hrgCyT0/5onAy3hpsT3HiKCdiFAgBKR45kPuiIz7Y2CubSo5kp6KaCBMKS710z8JDudt
         /mvTa8tUjY5RuwUb/xIL+g8/tyjL33zKcNFNBfwYzXe/DxjhfZ3BYrFeBpFu09vdIhl9
         q/2ZQ1TvNZ0EpEA3T1deDvRCaoFqktg807vwaKIO0fneJHYatHYXcej5J/qL1/+tycbM
         hdhuG2H90TLppUAJ30ucVdxLFcqwx8DjMLsUGEMS4btXctbtXWFwrOmox1hlJAcSPjqM
         Beaw==
X-Gm-Message-State: ACgBeo0VSZ3vZrgyvmKIcL+IwZUa4VfAVuguRe76xdP6RkHXJsqlifGX
        fWHqcRSKpvzXapTDShfElohTSHxSKCk=
X-Google-Smtp-Source: AA6agR500AgPveIkKB1k68IuQ2OfVg4nbN8p9mIWC15ua/m+jfILdBztMkVDxxlK2stDFyQcuEzPxw==
X-Received: by 2002:a5d:620f:0:b0:225:32fc:cea3 with SMTP id y15-20020a5d620f000000b0022532fccea3mr4305413wru.270.1660942152547;
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t14-20020adfe10e000000b0021e8d205705sm146068wrz.51.2022.08.19.13.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:49:12 -0700 (PDT)
Message-Id: <e79f23a66b28087b8690ff0f604b806babc49cd0.1660942149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
References: <pull.1330.git.1660942149.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 19 Aug 2022 20:49:09 +0000
Subject: [PATCH 2/2] p0006: fix 'read-tree' argument ordering
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

In the 'p0006' test "read-tree br_base br_ballast", move the '-n' flag used
in 'git read-tree' ahead of its positional arguments.

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p0006-read-tree-checkout.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p0006-read-tree-checkout.sh b/t/perf/p0006-read-tree-checkout.sh
index 900b385c4bb..c481c012d2f 100755
--- a/t/perf/p0006-read-tree-checkout.sh
+++ b/t/perf/p0006-read-tree-checkout.sh
@@ -46,7 +46,7 @@ test_expect_success "setup repo" '
 '
 
 test_perf "read-tree br_base br_ballast ($nr_files)" '
-	git read-tree -m br_base br_ballast -n
+	git read-tree -n -m br_base br_ballast
 '
 
 test_perf "switch between br_base br_ballast ($nr_files)" '
-- 
gitgitgadget
