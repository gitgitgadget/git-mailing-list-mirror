Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DCC8C433EF
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245143AbiAFWfF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:35:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245132AbiAFWfD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:03 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7CFC061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:35:03 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id w20so7560395wra.9
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9CufNRd6wkV0nDNdpn89TrmOrdnKkmCHsO22oDBohPI=;
        b=an42X77zQnxho7O3HsR8R3Xnui6pXrrpNQE24QY+zEDkHLwgbeDB3nucko1XgAniuc
         zA+QrE4ZsPpJSVRGJptcPpuIUUOhvgnKUSdIWYp8J6P3esRqS1YW18Q6zzCeXrzaXvm2
         dg5YmaAude892XOOxJSpi57BR3keIYhP+WrY5O/CBnd32zBiSE8GU+kGHNL5OlqidxP/
         yl+lif4wMaEjh3zlgh5X2G57BKSa4gOeWc7ZMJXsnRzw9oREvN+bTFeKeMHH6UDBvTnl
         kK/x5KVXuWpYj5BIcP+M50/M19GFqkxWfqV3WPH0GDh3ehKjm6hghfhrPUzXVsLyCQYm
         R9GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9CufNRd6wkV0nDNdpn89TrmOrdnKkmCHsO22oDBohPI=;
        b=NpOI3kOGy5a7yYYpdL1SyGEIre+/UXmUHT6YuCExIpiy5hMNtWYbMdd91XrPVYOY7k
         iwJpBtibvKztw3ZTJh7BWIrmbhHSOSPaO2++ueD4+eIOV/iZ9ezPwLCANDz6ZsCvKfgm
         JUq4K1cP26e1DgvYvJdZAEzjB0R9Qk3Jpn87M/pJ7+818uTk86UbUwavhxArA3AFCxtt
         ahNqpAcwbcPh0yvsbtSMztPXkjuQVer6kdAImOTM3pmHXUbrKpq+xGqFn8KGZKyLDk3Q
         XbEQ2MpCvEAt8wDbx/ozouHnnoQzR1hln89HIkHLRpOWCuyLKzL51u4nHzq7TWQnksLl
         y+sg==
X-Gm-Message-State: AOAM531bfaCZgOUKP+xp+kQlCulp7sb31xphaHWBGOlHs3AvqjdimP0i
        X8tKD+enKlerr0pt834PPysYPtSkHA4=
X-Google-Smtp-Source: ABdhPJxsFvDoUywWCCdgfYnLzKMG+M3SGqH53lwrQBnOPi/WJo7wj6os4ErqFsRmJ45RkJmY8sIcWQ==
X-Received: by 2002:a5d:55d1:: with SMTP id i17mr5291855wrw.392.1641508501544;
        Thu, 06 Jan 2022 14:35:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm3651314wrd.100.2022.01.06.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:35:01 -0800 (PST)
Message-Id: <d15a23cc8049b1f2f67b089d9edea0ce098065b3.1641508499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 22:34:56 +0000
Subject: [PATCH v3 2/4] t7508: fix bogus mtime verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

The current `grep`-approach in "--no-optional-locks prevents index
update" may fail e.g. for `out` file contents "1234567890999" [1].
Fix this by using test-lib's new mtime-verification API.

[1] https://lore.kernel.org/git/xmqqczl5hpaq.fsf@gitster.g/T/#u

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t7508-status.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 05c6c02435d..b9efd2613d0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1647,13 +1647,11 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 '
 
 test_expect_success '--no-optional-locks prevents index update' '
-	test-tool chmtime =1234567890 .git/index &&
+	test_set_magic_mtime .git/index &&
 	git --no-optional-locks status &&
-	test-tool chmtime --get .git/index >out &&
-	grep ^1234567890 out &&
+	test_is_magic_mtime .git/index &&
 	git status &&
-	test-tool chmtime --get .git/index >out &&
-	! grep ^1234567890 out
+	! test_is_magic_mtime .git/index
 '
 
 test_done
-- 
gitgitgadget

