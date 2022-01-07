Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF267C433EF
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347037AbiAGLRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347023AbiAGLRg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 06:17:36 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E86C061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 03:17:36 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id e9so8925896wra.2
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9CufNRd6wkV0nDNdpn89TrmOrdnKkmCHsO22oDBohPI=;
        b=hW15je3W793ZjfZmnaYg7ylPyDfOpwUnpBM6qrm9ALNgs2ov3XvlAETLDIRrabPxAp
         lD6d2J5RBAUNWr156P2E0t/SZKE9+tOJneFgsUwIfld+hVMWeugO2kCPrtdQ03FPhCBd
         bX2UenxoFec5Ky+JSlh3DHJ4lMbb/5PtuRDeB1ipRGyBk9hNMFKDme/ouJPzofoFjqkB
         4FdFTkCwQFcX9kWwlz+c/2UvDjPv4rbov27ofH7e41EheFXuvSoGGuEE/NXJiKVCp1Vd
         KolKdVEUnztiU/ehW4xOVy0tQXAp/DOA7bYLYpx0t0+IaGdcxFbMYDdLxlb6lz7MZ3ms
         Y9Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9CufNRd6wkV0nDNdpn89TrmOrdnKkmCHsO22oDBohPI=;
        b=0/HEyf6ClfxDIHgQ+rEXNmWC8z/g5WR7BEX8mFFDNlb2s5N/q6RHbYp8GI7Qqm3MIO
         TAty5dVcvlKYMxM89pIUdREpF2B3tQkzxbCHhMhj9f+qE9WBKu3GQPYwilhpWEL1gorN
         xSWwWC2RcyMVqPP+MIa/cVUXnDe2Gq8E5Yx/xdEdRS6VvhlIqU9I5Pep4sp25eFrgCka
         eGBAVqNZ4wzFlgqoHo2P6vdfYXvBXXXflauqOIU2p9gr+OfHdQzF0yZep4lZcBf4VrE1
         Qbx4DHuPk7YcU7DMC4B7WwLLY6PLygv8XbwEUEMmJnak9vnAvGCjPpUrDOX46Jfdjd7f
         B/eg==
X-Gm-Message-State: AOAM53033eHzj1BZY/HJF+Cnvp5l79QG/olnrN685rEB4+3bXt+qLTnn
        2mz9RQiowj9ibI9j5kxY4Uul7W5JonM=
X-Google-Smtp-Source: ABdhPJwUSew51cXM8l8uAjw6BKzkrAVhcDIvDV9vEtDtZTTe6isGe4GtqhuKEledNYOBDr/eVYCFkQ==
X-Received: by 2002:a5d:4dce:: with SMTP id f14mr45618628wru.336.1641554254854;
        Fri, 07 Jan 2022 03:17:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o1sm7706609wmc.38.2022.01.07.03.17.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:17:34 -0800 (PST)
Message-Id: <c97a41af38982954b384b68ed7aaf4d9a157043c.1641554252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
References: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
        <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 11:17:29 +0000
Subject: [PATCH v4 2/4] t7508: fix bogus mtime verification
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

The current `grep`-approach in "--no-optional-locks prevents index
update" may fail e.g. for `out` file contents "1234567890999" [1].
Fix this by using test-lib's new mtime-verification API.

[1] https://lore.kernel.org/git/xmqqczl5hpaq.fsf@gitster.g/T/#u

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t7508-status.sh | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index 05c6c02435d..b9efd2613d0 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1647,13 +1647,11 @@ test_expect_success '"Initial commit" should not be noted in commit template' '
 '
 
 test_expect_success '--no-optional-locks prevents index update' '
-	test-tool chmtime =1234567890 .git/index &&
+	test_set_magic_mtime .git/index &&
 	git --no-optional-locks status &&
-	test-tool chmtime --get .git/index >out &&
-	grep ^1234567890 out &&
+	test_is_magic_mtime .git/index &&
 	git status &&
-	test-tool chmtime --get .git/index >out &&
-	! grep ^1234567890 out
+	! test_is_magic_mtime .git/index
 '
 
 test_done
-- 
gitgitgadget

