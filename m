Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD505C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 00:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhLQA0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 19:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230314AbhLQA0i (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 19:26:38 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7661DC06173E
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:37 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v11so916451wrw.10
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 16:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=avqXGg2kUTd2CJj613icMPUhtOEL60OJ1xRjeOIj7PI=;
        b=Pf3mIYw+lrs/b95TOzriY8XU3FPEZyHA2DLfZ5qm5XAWBC96jhk+m4kt7YdlNEdKJD
         XwBS92HvsoLzvR3d5vqEj4bfslCNq96cFOLnNWl7URiyXED58KHX1zX5ulCpbNvCrlxq
         ldivZDgak6iYjHoxU7fVnHmvmwKHdqUyUvzz4yZudWqhx8i2B9iIpROYx643HHEoITsC
         3sIyx6G8qjlSjmusZLhhH3VF5AF3W32tmZSfOD4L0nrXaCnZu87uLalPrVEON+seeqoM
         Ig9qexCzpg0p4m728ZAAo3ZpWXpFyaH1pNKj8FBMygtRxKxaO0M6Zc7daBzRpz1g+FtI
         I/og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=avqXGg2kUTd2CJj613icMPUhtOEL60OJ1xRjeOIj7PI=;
        b=0Ai0xP2izVbYMIdy0Y9M360ez1fZQkZvdhQgHsedLqR8Iw5HMJyJaheeHrCZ+tF59K
         e45wOYeHAHOXSVUq0AF1to+zVd3Yj2BNtlrKzIBWSHTlg5+JSQC2eRcvaDqxH6F3oGWe
         MGsfDI42nui/iFIeqMY4xhBw2D954Bi+QmRA560O/EYExkUCRz6389cVXz3WjGLSosaB
         3/AlEjlF2K63rcsQd0UEE+wxp/H5TEjHkWJLlVGRDizpg+1DkxgtRYfzzETUG+3UgdJo
         HYJbZcFPlhbXFrm9bwHECzj3BHzQC7PVemp9N+ZBbmA8GuQTWskBw33lH5o7K2Nh1YRB
         ZfNA==
X-Gm-Message-State: AOAM531S7HISbPqR3He7OrKlp6yzqOrx+k6tm/4dqLBRVuuMVCdUQTLN
        ecReLFb003zBGAaCpY9wpasAgoGhj8S9Wg==
X-Google-Smtp-Source: ABdhPJxA4H+TXoJ9o/tO3St1QykikQJWLLA4gAT6G8whSAWPD2YMbbjnfJ8yNVPs5Aot3RbhqbwdbQ==
X-Received: by 2002:a05:6000:144d:: with SMTP id v13mr302062wrx.393.1639700795816;
        Thu, 16 Dec 2021 16:26:35 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm8127349wmq.41.2021.12.16.16.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:26:35 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 05/11] Makefile: guard Perl-only variable assignments
Date:   Fri, 17 Dec 2021 01:26:21 +0100
Message-Id: <patch-05.11-992e325491d-20211217T002023Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1119.g7a3fc8778ee
In-Reply-To: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20211217T002023Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the "ifndef NO_PERL" a few lines earlier to encompass the
"perl_localedir_SQ" variable. We'll only use it under !NO_PERL.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index bd8cb7c463d..780f222face 100644
--- a/Makefile
+++ b/Makefile
@@ -2301,11 +2301,11 @@ git.res: git.rc GIT-VERSION-FILE GIT-PREFIX
 # This makes sure we depend on the NO_PERL setting itself.
 $(SCRIPT_PERL_GEN): GIT-BUILD-OPTIONS
 
+ifndef NO_PERL
 # Used for substitution in Perl modules. Disabled when using RUNTIME_PREFIX
 # since the locale directory is injected.
 perl_localedir_SQ = $(localedir_SQ)
 
-ifndef NO_PERL
 PERL_HEADER_TEMPLATE = perl/header_templates/fixed_prefix.template.pl
 PERL_DEFINES =
 PERL_DEFINES += $(PERL_PATH_SQ)
-- 
2.34.1.1119.g7a3fc8778ee

