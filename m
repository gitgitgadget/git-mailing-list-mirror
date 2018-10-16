Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 867E91F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:57:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbeJPPqS (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:46:18 -0400
Received: from mx.mylinuxtime.de ([195.201.174.144]:54552 "EHLO
        mx.mylinuxtime.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPPqS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:46:18 -0400
Received: from leda.eworm.de (unknown [87.190.244.126])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx.mylinuxtime.de (Postfix) with ESMTPSA id E34F9C7320;
        Tue, 16 Oct 2018 09:57:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mx.mylinuxtime.de E34F9C7320
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=eworm.de; s=mail;
        t=1539676626; bh=+0z+i9etrpsrWu//ToD3nCor2RAKlY/ZMLC/TBpJhl4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=f1J/Mp36WADvKr0oLK5zScWbdjsf5IP65d1HqhhmYiT3l9eUqOaRWLX8Zjw1ZhauN
         CZSj5UfXSfZiLQxDvemCX3Khb0lv2OR2AHUt4yejhjmjdnYGN9FKgBaYixo4uGPKSj
         riwHm85TbMmwWDyTRYllTlh4WdSU4lwkpKXXfMFY=
Received: by leda.eworm.de (Postfix, from userid 1000)
        id 58405102973; Tue, 16 Oct 2018 09:56:35 +0200 (CEST)
From:   Christian Hesse <list@eworm.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Christian Hesse <mail@eworm.de>
Subject: [PATCH 1/1] subtree: make install targets depend on build targets
Date:   Tue, 16 Oct 2018 09:56:24 +0200
Message-Id: <20181016075624.30176-1-list@eworm.de>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
References: <xmqq8t2y1o4y.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: /
Authentication-Results: mx.mylinuxtime.de;
        auth=pass smtp.auth=smtp-only@eworm.de smtp.mailfrom=eworm@leda.eworm.de
X-Rspamd-Server: mx
X-Stat-Signature: 3cybc1ndhfcgjypsxakq6sjbrkqfytqo
X-Rspamd-Queue-Id: E34F9C7320
X-Spamd-Result: default: False [0.80 / 15.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         RCPT_COUNT_THREE(0.00)[3];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         TO_DN_ALL(0.00)[];
         MID_CONTAINS_FROM(1.00)[];
         NEURAL_HAM(-2.92)[-0.974,0];
         FORGED_SENDER(0.30)[list@eworm.de,eworm@leda.eworm.de];
         RCVD_TLS_LAST(0.00)[];
         ASN(0.00)[asn:3320, ipnet:87.128.0.0/10, country:DE];
         FROM_NEQ_ENVFROM(0.00)[list@eworm.de,eworm@leda.eworm.de];
         BAYES_HAM(-1.48)[91.54%];
         RCVD_COUNT_TWO(0.00)[2]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Hesse <mail@eworm.de>

Now that we have build targets let the install targets depend on them.
Also make the targets phony.

Signed-off-by: Christian Hesse <mail@eworm.de>
---
 contrib/subtree/Makefile | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/contrib/subtree/Makefile b/contrib/subtree/Makefile
index 6906aae441..4a10a020a0 100644
--- a/contrib/subtree/Makefile
+++ b/contrib/subtree/Makefile
@@ -69,11 +69,11 @@ install: $(GIT_SUBTREE)
 
 install-doc: install-man install-html
 
-install-man: $(GIT_SUBTREE_DOC)
+install-man: man
 	$(INSTALL) -d -m 755 $(DESTDIR)$(man1dir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(man1dir)
 
-install-html: $(GIT_SUBTREE_HTML)
+install-html: html
 	$(INSTALL) -d -m 755 $(DESTDIR)$(htmldir)
 	$(INSTALL) -m 644 $^ $(DESTDIR)$(htmldir)
 
@@ -98,4 +98,4 @@ clean:
 	$(RM) $(GIT_SUBTREE)
 	$(RM) *.xml *.html *.1
 
-.PHONY: FORCE
+.PHONY: FORCE man html install-man install-html
