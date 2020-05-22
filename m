Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D22C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 00:25:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 069012067B
	for <git@archiver.kernel.org>; Fri, 22 May 2020 00:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CLo1KEwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726812AbgEVAZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 20:25:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726650AbgEVAZN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 20:25:13 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77AD2C061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 17:25:12 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id d7so11015045eja.7
        for <git@vger.kernel.org>; Thu, 21 May 2020 17:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozQlQQv0SPjD5SN2F5m5r1muNv4gpVwXvn/S7pupZOY=;
        b=CLo1KEwUIe/YAD2RBxJ50lqshFj/zWo3yRL0/M+alzNizhwCyzjKw/Wb8wp+SLDT43
         41NrGfcRQ2JGtgU/RowMYlQK9POjqUY4dPeLQgI+VBLcsYnSycND0FAhKOaTPFC8YqgZ
         L4Fe1rzSg6SwbrAzlgEObHIKfhbcOMoFd2tG0JBgwPzmszfr5CI1307FCJXFDCKrE/T3
         Nps6jbykzyegccEVSdluNtFQXG6LoMPtW27Bnp2HHupW2PHUY5nxXdDcUi3L36PLNZ8R
         VvIegwYtzFXMwtVxBTHhwQjsXe6bDFlftV6x/YzrB5NujwNvsPQVjMk0GUoTbJpwgydQ
         klEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ozQlQQv0SPjD5SN2F5m5r1muNv4gpVwXvn/S7pupZOY=;
        b=YBcC6DCi2Zt4m5JsPaLXo4lH1B3yAbYgZlpFznnXIsDmWKOPbmYmLVgL7Y8wEgV2nU
         2TOrHT5X05KkZjeW3ox9FJyZ/EMpgqNiJRL2V3LLYK9Q0GBM1zLeMexFl8Ts6Dx1j8aw
         HVEsRuppKSpqrk5lf4IuyaIwu2UWh2pW4t37250T09kiznHwluUdbr9VoMEUgc1847cH
         K0zqfJ3yiwZZpNOVIeK8ZKfAub/a/aIAXrMw7gWSccQKpuqzDerK5q6RlIMYlyhEO9vC
         /vF11ZG6q0CETEdYdccTA3gClbvdUddqza2OpWiDyfWUZxP0k0Dj1EfKMOdGU4+rArv2
         dnqw==
X-Gm-Message-State: AOAM530BZCyBe0P1DBLTG/1/9UZOY2alPCFq7b/ZwmAFn0CqfSeHNyLe
        /EBPdhmmqqPc7+KGoJFemn6QDzyR
X-Google-Smtp-Source: ABdhPJxBsLtM97fC/18Z6xyilxP07jDTXaNSiAmW9hVrFYeQdbpaAVKJZ8kvEq3iMQyZ3wVZRXdnBQ==
X-Received: by 2002:a17:906:3ed3:: with SMTP id d19mr6355705ejj.404.1590107110716;
        Thu, 21 May 2020 17:25:10 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:5411:bf04:1190:8b1d])
        by smtp.gmail.com with ESMTPSA id h18sm6544607eji.86.2020.05.21.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 17:25:09 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH v2] sparse: allow '{ 0 }' to be used without warnings
Date:   Fri, 22 May 2020 02:25:02 +0200
Message-Id: <20200522002502.9010-1-luc.vanoostenryck@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In standard C, '{ 0 }' can be used as an universal zero-initializer.
However, Sparse complains if this is used on a type where the first
member (possibly nested) is a pointer since Sparse purposely wants
to warn when '0' is used to initialize a pointer type.

Legitimaly, it's desirable to be able to use '{ 0 }' as an idiom
without these warnings [1,2]. To allow this, an option have now
been added to Sparse:
    537e3e2dae univ-init: conditionally accept { 0 } without warnings

So, add this option to the SPARSE_FLAGS variable.

Note: The option have just been added to Sparse. So, to benefit
      now from this patch it's needed to use the latest Sparse
      source from kernel.org. The option will simply be ignored
      by older versions of Sparse.

[1] https://lore.kernel.org/r/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com
[2] https://lore.kernel.org/r/xmqqd07xem9l.fsf@gitster.c.googlers.com

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---

Change since v1:
* adapt the commit message to:
  - fix a typo
  - give a reference to the Spatch patch
  - add a note telling the latest Sparse source is needed to
    benefit from the patch but older versions won't complain.

 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 3d3a39fc19..69f065ef8c 100644
--- a/Makefile
+++ b/Makefile
@@ -1189,7 +1189,7 @@ PTHREAD_CFLAGS =
 
 # For the 'sparse' target
 SPARSE_FLAGS ?=
-SP_EXTRA_FLAGS =
+SP_EXTRA_FLAGS = -Wno-universal-initializer
 
 # For the 'coccicheck' target; setting SPATCH_BATCH_SIZE higher will
 # usually result in less CPU usage at the cost of higher peak memory.
-- 
2.26.2

