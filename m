Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAEB8C77B76
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 12:20:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbjDNMTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjDNMTP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 08:19:15 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B409A5FF
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:03 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id bu14-20020a0568300d0e00b0069fab3f4cafso8608256otb.9
        for <git@vger.kernel.org>; Fri, 14 Apr 2023 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681474742; x=1684066742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ti6xZ4a/m+5AGfIdRU2re7/IOM+gLDppbWJUnk5WpBE=;
        b=CDcingrCERcdhiU2feF0J02YS6sAyeOf5lbUsYuPxu8m8XqloT1KjT2MyLPV8VJ7hl
         aOqoVTF4TDMFpuZaHnosGCy+dv1DdxbfLqb5upBet2YsthS1s+oGgZbTF8yeXocVskFe
         KZbubY04aE1pcFytaLPmDaP//XFtP090blM/RH73WS4EinKPBYU2i0P8PR/OJ+yUV+FR
         yP2nBleGFFBlGMO+4EAwSN8y7Je9Q+xEhqsUlSoiaBWNKMrZUgFaaeW3HwGuBgzhEtlG
         dY9jwcB98Yyn+u306zjkyAYXYt/rOiZlzmyypxoJQN+FJOkiILGTy2VXGo0r0/ozKiND
         suSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681474742; x=1684066742;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ti6xZ4a/m+5AGfIdRU2re7/IOM+gLDppbWJUnk5WpBE=;
        b=HjoQR+JRPsNE9iEVjIZl1Ui22U/ri8eHz6ytzC6Spkh3Zoc+Oh37V03aqPdlPBDpIX
         k+L8frDM7/z4sn52dRyUefcRPvkpSTw76JE2NnRPrrBJ4Eee3ZbJPLPt7IDUfUtWaxad
         Ii1mV68QJxlKy4qd4AgYZfPAKpHgw8LVXeuExrK6koz7qd7+rr20xDLGAjP46zUuLzHx
         NXebd2PWNrPEUNcRhGAmk+0O6wHc5A+2rvX7lYhST+vNiUj2N3Hbzy9Pm4O/mUPl+N00
         Eheg8cTYYP/T5DKTs+M2uKDDpU6svOpuIgj1AW3sh8K+V0o0MobFCuY78mtmWc2Y1GbU
         btNQ==
X-Gm-Message-State: AAQBX9fFPYBoEwNosjeVSOhbjOlUhPOMw7OrqFHyeXSo0tmeCwu1x1D5
        2V8oIWuPkwBVMcBu6NL4m5Zq0jsS7Vc=
X-Google-Smtp-Source: AKy350YH1PEHSpLOt3JeogXmJx0neklhifdgetzN34OObj5t6/dJK+YEumO8nKBUzME+KdV+z7FrTQ==
X-Received: by 2002:a05:6830:1652:b0:69a:5407:e563 with SMTP id h18-20020a056830165200b0069a5407e563mr2652573otr.16.1681474742597;
        Fri, 14 Apr 2023 05:19:02 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id r5-20020a9d7505000000b006a3bd777dfdsm1636686otk.12.2023.04.14.05.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Apr 2023 05:19:02 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 12/18] version-gen: do v fix only when necessary
Date:   Fri, 14 Apr 2023 06:18:35 -0600
Message-Id: <20230414121841.373980-13-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230414121841.373980-1-felipe.contreras@gmail.com>
References: <20230414121841.373980-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's no point in having a v in the default version only to be
removed.

The only time we need to remove the v is from `git describe`.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index d4de540249..0691f481e4 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -1,7 +1,7 @@
 #!/bin/sh
 
 GVF=GIT-VERSION-FILE
-DEF_VER=v2.40.GIT
+DEF_VER=2.40.GIT
 
 describe () {
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
@@ -14,11 +14,10 @@ then
 	VN=$(cat version)
 else
 	VN=$(describe)
+	VN=${VN#v}
 fi
 
 : "${VN:=$DEF_VER}"
 
-VN=${VN#v}
-
 test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
 echo "GIT_VERSION = $VN" | tee $GVF >&2
-- 
2.40.0+fc1

