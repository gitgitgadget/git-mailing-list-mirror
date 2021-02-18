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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42C50C433DB
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A8E464E6F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229944AbhBRAJB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:09:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229896AbhBRAI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:58 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DAFC06178C
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:38 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id n6so653236wrv.8
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4Owy5EQDAkwhMCnvQWs0gpeMaUithj2blxER70q1aE4=;
        b=G9RPM7mF5oqCtDy8SqaDG9aG6YEdWpOhFV8JDjjSabeF1C5djH8fsktFfTSfV0eSDN
         OOqNUjOwdIVXImgMAc79InxAn606vWjdslNa+9ER8LnCktQCrRkQo2FaEqUCEg5m0H95
         ZpfWq08WER7/lC7YfUnU9ukdbTgHx0YzO0QVD5ednN7mZxGJLe2sYme478My1+TPutO7
         dd6mESNdN1qTYiYR31oltown6vRfpxafgC6DslWPdrCtOGV6cWi4dYY31hLtdAJhkZpj
         YPERr2qGmE67ADSPNzP9aQ/rdwCecYUkagLHucq0UfpzW2o852EEKelAj2P5yK2+KjDU
         OZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4Owy5EQDAkwhMCnvQWs0gpeMaUithj2blxER70q1aE4=;
        b=t6ODmWUBqEgklZ30fC14qI4oDZmwQMqw1nuhruGIJUx1Mhjcp2Qb4hOqgCIMJvk+dT
         sH6//nN9SFu6qfRo1B0Y5k8tShdTogsRyowLthxygSjKV7N+NIVCgVe/EmNPIL0bC6PK
         IuRm5klVE8u/+bvimmqorwHwJmmaTygBh0Nn1oZvZ9EGFZlKSEOeGvKxSOLzWRihga0x
         U6WqMoAUnoXMnbe4uLWjQu5E3B9vC349ppvwecMi3R33TtORQsT1is8WkA2pxhl0CSvS
         Z123JsYdGuoZ3q2CPZFdZPg4Y5/JYRXkbJsSSDYXaqVqh3+pPe2wBpYlp+7pn81pBO4U
         51Xg==
X-Gm-Message-State: AOAM532WK8t1Px0pZFWDzH5oqZTO7J8tVN4OGDj7ngk4aCEBTpkIy3bR
        4r6mv6VTw68yaa/S8fHUei2D7QtNaNfn8w==
X-Google-Smtp-Source: ABdhPJzD+869q7EtUvyA9+mbu85kISUcnEBxCuxNWUApTja5z2CdIFpVGNHoIdrudDFFOoYPQQT0dQ==
X-Received: by 2002:adf:d082:: with SMTP id y2mr1561782wrh.293.1613606857093;
        Wed, 17 Feb 2021 16:07:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 07/10] grep/pcre2: use pcre2_maketables_free() function
Date:   Thu, 18 Feb 2021 01:07:25 +0100
Message-Id: <20210218000728.13995-8-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make use of the pcre2_maketables_free() function to free the memory
allocated by pcre2_maketables().

At first sight it's strange that 10da030ab75 (grep: avoid leak of
chartables in PCRE2, 2019-10-16) which added the free() call here
doesn't make use of the pcre2_free() the author introduced in the
preceding commit in 513f2b0bbd4 (grep: make PCRE2 aware of custom
allocator, 2019-10-16).

The reason is that at the time the function didn't exist. It was first
introduced in PCREv2 version 10.34, released on 2019-11-21.

Let's make use of it behind a macro. I don't think this matters for
anything to do with custom allocators, but it makes our use of PCREv2
more discoverable.

At some distant point in the future we'll be able to drop the version
guard, as nobody will be running a version older than 10.34.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 4 ++++
 grep.h | 3 +++
 2 files changed, 7 insertions(+)

diff --git a/grep.c b/grep.c
index e58044474dc..c63dbff4b24 100644
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
index 54e52042cb9..64666e92049 100644
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

