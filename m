Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26026C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234352AbhL1BIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:08:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234344AbhL1BH4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B39CC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id b186-20020a1c1bc3000000b00345734afe78so9195127wmb.0
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/MSSM+OT4NyWgY18B3iN1iWyKZwDtnQOi8avi2sBWE=;
        b=CWpMQHQm+fxjN5gv/2emBn226+WEv1zIQwkfEjqoNo4guTfXtPk7TQGkyZUxvb5e7K
         QUyGraCiM6R/jeefYq2J2LhSWOe3Vx8LpI+cF7+H+6sg2b9/oF15WAzvK+SLaPE0YuZw
         Mxz6JOm14LLmBpTSR22kWQNa3hjpH++S+ffcVP9Q9YB019CqQEg3lJbUOGl1nH6rMbQa
         xugv2sYTdN2JleJJ+E6j8Mjr75kpEfjQeeJobgWWvaKlGSuMeihIwbrxI9fZBbCqAdMr
         eks3cU8cDY2E3NmKdTCZ+IA+8LTNAwvNEUedjwwcjozwDbmi4vF4TjFsn+DxJicBgPdh
         YxOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/MSSM+OT4NyWgY18B3iN1iWyKZwDtnQOi8avi2sBWE=;
        b=3XkW1nge3ezJ4X3gQQxCUjR6cRaSymefnREwwT61JDNfr9Ia2oPBWTa3XEVUD3wn9Y
         JmbtsYlY5GmAfpLrRkYuZ/bN+A2ddOga0cWhCawPJFsbjgtdblMlKdDynD2CZ4fUQE5d
         v3l8cAsU6MaIvsb2soS+2lGE0fILyWtU7pWuANDpPtw+YOg7gKf985BZSzCpndBQbIUl
         28cQXltmX6Gz/1ydyFN91jMSdWzS7ryt6sf5fOzSPBushJxBEK9NqpZlnR4o8Hp2CA6h
         AvVgLVCZbQeZAdtUBBpfh1pimLCEAhoZ/+VzHaHwpO+dOdhVv37m1ys0aNuikb3b0+23
         AgAA==
X-Gm-Message-State: AOAM532M7t20WM47j00Vy/JvO08CrHldm9wOnnMMvAIFR9N2Hy56UX10
        gP5CZSAJuSPVPTmmwBLWZ4MKbkjWv1XSu5fX
X-Google-Smtp-Source: ABdhPJyy1tN97VuR5nRvx5c4i5lm/mixlVhU0lLLItYZ1NqFA2zRyyLEhzq8Q7AhA3MJy8RodeOakw==
X-Received: by 2002:a05:600c:a47:: with SMTP id c7mr15094910wmq.23.1640653673703;
        Mon, 27 Dec 2021 17:07:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 08/10] grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
Date:   Tue, 28 Dec 2021 02:07:43 +0100
Message-Id: <patch-v7-08.10-7dbeafde26b-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com> <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in compile_regexp() to check the cheaper boolean
"!opt->pcre2" condition before the "memchr()" search.

This doesn't noticeably optimize anything, but makes the code more
obvious and conventional. The line wrapping being added here also
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 8dfa0300786..f85be8b6eac 100644
--- a/grep.c
+++ b/grep.c
@@ -492,7 +492,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->ignore_case = opt->ignore_case;
 	p->fixed = opt->fixed;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (!opt->pcre2 &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
-- 
2.34.1.1250.g6a242c1e9ad

