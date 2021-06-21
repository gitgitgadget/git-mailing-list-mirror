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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76CF8C48BE5
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61E4E60FE3
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232799AbhFURBF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232296AbhFURAx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:00:53 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C83C0219B7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:28 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t40so20515350oiw.8
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0SUxZ4NqQz+xS27wgan7HdR+ZmVT7uoo7sfzHIMnMOI=;
        b=oFIbVYwMV0jyeJ9jT8j+wO8e16BzROu9brNojMRyzdAL5gBgJv4Vs9uuugFIvH++Re
         kzn8sZ1iMcO+WYy8ZU/x9FOKyR9/q/O4/GEaCZbSxR8x2NHcRJwYk2rEtJVNMBiagasD
         Bv1nkyIMm+oO2YGZJYUNIsRzEvKEjAUw9i2AZVD0KVowQbdjjShPgFptyOdoKGlc9VxR
         5J/o+fV7prSr2Q//JpoMODAu9ItjuHxvCJ8nAxTRLF2ODirMrfGfuCJZc2KkFRvhHHnd
         VlG4gASlpFcxXj+Kj3WMMVY5BiTbn/oc97KVDgotaxiE/7VLCUGF3GAwhumrPFFysZ7f
         INbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0SUxZ4NqQz+xS27wgan7HdR+ZmVT7uoo7sfzHIMnMOI=;
        b=dsRaqQS4W1lM4m4RDRTSIsP40p3QgPQfd7ahIQGl+1vI4XpZhhpX3LwoNFt/KnAWg6
         OCrm6utObtiyft8WMU9kH2brMAET4TepCEJtec0iyqbYj38HMaK/F485I3xeIMiQU3oY
         AJo2bjyKGMysRMslmhapzKl2mv3psdJtZYMIfv4ei6Lfvj4snP9u6Dec1BXLTN5KSJ5t
         4mAQErNzsEPiTBNYrkAb+Q6sufaL+tBFDrJX8OgvE9cKK0SF5VrbKhyrgC7QKdPHZsBF
         FJvNQBDQzxdTJ6Ng+yBSGT70KTrMw3qYt0wJ4AA2ygofey7ybxKkJrqiPqvavfBEjFLu
         abfw==
X-Gm-Message-State: AOAM532Vz9T41WDjWg3AssahPG5GdnflHYvCLyqZOngOs3s1PJDGcPmH
        Wxi4l6ozgRm8WzC5Ba9bm3iM/uA7C5EMxQ==
X-Google-Smtp-Source: ABdhPJw6r8bdHH9iQ3HLdl0nNm9C53ayVaC2bKqXI0pXncKZCVWdvKek2MyBzwsSgPBliNPFb8Xrow==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr24826907oih.136.1624293087268;
        Mon, 21 Jun 2021 09:31:27 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id l28sm3995150otd.66.2021.06.21.09.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:26 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 04/23] doc: asciidoc: remove unnecessary attribute
Date:   Mon, 21 Jun 2021 11:30:51 -0500
Message-Id: <20210621163110.1074145-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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

