Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DB48C43214
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0012161051
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 09:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244944AbhIBJGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 05:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244796AbhIBJGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 05:06:17 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED97C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 02:05:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q14so1724085wrp.3
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDf4NR7irMIBPs6yfFlCt71FkrZC3JHtpdJMSAhYZAI=;
        b=Ah0FysJhNx8G2MmtI9K89ezT/eCm9oBERMkiwbXMOjQf4ZesTJNSfmeHF6DdQt16a7
         7BcPvew3iu7MfQYiOGrgf16CgYHXnP3VIIJ5UL02Bh4+qigPPahkSjnvcAPqGwE3yN1Q
         UkjhOFAzKUtx+I2CJmYXJVuF+73rvcBrEwJmRWXiQIGb+rWgAcTHSbf5631rEuvGAgjJ
         xKdAGaxplbbDZLmEidYRhS3ebITmPEqiMIcwqfWPmYCKBA+INPsx3Ti5ehVTav6JRz/Y
         I66kWoump+Z7k9g6ADUzo0R3Ts0LM4XyfaSDTUalvZvK7fjrpxXMo7TbhFQDjsrcuVjN
         NNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDf4NR7irMIBPs6yfFlCt71FkrZC3JHtpdJMSAhYZAI=;
        b=Zzl2tdlF58uISnUKvAnUEMYRK+N0CdcXaruFivCaT8jPScQs8InRBBR/Rl+yQycfz7
         KTSf9Ts4t6rN1ys/j2CGt7qkWa8UHq0G0b2iO9b+rIdH8gZMsfF4jBCwvq9uYIi3DtqH
         lQZgJdbSWUakMxBN5N/XLGjPt1vwYiB/yCWleTSmhpApf2f8HDcDlmxiYcaC/krbEpBQ
         M5zySSVypQ7+9EiffacI0f/spTyZHHf0GgUdL9doRxvuxjT8Op99/lqQTZGFkODh9B+C
         XyLBWXE3cjzRpu9aC8Zyx6PvswZC74QTeU3GulImIib+oddamNBRUtJf378dVclzcna2
         RpoA==
X-Gm-Message-State: AOAM53252fxXZtDogkRdW07Q+NEiHZPb+88CoFWr6G7ZEAsUNWxU4lOZ
        rlZewD9/XXFUGhwQKlW5m5MBZVp5PAc=
X-Google-Smtp-Source: ABdhPJykafvrBftjXIMsRaTlu44h+JcaCjupWY8Xe4Q9X/35mO/RI1Mw9pyQALrLkq6orfJEuTlPGw==
X-Received: by 2002:adf:eacb:: with SMTP id o11mr2442949wrn.418.1630573517927;
        Thu, 02 Sep 2021 02:05:17 -0700 (PDT)
Received: from localhost.localdomain ([178.237.237.111])
        by smtp.gmail.com with ESMTPSA id l17sm1262516wrz.35.2021.09.02.02.05.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Sep 2021 02:05:17 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v6 1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
Date:   Thu,  2 Sep 2021 11:04:16 +0200
Message-Id: <20210902090421.93113-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210902090421.93113-1-mirucam@gmail.com>
References: <20210902090421.93113-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a gap on bisect run test coverage related with error exits.
Add two tests to control these error cases.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1baf4e451..e61b8143fd 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -962,4 +962,15 @@ test_expect_success 'bisect handles annotated tags' '
 	grep "$bad is the first bad commit" output
 '
 
+test_expect_success 'bisect run fails with exit code equals or greater than 128' '
+	write_script test_script.sh <<-\EOF &&
+	exit 128 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt &&
+	write_script test_script.sh <<-\EOF &&
+	exit 255 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh >> my_bisect_log.txt
+'
+
 test_done
-- 
2.29.2

