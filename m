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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77074C433B4
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DBDE61417
	for <git@archiver.kernel.org>; Wed, 12 May 2021 23:27:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235896AbhELXYM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 May 2021 19:24:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349221AbhELWa4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 May 2021 18:30:56 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA3FC061358
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:28 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id u19-20020a0568302493b02902d61b0d29adso21321925ots.10
        for <git@vger.kernel.org>; Wed, 12 May 2021 15:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GV/uhR53OLHdyJng5q/OHhEJqkdcUpl+wvhx9tE92D0=;
        b=QJQPvINkSgAD0zupl5Zr1zfICvPDf0Vate9W0jkLr9cGd2MXje9sTHbGquXsYuuycn
         BUym/ec2tPpXL2BUcOfqyoR3yNRDOWxuaBTLqA6XFavDrHU/y2UPrmErPorcQnPMF4xj
         A+LWFOuv749BJkCtKccfCFTrNiSnlt6IjjwslGjuF1LkV4POc33apu1ZZvlDeSmk1zqr
         oh9hw6QNji9SWFKocUyAQrPSncAErzZdDqKGsqtN9+7N2+XYv31hBzx58zm+zPceUR0J
         b83RXi09fFwwTv2+ygRYsDP4L6crFmMKCYCoHA2yKSiZDRw9OvObJFAjKFpF2XOq/9NC
         f/hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GV/uhR53OLHdyJng5q/OHhEJqkdcUpl+wvhx9tE92D0=;
        b=WMYSR/lv+gJl23Qt3qDAiUp9Q9MPbjIcJuBASuLQctvuYawKJ4UGwrk1nOJuGVZ+40
         qkHAFr7uDDtAnSuzgKzHmzbLFAs74Vu0BB8Sqi8WfIfKdtAAZr7EHEr/MZHqmqeM9Sqz
         qSd3nh/dr8Z1ALqilGYoQhGR+ggyE5cVbenhJ7x2i94XUIsFyyZ5lAvttjAdPtUfQw3w
         3AB3t46ONsJUm8CNcAhhxCHDfAF3g8as4zhZw8bR8YU8Ft4RTL3qB446yVfCh5EbbHks
         rGtddwDGMvSuSxo6ZTrtZAWxbY87ZPXjURntTQvL5ikkXjDQYFZajOXT3NvgZ5A6eA/e
         WT9w==
X-Gm-Message-State: AOAM531DIDiFVUS4KA5QDpIGa8L5whj6BhPvvoz98FOe/zJqVYgUYLiM
        xFLELh/64+nYifg4aDJXsmqa4ZjE1bfIsg==
X-Google-Smtp-Source: ABdhPJx+If3cIKAtohZ+emtY/xRmZDrOJ/lPEUkR306lOemmzwHpQVv3Q9YEi0SzzESdzHvWuc/GqQ==
X-Received: by 2002:a9d:3bcb:: with SMTP id k69mr33710145otc.206.1620858507937;
        Wed, 12 May 2021 15:28:27 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id v28sm318451ood.27.2021.05.12.15.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 May 2021 15:28:27 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/8] doc: remove redundant rm
Date:   Wed, 12 May 2021 17:28:00 -0500
Message-Id: <20210512222803.508446-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210512222803.508446-1-felipe.contreras@gmail.com>
References: <20210512222803.508446-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not clear what it was supposed to achieve.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 956cfabadd..d02bd848e8 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -366,8 +366,7 @@ manpage-base-url.xsl: manpage-base-url.xsl.in
 	$(QUIET_GEN)sed "s|@@MAN_BASE_URL@@|$(MAN_BASE_URL)|" $< > $@
 
 %.1 %.5 %.7 : %.xml manpage-base-url.xsl $(wildcard manpage*.xsl)
-	$(QUIET_XMLTO)$(RM) $@ && \
-	$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
+	$(QUIET_XMLTO)$(XMLTO) -m $(MANPAGE_XSL) $(XMLTO_EXTRA) man $<
 
 %.xml : %.txt asciidoc.conf asciidoctor-extensions.rb GIT-ASCIIDOCFLAGS
 	$(QUIET_ASCIIDOC)$(TXT_TO_XML) -d manpage -o $@ $<
-- 
2.31.1

