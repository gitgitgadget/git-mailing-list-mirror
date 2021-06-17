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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F78AC2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0064861406
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 14:35:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbhFQOhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 10:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbhFQOhj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 10:37:39 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E731C061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:31 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id d19so6748809oic.7
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 07:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4T+EJLf4Ceh1ssFeIo8IWSBtRXtHLXqpgec0mvEHDjQ=;
        b=ZvnT6GfOKcQcvF3pPmuYB4t+nXx7AuuLoZav8wFwf4aWR3lGrDsTGqR1mIx2zGQldl
         a1Nl/2kP1fVtT45h75P3/59sq5ABEkjdPinW91TRV7N+EBbeXUat9uyM5i0q+Hr+HcT/
         9rxC4Za9HR473C1tunHq1SDjIg8HeKznsNd4HiJsGThHAAikQwsSvwAw+dNyWPTLOLml
         nkUEMNreREoOSYh0fU4uMGtMMcHPExUaiu/NmIB3UcTkOhvoXuXO8VElpqv6C1XsRC3v
         JS+OM75lB0kDiemDeHvBJmfBsMVe2vJmYwDACbKh6EfODzbKWRokfpDKSYur+ttUTj8O
         Tn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4T+EJLf4Ceh1ssFeIo8IWSBtRXtHLXqpgec0mvEHDjQ=;
        b=eD9lSXIMSAX1eWNihO0CcR+WMfW60FsYiG8qtAARmdd9YgTWSWyTmRSKT2IRAqi6yD
         2solYq67QQ2752aZfhVU1uvQN0ijN6QWdlQU/pBgLdeUY7uV18TKk4YHdYlBaxdFtJzP
         IyLm74B1UnRKpI5S4308wjSpfaoLZQlyxGtORTpDRYRgt0W3385NzGFc+FpOlCyKHeWP
         raf+TlmZe8Y5zyQyWJQmo/1MkNeD/9EqfbsD6kZNp75wzL7zjuYQcApW6JziWZmo83y7
         pwyfnk55VoO5D0o0MOh3DxK195/guI7v/hZutSdNlOMoI59/ZFvJhSQAy4M5Bsotu7nL
         z2SQ==
X-Gm-Message-State: AOAM531D2eRD/bxXkxmfn0o7xJ3KO7qWp1ug7I62HOTKz/ZTgOLJ3flp
        ZiH9nPzuNAhFOmphzrHpTTjNinW613SyqQ==
X-Google-Smtp-Source: ABdhPJx/D1kiZ5VShvdK46SSdMvso+95G4dPX9qCna9U8hr2OfTQDvhwdI4qIN5gdvuopSpCOHeSDg==
X-Received: by 2002:a05:6808:20a0:: with SMTP id s32mr10682304oiw.94.1623940530676;
        Thu, 17 Jun 2021 07:35:30 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p17sm1283425otp.73.2021.06.17.07.35.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 07:35:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v4 1/4] completion: bash: fix prefix detection in branch.*
Date:   Thu, 17 Jun 2021 09:35:24 -0500
Message-Id: <20210617143527.77329-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210617143527.77329-1-felipe.contreras@gmail.com>
References: <20210617143527.77329-1-felipe.contreras@gmail.com>
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
Tested-by: David Aguilar <davvid@gmail.com>
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
2.32.0

