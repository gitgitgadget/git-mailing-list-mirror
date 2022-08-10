Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 358CFC00140
	for <git@archiver.kernel.org>; Wed, 10 Aug 2022 15:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232932AbiHJPCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Aug 2022 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232916AbiHJPCk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Aug 2022 11:02:40 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70CD760CB
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:38 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id z17so18057723wrq.4
        for <git@vger.kernel.org>; Wed, 10 Aug 2022 08:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=TmBAYm4sYmaRuld1xeVh4ZPfnufQ3XTBy9onLsl+BK0=;
        b=Gq/7sCVvq9gyrdM6BUldGP+VWfOCB2wxY/dY/IUGgMAFG3tKXZn29EbvrBoXjSd05f
         23tpnk0OMkJXdKmIIijVs69DzYFMMYnAXgVAmhJd9GV1jCSpVchiJqHfpFD/Z3+u2782
         A2nEEXqhSl9ctRGaVZhzpYMEPSeNGIp6KSoVawKZa6bVvDa3/6U/xVIy4X2NE2dzrir6
         3t/bNwmEwRhfHWZRskD496xSKPneK1ddTnxb3A9mRSsQL0osVswryYsh0u88zL7y59UZ
         5sWBf4UdH3PUg+13exof6aJPyxCOyspOoRsrkyyaezoZbKsxABdDL2lwgpV21SlTZV9j
         Tt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=TmBAYm4sYmaRuld1xeVh4ZPfnufQ3XTBy9onLsl+BK0=;
        b=1zoJjIkHHhk1YggnOCbLVM+28YPRGFNbn0kkrLnMhhogpahOTwLLOqAscJHOUK0SUT
         bGmBghigZaMDGiOreC6ixa/q5LnamypcQsCuE5S6Xb/mSkBwWfmnC0/kKXqvFAwc5hDx
         OBWBreuTNSozlyo2Bq9i1YgoXG5uwOH7IpOPHuSR8OieAht1TDut5+jXo49wwjCpfBTV
         PU6zDfAWp62sJg/4UEwmF1UlryQgzL+Kj4sgqovwPA+RYXiXtEa0xcfzuO+o57LyIWjf
         BpWd+PQO4SkPmYHdBx0iUPybx6bJAUTyiCi1/y1kTckymnVkOIFSFe1L6xX9ET5Nfdyt
         xpgA==
X-Gm-Message-State: ACgBeo3mvBQPsYZ9/plHtjyGnE3R/Icwmxqtbytm5DWYfGGc+BOilXVp
        uOsnPWZrcmgp25muSwj5795PLIcRcHU=
X-Google-Smtp-Source: AA6agR4t9xjlmep9/mBPcCRysl/M09SYtsNW6vlj3mUXSe5g3do3B0rlYi/4k2xW0hMvjjpDsne7eA==
X-Received: by 2002:adf:f584:0:b0:222:cd33:fbbc with SMTP id f4-20020adff584000000b00222cd33fbbcmr9319640wro.624.1660143756758;
        Wed, 10 Aug 2022 08:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m8-20020a5d56c8000000b00222d4dfcdffsm6744562wrw.87.2022.08.10.08.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:02:35 -0700 (PDT)
Message-Id: <4d24a4345ba66031d2ccf7ce472ed93ace82e9d6.1660143750.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
References: <pull.1320.git.1660143750.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 10 Aug 2022 15:02:29 +0000
Subject: [PATCH 4/5] add -p: avoid ambiguous signed/unsigned comparison
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the interactive `add` operation, users can choose to jump to specific
hunks, and Git will present the hunk list in that case. To avoid showing
too many lines at once, only a maximum of 21 hunks are shown, skipping
the "mode change" pseudo hunk.

The comparison performed to skip the "mode change" pseudo hunk (if any)
compares a signed integer `i` to the unsigned value `mode_change` (which
can be 0 or 1 because it is a 1-bit type).

According to section 6.3.1.8 of the C99 standard (see e.g.
https://www.open-std.org/jtc1/sc22/WG14/www/docs/n1256.pdf), what should
happen is an automatic conversion of the "lesser" type to the "greater"
type, but since the types differ in signedness, it is ill-defined what
is the correct "usual arithmetic conversion".

Which means that Visual C's behavior can (and does) differ from GCC's:
When compiling Git using the latter, `add -p`'s `goto` command shows no
hunks by default because it casts a negative start offset to a pretty
large unsigned value, breaking the "goto hunk" test case in
`t3701-add-interactive.sh`.

Let's avoid that by converting the unsigned bit explicitly to a signed
integer.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-patch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/add-patch.c b/add-patch.c
index 509ca04456b..3524555e2b0 100644
--- a/add-patch.c
+++ b/add-patch.c
@@ -1547,7 +1547,7 @@ soft_increment:
 			strbuf_remove(&s->answer, 0, 1);
 			strbuf_trim(&s->answer);
 			i = hunk_index - DISPLAY_HUNKS_LINES / 2;
-			if (i < file_diff->mode_change)
+			if (i < (int)file_diff->mode_change)
 				i = file_diff->mode_change;
 			while (s->answer.len == 0) {
 				i = display_hunks(s, file_diff, i);
-- 
gitgitgadget

