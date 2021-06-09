Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 113D0C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:28:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC3E9613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:28:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbhFITaw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:30:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhFITav (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:30:51 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7761C061574
        for <git@vger.kernel.org>; Wed,  9 Jun 2021 12:28:56 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso2043223otj.4
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WRSjgvAnvinC9jsqMJ0bgTAJIM41vhXijompJfNqYpw=;
        b=SX0urmlnb+75B21kH5AhRb3etrvXUq6ghw8cozjAMODIZ4E9cQnuWBJrbI0HvmcdG/
         HFCP2idQ2FW2RspMZcb/+MR8KdrnTTv68B+yqSxpGXaqzqozd6TIe5XKu2nBH3B82euM
         kcc+5sBaDUkboJlIbC/6M4fTrPjYiwexcFsuBeI+4pis5XkTNhGP5MloJoKZVeLRdEBU
         NIwDPJjojJb/mi6eIP6+i7O0wwJpNBy9eYoRmohpN3iZUe6AxXLCaoKYvXX4djj7lu4G
         33XDZeFL/IDd9nbljiuSX4monLJgsOqNkjeHDGzDPMDT2/7G2x8plpG1EXnJXjhRzEOt
         vPRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WRSjgvAnvinC9jsqMJ0bgTAJIM41vhXijompJfNqYpw=;
        b=qYD2Jq8so4gIN2n25fLybAzYI3Lex1aYn6AwSsO+a2py8zthkPV7OHlIqpIeErZn/d
         DtiPurCRuSymfOMDNyYjWMjyhQgGNh01MoZSPFyTVMokjm/qMJV9+KVx9pJ1yb+cdOIw
         gFM89wlVnocimT0QJLUBOuo5Q/BcwJBjJVeAVZRlT7fyZBbHWhrCK5IKzMar8mEIEzdx
         S3gLgQntONB887FDZGDD1zw+I/3gKAjYh+cYZ/0BqzIrtl3fMc18gIumXZwtQOgVdHD2
         3VqcalaFp751dHsL1HH4zw1nlBKPdTpJK24tcxr/uI8Lh+jaV8O/LVqKvH1/428ecSB6
         9pZA==
X-Gm-Message-State: AOAM530I4tIOeLQLTEtRn7VxTceHdDK4Y88pHymQM3FEcPTZjUB/ECvV
        XstofIYVh7qHv9v8nt92R9pGvwS1sapPSw==
X-Google-Smtp-Source: ABdhPJw/VtB+8gHZSgDiUpOBoMsglROHd7MkAuHQ1LW6PsmfYoH5AnkJgWasqWCZnWEDNqJQYovweA==
X-Received: by 2002:a9d:7012:: with SMTP id k18mr815471otj.179.1623266935985;
        Wed, 09 Jun 2021 12:28:55 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id t39sm125728ooi.42.2021.06.09.12.28.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:28:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/7] test: add merge style config test
Date:   Wed,  9 Jun 2021 14:28:36 -0500
Message-Id: <20210609192842.696646-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want to test different combinations of merge.conflictstyle, and a new
file is the best place to do that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6440-config-conflict-markers.sh | 44 ++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/t6440-config-conflict-markers.sh

diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
new file mode 100755
index 0000000000..6952552c58
--- /dev/null
+++ b/t/t6440-config-conflict-markers.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='merge style conflict markers configurations'
+
+. ./test-lib.sh
+
+fill () {
+	for i
+	do
+		echo "$i"
+	done
+}
+
+test_expect_success 'merge' '
+	test_create_repo merge &&
+	(
+		cd merge &&
+
+		fill 1 2 3 >content &&
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
+		! grep -E "\|+" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=diff3 merge r &&
+		grep -E "\|+" content &&
+
+		git reset --hard &&
+		test_must_fail git -c merge.conflictstyle=merge merge r &&
+		! grep -E "\|+" content
+	)
+'
+
+test_done
-- 
2.32.0.2.g41be0a4e50

