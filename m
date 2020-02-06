Return-Path: <SRS0=KD4O=32=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA616C35247
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 20:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A416D21741
	for <git@archiver.kernel.org>; Thu,  6 Feb 2020 20:53:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MinqNdlj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgBFUx2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Feb 2020 15:53:28 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46830 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727698AbgBFUx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Feb 2020 15:53:28 -0500
Received: by mail-lj1-f195.google.com with SMTP id x14so7587649ljd.13
        for <git@vger.kernel.org>; Thu, 06 Feb 2020 12:53:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvioO68ZdfPHSHgR06fOUVbF4sNENIGcUgMajVPcQUg=;
        b=MinqNdljjpg6+WMYzamIi+8RbpvG1zKumnxa0Uz6+8zjrUa9ueyqPqa/YI3U2vB5XU
         qW6Q+7F2GryV9LGePsp6lhbrCjMrPvezbpsKBUY8t1WF7HpJatpbGhsyW7vva8rlhcfw
         dE74ozMmX5S8vKiebSNmlj43wGXz+KmK/kV9iq0fOy9M0EXlkisksL32KOjNU9muLz+t
         /vwWjByBL+FyY6BpZseSW/khcl4/bIIBmLp9WYJqvTh+BZZYSKHGvVs71bdZ9vY9u0ko
         nacs06f0Xx/jlyFNV31/GSDpwD3ww8Mev4gwiILweicR6+zd8kf6qISKt4/6Jlea1DGH
         YVSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvioO68ZdfPHSHgR06fOUVbF4sNENIGcUgMajVPcQUg=;
        b=RtPIEreblIrIejKJIu99xHLXzCZmIT2xRbEkNlvN5yeGPEUjl/IF7LMNCFrDmO+vLU
         AzxdZy0d14TYT4ADq6mkwGNlh45RUGGoAdqVx+VMGWihx1mBz2KB41XZQk+oe6/nl5IA
         2Ww2T3v7oqycRalkEHVBwV1EA01qpQIZ14bx49Jj7sBEsd/wrY8C5nvwmRLqwmmJK8nu
         ilyKIw7cik5FX7wnsBl5v5uKLf3284nyD3Jfk28Q2C5hcFwt6tqDMMLHTvdfaXj9EMy2
         WNmLQhcN5Y+ZNI1751GDmSrSoewcaycgF4ga33ZmvGJ5Wjw1kVUNFbvpbtCbtPatTCVE
         lfog==
X-Gm-Message-State: APjAAAXlrV2udP9rdYx7Uos+QZNaoR2ENDQ/p297tAO+VMOLnJyYk+ov
        CUUgCh5Wr6/NYBwkW2cZAEZzMuds
X-Google-Smtp-Source: APXvYqzXhtCnE5x/8FGb/6NvliRPAAO+RzGFbtmaoeTJj2FiBQA/MdTLodRrPzvYlOaZ15NehyjzdA==
X-Received: by 2002:a2e:965a:: with SMTP id z26mr3349087ljh.104.1581022405868;
        Thu, 06 Feb 2020 12:53:25 -0800 (PST)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id n2sm211890ljj.1.2020.02.06.12.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 12:53:24 -0800 (PST)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] diff-options.txt: avoid "regex" overload in example
Date:   Thu,  6 Feb 2020 21:53:01 +0100
Message-Id: <20200206205301.27367-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200202204739.GA24686@dinwoodie.org>
References: <20200202204739.GA24686@dinwoodie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we exemplify the difference between `-G` and `-S` (using
`--pickaxe-regex`), we do so using an example diff and git-diff
invocation involving "regexec", "regexp", "regmatch", ...

The example is correct, but we can make it easier to untangle by
avoiding writing "regex.*" unless it's really needed to make our point.

Use some made-up, non-regexy words instead.

Reported-by: Adam Dinwoodie <adam@dinwoodie.org>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/diff-options.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 09faee3b44..bb31f0c42b 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -567,13 +567,13 @@ To illustrate the difference between `-S<regex> --pickaxe-regex` and
 file:
 +
 ----
-+    return !regexec(regexp, two->ptr, 1, &regmatch, 0);
++    return frotz(nitfol, two->ptr, 1, 0);
 ...
--    hit = !regexec(regexp, mf2.ptr, 1, &regmatch, 0);
+-    hit = frotz(nitfol, mf2.ptr, 1, 0);
 ----
 +
-While `git log -G"regexec\(regexp"` will show this commit, `git log
--S"regexec\(regexp" --pickaxe-regex` will not (because the number of
+While `git log -G"frotz\(nitfol"` will show this commit, `git log
+-S"frotz\(nitfol" --pickaxe-regex` will not (because the number of
 occurrences of that string did not change).
 +
 Unless `--text` is supplied patches of binary files without a textconv
-- 
2.25.0

