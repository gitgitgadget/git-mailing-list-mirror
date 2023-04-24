Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A3E4C7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjDXQvV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232234AbjDXQvJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:09 -0400
Received: from mail-ot1-x332.google.com (mail-ot1-x332.google.com [IPv6:2607:f8b0:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1253A9762
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:57 -0700 (PDT)
Received: by mail-ot1-x332.google.com with SMTP id 46e09a7af769-6a5e2289965so3899161a34.3
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355055; x=1684947055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bNTf+ktL2dkdthZk78xsIda5Ny7bBME1izzqdqpt5zo=;
        b=mJG//rhl5Wc2FZFVXKjTBfOx8v9GHeESG3GPKAjOBfuWgDjWFC5u0/a2cmtqlVuHBd
         2sHgARTpvQYU6T/Ink6nmoufR0Bi4+UMmgnqGtZIYuvJkVmEYJsOLGpEM3ffv9XAXXwS
         M6W4Yl/P9KLPRAyvrcWEaknm0+R+78+NX/o0W+YvBJ0E4mUuZvJNdIk5UVhCFYbhpv1g
         E5JfGhUZZmn0yCjL1RYfaUEzxXEczu9PefRPl0ZuLRFsqRC3wriaaVm0+wyTmsvdX2dH
         /9fvEqOXVb+QLt4aU+f/ZT+9lF06q41s7lH+Z+/eGCNhxrCF0S4n6PuiexiR2L4caPEx
         ouYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355055; x=1684947055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bNTf+ktL2dkdthZk78xsIda5Ny7bBME1izzqdqpt5zo=;
        b=V92MhFV4Gn6Ou8KUIuXswBP/whRqdvU/gZydrFU0BnfeLQ4crhMBkWABDVmR2oUzB+
         4xkF/QOXSa1g+rGZCrD9ccO6h4Z3rTxDBPXokeS9z/pt4ZfqnCMqz2aSHLfwLGUbdKss
         REAKpuAxaP3qKCTTQLAP4II7k/F75iBJXh5Zj6rKduzsy75eY0rgwyvFkPB7tnR8Q3ZL
         hgITTqL2ibh8d8A28o0bYRTIac+xq2+0CeQGMSOD4UqHcfq3FQRi1bpenxF2+sFEnQUX
         TDNFmt/5Qver0eumxt0mswEaRf+GXTz9dHPYRK442G4ngzxLaIew7lNnpp9W4MI8eqVj
         xyyg==
X-Gm-Message-State: AAQBX9eInqfYeZFteLrM2hJYtw0hK7Z2GiKmq3LbPYO4/SBjDqnIEn2V
        Xslz5DOK/hzrnd1QAEXkq5Qq8JcQJE8=
X-Google-Smtp-Source: AKy350ZNe0iMUbqg7BiY7SBo2mI+1j1n2Q2UDEg9Hwh7/jf2x+FrDrtQKTPGPlOQLhrgFvdXV+/NTg==
X-Received: by 2002:a05:6830:1195:b0:6a6:5a48:1f9b with SMTP id u21-20020a056830119500b006a65a481f9bmr2622918otq.8.1682355055687;
        Mon, 24 Apr 2023 09:50:55 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id o21-20020a9d7655000000b006a30260ccfdsm4801910otl.11.2023.04.24.09.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:55 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 10/15] version-gen: refactor describe function
Date:   Mon, 24 Apr 2023 10:50:36 -0600
Message-Id: <20230424165041.25180-11-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

No functional changes.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index c5265cf9ad..0eaa813cca 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -4,7 +4,7 @@ GVF=GIT-VERSION-FILE
 DEF_VER=v2.40.GIT
 
 describe () {
-	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g') || return 1
+	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g'
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -14,7 +14,7 @@ then
 	VN=$(cat version)
 elif test -d "${GIT_DIR:-.git}" -o -f .git
 then
-	describe
+	VN=$(describe)
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

