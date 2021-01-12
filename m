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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AE49C07EBB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F64423127
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436934AbhALVhV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436869AbhALUTf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AB34C0617A6
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:29 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id q18so3867947wrn.1
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gq0wEbmaE+z6knB43LztlX5an7hfs653jER7XA1Bbws=;
        b=LWkEjKhcwGsGprUhIxk3xhRY7ptreS2e9QL0e3qef4pT+0Lj5RtDaMEDysCJUhbvTP
         hx61cgLYU9Gkz2C0uJpDj8Z66Gc1U3ix4WKi+WfM/+FFVG+RfGnJBlgTsc83K804V20V
         VosJgZ14JnAtt/k6OZDF15ndRru9a1HKiiXOaDcFjhjXlcHqvydQS9r4WhMKSMCzrpo/
         HwbcuxhtxarDBecCezjmocyAALa+vJQPZFqoyxnVfTsVgcRckmLGUY7BHLZcuFiskgfh
         p1ftrugzwQrSoBCGRuKSWeeLWtyfADWWr/4i9YKMKoKJ3H9FfyDbllDbptdoRyBgFEC9
         LeAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gq0wEbmaE+z6knB43LztlX5an7hfs653jER7XA1Bbws=;
        b=DiXVQlp1Q43rw52mwChUVicM34Mb/HEHuPo1ZIPSRZM9m+lzHUdzoBQFY9B1lLTk4A
         9cNRhkmMKsePCMyKQoihtX3UOa+Nn+NoVkKFTCkRnYP2lmnVwnkP3a0EGNadIFLFTXRs
         re7vu+qp9kIukPUpCIH8sU3QjOoNxSzI56r0tqm1PggAwCf/8hRYqNk46Vps5+TAso5W
         Sl3wT4MK3++9UG8VpqoWOODkk++McWLhw6CaOQ5UzUiuhJYi1YzuTyYVCxKJEFlWEPWy
         YLZVQ7bm2RQCpwOCg1FqZRnm0IJ6QX58ewVV2k6hCXRy+1OlGSnSM2kytiiSh/9r+y87
         OAQQ==
X-Gm-Message-State: AOAM530fFdIEDtpEB44/YTtroagGbJV+3+obwpur8/9Aaul4AMR8EeOr
        9d8ldEvajR1Km1IsCGyIPfYYsFHWzINK3g==
X-Google-Smtp-Source: ABdhPJyKAlJeeYbTPdIj6RU4PnBnxXTm4QyHv04hbJzcQwwX6krqMw+WF79ogBllicaMbosaahzLEw==
X-Received: by 2002:a5d:4ad0:: with SMTP id y16mr536588wrs.424.1610482707929;
        Tue, 12 Jan 2021 12:18:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/22] mailmap tests: remove redundant entry in test
Date:   Tue, 12 Jan 2021 21:17:52 +0100
Message-Id: <20210112201806.13284-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a redundant line in a test added in d20d654fe8 (Change current
mailmap usage to do matching on both name and email of
author/committer., 2009-02-08).

This didn't conceivably test anything useful and is most likely a
copy/paste error.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 1 -
 1 file changed, 1 deletion(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index dbd365681e..03a98d9635 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -414,7 +414,6 @@ test_expect_success 'Shortlog output (complex mapping)' '
 	Other Author <other@author.xx>   nick2 <bugs@company.xx>
 	Other Author <other@author.xx>         <nick2@company.xx>
 	Santa Claus <santa.claus@northpole.xx> <me@company.xx>
-	Santa Claus <santa.claus@northpole.xx> <me@company.xx>
 	EOF
 
 	echo three >>one &&
-- 
2.29.2.222.g5d2a92d10f8

