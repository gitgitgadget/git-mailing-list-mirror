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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CB6CC07E96
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25CD361C9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 02:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229987AbhGGCee (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbhGGCea (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 22:34:30 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C35C061574
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 19:31:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 7-20020a9d0d070000b0290439abcef697so841548oti.2
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 19:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=grkVnHHNxlk0usj7rU4StYPs3+LnYPTEkJdi52Yc7RU=;
        b=UoDXuMeCLhEtu+L7gD+zLKdWwJNb5JxrrJg5TlYSkRi6SbThhBii8vRVny8PKRFN2n
         O2rZfQ9drYCgeGRPCWsvQ9Yg5ZSoUHCo+H72HZHC8FnlTE5nYeZgclVlTlQL0vs92DBq
         qJjvkjAWhbYs5lPkxQjKfKjuReXhf+nSoa8LtCQ0J73QDtPMgEghPBERMjvyWg2xwGub
         zjDlBNnAykWFeBzpJhlRY1nPYpNwkS5JG2CGu9trV5UAXtE89cascSMfoo5IC9BGn86u
         vzQHDPkrTK5h6A8ixrPDOrtERjHkoj6InKyJiqx1eASE371cuYkBocfc93uZpcSDPZAg
         ifVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=grkVnHHNxlk0usj7rU4StYPs3+LnYPTEkJdi52Yc7RU=;
        b=gt2KNLMSp+cBu1VnsQMWS/SDrp5fhiEw50YUjcjIQI0Bk59bHQObnmwbWslEk1sYS0
         4ibvSH9akbRAlnAPw8mv2W7HCxXyZf3eqBZvfNEmcMozJtWKE492UhJff9/hZCEIj/5s
         pLrjnSiUQwSPIqSiwayDvK3MRbfQgCdp+7jwzT2syIBEoFl+x+9PTOeLGZJMwgou+JER
         487wtXRRSdV2ldJkWNrmuojL87OPEycEVMoeKka++tPKP96Lk45fOPLGtxOzk9DXQbr4
         XxB4nGUp63ateKHpwU5B52wIVKOuuRlnBynkdXsUV5/mZpPAF5I0FbkK9A82guoWox4D
         uyjA==
X-Gm-Message-State: AOAM533MpvRpJRY+N9R7NgEu0y07GSr4hnvYwOYTZvPuBKUulRgBc76K
        4fbn3Yh+5uYHbTtbaTC1bQZULAsZgec=
X-Google-Smtp-Source: ABdhPJz8T7/ZHnN/NxYnT5wsxc94SKx7OUbac9zJo3Nhl11F2RZxxDLBLoBbIooQ7O3W8MXbpnrDpw==
X-Received: by 2002:a9d:7b56:: with SMTP id f22mr17123566oto.71.1625625109788;
        Tue, 06 Jul 2021 19:31:49 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 91sm3030074oty.73.2021.07.06.19.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jul 2021 19:31:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 1/4] completion: bash: fix prefix detection in branch.*
Date:   Tue,  6 Jul 2021 21:31:43 -0500
Message-Id: <20210707023146.3132162-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210707023146.3132162-1-felipe.contreras@gmail.com>
References: <20210707023146.3132162-1-felipe.contreras@gmail.com>
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
2.32.0.36.g70aac2b1aa

