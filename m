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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D116C48BE5
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 762B261414
	for <git@archiver.kernel.org>; Tue, 15 Jun 2021 17:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbhFORXH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Jun 2021 13:23:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhFORXE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Jun 2021 13:23:04 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E30C1C061574
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id fy24-20020a17090b0218b029016c5a59021fso2287201pjb.0
        for <git@vger.kernel.org>; Tue, 15 Jun 2021 10:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=jD/Sh5E1Ed6m8REaHDSSv6LSEKIb3JTLhJx1kLigxvaHRE0K6iUsEcz/gGzrUWdrr8
         5epP9CyxIPtOgoF6T4W7MbiFKJM58snP3vcobHLS4JROuWPKTWdSqPg/27+qvh5dB6/M
         f2I7vHku5yp5DGZhqFJEQMaAMQfiUx2Joq9FT1Gpv4LhzQTOuHvES9re+nQUumPEo2cv
         8OCn6RlbGWrChElDqIrP8pf5gfbzU09kJY3IsVkDCRot6dk/HwUZCRWELetLyLifr1sX
         vS/z6tHfTFxLNMzT0Giu/EQQxTEAX4hDu0Npl4HuJspAnskO41OVwuCac9fVUBZymsBe
         TbQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=cJm4muTgMwbLekif1oQzz46VPQofMH7naQLzdGKGNiR/7O/yGWAuHFc3R3j5crZKgy
         adle/DlT7aplPRSaPwPbupzl6+FSMef+/O870pm9gF17bC6msr3r0fh1UgzaHOnp49WK
         vVnqMJ1Zh5WbOLcTo5fSzRkotG6Gaov9y0puzlkb6WcFPBwuqcpr3z3/IxK/kjNkk6zL
         sho+/2ieeNvQt2dHV1am6je7VIF1A8sWhaXT+3QYydJIFGSoj8brSr0udpqniZK+7ODf
         FjhdAsJ9yIQ9kEW6CGunJ7eJ/eQJPJ64af3aSVb0ZB4hwCDf0jLmSFc+O6cwuYhVsbKH
         WlgA==
X-Gm-Message-State: AOAM532JwRkJSTHpNJTy/OlZUlgOiBqKvwjxtaOof0iWZ4zMrQaB1k1i
        zwJSkWJx9OGFWS9LhSGtU4pYYc74Xe8=
X-Google-Smtp-Source: ABdhPJzFySgSMib+vvJnHam7iaMnLhhr4SwfKSqrhcQGp19+oqUORGE1msGX+ZiM6R5epTFn3klRIg==
X-Received: by 2002:a17:90a:7e8e:: with SMTP id j14mr5961736pjl.151.1623777659331;
        Tue, 15 Jun 2021 10:20:59 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id z22sm16864162pfa.157.2021.06.15.10.20.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 10:20:59 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/5] t6402: use find(1) builtin to filter instead of grep
Date:   Wed, 16 Jun 2021 00:20:35 +0700
Message-Id: <20210615172038.28917-3-congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <20210615172038.28917-1-congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

find(1) has a builtin (-prune) to filter its output, save a bit of time
for invoking grep(1).

In addition, in a later change, we will try to use test_line_count_cmd
to count number of lines in stdout and/or stderr of a command, due to
limitation of current implementation, it can handle pipe.

Let's replace grep(1)'s usage with find(1) builtin filter.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6402-merge-rename.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6402-merge-rename.sh b/t/t6402-merge-rename.sh
index 425dad97d5..5d76cd6414 100755
--- a/t/t6402-merge-rename.sh
+++ b/t/t6402-merge-rename.sh
@@ -546,7 +546,7 @@ then
 
 		test_must_fail git diff --quiet &&
 
-		test 3 -eq $(find . | grep -v .git | wc -l) &&
+		test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 		test_path_is_file one &&
 		test_path_is_file two &&
@@ -565,7 +565,7 @@ else
 
 		test_must_fail git diff --quiet &&
 
-		test 4 -eq $(find . | grep -v .git | wc -l) &&
+		test 4 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 		test_path_is_dir one &&
 		test_path_is_file one~rename-two &&
@@ -593,7 +593,7 @@ test_expect_success 'pair rename to parent of other (D/F conflicts) w/ clean sta
 
 	test_must_fail git diff --quiet &&
 
-	test 3 -eq $(find . | grep -v .git | wc -l) &&
+	test 3 -eq $(find . -name .git -prune -o -print | wc -l) &&
 
 	test_path_is_file one &&
 	test_path_is_file two &&
-- 
2.32.0.278.gd42b80f139

