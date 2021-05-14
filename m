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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A44FC433B4
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76EBE6145B
	for <git@archiver.kernel.org>; Fri, 14 May 2021 11:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhENL57 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 May 2021 07:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232428AbhENL5x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 May 2021 07:57:53 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F85CC06174A
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:42 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so19913355oth.8
        for <git@vger.kernel.org>; Fri, 14 May 2021 04:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=drGtLuFRBaz3x+0qNIPi2JxkgIsAzz1gR4HjqlfeXgU=;
        b=l95mZD0IAf/GgjDCt2eJN4tipiKEGmJXYtU58xFLslymdmtUE4bsuAudMD2E52xP8s
         DOr+qiI6gHHWb17Vt8Sd2j+TbEXvCV/tVdstaX8G18CUNAxyl7w48S4w5n50BCjZpeQw
         /r14UgPtXOLS8rLXpXZB+CqDqc6enYaKsYCa3+6CpX19kppJCa5jmT8gHabDzswf+km5
         ZqdoyXiTGLHNfpfyFZT/++DUGFdZn2u033M4WjB1RG5AQ7qOgPvhOjcRbFtK/mgAOBPs
         9/5wcB3KpsmWStNiAud3yH7YMrsutrC0T8oejQ0BqEo5//8cr+DnpujACSAZ0qG5fEMN
         Bk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=drGtLuFRBaz3x+0qNIPi2JxkgIsAzz1gR4HjqlfeXgU=;
        b=EbVcHtP3F1M/yfP0PLNKbxNrqfcdoTofPJkvgjbp8WsK2z6bavvpTJvJUqnFldaQtZ
         uhnBQWL42eQKMYcz/vx5QZjw+15FSnEUqZM3GACO7iH/s0T7CDnMri8rlVsWpoSRUmsZ
         LHKuELOkIqDChZCxXRrHdpEm2hDrgmhltrF32IT/5+ggfX3utZ4Ni+pHldczrGgy70ht
         i3dnBCNnqQjd9XXmrq5dzJLS2CfYEr/yFLZYKNdkAXDefhOg6Odf+rXO6YvSYPID5Q2O
         XXAcY86ONSBWBHl35FgAM55doGTg3HXtJzheqLiNVaX9NRDsshQuXlZUkyV/tt4cvDXF
         8buQ==
X-Gm-Message-State: AOAM531tNtGTu3Wtn5+WbE+sHmuanJe+atyWbzABd9qrKU3dqPWxQ8cF
        fdtxA/bPfz88FwHfAztJRp5opesFMW/byQ==
X-Google-Smtp-Source: ABdhPJxTG2Bij9iV2jnwCPF7dRNRdVdZ6X8z4RqANeunceXpOicP2qpiQ82KikSNeXw9Ng3NGgetqA==
X-Received: by 2002:a9d:470e:: with SMTP id a14mr5518981otf.236.1620993401458;
        Fri, 14 May 2021 04:56:41 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id y14sm981768otq.4.2021.05.14.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 May 2021 04:56:41 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/5] doc: avoid using rm directly
Date:   Fri, 14 May 2021 06:56:31 -0500
Message-Id: <20210514115631.503276-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210514115631.503276-1-felipe.contreras@gmail.com>
References: <20210514115631.503276-1-felipe.contreras@gmail.com>
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
2.31.1

