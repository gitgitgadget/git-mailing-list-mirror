Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26010C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E228A206B6
	for <git@archiver.kernel.org>; Thu, 21 May 2020 21:45:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJOWRyyp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgEUVpw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 17:45:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728992AbgEUVpv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 17:45:51 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958BDC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 14:45:51 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id h16so7787666eds.5
        for <git@vger.kernel.org>; Thu, 21 May 2020 14:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXQ9ssUIMjbjj7neKe/DRt3jDWZmvXhb1IpXEreUYSs=;
        b=nJOWRyypGGFheNrDWvmJ3jsFdix31G8ut4I1P9izbJ9oz+chkQVeHdZx3ruWY1akX1
         Siex6Swk5oLCJKo5uup6dNPD0bHzwcR3z1Re6GijqZYOe67g05Texq6u/9TdXUFyzcqJ
         aag9I4k+F1MgWdTf2vzmZyfJ2n0rvKG+WzlE+K6PRyPiwarXMbKCWnpui5kxCPsCWHpj
         mPb9BzIB2c86eD6O4eU878y+XzDEpueT9zJ9519qknl+7aEu0LczjanGYx0VXhsKtgKP
         JSUnOqpxlFERozfwpJtd9aLHtwUm5bpWeScg6ZrwwguHk4fNK+4PatTlxLJKLvnfiJx+
         5XSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IXQ9ssUIMjbjj7neKe/DRt3jDWZmvXhb1IpXEreUYSs=;
        b=nsU4UVVefG5BtEVI+VpFs9JMDh5aCnD6Uk1JeX07ZsZ2L0zsIMkBt3LBFt9juS1jhZ
         YGsd1ORfJ42RJMS4gpjXDQCqbl5AUVqqWhNjVYJbpsx9KvUczHeze0FT2Anclb9MUJXA
         Bx0ND/iCGo6rof56lqz3+3xM5/daGCbLT3OGlXsFmE69MpJDdZmiQ99QZd3Z0pz/u+Px
         gcshrbMAj1m/IqNdSfvfU7C9zrDK1C6wCyU4vH3m6BJ2XizyRyxvOhqIBejhiuqX/y7t
         l1gIGTTW9AoJ2oDVSfvxeQXnhH2yI7UOF/11TLMXlIO4U3E4ZhTRkuMDXNzIGv31OzA6
         0S1Q==
X-Gm-Message-State: AOAM533egNvrPEB1L42hwOK94UmC8TzTGnt62DFO29IXY9kYn8M3HXNY
        n4FZ60iWTt0cIj3IhDfKkmmEWuK3
X-Google-Smtp-Source: ABdhPJyXQZcwJUdLBWOVRMuntZddqDi/HVrb5NV4aeJnQ/qrrVmOi5WdUVHj9oTo2Y/U8V72PehqKQ==
X-Received: by 2002:a05:6402:1447:: with SMTP id d7mr653163edx.367.1590097550029;
        Thu, 21 May 2020 14:45:50 -0700 (PDT)
Received: from localhost.localdomain ([2a02:a03f:b7f9:7600:3983:c65d:57b:4e8d])
        by smtp.gmail.com with ESMTPSA id j17sm5896745ejs.108.2020.05.21.14.45.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2020 14:45:49 -0700 (PDT)
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] sparse: allow '{ 0 }' to be used without warnings
Date:   Thu, 21 May 2020 23:45:44 +0200
Message-Id: <20200521214544.8784-1-luc.vanoostenryck@gmail.com>
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

Legitimaly, it's desirable to be able to use '{ 0 }' as an idom
without these warnings [1,2].

An option have now been added to Sparse to turn off such warnings.
So, add this option to the SPARSE_FLAGS variable.

[1] https://lore.kernel.org/r/e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com
[2] https://lore.kernel.org/r/xmqqd07xem9l.fsf@gitster.c.googlers.com

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
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

