Return-Path: <SRS0=oq1W=ZN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B84C33C9C
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDEA9206D8
	for <git@archiver.kernel.org>; Thu, 21 Nov 2019 22:20:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CnTHOmwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726762AbfKUWUd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Nov 2019 17:20:33 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33464 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726329AbfKUWUd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Nov 2019 17:20:33 -0500
Received: by mail-wr1-f65.google.com with SMTP id w9so6403214wrr.0
        for <git@vger.kernel.org>; Thu, 21 Nov 2019 14:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PDRBuiN4uuj2Oic+P/eMcdaZg/8GJEflnfYq6+i3Ww8=;
        b=CnTHOmwJnuJ6an3bDHdMI60bufvpyKto+kq+hzvRBU8+lJGGe+TrRHwvT9wu4Mu2gY
         M0ZqwwCtLYb9jRgZFQhVoGWnr6igplWKsbhrED53B3FyBDIzGS8mTjs5VOY3/tnhSgZe
         bCqZAiBiTUk/YRYa3w6ziBOcAtoqYY2sXF6wQMOr/MrDQqeT4nfJMn4FI5RUyOJsMMje
         BMuFoB3q98cC/HBw4BhAiLEysJHA/vPw6l7i2Co0fJT/dE++dSz6rRkimuB4hz9oWxFm
         JuZa91HzxfXtWTu7aF4TWp6iu8xMtlJw0znu+Sw29S8HPiuiVyWyHpv2k5t+DO1uqGLJ
         JZVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PDRBuiN4uuj2Oic+P/eMcdaZg/8GJEflnfYq6+i3Ww8=;
        b=AIeDWORQOKC79GXZYWOZvksvDgoMaX0FaxMTM1/DuzmVM9pGoK+T3FQLUPj8HdmMG4
         nOgpBeqlCgNSjHIgS7o0thrLuOubokcurE1sZD1qJksjXX5b9F3Pm35YRe8mYUdweR7g
         315kmUFh3sqlqJUlir387og8myxwA/mm5eU7MJ7IxSX69lQ24UncGN6fSgVIfpEikqZX
         C7Rwsuf6PRlIRZuyPedefXmR3XqK4AYUD8DQYnCCTSHNJWQqtlh+hYsSKFU+rs2IRgg4
         pYetNtrIFG/3XoMbHpQMVJcCn0fNJTAY0RgFJvm35nozjJTiN1uIfppvyM4QutP1dIcZ
         6DVg==
X-Gm-Message-State: APjAAAXJGoAf9IW+Vyw7AqZUR4M5GiM3La1CK3zeBo9lYI3jRsLWRBb1
        92yLOqrGzfSfl+b0oNvaaS5kDJpA
X-Google-Smtp-Source: APXvYqySfT/1qYmA/kKqVE5SzqlXxs0T2Zkz58ml8oMa41TfQFNyz3GbJ5Mc9tuUM+YwBrfdH96UQw==
X-Received: by 2002:a5d:4ecd:: with SMTP id s13mr14440390wrv.216.1574374831301;
        Thu, 21 Nov 2019 14:20:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v9sm4645244wrs.95.2019.11.21.14.20.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Nov 2019 14:20:30 -0800 (PST)
Message-Id: <d5f5a3e2b9bed793f294f2e6eda6307a800f29d5.1574374826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.466.git.1574374826.gitgitgadget@gmail.com>
References: <pull.466.git.1574374826.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 21 Nov 2019 22:20:21 +0000
Subject: [PATCH 06/11] t3030-merge-recursive.sh: disable fsmonitor when
 tweaking GIT_WORK_TREE
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t3030-merge-recursive.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t3030-merge-recursive.sh b/t/t3030-merge-recursive.sh
index ff641b348a..62f645d639 100755
--- a/t/t3030-merge-recursive.sh
+++ b/t/t3030-merge-recursive.sh
@@ -520,6 +520,7 @@ test_expect_success 'reset and bind merge' '
 
 test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 	(
+		GIT_TEST_FSMONITOR="" &&
 		GIT_WORK_TREE="$PWD/ours-has-rename-work" &&
 		export GIT_WORK_TREE &&
 		GIT_INDEX_FILE="$PWD/ours-has-rename-index" &&
@@ -545,6 +546,7 @@ test_expect_success 'merge-recursive w/ empty work tree - ours has rename' '
 
 test_expect_success 'merge-recursive w/ empty work tree - theirs has rename' '
 	(
+		GIT_TEST_FSMONITOR="" &&
 		GIT_WORK_TREE="$PWD/theirs-has-rename-work" &&
 		export GIT_WORK_TREE &&
 		GIT_INDEX_FILE="$PWD/theirs-has-rename-index" &&
-- 
gitgitgadget

