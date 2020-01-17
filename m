Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432F1C33C9E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1223B2072E
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 20:45:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4wZUMJG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729809AbgAQUpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jan 2020 15:45:00 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:43754 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729684AbgAQUo7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jan 2020 15:44:59 -0500
Received: by mail-pf1-f194.google.com with SMTP id x6so12463012pfo.10
        for <git@vger.kernel.org>; Fri, 17 Jan 2020 12:44:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=S5J0IT/oNxIpEki3dZbwMLp73aungk/KQQhEG4ofblw=;
        b=j4wZUMJG8IBUYypboXye5/D0OpTSuhSjFFIpyVJgTIDmXUmLex/VPWEyFw6lNeni9G
         5w84vbd0CHokrxoCIj1oG0hsXnvLAMBQ2jHd9sBBE8eqbvkxeOJ6j6jWlnyX7WJhz5cB
         f/PjLppcn9yTBOr5KtYblCSHLPxRhp5bAxCp3q83kKztcMqYfT3nKIf5W005rMMbQ3q8
         7ZS8F+5pQ62ZcSAowEfAqbQy2GPW5wpa9ZhzQi1HrPbXxgSgSBe7KnajbHjSbjgD5VDn
         3/POYISPVTxNmKgZWflGqDzkIHkN0vwKy2J2VNXjoXvaNm4RpxRWnkw/QjftlHRsTp9J
         RhjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=S5J0IT/oNxIpEki3dZbwMLp73aungk/KQQhEG4ofblw=;
        b=P6KYqKlDiE8Ksxp97/eep4rkT122YN5rve6tqliCa6Qnr29Uv4Llq6B4zu6Pu2Lb++
         58ixidKkINXClRVyH5OZNb64Tes1tfKVzKDJxPA1yPurbxR27cgwkSwO7fktKrRdokah
         wC5rPqtXsweKMxcuDPtMKMQ5JgxeT6SDT0w9t8xhELnwWTYQeROn6b4Nr3qhaKwMLKpZ
         VsM+kP5mkFBRiiAvy02XVw1mNv2lD+yqLtNDLzibwt2cJfvjodNrB2+OdZmdh6Wv670I
         fWpcZI4AQRn9wc/pD8WIsdYLHYd8MBl10MB+rVkIZLT+yrh/0jjEW9zRvbqMI5TFOSzy
         CiKw==
X-Gm-Message-State: APjAAAUAB7OI+uhLtdQ2MLcZsX76lazfFmzcdPrpxu25cnu/pEMVglg0
        wedjGdFrBaVWQIsMQRE/rHU=
X-Google-Smtp-Source: APXvYqzcPnpX5DnsXmTX9gLyEKR5d+sTGK4neHP2rhRkijsmv9HOYV2gdNFhDhtQ1XeFjYvZ1zntSA==
X-Received: by 2002:a63:3196:: with SMTP id x144mr46950877pgx.319.1579293899150;
        Fri, 17 Jan 2020 12:44:59 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.169])
        by smtp.gmail.com with ESMTPSA id u20sm28844190pgf.29.2020.01.17.12.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jan 2020 12:44:58 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        shouryashukla.oo@gmail.com
Subject: [PATCH 3/3] t6025: use helpers to replace test -f <path>
Date:   Sat, 18 Jan 2020 02:14:26 +0530
Message-Id: <20200117204426.9347-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200117204426.9347-1-shouryashukla.oo@gmail.com>
References: <xmqqblr3f1q3.fsf@gitster-ct.c.googlers.com>
 <20200117204426.9347-1-shouryashukla.oo@gmail.com>
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
index 5136bf1e13..18a204bb65 100755
--- a/t/t6025-merge-symlinks.sh
+++ b/t/t6025-merge-symlinks.sh
@@ -37,7 +37,7 @@ test_expect_success 'merge master into b-symlink, which has a different symbolic
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge master into b-file, which has a file instead of a symbolic link' '
@@ -47,7 +47,7 @@ test_expect_success 'merge master into b-file, which has a file instead of a sym
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_expect_success 'merge b-file, which has a file instead of a symbolic link, into master' '
@@ -57,7 +57,7 @@ test_expect_success 'merge b-file, which has a file instead of a symbolic link,
 '
 
 test_expect_success 'the merge result must be a file' '
-	test -f symlink
+	test_path_is_file symlink
 '
 
 test_done
-- 
2.20.1

