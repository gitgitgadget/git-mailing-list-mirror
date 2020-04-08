Return-Path: <SRS0=ek70=5Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89DB7C2BA16
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BB6420730
	for <git@archiver.kernel.org>; Wed,  8 Apr 2020 04:06:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KxzwVIqG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726436AbgDHEGE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Apr 2020 00:06:04 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:33458 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725440AbgDHEGE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Apr 2020 00:06:04 -0400
Received: by mail-pg1-f194.google.com with SMTP id d17so2761080pgo.0
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 21:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GT0TpvTmy2q5lZKq0oThu8BDwzlulVSHnkrfqEkAQfU=;
        b=KxzwVIqGl09cN+7YLMC17q93w8MeTgyYajVBbsJt1vNCGdotMGlzT5k/mD+zIA1qQx
         aT/l+FSZZh8mbLZhKxQtWhCq9aHiFP4U/9NppsMj9VHmMC/cUzL+p47dc63IurFx3rqi
         NcZ71SHgY8k43IETS1L17ZeRzE7xfFBbLdEhCfwbyb0TtZ7KYC5wnaxs4pgGfhQZtVn3
         gc3uqMCr9JiUT7PZQqrho3ZBzKg6b8Vfg8y6VKf6bsxAw4himbG4ICfrVJ3o8T9j8YHj
         u+gR3s4b+OIoUiwXoPtPln9dCCyQTQl1eSc3/BXZXL2i+zG8SwTu9DD68HVag34xjnM+
         jkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GT0TpvTmy2q5lZKq0oThu8BDwzlulVSHnkrfqEkAQfU=;
        b=mB5MI6q00rClnFkmuLeBWrKHmeiod0LswOdsTLJIEqW+QQkTuBNtVvf90tg/njqWxM
         kGb8N9+TjGFYEvn2l7lVMtIM9kZCI7kovZlca1QAPBHn3XbvMDsfCtu/AjmC8HuzLCq1
         wrv0wluqTWLGF1085H6zMLwTWJ/3IEVM0oWx8L4RD7yhQ40PUHZAVdanwe3hWxqa/vX3
         IHjQ/9Ef+tgKFSOLh5aWnGe/7CJpclR10VgfXf+A8SILLFXtpb/A9jUN22w+4peAiM/4
         QLXc7qE1ka3944JAQRxTpy1UWZhbzC6ibK9KxCxCsRWbsIbYBN8xMgJ0jWw1eCmLhZS9
         udpQ==
X-Gm-Message-State: AGi0PubRb6nkbIY9PI+G1z5uNBlcRP0gNeKHRqo+ZQGRO70Os1pNJFNl
        RjVpfmFReqWaIBoFWNVssRcQlaesvYE=
X-Google-Smtp-Source: APiQypJT9i1U8MI4dCUl5OxJrTjT3m6r96t/F+vDfawYwxa0po/HM7FkKt0QBUXO99Z9ZAMI6JFWzA==
X-Received: by 2002:a65:5641:: with SMTP id m1mr4985979pgs.2.1586318763210;
        Tue, 07 Apr 2020 21:06:03 -0700 (PDT)
Received: from localhost.localdomain ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id s9sm2879725pjr.5.2020.04.07.21.06.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Apr 2020 21:06:02 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH v4 03/12] ci/lib: set TERM environment variable if not exist
Date:   Wed,  8 Apr 2020 11:05:34 +0700
Message-Id: <b88586c2c5e4781c6a7fdfa0e2669bf37773afd2.1586309211.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.26.0.334.g6536db25bb
In-Reply-To: <cover.1586309211.git.congdanhqx@gmail.com>
References: <pull.743.git.git.1585658913.gitgitgadget@gmail.com> <cover.1586309211.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GitHub Action doesn't set TERM environment variable, which is required
by "tput".

Fallback to dumb if it's not set.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 ci/lib.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index a21c6241b0..5c20975c83 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -79,6 +79,9 @@ check_unignored_build_artifacts ()
 	}
 }
 
+# GitHub Action doesn't set TERM, which is required by tput
+export TERM=${TERM:-dumb}
+
 # Clear MAKEFLAGS that may come from the outside world.
 export MAKEFLAGS=
 
-- 
2.26.0.334.g6536db25bb

