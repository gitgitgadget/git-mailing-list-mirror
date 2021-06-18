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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22592C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A3E60FF4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbhFRVyw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:54:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234685AbhFRVyv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:54:51 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA9FC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:41 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso11122528otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SUxZ4NqQz+xS27wgan7HdR+ZmVT7uoo7sfzHIMnMOI=;
        b=A/MIf3HkROImDWFV+lJol5Ktwf9Q+hZLOzx7JBrWPAGZnAf7hUidgTeJFQ9kK6I1sP
         DfdqxFs6YsJwkgAhXM9rv6KgqhP0CkV3KtCcTOMkoa1lwe0yexlHsriyPwIVfOi/3g97
         bx74Vw84BVz9dVjrHOUIH2ISYqcZJ8gGcKlGSPTZO3jS8iF5HbFCuRs50jTrC0HZdKoF
         RmEuLtbc6GhuohSLAnxewgnoifNdsLkoar5gdnLQe25Oe/GEqFKDG2Mn6xBCfY20KyUV
         cFVMNWuFJ3hVHNwx6fwoPnq74JkdrIJgaGugx9prdVDDpE9z3e7DgjqMpK4vyjQp7tXi
         cHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SUxZ4NqQz+xS27wgan7HdR+ZmVT7uoo7sfzHIMnMOI=;
        b=gh71o8AjkHoJMH8mYiqWa67aw7U1Zqhp6Y7XDtopR8QHjqZLeP3plPjPslR+T3SY+7
         HjuoEtsAUSThnqob/0tLRyd7AjaZwL2d+FF5OcuuurQBJmSogtpo15lbWFQ3SynUFgpo
         frhi4+dgmXgGnytj2W7lnznWkWDTjs1/OxxPlblkgFMiE80cGOFOwxGqwd003Ps8kA3k
         ImNed5aMIcIOSI9tZB9oKStRQ1klZcO9Kz5wShBAJ9qtrEZOtifn1TaTR50NOhklZJSR
         z2Q76G74456FMOz+VL9r/GJn1rFqe9jU3fZL2iTpqP516SVV8lODCvVk+5XF9GnmMM1E
         MBUA==
X-Gm-Message-State: AOAM533mf6PjQiAlGYbZ1Yho8+xt81uOHE9zAnPa6oS0l4IJcUbg+fpF
        NQtYt+MwKp+q83fiwrYavMb9UHlXVm7MIw==
X-Google-Smtp-Source: ABdhPJz2w6VAsiANmHN0Y3jhztY6FmbdpIssyPvQQpcTNzwltjv8oBy+q46FsogpVg86ZArzoey+xg==
X-Received: by 2002:a05:6830:4b1:: with SMTP id l17mr3788238otd.210.1624053160268;
        Fri, 18 Jun 2021 14:52:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id v203sm2056520oie.52.2021.06.18.14.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:52:39 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 4/4] doc: asciidoc: remove unnecessary attribute
Date:   Fri, 18 Jun 2021 16:52:31 -0500
Message-Id: <20210618215231.796592-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618215231.796592-1-felipe.contreras@gmail.com>
References: <20210618215231.796592-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's part of asciidoc global configuration since 2012.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoc.conf | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/asciidoc.conf b/Documentation/asciidoc.conf
index 60f76f43ed..f7908f9dea 100644
--- a/Documentation/asciidoc.conf
+++ b/Documentation/asciidoc.conf
@@ -12,7 +12,6 @@
 
 [attributes]
 asterisk=&#42;
-plus=&#43;
 caret=&#94;
 startsb=&#91;
 endsb=&#93;
-- 
2.32.0

