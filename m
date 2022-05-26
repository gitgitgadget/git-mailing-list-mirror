Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2547DC433FE
	for <git@archiver.kernel.org>; Thu, 26 May 2022 02:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346054AbiEZCPs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 22:15:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiEZCPr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 22:15:47 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF48CB2B
        for <git@vger.kernel.org>; Wed, 25 May 2022 19:15:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id a13so298788plh.6
        for <git@vger.kernel.org>; Wed, 25 May 2022 19:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YlMSZRhnqrhBTXGzOxe6amiFZQlgQN+2s/tGXxSCRt4=;
        b=LsuqGT0ntJRjJSnFrzrPmYRz8dTDH1/Pvj4Z8o2i3NpqPVDbRh+RtF9WsJiNMCyB2+
         FOrYBm8htartu6farxwUAq140RWxqrUxZtDQmGSbCiXK8HDbtwWjMuxJz//ywyuibcco
         XfQ35GhSYFnzpm2ecoh3R/7p3veFcVPjNqZScWMJlXALQy0cJ65SEV5mIUrOT8imzNsI
         3FanKaUFloyD7EDc6g1qLeuiyZZURitkt8gjHfPOWvJ+zEuOD1Dtcx7dYmEJ7WXB03V9
         I1B4QxWIKKyfETka2axjZwooV5l68Nc4UlzJGx79g0bN2H7js1EPidhFib36auOFIgH7
         fJ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YlMSZRhnqrhBTXGzOxe6amiFZQlgQN+2s/tGXxSCRt4=;
        b=RhOjbvRwkmqKXBvFDnpgex2xsbP6FPDSOhPe0RrTWCelNbK+YW5LIjXmWY96xt66Mz
         lO5+rBj8trUhAF/hIius8QopkQuJNpRpo1hxyLgxFxEo2dvvNibbl+rLEuGd7FHxQbCH
         z8LlQ5PuNkCxwl0nqpgUPlGEbRQ0iYrLU+wbw3JRXJ/fVm2ODXEUXm4nQmrgIDEn2OVg
         fQEEXuZNQ2TvoecF1SyQPuWTmw/YGjM27RUauCEath3WuDd7wj7qiBo//pPCU8JjHE7i
         eO+34uUEkVJ++uO2VFE6qaUVOVULMP48IrGnsVtxWF7KW2rMAaSTbKf8D41Q2sj9IJ2D
         riuw==
X-Gm-Message-State: AOAM533cGFSrdupR0xKHmlitJ41YLyiSNgqPyEyHLo+jF6BqX9gOqvUr
        m0/gho51UKBU8yZujAS3MlE=
X-Google-Smtp-Source: ABdhPJx7JZ+JbqAXbx5eWtXS2koQwJY74CNgA/ylZUT+xhtsHDsNKYTVdrihNou9kBTGqzx4gC9fAg==
X-Received: by 2002:a17:902:c402:b0:163:5b99:8efb with SMTP id k2-20020a170902c40200b001635b998efbmr5816818plk.4.1653531345975;
        Wed, 25 May 2022 19:15:45 -0700 (PDT)
Received: from tigtog.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902ce8e00b0015e8d4eb256sm86359plg.160.2022.05.25.19.15.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 May 2022 19:15:45 -0700 (PDT)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Alexander Shopov <ash@kambanaria.org>,
        Jordi Mas <jmas@softcatala.org>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Jimmy Angelakos <vyruss@hellug.gr>,
        =?UTF-8?q?Christopher=20D=C3=ADaz?= 
        <christopher.diaz.riv@gmail.com>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Alessandro Menti <alessandro.menti@alessandromenti.it>,
        Gwan-gyeong Mun <elongbug@gmail.com>, Arusekk <arek_koz@o2.pl>,
        Daniel Santos <dacs.git@brilhante.top>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        Emir SARI <bitigchi@me.com>,
        =?UTF-8?q?Tr=E1=BA=A7n=20Ng=E1=BB=8Dc=20Qu=C3=A2n?= 
        <vnwildman@gmail.com>, Fangyi Zhou <me@fangyi.io>,
        Yi-Jyun Pan <pan93412@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH] Makefile: dedup git-ls-files output to prevent duplicate targets
Date:   Thu, 26 May 2022 10:15:40 +0800
Message-Id: <20220526021540.2812-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <xmqqtu9d45f7.fsf@gitster.g>
References: <xmqqtu9d45f7.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

If there are unresolved conflicts left in the working tree, "make" may
report warnings as follows:

    Makefile:xxxx: target '.build/pot/po/FOO.c.po' given more than once
                   in the same rule

The duplicate targets are introduced by the following pattern rule we
added in the preceding commit for incremental build of "po/git.pot",

    $(LOCALIZED_C_GEN_PO): .build/pot/po/%.po: %

and the duplicate entries in $(LOCALIZED_C_GEN_PO) come from the
"git ls-files" command in SOURCES_CMD.

We can pass the option "--deduplicate" to git-ls-files to suppress
duplicate entries for unresolved conflicts.

Reported-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index a3f8446de9..a8880ed482 100644
--- a/Makefile
+++ b/Makefile
@@ -846,7 +846,7 @@ generated-hdrs: $(GENERATED_H)
 ## Exhaustive lists of our source files, either dynamically generated,
 ## or hardcoded.
 SOURCES_CMD = ( \
-	git ls-files \
+	git ls-files --deduplicate \
 		'*.[hcS]' \
 		'*.sh' \
 		':!*[tp][0-9][0-9][0-9][0-9]*' \
-- 
2.36.0.1.g15c4090757

