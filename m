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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07978C433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE8A46145A
	for <git@archiver.kernel.org>; Fri, 14 May 2021 12:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233184AbhENMQt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232712AbhENMQF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 08:16:05 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37C0C061761
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:53 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 69-20020a9d0a4b0000b02902ed42f141e1so16077324otg.2
        for <git@vger.kernel.org>; Fri, 14 May 2021 05:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=no6C6rlHoDZr+R43OkYQLtRQ20yjXEyATkgANNl/oss=;
        b=DdI+ERWXceqGOEukM2zxFo8ioNzUipGonWx93Dyx5w7kwxKs9oZFr2MSALv4VShaQY
         ilcNkLCYmLZMdJkQPLoui0OREJDm1fRW4tr/R2ge8Os2TUOHDuS3Wdkzhwu6VcKYZKKn
         feccSIhtwexhjqI78aDgC9CcNfAPogZH+o+JsBquySCWDHw22KkWd+Uq9uaR9r3rAOTi
         EFQSv3WYpxdVj2PmOD/ZwElIVXJ/8eZwi10s3B8BhqbmohCfjtv9KS/ueExU9fnrk2pk
         qLLErkR7TDIouVc8VZ0u502oAd5sF283Zw3ey0LPa+krw7sFypkdfVjeq/op4e8OQ1pY
         CWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=no6C6rlHoDZr+R43OkYQLtRQ20yjXEyATkgANNl/oss=;
        b=Fr4RtKagX+SJCK4y+YfKuy3dlu4OqZl5lRws76wUkdMVmI3CrBLnyo6iVKb88Aja5j
         ypYGPGtlSxIuDr2xoZoZsW8dFo1uDrzQp0eG1C1hiqbd9Qn3fJOLK8s7SsPBCRtWJS13
         YCNNNXEw0ZwX3nF5awFMuZfNEtZbQ2JNjNogvXklXnZfYOIrZTFuEjxEC/t7Nb5FoNZn
         bivrGCS1mnCns+mx6Ik3MDrBLRIP90s/IPNx9RoWYNpReeiKivj2ZnV4TQiKHPeaRxc6
         +e9BQOcH9pkdfZCWeHGen9/ur2OEKmtYpzDg0fJcUp97ynClGD/0eBImLT5Lp93WqDfA
         BDCQ==
X-Gm-Message-State: AOAM5307dDDLH4rZY5NuOU8MMgFGcAIq2HwC3CTShcFDc31N1QpSuqMl
        GwgYRqhAqUP7kWd1T0lPOQWECCN1c8YcEw==
X-Google-Smtp-Source: ABdhPJxHiV6bR2dXwwMinOU2PT6njUOllyORcG7p3lwAH24Y2IBMN6eFywGMtt6/1uOTaIF5ZAS9rw==
X-Received: by 2002:a05:6830:40a4:: with SMTP id x36mr36230780ott.342.1620994492907;
        Fri, 14 May 2021 05:14:52 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id m189sm1128807oif.45.2021.05.14.05.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 05:14:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/11] doc: asciidoctor: add support for baseurl
Date:   Fri, 14 May 2021 07:14:34 -0500
Message-Id: <20210514121435.504423-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514121435.504423-1-felipe.contreras@gmail.com>
References: <20210514121435.504423-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So that we can present relative links correctly.

Reduces the doc-diff:

   NOTES
  -        1. “Understanding history: What is a branch?”
  -           file:///$HOME/share/doc/git-doc/user-manual.html#what-is-a-branch
  +       [1]    “Understanding history: What is a branch?”
  +              user-manual.html#what-is-a-branch

   NOTES
  -        1. “Understanding history: What is a branch?”
  +       [1]    “Understanding history: What is a branch?”
                 file:///$HOME/share/doc/git-doc/user-manual.html#what-is-a-branch

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile                  | 1 +
 Documentation/asciidoctor-extensions.rb | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index a514a4e72c..cc5ff54d92 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -193,6 +193,7 @@ ASCIIDOC_DOCBOOK = docbook5
 override ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 override ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 override ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+override ASCIIDOC_EXTRA += -abaseurl='$(MAN_BASE_URL)'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 42133ee6c3..2ed92c3055 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -17,7 +17,9 @@ module Asciidoctor
 
         footnote = doc.footnotes.find { |e| e.id == node.target }
         if !footnote
-          footnote_text = "%s\n\e.RS\n\e\\%%%s\n\e.RE" % [node.text, node.target]
+          target = node.target
+          target = doc.attributes['baseurl'] + target unless target.include? ':'
+          footnote_text = "%s\n\e.RS\n\e\\%%%s\n\e.RE" % [node.text, target]
           index = doc.counter('footnote-number')
           footnote = Document::Footnote.new(index, node.target, footnote_text)
           doc.register(:footnotes, footnote)
-- 
2.31.1

