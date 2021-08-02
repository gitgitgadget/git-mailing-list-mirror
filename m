Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D44C4338F
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2AF960F48
	for <git@archiver.kernel.org>; Mon,  2 Aug 2021 20:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232276AbhHBUvb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Aug 2021 16:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbhHBUv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Aug 2021 16:51:29 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BE96C06175F
        for <git@vger.kernel.org>; Mon,  2 Aug 2021 13:51:19 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id m11so12589566qtx.7
        for <git@vger.kernel.org>; Mon, 02 Aug 2021 13:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4wVdkXiw5Cx5mBTU2XpaHPcJz/xzUKD6YUK5l31mKw=;
        b=NjwgyFsYDAWKsLkCNEbFE/I/iu2TdwfMdaNXoMT9/1jZSwGWpkbej2uJxYHceztIpN
         jn2wEE9UhV+a6MqoTYlYPf5/nzUBCuwRcm6tF8Tq8m3gsV5kxseeKsUvWmxkJZdIO6qk
         XTmqYa0EU683/Tz3V4sfEI1kNGKK/bCzfwRb1+ckgxAK5z6jDn735idBk7yoqbNI5zsr
         UnOgVJM7PyrNyR5ANPKb7LaromGQWMAdGqY98IiPmVsrYVhiobymjWVczAm2QmdQE5gB
         cjmEE92boboV8ypBEBQZTDHOI8GC0qlTbOy4N5QjT4MsFkvEx6o2jiyVmyzzotSU+goX
         r6tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4wVdkXiw5Cx5mBTU2XpaHPcJz/xzUKD6YUK5l31mKw=;
        b=izhVFhlMWB8TPi9/sKVqmDPdETlepztjwHTGMp5C5JgfE0Jbo0oGwZpwXG523s5Zgj
         MmJ/1Ln+6GLd7RPeB4DqnsR1rEvZL3cTCzrQLSCwLO5YpdIoEg+2LD1V9F5mEn+/1L3X
         IIWzBQDUxAO5lAxgeAT3EjV2+iyYpHlktVIP2tdjj0er047IyJtP2H89P97IpPC7gp2C
         Q78Ri0HV7rv63+mjxhTM1Bpy42q2BEjUqN6a1OgqhML7qDG+5v2bwOk8Z5MNApqmoTiw
         kHxFnM5OyndDs+uXX5jp3ir7FkZwurTIi5HfNsYxgShJ0pAAoS8EIUFTxWgqaAJm+UUU
         Vi6w==
X-Gm-Message-State: AOAM530bw7XwJMer5/KEAtEvy4bnmYiGao/HCvk8NLbPG7VhnCL63CPC
        FWeeB7Id/I/7ImZ3nL+CCzo1TWRWVts=
X-Google-Smtp-Source: ABdhPJyLnrGCBu5mJ60nn1n6RIq586wzvIyI2HmcGwo9urGjUL3ZkSyEtjA+fIELkqbR1035ApQXlg==
X-Received: by 2002:a05:622a:492:: with SMTP id p18mr15655964qtx.323.1627937478509;
        Mon, 02 Aug 2021 13:51:18 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id v5sm6539073qkh.39.2021.08.02.13.51.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 13:51:18 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     git@vger.kernel.org
Cc:     Thiago Perrotta <tbperrotta@gmail.com>
Subject: [PATCH 1/3] Print newline for git-send-email --git-completion-helper.
Date:   Mon,  2 Aug 2021 16:49:51 -0400
Message-Id: <20210802204953.229867-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802204953.229867-1-tbperrotta@gmail.com>
References: <20210802204953.229867-1-tbperrotta@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rationale: All git built-in commands print a newline upon upon git <cmd>
--git-completion-helper. Therefore git-send-email should follow suit for
consistency.

Signed-off-by: Thiago Perrotta <tbperrotta@gmail.com>
---
 git-send-email.perl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-send-email.perl b/git-send-email.perl
index e65d969..e991bf3 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -115,6 +115,7 @@ sub usage {
 
 sub completion_helper {
     print Git::command('format-patch', '--git-completion-helper');
+    print "\n";
     exit(0);
 }
 
-- 
2.32.0

