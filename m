Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE73C54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9313120714
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:55:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MLe2sISw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727320AbgCYFzY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:55:24 -0400
Received: from mail-qv1-f66.google.com ([209.85.219.66]:33217 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727279AbgCYFzV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:55:21 -0400
Received: by mail-qv1-f66.google.com with SMTP id p19so506307qve.0
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=tEtbvB1EO46KaKpHKaeuDGO3cynmYi7A8aQBCxE63jU=;
        b=MLe2sISw+jUPw/ew0uTWZaDYgyv73sqKW/Nfr7NvIns4cBqoxWLAJ8IBihaAsbHtrP
         yL6boOL7e/c/XaCXtGC3Di3SVENVok1yx72rWaM81RFtn5UBUrtzGkpav/TwRlwCJaE8
         V6GSdTqj+D1+VT7O+LRcWdjM1FygPrNFPdWEF2UarASLyTjghh8+d+kshic9fH+DoG9y
         zmPSZF18bwQduRPy6dY4B2inYjMDrzKUSSgDY+dXK5P0/pgQ9yvLAPCZWn4KLwsMs3p1
         Wy2T00818u1FiLxmeEbo+JTSdZDfcnJgi1KSMMtHOCeXC2WRkmKjilp3Ge8NoDnxjCqm
         Rcaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tEtbvB1EO46KaKpHKaeuDGO3cynmYi7A8aQBCxE63jU=;
        b=uHxD5ckgOfi1ZkdIZyhWzqwfVkvvrhKhPtF3hxLxrkPrQ9kyOntijIrAw0InEQIIjo
         GaGpKnkPSm/1pf1+O4Di0nGuvz6mJNHuBU5DV3mlmYQ09JpZ3Hsx0q0jrecnM1WNnSVc
         JfkdMQgM7M2+insT42Vm0ULOiCY8GHkJ853wUHZ8CUJ2gLe6FGFSb+sebehNaUsUPLMo
         dyJ+OIH7lkDRDr/TlGnVAXKRWlmg5DsqnLxhrk9pHwF9uaiRgoJ4eMl/oMTXsOgE02gc
         +TXx7Ye0lYbBmmn617dx85ij5tpvRWrbQplyMohm/AmnMZsMj65mY6soWYuPHdqkyZwt
         2rSQ==
X-Gm-Message-State: ANhLgQ0lQ+d8SmeI6RiYdNXChl/k60DL0yI6jJChgBl20LMu/HMEQ+VQ
        5qVEcWVtmiwURBsQOeHokufU5f2g
X-Google-Smtp-Source: ADFU+vtgoSO8GS2iVtm1aiZiAGh9AMil2Q9zQz77ZAirlaK4ISB/gdLUzUiWKDEmABfBNMvpl2w/MQ==
X-Received: by 2002:a05:6214:56c:: with SMTP id cj12mr1657718qvb.29.1585115720515;
        Tue, 24 Mar 2020 22:55:20 -0700 (PDT)
Received: from archbookpro.lan ([199.249.110.29])
        by smtp.gmail.com with ESMTPSA id k15sm17168712qta.74.2020.03.24.22.55.19
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:55:19 -0700 (PDT)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 8/8] t5801: teach compare_refs() to accept !
Date:   Wed, 25 Mar 2020 01:54:55 -0400
Message-Id: <b51f97f6ae37e4b69b9651cbd60a480e5db3e72d.1585115341.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.25.0.114.g5b0ca878e0
In-Reply-To: <cover.1585115341.git.liu.denton@gmail.com>
References: <cover.1585115341.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before, testing if two refs weren't equal with compare_refs() was done
with `test_must_fail compare_refs`. This was wrong for two reasons.
First, test_must_fail should only be used on git commands. Second,
negating the error code is a little heavy-handed since in the case where
one of the git invocations within compare_refs() fails, we will report
success, even though it failed at an unexpected point.

Teach compare_refs() to accept `!` as the first argument which would
_only_ negate the test_cmp()'s return code.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5801-remote-helpers.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 121e5c6edb..0f04b6cddb 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -11,9 +11,15 @@ test_description='Test remote-helper import and export commands'
 PATH="$TEST_DIRECTORY/t5801:$PATH"
 
 compare_refs() {
+	fail= &&
+	if test "x$1" = 'x!'
+	then
+		fail='!' &&
+		shift
+	fi &&
 	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
 	git --git-dir="$3/.git" rev-parse --verify $4 >actual &&
-	test_cmp expect actual
+	eval $fail test_cmp expect actual
 }
 
 test_expect_success 'setup repository' '
@@ -189,7 +195,7 @@ test_expect_success GPG 'push signed tag' '
 	git push origin signed-tag
 	) &&
 	compare_refs local signed-tag^{} server signed-tag^{} &&
-	test_must_fail compare_refs local signed-tag server signed-tag
+	compare_refs ! local signed-tag server signed-tag
 '
 
 test_expect_success GPG 'push signed tag with signed-tags capability' '
-- 
2.25.0.114.g5b0ca878e0

