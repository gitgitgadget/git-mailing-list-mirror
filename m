Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A695C433F5
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbiARPzo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346079AbiARPzi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:38 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F805C06161C
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:38 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id w26so28682725wmi.0
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=44E2QQjApQiFIbq9QhTLYaN8aThUFeOEerdUja7PAtI=;
        b=WKygFcZNKUMaEuDSRW50UnK05Zy3apw7B57nq+RMhVznZ6M/NHcKPF1mtCe+QFzFg9
         hoRDfVI6DiDJfnbtU4hRu+bmwfO5S90MoBC7YHbZqoDWhWprDefa6B2CA/lGWOTh3cIC
         0QiORdr+jUDOgKzOQgRBzmmYkfOSNCaolpy23h5jCDuyuiGfzSIfDXotp4vcSgbY4Du2
         /KUHEKgEn+hDS4cOGEG1WEc1186XnoTiUcVWTCaU+S/skHHJLyyWLJwHQlD2vjeXOYlI
         iCD3ybV1oNdvP1fp3JUK59X3bvAEm1IT550gPkVgIDyABzks+RkC6+0TJtcgh9/0y8tc
         Xabw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=44E2QQjApQiFIbq9QhTLYaN8aThUFeOEerdUja7PAtI=;
        b=7Dk4RHsw2LxkK3t6gW0Q1SBOPH4DRm1xMJ7mGJFoZ8YTIUIf9bbBobUOZj64hPRihW
         MEOPw5Yv6xe2hPLvSSAg15JVv58MtKcZbOGRd0BpQuJGqI9CTymBA9cSrcbupi02ZnVE
         KOux5WnsPBF9qqFj6JhHRiChzhtCj3AF47C4OXfaq3pHMKHiBnqobQzh4fK6WU1jRXdR
         gUOnDQvUjseO67FsQZ7Mv7CRxDB46dZXQFbX3AvrctVJVV3pZNSU/vuXx3oXCWECmGt9
         gZ2BkHC/o4ewM2wFmKNa0lH7DM1V+EMYbc9uvEH7J4K0xKsozWDjPqHgHHHLQfCdRFEX
         ngDA==
X-Gm-Message-State: AOAM531H0gKjzhy0v0q1PWZszJM1wufGmMVmnWEJm4lU/Snd6H3oxyKO
        rzuHRKjm9oSGtCL8xutfPCjp7V371NjRiA==
X-Google-Smtp-Source: ABdhPJxDMgA0UAbER/q+Y+BIUkrgEBfdXTYpXSBUrO0nZGOPT/aTCSDxsKlGwC3xuT8wwIy9sxj4BA==
X-Received: by 2002:a05:6000:1c0c:: with SMTP id ba12mr22310337wrb.285.1642521336774;
        Tue, 18 Jan 2022 07:55:36 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 08/10] grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
Date:   Tue, 18 Jan 2022 16:55:20 +0100
Message-Id: <patch-v8-08.10-62650a78ea9-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
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
2.35.0.rc1.864.g57621b115b6

