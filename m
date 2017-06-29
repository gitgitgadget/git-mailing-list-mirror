Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 668DC1F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbdF2WWu (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:50 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34503 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751912AbdF2WWq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:46 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so4985578wmg.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5mfDzWtvjyKkZCTX5GRq7tQSH873Y9mmj6yUG1lIA3g=;
        b=lgCWo47jiglwD/heuLeIJajURP9TDo5T81Nmhj0DXZhCrkpNnSPbijpJk9j8RccQkC
         UTFeZdFi238IMWCShJQUBDZKc8NI8mjw/Kvxz6I6NsN6T3fVUBn7dVrveXrOaOJCgnyu
         nOkQdG60IMoJHQvtWQzycNTaau2KU6fJRyVZ7B6koV7BUjDnY3z65ilZW85zbIibl5Uk
         VyUWUpJrk/BE6iozVpO24rYcPQOD7ywF0rtr6KSGQAa3D+P8yxBnsIBa7zUzsWQFT1Dp
         swHguTkfG8aCHB2unWYZJzoU53n8jfRLEgFmq6ElxrdBlw/6vhrDRVJu84j8NEGFeu5Y
         hqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=5mfDzWtvjyKkZCTX5GRq7tQSH873Y9mmj6yUG1lIA3g=;
        b=M3qdU5P/maQL6/AKLRC5RrVmEXyhRKDsRECIl8AjXzoCRG2rZP9GxUXMsMosK09sRw
         zJo67YosUpS3IbEOZMEJvJDvQmiOsA3LGC9eMBmO7kx02ZCZUk+agYzJ1RLeBGrpDS1V
         yLbvDc5iT3Aw9IlPwPI48YIAHQ8luHnLutlUGTOyh4cGK4ufwtNA8lOOVGwl0eldyFuO
         99MYG0d+IrTVX4NnBKvtPwyx79q4WOddfYOE3HNNPyAiFUy+uzYBvEN0Q3iYN4Y0C5I4
         OjOcbYaRhDKLAf/72bTaevY0V0oBvDgFi/GAMdSzc1bGU2Z+Gko9LEmhKJTaWjR0KpxI
         Isag==
X-Gm-Message-State: AKS2vOyrkfSNzPWvZTnJQ2K//PDVTnkreJtqTyXA/30uYqoVs2d1GwUz
        itUaKxfqiLD2dZsyHUI=
X-Received: by 10.80.155.19 with SMTP id o19mr3145012edi.27.1498774964714;
        Thu, 29 Jun 2017 15:22:44 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] grep: remove redundant REG_NEWLINE when compiling fixed regex
Date:   Thu, 29 Jun 2017 22:22:22 +0000
Message-Id: <20170629222222.4694-7-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170629222222.4694-1-avarab@gmail.com>
References: <20170629222222.4694-1-avarab@gmail.com>
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the redundant REG_NEWLINE regcomp() flag from the code that
compiles a fixed-string regular-expression.

The REG_NEWLINE causes metacharacters such as "." to match a newline,
since the basic_regex_quote_buf() function being called here escapes
all metacharacters using REG_NEWLINE is confusing and redundant.

The use of this flag was introduced as an unintended emergent property
of 793dc676e0 ("grep/icase: avoid kwsset when -F is specified",
2016-06-25).

That change amended the existing regflags, which were initialized to
REG_NEWLINE in init_grep_defaults() assuming a subsequent non-fixed
regcomp().

Manual testing reveals that this was always redundant, since no flags
of any use were inherited from opt->regflags even back
then. 793dc676e0 passes all tests with this on top:

    diff --git a/grep.c b/grep.c
    index 627ae3e3e8..89e84ed7fd 100644
    --- a/grep.c
    +++ b/grep.c
    @@ -407,3 +407,3 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
            basic_regex_quote_buf(&sb, p->pattern);
    -       regflags = opt->regflags & ~REG_EXTENDED;
    +       regflags = 0;
            if (opt->ignore_case)

Since this isn't used for anything and never was, remove it to reduce
confusion when reading this code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 11a86548d6..2efec0e182 100644
--- a/grep.c
+++ b/grep.c
@@ -593,7 +593,7 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int err;
-	int regflags = REG_NEWLINE;
+	int regflags = 0;
 
 	basic_regex_quote_buf(&sb, p->pattern);
 	if (opt->ignore_case)
-- 
2.13.1.611.g7e3b11ae1

