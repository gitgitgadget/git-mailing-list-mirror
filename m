Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5286E1F731
	for <e@80x24.org>; Thu,  1 Aug 2019 17:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729881AbfHARJ5 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Aug 2019 13:09:57 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38807 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbfHARJ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Aug 2019 13:09:57 -0400
Received: by mail-pf1-f196.google.com with SMTP id y15so34442008pfn.5
        for <git@vger.kernel.org>; Thu, 01 Aug 2019 10:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3hPsPItL8UlhGODMtdmrHFn4vDcj2yVnpE055Q5D+uo=;
        b=RcnivDZNNRi1oo9SRKYHueuVfjefjyHaRht6x2YNwjkyCocCWILd/ynHzMHff4m9p3
         hxIvES4h++H/E4WV3edgTfJPvf4srFOF1ninHHttj7R1lLnw0o8oNrzmp9PGCh2GCjIz
         ixRo8IFuJ09QkkbjJX5rMZN1DPIv7q/a0d3cMdgUREeYJR8daymkxEW3cuH+TdCVl+W1
         JddTQNhBdGppR1Ruc9HhPRIeZ54uQgtkFfqT4x6wEHxdrMGAIgQDZveU6kFJHPnFR4tE
         f1z6THa+mTt67SNJYEARw58WfPMUOjXFVS0MFgCjMiOgGuHNpz2dOKdAn2x307jSW+kb
         06oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3hPsPItL8UlhGODMtdmrHFn4vDcj2yVnpE055Q5D+uo=;
        b=P8wY/dYYBh0zBhwMvxQAtuXlC0weI1bDKzCkCVmghh49Rjm2LFrHhgZ4zD9H/yXysB
         vJCbKflupg0sju5tEQ7ynK93O4gbXzKWbZccQVeA1NCvzkDZaWcx+HTU2hAOKttPo/8X
         cclbjXFbh/R+jeWHVvdK3d3B4nSS1ryUAIcBXlnPDDLIRqRbY8iEk/qdvw8tEI0AGpkJ
         Xs/P+C670gGx0Z9uw4Ml8kMhBQNYkf660MuwKjV2Dnr4xwISiEqJxjU7kiO42Wi0Ugci
         5l8H+Ddf5nHpUsFamc4yRTP2Uh2bD/PuD0WSIBeRjBFRcx7j6k2aeMTSkWuVmEKM1KWW
         IsLg==
X-Gm-Message-State: APjAAAVTjF9ficoci6V0jFNbAspJCb4xRoNO5Mcy9WGgVpM9Co90bzYp
        LHixWNFOlmyr+omDNH13sAEwV/f2JhQ=
X-Google-Smtp-Source: APXvYqwiPFjEp1APy6YMQ3eXxKnH+LMkq4vfuMBpWWt6wcTayJwyDVP8kvzMlKJn98CZxFcfxP/+qQ==
X-Received: by 2002:a63:593:: with SMTP id 141mr117560006pgf.78.1564679395990;
        Thu, 01 Aug 2019 10:09:55 -0700 (PDT)
Received: from localhost.localdomain ([205.209.24.227])
        by smtp.gmail.com with ESMTPSA id a1sm22802806pgh.61.2019.08.01.10.09.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 01 Aug 2019 10:09:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, l.s.r@web.de, gitster@pobox.com
Subject: [PATCH v2] grep: avoid leak of chartables in PCRE2
Date:   Thu,  1 Aug 2019 10:09:46 -0700
Message-Id: <20190801170946.81221-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190727202759.22310-1-carenas@gmail.com>
References: <20190727202759.22310-1-carenas@gmail.com>
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

The table cleanup use free as there is no global context defined when
it was created (pcre2_maketables is passed a NULL pointer) but if that
gets ever changed will need to be updated in tandem.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V2:
* better document why free is used as suggested by René
* avoid reusing PCRE1 variable for easy of maintenance (per Ævar)

 grep.c | 7 ++++---
 grep.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..fbd3f3757c 100644
--- a/grep.c
+++ b/grep.c
@@ -488,7 +488,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	PCRE2_UCHAR errbuf[256];
 	PCRE2_SIZE erroffset;
 	int options = PCRE2_MULTILINE;
-	const uint8_t *character_tables = NULL;
 	int jitret;
 	int patinforet;
 	size_t jitsizearg;
@@ -499,9 +498,10 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+			p->pcre2_tables = pcre2_maketables(NULL);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context,
+							p->pcre2_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
@@ -605,6 +605,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	free((void *)p->pcre2_tables);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
diff --git a/grep.h b/grep.h
index 1875880f37..26d21a3433 100644
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
2.22.0

