Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FD4C432C3
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17E10206DA
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:05:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1Pu9fJw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKUWFV (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:05:21 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38540 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbfKUWFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:05:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id i12so6313084wro.5
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WCHjYPVvLSfbWOovV0VZCb0RhxBQMPojNdRCPNPSy+g=;
        b=R1Pu9fJwY7sTdL7luCb4Jni8kVPl0FAwWQXZDi7s76og37JnrajEveao0EucYXTi9M
         yh4bPDbT9Nh/RfDBN/CMuLrvIwceNZrQD54FEndap8xAHOReoxVlVMcysmS1audFjG8z
         YqnJPDd0mlhoorehuqPYMR8JPASLA8yif9fXzqp4PXakaQSZz2rUklhI+GtAC8yjeWcD
         koz1S0n/9a2vYqyJ6UkhLsSHJPQKLiqWKlm1bVwV7os0YxYiQ8TSDNAYflPUnBvigd4h
         hGI8KpsX5pS6n7FTazLNswnIOwAYHPI1YfFxwF/lwC/eK53RAe7ysbtU7qSOt7+NUoq3
         ibpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WCHjYPVvLSfbWOovV0VZCb0RhxBQMPojNdRCPNPSy+g=;
        b=f54u4az/6iyxidMjDwHEpzZB6b/ojEgrdbVracXHqLOUUrDDAc1bZgwWrS8oh5vy7D
         3NqgHO+VdeimIVUcVjTb+mhPG9rl5yGqElmXM0qd8DUG4ppjvkmnuCUmrZeVq1IcgsP0
         2gWWkyis1KRlYedB/fBk8vEOE4N/+acL6DnzhWFtb5romXWL9wfCLjQ9wDxRnJr96EER
         WmfljE4UUa6H4M4lUMuZ0FcfbIdXJagS3/H1xO0L1fyHAVlYVmXzL8nZESqZ2/Qs+gFO
         KzYF+mEhyQ9Sj4rBFr43zElSRvxRIajRW0EylLqavbjFd1Nadi0/NAwDH+9KGZGHCVW3
         f1Mg==
X-Gm-Message-State: APjAAAX335VfzdnJJNATppak0UxqPe5AFxjyTMxCnv+Tch8RzeAIYTfF
        HvAhy2QG4KN5rKUDpqHrOXu+3QJ1
X-Google-Smtp-Source: APXvYqzXlYfxMg4sMaist9vv5l/mFdZp8Xri5RtAGqRON+/B9SbTF+WDhnDAHUwsod0DIqO1lSld9g==
X-Received: by 2002:adf:82cc:: with SMTP id 70mr12236540wrc.231.1574373915247;
        Thu, 21 Nov 2019 14:05:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm4729843wrh.94.2019.11.21.14.05.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:05:14 -0800 (PST)
Message-Id: <4097d8f6dec0cc25e356c17a8cda73d3c32a4894.1574373892.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
References: <pull.316.v5.git.1571666186.gitgitgadget@gmail.com>
        <pull.316.v6.git.1574373891.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:04:49 +0000
Subject: [PATCH v6 17/19] sparse-checkout: cone mode should not interact with
 .gitignore
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, jon@jonsimons.org, szeder.dev@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During the development of the sparse-checkout "cone mode" feature,
an incorrect placement of the initializer for "use_cone_patterns = 1"
caused warnings to show up when a .gitignore file was present with
non-cone-mode patterns. This was fixed in the original commit
introducing the cone mode, but now we should add a test to avoid
hitting this problem again in the future.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index f074b7f3be..e61ddb4ad5 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -284,4 +284,11 @@ test_expect_success 'fail when lock is taken' '
 	test_i18ngrep "File exists" err
 '
 
+test_expect_success '.gitignore should not warn about cone mode' '
+	git -C repo config --worktree core.sparseCheckoutCone true &&
+	echo "**/bin/*" >repo/.gitignore &&
+	git -C repo reset --hard 2>err &&
+	test_i18ngrep ! "disabling cone patterns" err
+'
+
 test_done
-- 
gitgitgadget

