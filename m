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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE873C2B9F8
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B625C61404
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231326AbhEYKty (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:49:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhEYKtl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:41 -0400
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A21DAC06138A
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:10 -0700 (PDT)
Received: by mail-oi1-x229.google.com with SMTP id s19so29834043oic.7
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=L/P3GbnSpAi4jwHpDCRO08gI9/rsuAByW+B+eYDPeMY=;
        b=d8QbuSnc80dHiyvVqyVqW1ZCvs2LdweWTbUTd2vsfRNHRPiNsbhdKflT6uCmwxxnii
         rmJeBVh2B9yHfBv3YUDza23Q8jFZVOyJK7gCPPjwmk9wSoA/8qKqRWIqAo/4+DdBJ3sk
         9vl3TJp+PT+zrBzHOTGhRzDCl8vJnkqAiTm333kO3WD9O10c9QFXKZH45nCndNaBPdUh
         Ra00oIVuwyHK843izR/VV4f+s/I8G8z9YiAdOWm2iJoN8lCDYFfmMrQDb4BMhuDWD2+b
         MxVAOO0asrOOja/czAD10PB7vY7sIJ930nCnnkpnEy/528el1daQlYk+e1+Zcirz0uEW
         J7tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=L/P3GbnSpAi4jwHpDCRO08gI9/rsuAByW+B+eYDPeMY=;
        b=TUsQd63TLzcOtPV3bHNQ3B/ceTCzSkLilXdyp3v/O/stYDmkjM/vUqfDuDwLxcm6ix
         pokig9o38mOc0IL6HUBpfvjwQbRSw4kHDnDEDBjovGhzZUdzZynkhmRoPvn5eGrjsegR
         5U+2l5jQD1Jxer4eSzU2OI8hWq18o+JJ7pFNxZvXHrb0ZOxYSFK6Os5YCLftXiOo1/Kq
         YQthhaLf7afYE9A9h66r27aIfp4bjLwAVppLLs29NaL21dJ60dFL7k1xfoESITgvyDVr
         dsXMGhHFWw7AcdkREeDUHKpocCGboZMjqkzGw29GZVCO0YPhuoRBUeX1kq6GpgvGsbOc
         ePlQ==
X-Gm-Message-State: AOAM531hyaNR1S2U45/voH+atFwok9UVQHq6XLH0Vg0HiyUBXMhK9LCI
        7oGW+r6TnnL9U/ASZUWtAdmdbBngBMC1fg==
X-Google-Smtp-Source: ABdhPJzCnZBF0k+VYyl47P4RsYZ958OCpC6IrG2hoFmWq7MEjywkfGAtGAEbdaht4ZEH+gcG/qteVA==
X-Received: by 2002:aca:35c5:: with SMTP id c188mr2362982oia.27.1621939689859;
        Tue, 25 May 2021 03:48:09 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id a14sm3616832otl.52.2021.05.25.03.48.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:09 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 04/12] doc: asciidoc: remove unnecessary attribute
Date:   Tue, 25 May 2021 05:47:54 -0500
Message-Id: <20210525104802.158336-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
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
2.32.0.rc0

