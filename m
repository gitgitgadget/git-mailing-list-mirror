Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82233C433EF
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D34E60F70
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236012AbhKLVwY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235957AbhKLVwO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:14 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D57C06122C
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:20 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id s13so17927204wrb.3
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2U3JhPnF19jBTuRChU0Pqjnec5yia5NO0jdIRsdiBqg=;
        b=gMEYoiXXA4nqfPIxYtne2rwT+pu2tg+42WgG+d+MxcoVUJuvj1+lccGoPTOqXUrt26
         b3meyPjz5nojvHW0dVPpirUtjz0UvZKh4r6QVFmHzYi0gGLFcf8hS7PnUybJeJJmsAdB
         YLF93Eg3/buqao1H+PXYFin0+u5KhK/isCn16mp94a/S173JOOhjRq+GFrVt2BvK1jwu
         ESEzRbc2ss6SsOw6ZWIKlNfq+k2/Lvh4gI3cnApLOjJDoRyaMDMyKBnXFkvrXMk8kDUq
         +zAkP3aWfqwU+x/zMXFikDkGNJo7FtBAYAoPgH5IuGCG9bK65XqEy+/lEy56TjIiHsEc
         K/nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2U3JhPnF19jBTuRChU0Pqjnec5yia5NO0jdIRsdiBqg=;
        b=HPnqC+FI3w9zXXT0zube6E/nWpP6ZtcHnsB0JgCQ4YjwnPhy5nv6v8wO3Td9NqfzK4
         s42kIq8C9tXnXcmm8MV4YURF4PrgIR++pXuPsH6NLwjCakA5L1tKQpD5MoPHjMw+Xlcw
         HQGxtJJwbwe7OS+AFCXX5sjc/5v7xS7qS/4P88z0/XFWvpY75Z9Xt1ftM76HAtSjWsfh
         wlzOYgTNUW3ZIajdeF7n0RBt5DwI2+RLqKIfNB2EcZh4rS4sAMjDDgpcevuep2p9HpEu
         DaTF68L4Si5Y2ndirhXmzNawlzCur2dgYfSY2+lWoIIg5LlWdnP/Proh0X0LfPib8MJa
         y1kg==
X-Gm-Message-State: AOAM5307x0+NLJYXAL2TQLReUjy7dbPfQFsmw2tO1Sjs8oyk1GkooVSC
        G2xQdM9+uPlVgc3Af59J0sVKx5xfVPLFqA==
X-Google-Smtp-Source: ABdhPJxjTBTVBN08xt7dmZ/SVtLJg+KOdQ0Y182Jd9QBU43udY73cjayWkZ6ZTcC7WZKBXI6gtkk/Q==
X-Received: by 2002:a5d:628f:: with SMTP id k15mr22991187wru.363.1636753758734;
        Fri, 12 Nov 2021 13:49:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/18] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Fri, 12 Nov 2021 22:48:57 +0100
Message-Id: <patch-v2-13.18-6e25ac71cbc-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move these variables over to the shared.max, we'll make use of them in
a subsequent commit. There was no reason for these to be "simply
expanded variables", so let's use the normal lazy "=" assignment here.

See 425ca6710b2 (Makefile: allow combining UBSan with other
sanitizers, 2017-07-15) for the commit that introduced these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 4 ----
 shared.mak | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index 5ae7d012cfb..7130e32a251 100644
--- a/Makefile
+++ b/Makefile
@@ -1252,10 +1252,6 @@ endif
 ALL_CFLAGS = $(DEVELOPER_CFLAGS) $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
 
-comma := ,
-empty :=
-space := $(empty) $(empty)
-
 ifdef SANITIZE
 SANITIZERS := $(foreach flag,$(subst $(comma),$(space),$(SANITIZE)),$(flag))
 BASIC_CFLAGS += -fsanitize=$(SANITIZE) -fno-sanitize-recover=$(SANITIZE)
diff --git a/shared.mak b/shared.mak
index 0170bb397ae..2d597ef7603 100644
--- a/shared.mak
+++ b/shared.mak
@@ -7,3 +7,11 @@
 #
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
+
+### Global variables
+
+## comma, empty, space: handy variables as these tokens are either
+## special or can be hard to spot among other Makefile syntax.
+comma = ,
+empty =
+space = $(empty) $(empty)
-- 
2.34.0.rc2.795.g926201d1cc8

