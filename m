Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF098C433FE
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B87DE60F36
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 21:49:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235940AbhKLVwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhKLVwI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 16:52:08 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C85C061208
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:12 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id v127so8871033wme.5
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vvNJLKWcPa+hQizDp/euny7oemWnhAu2fSERRc9yCXw=;
        b=j9pw5giGhvG/Mt18p7hqxm9WLSl4Q+k7y83078hLyEKpEHU87wGs4lpojHqeuiO4Xh
         Qnnvf8+HcFp7Ble+G485f6q5taXf2D0yaDput1O4Gy9S+mnwjhW40LMwLJA0HkxndKIM
         OcdPKb3zJsrK5I75qIJo0uMNyWuujNRPXg2Mkyrz+o3MPs6K7mi9xuX+3cMsEqv1LAj+
         V2pkGQcrOfkKIFawW2vRE9manW4u/IG2dRkvlknzWuplDjw0VY+z+X4iON1VzWIfPl0p
         n4LW9XLMEDvZxTUpOlXXurLqlhcLir4f7kju2A5wAzRMALwNk/sY+jRNLgo2vzrYha3m
         daZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vvNJLKWcPa+hQizDp/euny7oemWnhAu2fSERRc9yCXw=;
        b=y8jHLoL/s5Nzf7/6x5qrSP90EfKg14OD0Y3OzRcQkA60TZka5cAgnRyBc6ENiGs+pR
         I/B/NhVN3zoY2D96/53SVra4ShU0UR5yXkPkBCjR6XmWO5ahFaLGAyfNXpD8Da8aJcwl
         sag8SwzlLpKroeyyzza038EW8UC3vdKe2oU/BDNITVAKJ4yvVtfKVWm4T5LWZejo8vSY
         LVL4Dzn6vYvfx8LwCh79cvDrwgyQ4NokArdRUQeBa3RAnG1va2SnZah5kP59pLz218Fo
         qLFAMMVVTahVA5WyL4ZZPlzY+iLkbZWdbiswG6KAHaH6D3iP/DQTlDGRwByp5KgKo2y1
         C69g==
X-Gm-Message-State: AOAM532722NXPy4UqsjL/l2zeVtNPRmjUmUvY7dyCGUJGU3507pdZlQ7
        xlJDqPznb9kqxdKAbVmDwk8ZRfOugpMYHQ==
X-Google-Smtp-Source: ABdhPJw19+LYwHSJfv4HPfsApcn1+GnkaCZdryu/uK2vQKdMmdAb2UgPUJ59F79omtIgALFZ0usY/w==
X-Received: by 2002:a1c:5409:: with SMTP id i9mr19989303wmb.146.1636753751116;
        Fri, 12 Nov 2021 13:49:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h27sm14117189wmc.43.2021.11.12.13.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 13:49:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/18] Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
Date:   Fri, 12 Nov 2021 22:48:49 +0100
Message-Id: <patch-v2-05.18-04dbc1d2809-20211112T214150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20211106T205717Z-avarab@gmail.com> <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29) we don't need to guard the clobbering of $@ with this sort
of "mv $@+ $@" pattern in these cases where we're merely generating a
file that'll be used as a dependency for other files, as in this case
for GIT-PERL-HEADER.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a71fba15e30..284725099c9 100644
--- a/Makefile
+++ b/Makefile
@@ -2349,8 +2349,7 @@ GIT-PERL-HEADER: $(PERL_HEADER_TEMPLATE) GIT-PERL-DEFINES Makefile
 	    -e 's=@@PERLLIBDIR_REL@@=$(perllibdir_relative_SQ)=g' \
 	    -e 's=@@GITEXECDIR_REL@@=$(gitexecdir_relative_SQ)=g' \
 	    -e 's=@@LOCALEDIR_REL@@=$(localedir_relative_SQ)=g' \
-	    $< >$@+ && \
-	mv $@+ $@
+	    $< >$@
 
 .PHONY: perllibdir
 perllibdir:
-- 
2.34.0.rc2.795.g926201d1cc8

