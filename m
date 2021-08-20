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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BB0C4320A
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E321610F9
	for <git@archiver.kernel.org>; Fri, 20 Aug 2021 00:47:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237174AbhHTArq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Aug 2021 20:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235748AbhHTArp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Aug 2021 20:47:45 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1BC061575
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id l3so6175581qtk.10
        for <git@vger.kernel.org>; Thu, 19 Aug 2021 17:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VIkXXUttl+P3pxkhRKykEwgspMFSlK3eUxNQcdWomPA=;
        b=D7WR1em2Wc/9xEvQOfwb7OxbI003qY2RJrfymJVHECaiHoVRHYIT+nq5bTfnMaC/XJ
         wbZyKVSW0VpMLkzAAexQi3qMiRLurUdlYxvU40W3tiuSCn4mZJy6BnnfdUg8+QgcMIhm
         CpXsDYvkJu00QZ/WQTthTsd4DzYRn/lgm12navfJ6xcKAUPSRI023foRrh7KL8O20oXb
         F9sabDM1DnyKKMZKjGIWdjgLE7vmhCVsKO5gwqxzEQM7FqZJqrlmJkU/Pp3PPOtkCOgF
         Zjdnsmge/4aolbxemKZsaASXQmLzvDB7pqMsZl/S4t2jNdRiFfBty3j8UGBy4jG/2zQj
         qynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VIkXXUttl+P3pxkhRKykEwgspMFSlK3eUxNQcdWomPA=;
        b=OPFtpY9dzOZxciOZEcSGmeg6KxHAwRWEwta5kf1rM3WuMP+jDkSXEFdXuue24tP74N
         yl3le3XPhSutJ7wgF8CTZnGiNfGvm6JmclDcJvzRfkURQ+rfnyi9m11ztVfjahPY4tUX
         fAVkqaiefye3oLb81ZaIsnDHgAntB1g1WVOal3+M4OhXFBIotVAuh1zlpXeCZSinXkzE
         zZRk0PGpiYEj3b/LgAI71SLFE+xdaAvB7YuXlBGZggP7Z7iAOXLiGvq8U9SF6yVi2GXh
         2qBZVr3nJMFs32AjWtDOZBmfTLSX7FNo0yveAU7RoJUC14eBrmcbtQ3LyLNmE86HWgLi
         uK1w==
X-Gm-Message-State: AOAM533yt+gaPaRzfyr+0S4BtgeCBdA3ADjrgEl41YAr5JoOKfR9ilsw
        AVIJVkRVnzMSLiErwd11MKwRZ6AMjFs=
X-Google-Smtp-Source: ABdhPJyBaBxo4n0sYP1aac4pEgUUf0xbNVB43A96EsV7cOSjVMBAzaFfT0O1jMcoV5TGEu2G7nlNPA==
X-Received: by 2002:a05:622a:4c7:: with SMTP id q7mr15528032qtx.360.1629420427917;
        Thu, 19 Aug 2021 17:47:07 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id o12sm2095724qtt.94.2021.08.19.17.47.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 17:47:07 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH v2 1/3] send-email: print newline for --git-completion-helper
Date:   Thu, 19 Aug 2021 20:46:02 -0400
Message-Id: <20210820004604.9948-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210820004604.9948-1-tbperrotta@gmail.com>
References: <20210820004604.9948-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rationale: Currently all git built-in commands print a newline upon upon git
<cmd> --git-completion-helper. Therefore git-send-email should follow suit for
consistency.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969d0b..e991bf333d 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -115,6 +115,7 @@ sub usage {
 
 sub completion_helper {
     print Git::command('format-patch', '--git-completion-helper');
+    print "\n";
     exit(0);
 }
 
-- 
2.33.0

