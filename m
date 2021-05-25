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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E70F2C47084
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAD0E6142C
	for <git@archiver.kernel.org>; Tue, 25 May 2021 10:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhEYKuB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 May 2021 06:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhEYKtr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 May 2021 06:49:47 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC694C06138E
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:13 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id y76so20592860oia.6
        for <git@vger.kernel.org>; Tue, 25 May 2021 03:48:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Vv31O72HlaW7pfx8KxRQpSn0tEZuIxic3nwHjKUSexU=;
        b=EKk16kF7e/fWcoT2lE5FT0Ad9dtbi0eGcmhTfn/6aXXxUY1G8/YhO3WjXoB0wfBygh
         XSJuCKsBgh2/Xu8ZTeS6sakpteL5MfItdyh/MkukEFqDWAkC915VquU2aBc0Q9BjbFn2
         vtAyQsbUTWCYd2jC6k4/LSf2nvMHOG7gndN+zocMmB9Iyo5kg0Z0stXb6WYy9FnkfNOQ
         T0+ZQz2o8SzMzt183l57QfVkRKslW6qEr/AYEvZuBd/u/rxZ1a5uMwLMDQkDSkRKV3cM
         3QJx3S+sWmkxxlXdtr9sCD5g+d7pZouWOdUHT/xNXNh/VHwWp3Sz8ZjiwKK4nGZnCFpD
         e76w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Vv31O72HlaW7pfx8KxRQpSn0tEZuIxic3nwHjKUSexU=;
        b=hKjlTlz79C2gvpvZLMrSXoYk+Q8m6vq/FCi2yAGo9JLvZUZhh/k/WoE7k6GBQuAKCK
         bsJBT12MTu67PaYPK4Gqun6rKmik/6NQo7fla4IkpeIAQr1b9B8amKTBuB4Z2BM0Wnpi
         ytnyEt83ybafkcwakDG8Lj7HMmIpvIrZ3nBktyew6hgUf0r3cim8bMUyKs1FG5dUNqjo
         bozB5tZbUmJxh+krtuB8rKiTMDwpU6rUTYE7qbQa6Ze/5pxswHG8BHHdvoJm97eNK58V
         wfjm4v9y9TOkYocjvvRpEo1Ozjmb/Hk+8m3s/WMA2l/vDGM6cKFWg3q347XKcY+1EVqI
         lmsg==
X-Gm-Message-State: AOAM532fTj8rjWfX/XX2ZvjsRikKjpFN8Z4zpzI69VmoCHioAv/fVyu2
        ZzcYotyyEfnlOFP3z8m63wZzsllIF23FKg==
X-Google-Smtp-Source: ABdhPJw8csKlh0AgidO6UWwIFaZ43QMVFMswBRgMUKvn5ST3hZvfoTui0XcpuuC0oVOwFsqOm7KwQQ==
X-Received: by 2002:aca:aa0d:: with SMTP id t13mr1205200oie.146.1621939693015;
        Tue, 25 May 2021 03:48:13 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id o18sm3683075otp.61.2021.05.25.03.48.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 03:48:12 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 06/12] doc: asciidoctor: remove cruft
Date:   Tue, 25 May 2021 05:47:56 -0500
Message-Id: <20210525104802.158336-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210525104802.158336-1-felipe.contreras@gmail.com>
References: <20210525104802.158336-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These were probably copy-pasted from other extensions. The name is
already defined (:linkgit), and we are not using the DSL mode.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 423450392d..3dea106d00 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -3,10 +3,6 @@ require 'asciidoctor/extensions'
 module Git
   module Documentation
     class LinkGitProcessor < Asciidoctor::Extensions::InlineMacroProcessor
-      use_dsl
-
-      named :chrome
-
       def process(parent, target, attrs)
         prefix = parent.document.attr('git-relative-html-prefix')
         if parent.document.doctype == 'book'
-- 
2.32.0.rc0

