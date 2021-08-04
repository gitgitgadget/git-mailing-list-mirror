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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80598C432BE
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6569F6109F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235307AbhHDWzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 18:55:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234938AbhHDWzA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 18:55:00 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7529EC061799
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 15:54:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id n12so3974036wrr.2
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 15:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gb05njfbNxLjpFx1D3j/nkPQkBgXLWRHHC5yoWoC4Eo=;
        b=P/31iPbk5njnxVUcuJrM9EMK607Rnk6uIim9DC6XUzp2953tUBiI4h2wjCjznl6+6l
         qFIzmP10pTR8mp+Sm2tYkrQ+JJ9DmP3BWHaHOShA5zdGLIlXK4Sa+hcBscaTeSA6kSyf
         cciE4MNH8IshKib9UkyEZgRdHIqog+WlQJuRI6klCV4Yr2zTHrYBDOMxLW8ttiSxtZxT
         mXHH1LQK6GzKX0BPQETHnHHS475Rj0wItUPsPy5IgcphhYxNHR6wdU4E9l4R9wvxsARe
         bvwW+VOxLBQqhIEATqGUpt2b33haK0QI9K5R2ewXG8vAXunIqtXMf4rbMpQ9QDZ5ZHUr
         ZbCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gb05njfbNxLjpFx1D3j/nkPQkBgXLWRHHC5yoWoC4Eo=;
        b=fW10J0zVpRz3m6P1f342Zf6u249lWJCYD+imZq8B2rg+ddbqVX9N8vtBTZt0SO1wE7
         jx29hd6FGa6vA0B/TIhzsmeqm8H1lR1b4KtNfIzSw7bWk9ikgi0kO7C5YCfh6ujgspho
         YarxXQSaId/ythS4ViCJ94WRPpLqoyHaurICsMgRKT2f7GHCUZ+V0AhG/aLNg+55QErG
         vSkyj0tBTibNcVTB1Owo3L5npjRUoe2oNLqFbRA3/X6xNer8eCTorphf21+DQPsGW/f/
         PUaG2Q7SGrcA8GpgHBz6K4qL/RQTt7TmwxM2uKaSrbb+ZKStsfgtb2z3miLtLWsj+vdc
         n8Hg==
X-Gm-Message-State: AOAM530VZuZ42eijC6rJ/TEzJNHFqpbnyLhpDfliewr7iWwYDDZUwud+
        PCOW+7Yk+Hyu0SRt1aVdiRdo3HFM6Usq4g==
X-Google-Smtp-Source: ABdhPJwJrDgUAf3SP4hpxmu7YTdHNwsu20bLPlJY2JlacOWSbOF2ZJYKVI+/7ivL+MdM5RhHbwgwtQ==
X-Received: by 2002:adf:f710:: with SMTP id r16mr1630109wrp.124.1628117684908;
        Wed, 04 Aug 2021 15:54:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u11sm3968190wrt.89.2021.08.04.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 15:54:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 2/5] Makefile: add QUIET_GEN to "cscope" target
Date:   Thu,  5 Aug 2021 00:54:37 +0200
Message-Id: <patch-v4-2.5-2122cb25633-20210804T225222Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.rc0.597.gc569a812f0a
In-Reply-To: <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210721T231900Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210804T225222Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't show the very verbose $(FIND_SOURCE_FILES) command on every
"make cscope" invocation.

See my recent 3c80fcb591 (Makefile: add QUIET_GEN to "tags" and "TAGS"
targets, 2021-03-28) for the same fix for the other adjacent targets.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 671dde5c7a1..59c2e98795b 100644
--- a/Makefile
+++ b/Makefile
@@ -2758,7 +2758,7 @@ tags: FORCE
 
 .PHONY: cscope
 cscope:
-	$(RM) cscope*
+	$(QUIET_GEN)$(RM) cscope* && \
 	$(FIND_SOURCE_FILES) | xargs cscope -b
 
 ### Detect prefix changes
-- 
2.33.0.rc0.597.gc569a812f0a

