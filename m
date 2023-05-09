Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4134C77B7F
	for <git@archiver.kernel.org>; Tue,  9 May 2023 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjEIACv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 20:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjEIACt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 20:02:49 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236297ED2
        for <git@vger.kernel.org>; Mon,  8 May 2023 17:02:49 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id 46e09a7af769-6ab0a942f46so845299a34.2
        for <git@vger.kernel.org>; Mon, 08 May 2023 17:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683590568; x=1686182568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=U/IpRTO+JQ6sAQOa3wqqN5XQX5O0Drb3ecXMUQnkVjo=;
        b=Zas63j61qzzWX4PC85u5uCrn3bFAxiB6Igvb0enViLd6UAjALWC14Ew5kIplEi8m5R
         PCBoUbff4r+sLu5Rloof3jaaZnVVNbdNzPeNMP+i+eiyFqi8GVSzW8vk1IlQwzFbyRrw
         sA0uKqZjqFh4NTFc2hKIl8WTdxqHqsCBVTmyHVDvTm1PT2eFG7JPuu/HmUhPhniBIZDs
         TnoRcjpoLSRaib1VpW5/cDRpQrLSb37Lqw6N0C5s5TfIpfuK1F+ERJRKz/lS/Y58SVtC
         eHAb5o+47WqT3CgGswxuUeBkJi79Q8PU6Vi7Kjgi52GXM++vDCTRqhtlsEhILCJ/R6JU
         ZCgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683590568; x=1686182568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=U/IpRTO+JQ6sAQOa3wqqN5XQX5O0Drb3ecXMUQnkVjo=;
        b=HeowclQb89Ve7i3wtWMmCExfpiEzFY1mqRaiuqFyvXwgqoXENFT49CBPx9tAdX3tmm
         1EQlpX1PkcotTLO7Bw/uMYXfAp2ZBoJC8iatC/4dgYoVdReWVCp+nuZwEj4LwoT66sFn
         rLCa/W3SEQsO0mbsfD0G492yyd7Sao2+qepN7tAsIX6m7XwMXCSowQJ5GckN793JoeXk
         3y623SFFMAB3szvzM/njQGSauRL3bUuJ6Xgpc8mmhXb4bCqDf49rvh1hhOBkWq7G4mhE
         rvnogDkRKIyBcZABVku8wgngEf307rEtaZAV9yPC+H473snLN9NZWlXm7D+ly9VLQ/+8
         Ta8g==
X-Gm-Message-State: AC+VfDzKTe28/hRrqIete/peC8BmJ/WVZgk7wmeLFYs83cdWvnJfPZx/
        bn0ABfcKnP/pcd+CD2BYVBGPsR5cb2k=
X-Google-Smtp-Source: ACHHUZ5ynhgHx7IapIlGbwrkwRuNL06fMME+X2l7apTL3DC9AMZmcZunOv6Azbs4eHulujc4C/ER8A==
X-Received: by 2002:a05:6830:100d:b0:6a5:ff20:82c with SMTP id a13-20020a056830100d00b006a5ff20082cmr359992otp.32.1683590568104;
        Mon, 08 May 2023 17:02:48 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id g25-20020a9d6c59000000b006a652d3ad74sm897845otq.69.2023.05.08.17.02.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 17:02:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] test: rev-parse-upstream: add missing cmp
Date:   Mon,  8 May 2023 18:02:46 -0600
Message-Id: <20230509000246.1760327-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It seems pretty clear 5236fce6b4 (t1507: stop losing return codes of git
commands, 2019-12-20) missed a test_cmp.

Cc: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t1507-rev-parse-upstream.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1507-rev-parse-upstream.sh b/t/t1507-rev-parse-upstream.sh
index d94c72c672..cb9ef7e329 100755
--- a/t/t1507-rev-parse-upstream.sh
+++ b/t/t1507-rev-parse-upstream.sh
@@ -97,7 +97,8 @@ test_expect_success 'my-side@{u} resolves to correct commit' '
 	commit_subject my-side >actual &&
 	test_cmp expect actual &&
 	echo 5 >expect &&
-	commit_subject my-side@{u} >actual
+	commit_subject my-side@{u} >actual &&
+	test_cmp expect actual
 '
 
 test_expect_success 'not-tracking@{u} fails' '
-- 
2.40.0+fc1

