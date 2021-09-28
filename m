Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B1CC433FE
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C94A961131
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240764AbhI1NQa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240732AbhI1NQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:23 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF39C061604
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:44 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id d26so409520wrb.6
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Y/K37CLslmBOGjQtg0CREEHlDXNbAwZD8skEKjGK6M=;
        b=kwSfRM7f1qiJ8dTw9mCNZEWny8lqSVQ0aELwJuYtWasvLn1w4O90cD1dI5G8RodurL
         R9KDcby6QEL1sPZv/P3iOEXU0xWK3NdPocuadxtzXYMbKx2/XvngTB3M+/09obJIwObM
         5yFZMiv+odMW71cqKR2NYU+yRufmgMCg0hX2NQGdwyd33EdgNg5rKvXn62OdYtpMg9Rp
         9sgzQHemAH/YO+eHUfYVEDgZjrJr8O0OdLRUIIHNUBaCW3isfQ7dyoQdYlFOpJTRMcmv
         jpTGwPPqLKuZT85tXJEYvUoZ5ZM872gGz5Uj4WztpMwCoD/OHGDDzYs/fnb/+4VwfshB
         6qcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Y/K37CLslmBOGjQtg0CREEHlDXNbAwZD8skEKjGK6M=;
        b=xCvSX2rCUoV4yya9ICcq3fNACuJwuluTUuZl7QJ3gPvAMFT7MNoJpdHwX2aO/P+Vo7
         JL2eyXv1a5+QAeCpZv2tm0pvmcFqUwNK4GNmw5Lqjr7VG6sNba/nwvvX8QZMn99l4gmx
         4Xf6bScxJ9rn3uJkFb27rho0AEzex9JcYSlV0FI5edlnYogGCJWh4zLpfH7DMNlidGU+
         Wju5PvKpW0h6HM07CNxOgfpjmL8wRqpyOAbMdXr3fe00LkR2IPtZJcWeZniq4rBlxvwj
         zMkGrBrtlh1EpsLhiIdaGP4zn40ePZfHHuINPQ5mc0HIgeKD4YesuWB+bBxMsbB49YQo
         N9DQ==
X-Gm-Message-State: AOAM532KXjgXbS5WMsWPwGt/WNpcGgzBrNjsP6EC8uLjDPwzY1Hierwj
        IFXE/p9t1F4XKdZJ2QVQq8ZRZIb8xRE01Q==
X-Google-Smtp-Source: ABdhPJyADK4qmemre8OEiFNnknpJdH0CreV6/7N1HNTiAM8cTEYDBNDePkwTAg9AZ+DK8KxKPC4QVw==
X-Received: by 2002:adf:f748:: with SMTP id z8mr3038844wrp.82.1632834882782;
        Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/10] parse-options.[ch]: make opt{bug,name}() "static"
Date:   Tue, 28 Sep 2021 15:14:29 +0200
Message-Id: <patch-08.10-07ba0e6f995-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change these two functions to "static", the last user of "optname()"
outside of parse-options.c itself went away in the preceding commit,
for the reasons noted in 9440b831ad5 (parse-options: replace
opterror() with optname(), 2018-11-10) we shouldn't be adding any more
users of it.

The "optbug()" function was never used outside of parse-options.c, but
was made non-static in 1f275b7c4ca (parse-options: export opterr,
optbug, 2011-08-11). I think the only external user of optname() was
the commit-graph.c caller added in 09e0327f57 (builtin/commit-graph.c:
introduce '--max-new-filters=<n>', 2020-09-18).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 4 ++--
 parse-options.h | 3 ---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 238a283db5d..57e95846e83 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -11,7 +11,7 @@ static int disallow_abbreviated_options;
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
-int optbug(const struct option *opt, const char *reason)
+static int optbug(const struct option *opt, const char *reason)
 {
 	if (opt->long_name) {
 		if (opt->short_name)
@@ -22,7 +22,7 @@ int optbug(const struct option *opt, const char *reason)
 	return error("BUG: switch '%c' %s", opt->short_name, reason);
 }
 
-const char *optname(const struct option *opt, int flags)
+static const char *optname(const struct option *opt, int flags)
 {
 	static struct strbuf sb = STRBUF_INIT;
 
diff --git a/parse-options.h b/parse-options.h
index 74b66ba6e93..dd79c9c566f 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -224,9 +224,6 @@ NORETURN void usage_msg_opt(const char *msg,
 			    const char * const *usagestr,
 			    const struct option *options);
 
-int optbug(const struct option *opt, const char *reason);
-const char *optname(const struct option *opt, int flags);
-
 /*
  * Use these assertions for callbacks that expect to be called with NONEG and
  * NOARG respectively, and do not otherwise handle the "unset" and "arg"
-- 
2.33.0.1340.ge9f77250f2b

