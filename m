Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A76EC43460
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0679861363
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 17:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354885AbhDGReq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 13:34:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354886AbhDGRei (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 13:34:38 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D87C061761
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 10:34:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id b133-20020a1c678b0000b02901231346381dso1611966wmc.0
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gO0AxTlSP9JgWbiUcJUymvi+2jRVcSGEQ7hJF8nhFCo=;
        b=NfAqWj3Gm/hvkruLk0VrGa6Pb/KZb7FXfOZOl4vygMPl8zoHx19guAA0OE7yCcR1CJ
         XEtGxxIb+9YSgqyTGJNW+bpZCOu1Y7bIo6legtXaNR4n5WTbCGByfRL4nXRsWVs9GxNc
         CBPxLEXZNvAhpZiWNJUNe3uAqhmxWj/BYdFTmDrdsa+oTU1jpWw4thxOxLSZTwVHAZP3
         OB8Kv8fauT74jp7F1pntaxbRtBMVFZg+h7fOt9Wy0EWT1SajhhaBD4pu8v4b/soE/+Gb
         ewO30pYO8eYUjE/T+ZSQSzwSQfbnWpgWC5ozPHgd53YRUeIyxJE8XQs13gzfRxgh1WZJ
         zdDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gO0AxTlSP9JgWbiUcJUymvi+2jRVcSGEQ7hJF8nhFCo=;
        b=l06wxoJHy0qJVxcniqWjvfrwV70bIBMkb8OVx2I5qTMNtUCo5HvqynVIdnalLBQ6MI
         4h5z8ai0Da8DvxRBmEiLCGkmSqm/d6HzuO21m2lBG3bhCG1GUJBVPIifZj57Ftox2TZf
         KRiOwuufBOV44xFX3FeSkbVhxCU2+VekOutisUzfOxMs6Pk8a2JKhm7JJpMLkAeJ6iZ0
         MXiZr36sJPQHezfI3Y4e1tuUG7UaoJfexmMH4ykBCtEJ2v4NF4SNzyw9nrDf7iFQucLf
         a0jFQysgzIligQkW2j4hVsjH8S/Uih3M33/67NilJZuHLyYCeXLTRTupW5mqfgTqdgBp
         j7GQ==
X-Gm-Message-State: AOAM532s/L0F6PrMMPyOIHDh2ZpWt9G/Nk6QVwybbJjJSWFZp8ljND5m
        6EDJxjQV7lhsMbPoBQ9dxuoJialDZFjSow==
X-Google-Smtp-Source: ABdhPJzKzgoXL8miVH9WYkjfvY3VuCwm4VtXVEB2MIG/zlmmzsRizvqCzaXwIVt2ClIS1iYulzji4w==
X-Received: by 2002:a1c:f407:: with SMTP id z7mr2745553wma.20.1617816865412;
        Wed, 07 Apr 2021 10:34:25 -0700 (PDT)
Received: from localhost.localdomain ([81.0.37.230])
        by smtp.gmail.com with ESMTPSA id o7sm41657197wrs.16.2021.04.07.10.34.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Apr 2021 10:34:25 -0700 (PDT)
From:   Miriam Rubio <mirucam@gmail.com>
To:     git@vger.kernel.org
Cc:     Miriam Rubio <mirucam@gmail.com>
Subject: [PATCH v2 4/4] bisect--helper: retire `--bisect-next-check` subcommand
Date:   Wed,  7 Apr 2021 19:33:33 +0200
Message-Id: <20210407173334.68222-5-mirucam@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210407173334.68222-1-mirucam@gmail.com>
References: <20210407173334.68222-1-mirucam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

After reimplementation of `git bisect run` in C,
`--bisect-next-check` subcommand is not needed anymore.

Let's remove it from options list and code.

Mentored by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Miriam Rubio <mirucam@gmail.com>
---
 builtin/bisect--helper.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 31c5f99660..c20f43c581 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -21,7 +21,6 @@ static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-reset [<commit>]"),
-	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{new,bad}=<term> --term-{old,good}=<term>]"
 					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
@@ -1192,12 +1191,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			return error(_("--bisect-reset requires either no argument or a commit"));
 		res = bisect_reset(argc ? argv[0] : NULL);
 		break;
-	case BISECT_NEXT_CHECK:
-		if (argc != 2 && argc != 3)
-			return error(_("--bisect-next-check requires 2 or 3 arguments"));
-		set_terms(&terms, argv[1], argv[0]);
-		res = bisect_next_check(&terms, argc == 3 ? argv[2] : NULL);
-		break;
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-- 
2.29.2

