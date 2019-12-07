Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4961BC2D0C2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 22:22:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA5B24673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 22:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZUaUEVXG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfLGWWt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 17:22:49 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37334 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbfLGWWt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 17:22:49 -0500
Received: by mail-wm1-f66.google.com with SMTP id f129so11036863wmf.2
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 14:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ycHLJXLtuC0CuDS3pBQBMtjT0D4fo3oynXCxfmg5k98=;
        b=ZUaUEVXGwGR7orEkRMiHZnFLyqErhHgxZoDnIeWn4kV2cS3kOboLlJ3YM4/8hzYrVj
         tBiDLA5G+9qtUA2uNPFqijsetpPs7Z3Y+5PrlUfd6hf95pq09qH+uOlR6Cp6Mh/PPILm
         uBNHroJh2IJZQIp9ydUutsxDD/sNr/FIXCKhSwpv0wjm/ioW/rFFB8HG7b5pgpkp1/9t
         T/TSr3HByj6lGJ08vStlLChwNmli4dtdYEIy15ML76p9yuXAKXz+dedASlyzzgaLlxVb
         4zn5THGxFI0bit83FqYaWNh3Q6ls/8++NGfTSKOOd5JUArf9UM6QzcbFi+pi0mXJUdbY
         W/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ycHLJXLtuC0CuDS3pBQBMtjT0D4fo3oynXCxfmg5k98=;
        b=DeIQHZwjshxVLf/OJiLtq/4x6iUCWppguSfymU41zlwWRs+mAMARCqMekmJWvIZ1qw
         bbzvPnltIh/CtyE/Qqb8zgJUn7UuPLJ8P3Da7lK89MyZus8d7r2wf2E6jrG0tHMczId6
         IxJzkCwRFG1NGW89an4Iw2GCNngdNOzbuDDeZVZDiKhTFKUkE1/yDmrWf7gphuySwhpu
         La9ooQ0BKY4oDJxPxE2g+AtlK4D060KBAnc2GVtVZg9Q9i5WVLR8BxpiIn9XnXcr9C+/
         qNoioQiI9OZMAwfyimRB0DCHzv5ozbB6Lhrb102gNnxIAYh6S98uBMwWRR6yJ/VQp0JY
         LgiA==
X-Gm-Message-State: APjAAAWeQDgXe/aOCpuYrxl5gvdeTY4yQRq6Bcnc5CMWFX2SqQHVSnnJ
        hXNiGAYGUNowgTYZ54X1qHWlLrP/
X-Google-Smtp-Source: APXvYqwZekNMRJ71SGWULXgZ6DtTYpZh9wtMb+WrgvijdnvCWhS8fMMk+13fLdajNjhNnBkPvKRPkg==
X-Received: by 2002:a7b:c764:: with SMTP id x4mr17306575wmk.113.1575757366874;
        Sat, 07 Dec 2019 14:22:46 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k7sm7296792wmi.19.2019.12.07.14.22.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 14:22:46 -0800 (PST)
Message-Id: <bb0830a3f0eb7244eb313c5e8250a4097b6e7663.1575757364.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.487.git.1575757364.gitgitgadget@gmail.com>
References: <pull.487.git.1575757364.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 22:22:44 +0000
Subject: [PATCH 1/1] t3404: fix indentation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This test case was added in 66ae9a57b88 (t3404: rebase -i: demonstrate
short SHA-1 collision, 2013-08-23), and it is not indented in the way we
usually indent sub-shell code in our test cases these days.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3404-rebase-interactive.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
index bf0dc756d2..ae6e55ce79 100755
--- a/t/t3404-rebase-interactive.sh
+++ b/t/t3404-rebase-interactive.sh
@@ -1265,11 +1265,11 @@ test_expect_success SHA1 'short SHA-1 collide' '
 	test_when_finished "reset_rebase && git checkout master" &&
 	git checkout collide &&
 	(
-	unset test_tick &&
-	test_tick &&
-	set_fake_editor &&
-	FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
-	FAKE_LINES="reword 1 2" git rebase -i HEAD~2
+		unset test_tick &&
+		test_tick &&
+		set_fake_editor &&
+		FAKE_COMMIT_MESSAGE="collide2 ac4f2ee" \
+		FAKE_LINES="reword 1 2" git rebase -i HEAD~2
 	)
 '
 
-- 
gitgitgadget
