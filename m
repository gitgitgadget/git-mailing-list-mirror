Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2CF6C433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 01:46:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352359AbiCaBsA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Mar 2022 21:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiCaBr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Mar 2022 21:47:59 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E5448887
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c7so5034613wrd.0
        for <git@vger.kernel.org>; Wed, 30 Mar 2022 18:46:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k39iHOKWgO3ciMMLmcOIK1DBdi7T5O4eqLeFwuqyqqQ=;
        b=qjCHbc+V/ZqC0JRN/lFoM/88g138ERmRCLGVF5znhDJHXqTCJe5t47X8bSu8x9Wtva
         jx1Yk5Lhf3LBI406TGmCRRddCT9BoBpuoNQpTWsq8ZHFbEzj3tFkm2IVD7QWEUi974m+
         Eph2T+gGCILKSAw8FZ3+mNkc+Nvf86DL9LVns8e8ZTrt4RsH1k7KVUJQ8m8o+rxgPwYH
         g5YvdBg9YQVQie8cBSqM/pRONtxezBD1UjBw+VJGsAKq19G8dWdw9vS8PaWgDu3IhOxq
         M5ZH2GyrFdeUsD8Lbhha7ix7P8gl0JhXsGl2xk7HMtTTsQZmR4ccxy1+DIBBz7nV10/9
         tGRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k39iHOKWgO3ciMMLmcOIK1DBdi7T5O4eqLeFwuqyqqQ=;
        b=zKKYYCyp693nWtafgWlkg7XZw2fHIUw6IKcdpdHaCvmVgaZQ144huBVGkK/3ttIemz
         wOLoihlrck3DYJcTg8YwK3ixjlqSihwFVxdQVQ0QIk3DEiwV/QWUpJvwdIsSAk6RqmIr
         oNRXwl8PEthPO0YTL35su7Yb4PVcbLB5sbmRV2/qVZjBnpGItSPFB0pNWN+QRrQgMtGW
         FToPEZrmjMHsuFsOsu+3m/TiOb3wzLJcRHcha9i1CmB57LrwrQmA4lWE12te9MIuy5KD
         f+m7dc4MLUyPVkEO4tvAEDdLUGWp5+wCAhJwftlYWQg+gf2YNQiEJSnAMJfTi0myLtDc
         3hTg==
X-Gm-Message-State: AOAM531ckYIVrr+UD1aiTPzcEe0HI9bTOzrnA/9HLqOcTGNXiPUQq8/R
        0nMiF9Lm5/+ZsLUfiFc73WgsRL7/roTG9A==
X-Google-Smtp-Source: ABdhPJxREBh9REG6Y2zDlCqk8By7/jrFy84EPh1zrpSkIqlEoFM+Apj5OwQBgooEiSnkItCQ2MmdEw==
X-Received: by 2002:adf:ffc9:0:b0:204:195:4ab0 with SMTP id x9-20020adfffc9000000b0020401954ab0mr2043829wrs.561.1648691171196;
        Wed, 30 Mar 2022 18:46:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b15-20020a05600018af00b002057c72d45fsm23603272wri.77.2022.03.30.18.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 18:46:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/6] run-command.h: remove always unused "clean_on_exit_handler_cbdata"
Date:   Thu, 31 Mar 2022 03:45:50 +0200
Message-Id: <patch-v4-1.6-fc55b203474-20220331T014349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1561.ge8eddc63765
In-Reply-To: <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
References: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com> <cover-v4-0.6-00000000000-20220331T014349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a "struct child_process" member added in
ac2fbaa674c (run-command: add clean_on_exit_handler, 2016-10-16), but
which was never used.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/run-command.h b/run-command.h
index 07bed6c31b4..5bd0c933e80 100644
--- a/run-command.h
+++ b/run-command.h
@@ -142,7 +142,6 @@ struct child_process {
 	unsigned clean_on_exit:1;
 	unsigned wait_after_clean:1;
 	void (*clean_on_exit_handler)(struct child_process *process);
-	void *clean_on_exit_handler_cbdata;
 };
 
 #define CHILD_PROCESS_INIT { \
-- 
2.35.1.1561.ge8eddc63765

