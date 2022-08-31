Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73786ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 16:03:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiHaQDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 12:03:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiHaQCw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 12:02:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEAF1CACB6
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b16so11264227wru.7
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 09:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=MCYwFiy9vE738DPnjGDmJN+C5Cur1qVQh+PXJTq/GGI=;
        b=bzr0BSbMbSIlAVgFBaQdACVHkLInoMvnbrHJNV3oeu3PVciEam2PlUgkx13qdA324P
         NEWQsfuOWlwevpfvsOBhXYa+e7dQyB82LGAFTgiyjP+Ni7G/rSQNfvzuRTOdVhnHvqxH
         oHDjuZ3klFP82vk94EHv1c49AiA9VVyqIcDydi2qbLniLGrEYtYDQ0IQKkLnmTZH7vep
         Aw1qxAFDEFuq22buQLnSlNCKkkC7RZdF1OCPRZfM9rz79DvZyHSW+f4h/xN0uAm24yHG
         LxGAg6O8S5XY4wkOxSW0dZLvNC57DwWBJHnmx+rAovXAJy1hAwNofHWE1a+02X4/0K+N
         FoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=MCYwFiy9vE738DPnjGDmJN+C5Cur1qVQh+PXJTq/GGI=;
        b=Ndc5XVLqygvSq73opzsLqFRFBlTz8Pwu/hsKlM/3iZhoEood25T3FOuyn2RI68hbGE
         dY1SNEA41rpajTIVUs3nWEX+NS4epxHLVldKcwBtVN7CuzQcEEZGxBk0x2IaHd76uFJP
         FErpQ+mM0D7TY81QQDGh8GtvVnmDIAz/DuXfnCARcyh/9WlKjKVM8W+NT83V2Ap4GSHt
         erEUNjva7jIl39LpFds2p1eqOuwaLgfuMmC7Ubp2o0a6DkeO2cnd5y1kHjYDTesCtW9c
         qmHb9zNcdmg0+U4n8/xp8gwbtnbee9Y0/DAU17eu2I1CBnl4Tb807JEVrs2yMK74loLs
         5Z8Q==
X-Gm-Message-State: ACgBeo0pN1KNr+1BsaQzMuQychy3tGre2koA1CJpApWsYch3hqBSKMD6
        cpdyKnRWcn8hlBTBuGkyKiNzdXaOuX0=
X-Google-Smtp-Source: AA6agR7TMs0tL5M9sKWl6LBDQLsksRTxMK5efQEOKcXbafAd2T35ukI3U5XeZN6Pd0iK3WhQD3i/sg==
X-Received: by 2002:adf:ffcc:0:b0:226:df89:73d2 with SMTP id x12-20020adfffcc000000b00226df8973d2mr7207930wrs.612.1661961768007;
        Wed, 31 Aug 2022 09:02:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b8-20020a5d4d88000000b002253d865715sm9501313wru.87.2022.08.31.09.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 09:02:46 -0700 (PDT)
Message-Id: <42ab39f21212d3da1af3546d3425aa790637056f.1661961746.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 16:02:23 +0000
Subject: [PATCH 6/8] t/perf: add Scalar performance tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     derrickstolee@github.com, johannes.schindelin@gmx.de,
        gitster@pobox.com, Victoria Dye <vdye@github.com>,
        Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Create 'p9210-scalar.sh' for testing Scalar performance and comparing
performance of Git operations in Scalar registrations and standard
repositories. Example results:

Test                                                   this tree
------------------------------------------------------------------------
9210.2: scalar clone                                   14.82(18.00+3.63)
9210.3: git clone                                      26.15(36.67+6.90)
9210.4: git status (scalar)                            0.04(0.01+0.01)
9210.5: git status (non-scalar)                        0.10(0.02+0.11)
9210.6: test_commit --append --no-tag A (scalar)       0.08(0.02+0.03)
9210.7: test_commit --append --no-tag A (non-scalar)   0.13(0.03+0.11)

Signed-off-by: Victoria Dye <vdye@github.com>
---
 t/perf/p9210-scalar.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100755 t/perf/p9210-scalar.sh

diff --git a/t/perf/p9210-scalar.sh b/t/perf/p9210-scalar.sh
new file mode 100755
index 00000000000..a68eb6b223d
--- /dev/null
+++ b/t/perf/p9210-scalar.sh
@@ -0,0 +1,43 @@
+#!/bin/sh
+
+test_description='test scalar performance'
+. ./perf-lib.sh
+
+test_perf_large_repo "$TRASH_DIRECTORY/to-clone"
+
+test_expect_success 'enable server-side partial clone' '
+	git -C to-clone config uploadpack.allowFilter true &&
+	git -C to-clone config uploadpack.allowAnySHA1InWant true
+'
+
+test_perf 'scalar clone' '
+	rm -rf scalar-clone &&
+	scalar clone "file://$(pwd)/to-clone" scalar-clone
+'
+
+test_perf 'git clone' '
+	rm -rf git-clone &&
+	git clone "file://$(pwd)/to-clone" git-clone
+'
+
+test_compare_perf () {
+	command="$@"
+	test_perf "$command (scalar)" "
+		(
+			cd scalar-clone/src &&
+			$command
+		)
+	"
+
+	test_perf "$command (non-scalar)" "
+		(
+			cd git-clone &&
+			$command
+		)
+	"
+}
+
+test_compare_perf git status
+test_compare_perf test_commit --append --no-tag A
+
+test_done
-- 
gitgitgadget

