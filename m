Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 340CA1F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:28:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388377AbfG0U2H (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:28:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42076 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387841AbfG0U2E (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:28:04 -0400
Received: by mail-pg1-f196.google.com with SMTP id t132so26313118pgb.9
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 13:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MTgKGB9/foU9CKM1OKzZ7KBnzeV9cqs6O+EZ95aebic=;
        b=IYmfLI6KD3YtT8vUUlOtoSoefkdxOACTykoQdLiVkwTB/yKEgJoe22dz+l4PLvNbf7
         wCnGiK/mLl88R59fh1W1OMsFfYSz706Eo4Wr45PRa86KJbKXSVWMre5fzKkx6V8/GoPP
         je2Us4URLntq/s9mW65/SwHlontmXPDupOKPReM/+58ja+bv0LR+kQ+B0sSASh6i1jAe
         tUa4qrD8CbBo69NcDkGJrMcdpOj6VCL9ndBUVew4HBjGy2aeksAuSMISCtbw/6cB55vO
         kdx+Ax3mCiR7P7+MK9mMMId9CbZoWLFx60leeJvTMDy6U4a9YC1bDu9aULfoPUSebTe3
         216A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MTgKGB9/foU9CKM1OKzZ7KBnzeV9cqs6O+EZ95aebic=;
        b=jhZG9yAtzl3LDURmaq9q5cY+v8RoUo1S99KRKrcxjeo1cfdokzlsb5+RmXyA1YZnBv
         iJOYcruGCgt6cL8j4Clw7gsFoEjgQlcF6gVBOrRM2uUY+JHt9w7x0o6/L1MHoVq1J0KA
         jLycoECvBtaamE7IYlwi/yB+7zOGoTr3DvUlyKNpeh3tvh2Rk3ip55z0wjXJusgBTQwm
         BxzRwcxFuPOS95c2GjdkUpMAPejRF44ejCEUuetC7f75HjyvUhs7U3vgIfD87k8JxSb6
         cEeGSRmmCcuLPSPfIsmMqkSE+ZzVhZ3ZkH7c1jzED74fmcjNS0xhmcJ457hwh+9rSFR2
         g0pQ==
X-Gm-Message-State: APjAAAWmiQs7BZcMAtpoV9RBYERaNq5Xx734HnCj0r1FOLpueShyLU6H
        zjaAXYHoq9DAHGfd+qnaoUabmrQObzw=
X-Google-Smtp-Source: APXvYqzn9NIEyYEu9KDcgPn6qZ4OP39m+ecEvx5+54NrNl14fzB96sQFO0Be88TyiG2RfrHzGe1sEQ==
X-Received: by 2002:a17:90a:9f08:: with SMTP id n8mr105326826pjp.102.1564259283686;
        Sat, 27 Jul 2019 13:28:03 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t8sm64671302pfq.31.2019.07.27.13.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 13:28:03 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH 2/3] grep: use pcre_tables also for PCRE2
Date:   Sat, 27 Jul 2019 13:27:58 -0700
Message-Id: <20190727202759.22310-3-carenas@gmail.com>
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

94da9193a6 ("grep: add support for PCRE v2", 2017-06-01) added a
local variable to keep track of the chartables (used when locale
is not UTF-8 but non-ASCII characters are needed)

Remove that local variable in favor of the shared one within the
grep structure and that can be shared by all functions.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/grep.c b/grep.c
index cc65f7a987..d04635fad4 100644
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
@@ -499,9 +498,9 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 
 	if (opt->ignore_case) {
 		if (has_non_ascii(p->pattern)) {
-			character_tables = pcre2_maketables(NULL);
+			p->pcre_tables = pcre2_maketables(NULL);
 			p->pcre2_compile_context = pcre2_compile_context_create(NULL);
-			pcre2_set_character_tables(p->pcre2_compile_context, character_tables);
+			pcre2_set_character_tables(p->pcre2_compile_context, p->pcre_tables);
 		}
 		options |= PCRE2_CASELESS;
 	}
-- 
2.22.0
