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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C6F9C433DB
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36F9420798
	for <git@archiver.kernel.org>; Fri,  1 Jan 2021 02:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAACR0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Dec 2020 21:17:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbhAACR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Dec 2020 21:17:26 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D15C061575
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:08 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id 15so23456301oix.8
        for <git@vger.kernel.org>; Thu, 31 Dec 2020 18:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DP6Hw0ZFTejgrZ0RAT8bzZYTx3HwKAFRcJ2Z3OOezik=;
        b=uafKxJpkRaj7HQ17ez7AmOi4NkV2onMqueI6Aj3O0FkDCIa1lnJ3TWE439Aa3xIDjk
         URVlObLQMJnGU6p9fby1XPki/2Q13hH/wWoH5sbBOUoGr6EA9Cb8Gi8wgshJ+S40Z4ac
         N6liSgQcVo8j3nMwxzdM/YlStTGvIfOQVfKOCv53fc+6b5vMoMmWE1RNMlPT6lJZNndq
         1ar1v5AdtiVMa+Z7GtPjKXpIRC6zbkkXrEZl3il9GhwqykXpkGy4blPFyicplBpwQeqY
         v4ojoDQcVcQxknd8d9EH/pttogvV1E61SpFXtXQxCxL277JIpiBYPJLed0fx3VKd+TJS
         7+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DP6Hw0ZFTejgrZ0RAT8bzZYTx3HwKAFRcJ2Z3OOezik=;
        b=TqNIYz8JnLxbXR0aduz3r0W6ym7gamQ8YvQItnJpePwY4OICyWpne83i9jO9DZCB2/
         l4OWlwShIkKWAQUXz2zpkX8/urluxUiiHnIbilgCJr5Mw81D54xgQekTmlia5MD+mx5F
         sD1YJ3IQimayH1nqs5wKRZMf9NhpbZposdqaE+aCTwwuyZ9IHBL6ckRMQ87xNjJAQi1J
         KyxoRixrYNYHq+PIdiC4qZiAaIuqKr4/LsAJjbBtqvLjsqb+2RIogoM60pEIgYc0MTA9
         7OnFLb3+bnfrEKjV2NMzFYrIh5iFzcZARPGjA25/tYdi9MBomFkeOYfslb0/b/GxONnl
         oOlQ==
X-Gm-Message-State: AOAM5323zcFdhPu/+NyVgesCakIaKpeRK5jGmjTVKGGenatqzB3LnDQS
        sT04zbQYegQvjkWVBPl4WhicpUzye9mSjA==
X-Google-Smtp-Source: ABdhPJyTwaGlTdRoUTBgHZ0xiWCFvnMSiLH039r70zCIdHraAUi/3+XTIX76ldvzwZY9J64+nGvDcw==
X-Received: by 2002:a05:6808:8e7:: with SMTP id d7mr9576810oic.127.1609467427485;
        Thu, 31 Dec 2020 18:17:07 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id g5sm11829874otq.43.2020.12.31.18.17.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 18:17:06 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 27/47] test: completion: add missing test
Date:   Thu, 31 Dec 2020 20:16:02 -0600
Message-Id: <20210101021622.798041-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210101021622.798041-1-felipe.contreras@gmail.com>
References: <20210101021622.798041-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Once the correct suffix in __git_complete_config_variable_name() is set,
we can add the test again.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index f6c60c609a..e1a9e9483c 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -2312,6 +2312,13 @@ test_expect_success 'git config - value' '
 	EOF
 '
 
+test_expect_success 'git config - direct completions' '
+	test_completion "git config branch.autoSetup" <<-\EOF
+	branch.autoSetupMerge Z
+	branch.autoSetupRebase Z
+	EOF
+'
+
 test_expect_success 'git -c - section' '
 	test_completion "git -c br" <<-\EOF
 	branch.Z
-- 
2.30.0

