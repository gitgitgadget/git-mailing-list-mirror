Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8154C433FE
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242410AbiBDVVO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241881AbiBDVVE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:21:04 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B580AC061401
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:21:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s10so10992999wra.5
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XzdgwU8RRIe5yFiWP9ykEdLW0y6riuT+J9AQ/6zgWFo=;
        b=Ia7GD/B731ZP8vAmP7Ca9KU+La2bc7spYaopZqWxIZNFXql/idK37/A6CLEejRoR+f
         ihgh85akcVgvsRrJ4AOupWwf+576X8ujAdps51f+mJsf+oix3/i86T1fNwa2Qd4dHsmN
         i9ut1ZVRuO6+emGjZpdN3vV8ozcnZ/e7Rjz5u/xeGc4NwU49BDS80SUkzkaqWbcrKPwq
         7AoVGRKT3euvwDxc/2pmOjlCvGN4LclfypcNYZTmE+a8S0eu9L1bDDNQz79jkqV93vwX
         2oxa3aA9wyUtSjp2xdSmGXKc9lg2U2ttb0Rf7tmDanBNRrD/SE76NemKEMuNvUalPOua
         jq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XzdgwU8RRIe5yFiWP9ykEdLW0y6riuT+J9AQ/6zgWFo=;
        b=RVwoTorYpC4bR+RurCUlV4TmeiXTI2/gEF9OfXYssqThbDZVUO339RnOnBWjmXLKpi
         gdI+HvmpLz086XxAcYMPWQcnlnzoWWvub28oncQ4IEMB1jE+GvFdX33dB5SUnBPHs3Es
         gA4mNHmsMj8Ih9VBCmjmEQkV2BXu8tGFHkQylKTEhuGTJPaJL7yOV01UkGRQ7xf+Okwy
         Gum/k2SBdGVr6y3nG5csVfYnmoQ3ML8VyV8yeECt0GuLErqdOUwrEyPMpSTkUmYhETN2
         u/Up2ioamox63TfAGRycr9ifS2oG/2bQ7cJmx2/9MRUi5Rkxy+yqcX0SUQhvocNP66ru
         yIJQ==
X-Gm-Message-State: AOAM530KVxDFJncXqMpxoIdyVU9ZtZaRQV/pPtZJmiRmx7bbPYUGxn7a
        dGoR7JLc1OihI9J+alV7HfaUXf1SJFF29A==
X-Google-Smtp-Source: ABdhPJzmpZxRDmj86XCdL3E0iytTmKMysH7j2Y7RGk9yi7+bvdQkU90pja6rZBvS8FiomU3DzJcpvw==
X-Received: by 2002:a05:6000:1881:: with SMTP id a1mr585006wri.561.1644009662112;
        Fri, 04 Feb 2022 13:21:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:21:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 8/9] grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
Date:   Fri,  4 Feb 2022 22:20:50 +0100
Message-Id: <patch-v10-8.9-df8ba5aba68-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com> <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code in compile_regexp() to check the cheaper boolean
"!opt->pcre2" condition before the "memchr()" search.

This doesn't noticeably optimize anything, but makes the code more
obvious and conventional. The line wrapping being added here also
makes a subsequent commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/grep.c b/grep.c
index 35e12e43c09..60228a95a4f 100644
--- a/grep.c
+++ b/grep.c
@@ -492,7 +492,8 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	p->ignore_case = opt->ignore_case;
 	p->fixed = opt->fixed;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (!opt->pcre2 &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
-- 
2.35.1.940.ge7a5b4b05f2

