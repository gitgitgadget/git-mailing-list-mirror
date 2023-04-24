Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE584C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232228AbjDXQvA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjDXQuv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:51 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D14F6590
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:51 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-187d9c205e9so3317141fac.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355050; x=1684947050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ikrhh7WqtiNmt86GQKZ7af/kse4hJbj5Vl4CEjNhjbU=;
        b=PwsgsdFa8DO9E4wWqxxGltZy1Z+DWhaI+TRhfZCh2T8lQdiugP4z35uLSnTztFYvct
         6g+PDHfeWpsfDivb0r4eLBckjvUQBZ0p4HQvWSukUtGMoKDkqq12PKKIuq12PWopFzAh
         UM6Sb9xUrfBbjygI3FBrbo+004YZRLIHKMptLuCHdwEGBuI5mjAw+vhqwrX6QBjWXmHS
         AC+IPv3qVCe9MAZEAvfx0iFIkmTTnZdcx0hFs6Z9Me50imtl6mFVoYyF5qLwpYSs3NQt
         sqn3nzAtycuO4vIfzJYG13xfEByia0MpXcYErFHPvW9qNvmDhzYKTQ5RNHXJFs/54Zfn
         QebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355050; x=1684947050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ikrhh7WqtiNmt86GQKZ7af/kse4hJbj5Vl4CEjNhjbU=;
        b=YG56em/k8L0rbZgn/N9V9KFDFU7czTLunP5UTFWD+t00EMoc5rgEb5Sx+u66NvrU3p
         4wVh+/5o5yk/OUcdkFV61swWG3TtBK4CfcCaeRxDJSmp/txDV+3lAYtMNDGX4CULhAoE
         uJY5uMq9DtwKiY/lXA0ws0B+oL2YyjI1hJVE2Nvjqi2PEJ53sDykCgGTE+xHI2GDGcTD
         la8rKUiKMZYUZUv0OJZKtRTPXeJceb5t6x9fO/MOwaaW53GGiJMUctax6G/Wa2QLNYCa
         SQ0gkwSoL7Vy2HguhkdohNUa7ygtJvdLQpou3Fl0lNsJH+SyvFoGJWIlpuWWYORkwwWV
         8Cnw==
X-Gm-Message-State: AAQBX9ew577TRaZsjpwtCChevWXVTpZ9XZXk+apDXkkzy30amL9M/clE
        eY7lBYrBdPHH1zW+nVtD9Ju2jyzpOtU=
X-Google-Smtp-Source: AKy350beLL8GJCbZ/j+2fiTI0rGXmfUNgvKQsZJ5qZsQznrsx5AcFAgpcd8lBz7dIqPMArwmyoz7Mw==
X-Received: by 2002:a05:6870:214:b0:18b:1d56:b846 with SMTP id j20-20020a056870021400b0018b1d56b846mr9709808oad.48.1682355050371;
        Mon, 24 Apr 2023 09:50:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id v68-20020a4a5a47000000b00541b5963069sm5061985ooa.20.2023.04.24.09.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 06/15] version-gen: simplify `git describe` checks
Date:   Mon, 24 Apr 2023 10:50:32 -0600
Message-Id: <20230424165041.25180-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

How can `git describe --match 'foo*'` return something that doesn't
contain 'foo' and without error?

It can't, so no need for check for the impossible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 17 +++--------------
 1 file changed, 3 insertions(+), 14 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 34f561752b..e99c7b45c0 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,22 +3,11 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
-LF='
-'
-
 describe () {
 	VN=$(git describe --match "v[0-9]*" 2>/dev/null) || return 1
-	case "$VN" in
-	*$LF*)
-		return 1
-		;;
-	v[0-9]*)
-		git update-index -q --refresh
-		test -z "$(git diff-index --name-only HEAD --)" ||
-		VN="$VN-dirty"
-		return 0
-		;;
-	esac
+	git update-index -q --refresh
+	test -z "$(git diff-index --name-only HEAD --)" ||
+	VN="$VN-dirty"
 }
 
 # First see if there is a version file (included in release tarballs),
-- 
2.40.0+fc1

