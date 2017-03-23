Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14CC820958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:30:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965040AbdCWPam (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:30:42 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33241 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964973AbdCWP3n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:43 -0400
Received: by mail-wm0-f65.google.com with SMTP id n11so17293611wma.0
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uDyNobKPcjVAzY3jVREynUrzYYHS7P0KwrlcslS9HWc=;
        b=eBE3zEhaK85gKbloHMTV6KmQikBmi9LoIKoKhlFP60senwWl01KokgkCROdiVaeDYC
         Qs6xdjvieGZaVDSK/9pR7IfJEAELz1dMN3l6JhY7m6hQWVrpoT4PJkjRlK1yai4Mvk83
         ZcqoKw176Cmmem99eimYS9CVsDbiOLAdGtcFTy1FlEviTTwdYka7Ln/Yvf0F9ohtqwpm
         nXSFWZ3ysXltlKL7RttWVw7npnSuCZEEQWe21wKZWkqI7UQyC0Hh3lPpO3fEiq4W3is+
         dhhd+TOlqHuQ4w+gBcbMrmWneZlJDL38GpbC8ePQogZOiBBmo+dTSdHdfv3todUOWhUw
         d2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uDyNobKPcjVAzY3jVREynUrzYYHS7P0KwrlcslS9HWc=;
        b=YUvERa4cunP4RX2iz6fOCGseM09uQqIA/r03zKarpBMtH1Z461UAMCW1JUykYzvi2W
         MrDDn8sZrak+WlG30WDreap57c9Co3nsg22d3barLGWScQHIkH87zlHejruBi9NQVeKB
         ZG9qkCf9HwLDZtStZ2a277hOYrILcjarT8DBqT8mvrQzWX91l/Y3mGw/IaYoqDyPXkIT
         rSkxkXSFyEDmOC9XiyjIGs8LnugqG7cxWjTpA4nQ4bXLMo6j2yN4Stn2ve2LTLEsJsLC
         +XJywjtcqYmJ3THrmKxqf9+4Ej7RouqsYX85GIuCzb8AEtHbu72R9frqohekpTSe5tyF
         Ja4w==
X-Gm-Message-State: AFeK/H27H42SzJBtcrWr+afRi3E0sgQ4GEaRYe0JNZ1LzkdzWbX41g3yWj/eph7KtLG/sg==
X-Received: by 10.28.135.149 with SMTP id j143mr13343224wmd.19.1490282981355;
        Thu, 23 Mar 2017 08:29:41 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id q135sm455057wmd.8.2017.03.23.08.29.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:29:40 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCHv2 06/14] completion: don't disambiguate tags and branches
Date:   Thu, 23 Mar 2017 16:29:16 +0100
Message-Id: <20170323152924.23944-7-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323152924.23944-1-szeder.dev@gmail.com>
References: <20170323152924.23944-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the completion script has to list only tags or only branches, it
uses the 'git for-each-ref' format 'refname:short', which makes sure
that all listed tags and branches are unambiguous.  However,
disambiguating tags and branches in these cases is wrong, because:

  - __git_tags(), the helper function listing possible tagname
    arguments for 'git tag', lists an ambiguous tag
    'refs/tags/ambiguous' as 'tags/ambiguous'.  Its only consumer,
    'git tag' expects its tagname argument to be under 'refs/tags/',
    thus it interprets that abgiguous tag as
    'refs/tags/tags/ambiguous'.  Clearly wrong.

  - __git_heads() lists possible branchname arguments for 'git branch'
    and possible 'branch.<branchname>' configuration subsections.
    Both of these expect branchnames to be under 'refs/heads/' and
    misinterpret a disambiguated branchname like 'heads/ambiguous'.

Furthermore, disambiguation involves several stat() syscalls for each
tag or branch, thus comes at a steep cost especially on Windows and/or
when there are a lot of tags or branches to be listed.

Use the 'git for-each-ref' format 'refname:strip=2' instead of
'refname:short' to avoid harmful disambiguation of tags and branches
in __git_tags() and __git_heads().

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 882635f97..e129f674e 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -340,12 +340,12 @@ __git_index_files ()
 
 __git_heads ()
 {
-	__git for-each-ref --format='%(refname:short)' refs/heads
+	__git for-each-ref --format='%(refname:strip=2)' refs/heads
 }
 
 __git_tags ()
 {
-	__git for-each-ref --format='%(refname:short)' refs/tags
+	__git for-each-ref --format='%(refname:strip=2)' refs/tags
 }
 
 # Lists refs from the local (by default) or from a remote repository.
-- 
2.12.1.485.g1616aa492

