Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA7F3C77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbjDXQvi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232284AbjDXQvT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:19 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F082DAD0B
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:00 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-187ec6a5504so3633974fac.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355059; x=1684947059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OBH7cOQDXJn+wAlJ8Gw9zkLtA6buVRqorS+OiGNl+k=;
        b=i52iLIXe81bFVvEQZUMDZChXydaFEhqk+ayb1Ibz26bmiQ4oH1B0VXuXeorrtBX5M1
         iT5VGOdUQ51JnBjaUxDZ2B+qwncLeQt/Umg1A7HrcVsfZkvlwSbKpzjZEnnlmYoeWSrx
         5mHDEYb60J8DWdRyNh3clxLytFU9vM0SfQFrusYapi7BaNmh4l4kiksyWqIeEkEyvRMN
         Kaarvu8y+YIf1ZUX59USkfg1O94tsv+JXrldZCbDm4dSlaFYD9yUgMlLlTCTwoxkdn5V
         KQQwHOElGDLIqxgoxfwEqkv9fniy7ocDnCJDA93GUrwwCRLdGakHt+eLqnyt/0u7lXWk
         0lxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355059; x=1684947059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3OBH7cOQDXJn+wAlJ8Gw9zkLtA6buVRqorS+OiGNl+k=;
        b=hdrZys9BKvvoWQNZzFeZ4ELubk0xFkxrrqmyB9AgZsi1bRayrStNgfZKjNTTy/RKjN
         0Hx1uV1H8aOKMCGc8CtDHZ+CtYSUPALc9w5867OqaveE0K+/j+RZ1iHd6lYYaWy54oJU
         IbQTGJY2Bnm7xT7fTJtWvUjXA/kFIouWdq3A2CYHJU1+/o/J94u6uyahwGcjJ8hifBpL
         yZitRhggqzHnP5nS8fo52jTovnU041DwtnkqFOQZRJu+2YzJ6njaM2o9jKbqsWGXlIy5
         WVuV1pZ18koi+aPH5bJvaDc6/YUBA/Viz4bCrd9f0tHZ9VutLw6QWbxmKuROaWhrNrC9
         Cc9g==
X-Gm-Message-State: AAQBX9eqrTtWE1qaeNwpr0U6Q+a8dcVqG+TaqRqp2Yx4u4XgP9qCsmqN
        RLiXCyw4EII/uWzL4ShJpkIzmkixuQg=
X-Google-Smtp-Source: AKy350Ya3KQjpmSqSnzNUE6hXRv3YIZPQIGNGazcoSQEAnJKNmFrK2+Qbip1frQ7Pi/FpSDD1KN+BQ==
X-Received: by 2002:a05:6870:558a:b0:17e:8a6b:829 with SMTP id n10-20020a056870558a00b0017e8a6b0829mr9586010oao.52.1682355059609;
        Mon, 24 Apr 2023 09:50:59 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id bo37-20020a05680822a500b0038edc69490bsm1209462oib.10.2023.04.24.09.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:50:59 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 13/15] version-gen: refactor main functionality
Date:   Mon, 24 Apr 2023 10:50:39 -0600
Message-Id: <20230424165041.25180-14-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
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
 GIT-VERSION-GEN | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 6bf932c281..5b75cb4976 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -3,19 +3,13 @@
 GVF=GIT-VERSION-FILE
 DEF_VER=2.40.GIT
 
-describe () {
+get_version () {
+	test -f version && cat version && return
+	test -d "${GIT_DIR:-.git}" -o -f .git || return
 	git describe --match "v[0-9]*" --dirty 2>/dev/null | sed -e 's/-/./g' -e 's/^v//'
 }
 
-# First see if there is a version file (included in release tarballs),
-# then try `git describe`, then default.
-if test -f version
-then
-	VN=$(cat version)
-elif test -d "${GIT_DIR:-.git}" -o -f .git
-then
-	VN=$(describe)
-fi
+VN=$(get_version)
 
 : "${VN:=$DEF_VER}"
 
-- 
2.40.0+fc1

