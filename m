Return-Path: <SRS0=tbmj=EA=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 040A4C56201
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD7F620936
	for <git@archiver.kernel.org>; Sun, 25 Oct 2020 03:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="enq7MZyH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1766856AbgJYDOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 24 Oct 2020 23:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1766837AbgJYDOH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Oct 2020 23:14:07 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF0C0613D2
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:07 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id n15so5085550otl.8
        for <git@vger.kernel.org>; Sat, 24 Oct 2020 20:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o5rowoouxDn0zguYYXN+F1arqo5oVWDt+w2FmFsvk0Y=;
        b=enq7MZyHcRb9IW0RmHTYmviXfJXbILelL2qJHSxOc9Zk7cMtnfd8tUqTR7PbxYN/06
         hxbM9yu/ZGHcKte8hj/LNXztZbw2NcBaJejOgWnz1PFYw4uSzCaG/vCZnsGjpPQSwW18
         6/34z9fcuaO4lFoR7NpORbJIl1peu3Hy3sB8E77z3Kt1Q6F8d+x9M7BULGY1rwXMs56R
         Y5YkJt2t0qlbKkbvcqFnmL6/jiwvncJEleyITqx0cRcpMUVsRivgL2niqqVjs+xslcmT
         zbCQN4xzHeJVbCdqPHiW9Jz/AiiOm2POJFItfS4Xw0w900u+Fh79/NCLxF2E0s3xU8+V
         k3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o5rowoouxDn0zguYYXN+F1arqo5oVWDt+w2FmFsvk0Y=;
        b=Do0S6bVnRMlJMVTJ6OGXuE0HHe+J/iQ+TlNoVBxElSU6dE8Nxa/spqTm/qbifdVPnW
         dHGd8Tsmbdj1iC+ocRN8mXuOI1idoUd5uLpcgMyWEaLhrPKSHeFBnWj9sbkfy9JOPCIZ
         gYyc00v7GIe700MbF0omfUPWI/p65i1STK3jsXBrA4cdMVlRtFD53uxRx4AR4j4s42mz
         duOYHNW9/NbaBz/JLTtU99kNkh28S/2U+mNpqnznbTR6QSQS9Tb5oe7ikwlGAlXso91F
         v4prXOC3sitqWhWhB8WfzkxRvL1AyjpaPyQvWfb13merStGL2E8mxu8dK8z18cnPNfto
         +1bA==
X-Gm-Message-State: AOAM533uk4oGOTbYo6/MhcRS4BZUJ3Jt6mQWOOmZH6BfGN/Zzvalbc1d
        LPLmARze+BBAU+tPYXlLXsSGjPzfJpwMNw==
X-Google-Smtp-Source: ABdhPJx0KH75jFyl/keMV6oKkvtQ+/JjcCuiuFB3IBP039dwktGcTMKyV1PdEUSx4vi+DaucNeat4w==
X-Received: by 2002:a9d:7419:: with SMTP id n25mr8144170otk.183.1603595646820;
        Sat, 24 Oct 2020 20:14:06 -0700 (PDT)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id b16sm1655544oti.4.2020.10.24.20.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2020 20:14:06 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/29] completion: zsh: fix splitting of words
Date:   Sat, 24 Oct 2020 22:13:28 -0500
Message-Id: <20201025031343.346913-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201025031343.346913-1-felipe.contreras@gmail.com>
References: <20201025031343.346913-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Files don't need to be split by '=:', words do.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.zsh | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/contrib/completion/git-completion.zsh b/contrib/completion/git-completion.zsh
index 13c6bd5c12..088bf7f759 100644
--- a/contrib/completion/git-completion.zsh
+++ b/contrib/completion/git-completion.zsh
@@ -117,6 +117,7 @@ __gitcomp_nl_append ()
 	emulate -L zsh
 
 	local IFS=$'\n'
+	compset -P '*[=:]'
 	compadd -Q -S "${4- }" -p "${2-}" -- ${=1} && _ret=0
 }
 
@@ -125,7 +126,6 @@ __gitcomp_file_direct ()
 	emulate -L zsh
 
 	local IFS=$'\n'
-	compset -P '*[=:]'
 	compadd -f -- ${=1} && _ret=0
 }
 
@@ -134,7 +134,6 @@ __gitcomp_file ()
 	emulate -L zsh
 
 	local IFS=$'\n'
-	compset -P '*[=:]'
 	compadd -p "${2-}" -f -- ${=1} && _ret=0
 }
 
-- 
2.29.0

