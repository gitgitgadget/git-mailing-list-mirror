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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E4201F731
	for <e@80x24.org>; Sun,  4 Aug 2019 03:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726781AbfHDDO1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 23:14:27 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:40368 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfHDDO1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 23:14:27 -0400
Received: by mail-pg1-f195.google.com with SMTP id w10so37965968pgj.7
        for <git@vger.kernel.org>; Sat, 03 Aug 2019 20:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ltF1tIJlp2J90qOZtND+D9qI4jPZdYKwTB9g4qs7F8=;
        b=WEr6AHmaeWpRlH3fkLDb1d/SOSYDuC2M91J6b6Mb+VmFh631KcNtLP0FsLIrku11s5
         9BuCJPpIRh7uksjFoQax2K3uSL9vHyPmCpfD9E23LKivYbKDiBCefzDGCha1CXknoz9+
         2w+5AASN0ZcxDo+qYRjBGb7DMVh6mUSus/GGoO0lwj7KOk/i02QAp0nXwwouZl3rBRYv
         AMMsXbc8Y2AATvspZO8BOM2fgnOC/TpOFr5nfyKwl3E7MLiUcvauYeXZTyFux7fgZlk9
         /5FIiKtHa4GGlyTnwQ62jpRjLxJeAMtaRGkIZDjXYd1wTjHouTy2FqYaDSNfCmXmEIN1
         Cu1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ltF1tIJlp2J90qOZtND+D9qI4jPZdYKwTB9g4qs7F8=;
        b=aVtvueQKaFEYDc1eKl4idcgN4sYHj7nq83leNY69tWmdDgPXfrKDdCse5+H4VAgzkq
         w+XcWRvkLUVRQkIgzG29n+ABEhexcryZBgDiH2GopYhrZTLO3aPxYARHJfMbjLg5smrL
         MFqKyr8n0qDapzNZGRysZQyu8wODlCrYM/HBvJXRD0YEFCV406wzJ1x1ooBXxsaSj9xb
         7/ySN/M9uT/GOTuda6tBLUItpMZWWLrVYlM8OtAWZ/QwdcK9VM1tUtkN+I54nKICWpm+
         /7rIGOgQ3kNyJ4EIJAyPQJNQs5P4CsXzvl+KeEgFpNTi7SOatQx1cT7Pw5pYH2Uf5oDX
         Jxnw==
X-Gm-Message-State: APjAAAWuyW63nVOXjQcWL/y/HsFveQ2wYlXnZTvIa2dtKq2C7l0Kj4WU
        ZCVayuaiuuvm2/h/z/E56vgZJ6ary4I=
X-Google-Smtp-Source: APXvYqxEy0QedXJUFMD2cx6ifugMTPI1iOlOcPKyPl8kG8AIds/1yJzQaM2iEyfFPEcK5a5jbnG1ng==
X-Received: by 2002:a62:18d4:: with SMTP id 203mr67573667pfy.165.1564888466402;
        Sat, 03 Aug 2019 20:14:26 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e5sm9624577pgt.91.2019.08.03.20.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 03 Aug 2019 20:14:26 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com, gitster@pobox.com,
        l.s.r@web.de
Subject: [RFC PATCH v3] grep: treat PCRE2 jit compilation memory error as non fatal
Date:   Sat,  3 Aug 2019 20:14:09 -0700
Message-Id: <20190804031409.32764-1-carenas@gmail.com>
X-Mailer: git-send-email 2.23.0.rc1
In-Reply-To: <20190729105955.44390-1-carenas@gmail.com>
References: <20190729105955.44390-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94da9193a6 (grep: add support for PCRE v2, 2017-06-01) uses the
JIT fast path unless JIT support has not been compiled in the
linked library.

Starting from 10.23 of PCRE2, pcre2grep ignores any errors from
pcre2_jit_cpmpile as a workaround for their bug1749[1] and we
should do too, so that the interpreter could be used as a fallback
in cases where JIT was not available because of a security policy.

To be conservative, we are restricting initially the error to the
known error that would be returned in that case (and to be documented
as such in a future release of PCRE) and printing a warning so that
corrective action could be taken.

[1] https://bugs.exim.org/show_bug.cgi?id=1749

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index f7c3a5803e..593a1cb7a0 100644
--- a/grep.c
+++ b/grep.c
@@ -525,7 +525,13 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	if (p->pcre2_jit_on == 1) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
-			die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
+			if (jitret == PCRE2_ERROR_NOMEMORY) {
+				warning("JIT couldn't be used in PCRE2");
+				p->pcre2_jit_on = 0;
+				return;
+			}
+			else
+				die("Couldn't JIT the PCRE2 pattern '%s', got '%d'\n", p->pattern, jitret);
 
 		/*
 		 * The pcre2_config(PCRE2_CONFIG_JIT, ...) call just
-- 
2.23.0.rc1

