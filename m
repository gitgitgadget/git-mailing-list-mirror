Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C7C4C00145
	for <git@archiver.kernel.org>; Thu, 15 Dec 2022 08:52:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbiLOIwq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Dec 2022 03:52:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiLOIwb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2022 03:52:31 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3937526ACB
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:30 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id u12so2270362wrr.11
        for <git@vger.kernel.org>; Thu, 15 Dec 2022 00:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ei6U/nntlUWEF+yRrzSWowNU3EfvHZJODJuqQdNbi9U=;
        b=eOE4lhIyeDeeLAJvLhEA27Q2Z3q3mhikql2LFk/xtsy+Rv05hWcFsf8VaOczD/DpWF
         xPhO27Gl9uL4K+JG39GviVA6oja+bzsJjZSqqCg2Cn8RlOASxh3FBKXMIFKRqyz6UT3S
         jwKh3pK8cR3rMi6VMLeWZvpeF9Cp6VWYwuLTN+yj4JMOQf9NavD19EF7PMsj2Hmtkmn/
         lHhAYIhYIRc6KvZHjNZN4vaRjtTK+E5+tPni/8AI61ucBiWUcS0kAaxEHudJH324aRSF
         y83NouXNZ/HcPTai0VTNojFwrHzP7VBfmSGotnUIRrWToRy6Hguy+L+McxgeKGcPaae0
         8iOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ei6U/nntlUWEF+yRrzSWowNU3EfvHZJODJuqQdNbi9U=;
        b=jVYE2ojnV312HYKmE2sYjk2fREk9AXSZFW5RGefEeeYT+30UuBvWzuGdXnSepk0FKn
         Q2sSMDdoKpxYHivuX6S+5ITsc/lzWLCPe+1G3bmFhS23uR5hA3o9PpaQkSYEFS437cwF
         wboxz7JSh21imlxbURWryTxlMO0obkcR4gtAbYsnG72q99Y5p4FfK7e3L/M7gfbjZEDO
         Kf6Q13c/EJic6/BoayUzrvpSzGj193m5AU58c8FHPoyohr3OGpBxFdI2ImqjtZ/abK+Z
         IuZDke7wsTZdhlaNBnSsLl8G80QfvRTKzZdLMw8PlqGd6jOKYw1lU4Nx1Qu2ZdZRhBrO
         7hsw==
X-Gm-Message-State: ANoB5pl0+C2YXodYQDoEujDWDEC5g/Bvn6DuE7VOX1pMvC0G9WHfflI1
        svJVFAv0Joa6Xim/2jDN+/RVWyfdBapAuA==
X-Google-Smtp-Source: AA0mqf5RUMcJKbjlczJvQbs9LUIP+B6xPd24iKxxI28gQNclbfB5FqLuYseJ97/AT44v5B40padiLQ==
X-Received: by 2002:a05:6000:15cb:b0:242:fa3:3825 with SMTP id y11-20020a05600015cb00b002420fa33825mr21240925wry.37.1671094348396;
        Thu, 15 Dec 2022 00:52:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r10-20020a0560001b8a00b0024274a5db0asm5464905wru.2.2022.12.15.00.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Dec 2022 00:52:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 04/12] merge-index tests: add usage tests
Date:   Thu, 15 Dec 2022 09:52:08 +0100
Message-Id: <patch-v10-04.12-aa731011e0a-20221215T084803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc2.1048.g0e5493b8d5b
In-Reply-To: <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
References: <cover-v9-00.12-00000000000-20221118T110058Z-avarab@gmail.com> <cover-v10-00.12-00000000000-20221215T084803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests that stress the current behavior of the options parsing in
cmd_merge_index(), in preparation for moving it over to
parse_options().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6060-merge-index.sh | 44 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index 079151ee06d..edc03b41ab9 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -5,6 +5,50 @@ test_description='basic git merge-index / git-merge-one-file tests'
 TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
+test_expect_success 'usage: 1 argument' '
+	test_expect_code 129 git merge-index a >out 2>err &&
+	test_must_be_empty out &&
+	grep ^usage err
+'
+
+test_expect_success 'usage: 2 arguments' '
+	cat >expect <<-\EOF &&
+	fatal: git merge-index: b not in the cache
+	EOF
+	test_expect_code 128 git merge-index a b >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
+test_expect_success 'usage: -a before <program>' '
+	cat >expect <<-\EOF &&
+	fatal: git merge-index: b not in the cache
+	EOF
+	test_expect_code 128 git merge-index -a b program >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+'
+
+for opt in -q -o
+do
+	test_expect_success "usage: $opt after -a" '
+		cat >expect <<-EOF &&
+		fatal: git merge-index: unknown option $opt
+		EOF
+		test_expect_code 128 git merge-index -a $opt >out 2>actual &&
+		test_must_be_empty out &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "usage: $opt program" '
+		test_expect_code 0 git merge-index $opt program
+	'
+done
+
+test_expect_success 'usage: program' '
+	test_expect_code 129 git merge-index program
+'
+
 test_expect_success 'setup diverging branches' '
 	test_write_lines 1 2 3 4 5 6 7 8 9 10 >file &&
 	cp file file2 &&
-- 
2.39.0.rc2.1048.g0e5493b8d5b

