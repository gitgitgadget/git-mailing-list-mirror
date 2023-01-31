Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55720C636CC
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 18:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbjAaS4d (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 13:56:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjAaS4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 13:56:25 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B84356480
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 10:56:22 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id me3so44502167ejb.7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 10:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KfIwJTCXBNaDMwv1B4P87hlof7LwIbqkkK4crZACUsg=;
        b=MhuFUkw8OKOj5VukLQRtMqyScmFuSeS/m5UAKL3wewf4dYAG2urZR/RdgwDqooorCd
         FOgZ96MwwUltMpG4SDnKpcOVZGfToWqc4ae+dB+6vWtyGYetFo8qXWWO7VZdp8TYgTpH
         Sv0gm1Q84WxldZfBuNftB9NQ9ei+BWgH0kcDmjC/Jvj4zeeEl5Q472mLqmMxoA3udSuE
         Sb71HwTpROFJFXBmI21aegz2jVPQx+67gqu3+QAghcK51Y9yOdUmbuUyna8y1wRxsFN1
         H19Vv8Ed+HWYmfkM7TZXls7RLHGhlWZY/HkYzutUJMP6pk8Hk4TTxwVwetJbvegzoxH+
         vnQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KfIwJTCXBNaDMwv1B4P87hlof7LwIbqkkK4crZACUsg=;
        b=kLX8PhxBAZ4U1ZDH+6bnP/gUBKVMM7eTHiHKE9+FU7NCqmia+qNVL957qCesa3YiGV
         ljTbdGslo0pHL++fpNRmoZhZeuNmg5NEYVZ3rGqsDo6Ydp0V6+WsoVjzJQa6i0hYbOW+
         fiEXyCLjUy+QVaPM8Lq1APlj25Vj2hbLUM+nevDyoTfGhV71wIB9DSSrQUy9EnV0q7fF
         RIUVsVUp6qAx12T3ruVP8S1CyIQ4FvIELUKB3OUfEdH7jeJ89XU6pnZOZJztqkHHoLDs
         zk3exT23Ca/hCNqqRzboLyhl9hUzLlpBLPrfM1Xek1XscYah3+hWGxaUhdRPCBpwAwTA
         mB1A==
X-Gm-Message-State: AO0yUKUtyovHwhfNbDUKRjBCT/r6hhqkiSnsWg7257jmn8tn5M4JXxJ9
        YBOhgUeskDcrJfRrhDi0FuqZF4apN4q1b/5K
X-Google-Smtp-Source: AK7set8c7kObqr3A+XeeNi4oi2soT1LcC8Y7Gdz05Lzd9OJPvkTMLYwLvd7ypDopk2IAVFzWkoROYw==
X-Received: by 2002:a17:906:b812:b0:880:3129:d84a with SMTP id dv18-20020a170906b81200b008803129d84amr15740251ejb.60.1675191380992;
        Tue, 31 Jan 2023 10:56:20 -0800 (PST)
Received: from x1.fritz.box (p200300f6af25c2003cfd4bb27291f555.dip0.t-ipconnect.de. [2003:f6:af25:c200:3cfd:4bb2:7291:f555])
        by smtp.gmail.com with ESMTPSA id z3-20020a50eb43000000b0045b4b67156fsm8593112edp.45.2023.01.31.10.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 10:56:20 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Mathias Krause <minipli@grsecurity.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v3] grep: fall back to interpreter if JIT memory allocation fails
Date:   Tue, 31 Jan 2023 19:56:11 +0100
Message-Id: <20230131185611.520311-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230127154952.485913-1-minipli@grsecurity.net>
References: <20230127154952.485913-1-minipli@grsecurity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

As having a functional PCRE2 JIT compiler is a legitimate use case for
performance reasons, we'll only do the fallback if the supposedly
available JIT is found to be non-functional by attempting to JIT compile
a very simple pattern. If this fails, JIT is deemed to be non-functional
and we do the interpreter fallback. For all other cases, i.e. the simple
pattern can be compiled but the user provided cannot, we fail hard as we
do now as the reason for the failure must be the pattern itself. To aid
users in helping themselves change the error message to include a hint
about the '(*NO_JIT)' prefix. Also clip the pattern at 64 characters to
ensure the hint will be seen by the user and not internally truncated by
the die() function.

Cc: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---
v2: https://lore.kernel.org/git/20230127154952.485913-1-minipli@grsecurity.net/

Changes in v3:

Mention the possibility to prefix a failing pattern with '(*NO_JIT)' in
case we run into the JIT's limitations, as per Junio. Also clip the
printed pattern to ensure the hint actually gets printed.
---
 grep.c | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 48 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 06eed694936c..c6fd44e3ec94 100644
--- a/grep.c
+++ b/grep.c
@@ -262,6 +262,31 @@ static void pcre2_free(void *pointer, MAYBE_UNUSED void *memory_data)
 	free(pointer);
 }
 
+static int pcre2_jit_functional(void)
+{
+	static int jit_working = -1;
+	pcre2_code *code;
+	size_t off;
+	int err;
+
+	if (jit_working != -1)
+		return jit_working;
+
+	/*
+	 * Try to JIT compile a simple pattern to probe if the JIT is
+	 * working in general. It might fail for systems where creating
+	 * memory mappings for runtime code generation is restricted.
+	 */
+	code = pcre2_compile((PCRE2_SPTR)".", 1, 0, &err, &off, NULL);
+	if (!code)
+		return 0;
+
+	jit_working = pcre2_jit_compile(code, PCRE2_JIT_COMPLETE) == 0;
+	pcre2_code_free(code);
+
+	return jit_working;
+}
+
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
 {
 	int error;
@@ -317,8 +342,29 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
-		if (jitret)
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		if (jitret == PCRE2_ERROR_NOMEMORY && !pcre2_jit_functional()) {
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
+		} else if (jitret) {
+			int need_clip = p->patternlen > 64;
+			int clip_len = need_clip ? 64 : p->patternlen;
+			die("Couldn't JIT the PCRE2 pattern '%.*s'%s, got '%d'%s",
+			    clip_len, p->pattern, need_clip ? "..." : "", jitret,
+			    pcre2_jit_functional()
+			    ? "\nPerhaps prefix (*NO_JIT) to your pattern?"
+			    : "");
+		}
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
-- 
2.39.1

