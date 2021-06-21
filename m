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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D468C4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB57A6102A
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231796AbhFURCE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:02:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232856AbhFURBI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:08 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B077AC0A887A
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:55 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id d19so20524457oic.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gaoUr5T2sLk0CaRIA05qEu9pi3x900FWIPt5mKEk5jo=;
        b=f/cDe78AfmVIEhEtH+DS4dD/j7K6ppqn02O2SNxQ6w1c5Fk7CKcu6Yo1+hvbw6dzwz
         /BorwLkxwDu9gPTCYasGSBWKd/ZsqJm6Vq5mlI0LW5A9+ksaTicCNIJdrHjwrKuB8TK3
         BZ5kUR63StaPYpoDtoNMU/delM7+tZV9IonE7RgjsJ4NHjdD8eT4pv8/VtbMx6SKDvrx
         YMJB+4diDha6Ld7pq2WxWw0BDwIX/qevrdTS4c4eE7Dl70DwdTPE8gpQgyIKI1024pHL
         MCrBvHxOhQy0FaxI1ErWk9sDHRzX8BLUFJ74yKJ81tlYx5NFzCB2IV/7+IAAl8MuAp8X
         0a6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gaoUr5T2sLk0CaRIA05qEu9pi3x900FWIPt5mKEk5jo=;
        b=K6PIsDXwqnSPLU/vU8N72fRopYgi3IMhfIePUuH8+rDMd0gZ9/MfLi088U30CT1jn1
         BZ7U++HTwl5ficfaVxusLAJmKlP9jZ3Tv57xEkYSUu+eCg9vkXRHERh5EBvKhNXYH9qk
         NewflIR6ihipnMP+jTS2dqOozM2FKhyyb1DYnhSN6RwtnycWyzLOF0iDbsoWk7THPzY4
         Hh+jaIt8rPed011gdmjFtoJL43KZwP/nV8ZNQ6nO9FqG60w+rW63NsvWguLtpbLiIUhL
         Cm30NzQKsvqouFB115tSqcYA8l+i0cQ6QuwP/vafe95vcZx/eOjK1SHdzlPhVyCOlY+x
         KDEw==
X-Gm-Message-State: AOAM530pMTmkGpabKTGEsOvMF9dP0yDxPNdl6SGPUXqXJ8gb1hnF1PA+
        pPT6TkukMLIGoKsCkpA6TXZX0Xshc34Jag==
X-Google-Smtp-Source: ABdhPJy1W7sPIOshLuU6sTnrzbwMStwFtXmsHaOK26jfZZJV4EUBExs4mZfkNZBoPEMlF+xa5rN6TQ==
X-Received: by 2002:a05:6808:f86:: with SMTP id o6mr2001356oiw.125.1624293114800;
        Mon, 21 Jun 2021 09:31:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s2sm691597ooa.39.2021.06.21.09.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:54 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 17/23] doc: asciidoctor: add linkgit macros in man pages
Date:   Mon, 21 Jun 2021 11:31:04 -0500
Message-Id: <20210621163110.1074145-18-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
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
2.32.0

