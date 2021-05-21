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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55051C4707A
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37F39613AF
	for <git@archiver.kernel.org>; Fri, 21 May 2021 22:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbhEUWbU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 May 2021 18:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhEUWbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 May 2021 18:31:16 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06F9C0613CE
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:51 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so19398908otc.12
        for <git@vger.kernel.org>; Fri, 21 May 2021 15:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CppMIyxNHXEDrd4wQvWEPsZhtP26lqLbX5TM9tK52QI=;
        b=HgvtV9F0IWPWoqVBjLLMKaJSPTSzu3z21yVEby+fZmbgr9M7WmCRHpmfWoG2DnYDjK
         ZCXjxWdrRmagD/N3iTe7lB+xPMf98V5saVtR/VNgLSGT47lb83zW4H22hxMhpOSG8luR
         Avfhr3IXdd0ptISLoKYD4cPZBeS8ifLXsE9OCUZ4Sik8dP18BYL6WECpoSqpsIcUXpes
         HJR0Q5w3CT+f00Wi4kgj1RoaTIuIH3epMjh636r+QkQ7kFk/XxtcuLgVxfwND+gFau5h
         vunwzrEWUT/VqXwBKturNe60jYRbT3w7zoC2CvsRlMRj80Mbf1yTKU8gs5/afJXE3eLb
         OO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CppMIyxNHXEDrd4wQvWEPsZhtP26lqLbX5TM9tK52QI=;
        b=n7QNmxVlxeamKajBL1E8pt0VRfdiT/ZRGw28/LK0WGDaED7aOkS0fsuGqj8X8zcE9p
         uaPnEuBr5iTg++DIDMBtt2mge3jSpq8hNXLqWryZ1OEuMPxIeuDdz87l9YbivDczhGvT
         g4FProYIFPAmSvHvnpEqmzVBFW6sSLYLPFVYkjEzjtlL9qBWSnP/HF42uXwu5LAcb2ms
         R3Kw71BHjorreFp7a8CZqkB9QYjC7qrYh2r76Kc77Qy6QHYbVkE5Pp6PPapu5yXOh9to
         st9s9rDYSu4YLj+7Z029Dnx65vyAm6NL/efxqKNTIfqPNujJ8P9E1g5mfhn1Hrnt3ELk
         n5rw==
X-Gm-Message-State: AOAM532Vt8p0ytdQ/4Wvv8aaRednuNhf4+jBVs4yQzqm4X15m8752FA0
        FnxERguJ4nS7R5anF3Mx5cUb+OJ56ODqiQ==
X-Google-Smtp-Source: ABdhPJxtnXTYgYpj2pf16xkQD/28mkuiZhX769c2K1vqmGjC5U6L/UVMI1kxpVz2XldwxN1rV8PfpQ==
X-Received: by 2002:a05:6830:349b:: with SMTP id c27mr10529803otu.251.1621636190818;
        Fri, 21 May 2021 15:29:50 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 19sm1343198oiy.11.2021.05.21.15.29.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 15:29:50 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 5/5] doc: avoid using rm directly
Date:   Fri, 21 May 2021 17:29:41 -0500
Message-Id: <20210521222941.525901-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210521222941.525901-1-felipe.contreras@gmail.com>
References: <20210521222941.525901-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That's what we have $(RM) for.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index eaff97dcb8..f5605b7767 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -398,7 +398,7 @@ git.info: user-manual.texi
 user-manual.texi: user-manual.xml
 	$(QUIET_DB2TEXI)$(DOCBOOK2X_TEXI) user-manual.xml --encoding=UTF-8 --to-stdout >$@+ && \
 	$(PERL_PATH) fix-texi.perl <$@+ >$@ && \
-	rm $@+
+	$(RM) $@+
 
 user-manual.pdf: user-manual.xml
 	$(QUIET_DBLATEX)$(DBLATEX) -o $@ $(DBLATEX_COMMON) $<
@@ -407,9 +407,9 @@ gitman.texi: $(MAN_XML) cat-texi.perl texi.xsl
 	$(QUIET_DB2TEXI) \
 	($(foreach xml,$(sort $(MAN_XML)),xsltproc -o $(xml)+ texi.xsl $(xml) && \
 		$(DOCBOOK2X_TEXI) --encoding=UTF-8 --to-stdout $(xml)+ && \
-		rm $(xml)+ &&) true) > $@+ && \
+		$(RM) $(xml)+ &&) true) > $@+ && \
 	$(PERL_PATH) cat-texi.perl $@ <$@+ >$@ && \
-	rm $@+
+	$(RM) $@+
 
 gitman.info: gitman.texi
 	$(QUIET_MAKEINFO)$(MAKEINFO) --no-split --no-validate $*.texi
-- 
2.32.0.rc0

