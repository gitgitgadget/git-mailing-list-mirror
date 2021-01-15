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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49C8C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:29:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98AF623AF8
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 03:29:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732487AbhAOD3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 22:29:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732483AbhAOD3J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 22:29:09 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDFFC061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 19:28:29 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id z11so10524871qkj.7
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 19:28:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kacyy0irydM+vFc1t7niwfdEFwnHzyN6cTYrYBoKSvw=;
        b=KoJbkOjg9HWHuzHYyjHFwvwdkcbLlep29gGNaML8eD3KmrhwFp0uD23zQxArRhOY/u
         0iBrII/+Atk8p1qj8NErqrvE8lcKAP1ScWumSCnI+xFJO+QTR0tAv98kB75EYD/uqcbr
         Bh+hdLIupFaInBYaqeAONT6GUOEpRwpOmizd7uHwMChIMSlqysIgZdQdX+L1ATiO5Wr3
         8YWZT/FHgbcDkuFLYGbTMwJHm+uxlD2Cguv9jQzvP2hgsWCQvmhhfqfA9AhbTVVXftzT
         4mhNg+CazhgWQ+6EtthvYn1K3AoaX3m4I3+B3J16HvM9Qmd0PxuDCftRMsFVx7oIGrJ0
         Z8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kacyy0irydM+vFc1t7niwfdEFwnHzyN6cTYrYBoKSvw=;
        b=KOjrjWKrTCh1ccESD0iMMyhx240ONNSaD4ZziHXhND3HbR8M0NXVWU+vbmvnhhNoTo
         jrVV13T13ZS8gzIItzcsConnQiCy/Wz7LJW0Z1jSDfAIPx2+Dol1Pqj8GtYzKdOjYhql
         nIxVd8gV3x86jEkj1+T72UE/gZ2JnGDIcN8RWot9OsZVOC3Ap9svDeVgg+967B/LYuPB
         D3KgVZphR2FQ7++kTccPycS4z/8pL0Ix8ejunY3YsmbrUp5anoSX2cms/AeE/yShvMuY
         zQzztJuMY15YEamURZUmWzoAmjN5eey/uF8R18iY/xBd8VkZbZEHhsMPnMeAvFcZGlSa
         +mhQ==
X-Gm-Message-State: AOAM532C4bQxz+JTfLVWChbfYTfBwcSjhkliFfp8ntUpA0zhoXdwqRwe
        5FIL04jsIcUnze/A1zVbgJ/YD9Q6N4nrkg==
X-Google-Smtp-Source: ABdhPJxxONvw+hRmSIPEdtgu4kx8fkokx0PFWxSOMq7OlpiQCmmtfkEXlwMGb90crnv4j+YjJ09i2Q==
X-Received: by 2002:a05:620a:1f9:: with SMTP id x25mr10176710qkn.456.1610681308250;
        Thu, 14 Jan 2021 19:28:28 -0800 (PST)
Received: from localhost.localdomain ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id w127sm4205545qkb.133.2021.01.14.19.28.26
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jan 2021 19:28:27 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2] mailmap doc: use correct environment variable 'GIT_WORK_TREE'
Date:   Thu, 14 Jan 2021 22:28:25 -0500
Message-Id: <20210115032826.51369-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210115023416.45011-1-levraiphilippeblain@gmail.com>
References: <20210115023416.45011-1-levraiphilippeblain@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gitmailmap(5) uses 'GIT_WORK_DIR' to refer to the root of the
repository, but this environment variable does not exist.

Use the correct spelling for that variable, 'GIT_WORK_TREE'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/gitmailmap.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/gitmailmap.txt b/Documentation/gitmailmap.txt
index 7f1089786d..052209b33b 100644
--- a/Documentation/gitmailmap.txt
+++ b/Documentation/gitmailmap.txt
@@ -7,7 +7,7 @@ gitmailmap - Map author/committer names and/or E-Mail addresses
 
 SYNOPSIS
 --------
-$GIT_WORK_DIR/.mailmap
+$GIT_WORK_TREE/.mailmap
 
 
 DESCRIPTION

base-commit: 4e168333a8716d902aed10c74ae5e408e683f902
-- 
2.29.2

