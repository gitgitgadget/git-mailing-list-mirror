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
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CC941F461
	for <e@80x24.org>; Sun, 21 Jul 2019 18:31:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727157AbfGUSbS (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Jul 2019 14:31:18 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:38885 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbfGUSbS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jul 2019 14:31:18 -0400
Received: by mail-pf1-f195.google.com with SMTP id y15so16258920pfn.5
        for <git@vger.kernel.org>; Sun, 21 Jul 2019 11:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPDll13peMFKXZCuV305W4Mbm01a3W+X7WRWy+auGxE=;
        b=As/0K4o0ojYPDHQp/d0NAi2OAPIaTDit1tuO1OF/IoKjXm/8tHExdA4wB3ws1FV7fp
         FfBoagIi1Q2XmX554tqPgAsRdQ7l4tK0qNt8iX4rOp8i593NnIXBYFLsuqHFJAU4bS7f
         g9/ufx5GXbR/As8VST4fftWlP0LKlgnhHSsiXRukh83SNpLue4WFSAlgLWC9YSRUmz3l
         u67C4kfYxt0oA7z38OSdETMlvZFcga68oNfvxErDuotnnN9xDrh5zmFKuh0WL7mVT6UC
         fAUlng3k1TzQYXtb/1MgTTydYzE4XStWx+SN/s2gEZRG7OBiaE1jNFCvLzXdF2iw/U1W
         gocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vPDll13peMFKXZCuV305W4Mbm01a3W+X7WRWy+auGxE=;
        b=ZBZKtm1zwvOSYx4vPJb4/BJbaHZBerQg3H+nOW7bdFtvyCuIy9XxSB6GAIeCxFBiAI
         pgQ9bS6rZ/HCWH85K6iY53IfUVMN3xcfEXvqUkFy+Zm/9ABMW/ftMmbTCHEy1IDUnkYR
         6u+8+OrLwcpf1Y21G/FQX69Xzcf4XuvsqZxdh8lPp9PfrxyjebGKGbXpA/HbxEFhk29s
         mfPG1zkwAMiI8bmVi6Rt/8eEdiHku/b06Nn+Oxvw8Qc7huCO8RcruRDpnU9LqBiJwTsg
         GzV2JkRJyaRj1euwBiHx1aFLiThujYMuxbd0PZia5/39GMAu9za1j7yXJPILCtZeHeSh
         Z/Zw==
X-Gm-Message-State: APjAAAWEyDyYrr6fjFIQGGt6u6Bues1SMYijzc34wpUkBqtZ8I6Rjpa8
        WrhWjTVBvdpZyGmFUQbqqJY6N/zL
X-Google-Smtp-Source: APXvYqxL1w3jzmb0ze80//nHWehYrhcaF8Pz6jdCmAozjB5MS8/+XcgXPdROZss8Rxq5T0SO+ws1IA==
X-Received: by 2002:a17:90a:8d0d:: with SMTP id c13mr70235090pjo.137.1563733877053;
        Sun, 21 Jul 2019 11:31:17 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id i74sm58926641pje.16.2019.07.21.11.31.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 21 Jul 2019 11:31:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Subject: [PATCH] grep: skip UTF8 checks explicitally
Date:   Sun, 21 Jul 2019 11:31:15 -0700
Message-Id: <20190721183115.14985-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Usually PCRE is compiled with JIT support, and therefore the code
path used includes calling pcre2_jit_match (for PCRE2), that ignores
invalid UTF-8 in the corpus.

Make that option explicit so it can be also used when JIT is not
enabled and pcre2_match is called instead, preventing `git grep`
to abort when hitting the first binary blob in a fixed match
after ed0479ce3d ("Merge branch 'ab/no-kwset' into next", 2019-07-15)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/grep.c b/grep.c
index fc0ed73ef3..146093f590 100644
--- a/grep.c
+++ b/grep.c
@@ -409,7 +409,7 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 static int pcre1match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
-	int ovector[30], ret, flags = 0;
+	int ovector[30], ret, flags = PCRE_NO_UTF8_CHECK;
 
 	if (eflags & REG_NOTBOL)
 		flags |= PCRE_NOTBOL;
@@ -554,7 +554,7 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 static int pcre2match(struct grep_pat *p, const char *line, const char *eol,
 		regmatch_t *match, int eflags)
 {
-	int ret, flags = 0;
+	int ret, flags = PCRE2_NO_UTF_CHECK;
 	PCRE2_SIZE *ovector;
 	PCRE2_UCHAR errbuf[256];
 
-- 
2.22.0

