Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5167420A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 23:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbeLIXBy (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Dec 2018 18:01:54 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36082 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726612AbeLIXBx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Dec 2018 18:01:53 -0500
Received: by mail-pf1-f193.google.com with SMTP id b85so4443642pfc.3
        for <git@vger.kernel.org>; Sun, 09 Dec 2018 15:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ddxf0+3zU83keRHbDPZB+MM1bEVMOBQEIHdxs5Q8t+A=;
        b=e3ha4XAS4zthD3LpNOHLrNOqDXsBCtjI6kIfDSPFn0mxwLGoIzudAc60YIsMH2M7HX
         wqNjCNLyfAbj+d6g5MOyDWlAOJ8oap7bgOetOlSuZdnwCRlYLzxsUhITikDh8sBSk53n
         MY4Z5ZHv1I7H3LjpPj7EfNHXIMeYbM3VbLIPvMj3XZKJxCdbFxoXFSvU4ppMoAOAntp3
         aB7CBzglD2Sf6U+2HH+PD/2ELgSzmv/xZVmfK0uSC3GjKyyMi4fTVxX6rm2KzMXl4HL6
         5OZo5TrpfaCf8xe36agxPQF3zzYI7UwcOkDer7oSGm5/J8WZZ/N1GN7eVn5Tcf0aszUN
         fW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ddxf0+3zU83keRHbDPZB+MM1bEVMOBQEIHdxs5Q8t+A=;
        b=Z47J8j8hE0f5BvoLQI5x2EE8sW8+XtlXMt8NSbOBuYEbUTgyP5nb3CJ63DBO23uBPG
         2dC3OVqu89ettr+72rg7V3XwdLgq9HPd4cV8LMvtUugfRMvyE/3Dy/NlIrTH177bXdu0
         GBZUgdYut0u0rK/c6mYhZu11g09Ez6TCh+61JDz3E2O9nlvB5L3a8HumuxvLTCPbTY5T
         E90KMLDEbvsQMgpfqM1/+9KxdIy/kYRRyAFZABJlNlEmtTbfcPY8uiARJ8HKpR3Ecfzg
         UHceJDX2AQEqx3aj+Je4s2zj4YxF9BXq5QdSHT09YiVpgD4xHpBasJmpFFiT26w7ilyi
         ZX6w==
X-Gm-Message-State: AA+aEWYWtSIVzwt6j8/0gvCk8hy5bFY/sPpa399ngc+ekJNhTIF7+czE
        4K/pwxXRDzWniHTxujwXm9H+CJ1c
X-Google-Smtp-Source: AFSGD/UQDtqAuXVLBcSGiDbHBP93T3vHqeDL0b+Oyzl7NdDAcblel7Rfj55BFP8dZVtJI10ll/4Kfg==
X-Received: by 2002:a63:2263:: with SMTP id t35mr8897197pgm.69.1544396512133;
        Sun, 09 Dec 2018 15:01:52 -0800 (PST)
Received: from localhost.localdomain ([172.58.92.208])
        by smtp.gmail.com with ESMTPSA id y5sm15110414pge.49.2018.12.09.15.01.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Dec 2018 15:01:51 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [RFC PATCH 2/2] grep: fallback to interpreter if JIT fails with pcre2
Date:   Sun,  9 Dec 2018 15:00:24 -0800
Message-Id: <20181209230024.43444-3-carenas@gmail.com>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181209230024.43444-1-carenas@gmail.com>
References: <20181209230024.43444-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

starting with 10.23, and as a side effect of the work for bug1749[1] (grep
-P crash with seLinux), pcre2grep was modified to ignore any errors from
pcre2_jit_compile so the interpreter could be used as a fallback

[1] https://bugs.exim.org/show_bug.cgi?id=1749

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index 5ccc0421a1..c751c8cc74 100644
--- a/grep.c
+++ b/grep.c
@@ -530,8 +530,11 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
 	if (p->pcre2_jit_on == 1) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
-		if (jitret)
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+		if (jitret) {
+			/* JIT failed so fallback to the interpreter */
+			p->pcre2_jit_on = 0;
+			return;
+		}
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
-- 
2.20.0

