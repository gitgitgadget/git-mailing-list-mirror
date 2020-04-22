Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E80EAC55185
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A228E2076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 15:34:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jrtc27.com header.i=@jrtc27.com header.b="TRQgWayW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgDVPeF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 11:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726240AbgDVPeF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 11:34:05 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8CCC03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:34:04 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id j1so2947983wrt.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 08:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrtc27.com; s=gmail.jrtc27.user;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+yrM54my9Gzqo53a+My8itzALTVnOcj6mrvqylbOh0=;
        b=TRQgWayW6lwB3clJtMdsFeQgIDtKJCjMiwVXQg5r5+K0uAVN87Tj4OXzQOZfzniVil
         oup6yi5F0WTg0FXNRlJ7X6l1vnlXCCcRwfJzYfGHkiWGurWs17VKWg7ejpxmevPTu952
         X2IdCZ4GUJBU9z5dIfPm0R9qf3dvPkDjH7DJpJdF57wfJ6kUm63x0iiQWCcfaB+4u/dj
         TS13hoosQroP4tXvalspMpR8xXzYvJQ6JdgJ95WgCNiZvuBs2rJGMr9HqC6Df57d0qbb
         HQQxtIlkVwKtfw6A1SywVgyyxmZPJ/wHhsJ2qQ1UVMEuH0h0eJ8tr+7A7Gy7JHaxeZar
         l3DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=L+yrM54my9Gzqo53a+My8itzALTVnOcj6mrvqylbOh0=;
        b=B8Cpqjl5q8W2fLu47NUFK++aIl17JxU9CJDt2WEsUPxwr7VjXbikxLJZG6VXGOCLmE
         AiuLUGLeenWHdkPb+zpEiK7BogMHRnAhMpSrG0v9TuTsunvftCtq3SvQaXOvMTwbCSNC
         eGCpoLD1Dd5du4c8GAsh+1JSb0ho631UEzZ2WHns53bz6/M4sIImEYFPoIfgvmERB498
         +aijC+t6INrKcPUZ2Yc7psVz6TYbEojdSOzy8jChAoeXdKLRoGNYLugk2dAgE/Guc/Kw
         a/1Y0RGCksyieVvhTFBxp03XGz3sn38/q0/+VKEQUV8M6TKU25H+capTjYuttGisTfY7
         Wo2g==
X-Gm-Message-State: AGi0PuYi2vV9Zzt+cwr9vNROKztjCXkwlu9FeLcFNiHzITw+ea8mIlxu
        SyAKzSepi0U6xM0zIocbHcLgMDvnWYeMXA==
X-Google-Smtp-Source: APiQypIJVqQuNdrS2prSNPGlI57NNneCjlVBv1mjLdV82OPyZKdqHF/GIDoG6ofdFyv4vPaSX1iqGA==
X-Received: by 2002:adf:fcc6:: with SMTP id f6mr27474740wrs.388.1587569643714;
        Wed, 22 Apr 2020 08:34:03 -0700 (PDT)
Received: from Jessicas-MacBook.local (trinity-students-nat.trin.cam.ac.uk. [131.111.193.104])
        by smtp.gmail.com with ESMTPSA id o18sm8761522wrp.23.2020.04.22.08.34.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 22 Apr 2020 08:34:03 -0700 (PDT)
Received: by Jessicas-MacBook.local (Postfix, from userid 501)
        id 5C4CB206DCA3DA; Wed, 22 Apr 2020 16:34:02 +0100 (BST)
From:   Jessica Clarke <jrtc27@jrtc27.com>
To:     git@vger.kernel.org
Cc:     Jessica Clarke <jrtc27@jrtc27.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] config.mak.uname: Define FREAD_READS_DIRECTORIES for GNU/Hurd
Date:   Wed, 22 Apr 2020 16:33:47 +0100
Message-Id: <20200422153347.40018-1-jrtc27@jrtc27.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GNU/Hurd is another platform that behaves like this. Set it to
UnfortunatelyYes so that config directory files are correctly processed.
This fixes the corresponding 'proper error on directory "files"' test in
t1308-config-set.sh.

Thanks-to: Jeff King <peff@peff.net>
Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index 0ab8e00938..3e526f6b9f 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -308,6 +308,7 @@ ifeq ($(uname_S),GNU)
 	NO_STRLCPY = YesPlease
 	HAVE_PATHS_H = YesPlease
 	LIBC_CONTAINS_LIBINTL = YesPlease
+	FREAD_READS_DIRECTORIES = UnfortunatelyYes
 endif
 ifeq ($(uname_S),IRIX)
 	NO_SETENV = YesPlease
-- 
2.20.1

