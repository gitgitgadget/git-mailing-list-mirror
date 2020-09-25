Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF69CC4727C
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A0120936
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 14:28:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3xJNELJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728984AbgIYO2s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 10:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728974AbgIYO2p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 10:28:45 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B09C0613CE
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id e2so3537337wme.1
        for <git@vger.kernel.org>; Fri, 25 Sep 2020 07:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QPGEktvBa4u524d4A0i6OsR419ivIXg6j+KJkoHFQyE=;
        b=M3xJNELJBCVHJ/my4Oo87IBBomMXKllMBpN+aDLRvUopdk2bbkBEHQC70Jw0qV8lDP
         FQAElxwgy6X96WXH9tryE9FI1g0SrFMUq6MNRZXaASO8Q5d89VskiP9qHhnNKgnOecF6
         eXz5lrFwne5AM2bGvY8TED4xhUIjT+Vi6RE9OG6WchnvvrnElTdvnd74g9/jZurV54Wf
         abKeImpfhmLHrQ+r9sBIe57XGlY8LTT0DD/qS9Oubxr7pxYWIFvNevw3JlSjS5USjk5g
         rEu4jFIFUKnufG7p6t6j8rB1J4/cWYE+tOqML34HQbF87HBCCR8w9LOsQhFw8HJQp4Sn
         tLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QPGEktvBa4u524d4A0i6OsR419ivIXg6j+KJkoHFQyE=;
        b=KrXrajq4ZdyTBhdoCKsf01p2pXtCgA4KHtdtW6Kjwi3f5GOWcV4KXACopuWQL1Nct7
         gNghKgoq2/aoX/HOXtW2yIDEgLlxoUunbMOcs9bbbCFCPF4WYUxUH8pw/KU/WRM60Buh
         mkcXwB+g0ivNV2ecpaxdnyU1uosVusc5A4d2MX+tFIkvAo8sfN49a8vcMWjsTXQxqwfQ
         u+1GyeiWZ4fEocF461rpee6ZCyOuLnedL5Ifm8jEB4d8B/+PdbKr8nOcsNOKZq7tJF8n
         Xl8TqhkNPlAB0rqRerQePR/yowQrrnnTTMda6rVIqmL84DY/eB0SjDmWnCAdiL7JYRXY
         Hp1Q==
X-Gm-Message-State: AOAM531YPZjqvULU5gis/zK8WH7BiPvmWsGh32TB89KvRTNWAPW08Mmj
        zOBAwW8gnKZ2g93jEwfHChc0RL5gHKc=
X-Google-Smtp-Source: ABdhPJyFGL5GOEeQ8qJ5W3t++eOXPWQ22GqaniotGjls9MaDfTtthsmhHialBdHa9RnUgnZqL2uL1w==
X-Received: by 2002:a1c:bdd4:: with SMTP id n203mr3419114wmf.119.1601044123473;
        Fri, 25 Sep 2020 07:28:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q20sm3048591wmj.5.2020.09.25.07.28.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 07:28:43 -0700 (PDT)
Message-Id: <efc93f1dd972614d197b919e17693a910e568736.1601044118.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.738.git.1601044118.gitgitgadget@gmail.com>
References: <pull.738.git.1601044118.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 25 Sep 2020 14:28:32 +0000
Subject: [PATCH 04/10] cmake: fall back to using `vcpkg`'s `msgfmt.exe` on
 Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?Q?=C4=90o=C3=A0n_Tr=E1=BA=A7n_C=C3=B4ng?= Danh 
        <congdanhqx@gmail.com>,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We are already relying on `vcpkg` to manage our dependencies, including
`libiconv`. Let's also use the `msgfmt.exe` from there.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 contrib/buildsystems/CMakeLists.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/CMakeLists.txt b/contrib/buildsystems/CMakeLists.txt
index 16014ac4f7..acb197fba5 100644
--- a/contrib/buildsystems/CMakeLists.txt
+++ b/contrib/buildsystems/CMakeLists.txt
@@ -155,7 +155,11 @@ endif()
 
 find_program(MSGFMT_EXE msgfmt)
 if(NOT MSGFMT_EXE)
-	message(WARNING "Text Translations won't be build")
+	set(MSGFMT_EXE ${CMAKE_SOURCE_DIR}/compat/vcbuild/vcpkg/downloads/tools/msys2/msys64/usr/bin/msgfmt.exe)
+	if(NOT EXISTS ${MSGFMT_EXE})
+		message(WARNING "Text Translations won't be build")
+		unset(MSGFMT_EXE)
+	endif()
 endif()
 
 #Force all visual studio outputs to CMAKE_BINARY_DIR
-- 
gitgitgadget

