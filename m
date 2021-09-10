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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64B8C433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88CDF611AD
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbhIJLFu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232442AbhIJLFu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:05:50 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 176D0C061756
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id i23so2067526wrb.2
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SEMIZdSYkElwb087O14Hplmrdixg0yjN9upmkC1IboU=;
        b=LrpH80kqx3Yt3QSgZ+oHZa9A3bceSvVwWE3+agHj6zGKWHTyuj12axR6j/a+C1+7rU
         t2eSBDKQQQc7R22ZjhIs22LcNtjnnlwC4JbN9XEnskhlJ82AeB7wD0E8wJ9T5t0HMy50
         QIENwlt/I2TsAgTIySVsnWDA2HtvO4icYVV9qOQVIECSEZpmBlWqRFOI0G5rYAzJ+DeS
         UxzoAvzGS95IxRoJIOv2Ecrjx1OYvz7x7vWLg6VitcPAyQ8t6jw+9mQlpIjPSw81UCTR
         kVaDOkkT5fm9RsIvd1aI7/O71iZaU3YJaz5Jl0mGY1wPzzjAhBrlm6m1yyGnlfV5yTOT
         gskA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SEMIZdSYkElwb087O14Hplmrdixg0yjN9upmkC1IboU=;
        b=l+96r8CGxiSOvZuqhws6a4r4w37sY3j1oxWdfeGd8FCPEYdf7QUYM8iZ7CioFDI+00
         qLFMYHx/U1D2sADXyyXbfNWzoH14e9fF1Vvtu9+qtyGfnkAhUKaUqm4hD4KSL/Eio0/5
         pnKgHkl7sRvLQp6lQOZGi/UP1jyNwu/9CEF9YWhGtqH18gkFIBBGufCgavb4U+yEE02K
         9I9EslgBGIy4RWuTmsEVrUs7ioeboIt8+R4hL9fWqrZsfhMV6MKZ3inLkiTqX5DPMOy8
         ep3uba20S126kGCgt/v4smjkePGzcrh0Hv1t3T3iyszqeH6zZt7I3ia5gIwmThbQGXoC
         mefg==
X-Gm-Message-State: AOAM5323uBVKjuhdP33AmnuqRRuyKIiAzI9IUnHLVyMp3be31AoG+Nfp
        VmFNUgYJkC2FFRsEKpse4FF4BjlaC5tkcw==
X-Google-Smtp-Source: ABdhPJzgNsEiJ83l2BtOrSB2utx8SvM3n4tceD3EFVP+ENoEpxwgNc1Dv09mOAwO6MT4Z+06S3jnjA==
X-Received: by 2002:a5d:668c:: with SMTP id l12mr2003603wru.436.1631271877327;
        Fri, 10 Sep 2021 04:04:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q201sm1013631wme.2.2021.09.10.04.04.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:04:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/8] INSTALL: don't mention the "curl" executable at all
Date:   Fri, 10 Sep 2021 13:04:26 +0200
Message-Id: <patch-v2-1.8-ac11cf8cfd1-20210910T105523Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 1d53f90ed97 (The "curl" executable is no longer required,
2008-06-15) the wording for requiring curl(1) was changed to the
current "you might also want...".

Mentioning the "curl" executable at all is just confusing, someone
building git might want to use it to debug things, but they might also
just use wget(1) or some other http client. The "curl" executable has
the advantage that you might be able to e.g. reproduce a bug in git's
usage of libcurl with it, but anyone going to those extents is
unlikely to be aided by this note in INSTALL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 INSTALL | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/INSTALL b/INSTALL
index 66389ce0591..5c6ecf03c27 100644
--- a/INSTALL
+++ b/INSTALL
@@ -139,11 +139,11 @@ Issues of note:
 	  (PPC_SHA1).
 
 	- "libcurl" library is used by git-http-fetch, git-fetch, and, if
-	  the curl version >= 7.34.0, for git-imap-send.  You might also
-	  want the "curl" executable for debugging purposes. If you do not
-	  use http:// or https:// repositories, and do not want to put
-	  patches into an IMAP mailbox, you do not have to have them
-	  (use NO_CURL).
+	  the curl version >= 7.34.0, for git-imap-send.
+
+	  If you do not use http:// or https:// repositories, and do
+	  not want to put patches into an IMAP mailbox, you do not
+	  have to have them (use NO_CURL).
 
 	- "expat" library; git-http-push uses it for remote lock
 	  management over DAV.  Similar to "curl" above, this is optional
-- 
2.33.0.873.g125ff7b9940

