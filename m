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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83CA5C49361
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5946F61279
	for <git@archiver.kernel.org>; Sat, 19 Jun 2021 01:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235338AbhFSBdW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 21:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbhFSBdV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 21:33:21 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8CAFC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:10 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id h12so5581427plf.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 18:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=QaEcclP7OHjPB4tJmnzpLY4/8K0D7kQhhMzZZgMv/yOStNV/Tuo8NvvqGYd0dNhfdK
         TqgMhS8nInvfc+FzZTyj4jsQtg2zpTiMcDEbzHUxpSaUJlSadkeGbyujFTPN569+Y3gP
         s9KFXPcH+0S7E6JqFCm6WbF0jZqL6ngsJ0JwHqoAoHUEpoGV4zROuko9iExJEYHC1t0v
         +xoBoZbS3aYvNvxITxn1O8vRmH6Da68PwoGU90cqZIn8AMpccb6iEsntrS/An2xUZDxe
         Zm0AhjvFk7P6MrduLbNtUdi9ljLIZJ/ElF7Rk0ka+rNcwJ2CZhwSSrcev/dB6Aqs4Yva
         Y4pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=E0As/PiTgAKXG1QBmBfO8WmAAJV6/5IlMyzY0z71GFE=;
        b=Q88RApdTByVGg7zWgjGHa3zhpHRWnoQN74FJBx+cBKkR4bXL1fqJLXPJge01xnZrWp
         rtgENsp31/MIx89PcBh13HqlWPLG6INhEuqvRhkEu9YTDNKevjsINL42HNIgnoGkDe9e
         lYFz1wwIiPRVShalxbJ75WFXk4eNftOWzbFca5c7zcYprNTFhNAykILoxFv+2UiUoqQF
         VJdX1KRaQPwccaEEhdbawgYrSlw6SjrW3FIfSY+sJ1wwukOk85wAyDtMlg3DydPEPVzX
         YVZMELegTQkZD0x8gbUc3DgptKvDPX0n2gBK/U/MfEsRym+ZWurEZMNmyLUu2rHX2tMD
         4P6Q==
X-Gm-Message-State: AOAM531WM2zgPiOZlcyuC9o6952U2bfpNnIsQz/L/1Q0VEnDmV4jJJLM
        Nk2FF4hXpkQg/+TwjyYN38lOWfyutDM=
X-Google-Smtp-Source: ABdhPJzthN+0HIyUth2Gp/jXfAuSFpCegyNC+9/Wr4sYlkVV+mnkemGaOM2U1ADPaMT+w0NbVKF6pw==
X-Received: by 2002:a17:902:7590:b029:11c:432f:d1ec with SMTP id j16-20020a1709027590b029011c432fd1ecmr7362197pll.59.1624066270275;
        Fri, 18 Jun 2021 18:31:10 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:a3d1:fb64:d06b:ab01:2de4])
        by smtp.gmail.com with ESMTPSA id s123sm8733427pfb.78.2021.06.18.18.31.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 18:31:09 -0700 (PDT)
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
Subject: [PATCH v3 2/4] t6402: use find(1) builtin to filter instead of grep
Date:   Sat, 19 Jun 2021 08:30:33 +0700
Message-Id: <20210619013035.26313-3-congdanhqx@gmail.com>
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

