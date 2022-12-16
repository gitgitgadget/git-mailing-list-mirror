Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F014C4332F
	for <git@archiver.kernel.org>; Fri, 16 Dec 2022 12:16:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230305AbiLPMQ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 07:16:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbiLPMQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 07:16:22 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF0217414
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 04:16:17 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id m18so5726105eji.5
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 04:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gZjEkMEfA2IueutZMyzzn9KCl5amOPwrS/g+XLLraKs=;
        b=tzzv+01JOVY4+w3qNfoY4MeL/CKM0f/kxZqHIj+CXRLhYi4gm9AdEU9Q6H27LY8NbO
         CO9fJQSp6th6pAuU8I2W3KXf5sYrDToDt2K5o7P1VYror9xf1zOKbqGdLtL94btpdv4f
         saYRF+VFZRIm0oEbXsmMNfbMl0STg2IovXhI82k5Dh1qkkPn6TuqQT+LtZ3IHhSXQQf9
         f4XXB2Jl+0p4ucxOuFUX9FQ9c8oHkQOBN9GgR5SXqWoYQk3IxucA2kCszOvZJU7d5Alz
         Lddjssvp5mrgFTBYHDh5XHI8KXpVPPkzoCpCWZsMfco/YC8N3RX1Jdkpe8SoUlnkL3Mp
         /EyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZjEkMEfA2IueutZMyzzn9KCl5amOPwrS/g+XLLraKs=;
        b=Y6kOyE6QStgeEplxWTgFD1yqt2iU02NAJ9FgPNfz7N2knu6zH7bIVuSpjjafQLnQ32
         KXSV6x3ZxytdMACWCnmmm/Loij7ODLdrUNZxG+f+Mto9AJ1VozW+ulSqMjB4i1p95A/F
         7E7mRUl1sTQCOP6E90U3i7dpoV2a28e03uNpPiREooy28I8N/HIZp3iKQD6nwfZPmHH2
         WpzhJBm0dFmkihtsh0vLh/GBi5ovgKn2Divozu2c9SuH1R0Mx3BnOaDvSwRwY8844J8e
         sFXywXlC1JYuwVzo6yCD14T92mqaLGBYj+oh1+jM8Qzu+27AaHlw14Fvkr7oSIq/1GGP
         Xq5A==
X-Gm-Message-State: ANoB5ple37e8O+Ispsg6Jp6bFrE8UTgvceg2uvKRnWiPp58GVERETsbu
        ort8yRkFN9h1WP5DNRZaxpYbgVcf7W/CBeq3hD0=
X-Google-Smtp-Source: AA0mqf7s4SbrmgfUfxNMHnRc+mQuTiZzGLdCxumDTOeVt2vCV6bAZy6D+MgRJdTbqvCTe+D6mfwhrA==
X-Received: by 2002:a17:906:1d01:b0:7c1:36:9002 with SMTP id n1-20020a1709061d0100b007c100369002mr26604235ejh.67.1671192976132;
        Fri, 16 Dec 2022 04:16:16 -0800 (PST)
Received: from x1.fritz.box (p200300f6af034f00ee1c30032c2fc9e7.dip0.t-ipconnect.de. [2003:f6:af03:4f00:ee1c:3003:2c2f:c9e7])
        by smtp.gmail.com with ESMTPSA id q25-20020a170906a09900b0078d76ee7543sm778157ejy.222.2022.12.16.04.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Dec 2022 04:16:15 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     git@vger.kernel.org
Cc:     Mathias Krause <minipli@grsecurity.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] grep: fall back to interpreter mode if JIT fails
Date:   Fri, 16 Dec 2022 13:15:57 +0100
Message-Id: <20221216121557.30714-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Carlo Marcelo Arenas Belón <carenas@gmail.com>

Under Linux systems with SELinux's 'deny_execmem' or PaX's MPROTECT
enabled, the allocation of PCRE2's JIT rwx memory may be prohibited,
making pcre2_jit_compile() fail with PCRE2_ERROR_NOMEMORY (-48):

  [user@fedora git]$ git grep -c PCRE2_JIT
  grep.c:1

  [user@fedora git]$ # Enable SELinux's W^X policy
  [user@fedora git]$ sudo semanage boolean -m -1 deny_execmem

  [user@fedora git]$ # JIT memory allocation fails, breaking 'git grep'
  [user@fedora git]$ git grep -c PCRE2_JIT
  fatal: Couldn't JIT the PCRE2 pattern 'PCRE2_JIT', got '-48'

Instead of failing hard in this case and making 'git grep' unusable on
such systems, simply fall back to interpreter mode, leading to a much
better user experience.

Such a change was already proposed 4 years ago [1] but wasn't merged for
unknown reasons.

1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>	# tweaked changelog, added comment
---
 grep.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936c..f2ada528b21d 100644
--- a/grep.c
+++ b/grep.c
@@ -317,8 +317,21 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
-		if (jitret)
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		if (jitret) {
+			/*
+			 * Even though pcre2_config(PCRE2_CONFIG_JIT, ...)
+			 * indicated JIT support, the library might still
+			 * fail to generate JIT code for various reasons,
+			 * e.g. when SELinux's 'deny_execmem' or PaX's
+			 * MPROTECT prevent creating W|X memory mappings.
+			 *
+			 * Instead of faling hard, fall back to interpreter
+			 * mode, just as if the pattern was prefixed with
+			 * '(*NO_JIT)'.
+			 */
+			p->pcre2_jit_on = 0;
+			return;
+		}
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
-- 
2.35.1

