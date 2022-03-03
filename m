Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95D44C433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 16:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234857AbiCCQFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Mar 2022 11:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiCCQFf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Mar 2022 11:05:35 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D461986CC
        for <git@vger.kernel.org>; Thu,  3 Mar 2022 08:04:47 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id p9so8541187wra.12
        for <git@vger.kernel.org>; Thu, 03 Mar 2022 08:04:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pz2XseBF4Xzz8NRFB2Itl1IwhFPCg4vqnJXl8ug9dA=;
        b=gI2emPg/5HoJc9KqHj8aM2p/MkAig9NA4KBTV48xdRLOU20fa0L6fWiW6pKY8dHM3p
         ZvqwxsQQKymjcPPErncV6J+AAaUp9UMr7bkDz/YHIwfGhlwsgETSaYge9UewnFQ6oCLD
         WBOB8H91ujeuMyCmkqs+ISpDaRYnlA0lz9nsWMVjfbQqfsiMvT4hXLdN6bLiu1FnkvEV
         7++Q6jyl452vmmG7CNWQRkAT+cvuU6qKCCdtJVjFo4+z6wiXXbS4QKPJVwnSePSVLP9G
         Fso7xl8Y6AGF6r0N/PFcaOlDsIqN+sekARrDm4YNXix01LHqesQvZOFjSB7DrvE7mmJL
         xGtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pz2XseBF4Xzz8NRFB2Itl1IwhFPCg4vqnJXl8ug9dA=;
        b=Y2SzpVQVA7+3U1y7U6EOVG/7zBFH+BSZm70N6Cnux2YMuvg7rgpvoqHg9VbGG+/IEC
         s1NjnT3zthkktqAgwTo3LHiO+4xxlgvvBNWSvxFhoom88mT/6cHihwbJQx8vummRjMKE
         ltA9EUwBqFEm0DKz7dAm4ZSi1Pvbhzd6Rc3Swn85cM+ax2BdiQKUT1Y8UFXIntbCfSar
         zi1dT0rhVxP36QMQ41sxL9auptnmDoFmNudKAYAr47qUBjX1BpZd6gXINxkFinigZUUL
         Z2NPo7VIZdNmKheZrByefDszJGN55Zc9KvSzBxjP49A4u/r4/Y5Zfhk1mn40keWz9+KK
         Ug9Q==
X-Gm-Message-State: AOAM53117g3nEb10FFUnq19fw+rFtgm4zWPzb5TEYUnY1psMlVL6gHDd
        o6kIbrkxjcI+m61JGWvZ7H6o7sRRalOj4A==
X-Google-Smtp-Source: ABdhPJxVtXEg3mzdXnwQpPP0E4X9V8JG7VG84wZmNa3n1gGc2bwBlOZWp/gsvBfiYqBgXqFjL8UEvQ==
X-Received: by 2002:a5d:514e:0:b0:1f0:25a5:2d49 with SMTP id u14-20020a5d514e000000b001f025a52d49mr6787816wrt.154.1646323486309;
        Thu, 03 Mar 2022 08:04:46 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m13-20020a05600c4f4d00b00386744cb31bsm4040667wmq.35.2022.03.03.08.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 08:04:45 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/8] Makefile: move $(comma), $(empty) and $(space) to shared.mak
Date:   Thu,  3 Mar 2022 17:04:17 +0100
Message-Id: <patch-v5-6.8-422dee02ae9-20220303T160155Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1230.ga6e6579e98c
In-Reply-To: <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move these variables over to the shared.mak, we'll make use of them in
a subsequent commit.

Note that there's reason for these to be "simply expanded variables",
i.e. to use ":=" assignments instead of lazily expanded "="
assignments. We could use "=", but let's leave this as-is for now for
ease of review.

See 425ca6710b2 (Makefile: allow combining UBSan with other
sanitizers, 2017-07-15) for the commit that introduced these.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile   | 4 ----
 shared.mak | 8 ++++++++
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/Makefile b/Makefile
index ce362720947..1e7a1277ce9 100644
--- a/Makefile
+++ b/Makefile
@@ -1289,10 +1289,6 @@ endif
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
index 1dda948df09..934bf428936 100644
--- a/shared.mak
+++ b/shared.mak
@@ -23,3 +23,11 @@
 #
 #    info make --index-search=.DELETE_ON_ERROR
 .DELETE_ON_ERROR:
+
+### Global variables
+
+## comma, empty, space: handy variables as these tokens are either
+## special or can be hard to spot among other Makefile syntax.
+comma := ,
+empty :=
+space := $(empty) $(empty)
-- 
2.35.1.1230.ga6e6579e98c

