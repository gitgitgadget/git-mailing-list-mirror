Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661AC433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BBE861BF8
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:21:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhKQKYK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236242AbhKQKXm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:42 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C07C061208
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:43 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 133so1722585wme.0
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5t8LCQhZGGsnbE0uIsoVupFqG8QfInC6IhXzkOL4jts=;
        b=EQUc0tvG5yDoPJR45uppV9iSgDsHmqFw/if8pCkXv6QiNBfynoyS0p1odnzh2IAnQ5
         pq8IKI9C3Q3NDpwTlLHP8GwXTQsrA1LOBpHxchpivxFurmUOjKxMDVOpGLACXhh3v9uK
         J7++Ut3EsvlNgSVic9Ui6ZdRo78J4QTVY0xUKGmEwym01zAb8pUo/8gKK6lb8JgdXTc3
         EbQCsfahUuy+VwWWXcLJl7gWts2Pr7GMJwQZA1wNqPlkqmF1/SiHcJj1PGPgYj+1f5wn
         s3/lfR5awXNXD4tg92AZ2lBsCDZUPJC20jQlr4iSGzVwkoSyDu4/Ke7qvrAyWynPTdvu
         6h4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5t8LCQhZGGsnbE0uIsoVupFqG8QfInC6IhXzkOL4jts=;
        b=lGZdrA0ph/YoRZIqIlOjSpYa57yuu2IY0CeMKHkCIyszWaA9r2v+t5DdqyM4JCX/7R
         DRPXyxmf0dXWxF7G9oKEvrYD5PSlCt6WK4dvJl5T5UnY9ITzXi+ImK6s0/D127Iuff19
         gNMINxkQDcN2kugDUIRpGkpRrwA1VkPjzSm90+xbsPHeSdV+TUB5e6pz76jLr5uRWk3m
         ++4fwnEJ6o1MTowcmWTNwM5+luG+Z9ToEWwVLIpjqzuidK+844HIpAs8ZCTEzyUmDLGA
         UwIRXsC7Ypo7AcpF/dkzinPiiLWN7CvvnRM2L/P81Mc89qfZiOhCf7cJ6aZrf9SVC/x9
         995A==
X-Gm-Message-State: AOAM530i1laRn/70/K9lw4mqwAjE4QBjCCHix9HYxy71/5XrmQK70R75
        YsUCHJiRFN5i7b0XMXC7sE1GXKPZKprumg==
X-Google-Smtp-Source: ABdhPJwXK4QCmXwxJOdG9zL960Nngzsx6FubzmQSV7DnzXxYjCL5Aia2rpCQaWCRAhv0YOThwNr0IQ==
X-Received: by 2002:a1c:23cb:: with SMTP id j194mr78946990wmj.13.1637144441900;
        Wed, 17 Nov 2021 02:20:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/23] Makefile: correct the dependency graph of hook-list.h
Date:   Wed, 17 Nov 2021 11:20:18 +0100
Message-Id: <patch-v4-19.23-2710f8af6cd-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix an issue in my cfe853e66be (hook-list.h: add a generated list of
hooks, like config-list.h, 2021-09-26), the builtin/help.c was
inadvertently made to depend on hook-list.h, but it's used by
builtin/bugreport.c.

The hook.c also does not depend on hook-list.h. It did in an earlier
version of the greater series cfe853e66be was extracted from, but not
anymore. We might end up needing that line again, but let's remove it
for now.

Reported-by: Mike Hommey <mh@glandium.org>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 0a3f292bf82..a9fa9461613 100644
--- a/Makefile
+++ b/Makefile
@@ -2161,9 +2161,9 @@ git$X: git.o GIT-LDFLAGS $(BUILTIN_OBJS) $(GITLIBS)
 		$(filter %.o,$^) $(LIBS)
 
 help.sp help.s help.o: command-list.h
-hook.sp hook.s hook.o: hook-list.h
+builtin/bugreport.sp builtin/bugreport.s builtin/bugreport.o: hook-list.h
 
-builtin/help.sp builtin/help.s builtin/help.o: config-list.h hook-list.h GIT-PREFIX
+builtin/help.sp builtin/help.s builtin/help.o: config-list.h GIT-PREFIX
 builtin/help.sp builtin/help.s builtin/help.o: EXTRA_CPPFLAGS = \
 	'-DGIT_HTML_PATH="$(htmldir_relative_SQ)"' \
 	'-DGIT_MAN_PATH="$(mandir_relative_SQ)"' \
-- 
2.34.0.796.g2c87ed6146a

