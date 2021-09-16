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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 270CFC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0731161164
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 08:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235324AbhIPI5C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 04:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbhIPI5A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 04:57:00 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD30C061574
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:39 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id t190so6568579qke.7
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 01:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P8qFk+5eGsb5mDAcpZ4ce4gr8ywWeMkfcrfikA4I4bU=;
        b=Y1W3lErkMZf4kNRjWHAXbOhmKd1HpGudfy8WLg25ygpbNbZLfU0FYYAkSQIsp4jbJb
         i0SwNk2lf6hPPB8dY7qXqeAJEgybPdZOyzx9quJmVdmXpi8eUfpG8Y8dWOzxmJgD9QAz
         7HdIp2jDQKmvH27AFHRkhcZqzCfE2WSCiFypoc5I+vcAPtnKp1nNOkn0AmLWuZEmxjdB
         lox6o+f5hS44ggZzNFLWY1VW/2cPl8FH2PVvQ3g/Z9fZKM4yKasAcpJv99RapoJpGr+X
         wl3XJNgDakkUmfDrKCHE8BDh2UoNSh6/p4pBDtJ+R8sKssOi0Us3+36sWpk8DeGPmncI
         HErA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P8qFk+5eGsb5mDAcpZ4ce4gr8ywWeMkfcrfikA4I4bU=;
        b=K4f5KWlkS7ej4dbcyTKNuIB5u2HP9/M0LAaphsRknMuNEOF17paS2mImg0SAdh6x6q
         AdrcGcBGkveiNFl6iSdLchavaP0GIMPT+t9DwW+Zh8bpaWu4g3pON6hYmEwl8qdBkbME
         O+d2MaGJ5kxJ6uO0DI+HVfgAK+ZRJjMFveeFNLQI14YdK8YZtz4NqQolWcu6HnuZnFW0
         LCo2Q+cpNpA2MowPb8r0PN1axkbDm6mxVNrWYc26xDRlJTk08SZGs+JLlPdjTvpdNCMK
         FNXzYUdZNTBe63uNVSJ1RkaYWkt4XBmyQsLMbimfYYTsriHelRVYPn/bRMfovn92K4RJ
         dH7w==
X-Gm-Message-State: AOAM531lb62C2qSLZc4iBgMLXMEK+HTzARvZGrCBBit4tbWpVSC6O+dJ
        wLCaVXFRsjL3YJE+5KbQxIOFMFwq6zI=
X-Google-Smtp-Source: ABdhPJybbXLvaMFV4WSw33pnJBSBTdRF6E5aV8CVUxk7s/+a66gaJrVXCWvZbvDDyU+yFmd59sKhJw==
X-Received: by 2002:ae9:c011:: with SMTP id u17mr4021988qkk.365.1631782538856;
        Thu, 16 Sep 2021 01:55:38 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id e22sm1663868qtm.10.2021.09.16.01.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 01:55:38 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 1/2] tree-diff: fix leak when not HAVE_ALLOCA_H
Date:   Thu, 16 Sep 2021 01:55:22 -0700
Message-Id: <20210916085523.68581-2-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210916085523.68581-1-carenas@gmail.com>
References: <20210916023706.55760-1-carenas@gmail.com>
 <20210916085523.68581-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

b8ba412bf7 (tree-diff: avoid alloca for large allocations, 2016-06-07)
adds a way to route some bigger allocations out of the stack and free
them through the addition of two conveniently named macros, but leaves
the calls to free the xalloca part, which could be also in the heap,
if the system doesn't HAVE_ALLOCA_H (ex: macOS and other BSD).

Add the missing free call, xalloca_free(), which is a noop if we
allocated memory in the stack frame, but a real free() if we
allocated in the heap instead, and while at it, change the expression
to match in both macros for ease of readability.

This avoids a leak reported by LSAN while running t0000 but that
wouldn't fail the test (which is fixed in the next patch):

  SUMMARY: LeakSanitizer: 1034 byte(s) leaked in 15 allocation(s).

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
v2: includes an improved commit message, thanks to Taylor

 tree-diff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tree-diff.c b/tree-diff.c
index 1572615bd9..437c98a70e 100644
--- a/tree-diff.c
+++ b/tree-diff.c
@@ -21,7 +21,9 @@
 		ALLOC_ARRAY((x), nr); \
 } while(0)
 #define FAST_ARRAY_FREE(x, nr) do { \
-	if ((nr) > 2) \
+	if ((nr) <= 2) \
+		xalloca_free((x)); \
+	else \
 		free((x)); \
 } while(0)
 
-- 
2.33.0.481.g26d3bed244

