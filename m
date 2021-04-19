Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E362C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B07261166
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238299AbhDSKxn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237578AbhDSKxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C84BC061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bcb050000b029010e9316b9d5so17790911wmj.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GINUYoeKtVZX7Ae2Vsi9H9ikU3XWyESu7g709miUeWI=;
        b=tt1FYmrURmdt8gIc+LEQ/TVnx42c8NGGgR2YZJAS1CZT6t52CL82dczc/9ax4DLVSI
         hB4EbgP7UlZKFRK8BSqevzHXq6Tit4KBz6sO3GZbdMiajlCTXjo6s1bV71+TZc7J+jRn
         XWY4G7WNAehk+1xmMaBmRj+LvFmSGpBeGM/9wMno+EqwPCA9OSSPpnkPuIVqvEZt7Z2m
         wVM+3mjdYVRmuJpMfc8qq734iuNQUnk7cQWtFLzWdaQxniAVR3EStrk4ch9aIn97WSxK
         DfvqaLdB5btPhB7jNhRSUz9JU2l7sl/PD81h+XbrHTBTiDniGy3ATjhpaGjrSvslZk/R
         qWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GINUYoeKtVZX7Ae2Vsi9H9ikU3XWyESu7g709miUeWI=;
        b=cwdic5/yFLaXzG4jL7bdfAbZ2+xkMjwkxt3wkeZFFrNj6LwZHastxFxqA72O2+cU8N
         w/09/N2XeK2Dg3ZaqKUH8s+mp58IihgyZVeyqiaurUVP9zMXHlWiVJasJw8NMyWoD8V1
         tY1z+b53bsT3snfbYgEuMezNh/t7WNBpHokjKi04+PeJG3NxU/rFkZxiQ4HZsea7pT9p
         83neDQmR/UuhitiDQdYNJEKEXMd2zC6YHeBNUY/Qkzp5utHJ1gO3PY7wMSgX/lz7XyFx
         W2ra572C949EeVzff2DEO+S97agMDcecELIUh3yvUP+6W+cI/Wx632n9llozqgugGYUh
         L0vg==
X-Gm-Message-State: AOAM530kmVEDKo3TECcEmeZiu0ilT5Bpj29EnLn+TfciU4Nlcw9d87PJ
        CBaylZmvHCZUkFjTuG2TjTcg8VSrtJs=
X-Google-Smtp-Source: ABdhPJzXIaPHR1A5WCNU3VMffT0LS/VFGMIEiXehx/78bXAhFNZDjmgcR4j62kow3ood3k2ONCqS3A==
X-Received: by 2002:a1c:6a01:: with SMTP id f1mr20990695wmc.144.1618829587972;
        Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm21680873wrr.53.2021.04.19.03.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:07 -0700 (PDT)
Message-Id: <70da8f5631d024c2a940a1f0b888fa1c467207a2.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:51 +0000
Subject: [PATCH 06/18] t1301: fix typo in error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index ac947bff9fcf..84bf1970d8bf 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -124,7 +124,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 		: happy
 		;;
 	*)
-		echo Ooops, .git/logs/refs/heads/main is not 0662 [$actual]
+		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
 		false
 		;;
 	esac
-- 
gitgitgadget

