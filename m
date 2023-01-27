Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 904D5C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 15:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjA0Pt7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 10:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231810AbjA0Pt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 10:49:58 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 928421713
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 07:49:57 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id rl14so14909328ejb.2
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 07:49:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=grsecurity.net; s=grsec;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RtT71v5x0+HI33lCBkefysb/NMBtTamYjlx9mhPYH90=;
        b=OfZliBorRi4GNvHtLiIRnZ+gsBrUsaOOXBU59r7buR3tAaUD1GDejKbRGHLzd16noJ
         RPyyroZpubLD93ebnTVXoaqIPd6Bt85pbvcZ9aBV+GosEJFDHGKGIEhwH9tueZI5hkRn
         ddioBmVjWt/HS1sP3YIYuPyISFXWv68EKG4nzoBQKLaZB3r/EDMOplbmt+PPjci4jotQ
         BWZ0mc3T4oeCDytTFLuCmJZsvOgumscZJM9ruNhPqFpDfe3AUKq9s0UF1tzxzdBexDdc
         Vaf05QHIMmmNzSWQ/O0eA7nklFR9apc8Gcex5MZjOl3mjT0Qpby6Yl7rU7ohVE84u4bA
         EIMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RtT71v5x0+HI33lCBkefysb/NMBtTamYjlx9mhPYH90=;
        b=NGCXjSD5baT+A65kmr3nwKq9Hx9CD92qHktMge/LX+F7/YuDBVm6WPMRAnVkJxiBDl
         ABLISWdOy1xH5TQg/s4ThxixCEKXgVkr4aK5IhBoDFSJOMK8iI4FlBMyQWNjdzc/9mTO
         vaKiescXUpg7cQe2YM6J+76ySMyoJDSexEGYdPHX0IoBUD4Fd/JUxiLw1zFrVRpRKS5U
         eVWRReZeJIJdPLu5HEO4ExdchywCK5NSEQxW12ghTX1+4sG+GFzXzDFIUcuZe4Cz94ZD
         TiF0UTkKn0vUVBb2TZl8fz1h/GaNmOxd/XIfLFRms68doQoXoy0dzTMClF4xpmM88aDm
         ohRA==
X-Gm-Message-State: AFqh2kriOu/V1Rf3jx8w/WMmuwuBwYHnGF4iM7k09ORVGXRjpaA8z+yD
        PZ5F07vBf5i3PSRYgClDMUCS1Ggo9shi/4Hy
X-Google-Smtp-Source: AMrXdXtWpqHEntdpKH36u5biln2bC6fnPLhISxq1S1P9ZPmkdNcRdc3Oy2xO2vZIMp5V6AqcW8g0eA==
X-Received: by 2002:a17:907:9a8c:b0:872:4fc7:fc05 with SMTP id km12-20020a1709079a8c00b008724fc7fc05mr45543920ejc.62.1674834595713;
        Fri, 27 Jan 2023 07:49:55 -0800 (PST)
Received: from x1.fritz.box (p200300f6af069e00d4e18eed0eef11c8.dip0.t-ipconnect.de. [2003:f6:af06:9e00:d4e1:8eed:eef:11c8])
        by smtp.gmail.com with ESMTPSA id b2-20020a170906490200b0084d1b34973dsm2446872ejq.61.2023.01.27.07.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jan 2023 07:49:55 -0800 (PST)
From:   Mathias Krause <minipli@grsecurity.net>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Mathias Krause <minipli@grsecurity.net>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2] grep: fall back to interpreter if JIT memory allocation fails
Date:   Fri, 27 Jan 2023 16:49:52 +0100
Message-Id: <20230127154952.485913-1-minipli@grsecurity.net>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221216121557.30714-1-minipli@grsecurity.net>
References: <20221216121557.30714-1-minipli@grsecurity.net>
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
do now as the reason for the failure must be the pattern itself.

Cc: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Mathias Krause <minipli@grsecurity.net>
---

This patch is based on a previous attempt proposed by Carlo already 4
years ago[1]. However, it wasn't applied as there were still ongoing
discussions about how to handle and possibly avoid the automatic
fallback.

A follow-up RFC had been posted half a year later[2], adding a config
option and, after some more discussion, even command line switches[3].
But, after all, it was agreed on that this is far too much and Junio
suggested to simply revert back to the initial RFC and implement the
automatic fallback[4], basically merging it with a proper changelog[5].
As that never happened, I took up the work and tried to do just that.

This, again, lead to some discussion but, fortunately, less about the
config knobs, but more about the implications of such a change. I tried
to address Ævar's concerns about always falling back to the interpreter
and limited it to the problematic case I want to get solved.

1. https://lore.kernel.org/r/20181209230024.43444-3-carenas@gmail.com
2. https://lore.kernel.org/git/20190728235427.41425-1-carenas@gmail.com/
3. https://lore.kernel.org/git/20190729105955.44390-1-carenas@gmail.com/
4. https://lore.kernel.org/git/xmqqh874vikk.fsf@gitster-ct.c.googlers.com/
5. https://lore.kernel.org/git/xmqqef1zmkp5.fsf@gitster-ct.c.googlers.com/

Changes in v2:

The current version takes a conservative approach by only implementing
the fallback to interpreter mode when the runtime test for basic JIT
support fails as well, indicating the inability of PCRE2's memory
allocator to acquire a W|X mappings for runtime code generation.

pcre2_jit_functional() very much intentional calls pcre2_compile()
without making use of the context set up in compile_pcre2_pattern() to
exclude any errors related to that -- a wrong combination of options
making pcre2_jit_compile() fail for these reasons instead of the memory
mapping error we try to detect. This ensures we're doing a dumb simple
JIT compile test to probe its general runtime availability and not
wrongly fall back to interpreter mode because the option combination
we're trying to make use of isn't supported by the JIT.

I also changed the author to myself as the current state has little in
common with what Carlo once proposed.
---
 grep.c | 42 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 06eed694936c..59afc3f07fc9 100644
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
@@ -317,8 +342,23 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
-		if (jitret)
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
 			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		}
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
-- 
2.39.0

