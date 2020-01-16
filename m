Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C29DC33CB6
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CD252073A
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 20:22:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jchBLFw1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387729AbgAPUWE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 15:22:04 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40552 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387660AbgAPUWA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 15:22:00 -0500
Received: by mail-wm1-f68.google.com with SMTP id t14so5170482wmi.5
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 12:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=x6ZYiMuLOJXS7EFdCKiKJtbl0bS34JMWuTxQw0T4W/k=;
        b=jchBLFw18n9uTn+10tireQzvh6XSSqhoy7jmttYWmUt6xzzFFCea/z5FZVQcuS9hYk
         8yYRFBVlZP8j4brEtxP6w7PmY5GRN9lrEa1m6UMYB/DGSiBoZZ0cGqjvTXD3I2XPlK/+
         rvWaPoGKRIuuuKNs6T9ozo1KStGPq5/egDqZkO58WqUl5eKubtHHZhJ1WDWyxBNPu/zH
         0hSUZmilvkbMeBumfjfVlsNWtfvjV3NYgm80C/wUVMjS9adX532hLvMJ1faxtkla/cNM
         TiUgTEr1CTZtvy9mV8wQlsW+2jtqeP+4MTqLtgT4cjbhcHs2yXJnX4gLxVZSNVjs1yCJ
         0p6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=x6ZYiMuLOJXS7EFdCKiKJtbl0bS34JMWuTxQw0T4W/k=;
        b=uOyC47uGdgbX765yOWNzhB+wJ43jlJSFsxuXi+jKqZ9x37znx6PivxCFGv2wrsL5BB
         ByLNr26/nWuMqdPlG2iYc8rwqml2oTuNdz2TXsiO4C67D2n/rD4AdfXMjOAyEXPOzRHq
         FfnT5+eGuACmuxd2vpPcwYNUnlVx00JGz+1KcKVMgX46pKeqfaJOSeu3OBPbMzoNYa+Q
         DDOqmyjriJsgmgg+7KbHVdHDMQinzwjAGRz8Vrgc5gQIZvVygPuuWofF8qJ7gxme7doK
         qN9gLHEYakb8LrRBn7F7F48X7FdNODh+zIGLCtG5HYcYcxFda5n/CM8UP6ny3QgwLp52
         qxyA==
X-Gm-Message-State: APjAAAWKZSbAubLlr+TFf1H9VkkoY8ZC/HqZoMefC5VAjPfFvSdKP7q5
        Agircs8xOIrvOWoNRgRoUKmda6Lf
X-Google-Smtp-Source: APXvYqxKH9ooJEMjQp6aX+JLADK6Dt28W8Ior3ZJW8S4qapT/gmp14pj1UO/cbuol+qjKX6ukkYVxQ==
X-Received: by 2002:a7b:c00c:: with SMTP id c12mr822539wmb.174.1579206118466;
        Thu, 16 Jan 2020 12:21:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c9sm5854311wmc.47.2020.01.16.12.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 12:21:58 -0800 (PST)
Message-Id: <9efed585ef7a1c09ed62998882236e7dbb58383a.1579206117.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
References: <pull.692.v2.git.git.1579098078501.gitgitgadget@gmail.com>
        <pull.692.v3.git.git.1579206117.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 20:21:53 +0000
Subject: [PATCH v3 1/4] clean: demonstrate a bug with pathspecs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <dstolee@microsoft.com>,
        Kevin.Willford@microsoft.com, Kyle Meyer <kyle@kyleam.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

b9670c1f5e (dir: fix checks on common prefix directory, 2019-12-19)
modified the way pathspecs are handled when handling a directory
during "git clean -f <path>". While this improved the behavior for
known test breakages, it also regressed in how the clean command
handles cleaning a specified file.

Add a test case that demonstrates this behavior. This test passes
before b9670c1f5e then fails after.

Helped-by: Kevin Willford <Kevin.Willford@microsoft.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Reviewed-by: Elijah Newren <newren@gmail.com>
---
 t/t7300-clean.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7300-clean.sh b/t/t7300-clean.sh
index 6e6d24c1c3..782e125c89 100755
--- a/t/t7300-clean.sh
+++ b/t/t7300-clean.sh
@@ -737,4 +737,13 @@ test_expect_success MINGW 'handle clean & core.longpaths = false nicely' '
 	test_i18ngrep "too long" .git/err
 '
 
+test_expect_failure 'clean untracked paths by pathspec' '
+	git init untracked &&
+	mkdir untracked/dir &&
+	echo >untracked/dir/file.txt &&
+	git -C untracked clean -f dir/file.txt &&
+	ls untracked/dir >actual &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

