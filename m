Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A80C4363A
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8498B20936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfy05UGK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766908AbgJYDOm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766896AbgJYDOa (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:30 -0400
Received: from mail-oo1-xc43.google.com (mail-oo1-xc43.google.com [IPv6:2607:f8b0:4864:20::c43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51131C0613CE
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:30 -0700 (PDT)
Received: by mail-oo1-xc43.google.com with SMTP id n2so1549053ooo.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IpYxavsTVxlyOo6i67ilYnK0thPLivsx6u0u0MGtU1Q=;
        b=cfy05UGKuk55WCkXWqeZ45I2tEBOxwfp7//K0ocxXa/daOPS67FVy4pZPepL3OaL2h
         isTsyac1UP3xtp7fBqs/aJXjIFvjVfJl7LNlQEB0F669PUPfahwUqwVlcP7kvCAcF04O
         cFJQdQq5wpygucDYRDhJVwJYwzQ6QMD/fKqp/IqYsT3PY0Q95IGu5hQwmp3glPor+6ys
         ivETkCkND49t+f91d7KTYfumgpSjNOQiHEKhVBnnbmOOGrbbOCfG1eKcj9ryvYJb4UtU
         j+IyNJ43K33otCAV5sp2WffZNT+pVJaDQX8v6pCf8B2KAjh84dL1W+C195TtZzzK+J4V
         71ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IpYxavsTVxlyOo6i67ilYnK0thPLivsx6u0u0MGtU1Q=;
        b=d3/n0zQ08SXlNADWERLZk//7ql6otnxSvWXCUwPExGvMrU70E5vdn5zlvXdVJSeSMh
         iuD97GcA1DcP1EKYF5AvH71rN1ZDJ8r6EbSd8arILu23C5SQ7R4MLzYV02d8CdzbG5Lb
         79zVIbIg1Y6ci4Fc7R35F18t+25QXg+0qKuq9gOLjpUgPiykJsHu1fEdeIaupkMzVCli
         +QE6cmxpfvKb1C2MEF+EhVwjVYjq7SGz7s4Wyj5zDKz8paIZNpxfrDjgpwx8lB9FURzK
         2h2Jo0NCMJjG7b6wGUNfOV4MERicdmyiqrI92SjEHHx5YRQcWDhOvQtd1e8By8uQik0d
         L7VQ==
X-Gm-Message-State: AOAM531Ks0GmU1c6rEzhx3rrbnPRhfLYe4xGcW2cxjCTB12llZHlAU34
        cY5qGcVqhGCojaz4cDStMddiIMJ0ij0Gyw==
X-Google-Smtp-Source: ABdhPJzwnTNxRdqY/k69M0TRQNGHJbSHOBtcEact6BwiRKYqULkbvh8gFIt+iVTQSCZ2EVWUgmbQQw==
X-Received: by 2002:a4a:d554:: with SMTP id q20mr3967448oos.23.1603595669536;
        Sat, 24 Oct 2020 20:14:29 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id q14sm1887392oic.38.2020.10.24.20.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:29 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 29/29] Update copyright notices
Date:   Sat, 24 Oct 2020 22:13:43 -0500
Message-Id: <20201025031343.346913-30-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 2 +-
 t/t9902-completion.sh                 | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 9fc9f2db21..d25f8691ef 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -2,7 +2,7 @@
 
 # zsh completion wrapper for git
 #
-# Copyright (c) 2012-2013 Felipe Contreras <felipe.contreras@gmail.com>
+# Copyright (c) 2012-2020 Felipe Contreras <felipe.contreras@gmail.com>
 #
 # The recommended way to install this script is to make a copy of it as a
 # file named '_git' inside any directory in your fpath.
diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7b7bc6e4bd..caf4e9101f 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 #
-# Copyright (c) 2012 Felipe Contreras
+# Copyright (c) 2012-2020 Felipe Contreras
 #
 
 test_description='test bash completion'
-- 
2.29.0

