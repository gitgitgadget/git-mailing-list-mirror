Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FADEC4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F021D613DF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbhEUWqb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEUWq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:29 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2F2C061574
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:04 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id z3so21108486oib.5
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=all81ubQzTKgRnk+PwTVcGJCyDf8WHC0oSVvyF6FtsA=;
        b=JfgM0a/5SvJgKpGQ7aqnmOMzrhJhubbE3UaMVIGTy35c8ssns7IrxB0cguqDOLbo+0
         MIjbLdBN8M+M8sndSBKeR7x784JH94tqg/4I8xtSaljA4CyTQ8dyBF1oojjnn+T1ALgv
         CNZbrbe4cvQWWcDHZLg9IiWiVHukCtdAOR6dzZPGMJXLTEjwCdU1sgmzgz3guK27+wAP
         DK9+DHuepJl8OM1CfxTzBlu7dfcv4/CSkG9JhjBdWy3+yaNmHpOpxgUO65HqYfw4WwZr
         oXxU1boaOKbfkoDGsnjU8CmrO0W8vmLIqk3dT1AJ8WFHRkj8awY0XaJvBzkAdW+jnJvU
         XqBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=all81ubQzTKgRnk+PwTVcGJCyDf8WHC0oSVvyF6FtsA=;
        b=LMjSn9nGzARoaf613LPFhMOShSDMzggGBSsujtK0rjIm3NJJLccrh6o3/ciPFyVHjW
         LixV4RU7222K+gSdLq28wk7nzKCm6lp4Uk2CPO5cg8hqrvdJDWyFmUNMrRDxI/MYKr84
         EqzN4LeVSLo52zJNE13FaGAGU3h5MRoOnh9CvJiwV+L81zH/Wi7ifsC9Z3BUNjQmkWd7
         vbwCc6+JUZuiiPF6/H4NPmGh0Gwj5hX1hdGgBzvpeAhE5fAHQlgfpk4iTMv744LBP0cf
         e29SDjUHIa45hjstqd6dOnCrpUU/uWmZNXwdY+3297ZH36Ea/JAssepn4Q5uvo7mgax3
         Obqg==
X-Gm-Message-State: AOAM533+epcPfLnCDnlTYVWmC8L7nFyLeIHDEtTLNen55OXJhe+inY9O
        5J1jWjcg0qGNYTe7SVqvsGjMn0P+OYFJuA==
X-Google-Smtp-Source: ABdhPJxRQCwwvMO9px+f+kzCFYft3P1EThENQ5hWoK0bCAEquxy2GDgOMPP5fxb5fFsivEosJKt9yw==
X-Received: by 2002:aca:670c:: with SMTP id z12mr3081786oix.131.1621637103389;
        Fri, 21 May 2021 15:45:03 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id i18sm1433185oot.48.2021.05.21.15.45.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:03 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 05/11] doc: asciidoctor: add linkgit macros in man pages
Date:   Fri, 21 May 2021 17:44:46 -0500
Message-Id: <20210521224452.530852-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fixes the doc-diff:

-       Please see git-commit(1) for alternative ways to add content to a
-       commit.
+       Please see  for alternative ways to add content to a commit.

Comments-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index b36317e4d2..6c4153f628 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -10,6 +10,8 @@ Asciidoctor::Extensions.register :git do
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
       format = %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>)
+    elsif doc.basebackend? 'manpage'
+      format = "\e\\fB%s\e\\fP(%s)"
     elsif doc.basebackend? 'docbook'
       format = <<~EOF.chomp
       <citerefentry>
-- 
2.32.0.rc0

