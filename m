Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AB4341F731
	for <e@80x24.org>; Fri,  9 Aug 2019 03:02:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404804AbfHIDCX (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Aug 2019 23:02:23 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:40903 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404679AbfHIDCW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Aug 2019 23:02:22 -0400
Received: by mail-pf1-f195.google.com with SMTP id p184so45217343pfp.7
        for <git@vger.kernel.org>; Thu, 08 Aug 2019 20:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpdagtpDwtSmuzO0f3b8AodYt9iVtLOneKul0+CN4/k=;
        b=WyetXoA/xjtNqvOKNfpDQiXYMk5GA/04YDRJPS6UKAM0BKfFJp4SjKV3q5BMWkn9q0
         e+Gbz/beMIUq51Ondh9Tg3o67hKQkAXuap3jPomcOuXj55/GlAiNJ3An3TYL1J5C9k55
         WceH/U4Nw9Nlh5D7fljj3Qf3UxQrV2a3/ikjX5NRfTngqNzIr4/xhUWIUbW/aRmPWt6N
         Npp/sh6ws9k2xKadN7472E6U/P+TkoPXGcT+lqvMMCe8i2uGuP9OlExsMtPga85ZAKb9
         7iC9r7w1Rldt8TYQw0SdVntLt2BY75y048A/tNufkDTD/Ddbs8bmIHoOXM8bi+VpPUkx
         AXgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpdagtpDwtSmuzO0f3b8AodYt9iVtLOneKul0+CN4/k=;
        b=OBIhdjVsH6QU0d4iwzbB7ZZ7AeZWp3J6+2lwfNemw093jIuUToJQrqtpN2kRHVDp0E
         jw/ETLyJ4YerCA5GE7qT0G7CJJrdlrI9lbuBuMjFOtL5G6d++SVjycqiTbHRmX8TdZow
         fJ7aIq+jEiSrwxkp9U9wE2ZWKpq8oQWw3c2HQaQhp5UuLu8astS8m5ecUsdUoQB9WpsS
         nCuP1i4cOR+HAEbT36y0Y1g2qI7Z4jlhvgypsZybNNlawSTJZ5n+8RzXGhWi9In9soyv
         f9wXnk2zehK+mqfgjUdk2zEx/wcp+xN00stmquv3fW4BMTpgg6hfXluN5fMa5DBssgyS
         tEow==
X-Gm-Message-State: APjAAAV01V+22nbEdigWswb2efpiWsbLBENSQiOm6Zxk1FD5iV+hjPf2
        c1TuQOoL6u+YOr/RPXnd/cW9P435eEQ=
X-Google-Smtp-Source: APXvYqxwOFHULIfvM1eXv74dDuwMxqK2ReD0KDgDUgTe3+PCdw3yAo/q/7hh+x/6ocxmRwkgNcSZsA==
X-Received: by 2002:a17:90a:c391:: with SMTP id h17mr7225092pjt.131.1565319741084;
        Thu, 08 Aug 2019 20:02:21 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id h1sm124965938pfo.152.2019.08.08.20.02.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 08 Aug 2019 20:02:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v5 3/3] grep: avoid leak of chartables in PCRE2
Date:   Thu,  8 Aug 2019 20:02:10 -0700
Message-Id: <20190809030210.18353-4-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190809030210.18353-1-carenas@gmail.com>
References: <20190807213945.10464-1-carenas@gmail.com>
 <20190809030210.18353-1-carenas@gmail.com>
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
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 grep.c | 7 ++++---
 grep.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index 8e0b838db0..146891e2bf 100644
--- a/grep.c
+++ b/grep.c
@@ -543,7 +543,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -563,9 +562,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
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
@@ -669,6 +669,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
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

