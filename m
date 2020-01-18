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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78797C33CB1
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 487252468B
	for <git@archiver.kernel.org>; Sat, 18 Jan 2020 08:33:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oljft9+m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgARIdx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Jan 2020 03:33:53 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:54593 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726509AbgARIdx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Jan 2020 03:33:53 -0500
Received: by mail-pj1-f66.google.com with SMTP id kx11so4262678pjb.4
        for <git@vger.kernel.org>; Sat, 18 Jan 2020 00:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MWoGM3Qa9X+AZ56NlPJQ9/XkIRHHhYCm+ixQ1gRl95o=;
        b=oljft9+m/TWtYE/X1pm3sF9Sf/G0zvwZDCMM5zO78nGoAtZXDo0p6jZv+IE80m4Lfh
         aoTlTziAx8s8PRwzKIBi0RYQi7UDnoWIgaRPAj2qFyX9PI+DcKToBDVMFRPKgqDri9vt
         +KFAq38mS1gDgQfBEQlO3ACDfEqw7llYVM/dqOIY/WNws8RKKGv9+WLP8hHTGsVuTxbk
         rpW7aLx9uf5ALcYHp7DCW1gKaMZtxj8I0pmpHuCQgkHRH/TjuIK//z8V/5WlF5ctbpSD
         2G/ITVHoGel2Vx3Ai5uQg0XW6ypbRhR7L04QKk8xEF//hq9qpITtlvYPMv5J2+123Rni
         WXrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MWoGM3Qa9X+AZ56NlPJQ9/XkIRHHhYCm+ixQ1gRl95o=;
        b=AuySHUKHI1eP60htrNOM3/wnj1K6mjt5yPIGxTB9vrZ2eu1knumhyvX5kqhwyjhqf8
         7VD7jNl3zS1SddftZT90VxG6NVb4jpFgswbA8c1KID5aZP74YpSfeaEjN5hJ8Taqkdrb
         A6XorIDvDdZcfX3MK1FumLGyDwHl6SCWnfWePYlA26oXzak+VVbNsohC+PON0k5sQl5/
         fitSjz+tvL/h5N9iUjYdbtM3fMJLAWHxUSM9dmI+JY64h3gy+oozkXV2nNbRYQSNcXTM
         wfQokUW/sRuapZx/54GfNWnHxOnoqts4Jv+xTo/ZrUIyK9xzkEK9MfAJ9Av/KLUVtbK5
         96ag==
X-Gm-Message-State: APjAAAVVyRS/o61/iMJYaD+7RnCM9OJHf24hzb7EvtytaAanY1Y95lDt
        vEC1BxSVAMBf3qp/LrX66N4=
X-Google-Smtp-Source: APXvYqxuaaEJmrfRrRJ1uFDFsq8pt1ceIEfIOY9rqLindfU4uQ2JtFFvSs5GKGr0CgQjd0Kehf+dzg==
X-Received: by 2002:a17:90b:110d:: with SMTP id gi13mr11061198pjb.123.1579336432734;
        Sat, 18 Jan 2020 00:33:52 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id c10sm605038pgj.49.2020.01.18.00.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Jan 2020 00:33:51 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     sunshine@sunshineco.com
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH v3 2/2] t6025: use helpers to replace test -f <path>
Date:   Sat, 18 Jan 2020 14:03:26 +0530
Message-Id: <20200118083326.9643-7-shouryashukla.oo@gmail.com>
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
index d257dcf34d..6c0a90d044 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -36,7 +36,7 @@ test_expect_success 'merge master into b-symlink, which has a different symbolic
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
@@ -46,7 +46,7 @@ test_expect_success 'merge master into b-file, which has a file instead of a sym
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
@@ -56,7 +56,7 @@ test_expect_success 'merge b-file, which has a file instead of a symbolic link,
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_done
-- 
2.20.1

