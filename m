Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9D37C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 16:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356537AbhKYQNY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 11:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356372AbhKYQMq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 11:12:46 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BCF8C061399
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:57 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l16so12613177wrp.11
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 07:57:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ItUp8M/atyI9K4rx4P6QdD53E0D10J9MuhiA1jbk01M=;
        b=LbYrufGVQUI7xnfQ6n2ssKUHqu81SYSAijrUIRDmD3OBNYKbyTmp5SY4KwOrDCoUzJ
         1BHi5Ebf42ulYhVZbYcLdNbHI09fu9c+iMkg+sCnWvnznDmONUusMPgd2klAPN7yZ47g
         IGEgc1GpqA3B8QD56KwCVejmeRmmQGoD2kJ5FNeeEzC7ACcwcmcGUsfJ2KOPkM4+scKS
         oMzjCPWEne2ciAOO7tvxcyE6jJnt/77oujsnZGGldl8U0CnotGZgL60OE3Z2af4Wwd11
         0GgDz6YUXLNHtSrxSaD+8xB2wnah+IF4e74gCf/WLBPTCl3yZy42PbxyN0xW4PFWmWeg
         JlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ItUp8M/atyI9K4rx4P6QdD53E0D10J9MuhiA1jbk01M=;
        b=WxXP070VHUpR+Zd/umXu2biotIVWQE7r3B+MLTDw+G7VdhkwU0l8xrHE/uWDk3fH9H
         SCLY3CTGeK65BZrmUWw7RtdczvhCQxiGTJKZFoYIv6WjRobwKyzMCb0Q1N9l8cXFX8Qd
         V4TK2URXM+WpJOvMv/BdMBa9iH7nYXv0eBW7x4LJ1rhdz0ZjZA+UQ0iooLDTGNMHqXpf
         JRQ+yOUrFPRYAh0cVy+Gqhi7s2l+qHSZvg8ldKSdobxETiYUU311MJOKQVMk/q9Z+Zvy
         AuVKYuNZVm8tIoUklO7FHd/wfLyGoaA21Xa8TDDxqj9ZIWl95VGt/wSSb/5SoF8B8WUl
         +PoA==
X-Gm-Message-State: AOAM531Z553p41aK/9qGBbYFEAzssY/wE22zIOUuurtbyqZosv3jUkSv
        27H4ZKwE9EYOZOGbX+fmD0tsiovWABQ=
X-Google-Smtp-Source: ABdhPJw9OpWShM6Q8b39MGmAM5C6Hq6wyyMJ+gOFCkhfRFFe1WjxXhrIYm4niHUC+diGBOMWYcFQ+Q==
X-Received: by 2002:a5d:4cd1:: with SMTP id c17mr7617906wrt.31.1637855875758;
        Thu, 25 Nov 2021 07:57:55 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v6sm8226830wmh.8.2021.11.25.07.57.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 07:57:55 -0800 (PST)
Message-Id: <0319503045ba8ab93eb09434ed4bada0050c5f8a.1637855872.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <pull.1145.v2.git.git.1637855872.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 15:57:50 +0000
Subject: [PATCH v2 3/5] t1405: check for_each_reflog_ent_reverse() more
 thoroughly
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If we are checking for a certain ordering, we should check that there are two
entries. Do this by mirroring the preceding test.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1405-main-ref-store.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/t1405-main-ref-store.sh b/t/t1405-main-ref-store.sh
index a600bedf2cd..76b15458409 100755
--- a/t/t1405-main-ref-store.sh
+++ b/t/t1405-main-ref-store.sh
@@ -94,6 +94,7 @@ test_expect_success 'for_each_reflog_ent()' '
 
 test_expect_success 'for_each_reflog_ent_reverse()' '
 	$RUN for-each-reflog-ent-reverse HEAD >actual &&
+	head -n1 actual | grep recreate-main &&
 	tail -n1 actual | grep one
 '
 
-- 
gitgitgadget

