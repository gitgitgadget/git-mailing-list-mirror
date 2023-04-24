Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D771C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:50:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbjDXQuw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbjDXQuu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:50:50 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD777686
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:48 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-187d9c205e9so3317099fac.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355047; x=1684947047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SealYxV1P0U6WM8/BkNmOSbeoydiMVThybk/G9EJ+VA=;
        b=fP4zPffGRzFKLCgxKxVHpSUwFbX5rwIOb7lRFvyYpF4OJUhYwkob46N9/Qllf78RA/
         ztM5Q/C0fGneypafuDVbHiOwM/fV7Lva21HNshvs6G0qvx5xxnpWmcXNx8wYrK7a9RvH
         9OAUCsLQusl3TdiR3d88+uTrbVkQyn/WZqE8MV2AK04PWcoBN7f8RWQgbdHfRarWXW1W
         f8SEyWQtDOEy3CL/+Xch3/k2OOcCL+yFBPAS+RXhY+zExARR4JO+mf0bzRph3ov8ziqF
         v+nwXxOEyI2D5BtBB6XA4Mc0gHZ+PlPb49Om3Xia/SHLKGTvTGvk9R6ZTmBW3bNbTEIM
         scwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355047; x=1684947047;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SealYxV1P0U6WM8/BkNmOSbeoydiMVThybk/G9EJ+VA=;
        b=Pm1nSOpWswzWgCN3tQCeh9uhKEff4syM5vNPRpoBXU1gQPGrGYR1rnIsVcTJolGUQ7
         JMBrsMJxGeIIOMK2GhAU1plUGndM3Uyab+YPJXr5EpOYZ3tL7fpcitzts6YjBbBJBdyO
         nY6f5emriC8k7plg0k7PZvXOTeiJfisoXg6uL5FtD7jA3o7GK60nYbuu58jD4d1LYjuJ
         PErUTeb2XWj30Ob/2TrCYDM4ZAVYeF8RobGIHoEZ1ag/5pxsLBEgBUBtJeYiVVq1qZzG
         sPKmD6VG8hzDhfiINn7pSWvfeDsYowLvmvSioow5llx6KYZSG+SdLq1y3jpPvalCsLjf
         BY2A==
X-Gm-Message-State: AAQBX9fGVFsblrh///d7T9WfbuDUx7LqC8PnGn+o1QHuZcQcUNhIXASA
        DCIdSuQ94uTgcZSMBSFfbCu7rodgjws=
X-Google-Smtp-Source: AKy350YWp/IqIYFygdTWNIZZaD+6aBGQ4u/NPWgUPbTKSWEmlbkGw55a94RmOb2vlOn5tem8IvAfPQ==
X-Received: by 2002:a05:6870:a70c:b0:187:78db:feba with SMTP id g12-20020a056870a70c00b0018778dbfebamr9541157oam.59.1682355047729;
        Mon, 24 Apr 2023 09:50:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id dk10-20020a0568303b0a00b006a60606de62sm4759279otb.52.2023.04.24.09.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 04/15] version-gen: simplify v prefix removal
Date:   Mon, 24 Apr 2023 10:50:30 -0600
Message-Id: <20230424165041.25180-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There is a much simpler way.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 0d00fa3d9a..c0f6bb242f 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -33,7 +33,7 @@ fi
 
 : "${VN:=$DEF_VER}"
 
-VN=$(expr "$VN" : 'v*\(.*\)')
+VN=${VN#v}
 
 if test -r $GVF
 then
-- 
2.40.0+fc1

