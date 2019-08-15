Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B5E61F45A
	for <e@80x24.org>; Thu, 15 Aug 2019 21:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731709AbfHOVoh (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Aug 2019 17:44:37 -0400
Received: from mail-pf1-f172.google.com ([209.85.210.172]:41952 "EHLO
        mail-pf1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728828AbfHOVoh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Aug 2019 17:44:37 -0400
Received: by mail-pf1-f172.google.com with SMTP id 196so1977523pfz.8
        for <git@vger.kernel.org>; Thu, 15 Aug 2019 14:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98EMWsuD7z1nEomBbR7CxG/HBZxTeELehw4GC+wgdtY=;
        b=HnFU1DR+6eDVmJkmFyeo7vI13wLX2RowXOB4QTLblXifKBQu4oaJPhg6K5LdOayH1a
         MG5NXcGRYATwkWCJKtxA+tBeLDlCql5/r685IqGhAgH1Bx7XL4M82TAkEFQ/vMJE2pP4
         pkWcD4zfCLOa4tvv0dKygJeqcLI25sjB0OwcijWyHzfL2bhorTRwfZcvhmKVi8d50PoN
         Z5ANB+TyStPTwc6uYQ9FBcViijFhL2IvGNtnE28nSTXrCWBt/ZRm0n2d4VoCp3p2pPOE
         z5YuAM8TkbLPR+ac3jYFbMX8YadMTotHUzwjgRVRj6OqiQdDyPuovFGH7X+mqmkL8GUk
         +mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98EMWsuD7z1nEomBbR7CxG/HBZxTeELehw4GC+wgdtY=;
        b=IOLkhljVxqCcA3g1z+NhvkKksygUQGWZWqjMRjWZRYDv12VjiIBgk4X9sHtsqSqqJk
         43+eYsdjt6TUXfaBlR23dk79hmdswxLxcP7cDXpi+oQIIlGEhOYoBnmZ/hdrB/MHOq1F
         rvuYTsLB2Wpk30i4wcFjR/Koen5Q+CmWUECURKcQ6llc+8JE1BRWOei8bQ5CD3BTBc1Y
         zSJHawr2pdXp5E3RcvfywuKQ67zKKxNNmRqEW3L1Tnhvzci77M2W6pSvlU1V76MJYHid
         yfRuwhdLuiypNH+iOBp298VKlRqjL57eWjeD/8HlaBVO13SxbUdgKm3LU63P6N4qfP3S
         2XVQ==
X-Gm-Message-State: APjAAAVMHu6RrStyBxc8a4VKtRc3x0l+8niPbD220F0dGCua6J8afbTC
        RUp/W/CbkSmzxXSTdx4jZ5iN8yPt8tE=
X-Google-Smtp-Source: APXvYqx7mxjrgPLeDPVjZpnSFv2Yx6xksPFMCQT07lV7+FqzqpgX+OYm/3vw4VcV1WnVllQpbOuegg==
X-Received: by 2002:a17:90a:358a:: with SMTP id r10mr4191690pjb.30.1565905476125;
        Thu, 15 Aug 2019 14:44:36 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id x22sm4391973pfo.180.2019.08.15.14.44.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 15 Aug 2019 14:44:35 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de, daniel@haxx.se,
        peff@peff.net
Subject: [PATCH v3] http: use xmalloc with cURL
Date:   Thu, 15 Aug 2019 14:44:29 -0700
Message-Id: <20190815214429.28048-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2
In-Reply-To: <xmqqo90q2pfw.fsf@gitster-ct.c.googlers.com>
References: <xmqqo90q2pfw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

f0ed8226c9 (Add custom memory allocator to MinGW and MacOS builds,
2009-05-31) never told cURL about it.

Correct that by using the cURL initializer available since version 7.12 to
point to xmalloc and friends for consistency which then will pass the
allocation requests along when USE_NED_ALLOCATOR=YesPlease is used (most
likely in Windows)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v3: proper use of #elif (Thanks Junio)
v2: keep all curl_global_init ifdefs together (as suggested by Junio)

 http.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/http.h b/http.h
index b429f1cf04..20a2030c94 100644
--- a/http.h
+++ b/http.h
@@ -25,8 +25,12 @@
 #if LIBCURL_VERSION_NUM < 0x070704
 #define curl_global_cleanup() do { /* nothing */ } while (0)
 #endif
+
 #if LIBCURL_VERSION_NUM < 0x070800
 #define curl_global_init(a) do { /* nothing */ } while (0)
+#elif LIBCURL_VERSION_NUM >= 0x070c00
+#define curl_global_init(a) curl_global_init_mem(a, xmalloc, free, \
+						xrealloc, xstrdup, xcalloc)
 #endif
 
 #if (LIBCURL_VERSION_NUM < 0x070c04) || (LIBCURL_VERSION_NUM == 0x071000)

base-commit: 9827d4c185e4da728f51cd77c54a38c9de62495f
-- 
2.23.0.rc2
