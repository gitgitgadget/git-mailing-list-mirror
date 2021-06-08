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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E952C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7B5E61287
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbhFHGCh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFHGCg (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:02:36 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD434C061574
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 23:00:26 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id t140so15255558oih.0
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 23:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gUHBzJtvlaZgfjKMwZulc8xTVgtqmfc+Q79RqUXEtY0=;
        b=RPetCy+pKaAywhh1lqEgXdcObWPbAI4pq7muqrkbxpU3EKE+MUs+uEUAf7bhkeblsj
         0JVAh5aM51nyxB/mWQI09u8gXNO722xpHrYTBTBV9bvGdlzOONB1s2xk0z4lCjG/qW2n
         2egGmuuu8ITP91NC9ga5uI7pUdONwwDxGoQfJ5UXqn+cEzs2StwbFfmuhZlqGIr3hIup
         T5NX2xXc6DCyYxk+GJRrGWPK1eaN/gWYhymHOs0wj6cwbb91RTVAupqSqhKGI65EwecU
         z0y/fGMNT+/Gbga+IctS0HGSlrIZFsGvD/D5veIg0DeTjdgVCMYuj+P/UilqUnFygeE9
         95QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gUHBzJtvlaZgfjKMwZulc8xTVgtqmfc+Q79RqUXEtY0=;
        b=VCXQE6KT1Wfd3sewVnlHHF5i1bKyBfgUbfnfNVeIy4OIYBDxiIdvvjCX/DwquzvQjx
         iRPNsvj4UVhLc9sTdUImq0d88zfWsYK2G7o5nUokNC/C/Iu7zr+xuJfOZBH5okqPyDca
         2W1qp95ZzWOEf6CjDIob6PGEeYsP1gCsmO7VouDx+p0IC2caC/5+AMfMh9VzAFdragBY
         rFQlj2jK2aAvmcXo9SekZ2mfPtWSx6u6dqjIiU2sN4odPW4b0TDYIl3Y4LhmD2cn6gM9
         Rov7VEZ9bd5jwgtFw2IELP3t4HPwFh26sG9r3JvdoKivdHD5xf1QDu1K59H7T2XVtJvG
         xkgg==
X-Gm-Message-State: AOAM531GA5gGBUcgTyzuBbiIXrXOJFsjIrrsm19u+OWLo9M7yA4oTOM+
        RmpaCm+w5RSyf+spX+zzXtupFH/sWhQqZQ==
X-Google-Smtp-Source: ABdhPJy6/hh+uZOxP1NFNyVhDYna64gq4LFS+0nntK1z/T2gljvSManG0ZEu7Pn5ln2R1tCQRAujkw==
X-Received: by 2002:a54:4d8b:: with SMTP id y11mr1783229oix.26.1623132024326;
        Mon, 07 Jun 2021 23:00:24 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p204sm2650911oia.43.2021.06.07.23.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 23:00:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: [PATCH v3 3/4] completion: bash: fix for multiple dash commands
Date:   Tue,  8 Jun 2021 01:00:09 -0500
Message-Id: <20210608060010.1676208-4-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210608060010.1676208-1-felipe.contreras@gmail.com>
References: <20210606184726.1018460-1-felipe.contreras@gmail.com>
 <20210608060010.1676208-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Otherwise options of commands like 'for-each-ref' are not completed.

Tested-by: David Aguilar <davvid@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 05606609f9..1feb2ee108 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -421,7 +421,7 @@ __gitcomp_builtin ()
 	local incl="${2-}"
 	local excl="${3-}"
 
-	local var=__gitcomp_builtin_"${cmd/-/_}"
+	local var=__gitcomp_builtin_"${cmd//-/_}"
 	local options
 	eval "options=\${$var-}"
 
-- 
2.32.0.2.g41be0a4e50

