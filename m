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
	by dcvr.yhbt.net (Postfix) with ESMTP id 359071F462
	for <e@80x24.org>; Sat, 27 Jul 2019 20:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388379AbfG0U2H (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jul 2019 16:28:07 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43271 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388368AbfG0U2F (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Jul 2019 16:28:05 -0400
Received: by mail-pg1-f196.google.com with SMTP id f25so26310115pgv.10
        for <git@vger.kernel.org>; Sat, 27 Jul 2019 13:28:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rcx1Qs3x+hKT/K4of3mciJhCswIiyW19mjDmLYzoLXA=;
        b=eIMeViUXs75IcP6dEL6+P1wRjK5RW16r260d99EaS+KcCO3qFwX9XfT0dFYalyGlAQ
         jG4BblzhhDU/821WSnoynz9VTYuB0oR/a1DtnV0glb8c1C4RmJTe4Cyrj7dmMrSoHZAA
         Iv/gXl3DHpVA+xSkFccgweIDWkCEr4Pg6/q2rKNedpY9lWwC19PWxWNflJ8TmpGklO1F
         azwFKCvw+dbhmRbSWhb7s6UnhPGDP3x3YkNs+iHN0v0EW/hXWp9DC7TC9AaYgrJKnMhW
         5IRXVVZiZPLYgpc5fXeVFvq4BPQ3iQ+GUXNAUPwtyNoVjcUI6xEGd+7egYNvP3fiv4JI
         9k/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rcx1Qs3x+hKT/K4of3mciJhCswIiyW19mjDmLYzoLXA=;
        b=NYF9/hfIAXVW56AhBP05/6/GQfOgpOzRiZWhcPlRg64eDy9w68gj41TJqfKrMr7aYt
         PglQYHdWZyRrXhmJRRlmnLRLcqVpN7cbmk34BFObI7lv32q0ddW2t7rhMLl9rxTfi9wk
         SHB11GRI0g5xpaA4j87Ng/dQSTMY7UcP1LZSS1AFByY2IlJTAre58nThDmhhQXW6OIjW
         wPVLrHsiPGrxSg8AvNBkC7PVdYyac2Lir9NSQynigHvtGkhYonLtwdRzOTwYOoZAtKz0
         jemR9vGT2g4yX0nnrSpyKtMjxShpErid81bYyoBogrTdWKP2Ps+BCBnA99Iz2LEe8opZ
         FL+A==
X-Gm-Message-State: APjAAAVTBij6zjO97ktLO9QC/jKCDHs8ODJZeO5P6bOFL/5E1siB+vps
        jFZisFN/Y8B67Qyd4l+Ydew+x17/ViE=
X-Google-Smtp-Source: APXvYqzBXk9tDPuagNqpjmUSMGRj9rutJNPB6c4sEXE9eK4cIadwm72yufjNxJLU+x4IFeLrLiUcug==
X-Received: by 2002:a17:90a:7787:: with SMTP id v7mr104721716pjk.143.1564259284392;
        Sat, 27 Jul 2019 13:28:04 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id t8sm64671302pfq.31.2019.07.27.13.28.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 27 Jul 2019 13:28:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com
Subject: [PATCH 3/3] grep: plug leak of pcre chartables in PCRE2
Date:   Sat, 27 Jul 2019 13:27:59 -0700
Message-Id: <20190727202759.22310-4-carenas@gmail.com>
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

Just as it is done with PCRE1, make sure that the allocated chartables
get free at cleanup time.

This assumes no global context is used (NULL passed when created the
tables), but will likely be updated in tandem if that ever changes.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 grep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/grep.c b/grep.c
index d04635fad4..d9768c5f05 100644
--- a/grep.c
+++ b/grep.c
@@ -604,6 +604,7 @@ static void free_pcre2_pattern(struct grep_pat *p)
 	pcre2_match_data_free(p->pcre2_match_data);
 	pcre2_jit_stack_free(p->pcre2_jit_stack);
 	pcre2_match_context_free(p->pcre2_match_context);
+	free((void *)p->pcre_tables);
 }
 #else /* !USE_LIBPCRE2 */
 static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt)
-- 
2.22.0
