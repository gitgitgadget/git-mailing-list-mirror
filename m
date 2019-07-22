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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F0631F461
	for <e@80x24.org>; Mon, 22 Jul 2019 14:43:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbfGVOnx (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jul 2019 10:43:53 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:36588 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfGVOnx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jul 2019 10:43:53 -0400
Received: by mail-pf1-f193.google.com with SMTP id r7so17483761pfl.3
        for <git@vger.kernel.org>; Mon, 22 Jul 2019 07:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Da5RAfGtM00pRWhb/QLSBy+wcmlN/YDt+CzAkDW3z8c=;
        b=FAr6gZ9J+ENYw2GvaQWD1mi/KLU94Hjc5xlbtVeWCrheLmZD9CKXJaFOypWefK9K35
         fORfnZUukZnR5XIGLd84m0eDi/a1eLAn7gOj6vtteFZQ9ih7wjwk4iTjx9MGzDxwWaMO
         /+jw/Tmm+/TXFQTVFk4fEWTdsDQh8dtWmq7g7v8S6CfwW+xeitAmb6DDxLP1Vh1uO5kr
         w3yrM6r7gqD3i4+R47wZc+dRCAxwZTKzkjovQGnG9TAt6yynZR/+A9kNQsBAd8svaVqy
         cHo6+qyhBaGms+dYqF+dcaIm6Vw4ER65j8QcQ9iD3KnKVDhcvnfML7lP+ihBsKipeNvp
         jrqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Da5RAfGtM00pRWhb/QLSBy+wcmlN/YDt+CzAkDW3z8c=;
        b=fCDenlXx8Ifjwud+BtdpdUPqCsjUO8yiD29RX7Fatz/ODQh7KydVaNCOsEW6r41rB/
         Ew7XjwAtvvD8u8t6xGoqL4ZRq2ka/AjUqBmQgf89cRbDms7IC3vt7OYSa2FHWVDBFrG0
         V4oWic7n9Zpl7KuNOAiuVfcPDKpLvApeoTSPTRtQcvdO94TsD2FncEDPDtrGUFidRumN
         jDbhsW2NX8Xp36mSk5gjDkXjHmFDcRHZM5Jzq2G1KuMu1sYZt7/D88FkVPfQu3D36S7B
         GSooCLcdrtFlko2UEVR0OVx4w6toy96XAoGQTPGGDPeQNcqFX7khTu9fMMl741NRZTY9
         9eVg==
X-Gm-Message-State: APjAAAXUujZQh/s9NuXhTF3LdHNrySwriclDgoeXUwtzeCJwQnkJb4R1
        7shRO05cz6VdEuTTxk7Edr0o+pmL
X-Google-Smtp-Source: APXvYqwjqTLYsPxgQDJ54zOSfqlENiSsdDbRP8XvGEIsARuKwFpSKjpH0SSXjG9NMbWDcYwOewiFEw==
X-Received: by 2002:a17:90a:1c1:: with SMTP id 1mr77643296pjd.72.1563806632272;
        Mon, 22 Jul 2019 07:43:52 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t11sm46740744pgb.33.2019.07.22.07.43.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 07:43:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH] grep: skip UTF8 checks explicitly
Date:   Mon, 22 Jul 2019 07:43:50 -0700
Message-Id: <20190722144350.46458-1-carenas@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.1907221340320.47@tvgsbejvaqbjf.bet>
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

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V2: spelling fixes from Eric Sunshine

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

