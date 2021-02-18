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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57641C4332B
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2A51764D9A
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBRAIe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Feb 2021 19:08:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbhBRAIR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Feb 2021 19:08:17 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6958CC0613D6
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:35 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id n4so694638wrx.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2021 16:07:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vM0hoCFB5kfop0PsoYzpMXvLRypIMlpoecOpL+DhD8s=;
        b=T2g2JV79SASNtQWaBB5gq+ukoUR3jCAYI7bhW0pEz5bU2+R9nZCFJI2v7KuKjEY5lH
         qPHF8zjN1xK0cCsljrsj+o4Ka9hYE8zJoE1TnITqsD2zlrN06TtlUgpM4fTWCVqolkie
         T68zBOT9LTeRrwLEMR6T6NsHRck4m+RilZVhkJ7bIJrD8cdhFZ3plVUYEKxVrUPnLpuU
         8a0hqmzMZqIBOl+n8zJ1/FkiVNLarF15Tm8qK8H8riXJRJAlBBwpnFW/0u5bBLE7jqZg
         OI6FiMhMpuZ7uZr16DsVEjkapjV8k7v8laNLi3/GOrE5RG65pLqdnEAGh1WlTMKhSGbW
         Kdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vM0hoCFB5kfop0PsoYzpMXvLRypIMlpoecOpL+DhD8s=;
        b=LrRMPJmPed83AAmyFRHt4ZP7d2d0dQzbZgeMF1OKoWAh7pEP+tKSIt9FuajhEFysg2
         WFLee4HxjIbCIuEUotptFh3k5FCZ1i8LycoGMNYdCIwOgcLH+z+bqH9z5uc8ytoZMVpM
         V+WztxLIxbGjlfMymyVfmSjF9bev+5jujVnoRhiY4qKcPHRXuvbdI1qrkzR3iLSVCxRh
         1TlVT0jGhswEbALmF55dD+W/R14+iAz/dvYXZbQM+0G5obM6buca76b4bpSYKewK1BQX
         UKq7oIXpEM7tr/AmnlfVzci/3rJrC95B90ZHg0Q4+VDFpNlKdDWNGDZ8zUvkw3N7+aB8
         /d9g==
X-Gm-Message-State: AOAM532dWQQCGL8ImF1GBBZpO184G1tR13PKUbNohrGJXEdkf8htclMP
        L3MPM/jHeWD2qcWM9FJxn5d7kQgwRX5E6w==
X-Google-Smtp-Source: ABdhPJz6a6WQ0nu5kg+GiuMpDqWqh/7O20yBoHACQLX2TRzN26wBex3aay5plKHeN6txDxsGThqaJA==
X-Received: by 2002:a05:6000:1819:: with SMTP id m25mr1572971wrh.342.1613606852457;
        Wed, 17 Feb 2021 16:07:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r17sm6232795wrx.82.2021.02.17.16.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 16:07:32 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] grep/pcre2: drop needless assignment + assert() on opt->pcre2
Date:   Thu, 18 Feb 2021 01:07:19 +0100
Message-Id: <20210218000728.13995-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210204210556.25242-1-avarab@gmail.com>
References: <20210204210556.25242-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Drop an assignment added in b65abcafc7a (grep: use PCRE v2 for
optimized fixed-string search, 2019-07-01) and the overly cautious
assert() I added in 94da9193a6e (grep: add support for PCRE v2,
2017-06-01).

There was never a good reason for this, it's just a relic from when I
initially wrote the PCREv2 support. We're not going to have confusion
about compile_pcre2_pattern() being called when it shouldn't just
because we forgot to cargo-cult this opt->pcre2 option.

Furthermore the "struct grep_opt" is (mostly) used for the options the
user supplied, let's avoid the pattern of needlessly assigning to it.

With my recent removal of the PCREv1 backend in 7599730b7e2 (Remove
support for v1 of the PCRE library, 2021-01-24) there's even less
confusion around what we call where in these codepaths, which is one
more reason to remove this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/grep.c b/grep.c
index aabfaaa4c32..816e23f17ef 100644
--- a/grep.c
+++ b/grep.c
@@ -373,8 +373,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	int patinforet;
 	size_t jitsizearg;
 
-	assert(opt->pcre2);
-
 	p->pcre2_compile_context = NULL;
 
 	/* pcre2_global_context is initialized in append_grep_pattern */
@@ -555,7 +553,6 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 #endif
 	if (p->fixed || p->is_fixed) {
 #ifdef USE_LIBPCRE2
-		opt->pcre2 = 1;
 		if (p->is_fixed) {
 			compile_pcre2_pattern(p, opt);
 		} else {
-- 
2.30.0.284.gd98b1dd5eaa7

