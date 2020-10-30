Return-Path: <SRS0=4tT/=EF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59171C00A89
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1A3206E5
	for <git@archiver.kernel.org>; Fri, 30 Oct 2020 18:07:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=powertools-tech.com header.i=@powertools-tech.com header.b="booUe86q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgJ3SHZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Oct 2020 14:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbgJ3SHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Oct 2020 14:07:25 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 891C7C0613CF
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 11:07:23 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k125so3085275wmf.0
        for <git@vger.kernel.org>; Fri, 30 Oct 2020 11:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=powertools-tech.com; s=gsuite;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=NbU/YIvegXVeGFnwdMpN5cm8mr/TJ5g8lLMikR5PLsk=;
        b=booUe86q9hUB0TTmpZIbHV1vLvOTnBbc79cYdAVGXH2O0PvPA65ujehjmYDYF3eYyt
         yQ9Xmu+1CLl1YJYzronrudTFpSLWRpivE0OBh1G9E9gCbd3HQDtPa+GD1rQPzD7ZS+qD
         vI3pbRKRjTLq5OfdT0dRiddgWkgwl3/vMf0Ak1m4/nm+z8F91OtULfj4QG1dXZo9Z2XP
         CyLAi9zrkvjXdH2G9+DhSmS/0JmXpXxS28GUtWIz8BIuxVAROllg+WrEGSkfZboTEnU2
         lhmdS9WF3C4d2wHWrZbZQ1VGubvJpIL1IDhfCOCsaydAcvCH2SHJrOL2x1rf8m0AhroY
         nREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=NbU/YIvegXVeGFnwdMpN5cm8mr/TJ5g8lLMikR5PLsk=;
        b=KgkaqiTb42dlqvhWKmf2GLHfgm6u+r6XS4ed/aIiBrWvYBXkQTPWN8dwjGB93ApD4S
         GMR38Oa7kTXCrJhLrKPQHm/C2Do6DFzJVTFy1VmZWLAM7lEo+VXuEhFo49KvWixfwsJ4
         yA60J7y21Yr9bAu8YUIXxLC6L+dZpCaayAZb1BlpHYnZ1tmN6EBlxGlBIdO7j/7PgmoR
         fmlqd9RX8jhvT9Vcrwgh3VQppGUzAd8f4RAHjU2kI4S1ryX3mlIPaIfWIgXXzUuv/3vQ
         A/9rN7zmry5GNmllbcLk3M4UelW12+5os+MaZvRr1ZyTyxmuKgx7weDMM9Hhxxc1J2R4
         k2lw==
X-Gm-Message-State: AOAM5329+AKnYGU5gMmjHzfOYssCu/j4aYxVUPCH3t8/Ri7C+tK2gTl7
        5hf1a3FgObtpr/ZIv6y1N2F4iZH9sMdE4yIv
X-Google-Smtp-Source: ABdhPJzOwvj0EAKo6HCljGs6OGj0ytoCUB7Nu+Pw52qPdCtGkBYz34nTe34FTDejHvUkGdpuOMc9mA==
X-Received: by 2002:a1c:99d3:: with SMTP id b202mr4050275wme.0.1604081241838;
        Fri, 30 Oct 2020 11:07:21 -0700 (PDT)
Received: from localhost ([2001:470:1f21:ea::ffff:dda4])
        by smtp.gmail.com with ESMTPSA id v24sm11741104wrv.80.2020.10.30.11.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2020 11:07:21 -0700 (PDT)
Date:   Fri, 30 Oct 2020 18:07:18 +0000
From:   =?utf-8?B?U2ltw6Nv?= Afonso <simao.afonso@powertools-tech.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH] credential-store: use timeout when locking file
Message-ID: <20201030180718.4i7txqkgye7r6pkb@safonso-t430>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When holding the lock for rewriting the credential file, use a timeout
to avoid race conditions when the credentials file needs to be updated
in parallel.

An example would be doing `fetch --all` on a repository with several
remotes that need credentials, using parallel fetching.

The timeout is hardcoded to 1 second, since this is just to solve a race
condition.

This was reported here:
https://lore.kernel.org/git/20201029192020.mcri76ylbdure2o7@safonso-t430/
---
 builtin/credential-store.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/credential-store.c b/builtin/credential-store.c
index 5331ab151..acff4abae 100644
--- a/builtin/credential-store.c
+++ b/builtin/credential-store.c
@@ -58,8 +58,9 @@ static void print_line(struct strbuf *buf)
 static void rewrite_credential_file(const char *fn, struct credential *c,
 				    struct strbuf *extra)
 {
-	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
-		die_errno("unable to get credential storage lock");
+	static long timeout = 1000;
+	if (hold_lock_file_for_update_timeout(&credential_lock, fn, 0, timeout) < 0)
+		die_errno("unable to get credential storage lock in %ld ms", timeout);
 	if (extra)
 		print_line(extra);
 	parse_credential_file(fn, c, NULL, print_line);
-- 
2.29.1

