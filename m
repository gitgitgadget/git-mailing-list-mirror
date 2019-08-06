Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F4F11F731
	for <e@80x24.org>; Tue,  6 Aug 2019 16:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387886AbfHFQhH (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 12:37:07 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41943 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387810AbfHFQhE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 12:37:04 -0400
Received: by mail-pg1-f195.google.com with SMTP id x15so31528484pgg.8
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 09:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hwmuVTzHmyD9L5KeFW98E8S4xoStRlQOJIZx6ErvQYQ=;
        b=q6MT+ksCyimb8LfpyJxRn6bnhSO6ZCEKKxAbs07Z2yJtG4k7rG7DiK6JmpPRjOBo1V
         UJVMZtWMkNLnqXb0bdRHdE++hGR97yqj5nfpI2n/jT/LbFkqkgtKAzgAfVGmMLR2xNtu
         2aPu2LjHTW46IisGHIbq+/wigJxlryzLdu2JWlLoGkkRkN2O2onk1v9S1q1eOdLM013d
         gS2A31oWg/7JSYlgIrFyYZj8WjHHDZx7U3K3dbbMp4iFdm9f5vTpt8iSBrppC1ff6bMg
         sbzmjPrJQpESJR3ngRHX93GtZ1fNgO1j1Tm7TvQxdsjTED9lgV4ZVctm2Gz9TX60AoTK
         kJ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hwmuVTzHmyD9L5KeFW98E8S4xoStRlQOJIZx6ErvQYQ=;
        b=YnlE7a2oPh3+f9TYMcvjON4aPRjS67jCdDOCpXWUckEEJkirWgERjfACWNR5aw5gBT
         QAobaqbXHLr4L2CQuAwJgz/JtfAWqTCbn9YrtSzxiiLnxwFPD8Iz8LBLvUnkY5kKWj3j
         OVhDYtq3dnqYlpZ5aOpF+MvPJYpy/u5njBMFEoxmCxJ3z+AycOBNnNDW022IO646VeiV
         oEAGTW4mhhdo3fbs1Qr5PsDfQbURRmQSWhiUANcMXey3lRCqclWlEFxLzVU12JGJb/1P
         ah0oirUbndEdS2vuJkbzb5awjSxyG9NZt2EHoayls5Uxvcp6uztCc9vBmGZAmbVp/EkO
         Wp0Q==
X-Gm-Message-State: APjAAAVAQExhH+cXGY/E8ifxgEgtyQh6scByXUHnmJk1ATKvOmbuwsP5
        y+J0Ua45AVhkKkwJpM2jiXJ7UmGutxI=
X-Google-Smtp-Source: APXvYqwdG3+JyneSzBvhNUpI6E/HOA/v5e2T4Zje6ep07llpzqNNbUC/oY2nAFKY5NRAgM01SM0ZWQ==
X-Received: by 2002:a63:2157:: with SMTP id s23mr245304pgm.167.1565109422822;
        Tue, 06 Aug 2019 09:37:02 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id k36sm89364611pgl.42.2019.08.06.09.37.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 09:37:02 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, l.s.r@web.de,
        avarab@gmail.com, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v3 3/3] grep: avoid leak of chartables in PCRE2
Date:   Tue,  6 Aug 2019 09:36:58 -0700
Message-Id: <20190806163658.66932-4-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806163658.66932-1-carenas@gmail.com>
References: <20190806085014.47776-1-carenas@gmail.com>
 <20190806163658.66932-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) introduced
a small memory leak visible with valgrind in t7813.

Complete the creation of a PCRE2 specific variable that was missing from
the original change and free the generated table just like it is done
for PCRE1.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 7 ++++---
 grep.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 3e5bdf94a6..3d3ea0414e 100644
--- a/grep.c
+++ b/grep.c
@@ -527,7 +527,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -543,9 +542,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			if (!pcre2_global_context)
 				BUG("pcre2_global_context uninitialized");
 #endif
-			character_tables = pcre2_maketables(pcre2_global_context);
+			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context,
+							p->pcre2_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
@@ -649,6 +649,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	free((void *)p->pcre2_tables);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 526c2db9ef..533165c21a 100644
--- a/grep.h
+++ b/grep.h
@@ -96,6 +96,7 @@ struct grep_pat {
 	pcre2_compile_context *pcre2_compile_context;
 	pcre2_match_context *pcre2_match_context;
 	pcre2_jit_stack *pcre2_jit_stack;
+	const uint8_t *pcre2_tables;
 	uint32_t pcre2_jit_on;
 	kwset_t kws;
 	unsigned fixed:1;
-- 
2.23.0.rc1

