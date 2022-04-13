Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13F90C433FE
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238611AbiDMTzV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 15:55:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238552AbiDMTzO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:55:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8527938D
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:21 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so1830335wms.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRa04VMpehokdK0nTkHU8KFYBRhmU7wVmus9ul3lobQ=;
        b=IqgRIc6GvOVOVpvnwMU7231UvNioKoZ26N7cKcZzyYjPTD8yQ88XwMPH0SfbMpz4N8
         mvLNWHZTFFgSqkzSvw8501mGnH+uLxuBFsHlAIvtsM35toTj21mQucAr/kQcfispyhp2
         KBKELOjlfn87Vcey8CnAwHWxt8LecK4elFWBw4CQF+yw2sPH2cQAVvvhxe0co9fuig75
         9WCTZdjsWn5y1zf5sP8AvYTj6ZffdWHhzLxPXpLG6x9E86cPxioH8LcQiVThZIAWmfTa
         RHyZbaDyW8HMzGaveMNOMNM0cNtRd49W6xTf5eu6RhHYzX1zp8uCeiyQMW5PGKg6ZFrv
         eQsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRa04VMpehokdK0nTkHU8KFYBRhmU7wVmus9ul3lobQ=;
        b=b8AULyTJOaiNOpVV6UsrRj+Pb1hJVKN2h5pC09DxPaDBmb1yQ+6Y1Y09lJtbY09eZ3
         jrNHh/emEdAOfIlRgbnYt/76zZYVPof9n8R74aUNY6qtJZ47yXFY2bOk44zTAChe+0gB
         sqC3rqWLY9XnI0qRVakCoLkTOSZ4PJZ04qdOs5YK3k51CO94Vn7z14j/soIlI07FzfXN
         O9OPzIOapeXU3wMMlF5Y7kIHB0GcIeqzPJkl5TZ0VPySGvRU2a0t2rJs6SZ8rkkb3T66
         VzlVGJ7jUhzvrYGg2WTquKbdkVbD6L0ZgVS/GWLTvll02S6mA492C7e1CWThyKtdvJvI
         b3BQ==
X-Gm-Message-State: AOAM53333qrXnF7SKqNolO6q+7eHQcDV9rBe4Dqj/lC64/Zay5aE+jru
        eHb+V1lyk2ewg7E5zDsTNxZvnycBwZLJzw==
X-Google-Smtp-Source: ABdhPJwajpE7vVAwvRWeOE/ETllQLo1xfuYpWiKH2sYLpE9HOymnhh7eeuL4wj++fVQ6qpxfnPibvw==
X-Received: by 2002:a1c:f607:0:b0:381:1db:d767 with SMTP id w7-20020a1cf607000000b0038101dbd767mr252853wmc.165.1649879539523;
        Wed, 13 Apr 2022 12:52:19 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k20-20020a05600c1c9400b0038ecd1ccc17sm3432484wms.35.2022.04.13.12.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:52:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 26/29] CI: set SANITIZE=leak in MAKEFLAGS directly
Date:   Wed, 13 Apr 2022 21:51:39 +0200
Message-Id: <patch-v3-26.29-83138dacd3e-20220413T194847Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As in the preceding commit's change to do likewise for CC, let's not
set SANITIZE in the environment. When I added the "linux-leaks" job in
in 956d2e4639b (tests: add a test mode for SANITIZE=leak, run it in
CI, 2021-09-23) I missed that I could do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index c73b107d9c7..b439c1a4f82 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -201,7 +201,7 @@ linux-musl)
 	;;
 linux-leaks)
 	CC=gcc
-	setenv --build SANITIZE leak
+	MAKEFLAGS="$MAKEFLAGS SANITIZE=leak"
 	setenv --test GIT_TEST_PASSING_SANITIZE_LEAK true
 	;;
 esac
-- 
2.36.0.rc2.843.g193535c2aa7

