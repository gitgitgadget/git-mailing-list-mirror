Return-Path: <SRS0=dClv=3H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E676C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D91572468C
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dZHB85Nk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgARIdo (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:44 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37833 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdo (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:44 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so13108883pfn.4
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbAEoprmoggkR26eAAqeoFeiqErsIATEpefJg0F+rhY=;
        b=dZHB85NkByA0LS+Alqo4tIJQyIKxQsvJ82uqcx64hk4AUckezssXRe6EYkFkUCs/UY
         FXaKHvN6kPbU7zZOFgacFvje7jrMx69hsMNl/iIEl2PfRgb6prWA7xS5qJDtCLt1BZyM
         IERx7STjwUDjdsdoiY0CHKQ4Okq8rJ1p2XRG6EWU8yCNcPQXr97Ouuy4VFtW04Sicg7F
         AQhkIK2DqCh8hN4+iQM2j9bDWumCfvO3vttgV1bccdA10HU2WW/6Ek53gLkFJM87zbsG
         W8pVuJZBINbU+Kl3Oj3ZEdUZDs95P1FIDj+ZpcgleOgD3uUlXV4aFbqKSl8PETZp5WER
         LYFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbAEoprmoggkR26eAAqeoFeiqErsIATEpefJg0F+rhY=;
        b=CNbWHS1CbR7SmpX0NZmffW2SgWH3mr6VJuQiqR15c3Jj4F4x2Lj/hQGJyB93umINM0
         TX4EEDpt9g35NwROLh6+Mxs9DtY8MKRkkPBV0jUeaisLu965CbCQrYFZHSqXTo11ckLL
         xIKrbVNGPKUA+kz++e1UwZMmRwxxRiMsq2BX1PL2q4rHv+LC3PP+UJ546Gr4KlFLO8Me
         hLNkJ0FQrTTmUmvYicQc8h1+wj1uxTfZraM7tSnpA4fB6IkPCiwAwK8qvlzQV8kHM1aE
         7D2I3ZJXl+nzMdHXAwrCAJmW90J2xULeDqEYLkx6+MkLPcAiCJkHTSrNoe31zMX2utd+
         4WEg==
X-Gm-Message-State: APjAAAUZEwHfR9RxZF/kSAfr9tS0tHx4TxCK8QOsfOXWQW3SqgpZg73S
        xTZGUBY7HFJYaLdlmRl75CM=
X-Google-Smtp-Source: APXvYqxBBJW2jleXDp9M9MG0g0cLaKbL33kEBST6JcqVDNvMTpVAzqRMp+ByIPPwaFr4q4Io6soclA==
X-Received: by 2002:a65:5608:: with SMTP id l8mr50677399pgs.210.1579336423219;
        Sat, 18 Jan 2020 00:33:43 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:42 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 3/3] t6025: use helpers to replace test -f <path>
Date:   Sat, 18 Jan 2020 14:03:23 +0530
Message-Id: <20200118083326.9643-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200118083326.9643-1-shouryashukla.oo@gmail.com>
References: <CAPig+cQX=jB1KTKcOMVE9u0jX-ZXt_vQBndkzqqQWORu5iFxeA@mail.gmail.com>
 <20200118083326.9643-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Take advantage of helper function 'test_path_is_file()' to
replace 'test -f' since the function makes the code more
readable and gives better error messages.

Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t6025-merge-symlinks.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t6025-merge-symlinks.sh b/t/t6025-merge-symlinks.sh
index 41bae56ea9..ebbbc03f1d 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -38,7 +38,7 @@ test_expect_success 'merge master into b-symlink, which has a different symbolic
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
@@ -48,7 +48,7 @@ test_expect_success 'merge master into b-file, which has a file instead of a sym
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
@@ -58,7 +58,7 @@ test_expect_success 'merge b-file, which has a file instead of a symbolic link,
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_done
-- 
2.20.1

