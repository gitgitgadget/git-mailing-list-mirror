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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94C36C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7628561164
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 07:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240721AbhINH1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 03:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240724AbhINH1i (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 03:27:38 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB80C061766
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:21 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id s32so10528805qtc.12
        for <git@vger.kernel.org>; Tue, 14 Sep 2021 00:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4K9JSPXqos20MXnLzM0vjK2kmltINMLZkZK/ZQEXU8=;
        b=ktTT30AuioduRjil5E1M+RrtsxonngxNUKPbsKGCemt13aSvuqjX4GGkkGzBHDC9dX
         DnJgcNu0FU83oPBwICXjbif/dvLgkEQGiDEL1r0NnWSaGwC+Xco88Nwfz3E4642Ymk8l
         WQJQ8C6+lM2WrCXhveVFDXqqhPdfUCDsZuoVqJc3ShZmlomt6cXFo3FbMOrfo8ZztCR7
         nutl/MdEQU0/b9afTY7d8HVkDtOCa2ZL5FJ66xe9Y7Cfcmx1awUKqdWOJa2nbB4NLYNi
         V1XS1/G2XsTom6KiZaqVB7FplGtBroLxUBQietGnEDxzLIeSM+F/L2GlDhUI6R0djaLK
         DbGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4K9JSPXqos20MXnLzM0vjK2kmltINMLZkZK/ZQEXU8=;
        b=b4fekxVNu8ZpLw3vGERye0pGKqUXuh07agZ+WiPqEyl3a5DS4U9pymx0m3O8JguYdU
         rbeyjQc4MqpEkyHSPMsc8/gI588OeTbx2W01jQRoR3ehAmKzWX+/kkQPDklnepU0FSPA
         GD90vYbWP5SjE2PfT7t0cy9ZFb3tAwjq7Qrjsnu+63Ot2MNlqk4R8SNOXF+OgPyfVoWG
         gtwu95oUpjRpRuV2OBIbMSbJhXlXFV9MbEZ032Qkyzo8sCdFKWIW/O0BidylvYqfoMJn
         4EVoMYnbwlfu7TNVwXeO0C/XXaLOdLhBswEy2E0n9KAYmHIHJB2wfMYx549UI9PiZ264
         INFA==
X-Gm-Message-State: AOAM532FUMq6j1gXrmS96zoDRObpdiuUcSuNXboSN5iq0lJ522NULDWH
        p31tZ8Kix70DxUJEROmo+9NWecHs8iw=
X-Google-Smtp-Source: ABdhPJwSJxN3zHOoX4RjXw/WNRlyYVZXTCUY2TBY7/cXHZPiC1UtSOrK1qSTU8RE2uBUKh8WiYcNvQ==
X-Received: by 2002:ac8:5710:: with SMTP id 16mr3267884qtw.395.1631604380498;
        Tue, 14 Sep 2021 00:26:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o12sm5486554qtt.94.2021.09.14.00.26.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Sep 2021 00:26:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, gitster@pobox.com,
        johannes.schindelin@gmx.de,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3 3/3] git-compat-util: include declaration for unix sockets in windows
Date:   Tue, 14 Sep 2021 00:26:00 -0700
Message-Id: <20210914072600.11552-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210914072600.11552-1-carenas@gmail.com>
References: <20210913085600.35506-1-carenas@gmail.com>
 <20210914072600.11552-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Available since Windows 10 release 1803 and Windows Server 2019.

NO_UNIX_SOCKETS is still the default for Windows builds, as they need
to keep backward compatibility with releases up to Windows 7, but allow
including the header otherwise.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3:
* better commit message as suggested by Dscho

 git-compat-util.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300a..6a420d104c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -160,6 +160,9 @@
 # endif
 #define WIN32_LEAN_AND_MEAN  /* stops windows.h including winsock.h */
 #include <winsock2.h>
+#ifndef NO_UNIX_SOCKETS
+#include <afunix.h>
+#endif
 #include <windows.h>
 #define GIT_WINDOWS_NATIVE
 #endif
-- 
2.33.0.481.g26d3bed244

