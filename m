Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC16C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbiCAEm5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbiCAEmk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:40 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE1C6E373
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:42:00 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id e13-20020a17090301cd00b00150145346f9so5479185plh.23
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mbH986E6sY3FtPk9GutpUyrvu3iKwdHEwD6Ce9zALkA=;
        b=Zmk7y8PURnmN8W5amTzm4AmNcYcfxDgKPKNNQ5eCVgqask0hwwCTq5e+5oZJn40zt7
         d62qmHy8tjEzlJBXmpvY3+4dFgWY4arUsdQn5ZSM4Wiu4I/FiIgmYlewfbmyl5AkRGe6
         F1C7Cx2dML9x2enF5GSv1bWBtFN6Uc05Ypqz/fcNH0YmPrtLPs9OvZIvGshFNkyPWyOR
         7uqOwCPM0vDt6Oxyc7N1V6RwD+yc+unshc6Xp3vLoDQY7uUFBY3Ntt38aeE0MVWlSP2U
         cRgkqW5HZ3zsDYFrgxSJNvNZe9y+2Ly14LQ1JkpUms5DCXZcHe+W0bbrANOp67tj2LP5
         pIcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mbH986E6sY3FtPk9GutpUyrvu3iKwdHEwD6Ce9zALkA=;
        b=S8okSvu0hmepgXlKtOOFEtJbItRAWoknoZgOW33RmQ8YBRAsNOlN+RV7pa71lNhLXj
         6YjOg56Fto29dmlZbhwdMFuO9IhDTvhwUYO/JRxxVvnfRm94TF359Xc/tm6j29r/UA1Y
         v01zr7D4ToOK760f6S5Eur5aeProaldPTEKbWK1fG+tJ00pOY4UyblOY2tXLV5EoyIEg
         cFIByz/AF1BZlcc4+3CQXzfw0FX+Uq+c592l+CRMVGyhrSbHcPP0quBse1dQR1JGRfFX
         SUKIrneXrsMY5R9BnpALtcJBEfbK2mOmb+gG5thb6ekrc8IEJ3hMqqXPj2z4UHtnkfoz
         6fYg==
X-Gm-Message-State: AOAM531de5ODA2efO73L5BKhVIFAxrhfbEOq/8hpGoahQnC7bMZxLxpU
        WnagyM5ZzCCYeU7qd6fWAEnGsMQyDeTmKp/G6FNIsNxwh9xar0Bw8nw9GH89BZ4Zpfn5l4V5YNU
        xjGyYeufAUmq4uvBYWuQfJZGJpS8LTVfkEwSokf1OHiwc4M9DKNjediMEDlMb6JM=
X-Google-Smtp-Source: ABdhPJyGqKEnLJL6L5Rclf731SollOqQuptxnHfPG3p+NxQiTN03JM1UA3MG7RN4Xsq3iUo1DpjjoE48g8DOEA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e541:b0:151:8722:5a87 with SMTP
 id n1-20020a170902e54100b0015187225a87mr86490plf.71.1646109720084; Mon, 28
 Feb 2022 20:42:00 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:31 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-13-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 12/13] submodule update: add tests for --filter
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test the "--filter" option to make sure we don't break anything while
refactoring "git submodule update".

Signed-off-by: Glen Choo <chooglen@google.com>
---
 t/t7406-submodule-update.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 7764c1c3cb..6cc60ff5e5 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -1071,4 +1071,17 @@ test_expect_success 'submodule update --quiet passes quietness to fetch with a s
 	)
 '
 
+test_expect_success 'submodule update --filter requires --init' '
+	test_must_fail git -C super submodule update --filter blob:none 2>err &&
+	grep "usage:" err
+'
+
+test_expect_success 'submodule update --filter sets partial clone settings' '
+	test_when_finished "rm -rf super-filter" &&
+	git clone cloned super-filter &&
+	git -C super-filter submodule update --init --filter blob:none &&
+	test_cmp_config -C super-filter/submodule true remote.origin.promisor &&
+	test_cmp_config -C super-filter/submodule blob:none remote.origin.partialclonefilter
+'
+
 test_done
-- 
2.33.GIT

