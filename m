Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D566C55189
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 658582082E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:51:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/YDNT9G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbgDVUvJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:51:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbgDVUvI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:51:08 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B161C03C1A9
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:08 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r26so4160791wmh.0
        for <git@vger.kernel.org>; Wed, 22 Apr 2020 13:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+BzgB5ENmNknF0tWGX7CWc8gz1tlBSErAWASTImX8bs=;
        b=i/YDNT9G8vCL0pZ9NEyGRfI7kCAmvZcUcvgD7mCMcHgtUxKY6FHMUyzwaVojFg+KsA
         aZvnUlg21XkwtK+1RI6IcXdTQxmuiBcZ61jwIs89fV5gSiqyBLop4Vl+RNSJeI/rKNu4
         fM9pyrXzwgZc1vSglyLxwc1Avjne17P68rDTcbMZsn6xHWh4ryc9JCpZJMeqPcfuRNrA
         7PFDciCSNuq3bfiR+j0huhgFiK8cc5jaaWrCYAtnmKxj5wNlHF5js2wun3GwBTzwRcbM
         ozUnwov6a0UkH7ogmSssrDlMUG5Yq2uHvtecqXHZD3upc9XBSzUc7wP20XyrWxOg3l+J
         nC5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+BzgB5ENmNknF0tWGX7CWc8gz1tlBSErAWASTImX8bs=;
        b=AInUhZSzXYeX3p5I5V1ubpBGddbknVv8GgHoX1mTwi3e2SRiC3T3wMPP39CgaDW0Bz
         iOYkt9f/oE7rTn/6Fn4arE9/flgB/yiB7YHQqvD6CEtOFsvVTYZHLQPV4QizvpXlncGG
         G2CIatOPJKUZBf3B/kis/VjDa+hQbiarJ0RROOrgG/W4A9+1DeRlVot2f29IHJFR2Tyy
         oJ7hwQEiAZThanWgsGPxwo09riLtWpfoUXqZ+BuQFI+NzIHr9ofRhw95UXg5l4kdOGXQ
         hyrB27qu07BVrqyW+FrmEV4v754fwXGhgj3a9LOP1MzBwQtVQ6kOvBDhMJayuu8Q49Zt
         GV5w==
X-Gm-Message-State: AGi0PuZsfxPxJWQkYjTKdLwgpGgzVu0ys1j4PZcsstPAPjeYsDnYl5XI
        dJbfWHsvoaf+VJs3xMSZWaQ4DMjb
X-Google-Smtp-Source: APiQypIEwyGi7aQytjcVIaXRIMFpbDdW2oUYd6YtrgJi/R6hltG/+uVy3MKZLiZGdqPQFBpRpyqZmA==
X-Received: by 2002:a7b:cbc6:: with SMTP id n6mr336573wmi.155.1587588667160;
        Wed, 22 Apr 2020 13:51:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b22sm9129205wmj.1.2020.04.22.13.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 13:51:06 -0700 (PDT)
Message-Id: <2bf781081d9e43f38f2141de023fe918eedcbf5d.1587588665.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.615.git.1587588665.gitgitgadget@gmail.com>
References: <pull.615.git.1587588665.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Apr 2020 20:51:03 +0000
Subject: [PATCH 1/3] credential: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Ilya Tretyakov <it@it3xl.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There was a lot going on behind the scenes when the vulnerability and
possible solutions were discussed. Grammar was not a primary focus,
that's why this slipped in.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 credential.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/credential.h b/credential.h
index 122a23cd2f1..5a86502d95c 100644
--- a/credential.h
+++ b/credential.h
@@ -32,7 +32,7 @@ void credential_write(const struct credential *, FILE *);
 /*
  * Parse a url into a credential struct, replacing any existing contents.
  *
- * Ifthe url can't be parsed (e.g., a missing "proto://" component), the
+ * If the url can't be parsed (e.g., a missing "proto://" component), the
  * resulting credential will be empty but we'll still return success from the
  * "gently" form.
  *
-- 
gitgitgadget

