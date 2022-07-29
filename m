Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCFFC00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 09:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbiG2JGy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 05:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiG2JGv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 05:06:51 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF6FA50065
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:50 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id g12so4115296pfb.3
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 02:06:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkAX6ZBVrA9kmFQxxP23Uvdnv/wtzI0qjdLbfzDFpXM=;
        b=dZ1tqAnYPkHIgayqP7w7J5b2/na6V24ymGf26xYirS35Ma0M0921bT7LZcdUbG+oyQ
         FHK0FnCqvwgF1QAImJGf11/nTxlTH1yMuB41d/vbrzdqHxSyN4XvoZOZsbQZTRLcxOiv
         j6QK1hKPskuAcLjGaAW1S4Hiw+ACywZm7NaEKDSc9rxliTbLcQPFPkm9BWjepNetwfB3
         1yzrIpZCU1HTEfS47QkksjYBCB8R3notcK/a1xj0sT+emfjMGJ2T+btva5jVGo6uPU/l
         qEfEq1YHzR3ZaNLGhNYvvuIFeJRjuo03RWajd2ZfS1+7PyVseEvs6xtffxID21N4EvUH
         gOjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MkAX6ZBVrA9kmFQxxP23Uvdnv/wtzI0qjdLbfzDFpXM=;
        b=foAd3cWXw/oOhfPT6MZi4dA++DEg4RpN9znhs9wA2AmpkKqljyrD0o9yjNWbAJ9J0o
         in3lvc5UxOdWwiCubjW+dm2BlYQe4yvCcgWQiU+V4EBnnkxKRVlR7lSEtZeM8TOO6mBd
         ACSAwqbo7Hb8fJA30MYGPn8GZ3x0NjRlqA8xHSN2wVmdsTa08rSqp0BnExE3TBu7ojxv
         lvLRbZ272R6ZJLWIbG4U5Eq6QvKLBxRM7uZtABSz6cs2drtwiy/++qpsWpnVyi2elrGg
         GQ6mYXgNot+/7uRSd1V6j1aiL33rEpfvzSf9UH8QJYi0QW/4aIuh9PjB9oe3fhOtkmRa
         jfbg==
X-Gm-Message-State: AJIora+sQIgkOENA8kAT4ep9pqjm9Ut9J/CIujvbv/my3SxreyTJzTej
        T1iZuj1doVI28ZWFvmuJwhjp2V3tOsI=
X-Google-Smtp-Source: AGRyM1u7YR35gd7I23fgAoQnNp1L2WsnzvXJfoNfK5IVUNHQ1u3CYwDa9LFwhF2VFZZD/HS/VD4d0A==
X-Received: by 2002:a63:1208:0:b0:411:9b47:f6cc with SMTP id h8-20020a631208000000b004119b47f6ccmr2168280pgl.79.1659085609920;
        Fri, 29 Jul 2022 02:06:49 -0700 (PDT)
Received: from localhost.localdomain ([113.173.163.90])
        by smtp.gmail.com with ESMTPSA id l5-20020a170903120500b0016d62ba5665sm3002669plh.254.2022.07.29.02.06.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 02:06:49 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH] unpack-objects: fix build warning with gcc 4.8.5
Date:   Fri, 29 Jul 2022 16:06:44 +0700
Message-Id: <dfb9273964a6226472316bedf188de63169fb45c.1659084815.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.37.1.560.gdfb9273964
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git_zstream's first field is a struct (z_stream), it must be
initialised with {0}.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---

 Cc: Han Xin <hanxin.hx@alibaba-inc.com>
 Fix for hx/unpack-streaming (merged to next)
 Please feel free to squash into it.

 builtin/unpack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 43789b8ef2..4b16f1592b 100644
--- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -385,7 +385,7 @@ static const void *feed_input_zstream(struct input_stream *in_stream,
 
 static void stream_blob(unsigned long size, unsigned nr)
 {
-	git_zstream zstream = { 0 };
+	git_zstream zstream = { { 0 } };
 	struct input_zstream_data data = { 0 };
 	struct input_stream in_stream = {
 		.read = feed_input_zstream,
-- 
2.37.1.560.gdfb9273964

