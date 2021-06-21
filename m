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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5234EC48BC2
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F0A961107
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 16:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233044AbhFURBQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFURBC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:01:02 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA3AC0A54D6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:42 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so18341847otl.3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 09:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0OwNfS9ScZ7L6vTIWaYLacOWVDKxRatRYEoPajaBQbY=;
        b=ZIZOedf5t1ObYGv/dGIm1F7+wXXBkD2zG1xogZkzZDmGZ7KS2r/i4ZqAyymiRaF9DN
         I9JkJE4jvXkL8StDaSIG03LesImodROBgfWFRVIGJUCxuLQqedR3Ffno5d3MT6gOcM63
         WAdQIe7Wkv28/nvFyM8rTA1TDb4KgLiUgXLM3s4z4ZJ2i9LexJu8V3aIo6S80Pph1raV
         7bmUmTvyeJVnknJI9wVGSp3zDPeVdU6I4LUtjH4aQgLic/7Vmb55AGgIE0iyaRob1BBG
         IxIhXonfEz0XyDVkX14C95Ghd6p26LTB5hATTfBZ7WPl848Wy8WHlDVRHRMmtxhMIsE9
         tPxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0OwNfS9ScZ7L6vTIWaYLacOWVDKxRatRYEoPajaBQbY=;
        b=etdA66GLOTsagBItR4PkUNNgckmTwqlMTSMxgiyAniEcKzC6tYR4Ie0kztPdN4FpMl
         2ZVjsVhhLK0BN9PugufxsIg8US/zk/LlxOQqbaxmP5L8QOJDRu1dDIdahX6ctWsKmvAm
         gyq5jMVYNV9vS1hhBBcAFf0CQf2MMMD4HIH0XSBpT/tVrR2dUru96kHl3hMa2yivXqBV
         uPnznP0MKJuxLmvq+xMSwTZIoAV1CCfHUnoHPNPfPC+o9v5TAyTUTLF9DP6JQ62kHR+q
         iPS5wMh9qpyoGRzfPcx91vQn35bnFnou6LuPtIiFgy4KZhqgbX5Sk4c+Z61qNZcPhpCA
         gjLw==
X-Gm-Message-State: AOAM531qbk6bmRU7SootoN31MmytZdvGzo4qAtn2QJoeu8RcokXXPCgb
        Ke6enhSvf8vpo3IAwk0w8nh0OiJI+B84kA==
X-Google-Smtp-Source: ABdhPJyPltHW7KdyehxRESHvnWhlKOenM3O/MdxXzhObX3ytcW5iS1YunyWWLWRqx7Qru71Q1u1+bg==
X-Received: by 2002:a9d:3e15:: with SMTP id a21mr22146844otd.366.1624293101385;
        Mon, 21 Jun 2021 09:31:41 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id j22sm1052857otl.46.2021.06.21.09.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 09:31:40 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 10/23] doc: asciidoctor: improve string handling
Date:   Mon, 21 Jun 2021 11:30:57 -0500
Message-Id: <20210621163110.1074145-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621163110.1074145-1-felipe.contreras@gmail.com>
References: <20210621163110.1074145-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using printf style formatting (more familiar to git developers), and
also here document.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index a678704e17..3282d59a48 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -7,20 +7,20 @@ Asciidoctor::Extensions.register do
   inline_macro :linkgit do
     if doc.doctype == 'book'
       process do |parent, target, attrs|
-        "<ulink url=\"#{target}.html\">" \
-        "#{target}(#{attrs[1]})</ulink>"
+        '<ulink url="%1$s.html">%1$s(%2$s)</ulink>' % [target, attrs[1]]
       end
     elsif doc.basebackend? 'html'
       prefix = doc.attr('git-relative-html-prefix')
       process do |parent, target, attrs|
-        %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
+        %(<a href="#{prefix}%1$s.html">%1$s(%2$s)</a>) % [target, attrs[1]]
       end
     elsif doc.basebackend? 'docbook'
       process do |parent, target, attrs|
-        "<citerefentry>\n" \
-          "<refentrytitle>#{target}</refentrytitle>" \
-          "<manvolnum>#{attrs[1]}</manvolnum>\n" \
-        "</citerefentry>"
+        <<~EOF.chomp % [target, attrs[1]]
+        <citerefentry>
+        <refentrytitle>%s</refentrytitle><manvolnum>%s</manvolnum>
+        </citerefentry>
+        EOF
       end
     end
   end
-- 
2.32.0

