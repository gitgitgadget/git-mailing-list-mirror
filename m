Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8D91F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751905AbdF2WWo (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:44 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34484 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751813AbdF2WWm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:42 -0400
Received: by mail-wm0-f66.google.com with SMTP id p204so4985460wmg.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=HlOtr+gDoIDRLpfvJRinLFkxIp1L5tIPPsLBa9ae7hE=;
        b=Y3UxwcUqvgupDihOu97OGwsYYQ29tbbgHfAyd0TL1jsg9R3ob4LCbmyoDzbgWt3TgH
         D09U042hibadBiKL3Vh86pO5EbeNN/muOOsaHE7OB0/x2guDtvVcuvGeqxGstDqWDCpn
         1WWGmsKY3VuwrJq7VAcTkdmG+vofTQtXi0wuGPPtRBiKcDDxEWFsnwZFwG+i7Eohkjas
         LKuGnJ8hBc4weFH5dIwf3DK9ajCuzD6nCspJv2xkgiEYwWNw48tHh32Et/qI6h3CJja9
         uumkQYeURifR6XBS9yRqLHUMNX4Mw6pC2Q2Jkxtm9GIdAZROaUQxdkuT+h9ZWCAmdLWH
         WzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=HlOtr+gDoIDRLpfvJRinLFkxIp1L5tIPPsLBa9ae7hE=;
        b=dIqjG4Ql3OJ+qY8c6VAJFP8ba0skJU4lbuF3cuZVVhqkWKqunM6ZnbXgW+WhDJWGvy
         17QBu0iHqwZJvRAhmLaUmv3NrmL2ga1F6Hj+xsrsA6jkT1dqFvPYfeAq4o8xz5bHW8fo
         26HpTupaaRVvE5uyV9acBxLfiF4kkcah7qxNkJscY/M2ts7Cb7qyg0OVyyhKTudDb2py
         Cw9v8O60qUB1UIPgfGK00TwyuKGmsxUTv5xNgds6nyhbXBKOJo0W3sBRTbSnUOXqwlYa
         eHiVYz4aYaUWV9XJxyHcSpyx34VkYhlphBNxzX5LMUBallpGGecVgqvCvk8YaBJWdw1X
         TvDw==
X-Gm-Message-State: AKS2vOyh7JhlzFOMMlwoc0OUaZDy6SUd4zNNvZ/4Vp+qZI3OchWqVPE6
        +W4AEfMvjGW6rUptqKA=
X-Received: by 10.80.151.219 with SMTP id f27mr3100245edb.126.1498774961128;
        Thu, 29 Jun 2017 15:22:41 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] grep: remove redundant and verbose re-assignments to 0
Date:   Thu, 29 Jun 2017 22:22:20 +0000
Message-Id: <20170629222222.4694-5-avarab@gmail.com>
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
index 86dc9b696f..7fcdaa0753 100644
--- a/grep.c
+++ b/grep.c
@@ -174,28 +174,18 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
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
@@ -205,7 +195,6 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		 * "cannot use Perl-compatible regexes[...]".
 		 */
 		opt->pcre1 = 1;
-		opt->pcre2 = 0;
 #endif
 		break;
 	}
-- 
2.13.1.611.g7e3b11ae1

