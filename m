Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C836C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ECA260FF4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 21:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234656AbhFRVyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 17:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbhFRVyo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 17:54:44 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A62EC061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:34 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id w127so12128262oig.12
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIsKpyLpMwcV0waRRl8hCLVzOTf82aKkn1sUYBQYWTs=;
        b=SX+NMircqk+0xjls2Wug8M2Zijs/lmkjsbUeVsTbgtCrwZvv/UDws87P9tFHGGAfuG
         y0oluZlU9IVXbQS3MGUiuveHVnZyd1I1QJo5avxC8cxYirKUDdeg+2qwadOEKG1PlLIX
         uGq9YPktN3pQPu91ReJxwtrBAlMrOH4ZzK331P+UavhqB3r+ksUHefKX5igIHpxMbUYx
         ElwzBcQopKnKRC7o17KcoL3PkYKxRiPdfFqDGjJrtSLqp2c7rfHIsMDgB77VNLdQweKy
         xs0qZUzxrkiwoTheKRPVWX+wIraxD7kCRXOlFN/42YbxaGPYxnvlOs0JdXrrwFxvi+hg
         4F6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIsKpyLpMwcV0waRRl8hCLVzOTf82aKkn1sUYBQYWTs=;
        b=DjgKqm6CjJX9JHwjlIpwGwcee8rfDFB8rcuuLrxnpvwtSv2Zk2HGs6J6oU+YrUoCjK
         /wxTF4PnZJlh9D5A/Uufuswvj1iNBr1zaXhRy4F9IgyRCegt9qMF+Y4Q0DXC7paHV6EX
         CDG4X0j6boIsnjTE2gCPXIxY5dhQCBjQ9cq0o7Jp8T57mW8kume/Ri5aF5nU2Bc+OUyq
         3YinQhV2fvQ/wFAicRuxg7cobMNtzQtCuPuxaIYVW+S8ZLD9+t2fcFKrRhopt2fPe5a6
         mKr/ahTEN8THGKUP7BZhGZF2jlwLy0PpgDsuwROIRHqrCTn1njEdJdzOEaQI/F9gpvLK
         s+Lw==
X-Gm-Message-State: AOAM531D9DNxvcp8aTfajOgUdwIgiP5wUibw7ODvguplDKMz/+9Iz8J8
        /EozEYNB9jI9IW5At+ZAUnzpwFYwdrCJDQ==
X-Google-Smtp-Source: ABdhPJy+u8NoX/00sRWEOODho8Hh0plbj3Ogn8nN4FQvbEYzoNwk3FrBXMiFmHQ4uswJtgi8yrQ2nQ==
X-Received: by 2002:aca:ed0f:: with SMTP id l15mr16066366oih.136.1624053153377;
        Fri, 18 Jun 2021 14:52:33 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id c22sm1859076otp.80.2021.06.18.14.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 14:52:32 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 0/4] doc: cleanup old cruft
Date:   Fri, 18 Jun 2021 16:52:27 -0500
Message-Id: <20210618215231.796592-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series gets rid of old unnecessary workarounds and convoluted
solutions.

I've dropped all the asciidoctor improvements in order to smooth the
landing of this series.

This conflicts with bc/doc-asciidoctor-to-man-wo-xmlto which in my
opinion should be dropped since I have better proposals for pretty much
all the changes there, and doesn't even apply on top of master anymore.

Felipe Contreras (4):
  doc: remove GNU troff workaround
  doc: use --stringparam in xmlto
  doc: simplify version passing
  doc: asciidoc: remove unnecessary attribute

 Documentation/.gitignore                |  1 -
 Documentation/Makefile                  | 19 +++----------------
 Documentation/asciidoc.conf             | 20 --------------------
 Documentation/asciidoctor-extensions.rb | 17 -----------------
 Documentation/manpage-base-url.xsl.in   | 10 ----------
 Documentation/manpage-quote-apos.xsl    | 16 ----------------
 Makefile                                |  4 ----
 7 files changed, 3 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/manpage-base-url.xsl.in
 delete mode 100644 Documentation/manpage-quote-apos.xsl

Range-diff against v4:
 1:  2a93d8774a =  1:  ec9f46892c doc: remove GNU troff workaround
 2:  774603b50c =  2:  f496a2ddda doc: use --stringparam in xmlto
 3:  8e92e10b10 =  3:  10216673c1 doc: simplify version passing
 4:  230b5c8ae0 =  4:  4f2e3456cd doc: asciidoc: remove unnecessary attribute
 5:  2d1f79d642 <  -:  ---------- doc: asciidoctor: remove unnecessary require
 6:  e0b662986a <  -:  ---------- doc: asciidoctor: remove cruft
 7:  1bdf72a856 <  -:  ---------- doc: asciidoctor: reorganize extensions
 8:  8612b428ce <  -:  ---------- doc: asciidoctor: use html-prefix only for html
 9:  9cd9f3f317 <  -:  ---------- doc: asciidoctor: refactor macro registration
10:  96bd66784f <  -:  ---------- doc: asciidoctor: improve string handling
11:  5e293a15fc <  -:  ---------- doc: asciidoctor: split the format from the code
12:  7fd97fc089 <  -:  ---------- doc: asciidoctor: specify name of our group
-- 
2.32.0

