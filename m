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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EC2FC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3536610C9
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232244AbhHPBQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232700AbhHPBQ3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:29 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13C16C061796
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:59 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id t190so4136889qke.7
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUTRc3ZAf9pBuUnalst9RD+aHWTKDQKemKsgBRqkTP4=;
        b=UyjFsMdI4oDovmz5XovGRLO6KL1bps37PHt2539ngxpj9WSBuDfwCxTt3eYLPb1foE
         xT2g2XebBIJa3p1RVsKzumd0sBJplT1VL+50uMc6jU8t7fgaXhIJQEDBc+aUEHWpHs8K
         EA47ClFIt6Ruwage2J/w/tZFU30VGp4+vD47VuFtahSrFwj/uikdQFKLsDPNbRO5xHNF
         qlb0vFNWMx3f2gLC7cobI2mVODGNAgX5BpSOs/JifLGtgroLU7AnBdQ+wDL+8jco/100
         3QSQkAKwa+IZ6Bna4j0Piu8JP3mbkR934Fl87/kuKj6mcnSXWDsteCL5DoZ88LeSFmSY
         m3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUTRc3ZAf9pBuUnalst9RD+aHWTKDQKemKsgBRqkTP4=;
        b=jAlFUx+YeajVd9BtmFLxSx4wcJSr23YBXaR+mym957K0yGKJ9yI7VYAe0il2RnXsml
         M4QS+pz0GVFCcArKVWRpeS+6gw2Bx/wjoEqB0ngKeMRu3TP5rwqI3731NTSJrXA0iHE8
         KewhyT+tqqIJ16YDz/FkemL7VRfJSnxvRWj1t+DzrVM9P7ae0TkUTN6dwaFrljqXLsnB
         1nX9HycOBiHRue0hdUaJVm3KxlUReBXFKWuHEceLaym2rrIfQxPgHm3euJxbbBbyA3Ou
         ZVoh8gnajbka08oPyCes0g91nd26hh6r6rYzFU8LvzbXZJ0mQSDpValQ0OU/fvWf5zHv
         wUpA==
X-Gm-Message-State: AOAM532EPI7ZXNOWO7DRfDcpyC7OCx8GWHvgfxEJPqbWD/Lrm2sNroIt
        p6NWqez8ppZ1tVL9sdlNy4kib0jt1+Q=
X-Google-Smtp-Source: ABdhPJweYXJ98VFgDGWw0CwRi4xqKqcZ8ciSutxWgvOSBUAP0YhZPrrfFH8SJtAcnwIPHyvX5ZgzAw==
X-Received: by 2002:a05:620a:2a15:: with SMTP id o21mr13030284qkp.194.1629076558095;
        Sun, 15 Aug 2021 18:15:58 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:57 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 4/7] fixup! reftable: add dump utility
Date:   Sun, 15 Aug 2021 18:15:35 -0700
Message-Id: <20210816011538.34199-5-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

avoid _XOPEN_SOURCE redefinition in alpine by making sure git-compat-util.h
is included first (as recommended in CodingGuidelines) and therefore avoid:

  In file included from ./hash.h:4,
                   from reftable/dump.c:19:
  ./git-compat-util.h:147: warning: "_XOPEN_SOURCE" redefined
    147 | #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs 600 for S_ISLNK() */
        |
  In file included from /usr/include/unistd.h:8,
                   from reftable/reftable-writer.h:15,
                   from reftable/dump.c:14:
  /usr/include/features.h:16: note: this is the location of the previous definition
     16 | #define _XOPEN_SOURCE 700
        |

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Using code contributed by Junio and only reusing the commit from my original

 reftable/dump.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/dump.c b/reftable/dump.c
index 668cfa8996..ef017701b6 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -6,6 +6,7 @@ license that can be found in the LICENSE file or at
 https://developers.google.com/open-source/licenses/bsd
 */
 
+#include "git-compat-util.h"
 #include "reftable-blocksource.h"
 #include "reftable-error.h"
 #include "reftable-merged.h"
-- 
2.33.0.rc2.476.g1b09a32a73

