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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D3081F731
	for <e@80x24.org>; Tue,  6 Aug 2019 08:50:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732406AbfHFIuV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 04:50:21 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37329 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732189AbfHFIuT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 04:50:19 -0400
Received: by mail-pf1-f196.google.com with SMTP id 19so41124611pfa.4
        for <git@vger.kernel.org>; Tue, 06 Aug 2019 01:50:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NH9xqjWSw4y9Xoaib3N6rrQMIcUMlxBlUUxbUOHHTkg=;
        b=VsNPMiLnEouFWaaZxEVVUusuiKqzjUzIepc38tXs5GuUJpDfivCNu4QWXl5aPNAMoh
         MAyJVvp7x615cOfq8ilmukcdsHjrgiMp9Ypv673ptQ7VmcOqZyllAP+QlA1OlmQajnw5
         jIB4TL9GKMCVEy/9BIN+ck/ovRXEgadyGpSNSw2f66eVPFliiwAaVSDr8y3xKD3iVqSa
         SraRdXXxMDcr1b3cxLRSldim2+wUSuZqpllKiTQ2NvMIy9wKEzqjWrQTykvTvQcfIh7v
         Q7LOLpI6JtcLX0Qd1JV8lhRNLE0ShXMEK0xRJvuMGtTFqp1qFObLw+jLxHp7/MbuMf4q
         xpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NH9xqjWSw4y9Xoaib3N6rrQMIcUMlxBlUUxbUOHHTkg=;
        b=Dz2q3WgZQDLr1MpiWXeIbJdiIA0ncuLktT4tnlfAobrjfrII9X6C0JrG2RudPMPYry
         IqSz/MTMMlb9iFWhKY0y+v+UVoCfblc8qsHqgrafcEJT1ugA0/sQcJ0AinjCL31EBh8E
         N7rNmy8lZ1/NTK152XKJJwgEvCZ14YDSw9nh76+boI66YPBNqVLqI749a84/PihvfIwu
         hs/zmrK3yEG6xk5JS2xRMWVhvs3IdFYx1bzJRJ/HnPOV8e9yuYR876NIM4zFG+A/fYTf
         +dtxvpmcWSUVnZJ8biKn96oxOZtGDBKcDlgOxqliACLHdbCGIsbNSBLSBF9iD6nR7SG3
         OuFw==
X-Gm-Message-State: APjAAAUgMROh+ShMhejLGVuTjC6HVRX9uTnCexZnCGBomgCDrCKjpdql
        kEKQxSTTKFCdGh7tF+lGFYQ=
X-Google-Smtp-Source: APXvYqyqhQ5ApolBCijqXRoAxwCX9nVTWNaUjg9b9fllX82bt+c1qp+L4B1ZaRKMxRKRbVUSxR8ebQ==
X-Received: by 2002:aa7:8752:: with SMTP id g18mr2396391pfo.201.1565081418602;
        Tue, 06 Aug 2019 01:50:18 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id j5sm75743830pgp.59.2019.08.06.01.50.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 06 Aug 2019 01:50:18 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
Subject: [PATCH 3/3] grep: avoid leak of chartables in PCRE2
Date:   Tue,  6 Aug 2019 01:50:14 -0700
Message-Id: <20190806085014.47776-4-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190806085014.47776-1-carenas@gmail.com>
References: <xmqq36ifmg7v.fsf@gitster-ct.c.googlers.com>
 <20190806085014.47776-1-carenas@gmail.com>
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
index e748a6d68c..3e14ec91a6 100644
--- a/grep.c
+++ b/grep.c
@@ -524,7 +524,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -535,9 +534,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(pcre2_global_context);
+			p->pcre2_tables = pcre2_maketables(pcre2_global_context);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context,
+							p->pcre2_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
@@ -642,6 +642,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
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

