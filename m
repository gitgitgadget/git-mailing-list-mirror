Return-Path: <SRS0=V3lj=EK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9943FC2D0A3
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 536492067B
	for <git@archiver.kernel.org>; Wed,  4 Nov 2020 17:47:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PowITBqf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgKDRr3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Nov 2020 12:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732066AbgKDRr2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:28 -0500
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7D6C0613D3
        for <git@vger.kernel.org>; Wed,  4 Nov 2020 09:47:28 -0800 (PST)
Received: by mail-ot1-x341.google.com with SMTP id g19so10646580otp.13
        for <git@vger.kernel.org>; Wed, 04 Nov 2020 09:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6Wu893TP6PVjXtaNUZYYu4R2pJ7LfNrKwBcdWIwyccw=;
        b=PowITBqfMARr+pxGd8W0/q/WIU8a2P6drl4EY65UbuJCq9eNbI/jeAJD0iAd4TSrtI
         Q8t+002oefIYsDHhpwNVJvbzYV/6QyDwcX2eAY6uAxFfS5YeF1pTnHjJ+IYAXrBJZ3my
         2PtJB4v7uxtW/+Wixiprjnc9snXj+RwOaTumUsh0CCEt17SRzblvnLxw23um/Us0gCZr
         AqJM9ZaPWfNkLCMgBl8HwTPtnjYss8BQJMayRfZDLJkaBZ0CmWEDPf7MZ5U7SQ+r/GlE
         sS+ZGavfGY34YzVYRtHlWIFODABQ7by7sSbA83UY//gDAGreu1gCjW/lZ6l6W4OLuEtB
         Pfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6Wu893TP6PVjXtaNUZYYu4R2pJ7LfNrKwBcdWIwyccw=;
        b=Qbtm8+gpSh9orgiCIQeC0YFoVZ+6hbOAbNv2AJGLLJ5z1/69xSWJSNpPyQIjymp6FZ
         DfdkFOzQju+Up+3vqLAU/EyFtLw7OHmc9ku6F6tTFGEBa0t0yY9h7Y2HfKvJtdFW3i8y
         waBsD7offsmcF0gD+wZ7m1YV26NofnI3jJv+q6Mf9YVzn+h6pL37se8aAepdkOGP8Cqd
         dg51nDqb65xgey9PkdwcgBFK4s1fJcHHcqeBWgXMv+igblv4tbyhVu0RvRSL5VAQkqb7
         o8tnKmT1nHToonWHo/lQvxEce/3ztXDV634fAC0XPM0/2vSM6EvBIN+ZyRuoEuTzrMCB
         CfwQ==
X-Gm-Message-State: AOAM533Qe4XkkhQKcEQ7px01gUzM8y44Hjn5aZkWeZmSXYp2t79+sZoS
        NdvSYBsqToANm7REkR7iJY1GRGAg97zlUw==
X-Google-Smtp-Source: ABdhPJxaNh/n6I9CcidfErXkd1vwaCTquWj7oMFnS98ipKPjhKRELDODX8XDbcnN+cHVoMSp78US8g==
X-Received: by 2002:a9d:3d3:: with SMTP id f77mr4164846otf.125.1604512047477;
        Wed, 04 Nov 2020 09:47:27 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id t6sm687955ooo.22.2020.11.04.09.47.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2020 09:47:26 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/10] completion: bash: do not modify COMP_WORDBREAKS
Date:   Wed,  4 Nov 2020 11:47:11 -0600
Message-Id: <20201104174716.783348-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201104174716.783348-1-felipe.contreras@gmail.com>
References: <20201104174716.783348-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There was no need for this once __git_reassemble_comp_words_by_ref() was
introduced.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f384698f2..90202e11a4 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -45,11 +45,6 @@
 #     When set to "1" suggest all options, including options which are
 #     typically hidden (e.g. '--allow-empty' for 'git commit').
 
-case "$COMP_WORDBREAKS" in
-*:*) : great ;;
-*)   COMP_WORDBREAKS="$COMP_WORDBREAKS:"
-esac
-
 # Discovers the path to the git repository taking any '--git-dir=<path>' and
 # '-C <path>' options into account and stores it in the $__git_repo_path
 # variable.
-- 
2.29.2

