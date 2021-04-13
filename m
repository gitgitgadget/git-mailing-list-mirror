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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67C28C43461
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AC676109D
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 11:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245001AbhDMLmP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 07:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbhDMLmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 07:42:13 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE60C06138C
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:53 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id f17so19750968lfu.7
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 04:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn9QqDpx/Z77mFW+plPu8eUKAUu6dpdKxRaYmz5Jji4=;
        b=Hg7okFOp/3rUPLYTrZndTBzXBNEf6LskEWLhZD/th3cBCpFLNSu7kmtfgZoA/aNW2s
         DFx17qT2z/DkPH/CctTwBP26fkbHlOoqF8NAxrBOseOqDSIti/llsccRTpe6XcoFDzlJ
         g7B6wcPq87y1O7IODyU1gzXRnLhHUGAO6VzKHg8XWWYwuJaotarFyip36Ff7Dr0lFybZ
         9EzwUbx46t+eCeUSeuuPpt2fviSOc3aNhpeC2kNcTabYVtlOlnYqqIeNyxazq2hBAQZA
         YZv8nC+ecr07/0erLTH0+2gzU5wa+NTw0/QHPsMDMwT+LpKZWghT+gcmsqEIFytGiRzR
         sZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn9QqDpx/Z77mFW+plPu8eUKAUu6dpdKxRaYmz5Jji4=;
        b=j6e6I0OYRKq1Bd3PnUBo4bK27p8UReE+PdQX51HuksND22GdrfQ52bnN6uYOZqBbQG
         JSlNDf4u+77YjzJ6dEgYQDkqMeeaxlcGYqXwUa0VF8C1/bs/MoKpWy+RCNRTwfvm51mF
         cUBXiTsKO1bKu/ig8Lj1aggGrGejPK+x5ZssK6QGvJW71Cv+V0l6bdZUyFDqsUJyCsOj
         QFHT06OnRiY2YAGS/m9hoZzb00oLfcJ/Y2pRSmdJM1So6886C+/tQxMm5Snk/Y0YmhIb
         DOG5cgBVXt7JPDbs62ExjAFuJiRX+RmbnHSWXq5eIpoFnqUiRRKu1LeCHKWv2/PFncqb
         fAkg==
X-Gm-Message-State: AOAM532GzsPw/XCmijCQ+CAzgCv6SOUgS+Yf2wmmgml06lUep+d0ey7g
        T4PUhiEXx4ejz2AvHhNpRwE=
X-Google-Smtp-Source: ABdhPJwJVUzq8pvFvLCX8Yz4eGTbIpQ3GVC7HDMuJ8R7TJPPL0/y4NWgjegiS8H0uGdXP9xiRwsqag==
X-Received: by 2002:ac2:5c04:: with SMTP id r4mr15225002lfp.387.1618314111687;
        Tue, 13 Apr 2021 04:41:51 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id b11sm663339lfi.292.2021.04.13.04.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 04:41:50 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Sergey Organov <sorganov@gmail.com>
Subject: [PATCH v2 5/5] doc/diff-options: document new --diff-merges features
Date:   Tue, 13 Apr 2021 14:41:18 +0300
Message-Id: <20210413114118.25693-6-sorganov@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210413114118.25693-1-sorganov@gmail.com>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210413114118.25693-1-sorganov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Document changes in -m and --diff-merges=m semantics, as well as new
--diff-merges=on option.

Signed-off-by: Sergey Organov <sorganov@gmail.com>
---
 Documentation/diff-options.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index aa2b5c11f20b..6d968b9012dc 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -34,7 +34,7 @@ endif::git-diff[]
 endif::git-format-patch[]
 
 ifdef::git-log[]
---diff-merges=(off|none|first-parent|1|separate|m|combined|c|dense-combined|cc)::
+--diff-merges=(off|none|on|first-parent|1|separate|m|combined|c|dense-combined|cc)::
 --no-diff-merges::
 	Specify diff format to be used for merge commits. Default is
 	{diff-merges-default} unless `--first-parent` is in use, in which case
@@ -45,17 +45,24 @@ ifdef::git-log[]
 	Disable output of diffs for merge commits. Useful to override
 	implied value.
 +
+--diff-merges=on:::
+--diff-merges=m:::
+-m:::
+	This option makes diff output for merge commits to be shown in
+	the default format. `-m` will produce the output only if `-p`
+	is given as well. The default format could be changed using
+	`log.diffMerges` configuration parameter, which default value
+	is `separate`.
++
 --diff-merges=first-parent:::
 --diff-merges=1:::
 	This option makes merge commits show the full diff with
 	respect to the first parent only.
 +
 --diff-merges=separate:::
---diff-merges=m:::
--m:::
 	This makes merge commits show the full diff with respect to
 	each of the parents. Separate log entry and diff is generated
-	for each parent. `-m` doesn't produce any output without `-p`.
+	for each parent.
 +
 --diff-merges=combined:::
 --diff-merges=c:::
-- 
2.25.1

