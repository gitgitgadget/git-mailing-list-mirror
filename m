Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE51C43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 334272077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 10:15:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7NNZkh9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387732AbgDBKPw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 06:15:52 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37134 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728135AbgDBKPv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 06:15:51 -0400
Received: by mail-pf1-f194.google.com with SMTP id u65so1552957pfb.4
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 03:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3l9Xxz2IQ5mS1q6rjz8+9ZZkeK3J3nQoc6654TkzMk=;
        b=X7NNZkh9RI4GTgaZsr2kaPxXGU7jVOq81wPcnYlAcv7nESR7TV4Gnsawg15F/7HVKn
         qqRkUXTpyKWeN0ujPSj+IhIlv6L8zY9UWFnCdJE6pjaNl4BVxlJCRzsJMoBKSXZpCJUk
         Kz3iwaJcRenh+sTePV+GhytuWrIbKjC1KADCut/SRtPce4z5eHc9ihaTAdlF6MRq7KnS
         mekK3a0nUCu3R6r1J/QpB+7MjPdD90cj96dRHWpFTuhiwUufeV+XCFm7deiZi1aj2mDK
         TEP0pHy3tw808Th7mIf75pO46ZuopLhsS1xw7jPpvvUO0KfuUYcZPqhsiPaiBmtIB7XH
         2wYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3l9Xxz2IQ5mS1q6rjz8+9ZZkeK3J3nQoc6654TkzMk=;
        b=o2gBHufLYeHWkytn0oAbGWN0kHjDozFYuYc0FWxBiIpAKyS4j41PvBjrTfaUCbHcm3
         zq5V947WG4KQaiEfQM4OAZGtialAKmDZ8uRLpUEpmP+skmBpTnDuNcStRfuk75dAKYgx
         Gqb6NGLInmvcQxK+pr9R3ymFzKIPB69VnG2ZC3oZDDWRkTlO89NvFMsEHzJJ5HpESxhs
         RjbgQ1E3ZUU0sjake6XasCp7xnZRdvdBDJcCrAopvhKiAOE2iRBg823oyknzTjXnjvxd
         ItXs2Ee8Y0GR5q0S9glv2yszSSrf1wSR3j3YALKlgN+6xEdW2DW4CRor6hDTXrekFOa8
         x/qg==
X-Gm-Message-State: AGi0PuZn2gpjTD2vgp+zmRZOaDfh6WwIShIsV5lJbtoxe/sjPlgGxQg0
        VgRyyHOyADkq3RcSmHuHpJrB8v/e
X-Google-Smtp-Source: APiQypL2f+TCdldIiNplK1v8qn0Unsx8rXlM21hKixQR8Kwl80Ecr22D9+eajfFZczVuhVKbFWrtlg==
X-Received: by 2002:a63:4f64:: with SMTP id p36mr2653713pgl.330.1585822550664;
        Thu, 02 Apr 2020 03:15:50 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id nu13sm3599948pjb.22.2020.04.02.03.15.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Apr 2020 03:15:50 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v2 3/5] Documentation: document am --no-gpg-sign
Date:   Thu,  2 Apr 2020 17:15:32 +0700
Message-Id: <09af4cda24185bdc536dc04183bacf5d43dd5d05.1585821581.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1585821581.git.congdanhqx@gmail.com>
References: <20200331064456.GA15850@danh.dev> <cover.1585821581.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 Documentation/git-am.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index ab5754e05d..05a2c1b887 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -150,7 +150,9 @@ default.   You can use `--no-utf8` to override this.
 --gpg-sign[=<keyid>]::
 	GPG-sign commits. The `keyid` argument is optional and
 	defaults to the committer identity; if specified, it must be
-	stuck to the option without a space.
+	stuck to the option without a space. "--no-gpg-sign" is useful to
+	countermand both `commit.gpgSign` configuration variable, and
+	earlier "--gpg-sign".
 
 --continue::
 -r::
-- 
2.26.0.334.g6536db25bb

