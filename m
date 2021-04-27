Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4AC433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:40:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC2E61168
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235613AbhD0Kkq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238482AbhD0KjT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:19 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84ED6C061756
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:36 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so6585365wmh.0
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lrfJTjST1EpqU9jSSQBOMP4Vy8yAsknMgVSKzJ8+zl8=;
        b=chGNvCLuiCQFbr7vYkPlPUO0qMdjZzLyJi0VKkC8kzgdRyniUgUetBk/Nt1wjaBs8z
         uKghiRwmeK32nuIwD/UhWV07LzcBIb+uXLF5Ko9pRZ6ja4MEH7J/kfASBdEFvtQah9hV
         p3OwV9n1UZEo1ddKKl7/2X4e/cyeMvYP84kKi8KLaIhC7L5Nl+oRKU5RfawQZPxfYGjG
         RBXd7J08KRZPxhehbx9YNSay6tA8bqFWIgWHLS5RV8sMa13vpr91xeghfD0sk9sKePlS
         iOhLEh8qx42v1tok0EqCptWfyJjyapUcJx4oz3bmeYhYxiKfvo5EYT70pVGWBjSYVLO8
         9EhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lrfJTjST1EpqU9jSSQBOMP4Vy8yAsknMgVSKzJ8+zl8=;
        b=QZJ9RFvqvUSJnwid+yNfMoteBkWM5p7G3qbshka7Xk9eCbON+BdwP3YonlACfabOdP
         2Tug53uPsLwOnZxV8Ae66lhd828n9gk3HEyHygKmZFgE3YtCJUUZZdf4Nh9LqoGi6v8V
         ly/O+oxcjS1Cx6IHqkWy5J1Y0UFbkZKUXfP1aFee2NTFwd0NVN6L1MqOJRHT6oRZyN6r
         56615Sn09mOvuurFtkkwmIEojBleuDN+m2Hw9AWgwlM7Gdvky6NIecOMhgYLrL09LIeZ
         6g8ZLPhKkuaLfzX9yX3GRmgK3tOurKAvMsWTwmV1AVBgqUfNjEXW1zvFpO9MT9of61uK
         o7wg==
X-Gm-Message-State: AOAM532zP20EpLjG9KDqjT/XqQSL7jV9SaWCOkaFl2pZ3qxDYRt0vC08
        OTrxPwRBrvzewhUxBCs3agM7j8l5RT4=
X-Google-Smtp-Source: ABdhPJxk0E1TbEfJUtODZp0qD7rNmwwoOzVnmRRY3I0SRGQi9o/Y35jVJJBQHE2FyTV6XgXGg2LgQw==
X-Received: by 2002:a05:600c:3544:: with SMTP id i4mr23544907wmq.38.1619519915398;
        Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm3412589wrn.87.2021.04.27.03.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:35 -0700 (PDT)
Message-Id: <a33cdfda74ff55fbc8242d3486e1fd5a26ad4c00.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:21 +0000
Subject: [PATCH v2 20/21] t4202: mark bogus head hash test with REFFILES
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

In reftable, hashes are correctly formed by design

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t4202-log.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index a8c5a00d012d..3f969b01508c 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,7 +1834,7 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD hash' '
+test_expect_success REFFILES 'log diagnoses bogus HEAD hash' '
 	git init empty &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
-- 
gitgitgadget

