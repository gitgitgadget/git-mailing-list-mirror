Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5D01C54FCB
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42972068F
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 23:55:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GWtw0E1M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgDTXzF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 19:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726498AbgDTXzE (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 19:55:04 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3864BC061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:04 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id ay1so4574138plb.0
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 16:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bkCvmE7nCoAZ/1AnoRi1wMCy+PT/p2KN0W7on/ka+eI=;
        b=GWtw0E1M8ulXb1CVIBg7XZCf9/s+SaNT5+VbPPSVoqBDXbw7kR+w/IoVwL/t9l9TP8
         8wbXARAIH8/3rYpF0jWn5QzpFS2RiD282IGSdQHb+JFzfnT4mRusYIu1RlkRuNRQXHRt
         PPZngUjZWlpPnFk9vxH2lyVKJw8tBA2Rc+MdhQaRAWbgt1vEynhEpyjgfNsiqSA3aB3P
         PFXnKb9UDth5Ovo8VHT+MpOijLBPDeyoJvH6qWRtZvSu+4nKty0oMUDNeWrsEivTntjK
         MnzSjO2e2CudHPa8Ngh9P01qoCpFZXTrlIIPoao27FlAYI79LSDXlokH7rHCIWgwsJdO
         VaWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bkCvmE7nCoAZ/1AnoRi1wMCy+PT/p2KN0W7on/ka+eI=;
        b=bJNltuZu/fhT/RF/nbeg7L3Axkm8HL95JwgbQkYDcaszQuFLUZNCQ8NRtqTNobhxcP
         gRHNQnlRyne6tHVd+Y6ixGre3FM2miDlmbkJJMeob/rxQxUH02O5bRg1o0coactGWtBG
         skK5BDj9GsQETYc6UT2+nlSDBPdGP/2O0ikCSWd3xIpm7CrWhXi8DvJhO0oESNx7d3dT
         94KvMMgI//jRsp3euzqwSNema+LUhkexZj2sQwZSwT7r9VTB0nPnDsIsKjO20v7YaLWA
         OOLE4XQjCr824HrFSI+uUSBtz9tzoaxfG5JKfcynaDzd/yKO2Yk/7j8EhYbN/S0RlWl7
         T2TA==
X-Gm-Message-State: AGi0PuYGH52MOEClJAnAImsqSTU+X58mL1RSShFy10imHqYISKzyWT1M
        hc3OdY5M+73FHAKiRhVYswmRHiNy
X-Google-Smtp-Source: APiQypJw/xLgCeBZkzdI9gNm0cY2WeqqBMyjEuuXSo6zQlnQN97KD/WtXQzvFAns6ggKKN7dpIchow==
X-Received: by 2002:a17:90a:1955:: with SMTP id 21mr2181596pjh.25.1587426903541;
        Mon, 20 Apr 2020 16:55:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6374:f359:effc:5180:3a91:1887])
        by smtp.gmail.com with ESMTPSA id g14sm609248pfh.49.2020.04.20.16.55.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 20 Apr 2020 16:55:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v3 3/3] mailinfo: disallow NUL character in mail's header
Date:   Tue, 21 Apr 2020 06:54:36 +0700
Message-Id: <b2e760227e4c80af67ce3c1c405207dc7a1f7bf4.1587426713.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb
In-Reply-To: <cover.1587426713.git.congdanhqx@gmail.com>
References: <20200418035449.9450-1-congdanhqx@gmail.com> <cover.1587426713.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 mailinfo.c            | 5 +++++
 t/t4254-am-corrupt.sh | 7 +++++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 0e9911df6d..5681d9130d 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -1138,6 +1138,11 @@ static void handle_info(struct mailinfo *mi)
 		else
 			continue;
 
+		if (memchr(hdr->buf, '\0', hdr->len)) {
+			error("a NUL byte in '%s' is not allowed.", header[i]);
+			mi->input_error = -1;
+		}
+
 		if (!strcmp(header[i], "Subject")) {
 			if (!mi->keep_subject) {
 				cleanup_subject(mi, hdr);
diff --git a/t/t4254-am-corrupt.sh b/t/t4254-am-corrupt.sh
index 1bbc37bc92..daf01c309d 100755
--- a/t/t4254-am-corrupt.sh
+++ b/t/t4254-am-corrupt.sh
@@ -70,10 +70,13 @@ test_expect_success "NUL in commit message's body" '
 	grep "a NUL byte in commit log message not allowed" err
 '
 
-test_expect_failure "NUL in commit message's header" "
+test_expect_success "NUL in commit message's header" "
 	test_when_finished 'git am --abort' &&
 	make_mbox_with_nul subject >subject.patch &&
-	test_must_fail git am subject.patch
+	test_must_fail git mailinfo msg patch <subject.patch 2>err &&
+	grep \"a NUL byte in 'Subject' is not allowed\" err &&
+	test_must_fail git am subject.patch 2>err &&
+	grep \"a NUL byte in 'Subject' is not allowed\" err
 "
 
 test_done
-- 
2.26.1.301.g55bc3eb7cb

