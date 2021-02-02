Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4FDBC43381
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8596064ECB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 02:01:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229977AbhBBCBD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Feb 2021 21:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229852AbhBBCAw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Feb 2021 21:00:52 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D612AC0613D6
        for <git@vger.kernel.org>; Mon,  1 Feb 2021 18:00:11 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id u14so967928wml.4
        for <git@vger.kernel.org>; Mon, 01 Feb 2021 18:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=99z/N51brAZCh/2yfY4ZwIW5x3kNGhNN11Cc0IDmqbs=;
        b=Nc97EPEF7Z5Yq9QFRqAuGC9WJ29NbfzRrUUG0CMO5sa7fz64srUwQuwt6gRyH21fbX
         wqRPjlm9M3G1FMIvv1CgMRnNAg+PSHWe0S13Uxz5OR4J80MgLq2ku3/5Td1H5jNRUMUN
         NqhWFchN/3pTalpuskPoaX1TOdvrAGd4GAdXqBKbZ3QOnDBhd2QVx6FlJE+h85Lzc0U9
         4IFQvEm0lLMvVOEuan4aYuKbLCR5aFTvK3ueTYNDLYKyPzfDPAfnK35G5oJNeZKHZBAe
         p+W2Ud+KJPmR40an3vBpqlOctmrnLmleadcH7XllDeFQLuMw2cKuJu8HnI2Q5AybesN7
         VfFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=99z/N51brAZCh/2yfY4ZwIW5x3kNGhNN11Cc0IDmqbs=;
        b=dnQQKdrfBa9WTV0/2sYUf9hBb9izU6wVhTOsE+5hDE/NVYDtw2LL4GTscTVji5FvGS
         ijJBnCr9JN8v/OEGU3k1Oc3O3PhB8frlECOPw8Hlce7lW6kg9tq9Zdu6AVWwfkKdMoke
         yoh3Q1LrWujxk+6YUKAUekfB6y0LVniJDl63iyYUwW+47xY7T9wquGZthlgJm8gvyn0t
         DpHibEaoNhR0yEhNeSurNiqlH2nsbpYIKgrm552/u25sViR5rgjWIf/eXhHsokqx0B14
         gNzUr3lgx25tkUnVuxoaXudbVL8SmcC4Rh3Mrze6+A5HyCQ8yWm5ylUzbbdIL9RKvPUm
         BsWA==
X-Gm-Message-State: AOAM532mRV0VWlp7IbrqN1dQCMLhggR23itmFMI2MOf1CCSDWCLSMZdO
        xONcPPOVfgd49ROpuQQJvn3bvBB2AvTe8A==
X-Google-Smtp-Source: ABdhPJw3NyfTLdwifbjIqPab/1hRn7EmWyYevNQbhEDCuMqY2KOJzPWJwXCklkQdiRg1BLMJ27XjEw==
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr1365836wmj.126.1612231210386;
        Mon, 01 Feb 2021 18:00:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y24sm986175wmi.47.2021.02.01.18.00.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 18:00:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Vincent Lefevre <vincent@vinc17.net>,
        Chris Torek <chris.torek@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/5] run-command: add braces for "if" block in wait_or_whine()
Date:   Tue,  2 Feb 2021 02:59:59 +0100
Message-Id: <20210202020001.31601-4-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210201144921.8664-1-avarab@gmail.com>
References: <20210201144921.8664-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add braces to an "if" block in the wait_or_whine() function. This
isn't needed now, but will make a subsequent commit easier to read.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 run-command.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index ea4d0fb4b15..00e68f37aba 100644
--- a/run-command.c
+++ b/run-command.c
@@ -551,8 +551,9 @@ static int wait_or_whine(pid_t pid, const char *argv0, int in_signal)
 
 	while ((waiting = waitpid(pid, &status, 0)) < 0 && errno == EINTR)
 		;	/* nothing */
-	if (in_signal)
+	if (in_signal) {
 		return 0;
+	}
 
 	if (waiting < 0) {
 		failed_errno = errno;
-- 
2.30.0.284.gd98b1dd5eaa7

