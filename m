Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F032C0502A
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 09:31:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231287AbiH3Jbq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 05:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiH3Jbn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 05:31:43 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A65E99B40
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:43 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-11c4d7d4683so15347679fac.8
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 02:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=lFTLPaWSHwhDaQSfY1P+2FkHzQtINHyZtFu31qB1Hq4=;
        b=FDJvIo4CnvDto4AkvhAlNGwgOZvh44hqHg6+gba9A0hjZFCMootZn85K7MlpPn7Kuu
         MoUw5dPBc14yzjTqRKzKqW0E/k6LomyYNjSSPyHT3FKziszxVYbqbMrNlMNKU/2Y+fmg
         KH2VkR6fa7yPN1qVs2M85HeVo9pYQiTy2lcpu2QJDnn9cAzDKgFkeYhJvRhyGg0cb9jV
         dm7bnrWhCcZCYaF1d2JEtqk4uneeaYtS6F3NbYBRkCq0uJinsPDk4Hmml69H6mH7/u5L
         j3CbGM8GRky1GCs8prb9FdwluYNDRKQJCQ2VdJWoU3ZIGheymdTXCPcK4TU6eprxsado
         QdTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lFTLPaWSHwhDaQSfY1P+2FkHzQtINHyZtFu31qB1Hq4=;
        b=H8QS+h7QdcLjQ14qAPJXkQgBNtHkv/fusjKbzW+D+F654XOv8K8Wp8JFxM5/fjDNjl
         CNneEwOPjTbGVGMBaQfjMYBbbMn58wX6OWsDxdZzwCS1SdgbCU0dMFdebURYz2YwXlVs
         Zr2G5lPHrpEch2l5Ywnrvqx6ClJRFj4mu8DobfBhW9cmyulmXsBtbowv5iZGnSh6j37T
         iSVCEaLjBL4Ct6ZE6KEZtS5VwLMom7HzlrggsCUbgsB4W0OEtmouAsmN5dC0KJfKUz5j
         SfCG7dQHoQyIExHTU/XtIA4se3czBN/i+fiVDRqSVYgjrfrDxNPUZh9XYPU/3S4bzOz5
         UG/g==
X-Gm-Message-State: ACgBeo3UbtXDXd94VDTFbAqB1vrL1/f0NsIzLsEe/y32PTxnQ9SFKw1U
        Ixu3s/EuIXuq1t7LV8RG7ug4VOyZeiw=
X-Google-Smtp-Source: AA6agR5vOyCrL+TpS+AoDuuwNMSFPokj9GflVnaJ2eNwrb9oD6cc73iaYi2OGFPWLuoTVkPI5WO+gA==
X-Received: by 2002:a05:6808:f06:b0:343:2e08:ce93 with SMTP id m6-20020a0568080f0600b003432e08ce93mr8743254oiw.273.1661851901985;
        Tue, 30 Aug 2022 02:31:41 -0700 (PDT)
Received: from localhost ([2806:2f0:4000:eec:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id x17-20020a4ad051000000b00443abbc1f3csm6384266oor.24.2022.08.30.02.31.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 02:31:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     git-fc@googlegroups.com,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 01/51] test: completion add test for __git_cmd_idx
Date:   Tue, 30 Aug 2022 04:30:48 -0500
Message-Id: <20220830093138.1581538-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.37.2.351.g9bf691b78c.dirty
In-Reply-To: <20220830093138.1581538-1-felipe.contreras@gmail.com>
References: <20220830093138.1581538-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When __git_func_wrap was fixed to set correctly __git_cmd_idx in
cea232194d (completion: bash: fix late declaration of __git_cmd_idx,
2021-06-18) no test was added, therefore we could hit the same bug in
the future.

To ensure that doesn't happen add a test which adds an alias for 'git
add' with __git_complete, and then pretend the user typed this alias.

To make sure __git_cmd_idx is correct we add the --update option to
ensure the result of __git_find_on_cmdline (which uses __git_cmd_idx) is
correct. When __git_cmd_idx isn't correct __git_find_on_cmdline fails,
and therefore the --update option isn't interpreted correctly.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 43de868b80..8cc30448c7 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2659,4 +2659,13 @@ test_expect_success '__git_complete' '
 	test_must_fail __git_complete ga missing
 '
 
+test_expect_success '__git_complete has correct __git_cmd_idx' '
+	__git_complete ga _git_add &&
+	echo modified > file1 &&
+	touch file3 &&
+	_words=(ga --update f) _cword=2 &&
+	__git_wrap_git_add &&
+	test "${COMPREPLY[*]}" = "file1"
+'
+
 test_done
-- 
2.37.2.351.g9bf691b78c.dirty

