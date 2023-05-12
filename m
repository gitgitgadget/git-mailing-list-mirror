Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17A0BC7EE24
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbjELIDz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240171AbjELIDs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:03:48 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB03C106C5
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:46 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-190d4f2f943so7559463fac.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:03:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683878626; x=1686470626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNk0SOiEmVxan2pChk6RXCegBynqH0jK3A+WuF/KI/s=;
        b=emMSz7xgDz1KDoNba/IksUu4EFAAfrwHtS7dOcgc2P1LyeltJ71GA1KwHsIS2e9kPt
         3zVeDHsY6Q757yP24gjbSMQ1q+yCO17lOuFNq05rbnnx7WXoWzH6DSwWFdTXh6AnWPX7
         sQne/CXLCDegdLxNrOzS2c97XHkyc/mFrxT6YCb0p2GsN2zNvtflDfCc+x2EFcGgdlgx
         OhY0iISPvKN01Y9mn/0RHjD3/PHYcVVngkVkdlJl64moBn1+OD0X6SfaIEu2cVBnSQ0O
         gS2p/BOJb0IQbyp2Ij8DEy6QNwGp7212cOjhKJqsJz8sHXlz2eujOfNPq9lQJBZMpRhc
         DIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683878626; x=1686470626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNk0SOiEmVxan2pChk6RXCegBynqH0jK3A+WuF/KI/s=;
        b=GmJAJB9gd9puTALfYfufsNFFVyUtyZjp11SPVrOaHMvCoinlUclQNUFtWlkC3y1EiY
         5Rc8xyKWEMq2Rp9mGe6slkdRcolzGNT1FlZXdpdLe+eVtc9sODTcYiqaoJYLJFFcAR4I
         gLZaORBtMjEZ5WPgPkcAuaOq09Xb94/xyF01ylbb6+p06ZavjSop+PAeQ3NdsmILbAqb
         tZQI89hA8bYLwJvDxxTM98MUpdZXXo/ihz10LTcm0Rp9h7arFYSqaovMvPDj9AfHvOVD
         DNjwWiiwi42VFLIJ+tkmEZg/edBf3Tn8ChJacuTBKrZDV4pGt4FXGTsejUWerI8IQ7E4
         4Img==
X-Gm-Message-State: AC+VfDwyCRiPmlKsuDpC/yo9Mc7t1Vm5BE0zikVrtcbBV8wY2Og4sE3F
        g90Rb1wZF3T84zqzr4PLaYrjdoaWQIs=
X-Google-Smtp-Source: ACHHUZ5R0cv68rJskoy+pxikmtZPBa8in+DJt2op8oL1ZxxCu1i2zA0LkzG7mVvqFwe/+gS6dv8JVg==
X-Received: by 2002:a05:6870:b304:b0:18f:558a:1f34 with SMTP id a4-20020a056870b30400b0018f558a1f34mr10657087oao.40.1683878625744;
        Fri, 12 May 2023 01:03:45 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:e8a3:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o5-20020a05687072c500b00183f77dcdadsm8806514oak.33.2023.05.12.01.03.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:03:45 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 4/7] test: add various tests for diff formats with -s
Date:   Fri, 12 May 2023 02:03:36 -0600
Message-Id: <20230512080339.2186324-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230512080339.2186324-1-felipe.contreras@gmail.com>
References: <20230512080339.2186324-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There used to be a bug when -s was used with different formats, for
example `-s --raw`.

Originally-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t4000-diff-format.sh | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/t/t4000-diff-format.sh b/t/t4000-diff-format.sh
index bfcaae390f..7829cc810d 100755
--- a/t/t4000-diff-format.sh
+++ b/t/t4000-diff-format.sh
@@ -91,4 +91,23 @@ test_expect_success 'git diff-files --patch --no-patch does not show the patch'
 	test_must_be_empty err
 '
 
+
+echo 'reset' >path1
+
+for format in stat raw numstat shortstat summary dirstat cumulative \
+	dirstat-by-file patch-with-raw patch-with-stat compact-summary
+do
+	test_expect_success "-s before --$format' is a no-op" '
+		git diff-files -s "--$format" >actual &&
+		git diff-files "--$format" >expect &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "-s clears --$format" '
+		git diff-files --$format -s --patch >actual &&
+		git diff-files --patch >expect &&
+		test_cmp expect actual
+	'
+done
+
 test_done
-- 
2.40.0+fc1

