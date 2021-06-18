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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFCE0C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA1D611CC
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhFRS1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236282AbhFRS1n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:27:43 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36C83C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:32 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w23-20020a9d5a970000b02903d0ef989477so10553941oth.9
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+ZGt3UjCO90OHaCnDYTyjNMRhlOdjgO4FeS/J08wF5s=;
        b=QT/aE+2f65/WaJlyaWjkpj+yGWY5iI3TgGNUeuP+b47Yk9eahgFEk3x3E0KazEWY20
         RHgxo2k2eW1/TCAFws/jfaYdZiCaWfK3mgsaoIICb2mQHZArvccFQs+prxRCYHHZ2dgR
         4yUeOHkJe1S6LKUh6tftXvKlMY/o6K6ZSzMhvPoQgJZLKdIgXY29qFVz0BtXlo2sqEf/
         cjSAZOIAY+m5GoCg9BEmYB1j2zpYmjbrlnIWFttW1oNB6Nap9P0oiWl+/o3NfICeimHk
         bEODkQPeZTJeSuGxW8PIUnbmd9hhmvC5/hUWspC2b+RBePoObphBSQ5dQNcbcsx/tr/Z
         MLpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+ZGt3UjCO90OHaCnDYTyjNMRhlOdjgO4FeS/J08wF5s=;
        b=B9FHD6a37IsxRw4FnUG2ZB3pvoeqeQPUCrRAqq5emotzFrjgVGF7sS0EF3S1/ZCNQE
         iGBJR9vXm5tAK07Fx4xvZKnh45Q7R5mNRfF26rxcEnIIRtACHaN9tXrYa6JsYjGGqhZl
         d5ECdfCgG6J3hI76kHp8bFXLQXpSvxAQF9LgBSVd2MBe7B4SPCdWQH+ypRZOk3Dga4VR
         0oo/q8EWyjrC8DQ/HXcuJM5VRsiVfgd+fmkKlLEcwcBt/7bhpIPk65CqMZy5gzBLYJ66
         2a1DR20ZhUzunRwELZk08F+7evZSLPBqt5rALQ+eXUI4X1vtwGb19bFpskip01x5s8Cj
         Czgw==
X-Gm-Message-State: AOAM532+wShbjshS9p3RCvDLZ5NYScYmzlI2248ks91Ww/JhK/XScONZ
        xGBwYCDs3U9k1miMdbH+7TZN5gyClLzQbQ==
X-Google-Smtp-Source: ABdhPJxvPqaAFJAy3NebDQpI2O7Y4qNRoHXUytl8An8j/o4MykgDiG5oZQipnmTYkEsPKzruMv7MTQ==
X-Received: by 2002:a9d:5d11:: with SMTP id b17mr10777300oti.216.1624040731425;
        Fri, 18 Jun 2021 11:25:31 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id h193sm1953092oib.3.2021.06.18.11.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:25:31 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/45] completion: zsh: add higher-priority location
Date:   Fri, 18 Jun 2021 13:24:39 -0500
Message-Id: <20210618182518.697912-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

bash-completion looks in /usr/local/share first, we should too.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 4a4df3b37c..da13c184d1 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -35,6 +35,7 @@ if [ -z "$script" ]; then
 	locations=(
 		"$(dirname ${funcsourcetrace[1]%:*})"/git-completion.bash
 		"$HOME/.local/share/bash-completion/completions/git"
+		'/usr/local/share/bash-completion/completions/git'
 		"$bash_completion/git"
 		'/etc/bash_completion.d/git' # old debian
 		)
-- 
2.32.0

