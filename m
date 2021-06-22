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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1D73C4743C
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B126B611C1
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230463AbhFVA3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:29:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230481AbhFVA3e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:29:34 -0400
Received: from mail-oo1-xc31.google.com (mail-oo1-xc31.google.com [IPv6:2607:f8b0:4864:20::c31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A4FCC061756
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:18 -0700 (PDT)
Received: by mail-oo1-xc31.google.com with SMTP id b24-20020a4a34180000b029024b199e7d4dso4621312ooa.4
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q9Un+r4ZONvlb6vx62E8HtR42WCg4M/UJUYRRNng1jc=;
        b=S9Hbg/hUtRv9yjNo6CXlkikKISJrGZPVGXIXvqcyCep91Icyok9J7VX5abLDcJa2yD
         YqshGrrwmzRCtcZak3C8J8Fpzi2aC1e1HVB+dKZzLNkY+HfYs0aPl992DxO7TbqFztkS
         pFlHIO3yyYCgEj1O2bgNrxRJ7uNkEMUjqZEfpxCcnAyLdqtG4ItVKrDGoBa1ugvk/9a7
         /27QdrOxeMjCzYub2tIQJf9vjzackFY1OcdirdymVRUMXWUNkl/OgQrKpYxSwoiJfIsp
         17T1BB0wyX3bafU9KsRueIKfRculBln95hg/tmyPkywBstVb7PTcJEaPVkxkV+I1qvON
         /vIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q9Un+r4ZONvlb6vx62E8HtR42WCg4M/UJUYRRNng1jc=;
        b=ksWpjBl44uf/lHi3nIpP0hnaSwSXT/NPTsZa7C98lu86BnU9NRg2gBx0aDDiTXdl2k
         8w6hUgPqOC4NWbCU5BR60ebTTTtFOCH+gGNMgloJXRqarACAPXrsXjsz/FF8e49OmJ+p
         PvgscajbbqKdHC4QgNQIhwP0IrueHevKwHBvQiL0LWxaj96v34xB9/BRNhH3lJDyKHzQ
         iq0ZJrR7gKpwPkwJqDjQL99R2ckoExIbjtAq42i4rxvjacUCdmZa+6jHMKbh/6RdO3vp
         7KOfdoeRH9aYiao+kPjeYz/SfsS/EgSAmQ0mRH8Fj6NadiSAjweYJiP+GGAay1Ydm01b
         cldw==
X-Gm-Message-State: AOAM531Q73V0QICgxwnBggGrCSIpZ4dp7oIPXwAfk+U3E4gnWVWPjDlg
        1exVuWQJCBF3IePoBz570WCsnZS67yoTwQ==
X-Google-Smtp-Source: ABdhPJxQRNtFMM+ApzS0w3dsWAxJhzdXFUPom4aRBB+A9O1oceFBI8/8X9mLdtg5xOAw1kYyP0ZKVA==
X-Received: by 2002:a4a:c190:: with SMTP id w16mr742984oop.92.1624321637498;
        Mon, 21 Jun 2021 17:27:17 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id r7sm344137otn.29.2021.06.21.17.27.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:27:17 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/4] test: add merge style config test
Date:   Mon, 21 Jun 2021 19:27:11 -0500
Message-Id: <20210622002714.1720891-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622002714.1720891-1-felipe.contreras@gmail.com>
References: <20210622002714.1720891-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to test different combinations of merge.conflictstyle, and a new
file is the best place to do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6440-config-conflict-markers.sh | 37 ++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100755 t/t6440-config-conflict-markers.sh

diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
new file mode 100755
index 0000000000..813d7dda9a
--- /dev/null
+++ b/t/t6440-config-conflict-markers.sh
@@ -0,0 +1,37 @@
+#!/bin/sh
+
+test_description='merge style conflict markers configurations'
+
+. ./test-lib.sh
+
+test_expect_success 'merge' '
+	test_create_repo merge &&
+	(
+		cd merge &&
+
+		test_write_lines 1 2 3 >content &&
+		git add content &&
+		git commit -m base &&
+
+		git checkout -b r &&
+		echo six >>content &&
+		git commit -a -m right &&
+
+		git checkout master &&
+		echo 7 >>content &&
+		git commit -a -m left &&
+
+		test_must_fail git merge r &&
+		! grep "^|||||||" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
+		grep "^|||||||" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=merge merge r &&
+		! grep "^|||||||" content
+	)
+'
+
+test_done
-- 
2.32.0

