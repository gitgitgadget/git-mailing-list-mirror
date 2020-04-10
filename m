Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62BA4C2BB85
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A3042084D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 11:03:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+WQEcnJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbgDJLDK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 07:03:10 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:33518 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgDJLDK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 07:03:10 -0400
Received: by mail-ed1-f65.google.com with SMTP id z65so2069560ede.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 04:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sg9nhEpWY2FbxqMP8ptNSKKFsPOyNmnzld6av7ivAuE=;
        b=B+WQEcnJtzROIxkSVGWvP4WGT+QeIXXIwQJgMjjPvAoRVtYU/91dO+DQ2oXDkWt3xJ
         ws9AdZ+AqOBiUDrkEGaLNs0XxdhcUY9HBAp2Gx3UbY1cnPPW/BVxgUF0YjQC4fIVSCh8
         p+9WE41fC8cRLUn3hcf1eIt3jZVKEGeLlPNbocFARkv1IEYBD3rNnLJDGgsC9MOjOe2G
         UP2LN15RETf14kYWbBAfdswYrD07azCIwlaaQ7GWYzzKLd3bUYe4F9WxQlI1d4hTvziY
         8RlPgCkrKdbCXTrUTQe1PBwOOHQKccOKpJrOB1K/KKiMoxXLZIYGCByxkWXS823QAnMs
         IwXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sg9nhEpWY2FbxqMP8ptNSKKFsPOyNmnzld6av7ivAuE=;
        b=RRAegqwenCmUmmOz2O1A1eApbvaQHP45RVY/PTwPNwiCnwvSB7quGdTvhmE8IS+ypH
         OsVHcUsp1SZrFGwxF0L7RqKIJ7RTQmNuyl3xD1mCyOtve3UMQ+nBCpciOfnjS341D2Mt
         A2r6JXxnJBiDI5R/C6lV6nnlJr0qxM2SE6B1sNwVU3WFDYBVKOcRhI0Be0rklF1hyKUv
         kyR3nv82cnYUMXycM/Qf2JANkR0i0xFiRLkDxWpkmOm/fTkpLHan/SpHKlNntUQhkPOy
         939huLcinLWbeGgsbbh0to570eaUmhsGH+1/xOJmYasMwOVQlHFzSRhosDelof//8Oxi
         DQPg==
X-Gm-Message-State: AGi0PuYfhgXSi7sSC4eUw4zj2Pr00nbIIFVUtP6mCRHiDA0HdFzCG3WZ
        aVHQTkYWFB9cIF+0r9dbxw/lU8bC
X-Google-Smtp-Source: APiQypI2y1q1DTyUHXLQSMX24gW06J2wU8qvW1VQM1cTBfRl+HjCeB4U163bU9bLXwQB18TkpwQC+Q==
X-Received: by 2002:a17:906:37cd:: with SMTP id o13mr3195673ejc.259.1586516587804;
        Fri, 10 Apr 2020 04:03:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id qu11sm97518ejb.12.2020.04.10.04.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2020 04:03:07 -0700 (PDT)
Message-Id: <d0c0767a2aad765297ec82db84c41fec37eba3ec.1586516583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
References: <pull.603.git.1586374474512.gitgitgadget@gmail.com>
        <pull.603.v2.git.1586516583.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Apr 2020 11:03:03 +0000
Subject: [PATCH v2 3/3] t: fix casing of the operating system `Windows`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The lower-case `windows` refers to something different.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 09e2cebb456..139647a6341 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1544,7 +1544,7 @@ test_bitmap_traversal () {
 	rm -f "$1.normalized" "$2.normalized"
 }
 
-# Tests for the hidden file attribute on windows
+# Tests for the hidden file attribute on Windows
 test_path_is_hidden () {
 	test_have_prereq MINGW ||
 	BUG "test_path_is_hidden can only be used on Windows"
-- 
gitgitgadget
