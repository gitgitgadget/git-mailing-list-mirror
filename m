Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0956C77B72
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjDNMTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjDNMTR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:17 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8697BAD28
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:06 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id e80-20020a9d01d6000000b006a43569e458so2018490ote.10
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474745; x=1684066745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HdCFWIPD/Xya/EAncT1NEKTkVPi/mTd9BhjKB2sKeIw=;
        b=cAlrP7caJs1RiWp2wZglyOC4ua4+pam2qacRN5IW7k3tWvZpur+svWFQLh98LXYcr7
         IJVhFE7tTvnx6MOjMxwAC7dXrQtvxO47JDHmg801u+gkwpfWCs4cjd7ugeal61bVTaLm
         jN/cmYo2+F+QxQoW6/mVHDNi0/uxUppDW2aC2DxENWYVrgBdAOccnEYJhyBqBt7k5v6Y
         sbQLeFrely9Oz++k7jjmcUHPlGXE9AAgAf4bObrgq387BagnpleGRxsfF+vxehxOYT51
         rh+rePQCWLtRyf4PqOtc4YL2cWUny2fdc5VAy8lKKb8UjXuV6pffgoEv40lZHRVnd8Kw
         mPzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474745; x=1684066745;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HdCFWIPD/Xya/EAncT1NEKTkVPi/mTd9BhjKB2sKeIw=;
        b=RN7xeLFFi7lVK6n8TIPJFa/l5Y4wz+JMjFGGV2boF0N748pk0WArI8wfxJTI+7WGle
         Gv3mtz3oFea93a3iqYPyQCq7a0ghtm3l8+l1ILv6olwlEXLf29ZVelfIYU+JLJbXPhKy
         WpaalpURH7TSvXmktgJ4NdjPjOvupxmhJGyW6UCMDqBpTE/OgVXwESA68aepyOfLSfJJ
         qfupqNscAmHsU5ZFtk09m1UryQlPDHtxEK/OmrcLFwOdwyhVLZ29OuMp1ajc0jfM7gdY
         Hq5rmDUmBX+VOJLfGVzFlEa3cyECc1uJfNk3Ymlsx1H1rpfJpSoaM/qQNttWEUM+AVvd
         CNVQ==
X-Gm-Message-State: AAQBX9f/gIJnEEoNgtogJ6rBq9R39ikoLv+YP6n32yys/67x4cqeOuAq
        53NjsrZbcuaeX+YpStABHdrWAMMzJ14=
X-Google-Smtp-Source: AKy350aVNz9pDZknqC6aKX0yug8v7CCd9OoAsTJvZ+U1d3MfgoczVArUB7Yc/3+b7tWanqa/YwyZfw==
X-Received: by 2002:a05:6830:22c6:b0:68b:cdc3:78d7 with SMTP id q6-20020a05683022c600b0068bcdc378d7mr2333145otc.8.1681474745489;
        Fri, 14 Apr 2023 05:19:05 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id b6-20020a9d7546000000b006a2ce5f3641sm1643279otl.8.2023.04.14.05.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:04 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 14/18] version-gen: refactor main functionality
Date:   Fri, 14 Apr 2023 06:18:37 -0600
Message-Id: <20230414121841.373980-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's pretty clear that the `version` file overrides `describe`, so do it
in one function.

There's no need for the comment as the code is self-describing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index fa0e72a32c..53b3d64131 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,18 +3,12 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=2.40.GIT
 
-describe () {
+get_version () {
+	test -f version && cat version && return
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
 
-# First see if there is a version file (included in release tarballs),
-# then try `git describe`, then default.
-if test -f version
-then
-	VN=$(cat version)
-else
-	VN=$(describe)
-fi
+VN=$(get_version)
 
 : "${VN:=$DEF_VER}"
 
-- 
2.40.0+fc1

