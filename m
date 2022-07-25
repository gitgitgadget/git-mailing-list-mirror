Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372D8C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 12:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiGYMje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 08:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235169AbiGYMjT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 08:39:19 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325851A835
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:17 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id z22so13746525edd.6
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 05:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uUPpPT1X+2APcEByrVV5GZFx7noShyjLLXjYOC9evMw=;
        b=O7vcBb+RzLBuz+tzPUqpKhxnQGyNEz9SMqjFABMur7Yhflk/f3sNdb3X/NSyfk0YX0
         gyOuWrtuVdj12p1pod3TUMtYPTeTshjehKoZ6NBcDQLPd9ogHl2mzhjIoK+vcvw5Eur/
         j5oJ9yeQ40JTPRAdxQYcomFjmzxKKnxonjoHhgSqJ1NjU2mcg1evUILnzsg89xAxjfiT
         kJM9jYAt7YV4FwvObSnyvruQbvUx81UlH1Cwkh1hWciAiVpXYRh1hrmQFW0Uj9zB4Uqs
         BY477mikuThoWrJAidkzFaMBrxP2hhOpOwYvFNwW437tItYn3RSK88G4Wv4GJ+mDmCoS
         3s7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uUPpPT1X+2APcEByrVV5GZFx7noShyjLLXjYOC9evMw=;
        b=1fKO4NEMaACeoazBQbpQKDAxzh/JyT0KWM21GX/YahSM1vi8sryWKIDXdMehawKhyr
         2hfb0Gw7AEVUt28rHdKr7KFSlUn6Vi3Op6xePxe2zJdQXFBX4S9PFgB1ZXjA81FZYjBu
         fpkPnadDcMsZDmA3QMu4ZknXsLOH3AmLo88rNAeMHtE++JODXmQdma3gpra+G2V959qJ
         K8tmOvwfiuyNpEvkPpv5Uyn1AH2mNRtCBhOYfH1wCcLivDF7XlWvRQJae84kZLQ7M8Gk
         g8laIQXB/+m1MwDCGTZlZ9Zya2gAw9ui2gTD54R7ZAj8jSvVqwoe4hpF9qn8QX+HuAaP
         Amdw==
X-Gm-Message-State: AJIora+otYaNSbwBFcGofBOuQP47n9Z6TsrDCAb7Q7p5j0hJMINrDNtE
        VvvNnxN7JfFfObsLvyWQb0yhZdpS5KQ=
X-Google-Smtp-Source: AGRyM1sOUBkpE1EEy9R0E5vgkkPdqwF20mRpncWaIt5yeKzG+LWcvAS3YxqmaF3d5e163+CpQP+puQ==
X-Received: by 2002:a05:6402:190e:b0:43c:34ba:1903 with SMTP id e14-20020a056402190e00b0043c34ba1903mr997368edz.229.1658752755570;
        Mon, 25 Jul 2022 05:39:15 -0700 (PDT)
Received: from localhost (94-21-23-94.pool.digikabel.hu. [94.21.23.94])
        by smtp.gmail.com with ESMTPSA id i15-20020a50fd0f000000b0043b910de985sm7100924eds.74.2022.07.25.05.39.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 05:39:15 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 08/20] parse-options: drop leading space from '--git-completion-helper' output
Date:   Mon, 25 Jul 2022 14:38:45 +0200
Message-Id: <20220725123857.2773963-9-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.1.633.g6a0fa73e39
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The output of 'git <cmd> --git-completion-helper' always starts with a
space, e.g.:

  $ git config --git-completion-helper
   --global --system --local [...]

This doesn't matter for the completion script, because field splitting
discards that space anyway.

However, later patches in this series will teach parse-options to
handle subcommands, and subcommands will be included in the completion
helper output as well.  This will make the loop printing options (and
subcommands) a tad more complex, so I wanted to test the result.  The
test would have to account for the presence of that leading space,
which bugged my OCD, so let's get rid of it.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 parse-options.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a0a2cf98fa..8748f88e6f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -620,7 +620,8 @@ static int show_gitcomp(const struct option *opts, int show_all)
 			suffix = "=";
 		if (starts_with(opts->long_name, "no-"))
 			nr_noopts++;
-		printf(" --%s%s", opts->long_name, suffix);
+		printf("%s--%s%s", opts == original_opts ? "" : " ",
+		       opts->long_name, suffix);
 	}
 	show_negated_gitcomp(original_opts, show_all, -1);
 	show_negated_gitcomp(original_opts, show_all, nr_noopts);
-- 
2.37.1.633.g6a0fa73e39

