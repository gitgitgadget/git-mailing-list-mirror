Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BB8C433EF
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC10161BAA
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 10:20:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236266AbhKQKXg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 05:23:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbhKQKXa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 05:23:30 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4765CC061764
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:31 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id p3-20020a05600c1d8300b003334fab53afso4322135wms.3
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 02:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JFYSW7wsZhC1JEB9FxIu9/K6+I4l2z3dzIA+Y/HjmDo=;
        b=oy7+ZI0lrokYUaaHl1MEt45nn78KjKCy/JaNjO1TUNUCQh2x1OwgyyHkuZi3UVxdzF
         KL08NyPCRJ0ADWW5LUqT4dm87KxFim2tLDaJKn/GqYevAQFD+hw0T7PDZ16MUTIckHTV
         81kG/RGqM4f6nCmPA1DUoAElsk0l2/xwV5B6khQrJV9IK9xLjDXXXHhLEoCTy4HJmVNN
         GJxvOGzh+CLQQIVzYw+eLnZmd6+jgxdQvyBJ2c9+ztYcWSns9uIXEehy6QZb0LGYDbYx
         cTyxA5lODSva5kADTVM/Btg+vtCog6LGSWvgwmlW2NqFxvtWhCSlUoFg201xoNychXGA
         uQRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JFYSW7wsZhC1JEB9FxIu9/K6+I4l2z3dzIA+Y/HjmDo=;
        b=PLWGfAnPRVUtYszF8s3BPHk7I58mCGtTtkJOixQlFwBeN3INFeqW0uJup5Rz9jyhQb
         B09yeaMBnBpV9UzT+O+Wb/x83N35IkvdlkCkBdeHhyqgK/h8bBNMBJR9s5aXFKBbjm9L
         P4XzukEgeHYDa+qcgwCJemlIiMS67NkPF0IPLr1GPTPG/mL7iw8/IHqIWfTky9N8Rckd
         UrWPvFhrKlMsLkykQAUQ9Ge/oeYANbpVzxKB4Eeuk1618l4okTy812+nV1blOK3T2VLx
         LzfjSVyHfRgRtvXHnzIEE5sGeMZKQ1JBXCi5lK6u0FpFGrxek4QJnMlihDt/V+AwHvJf
         bi/A==
X-Gm-Message-State: AOAM532KoZsOR92Z8fFt1yVybpUYvS/OI0Jaur4sLnO3Sjh+KkMlA7w7
        NbhC5Sk6BM3VgciI3+XgzRbhT1GWfgwCMw==
X-Google-Smtp-Source: ABdhPJzS2jfqzxtACBDW0N+xFMfNY0JR7wMV0BvGk0p/4PA762bB03O5JQ8PrGkFSx4bDZmfC73OVw==
X-Received: by 2002:a05:600c:35c8:: with SMTP id r8mr16704571wmq.8.1637144429614;
        Wed, 17 Nov 2021 02:20:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n32sm6456256wms.1.2021.11.17.02.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 02:20:28 -0800 (PST)
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
Subject: [PATCH v4 05/23] Makefile: remove "mv $@ $@+" dance redundant to .DELETE_ON_ERROR
Date:   Wed, 17 Nov 2021 11:20:04 +0100
Message-Id: <patch-v4-05.23-3c987590740-20211117T101807Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.796.g2c87ed6146a
In-Reply-To: <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
References: <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com> <cover-v4-00.23-00000000000-20211117T101807Z-avarab@gmail.com>
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

We have had a hard dependency on .DELETE_ON_ERROR since
7b76d6bf221 (Makefile: add and use the ".DELETE_ON_ERROR" flag,
2021-06-29), so this is a pure cleanup as a follow-up to that
commit. Support for the ".DELETE_ON_ERROR" target itself is much older
than any GNU make version we support, it was added to GNU make in
1994.

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
2.34.0.796.g2c87ed6146a

