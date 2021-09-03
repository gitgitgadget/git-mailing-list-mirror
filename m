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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2508AC433F5
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:59:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 052E7610A1
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 11:59:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348653AbhICMAL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 08:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbhICMAL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 08:00:11 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B035C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 04:59:11 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id j16so3384568pfc.2
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keX9OKHJRp9sFEHyvNaTZ4DrfGUgK2mF958rkX9iDfI=;
        b=Nwv7kx+YphnOlHqff4lHrZGCwehQ8C5Ypa4Bd6ROf/A79scKqmtxUGipFvnkqesguA
         h2movzKKD5cXXqxBN5CqX0NPzMwSshuzDaWRxcxGsPBUCeQr1FMarvhLfezk3E/CptOb
         NMutF1B/qdfvZZS70s7mM6nV1S5Vh61ZJD8aNkJrX+2fnkKGH6aA9TnIPkFffYmJRYU4
         t6M6g+mqGl4xJMf0SBg4xOEOobC8mDBYKwLqaneH8MbjC2QgM37H0SOlFviaA9qagLow
         KXuNPOhY6CYLwF1nmSvGGvwwRTvAr+s/nC4Cn0ntQxCaT+nAKndaeE/yxRa65v7qySXD
         IGYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=keX9OKHJRp9sFEHyvNaTZ4DrfGUgK2mF958rkX9iDfI=;
        b=OywGzqZqrQm0LgOl5F56asY9DW8lzCdbXZcUd56ZPaaz9NWL7YahWYZmxBE9ZOoRNe
         ZeLesuGqRZAdPUHkNV4Ku35rp5n6nlMED6m+f9onRdujZ8pa7Vydm6QMrfvpe6k377bf
         Qi9tAqzCx3F1YtDN4bzTZyTxf66wYrKNhRSUPoZUxgRsNvR2+Pmd+aUA+dO2Ksye8DxW
         A10lZ0mzJKJpoWOa2qDjR5HTyVTHoo03xNAcgOTfABpaRkVRnw+wLoJFTqhXf2bvwRaf
         sJJUmITkNOiJ2HrWVQeyr2BJV7k9K5oWIpI8JIwgPTBQld9f6Nc0GokWfp3TbcaKvXG+
         tLhw==
X-Gm-Message-State: AOAM5334HCdVHiySW6chmsOKO30kJFAXOFCpttbGSgtzfKQQeARDHLuI
        v5rFchL66ym3i2R2089GKjDB7ZF36xRgJATX
X-Google-Smtp-Source: ABdhPJzAT6PV37ScshqFVHSrstBZKkrfXo77/DfRbBGhxnPyr5YkoCUw03ATuT2dwBKkGDxS4F2DOw==
X-Received: by 2002:a63:1d23:: with SMTP id d35mr3248901pgd.357.1630670350399;
        Fri, 03 Sep 2021 04:59:10 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-82.three.co.id. [180.214.232.82])
        by smtp.gmail.com with ESMTPSA id g2sm5173916pfr.35.2021.09.03.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Sep 2021 04:59:10 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] bugreport: Add hint to answer questionnaire in English
Date:   Fri,  3 Sep 2021 18:58:24 +0700
Message-Id: <20210903115823.622715-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Depending on system locale, git bugreport may launch the localized
bug report questionnaire (and thus users respond it in their native
language). However, many Git support forums (including
git@vger.kernel.org) expects bug reports written in English.

Add a hint that answering the questionnaire in English will increase
chances for bug reports to be responded.

Fixes: 238b439d69 (bugreport: add tool to generate debugging info,
2020-04-16)

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 In [1], Junio suggests to add hint for filling in bug report answers
 in English. That stems from my responses to Krzysztof Żelechowski's bug
 report [2], which advise him to re-submit the report in English.

 [1]: https://lore.kernel.org/git/xmqqeeaiodxc.fsf@gitster.g/
 [2]:
https://lore.kernel.org/git/22496693-cf63-a278-c85e-d9e4376e2a59@gmail.com/

 builtin/bugreport.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 9915a5841d..56ccd0fc41 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -96,6 +96,7 @@ static int get_bug_template(struct strbuf *template)
 	const char template_text[] = N_(
 "Thank you for filling out a Git bug report!\n"
 "Please answer the following questions to help us understand your issue.\n"
+"Answering in English will give a better chance for your issue to be responded.\n"
 "\n"
 "What did you do before the bug happened? (Steps to reproduce your issue)\n"
 "\n"

base-commit: 6c40894d2466d4e7fddc047a05116aa9d14712ee
-- 
2.25.1

