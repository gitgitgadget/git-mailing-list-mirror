Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE76DC33C8C
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79AE21774
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 19:32:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SI7Xyg7C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfK1Tc0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Nov 2019 14:32:26 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:44091 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726696AbfK1TcZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Nov 2019 14:32:25 -0500
Received: by mail-wr1-f67.google.com with SMTP id i12so32321737wrn.11
        for <git@vger.kernel.org>; Thu, 28 Nov 2019 11:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9mlTKLfGc4+8qCONTmQUYMhzts8nFGvNk9fsXo/vstg=;
        b=SI7Xyg7CtkTaSTE4NaSEf/dvIiXzOU204odq92QiTjHP8HeEItG2v1une4fnvJ2lcD
         jTSDMh7XoXXshHqM2byE9Ypu3d8x2MsfG5mJAnT/ZR43Io+q3S7p+7TXWVgPbwHMwhuw
         s7RlbfvXM3KbZTEh+pDXulk9qQkX8+Gc7zOZgMQfB0/ZsCNbeahBVEhXVYWczKn/y42Y
         7mYEu78jZoUUXdWwYWyUpa33eS6ZgdtJtOPktI9jVgZsjPMHcwqTHHi/E0cSMtHXzAKY
         6WIQlPpWpxUwR6NAVuRE28+uuKncE3VxLRonHrWX4aj1RNXjFBZyb51uFsYfi1aPfYrE
         jqFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9mlTKLfGc4+8qCONTmQUYMhzts8nFGvNk9fsXo/vstg=;
        b=IeOhryIDGv5jpF5N+2Cgl9cR2XawFwLwngQ3hzBQtrE+SLbrC/4vflBFoWwreeR6Yx
         iWRmcCAfkZeV1O4tMQkPBn9SIvKtzOURVPElV1GWe1dUcQby1WJzXD7Ej7G1Cwz1pTzk
         no6SGHXyxQRKgU3Z2Tgkp92WDoUDchf6iyvPbulQdCMKqzEZkoaoUbNJaW2yBjWeIhQl
         4ot7AS2qWIlkhFdjGhFjiEEfwaAaANp6nNfUqU+WGMFpsIlOx0gW+xCghmFGRCJZa5cD
         UauXvuzVHTWHGPiIRO0wq2o4pqP5Sv1MzGkJi6ZhjY1OWH8XIeywla2ZLHI0/hvSnok1
         u/WQ==
X-Gm-Message-State: APjAAAXUJvHowK6fzgGRtDNWqJfTcABO1avJWLrBdOImljqiTGS3o13g
        zbCXb+156c78zPHIr0pgGn7WTPGf
X-Google-Smtp-Source: APXvYqxIszCjUNvWhLDSCFIpE+QQTS3m1szt9aFGDysa1stCfGso7U0x5XrdkC6ZtLbFN1buOVN+BQ==
X-Received: by 2002:a5d:67ce:: with SMTP id n14mr49727276wrw.67.1574969543389;
        Thu, 28 Nov 2019 11:32:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d186sm11978034wmf.7.2019.11.28.11.32.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Nov 2019 11:32:22 -0800 (PST)
Message-Id: <ded493ee802805f831a498aea43e3e72a16c21bc.1574969538.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.479.git.1574969538.gitgitgadget@gmail.com>
References: <pull.479.git.1574969538.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 28 Nov 2019 19:32:18 +0000
Subject: [PATCH 5/5] t2024: cover more cases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2024-checkout-dwim.sh | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/t/t2024-checkout-dwim.sh b/t/t2024-checkout-dwim.sh
index fa0718c730..2fe77387a6 100755
--- a/t/t2024-checkout-dwim.sh
+++ b/t/t2024-checkout-dwim.sh
@@ -132,6 +132,33 @@ test_expect_success 'checkout of branch from a single remote succeeds #2' '
 	test_branch_upstream baz repo_b baz
 '
 
+test_expect_success 'checkout of branch from a single remote succeeds with --' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	git checkout baz -- &&
+	status_uno_is_clean &&
+	test_branch baz &&
+	test_cmp_rev remotes/other_b/baz HEAD &&
+	test_branch_upstream baz repo_b baz
+'
+
+test_expect_success 'dont DWIM with pathspec #1' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz nonExistingFile 2>err &&
+	test_i18ngrep "did not match any file(s) known to git" err
+'
+
+test_expect_success 'dont DWIM with pathspec #2' '
+	git checkout -B master &&
+	test_might_fail git branch -D baz &&
+
+	test_must_fail git checkout baz -- nonExistingFile 2>err &&
+	test_i18ngrep "fatal: invalid reference: baz" err
+'
+
 test_expect_success '--no-guess suppresses branch auto-vivification' '
 	git checkout -B master &&
 	status_uno_is_clean &&
-- 
gitgitgadget
