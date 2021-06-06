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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 694E2C4743D
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C9D9613EF
	for <git@archiver.kernel.org>; Sun,  6 Jun 2021 18:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbhFFSul (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Jun 2021 14:50:41 -0400
Received: from mail-oi1-f175.google.com ([209.85.167.175]:46743 "EHLO
        mail-oi1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhFFSul (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Jun 2021 14:50:41 -0400
Received: by mail-oi1-f175.google.com with SMTP id c13so10234645oib.13
        for <git@vger.kernel.org>; Sun, 06 Jun 2021 11:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qA2rOvV73eh/ZtL1yKv0TyujlQKvNbtW1ksyilAmOtU=;
        b=ihMDSbnp/smIGm2qYymqRblpuDiNUYmViZ4N+d+12BAWSAfD2V3s1q4rKCq+3LtXIz
         C6ORuGbWj90rt4/1zv1Xk6dh/2//bcS0HfUjBljV+09FH+aeREqmPPk03dOCTyp7PU11
         2UubunLiAsE5T+GOCXicS2ELEh/wQaNMInHaEz6tsjLfkRbnbSLFInREIQxV5xvHZyV5
         U6K9j+T5QutG1D/7XDKwV4bOKKFMnVqFwed7tsR2FIr4SlbRJnJxC77VoBQwvFKY4pz3
         T/2nmdQ/zHP+vNukfK3ijQZ4E9WyT4SMUND8UCMMHJSysihcjNqKwUOnny2LaYwCLErz
         zkEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qA2rOvV73eh/ZtL1yKv0TyujlQKvNbtW1ksyilAmOtU=;
        b=kWzGIv4H4yHVOF6/W9cUCzefCpvWI8elsbAMrCUkpLT528lyZ0wpaamPlwaxTaeNNL
         +QU0ToBNCN+ZV7VUNX6U5TMS0Td+cksL1mFHSxcJtl+G2UgtWKwN8EUAlcYQmLwppveF
         E3dLOfUvcgxzTRIDWQ88+/MBxAhi8tpRZJ/4Up4l9b5L9FjNKU9rr9Yc/hvOIu23jXZ7
         IlEpeeoyqsqrscBSuGT99EUd3ujUzVOOriNFdTsJA/tgEBmtYavP6Bhv/PxAR1m1+hsG
         kNIVE/xA56CWYmoXjODaTACD3Dy+bUzhbWV563lNugFXuqTDH+cdQSov86xQU08ZllNd
         zMug==
X-Gm-Message-State: AOAM533D3R5ynHXiScTcqas1pRXuse6jFcOLW0Xwvr2EzUGWZ4BIPXuS
        ynh1moT+D+HV7on3AbNkPjKTZ7gOsVE6ZQ==
X-Google-Smtp-Source: ABdhPJyop+YW21e5en9rAsBH6BNW7/jsd/t1xH4yx0ykHl+GHm38TlnPPfOricKmFa6Z/qnsyDcjLw==
X-Received: by 2002:aca:edc5:: with SMTP id l188mr3936543oih.134.1623005260412;
        Sun, 06 Jun 2021 11:47:40 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c19sm1803087oiw.7.2021.06.06.11.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Jun 2021 11:47:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 try2 1/4] completion: bash: fix prefix detection in branch.*
Date:   Sun,  6 Jun 2021 13:47:23 -0500
Message-Id: <20210606184726.1018460-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1.2.g0532ba4bf6
In-Reply-To: <20210606184726.1018460-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise we are completely ignoring the --cur argument.

The issue can be tested with:

  git clone --config=branch.<tab>

Reviewed-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index b50c5d0ea3..47b48fbab6 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2649,8 +2649,8 @@ __git_complete_config_variable_name ()
 		return
 		;;
 	branch.*)
-		local pfx="${cur%.*}."
-		cur_="${cur#*.}"
+		local pfx="${cur_%.*}."
+		cur_="${cur_#*.}"
 		__gitcomp_direct "$(__git_heads "$pfx" "$cur_" ".")"
 		__gitcomp_nl_append $'autoSetupMerge\nautoSetupRebase\n' "$pfx" "$cur_" "$sfx"
 		return
-- 
2.31.1.2.g0532ba4bf6

