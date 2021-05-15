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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38F5CC433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14A87613BE
	for <git@archiver.kernel.org>; Sat, 15 May 2021 11:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbhEOL6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 07:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231874AbhEOL6T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 07:58:19 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89199C061760
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:05 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so1566714otp.11
        for <git@vger.kernel.org>; Sat, 15 May 2021 04:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qryDjEvV0FR5O6sICM8r4iYOMLB0UcHl5tSJzPfl088=;
        b=nfFEZzovFPAxHmeltyLKXW13MK1V1e3hYUCbulYZCIF+zvdZWFfDQP8vgOtutL0ilE
         4Dl3c5b/GjcCOgGMsAt6cXM6YJF/i76xqbRrkDcSkHF8DjRpNks9dkRq4PP3oIpOewHC
         TUHZRGn9cwvOVYSgxaigqcc54aD0Zj2ktvsPBfBBiiqirN1TvlkUGOY0DEDv0CojUp3x
         F/Hg553M37hhTsuSuU25IgJ/DyIaAn9aUjnyvDTbp5yoWo18ZSAKDc8je3GtT0jvMTIF
         4ENzBRFl4cneI/PlTc0i+s1s4FQgbwHxfuiAOc7EIoeiSIV5T0Fi2mHK3lyFJYOD52t+
         feFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qryDjEvV0FR5O6sICM8r4iYOMLB0UcHl5tSJzPfl088=;
        b=FU/uDxumvknWuY4fkraeLIq9A04ROjqYXMs8y3ecQfV/FpT3cKh5zAQ7vO+X3WjDBa
         iBHYZOZbQFm1N7MiK9aokVqVyhjWnnCT7svR/39C5nEoBrS9dR2KBt+6VcRRDL8OJPFe
         WDCM54V9GvYTfUW/zhmiOZ0dyiI/XnuzLN/hdQKtdgIz7rQ4LjPV2qaCQFt0JPxoRWjo
         sd4XGp+OE+c7sDt4RbWD9H5eC33Da2wAH8ofLOfNz+oxuUSA85SNDe0L0m4Z45Ab1DqC
         9QbvGc23BCCkkYzpFBfYx/NhLnbWScxCfSiMVt/rfHKlr9zTGpSHlcVIlgwZMEVcxPlc
         PTFg==
X-Gm-Message-State: AOAM531YpV5al7VSD1gAQQPMjRtKu6hjD/evZQzSTXhrrCn+qbYIiJev
        bdnrLo9mn3Iwwj00UF4GqYuuZveRoGJnJw==
X-Google-Smtp-Source: ABdhPJy7eBFtjVY3ijnDX13XMKLuJPLLEjinKIF2Imj6lJBZpFTxFVzlhq8wsvY+rdBzenzSoZB++g==
X-Received: by 2002:a05:6830:44f:: with SMTP id d15mr5402233otc.369.1621079824775;
        Sat, 15 May 2021 04:57:04 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id b8sm1768818ots.6.2021.05.15.04.57.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 04:57:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 06/12] doc: asciidoctor: remove cruft
Date:   Sat, 15 May 2021 06:56:47 -0500
Message-Id: <20210515115653.922902-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210515115653.922902-1-felipe.contreras@gmail.com>
References: <20210515115653.922902-1-felipe.contreras@gmail.com>
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
2.31.1

