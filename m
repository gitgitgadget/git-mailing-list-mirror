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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD4F6C4320E
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A1E60ED5
	for <git@archiver.kernel.org>; Sat, 28 Aug 2021 03:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbhH1DKN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 23:10:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232555AbhH1DKM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 23:10:12 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DABD1C061796
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:22 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t190so9376598qke.7
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 20:09:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=eZVsHuoE6kLJgSZxOqp0Cv+BwC9dh1Z26Z1ZXcSVnY4tVNiC0tmVYA2UAYZBc16eMN
         xtRXrDrEVCCenpAbRBY/LENwDMJvgsVZami7bakkdrhfXLdN1CgMGhF/BOzvwWzQBYyy
         K9T8rMgIXFiOCnTnlfJOnTZQ2nwTV2pxupge0Dw4FRxD9o+2GVlbpyrWeuHLfrOR4rwl
         U+Kd8kqBH012r1u+pAxX399ref1Oiy2xqbXKpo8oFOC5gW4csERAtZWR2NBmQEU20yEN
         E6UPVQtw+HMkTp2WRZbWPtculpcYm/+p4W4LE5jfzg68EPEz2bmZW07KDris8B8UelJN
         JXfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i3TAMgrYVK3W7T/b5x9JPhB6YthV3zjDhUCRgOtbgP8=;
        b=gcFAEF+rqk+T48CgQWkhDwaHGCRKr8/xGxfLo8uWV6+ELtdf4PWNGXNFBV+QYITKzq
         k6Bu4Lfuk4l0lAvH7TxcuaS8gt2THbCXb7/lA0RPzh1ud+rRXHpQkqDcdEyye89KyH47
         rozJW/B1c6RSrp5aAI+xMMhY5nozYk9ZRe4ZlziTpZAa07ea+JMG9xqL2ba+s/yRLqCw
         g+XqdPYt1qGEjWogdsongqj6UQ/vx+wG6za/DPA1ncFStY4Xjy3P5BNQ0L7D1w5pASyD
         DSdz4VICdAUcCxkxFdRWuqPNxmXD085eKZGxaFxPNEGNY7a3NPo47tK0H0DLR9c898Ua
         RBjg==
X-Gm-Message-State: AOAM533wJlwDWT6YyCMKCjnR9gGy96X22ft8NeAU9LL6VIRh6+iPI76A
        nROrM8twm7CH8uexZ0SKuAU=
X-Google-Smtp-Source: ABdhPJwYtzfClxgmw6guMAwahWo6qtZ9ZNi6FTgoD+0ouJzED2tcTRxrJnHrqE70jPBFIncyPwXdhA==
X-Received: by 2002:a05:620a:179e:: with SMTP id ay30mr12031070qkb.333.1630120162145;
        Fri, 27 Aug 2021 20:09:22 -0700 (PDT)
Received: from valhalla.. (cpee03f49946310-cm589630b5b38a.cpe.net.cable.rogers.com. [99.250.23.181])
        by smtp.gmail.com with ESMTPSA id e25sm6071682qka.83.2021.08.27.20.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 20:09:21 -0700 (PDT)
From:   Thiago Perrotta <tbperrotta@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, tbperrotta@gmail.com
Subject: [PATCH v3 1/3] send-email: terminate --git-completion-helper with LF
Date:   Fri, 27 Aug 2021 23:08:37 -0400
Message-Id: <20210828030839.2989-2-tbperrotta@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <xmqqmtpbub07.fsf@gitster.g>
References: <xmqqmtpbub07.fsf@gitster.g>
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

