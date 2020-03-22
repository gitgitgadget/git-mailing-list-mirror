Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2235C43333
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 704AA20754
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 00:56:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xuv2MW1E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgCVA4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Mar 2020 20:56:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33792 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728176AbgCVA4Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Mar 2020 20:56:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id t3so5190742pgn.1
        for <git@vger.kernel.org>; Sat, 21 Mar 2020 17:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F1cNCK1sYGppF5Q1iJklLU1vJDXWEFfI7G6CFrGZHY8=;
        b=Xuv2MW1ELOrth0gMoHh26gFJlD0IjlU+tAN2y/mth8G1Kd97Noyia7J4FLyIYd/llC
         nkMJtABok4tXBk1c9iWh7kvgNZqb07hahCsdHkiFOpDWBY9ofItFhxQi9YUIuuoYLlji
         pVtHLT67Z1A2Y9Vs5Gqgy/u+Eli74Oc99RjLoVA39G1SHMecjl7Kx40X5XXjiNl/Jr7M
         YxulQ33jKgsI1Y1wANdBik5vmZ5Vq7LnjaDEktuDHHVcBqwUf5wqAIp+lEcdsQXa7O6i
         s5E4T3lHmeYF9k16TcM0eX7u1VSezHnXC3ZlbcryfuKbMPRRK3s4i5mpVg7Mjcsk2OWV
         X8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F1cNCK1sYGppF5Q1iJklLU1vJDXWEFfI7G6CFrGZHY8=;
        b=hMzHjCvpl0MMimIbeUAAz48ROsCdfWehNtieYO9pLeWLWyfBamD5CtLewA0Afx/Bzv
         BrjHXArPtfaTt+M5XcW5Bpk9nuZpHljgaPbH5CwnSlHoUVIlczp6BP9HecxCErl0R3CV
         3R0RetFTCIIgorib8J5fWoZ99IM1T5h48FNn43eUVBVJDX95OVcJAwHp8k4Au9X/Fhff
         bAzFXJdPsYm52WeryX0yCs0PdZCEwrrmzVACu4vmRb5dImFDtWqvMK2kI3h5LQhlE19H
         QUCZrTel00QtrCUZ3aJqme+4Wm+IyOB1Dozhje+NrckqLKthWxTFHghVcdrnjI9ERpsP
         7NhQ==
X-Gm-Message-State: ANhLgQ38lKYH9auNHFzHaJH0A50kaioTbXUCC4kn61fvw5TPnmSELu2a
        hkX8iXozwrSQUI5O+ej1BVOstK+d
X-Google-Smtp-Source: ADFU+vtxxyy4f9CMBtLP4UxFLTkGb0oCIcieRuSryzKquUEe5DerdaQ95Cphw9nAQdNdBb9LiEFebA==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr17911221pfl.252.1584838574787;
        Sat, 21 Mar 2020 17:56:14 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:576b:56ff:d97c:a505:3e0c])
        by smtp.gmail.com with ESMTPSA id r7sm9235641pfg.38.2020.03.21.17.56.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Mar 2020 17:56:14 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 6/6] t4124: fix test for non-compliance diff
Date:   Sun, 22 Mar 2020 07:55:19 +0700
Message-Id: <cd86febed9b2791436d5e61da58cd318dcf4a7f9.1584838133.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d
In-Reply-To: <cover.1584838133.git.congdanhqx@gmail.com>
References: <cover.1584838133.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

POSIX's diff(1) requires output in normal diff format.
However, busybox's diff's output is written in unified format.

POSIX requires no option for normal-diff format.

A hint in test-lib-functions::test_cmp said `diff -u` isn't available
everywhere.

Workaround this problem by assuming `diff(1)` output is unified
if we couldn't make anything from normal-diff format.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t4124-apply-ws-rule.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t4124-apply-ws-rule.sh b/t/t4124-apply-ws-rule.sh
index 971a5a7512..2a54ce96b5 100755
--- a/t/t4124-apply-ws-rule.sh
+++ b/t/t4124-apply-ws-rule.sh
@@ -52,6 +52,12 @@ test_fix () {
 
 	# find touched lines
 	$DIFF file target | sed -n -e "s/^> //p" >fixed
+	if ! test -s fixed; then
+		$DIFF file target |
+		grep '^+' |
+		grep -v '^+++' |
+		sed -e "s/+//" >fixed
+	fi
 
 	# the changed lines are all expected to change
 	fixed_cnt=$(wc -l <fixed)
-- 
2.26.0.rc2.310.g2932bb562d

