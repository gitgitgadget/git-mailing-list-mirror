Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3024C4320E
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBDF36108B
	for <git@archiver.kernel.org>; Wed, 18 Aug 2021 05:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237394AbhHRFUP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Aug 2021 01:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236730AbhHRFUO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Aug 2021 01:20:14 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0CEC061764
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:40 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id o2so1037388pgr.9
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 22:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=amdIalIdYN2xmf/MOneDUOPGD8FMZbN13itkte7JtH8=;
        b=mHdTJPDRvGK36lW2OltU4yrmtrm7JjRY1IyHTiXXvOD6ulhZizyrCHYfsBqNc8BNuf
         nlFlF1EJK9pgeuBOg8unBLsOgVgq0DJNVqOERuyjCqNw4rPYCiioAjRDJERYWq8NX+YP
         SNRWOH6nsE5GChKLbrFVcmDUih6pzqd+Szjril/BRoX7Xj4OjxPHCONM5gjTPt+k979y
         Efy49xqldZFwguFJ/CeV3fPFrnLO7dgEmeHmH0w/mkLqRNBsAEzG4DFrfwytcKVsI9Ip
         VBf7dCyUHSkoeCXA7gzDvNoKvFJRK1NBSYiK6yDfqresqu412LID2iXGJn3KtQEUF4LP
         +smA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=amdIalIdYN2xmf/MOneDUOPGD8FMZbN13itkte7JtH8=;
        b=g6NTGYRk+DJ03o9mwdp8LG8Ft48e3YCY0aCPaL7cHEFoYBU/VD+eRx5hROtNn/i/tI
         8QiedfKDYDKO2H+gp3awvrYRCTgPKnK++r5qlKPrRWEF4gBmQjw2td5/uKHPtkFpFo0I
         5DVBFGA0uV+QDUImmHUmf2G977BcNZJOlaHo6dY4VwP3i2RL/8bmFy/PKs41XH8jdXbw
         mPbvMmI2kiRB3QqtluNwJOpBMIVuBH+YJZooEQS6c/pGskqzg0urVBN6vR7npp7Q6H65
         BIpkkNK/pUZfVig3JfgTli8RnzG3kV69ahvGxunhGEgk+glVkdrbuseMY3GEXNm1ZPUX
         r0xQ==
X-Gm-Message-State: AOAM533HsvY7KdSJILcd1WmWsWyztwywrLCkig42SC3sHPvN25CrRtFY
        I7uI5vIQ1jLOmnpL52EMrpApN1aXcTM=
X-Google-Smtp-Source: ABdhPJw3seJB2hZ3UORJSI6V79H+nkmSWit6EHUVdGT1XQiqKLSN7lbxwoqKo4q7UrvW9W77VqzV4A==
X-Received: by 2002:a05:6a00:1989:b0:3e2:a387:e1d9 with SMTP id d9-20020a056a00198900b003e2a387e1d9mr5358589pfl.64.1629263979890;
        Tue, 17 Aug 2021 22:19:39 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63ed:4478:964c:2b9b:388e:4b0])
        by smtp.gmail.com with ESMTPSA id g202sm4385410pfb.125.2021.08.17.22.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 22:19:39 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH v2 2/2] t6300: check for cat-file exit status code
Date:   Wed, 18 Aug 2021 12:19:27 +0700
Message-Id: <68ee769121195eb61bb51fd6a27d22a8dddb13b6.1629263759.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1
In-Reply-To: <cover.1629263759.git.congdanhqx@gmail.com>
References: <bcbde2e7364865ac16702447b863b8a725670428.1629200841.git.congdanhqx@gmail.com> <cover.1629263759.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In test_atom(), we're piping the output of cat-file to tail(1),
thus, losing its exit status.

Let's use a temporary file to preserve git exit status code.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6300-for-each-ref.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
index 93126341b3..cc0f5b6627 100755
--- a/t/t6300-for-each-ref.sh
+++ b/t/t6300-for-each-ref.sh
@@ -66,7 +66,9 @@ test_atom() {
 			case $type in
 			tag)
 				# We cannot use $3 as it expects sanitize_pgp to run
-				expect=$(git cat-file tag $ref | tail -n +6 | wc -c) ;;
+				git cat-file tag $ref >out &&
+				expect=$(tail -n +6 <out | wc -c) &&
+				rm -f out ;;
 			tree | blob)
 				expect="" ;;
 			commit)
-- 
2.33.0.rc1

