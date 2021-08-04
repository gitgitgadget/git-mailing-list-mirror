Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34CB7C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 12:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 148DD60F22
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 12:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237523AbhHDMZR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 08:25:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238147AbhHDMZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 08:25:11 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA484C06179E
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 05:24:58 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id s22-20020a17090a1c16b0290177caeba067so8492745pjs.0
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 05:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZKrN3XNKNhn4YS1lu/zz5QDrEcvYcG2ftbOYCHN0c4=;
        b=NvCKM0UsIVgwlAN0z7M4VLh1NJehvzqbRl/oSRWtQ/1T/vqsR5GTvz3PiNvsx4+x1e
         aaFpLBdWNYV/3Oo5BotHA0uDyxoK9bum0BpevuEuYks1m/M6nytDs3Ul/UC7hEQvS2Hd
         k/BM1J6G/M0k9UA7vYbVV8wA2cpJoNd8lUZKiq8C5RIBqV019laIQL8ur88NmLAvzTMh
         tE3oMwfg2OQOynR3F+tgXYB82/ziQzQ/3jk5p/3GYAm/TsMRSBFQsbgUhohaJDbeT1RJ
         nYbRQmxRpenKNBrvpyml0DgEaoHyWJFgwLXJtO0+ecJZSxATaoYN/SQxfFOgL6ZG27qp
         rp5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RZKrN3XNKNhn4YS1lu/zz5QDrEcvYcG2ftbOYCHN0c4=;
        b=fLlnn2PPoHXatglTrlL5wk9jNrhiBtSIZFjekDsDICa3qagvMi6+t3yRoL+c0xZK9x
         vZU0wTkQZIG3URnN+o8mAvkHc5yl30dxuawo7V79A2wbw29SfdvBDw+6iWZFdoeQ0tDZ
         YtvjFlclTyQLrKeeN7OJ6jnojSVn26g/+h4IhWsIXre+tn9JxERJCHoPXcHfwJeaz4Ry
         F9QkhHSRKrMPtDpm/eQOSi7XfMDMqsghzgigKIfkGnViu4gko0auRBlokPgxLhtPOkbi
         W+WkTWqS3kK7+qtT9cveAz4WHbq9BPm4KAulHNFm2CIIZnxhB40b47vK26iZyM5+Zy/F
         M9hQ==
X-Gm-Message-State: AOAM532/Ni9CONv1Ns0IY6ivm2PUNbSw7zKt/sFsXKb09f1bsKdYbA5x
        xw+WXVQT6Vg8HV4gv72pKF1W2ebd5+Q=
X-Google-Smtp-Source: ABdhPJwiL20wp+sRn/SHiNF/BS92ovrzqJzGGr/jUnFke4ArVrim+I+aFxx4KRZVDFINigMIw/xxAw==
X-Received: by 2002:aa7:810d:0:b029:363:7359:f355 with SMTP id b13-20020aa7810d0000b02903637359f355mr27405380pfi.64.1628079898130;
        Wed, 04 Aug 2021 05:24:58 -0700 (PDT)
Received: from ubuntu.mate (subs02-180-214-232-12.three.co.id. [180.214.232.12])
        by smtp.gmail.com with ESMTPSA id n22sm2730951pff.57.2021.08.04.05.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 05:24:57 -0700 (PDT)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] diff: --pickaxe-all typofix
Date:   Wed,  4 Aug 2021 19:24:20 +0700
Message-Id: <20210804122419.53968-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When I was fixing fuzzies as I updating po/id.po for 2.33.0 l10n round,
I noticed a triple-dash typo (--pickaxe-all) at diff.c, which according
to git-diff(1) manpage, the correct option name should be --pickaxe-all.

Fix the typo.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 diff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 82f88de755..a8113f1707 100644
--- a/diff.c
+++ b/diff.c
@@ -4640,7 +4640,7 @@ void diff_setup_done(struct diff_options *options)
 		die(_("-G and --pickaxe-regex are mutually exclusive, use --pickaxe-regex with -S"));
 
 	if (HAS_MULTI_BITS(options->pickaxe_opts & DIFF_PICKAXE_KINDS_ALL_OBJFIND_MASK))
-		die(_("---pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
+		die(_("--pickaxe-all and --find-object are mutually exclusive, use --pickaxe-all with -G and -S"));
 
 	/*
 	 * Most of the time we can say "there are changes"

base-commit: 66262451ec94d30ac4b80eb3123549cf7a788afd
-- 
2.25.1

