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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87999C433DB
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44FF32339E
	for <git@archiver.kernel.org>; Fri, 15 Jan 2021 02:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732220AbhAOCfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 21:35:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732216AbhAOCe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 21:34:59 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE119C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:34:19 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id h4so10461903qkk.4
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 18:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uZv3mpVixvK/x5bhIqtzJQM0yoUUVNT6KaEadIKFoZQ=;
        b=iO+0O5HUGt5vSXoZUgdvQVLDuBz5kTaMdtbSVBCF86x/tXpxlOuYx7oX8A8onU5Spl
         dfU55Op0eTTfPHIYOXI5uFLe2AGwJBytZWDw/TA7N119QH7v/6aCtV+1vq9gZ4TRHDxG
         Vhq4qf7VAed/F0lkggf96QXovqsHaSliLgflpKFiz3glaouKLBtQpjLsPQ1ixOrdI0vG
         qewAXFbtVJ4QKsH9SHLNjGkHITw33+gmi4vU7qgPUdTGjl4a1+cNMLTXw5+LFV+pjgMm
         IwROvhzISZQdYJ2DrwKYa0j4q/nt6l9TV3TYkFpEy8a6VDjyuIwvVDyYn0ckKHrNGiCc
         lSKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uZv3mpVixvK/x5bhIqtzJQM0yoUUVNT6KaEadIKFoZQ=;
        b=cPbo90EXI4U6w9YRP8k1wSGIfxO0e/jofQ0Hl0+/NwjfE1l8BeYVe7pbnVsFGdRixv
         1mGnrgE2I9+2FRsZp5RVfGXnyc4zytTjPIG5c+ct2W94VRRMbtFuXQTE6vdZDubiZHk/
         3JbA6Jc/d9AafCeta4dcY5nzWP4bymEcqkwak5FnFYy9QyHaUJ104tMdx+oC1MgFpSd+
         83amXcIeub8bztKLORCWbjsRRzFlASibmlV5F2EtEKinEfuN9LySsOFFflR4z3p6tqhr
         fIfpmfnAYV2Q4dnHS1FL+1UTaZBvdB13gSwsSJVUmk0Blby8LqBBb2gN2faFEsXgSHXh
         tPMg==
X-Gm-Message-State: AOAM531WcgjdQ2H45/4MiaLXGeB0+w+am6HfNJ+dlSN4xbhSFcNR1ymU
        i+mbG+bvPElFjsMsZwyoHeRvPMr6q67reA==
X-Google-Smtp-Source: ABdhPJyHdapBGGniOlYaOzrQ7CJYyHX6EdEAf8XJhmiHBTXHRYbj1GsvJc8OO082QC8IZ7MwORiNMQ==
X-Received: by 2002:a37:a312:: with SMTP id m18mr10387151qke.268.1610678058776;
        Thu, 14 Jan 2021 18:34:18 -0800 (PST)
Received: from localhost.localdomain ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id q73sm4210878qke.16.2021.01.14.18.34.17
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 14 Jan 2021 18:34:18 -0800 (PST)
From:   Philippe Blain <levraiphilippeblain@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH] fixup! mailmap doc: create a new "gitmailmap(5)" man page
Date:   Thu, 14 Jan 2021 21:34:16 -0500
Message-Id: <20210115023416.45011-1-levraiphilippeblain@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112201806.13284-2-avarab@gmail.com>
References: <20210112201806.13284-2-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

