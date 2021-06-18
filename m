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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2C4C48BE8
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59001613C2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236374AbhFRS25 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236369AbhFRS2n (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:43 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D73C061768
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:29 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id t40so11499953oiw.8
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l4OUJ0MFZciuomuXAL2m2mr7Epmp/zVr+QKarkFWi1Y=;
        b=aM8pAsaUYkOH5uEgzWW/GYLW2jJZ7z9iRwSe48tb6xxuaTUmR6iM+u8596L9TD9+xM
         5rEqaDNhdyLNMhP7SCUsAk5aQ3e4/a37Vmd/flUxZaDBWoDhq8+HQd8gHnyBrDgN8SGD
         yeh2U+wfxcY5OJH5te04ZQS8zRPyTUIrGyE4IzvdvJnVQMX+GITt/Jn6JuF/8bqc/1CP
         Ed0Tk6TKhrCXbjKXRwW3I+NyhZ4IlUQiFfZtz1nNmdTUKVsXReNCzcnAR5PuBiVSY2YE
         Z8i8nlnPVaEPCg+XH7Raud8CkdOmKnZcPbQSitpY05i3dVYYzOKtXf6SHa7TcMTt4guh
         OnNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=l4OUJ0MFZciuomuXAL2m2mr7Epmp/zVr+QKarkFWi1Y=;
        b=iSsR/wy98n6Y6t3AE7IjMhDzl+YJsHrwcuxcGmTeafjABKxt5b3QLSj+6B3jPEYty3
         QaBOQaqyYzO7n6nMyMSb4rxDqeJuEKTU4QNsizMWB2I7lW9A3KrvWo6/HSjh1iCr0Xy7
         rgv0awkBcLsObMRzOux9q7JGZy1f/wXcaJLXsOKU74WbsnN1+AKsxa5V4MS+1lBopTSw
         xiLm4AAkiouWWK/8MNwAe399m7kGjK16hA+RqAIgbZbIs6u2y8WZJ45mU0Etg0Ha01K5
         hGcjy5Fowu9+zz5lP++RE4nEFolMIRCoISPHbC0tt7RFrTorc0D0xGXi0/h7tpb769l1
         2p+g==
X-Gm-Message-State: AOAM531XOTqsHrSdYzvT8TcDmsMxpItIFYUidpEp02BrxIgN0ptduUil
        VkwSV10wIFrGfEXv000LRtSa8R4gllPoUg==
X-Google-Smtp-Source: ABdhPJzoygKVPYW1ktq3XCmL9tFp2NKHnKpXXq6bk/5ZR835iYI6mPeRe7/g4O07qU4eBXGuR5GBqg==
X-Received: by 2002:a05:6808:200d:: with SMTP id q13mr8459310oiw.24.1624040788465;
        Fri, 18 Jun 2021 11:26:28 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id d10sm1541207oop.3.2021.06.18.11.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:28 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 36/45] completion: zsh: shuffle __gitcomp* functions
Date:   Fri, 18 Jun 2021 13:25:09 -0500
Message-Id: <20210618182518.697912-37-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index bfb5c38a3c..c4510a3180 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -88,11 +88,6 @@ __gitcomp_opts ()
 	compadd -Q -S '' -p "${2-}" -a -- array && _ret=0
 }
 
-__gitcomp_direct ()
-{
-	__gitcomp_nl "$1" "" "" ""
-}
-
 __gitcomp_nl ()
 {
 	emulate -L zsh
@@ -107,6 +102,11 @@ __gitcomp_file ()
 	compadd -f -p "${2-}" -- ${(f)1} && _ret=0
 }
 
+__gitcomp_direct ()
+{
+	__gitcomp_nl "$1" "" "" ""
+}
+
 __gitcomp_file_direct ()
 {
 	__gitcomp_file "$1" ""
-- 
2.32.0

