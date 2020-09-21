Return-Path: <SRS0=LBHq=C6=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4673C43463
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5B44216C4
	for <git@archiver.kernel.org>; Mon, 21 Sep 2020 10:40:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGP1p/oK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726751AbgIUKkU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Sep 2020 06:40:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgIUKkT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Sep 2020 06:40:19 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45891C0613D0
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:19 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so12077232wmb.4
        for <git@vger.kernel.org>; Mon, 21 Sep 2020 03:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pAPnWB8cMWB9fUMZv/RX0vuxIR78pyzyC/7m4DfB+Gk=;
        b=pGP1p/oK223e/v6nGEVmGGfYj3JEnuwVEhwdodIIdlTxDNTl+Xk0b5000YYwTtFEks
         2oE2Ie6jTju8zNgwSpvsi1Czm+W/tbUpih5mnW2U25HL4CAuemLE7pHvJ2Xnepy62/wq
         ZdNL8Lt+kM+PE8Oa51L3ZKt7NtOJpDyr2hExdMT4DEOrDeWQA4UaqFnvEohXMS9dTFP2
         E8uBhmgg9QYbWmIlSaWutaf3hiIdVpWfwr2bpwIaIdY/xKR+4dSq7m5exvOqzTHNsEnq
         bt0Vg6B1KUGBFSFWOGxVcwPKiVzrm9fzE3Su4cEezgHakIqv72/ygjYRG20VW/ljQfSN
         4i6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pAPnWB8cMWB9fUMZv/RX0vuxIR78pyzyC/7m4DfB+Gk=;
        b=lzX6S4HP9+9Pxy2XWlRFEZjhflu2LbX8ErmISv4WyX5bm71K5U++hl1J4nyrVLHx0t
         oFcERLnsgkJoVLxakrZWy+lxg2/fE9kpgAYOeRpw8lllAztOrYcgNFNSaWxEe61DZ440
         HxFfi1MfosPO4QuXhxMkMMK7lI2ruLwWrBDVpOcqS/ZS/eZniI2cibD4Nm8dK3RvAYKm
         3V3V4hXBlEc4b3X5pnftQfgM+ZamtdnHGO9XOqWeJtKGGjOJQDGc4UTitE3L3/+gfzZL
         wSH5CX6+G3H6n6KBhT7R5AoRLelNeh//abgbfgu14SVnJC67aCrN76dJLO+Nlz6dit8d
         RqEQ==
X-Gm-Message-State: AOAM531XiuobriM43nFmN1fRDv4ziLtExIk+hPU/VYACh8vA4NE57HOZ
        pkOTINd9GTA7exll1OQ5CYNpQ9ffDPw//g==
X-Google-Smtp-Source: ABdhPJx7mbm+joFZsWSwUU8CHeJK4+Fs+LH2UhuylpnVQzVZyDN888AGr7LocK6kDSrEHTog7MOtOw==
X-Received: by 2002:a1c:544c:: with SMTP id p12mr8337610wmi.170.1600684817782;
        Mon, 21 Sep 2020 03:40:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 9sm18647833wmf.7.2020.09.21.03.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 03:40:17 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Antoine=20Beaupr=C3=A9?= <anarcat@debian.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, imon Legner <Simon.Legner@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 03/18] remote-mediawiki doc: don't hardcode Debian PHP versions
Date:   Mon, 21 Sep 2020 12:39:45 +0200
Message-Id: <20200921104000.2304-4-avarab@gmail.com>
X-Mailer: git-send-email 2.28.0.297.g1956fa8f8d
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded version 5 PHP versions to the version-agnostic
packages. Currently Debian stable's version is 7.3, and there's a
php7.3, php7.3-cli etc. package available (but no php5-*).

The corresponding version-less package is a dependency package which
depends on whatever the current stable version is. By not hardcoding
the version these instructions won't be out of date when the next
Debian/Ubuntu release happens.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 contrib/mw-to-git/t/README | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/mw-to-git/t/README b/contrib/mw-to-git/t/README
index 2ee34be7e4..72c4889db7 100644
--- a/contrib/mw-to-git/t/README
+++ b/contrib/mw-to-git/t/README
@@ -14,11 +14,11 @@ install the following packages (Debian/Ubuntu names, may need to be
 adapted for another distribution):
 
 * lighttpd
-* php5
-* php5-cgi
-* php5-cli
-* php5-curl
-* php5-sqlite
+* php
+* php-cgi
+* php-cli
+* php-curl
+* php-sqlite
 
 Principles and Technical Choices
 --------------------------------
-- 
2.28.0.297.g1956fa8f8d

