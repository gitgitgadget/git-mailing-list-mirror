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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A910FC433B4
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D61F613BE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhEOL6l (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232122AbhEOL6V (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:21 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA6FC061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:08 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id g15-20020a9d128f0000b02902a7d7a7bb6eso1570904otg.9
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1FiGAYtyFmV77j2EhKLB7vcqiackZIC91cYe2eWj9A=;
        b=l/RXPcIbu7+Rv+M05FntpZ+MuyWDM73Ywd1rjI8rZ7baRlSz5jLKbx0JRIh2TWQ/Zj
         sT6suGJ0YvlmHBsTpRiJ0xvGDtbr5ij2fzp1EKw/8eccgerNOwsP/GWLbIXPLTDrq7gn
         E1kcBlbrch5Q4aDI3X73icUroy5ZzucT2bopq0a7rOSNsR63BC1BajgB3jdZ1eejvk8b
         /lsZu8QtVdXkfhgUwBuk9aDxRft/n1KI83RW1gdORV23g+sGf6tjmgJchPygemnIMqYu
         sRH3MzyI87DOG1SgycnyTQFO68GMHVz9rSgTAytfZF2OeuUG3ewBEkoD0ZbJ+DF7uJ50
         wmAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1FiGAYtyFmV77j2EhKLB7vcqiackZIC91cYe2eWj9A=;
        b=kFElnV52MAcw2dGBrfhZJiuUZbElrPa39Vb0xNUwoncUPR3zKo8KuepIKzd4ZW3iOu
         86PNtC1Sxb1hMxASGZoSXh5/OPANmBlRo+fhxiprX3JL0a4EPzVxee9q0Vd3foRlQ2Z2
         PAHn46uSsY8J6Z7SxUouWh+iFhLVl1enUNMEVkeLtUlGmG6PPhsyCSqwWfjspPGuNltv
         ZYH4PP7ELVvcexhrcftlfDuvGa9RCKenA+X9rQu/1vrGM0xafEbxLag8Ts+4UgJ3c9Xn
         jGgrFh+urTbiWnNihKLrEt+2UOBYH+pz4VmHbyT1AuYalq9NKoGBR5Mh4dzt3KHNY9uj
         bG4A==
X-Gm-Message-State: AOAM5327YT6bCTQ40AwQIuEGjJFk9WdhyVNoEYo7edzT7GiGGikyb9Nw
        vFJNBSvSVHMzO8ZsR8dBWuWQJc953XI56Q==
X-Google-Smtp-Source: ABdhPJxutud09zYRdCNTmr41Ts6f+JKQmbXhEPEfm/gBZrQINTGD08rFUsW5DdbOK1yc4L/rr7qWkg==
X-Received: by 2002:a9d:542:: with SMTP id 60mr13024459otw.143.1621079827835;
        Sat, 15 May 2021 04:57:07 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id y191sm1710432oia.50.2021.05.15.04.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:07 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 08/12] doc: asciidoctor: use html-prefix only for html
Date:   Sat, 15 May 2021 06:56:49 -0500
Message-Id: <20210515115653.922902-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is what asciidoc.conf does.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index f998a42249..c77b6de350 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -4,11 +4,11 @@ Asciidoctor::Extensions.register do
 
   inline_macro :linkgit do
     process do |parent, target, attrs|
-      prefix = parent.document.attr('git-relative-html-prefix')
       if parent.document.doctype == 'book'
-        "<ulink url=\"#{prefix}#{target}.html\">" \
+        "<ulink url=\"#{target}.html\">" \
         "#{target}(#{attrs[1]})</ulink>"
       elsif parent.document.basebackend? 'html'
+        prefix = parent.document.attr('git-relative-html-prefix')
         %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
       elsif parent.document.basebackend? 'docbook'
         "<citerefentry>\n" \
-- 
2.31.1

