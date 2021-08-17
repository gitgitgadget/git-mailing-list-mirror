Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F06B7C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C4514604AC
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 08:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239033AbhHQIQc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 04:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbhHQIQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 04:16:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80331C0613C1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:54 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id q6so15796941wrv.6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OwUdyqj0SBTZGYDzNsX83JlUezJs5b9nQag/bX/AVAo=;
        b=MD6EYGCnRhAtkZTuHq3sRzobocIg9sSEtyh3+Fco2RyoOehlo9W0ct/W1P+9wmEx38
         CpAhl/25rjr05Gy7lOVCxKMd7t7yMSs9GDy5Hg7h5/km9BMMl+0JMjACHQIOlnyEX9O0
         6A2s5oPil9F8oCkUzZ9sZepfuRVOgoVuYQRNOPv+a148VCOnq1cktEQrfZzIqsJNf1HQ
         rPg/EjQEqNYqIRhhk76Ap+jUpNrVTHAuMF3i8gE6Ckg9jhhEKCY48iXbwmnhsX6UdSTT
         ipVO1/B5ANfS0VkMK4Nx5ufwt+jrM3aPxEOKhuNUGisVBtyZ6Fb7qVQP+rZao5i5w0q3
         gsaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OwUdyqj0SBTZGYDzNsX83JlUezJs5b9nQag/bX/AVAo=;
        b=RgGHih4Qvbp+bTdaRRfJ1VQO24ThmSM9Bc7XSBtyhHJbxmzw1cLi7USdsO6K35+VZT
         WzHZuW2xKNaI3GAcbcLofPcAOptEB4dFxBL2gLCP+9TJvEwpqHrH2LZH0X06ty4WQFRy
         HgRBBH710JFEGJC/fe+IlO1/MlL2fVo7zSaONUKfGMJQjlh8stg1w4weYTssGHjeJDIe
         7jbAa2slBIwomYMAAMuEfKgksbdYbSm/O9TUAG8bElSwko+6aJRxDxg0MS5QHPMxeOCr
         7pqmtajAeT1qrE/tOtfGZWwVfLsCAsEE8DikbeiG3E8m8bLRVYj+qGHV/kGbEE7n21yA
         Te+A==
X-Gm-Message-State: AOAM532ypfJtnqazIRBHOUL/ZcF2iEUl9L1T9O5rUyiYaRCQYH3KnyKm
        q28S80bjTvbbr7beB0UQsY2h/WkdDD8=
X-Google-Smtp-Source: ABdhPJzLlS819t2EeRYu1NRIVGJAHfUdLUUgPoMTVRdRwvdWOSWoVQpw9qrGBHc6oJ+rkAa9rNrMDg==
X-Received: by 2002:adf:a29c:: with SMTP id s28mr2394835wra.318.1629188153143;
        Tue, 17 Aug 2021 01:15:53 -0700 (PDT)
Received: from localhost.localdomain ([178.237.233.111])
        by smtp.gmail.com with ESMTPSA id l21sm1256238wmh.31.2021.08.17.01.15.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 01:15:52 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v4 1/6] t6030-bisect-porcelain: add tests to control bisect run exit cases
Date:   Tue, 17 Aug 2021 10:14:53 +0200
Message-Id: <20210817081458.53136-2-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210817081458.53136-1-mirucam@gmail.com>
References: <20210817081458.53136-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a gap on bisect run test coverage related with error exits.
Add two tests to control these error cases.

Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index a1baf4e451..f41453cc97 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -962,4 +962,18 @@ test_expect_success 'bisect handles annotated tags' '
 	grep "$bad is the first bad commit" output
 '
 
+test_expect_success 'bisect run fails with exit code equals or greater than 128' '
+	write_script test_script.sh <<-\EOF &&
+	exit 128 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
+'
+
+test_expect_success 'bisect run fails with exit code smaller than 0' '
+	write_script test_script.sh <<-\EOF &&
+	exit -1 >/dev/null
+	EOF
+	test_must_fail git bisect run ./test_script.sh > my_bisect_log.txt
+'
+
 test_done
-- 
2.29.2

