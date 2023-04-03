Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7898C76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 22:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjDCWdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 18:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233096AbjDCWds (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 18:33:48 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7F040F1
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 15:33:47 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id e18so30875986wra.9
        for <git@vger.kernel.org>; Mon, 03 Apr 2023 15:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680561225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=WU6rdMECMRatIjGqL8HWoO852odhauHUCgCcfNEVl3cYOT/cMC5E0C2A0kqSeZjPRE
         nnLz74HQrOOA7Qg/L6UIC5ATshv48CXY+nHr/r+a2/9BkSSD2cPs/o1sU7kMQ/CQEMvS
         ge3kuvl52WEEUPAYUQeKZqNaOW/jUkXesCvTpmYTXHlbum1szSGNKDpgXHbCy64Wr9XR
         lWmiVWXz5t1v2P0xOAXfzLvng/QHJzhcHfJVjUreij20H+/EpTx8agN9wpcb9ns6IYn+
         RL4zN+l0Qt6IOWs+JzVRUN/6nyY9j6xJtkr30hD9Vb089kld2Hk7vqKDUgaHcDqN5bPc
         29fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680561225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wPA6VephNu4ae9tYi/0aHGAe7CNAeibjD4ifce3lHUg=;
        b=eVKYkQCl7rx5GK9pOB6YHjQir9vL9/5MDFkZIheiOL2FaWqe78oXmCZmLHnG8t38xO
         dIigSLVyx/r5cNQh9U83byLtj9jWlbmdkKBljq5utYX9mMJbLrILsBZbQD4OIAUsBOgG
         ZaC349/gQ8Pczugj9Ok8p6aX2j5+MZbkS+9pkBGWK6AxCD0bXWE955lGViNRwWLapXXE
         +c4uRa1GcK/fSQNNlx33MPcy6g70W3hntkCrtnJcaeOuG/rjAgFCeqU3A5h75jOSxRyj
         hFXtC9LK28ovwG2LpZpc7eBbsmNti7n4yGUKoKanzUkpstY7UgZgOpeYkj6ajZ+WlkUM
         FXhA==
X-Gm-Message-State: AAQBX9clQdkWbtEIxGEonGgyWz4V//nGi+qrSJKwmlWCsVnw0qWdWPUt
        /n2b4/1X19erJ3Xe91+VFCJMzx3tP8mSz6jaDFY=
X-Google-Smtp-Source: AKy350bS0cDNS1iPVHDdezW1p4M/KgJVCHAXXpEUh72REyhIfhJfIUjSM0g5SZx2omp7LXLFKbE57g==
X-Received: by 2002:a5d:42c7:0:b0:2e9:bbad:7e7 with SMTP id t7-20020a5d42c7000000b002e9bbad07e7mr64109wrr.38.1680561225017;
        Mon, 03 Apr 2023 15:33:45 -0700 (PDT)
Received: from titov.fritz.box ([212.102.57.24])
        by smtp.gmail.com with ESMTPSA id m17-20020adfe0d1000000b002d1e49cff35sm10697453wri.40.2023.04.03.15.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Apr 2023 15:33:44 -0700 (PDT)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=98ystein=20Walle?= <oystwa@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 6/6] t2019: don't create unused files
Date:   Tue,  4 Apr 2023 00:33:38 +0200
Message-Id: <20230403223338.468025-7-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230403223338.468025-1-rybak.a.v@gmail.com>
References: <20230401212858.266508-1-rybak.a.v@gmail.com>
 <20230403223338.468025-1-rybak.a.v@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tests in t2019-checkout-ambiguous-ref.sh redirect two invocations of
"git checkout" to files "stdout" and "stderr".  Several assertions are
made using file "stderr".  File "stdout", however, is unused.

Don't redirect standard output of "git checkout" to file "stdout" in
t2019-checkout-ambiguous-ref.sh to avoid creating unnecessary files.

Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
---
 t/t2019-checkout-ambiguous-ref.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t2019-checkout-ambiguous-ref.sh b/t/t2019-checkout-ambiguous-ref.sh
index 2c8c926b4d..9540588664 100755
--- a/t/t2019-checkout-ambiguous-ref.sh
+++ b/t/t2019-checkout-ambiguous-ref.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup ambiguous refs' '
 '
 
 test_expect_success 'checkout ambiguous ref succeeds' '
-	git checkout ambiguity >stdout 2>stderr
+	git checkout ambiguity 2>stderr
 '
 
 test_expect_success 'checkout produces ambiguity warning' '
@@ -37,7 +37,7 @@ test_expect_success 'checkout reports switch to branch' '
 '
 
 test_expect_success 'checkout vague ref succeeds' '
-	git checkout vagueness >stdout 2>stderr &&
+	git checkout vagueness 2>stderr &&
 	test_set_prereq VAGUENESS_SUCCESS
 '
 
-- 
2.40.0

