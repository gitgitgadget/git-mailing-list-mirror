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
	by dcvr.yhbt.net (Postfix) with ESMTP id B8F291F731
	for <e@80x24.org>; Wed,  7 Aug 2019 21:40:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfHGVj4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 17:39:56 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:42341 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387802AbfHGVjz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 17:39:55 -0400
Received: by mail-pl1-f196.google.com with SMTP id ay6so42642912plb.9
        for <git@vger.kernel.org>; Wed, 07 Aug 2019 14:39:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qW33J0Fo0ymv9yMlLbkqbn694TluF4+zgIfMGEDbGwY=;
        b=nZIa3P7HUdmWwan2of4xdyq0ruw0X66z1eO/p8Xb8L2FlWOmxZi38ylf4n/tUKaJ1a
         exP5+moBRjkL941hYXHP52HQHJYae88DOOyOsIXWKGoWoC92zEWuxkk4roOALmgVMmfZ
         drrk+MI1AAA+QhKh+kkAhQEK9OrwBHZtF4sYRVVMUxZ0S4fDkHxXvJT7LlQhRJ/R7awu
         wPlpqifnBiT3xfj6EGNwi+ylmWYBxvaSD6ZMRFUlZhPt0VMIstOyE+0Se3qiYJQBob9k
         CmVlzWUXzSV/+idjNbiXQ2ajnhuunSs72MxNkCjLfayoj9SYZjPG7Qce5WIPOvXlJdiw
         taeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qW33J0Fo0ymv9yMlLbkqbn694TluF4+zgIfMGEDbGwY=;
        b=iL65jEtigC19j7pbB4rnUYzCDLrdyybNSbf3I8AaOI5hy29aJJmskqkW2IwFRGxv1R
         6x19LjLHKxHZ5ZFtudyyFqmedPCuIUkVr6QQJpwazsji3O7euszNaz2o2KE3p5s4KfJf
         /wAXq3V0zkuCZu+GaYaJVs84sCOvpyYAxxzJ8CLdDeVfQQCDA3Or4vhCWuM0DyPU437S
         5+/kVyv7vnEjzjPehuShjwhwJcKs/T2r5fF7M+1TdHaq8i10AM8P8nFgLqKaWSpbpM1f
         FKhRstmvy/UOlw3z4maZjIS67pB/fXtxWU/icOt2I2H+Wa93fjruDkooK4tcMuls+MK3
         MTUA==
X-Gm-Message-State: APjAAAXjpCgnS4MpLmG3f65gZdT8Pab87yvbnAHCF3g1yvxWTHLTI0va
        9rRAHPg6PrXzNj6lCZhmSWQZVMi72RM=
X-Google-Smtp-Source: APXvYqyxzurVvN/0tkipqaWDCdnyXKzmadhGN9aFJrlxXQ7Ly8G+CoGGrv9vH6ddahSIs+raRFpvtg==
X-Received: by 2002:a17:902:d715:: with SMTP id w21mr10458526ply.261.1565213994984;
        Wed, 07 Aug 2019 14:39:54 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id b24sm63840303pfd.91.2019.08.07.14.39.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Aug 2019 14:39:54 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, gitster@pobox.com, johannes.schindelin@gmx.de,
        l.s.r@web.de, michal.kiedrowicz@gmail.com
Subject: [RFC PATCH v4 3/3] grep: avoid leak of chartables in PCRE2
Date:   Wed,  7 Aug 2019 14:39:45 -0700
Message-Id: <20190807213945.10464-4-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190807213945.10464-1-carenas@gmail.com>
References: <20190806163658.66932-1-carenas@gmail.com>
 <20190807213945.10464-1-carenas@gmail.com>
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
index 8ee982e2e8..ccb6ab38a3 100644
--- a/grep.c
+++ b/grep.c
@@ -541,7 +541,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -557,9 +556,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
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
@@ -663,6 +663,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
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

