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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4DC4707E
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 313B5613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230137AbhEUWqn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbhEUWqf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:46:35 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9C4C06138E
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:11 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id v19-20020a0568301413b0290304f00e3d88so19449182otp.4
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1yCu4/hV2BR/zfanL7W8lWbqh32GElVDBuizt+GdKI=;
        b=QGRxtl9GC6JhvcIsVe+g4Mv7XtxTzrkReSASDNjLX8ea2cK34z9nTS6Ir8262wOVym
         W67YAtCYjScHs3Prq2HqYywFpaX8ItUB+EsN5CahmO389Sb0S6NbrADidE1DZmJ/gQdB
         bFnQKf49Y6OjJyq4pvI2w0zXS52L2qwcwYWvvnc0LyYvdCRFmzmDBaim405Hp+eWLshb
         udHjP34Q8bsEFofkgShPZnG9Ij5i3LmqbFHPbLK63WkqHbXMe4hEDWXoA3gq58Uf6li/
         4Bv9VVZeZRWPeKdFgVzEbl5oVb8AGkl3Lu9aUjBFFpJBb9ghCraNorWwxg1TFGbyeHhw
         uokQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1yCu4/hV2BR/zfanL7W8lWbqh32GElVDBuizt+GdKI=;
        b=nc9t9lsJHurk8NK0nEk2QhdFWNYZNpsHKs0VR96kDCVbGbcTUY5XVufA0Wli5IA4Fc
         M7Ku+63ACNa0FCFP5yc5LACHwJFHwntHjX8eToJm84ZguMAUtum0qVQCKqJdoP8msIyZ
         LzHPQNgJpoZwOX2xJnJsoQITGGyxLdvoGl0oHlxrZP42L3vL/tA1KfoWzh2vLQfWoctL
         oMasJafsuxYL2viObmN96ffk6s7ii69Rm0BJGQAcnRE6//y3/2EEG1ZVtTxAW8lw0APm
         OpvmqWvKZSh6LrWft7s0W3NLIPBdO5ZQ36TgL/Pecl28Qvgday1PE49FkHXKu9Ad7UiH
         lsIQ==
X-Gm-Message-State: AOAM530xBC3kFasAOjvObBzofVBz3VLBaQzCn0zmOD/dw56xLv4kxDIS
        oBYSR7jrbgHaXWv8sRagKu8KTo2KCkbfiQ==
X-Google-Smtp-Source: ABdhPJzQwhc+fs8NW8h97GCh7LUqMEdx5icWB/S7Ht2ABUdvV1Gbgi9q3gZSDzH0xFi53m2JsQMFJw==
X-Received: by 2002:a9d:77c7:: with SMTP id w7mr10264393otl.364.1621637110640;
        Fri, 21 May 2021 15:45:10 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id o13sm1556441ote.32.2021.05.21.15.45.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:45:10 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/11] doc: asciidoctor: add support for baseurl
Date:   Fri, 21 May 2021 17:44:50 -0500
Message-Id: <20210521224452.530852-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521224452.530852-1-felipe.contreras@gmail.com>
References: <20210521224452.530852-1-felipe.contreras@gmail.com>
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
index 0c654f4ec9..c28c49dd7a 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -185,6 +185,7 @@ ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
 ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -abaseurl='$(MAN_BASE_URL)'
 ASCIIDOC_DEPS = asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 914e6f64c8..8856f2febd 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -16,7 +16,9 @@ module Asciidoctor
 
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
2.32.0.rc0

