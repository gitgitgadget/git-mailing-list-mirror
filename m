Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B602C20285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751698AbdF1V6j (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:39 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34446 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751654AbdF1V6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so9047171wmg.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=X0XYPC2tpV0kINz3bSXE3bb/aGKvNSqay5QsEjsNc30=;
        b=RiLr40Hf0O0RjatF9FtSpSJJ0YZDm7jAXeXjCL1DahK0SjMHY6SEcZW0DjZW1SCThX
         35yT90SiJL2SbRuLOceOE9cXSlir3OGQlEPTIiTCLRgewtCVQ9ZDaD7gUyvvXmadRy8U
         ueOP5Qelf/Yskh5T8HCFVBj9iSGNVu+KJLZaVGNuOZ2lAgwq1mX6li3j13MlpnRW66zF
         Wh015aWqQp4AlUzTRat1FB31HOygl8jVjNOWh10f+4iFqmv84MKeKt9xJ4eV3g2HZyMF
         AdaRq3Uqk8Upj2HXYsXC5t3+4UnmoZZn5zN+IvuaTHJIdhljso6RX9engterNRZO2WB9
         Q+8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=X0XYPC2tpV0kINz3bSXE3bb/aGKvNSqay5QsEjsNc30=;
        b=ZVFWf8GGkhpMem2yJBu2+tM3oNvNbpaPejUqDaXFcmp8dyHc7NksjG+xjHytdUOxeJ
         Koz1DLyCypliX0QxVm8LmAdRlOUEigtENSurjIjNviw4Q2uaoBkKZqwv/Yfb8dAS5ncd
         gqBCPbez7ZyWxo6tZaD/s8BGn7sNNy3oekFMdqYmvhIvuWrh5YMnBtbCcYYfRu9Km3+u
         GWxGDeiWEn2lceJJ32BMFcGU2sGpf0x0s/hCBvZhBhdxGu5DdQEW367WFhB1XIQdV/lp
         RsldSblcn9pcJJebasjs1WRHocg3w1iIwJ4P35DaNbisvXWmTxz/uNc5oWrFhqYk2yMB
         RbHg==
X-Gm-Message-State: AKS2vOx16qCTzt8FVuFIBfZhJpDEcQ+EFVnvoBxtc+ehbLUBaut2O8Pp
        wJlhipDNgQ4dAz6dcWI=
X-Received: by 10.80.152.112 with SMTP id h45mr9403846edb.51.1498687110849;
        Wed, 28 Jun 2017 14:58:30 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] grep: remove redundant and verbose re-assignments to 0
Date:   Wed, 28 Jun 2017 21:58:08 +0000
Message-Id: <20170628215809.23060-5-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the redundant re-assignments of the fixed/pcre1/pcre2 fields to
zero right after the entire struct has been set to zero via
memset(...).

See an earlier related cleanup commit e0b9f8ae09 ("grep: remove
redundant regflags assignments", 2017-05-25) for an explanation of why
the code was structured like this to begin with.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/grep.c b/grep.c
index 7cd8a6512f..736e1e00d6 100644
--- a/grep.c
+++ b/grep.c
@@ -175,28 +175,18 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		/* fall through */
 
 	case GREP_PATTERN_TYPE_BRE:
-		opt->fixed = 0;
-		opt->pcre1 = 0;
-		opt->pcre2 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
-		opt->fixed = 0;
-		opt->pcre1 = 0;
-		opt->pcre2 = 0;
 		opt->regflags |= REG_EXTENDED;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
 		opt->fixed = 1;
-		opt->pcre1 = 0;
-		opt->pcre2 = 0;
 		break;
 
 	case GREP_PATTERN_TYPE_PCRE:
-		opt->fixed = 0;
 #ifdef USE_LIBPCRE2
-		opt->pcre1 = 0;
 		opt->pcre2 = 1;
 #else
 		/*
@@ -206,7 +196,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		 * "cannot use Perl-compatible regexes[...]".
 		 */
 		opt->pcre1 = 1;
-		opt->pcre2 = 0;
 #endif
 		break;
 	}
-- 
2.13.1.611.g7e3b11ae1

