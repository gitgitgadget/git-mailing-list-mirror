Return-Path: <SRS0=iK8c=5M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E745C2D0EC
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6809E206E6
	for <git@archiver.kernel.org>; Fri, 27 Mar 2020 00:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SpTq9zwE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbgC0AtK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 20:49:10 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38834 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgC0AtJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 20:49:09 -0400
Received: by mail-wr1-f68.google.com with SMTP id s1so9468009wrv.5
        for <git@vger.kernel.org>; Thu, 26 Mar 2020 17:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Qyv7zF5hcZg/DzLYC2a8W4SsgN0Hb1faAJoIvnhgBzs=;
        b=SpTq9zwENXZGjfUpms5YF/SNKRsfGAsk7WNCWNnlL6QcneFwadPViPdzh9IecOOH0C
         zPEIAxUJ9BTWQoIxRuO1i9teaBh49Vc3zm1/U3fUNCXzRZ6DhY1zDh2ayL1fBGE3184X
         XgBnz53ylut63dO5F+Fd/bbsjy/CArGa4E7fMOeaLjn5tGByCBesnyImogZqEa4eIChB
         vxlOZABc2NQqNC0elIMrrmrObwt/DI58u7Rf+PU9PqfZinzWmykAy5KvKrAjF1CdD6Ay
         /AAFlIZY45XxeMEOBMsyLhzgjqLc9+mGMyR2JHM+E0HyKTGxwTHkgU6BSfl0tCGyjnU/
         IsPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Qyv7zF5hcZg/DzLYC2a8W4SsgN0Hb1faAJoIvnhgBzs=;
        b=HldndtXIYcKn3wgx3llLGO7EBn1ajmoPHLKvqolCpS89jlDQIWIc/2tbXyyEQJGxnJ
         Pd+gtS0f+/+fJ2CFptiKJCQDLiRklTfqbNk+TQQXRz5ciPS6RkQEE3rT+FwQWXSYh3IN
         WdaOivdSQOWfgLuGmOPUoSLwt5BWsPlmO8XHpEAjnZKb30aNTJiWkM7Pl3oWx1jh53uZ
         dQ/MmPTvmuH1qYELPQTPaCaRBBuTvrRMc+slY6798RRKVKdcjLyIsw9Rx3zA4iGTwpQL
         rfqgLPa8+PyAB/oAy+tGb3KkizdsFplFj3UMtBWEwpQfF2kxyNXLvJ4B3M7ABFFHoSq8
         9hHA==
X-Gm-Message-State: ANhLgQ3z2yDqyqiBb5pbfeSstC7tTUKQLWjq7TertavH+u3l+radqwAf
        V4GRNRYs6yNumswEvRIoJHYODVy4
X-Google-Smtp-Source: ADFU+vs+iwY9Jp4CX5EeRLPOyX8D0Fihx98QqQ2HpVXoXbi+b0QvnQ/ckWF+n1TB221jrasrmZFTnw==
X-Received: by 2002:adf:ea84:: with SMTP id s4mr12835399wrm.392.1585270147109;
        Thu, 26 Mar 2020 17:49:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b11sm5890811wrq.26.2020.03.26.17.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 17:49:06 -0700 (PDT)
Message-Id: <da4b74093cd4eb0d91f4472d61fd5e992b8e4d12.1585270142.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
References: <pull.726.v2.git.git.1584813609.gitgitgadget@gmail.com>
        <pull.726.v3.git.git.1585270142.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 27 Mar 2020 00:48:48 +0000
Subject: [PATCH v3 05/18] t1091: make some tests a little more defensive
 against failures
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t1091-sparse-checkout-builtin.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 44a91205d60..8607a8e6d1a 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -278,6 +278,7 @@ test_expect_success 'cone mode: add parent path' '
 '
 
 test_expect_success 'revert to old sparse-checkout on bad update' '
+	test_when_finished git -C repo sparse-checkout disable &&
 	test_when_finished git -C repo reset --hard &&
 	git -C repo sparse-checkout set deep &&
 	echo update >repo/deep/deeper2/a &&
@@ -328,6 +329,7 @@ test_expect_success 'sparse-checkout (init|set|disable) fails with dirty status'
 '
 
 test_expect_success 'cone mode: set with core.ignoreCase=true' '
+	rm repo/.git/info/sparse-checkout &&
 	git -C repo sparse-checkout init --cone &&
 	git -C repo -c core.ignoreCase=true sparse-checkout set folder1 &&
 	cat >expect <<-\EOF &&
-- 
gitgitgadget

