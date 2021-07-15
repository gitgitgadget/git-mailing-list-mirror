Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955F4C47E4E
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82FFB61374
	for <git@archiver.kernel.org>; Thu, 15 Jul 2021 15:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239311AbhGOPnf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jul 2021 11:43:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239236AbhGOPnb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jul 2021 11:43:31 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F37C0613DD
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id w13so3997066wmc.3
        for <git@vger.kernel.org>; Thu, 15 Jul 2021 08:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=vDUW5T6QowNzFcHGDbDhPT33dJUP21r5QqIEWNcSBJ8KBNj9KxYM8P/6jDTeqeUgwq
         hbNq04lJx5DoX/GTwgc+mdo704nfq2Ovan1wUa3FDxQ7SiqnmeYlQlZP40wvlEyF4D0X
         VWOURjbQv6/NwIuUHKWJOLLZ9a9Y68YbPaQStvrPiO/DNcJ4E9gZLKQaPVsqEkRQ7XwF
         TprZxFpChWnM4UPryNo3PR0E5aU8jfYipNuPuwSGV4141pfxmI5ZtHHi9zdbdnUyQXzK
         ZmRpBNEsHvAgbZOOh8QHOJ6sPwbPQKvQtjxk4Pqv4kZT7hEEhgva0J5iy62f937Q9k4L
         TyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9N06sBMGSwslqzktoVL9OhM7KzXq4rCuo4jo7obxQWo=;
        b=nNMdP1OYMZbMH+TD+oyZXmvRfwUaOymC5XCZtCNFe9UJB4JCN2mjmblThUyp0TkzE2
         BH1LjMgv7E/i2m5RirtzGDtdDta/yrZJX0a02U165AVJmN9tE2uHulg3a/TP4YOjeAj0
         +wE/JYaFSTfMlviqTI5qBTnFsTb9kcjFBn842buOEtEPGagcj54K5IwTnjjxoC9aUoWR
         dhsNgILss2Ar8c1lHhuN3cS9AeA+5kADQ8hcuxaX38RXoPXWh6LOSDAeVC3GlPAETjQA
         Q5iFqOMrxZjXf8GtjcTiKo4Q+PMaH5WElj2bjXE+AWgWSg0xzrlNfKmYCypNHWDVGQNu
         jXmg==
X-Gm-Message-State: AOAM533995pTRN0whXPzwB40k8Vglb99ArrCKI3gRF75mlpHeNhGuuuR
        CRbYVLVyAkmatIdJmvsd1AqfxTXbxn4=
X-Google-Smtp-Source: ABdhPJyA/pAKfh/ooDH7FbyP+6QY//BV5JDsYdFB8eNf6W7jQsIRiPlXHkg4Lsb0vgjY6XK332UIjw==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr5454494wmr.23.1626363635619;
        Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f130sm6649377wmf.23.2021.07.15.08.40.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 08:40:35 -0700 (PDT)
Message-Id: <ae3a7816013fbe1568e0bddff211b43ae41625bf.1626363626.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
References: <pull.993.git.1626090419.gitgitgadget@gmail.com>
        <pull.993.v2.git.1626363626.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 15 Jul 2021 15:40:20 +0000
Subject: [PATCH v2 12/17] [GSOC] cat-file: create p1006-cat-file.sh
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Philip Oakley <philipoakley@iee.email>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Create p1006-cat-file.sh to provide performance testing for
`git cat-file --batch` and `git cat-file --batch-check`. This
will help us compare the performance changes after we let
cat-file reuse the ref-filter logic.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 t/perf/p1006-cat-file.sh | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100755 t/perf/p1006-cat-file.sh

diff --git a/t/perf/p1006-cat-file.sh b/t/perf/p1006-cat-file.sh
new file mode 100755
index 00000000000..b84ac31f9cc
--- /dev/null
+++ b/t/perf/p1006-cat-file.sh
@@ -0,0 +1,28 @@
+#!/bin/sh
+
+test_description='Basic sort performance tests'
+. ./perf-lib.sh
+
+test_perf_default_repo
+
+test_expect_success 'setup' '
+	git rev-list --all >rla
+'
+
+test_perf 'cat-file --batch-check' '
+	git cat-file --batch-check <rla
+'
+
+test_perf 'cat-file --batch-check with atoms' '
+	git cat-file --batch-check="%(objectname) %(objecttype)" <rla
+'
+
+test_perf 'cat-file --batch' '
+	git cat-file --batch <rla
+'
+
+test_perf 'cat-file --batch with atoms' '
+	git cat-file --batch="%(objectname) %(objecttype)" <rla
+'
+
+test_done
-- 
gitgitgadget

