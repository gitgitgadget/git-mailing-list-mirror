Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00ACEC7618E
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbjDXQvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231579AbjDXQvH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:07 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 207FF975B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:54 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id 5614622812f47-38e975c853cso882397b6e.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355053; x=1684947053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDGZRg+9mhMB8924q58ConnpTrIxmBNlQwQtW0pIlqc=;
        b=kJVkoYWG+odKxMmYZIhZ+eSbq3+wVzd+xXEKk9GDBR/oo1vuwKxxej2gLcF2ZsL/xZ
         DCzoKBjo4eUlZVfhrhDlgvHmWGaajfPpjL9xamo0YAukX8nyZrjsFcKaz2SpbW887bhi
         uLdrivHsUhjke2wtiqTfaci8LXTnuGp/SOMjiwUmMuyjNp/bvuNL27U5esX0Zx5fOknt
         33VcZWI4kZlaq5rsxLNnwZ4Tb3F2uZ5OxedkQ4z5NHWZbXExgA8NShML1AfN8ARdD5jD
         FEon4yEu9aOV1RxKZKLwFppPnHC8Xo0Kwvt6ULeSvYeCcwBFdHhBoQak2wq+EO/rX6js
         B9OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355053; x=1684947053;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDGZRg+9mhMB8924q58ConnpTrIxmBNlQwQtW0pIlqc=;
        b=Xq9fijQ+BI1RCZkIuq9oQRIrlRmNHouhbXpNeHWA62VHgCFjarkzDRDR9aF78G5pAS
         C5EI+i633iwoUbhsJ/Uo+PdpzJEw5DDjRbUUYDdDFghsifPDDzGoPCrjRkcmZmd76Uql
         /k8vcR1MtUzs6MTb5ambW7vvIHMH/DLfbebEYi5w+pk59m38XKbYsYiL5QjqScPKq5V6
         vItmgf0ogmOCzUFKee5EYJtyKNV/GA7L3Ky7J7f7IABsbxIDvHlqPSAKdwOFQMMsYxGq
         srGcnTlgz3wF9paXSQWcmFHNpwvTlgI3r3ByAM24CPGJuEfJjmYDd11RMjl1EotaaCDM
         uboQ==
X-Gm-Message-State: AAQBX9d3PzDj4MQgSZjOmDQCs1w0d8JmyFNpO80/JOaCxn8KW2VHA/aV
        X+My12P9CaKHkPLykobCkgDGzZW6eVA=
X-Google-Smtp-Source: AKy350bwxzhk0A0XUvRBeH+6/OH8b53Bj0mMt+DC9nszD1YdJGWo5tlGLcXehu6vk7Or7Qep3sLogA==
X-Received: by 2002:a05:6808:4f:b0:38c:a20d:d376 with SMTP id v15-20020a056808004f00b0038ca20dd376mr6878061oic.39.1682355053035;
        Mon, 24 Apr 2023 09:50:53 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k205-20020acabad6000000b0038934c5b400sm1425904oif.25.2023.04.24.09.50.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:52 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 08/15] version-gen: move describe fix into function
Date:   Mon, 24 Apr 2023 10:50:34 -0600
Message-Id: <20230424165041.25180-9-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 8edaf8f335..7a7a7fc591 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -5,6 +5,7 @@ DEF_VER=v2.40.GIT
 
 describe () {
 	VN=$(git describe --match "v[0-9]*" --dirty 2>/dev/null) || return 1
+	VN=$(echo "$VN" | sed -e 's/-/./g')
 }
 
 # First see if there is a version file (included in release tarballs),
@@ -12,9 +13,9 @@ describe () {
 if test -f version
 then
 	VN=$(cat version)
-elif test -d "${GIT_DIR:-.git}" -o -f .git && describe
+elif test -d "${GIT_DIR:-.git}" -o -f .git
 then
-	VN=$(echo "$VN" | sed -e 's/-/./g')
+	describe
 fi
 
 : "${VN:=$DEF_VER}"
-- 
2.40.0+fc1

