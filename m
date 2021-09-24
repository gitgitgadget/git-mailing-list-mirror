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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D0D3C433EF
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64D4961090
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 02:47:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243963AbhIXCsi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Sep 2021 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243956AbhIXCsg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Sep 2021 22:48:36 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CC68C061756
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j13so8239168qtq.6
        for <git@vger.kernel.org>; Thu, 23 Sep 2021 19:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=kHtdDHcYug9bRvjZzmXTZdwd5PrHg6xja7kz7XXckHS4d2KF4+63GQcaa+73nrhHaZ
         j5IhIc76783WYHU0CliQ9EmyJo51CCUvIq/Mv/nTqZ4D14d0r688tg3aOmPFa0VIjrrV
         ceTvNHVNpdyM17O6WIT0hIiNN+0pp7D3Bu65XE3513RXQi7ZTn/Ez0hz+N1UKOR1A4LC
         8WmvOI1LBgShV91ZQk1WUO5r5f9fbxqm+4VmjSvO9iWB1RlgT/HJc+1YHyg/CTSQdjvb
         HqOdY/Yf6gXehoEoAh/O6oR6RJ7yL8bO54QIn7eUzeRq7T+ZcnDKYt2Cvjz9hRkqZ5ea
         r+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=WEVYVBrGzj/uoJcqBr5DMThY+JqwFyJUJU3KVHhAYY3t+4XNyUzr7SAZzEEbZOD1ye
         +SdlYU4awHBDIZIBIjYd54V3tjn3wKlW55fr5GBQWxTEshu1abIjFFcIoFTK3zfYqZUG
         Ng2sukV4FwSYFD+N3Ck4S7rWXjxB6LnwrXlbjjWxpxCQkOpkroKtJkNfGfFiLeSn6kSJ
         JgNStzG2YdiAiLMH6jH+6c6uk5+nHAgaoVYS/TEN5Rv8F1osVIsRayZ/Eu2ciC5VxMiP
         YudcNRcEO31sdSFPWBBvtsQupcwv0e0sDy+RYL/rv8cOACNxSXLNrisvU71vNySdCU3a
         fpVQ==
X-Gm-Message-State: AOAM531D4RPznvaof/du6U4ZJ7UTk/xY29z3r6VqKTcq375Q3Rg/I9ED
        BxkTWArcSAkXgpBsHImletM=
X-Google-Smtp-Source: ABdhPJwpobjbrY2Su2jrK62lIfaWyPn5sOK60ywCZCpk709g00D0kJvej/nBnMp4ZW96SlJMbslikw==
X-Received: by 2002:ac8:4088:: with SMTP id p8mr1967075qtl.279.1632451623312;
        Thu, 23 Sep 2021 19:47:03 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm5698011qkh.17.2021.09.23.19.47.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 19:47:03 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     carenas@gmail.com, gitster@pobox.com, bagasdotme@gmail.com,
        avarab@gmail.com
Cc:     Thiago Perrotta <tbperrotta@gmail.com>, git@vger.kernel.org
Subject: [PATCH v5 1/3] send-email: terminate --git-completion-helper with LF
Date:   Thu, 23 Sep 2021 22:46:04 -0400
Message-Id: <20210924024606.20542-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <87zgs34ccx.fsf@evledraar.gmail.com>
References: <87zgs34ccx.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike other Git subcommands, "git send-email" leaves its output an
incomplete line when "--git-completion-helper" is asked.  Be consistent
by terminating the message with LF here.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..d1731c1755 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -114,7 +114,7 @@ sub usage {
 }
 
 sub completion_helper {
-    print Git::command('format-patch', '--git-completion-helper');
+    print Git::command('format-patch', '--git-completion-helper'), "\n";
     exit(0);
 }
 
-- 
2.33.0

