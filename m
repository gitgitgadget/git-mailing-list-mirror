Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 918B7C433FE
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 14:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236102AbiDWO3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 10:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiDWO3U (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 10:29:20 -0400
Received: from mail-oo1-xc2a.google.com (mail-oo1-xc2a.google.com [IPv6:2607:f8b0:4864:20::c2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 447A5DF6C
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:23 -0700 (PDT)
Received: by mail-oo1-xc2a.google.com with SMTP id g30-20020a4a251e000000b0033a39d8340aso1937832ooa.5
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 07:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EnjBN/XzFJ1WWKVcfokU97kW/LeR04cJJXFrJ6VzEkA=;
        b=KMVYfX5yu0tCC5YHRunQ5AHMbkycyvBpgJ3OniLJFiOyMWzweV9iw/uW4LyGfE/JOe
         Sl7QZd2ea6NA/Qp8KxkqKXMhkJLOnYHjWVb4mPRetBoQVSyfDUXTbe8Y7oV3wVJ8Y/4F
         6LiC5o8aJL3/xZpHPwcf1r1bGqNv8NeG7AtoismH3AfSPMbVLd4plI7SMqUtKZV9BJYY
         +WoOSQ5oJL2X6qLf5c7Ig9s74A6c2t4xkhrm1ytLxMUNdjSfAxxYK+yE0tjFa3GXZIi0
         dBbRkK8WQbtvYKvCx25C2QlBDFQQO91G8yi9JWS0IGChWWkmquqX3wUixc3Kf95lmVLU
         NjSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EnjBN/XzFJ1WWKVcfokU97kW/LeR04cJJXFrJ6VzEkA=;
        b=nyWY54qXWx1IzoPW5OKZmnWM7KHfktqRIOj+veyGGqJbGCIdNRFwrKlwqnV5xvBL8K
         axuTZ8N09iY1JU7790eFzcvg/KRBQRjRBZpQz3wi3JUcBLiBdyj3AULIQ37fnwCzzsKh
         UckxIa7HAFQafsMPx33n236H9aFLJKw3BXcI6jqZiEYJVPDLDQyN3r8v3bn0DbAhNeBs
         yUSWnioOjgzlzeJITiQS1VTAKYoKivvFPGAk4bP4XWF8Wg2qfjx71nSBpuBdP9U5fKFX
         Re5Dz5pIsaeYlURie8RpKkc4xtd7DJcGJEXPRM/+ulWFkD6UZJeietiMdulxP5HAxWy2
         fzOw==
X-Gm-Message-State: AOAM532XFCIgdtB4E1tU7ExWQ3CcjCJ2cfxq0HqF0oWYWSOpuopxaWrb
        LI6M71eEkDPhvBjS/tj26o4wOOurSS0=
X-Google-Smtp-Source: ABdhPJwWxcE1SZkcHZjBA6/p8VtyhMZKj0F6SmThoq4XYouFDEtddPFkA8qMn9Lm87aaZndgsOzIow==
X-Received: by 2002:a4a:8081:0:b0:33a:52ed:3b3b with SMTP id z1-20020a4a8081000000b0033a52ed3b3bmr3409507oof.26.1650723982489;
        Sat, 23 Apr 2022 07:26:22 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id s4-20020a0568301e0400b006015bafee43sm1869993otr.46.2022.04.23.07.26.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 23 Apr 2022 07:26:22 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: [PATCH v3 4/4] CI: use https, not http to download binaries from perforce.com
Date:   Sat, 23 Apr 2022 07:25:59 -0700
Message-Id: <20220423142559.32507-5-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.266.g59f845bde02
In-Reply-To: <20220423142559.32507-1-carenas@gmail.com>
References: <20220422013911.7646-1-carenas@gmail.com>
 <20220423142559.32507-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Since 522354d70f4 (Add Travis CI support, 2015-11-27) the CI has used
http://filehost.perforce.com/perforce/ to download binaries from
filehost.perforce.com, they were then moved to this script in
657343a602e (travis-ci: move Travis CI code into dedicated scripts,
2017-09-10).

Let's use https instead for good measure. I don't think we need to
worry about the DNS or network between the GitHub CI and perforce.com
being MitM'd, but using https gives us extra validation of the payload
at least, and is one less thing to worry about when checking where
else we rely on non-TLS'd http connections.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/install-dependencies.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 46a23a33dbd..a2d3578f4e3 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -5,7 +5,7 @@
 
 . ${0%/*}/lib.sh
 
-P4WHENCE=http://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
+P4WHENCE=https://filehost.perforce.com/perforce/r$LINUX_P4_VERSION
 LFSWHENCE=https://github.com/github/git-lfs/releases/download/v$LINUX_GIT_LFS_VERSION
 UBUNTU_COMMON_PKGS="make libssl-dev libcurl4-openssl-dev libexpat-dev
  tcl tk gettext zlib1g-dev perl-modules liberror-perl libauthen-sasl-perl
-- 
2.36.0.266.g59f845bde02

