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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A19E4C433DB
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AC2964F74
	for <git@archiver.kernel.org>; Wed,  3 Feb 2021 03:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232761AbhBCD3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 22:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232680AbhBCD3l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 22:29:41 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03581C061793
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 19:28:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id l12so22587018wry.2
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 19:28:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrxhJITvh/JFLu/TQm4W9HxXuDchoeDmPm9ANtG+qqY=;
        b=OcvgAb+og7WEeap9YdvkeLzndkIDk0PyqFQVorPk6m8C/PQjsIUVsQipAUVSMPQKJ6
         y6ZN7fJR3zJwKe18iC0MSf0qffdKal+VCIERYDSpIMohHVzDa2FRj5QQNlm58mECp469
         x7qOce5S0g2YwdR79MUyNU4ErhpGPU22C6owiWlH39v/q0/fB8BFTA7eYl9+d9cfxrJC
         U1aMxSgxtD/0z8iNhbGEnR9NHbJzynKE3JIoGUsMMbS60W0pNu5hA3K6uWbCQe4ZogAk
         ios8YBKfTgLO4UN4k28zUXoxhEvNjFS2bhTLlCR3UkQ+vuLqac2gArDyTDvCeBqiyR1R
         Wvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrxhJITvh/JFLu/TQm4W9HxXuDchoeDmPm9ANtG+qqY=;
        b=pT/g4R/nMralKJjkSzXe2ZGCfcUsFyEwxHRqzswRJfgSowtPoC83pJxCj3ehQ0tXUy
         05cq16OKJpikfXfhsjDl0gDWsGT6F1u1cDvltE0LsPcs0WkXrCcbqOEyYflnZ1kHowbE
         sEuThlxZVxqkkEremoeimsyxLhBX1DshMelt0lvuvE2+nR2TnjBdi5Y1YE0uO3JTcFtc
         wtlne/CrvPcEi/StBCzdNvDyD2MrqgoqgxUzAx9YQQrNERC3nmeLTJVU/GLaIKIcacV/
         5T6Fliu7p2lmZ8U81fbhsXtO847/R0XC9NJA+xt2JyzKHc6wortxjE73zMGsa0OyhkhG
         sEjQ==
X-Gm-Message-State: AOAM530gdPYUymdpniiGHyuAaPG1/LB04a9VD45ahXnTDfYwRgbdLjCf
        ee5zjDMglPbuBRHjNveZEj/gBh8Uk3EF0Q==
X-Google-Smtp-Source: ABdhPJxD2sla8gUX/aVUePpezqxB3oTo7oaWFkAcHfaYQo0QKXCVVtGkk3O5VzMIjCWmCpoc+BBr3A==
X-Received: by 2002:adf:f905:: with SMTP id b5mr1017831wrr.129.1612322904549;
        Tue, 02 Feb 2021 19:28:24 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c5sm971089wrn.77.2021.02.02.19.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 19:28:23 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/25] grep/pcre2: use pcre2_maketables_free() function
Date:   Wed,  3 Feb 2021 04:27:54 +0100
Message-Id: <20210203032811.14979-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the pcre2_maketables_free() function to free the memory
allocated by pcre2_maketables(). At first sight it's strange that
10da030ab75 (grep: avoid leak of chartables in PCRE2, 2019-10-16)
which added the free() call here doesn't make use of the pcre2_free()
the author introduced in the preceding commit in 513f2b0bbd4 (grep:
make PCRE2 aware of custom allocator, 2019-10-16).

The reason is that at the time the function didn't exist. It was first
introduced in PCREv2 version 10.34, released on 2019-11-21.

Let's make use of it behind a macro. I don't think this matters for
anything to do with custom allocators, but it makes our use of PCREv2
more discoverable. At some distant point in the future we'll be able
to drop the version guard, as nobody will be running a version older
than 10.34.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 ++++
 grep.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index e58044474d..c63dbff4b2 100644
--- a/grep.c
+++ b/grep.c
@@ -490,7 +490,11 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_compile_context_free(p->pcre2_compile_context);
 	pcre2_code_free(p->pcre2_pattern);
 	pcre2_match_data_free(p->pcre2_match_data);
+#ifdef GIT_PCRE2_VERSION_10_34_OR_HIGHER
+	pcre2_maketables_free(pcre2_global_context, p->pcre2_tables);
+#else
 	free((void *)p->pcre2_tables);
+#endif
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 54e52042cb..64666e9204 100644
--- a/grep.h
+++ b/grep.h
@@ -7,6 +7,9 @@
 #if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 36) || PCRE2_MAJOR >= 11
 #define GIT_PCRE2_VERSION_10_36_OR_HIGHER
 #endif
+#if (PCRE2_MAJOR >= 10 && PCRE2_MINOR >= 34) || PCRE2_MAJOR >= 11
+#define GIT_PCRE2_VERSION_10_34_OR_HIGHER
+#endif
 #else
 typedef int pcre2_code;
 typedef int pcre2_match_data;
-- 
2.30.0.284.gd98b1dd5eaa7

