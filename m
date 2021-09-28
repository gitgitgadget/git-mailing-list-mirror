Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EACC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B63600CD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240747AbhI1NQZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240718AbhI1NQX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:23 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E22C061740
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:43 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id f78-20020a1c1f51000000b0030cdb3d6079so2733568wmf.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9+AKfWqP5PTcsFh1Y92T7q30jGoiSXplv/SwQO0S6Pw=;
        b=SCcEMBuDMQl7SBHycjpjwpJmpOLH1hnBcPjIFolr8u2ZWBA+GMg+4w7tqSZpFuYxIj
         Ycir9DqeowZBY8qEarnU4ImZrfZS6a3mU5QCQapnhiTJCqbo7gwn4pkLQXqkP2NYRpls
         ozjRx6+GyKEdfrVm+k9LuNJHYyDPzjqnA4Tb9j9if0LTSD3znF5guWZrgbvC1xj+2NmC
         ayid1KFqNVhrBmCi19YR5UsY+Cu/UIIhE9oVFMZ/h+DBIMJil5mFRsM0vMhJVlwvO7Ll
         4VTl0+pn1HAcaQ9zQVUC8aJBtFI8Pzwqd+LvWEgvAHFdcWzg96ZRE3OjbTTjwKjngK8S
         ILhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9+AKfWqP5PTcsFh1Y92T7q30jGoiSXplv/SwQO0S6Pw=;
        b=ilNXAxd8eqzxxcDeAQ1Svuic8PXne+u5Sa/oHpBck4HFTX8qWbrx+kVx1gxsTWubhP
         xGjVdYp2Ns6qoSS6LIyp96TqxtnKfXWl4xtNvd5Qbv29h1iKT1VmMpBJ50J88ZfU7iz1
         RJfasBSj4tN2/KOaQiZnfqvYL/wdf7Rux6Q1dXZ+zZcb8PFPwU1XAOcBNxglsDUk/zUL
         r6fshc6LDwjn8QFKGgnNpT3UNAGtnJutSadshmgZms5puwH8gBWIIMnnVwjRVcdFWVGM
         OJVWf6YNzjsawcnCWdgY2QEsx+d4cxIwrmsNB6Tc5RrT/z+9wJbne4Ar23D1LWFtnA2Y
         ZMBA==
X-Gm-Message-State: AOAM533VVQd7BmaeupJt3s4bmg1D7qtSSdSwnbkV7XEsyfL42UexT2O6
        nUD0AZNF9qBnPy8Fkp2nAhqnguaitxV+hA==
X-Google-Smtp-Source: ABdhPJz7PC9I1BeADIWruqqG5bCRj9T3ZMk8kTtUMk2q6TJ2rfZNftDdwkRt5pdQI2Jd4yIabcsqQA==
X-Received: by 2002:a05:600c:198c:: with SMTP id t12mr4751128wmq.128.1632834882057;
        Tue, 28 Sep 2021 06:14:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/10] commit-graph: stop using optname()
Date:   Tue, 28 Sep 2021 15:14:28 +0200
Message-Id: <patch-07.10-b0b313795c7-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop using optname() in builtin/commit-graph.c to emit an error with
the --max-new-filters option. This changes code added in 809e0327f57
(builtin/commit-graph.c: introduce '--max-new-filters=<n>',
2020-09-18).

See 9440b831ad5 (parse-options: replace opterror() with optname(),
2018-11-10) for why using optname() like this is considered bad,
i.e. it's assembling human-readable output piecemeal, and the "option
`X'" at the start can't be translated.

It didn't matter in this case, but this code was also buggy in its use
of "opt->flags" to optname(), that function expects flags, but not
*those* flags.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/commit-graph.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 0386f5c7755..36552db89fe 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -172,8 +172,7 @@ static int write_option_max_new_filters(const struct option *opt,
 		const char *s;
 		*to = strtol(arg, (char **)&s, 10);
 		if (*s)
-			return error(_("%s expects a numerical value"),
-				     optname(opt, opt->flags));
+			return error(_("option `max-new-filters' expects a numerical value"));
 	}
 	return 0;
 }
-- 
2.33.0.1340.ge9f77250f2b

