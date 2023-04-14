Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A125BC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjDNMTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230351AbjDNMS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:18:57 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709AE9EEE
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:51 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1879502e2afso5529685fac.5
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474730; x=1684066730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQcKAEYzHB9sfB9/cYFsqe1sV8FF6PP6yTX0Z7OGj9A=;
        b=Kx4JGlBiTSWqAJr6VXHxHNVb6QR0sql0LL2JygU1CUBHJjiiEdEg2FygYJUvugVOhT
         Fo+6vU9lV+lIR3o00USmJG9hX4gWU3c/xl8SIplozrEh28vg+hK3ME8Su6A8I6u7Yl3r
         EvcTHv98IDh9MGwWwU5dfSozT8LKYXFxk9XL0CwS8zez27ye5wK+0+agpJHPE1ldy3i1
         pohqzwSkeY13Bq2G3JpV7+TazKJ67BkoC35o/NU7H9Z/friipjB6FKVKM2K78yKnHoZp
         RKFVp8aCUkOb5xLVTaDbrxE7R5pYKq74Jr+YgSDXaMsTOTmSxTKczsChWzX5N+6PrVdI
         XRQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474730; x=1684066730;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQcKAEYzHB9sfB9/cYFsqe1sV8FF6PP6yTX0Z7OGj9A=;
        b=b6UGdTDuebLy9WhY5lTz7nbs/l4F3vjiw8ibo1nx3DNVr7nmids9FUvxuf48ayc4Dd
         6gCKXoiyLSvuXM0+TimVoxdPHBNgTNP5OPhhW4ocd4GNqd1+H4sfJBKnJ8+oDHv3Dv98
         +WEC6lZOYBpnwLLxM+qohGdsfepLhOdtyBqQXDd2bQpdleWbC+oxc5tp065xQY+5sgRZ
         1xGY5yvH4S/2h4XhhZTKZz+IEPZG9d+SCNOrM2jRdySf1tH/4WUb+Ro/hOtyfog2dEiu
         Kpj/e2BpvpRUbEKWGmtqMHTxj69eAXqVPExa1qaMAe8Z7DyLOC3vVYi4SCE2S0L2f6YR
         GELQ==
X-Gm-Message-State: AAQBX9c4oWMhDoCXYUM12NXbAH7BW6AY5DPwPl2xa5oSge+jkXygDLxR
        1+gjAmbx2z17HT80SHZr0p1+gTEkD0I=
X-Google-Smtp-Source: AKy350aMwXX1w0CMf1CdF5qgbE+Xbkxfwf5C3FZBatt3OjDHrFEZlPOkT74Zu682VL3zU36t7oL6qg==
X-Received: by 2002:a05:6870:a54d:b0:172:7fc0:9188 with SMTP id p13-20020a056870a54d00b001727fc09188mr4291001oal.35.1681474730433;
        Fri, 14 Apr 2023 05:18:50 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id 63-20020aca0742000000b003896b3269d3sm1590332oih.20.2023.04.14.05.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:18:49 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 05/18] version-gen: simplify update check
Date:   Fri, 14 Apr 2023 06:18:28 -0600
Message-Id: <20230414121841.373980-6-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't need to extract the version when we can compare the whole
contents.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c0f6bb242f..34f561752b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -35,11 +35,5 @@ fi
 
 VN=${VN#v}
 
-if test -r $GVF
-then
-	VC=$(sed -e 's/^GIT_VERSION = //' <$GVF)
-else
-	VC='unset'
-fi
-test "$VN" = "$VC" && exit
+test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
 echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

