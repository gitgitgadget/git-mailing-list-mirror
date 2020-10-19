Return-Path: <SRS0=jQhj=D2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAFAC433E7
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855A2223BE
	for <git@archiver.kernel.org>; Mon, 19 Oct 2020 19:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Al0bJM5k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731241AbgJSTbz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Oct 2020 15:31:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731223AbgJSTby (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Oct 2020 15:31:54 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B3BEC0613CE
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:54 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id 13so633811wmf.0
        for <git@vger.kernel.org>; Mon, 19 Oct 2020 12:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Jo7WWrNAmpt6XnQC3Jj7C6AuND5x2YV90VeNlRHQI4E=;
        b=Al0bJM5kJLmK41rT4gOD57lHqZ6jUP61B365a9lQ9Eu+f6CiifGbsMQF9lpxhBQqtc
         XxL0YiWlrbbbZomQKeHqr/pAl7pxKHmf6VfT5FOzWiGjRI6+aiY7JH64e64B7a8z1P89
         MO/FYAGlu+OQPH1b7HZgN6pem7NtoJpQepF0L2r936KOGWfdR4iW8toc6uAdG8IoWTlG
         hpdqB0nltwJyJbdvVPT5F2Dn+u1ePH6giyWvcZgck7MRkgAjYHTDwoZan0wxDf6DtzAZ
         HzdWatiQr8LRdg0zmIvTfiqaGChf3Z7ogeqggS4ovhhLiFZ0oXWzZ471NGHHoLGCdnJp
         RioQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Jo7WWrNAmpt6XnQC3Jj7C6AuND5x2YV90VeNlRHQI4E=;
        b=GSCIsPo+jCl/+1y0oBf4X+sGpKYTIWPhlspOVDVLZUR90bwe5xvJy23Cot8jmTP5FF
         /ygw4/OJ8e3fBKhm3BDNHst4qNU591kMvlG83oJ4T2gO3g9CtY17WZzxCvhZ3Y03dTUI
         ClFWB+sj0fLaJQ06Zj2F3lHxXjhFzWELVYHW+kcUACEOlA9bAWCape+Tp5pz3f2bZqMq
         42grgTCbnuinyRxntwDMaqO54JZpG0lk9GBc9N2p29tpZSdq+ht8S3O8GjN25vEQ7FGz
         /5x69YthUBQxtVyezeJ83IDE33QW4uJQn2ZNM+kKsuyhIHrbnRCooCPtXRKUpF1vQBDR
         FCLw==
X-Gm-Message-State: AOAM531H+cuB+8NOsJK3Oy7ykOob9Q+ewi2hUiPmJOz5D4jMBNEnsEVU
        3pxVev4i5kmj4Mmyr/C0ZNsaE+/Tp4A=
X-Google-Smtp-Source: ABdhPJz1lLhAbijE2MJL9OWtUOkfHwwVDlXhy6mt/xrYzGj+6XdgW5RotlrIq+YKHRqfaCWNXsqO5Q==
X-Received: by 2002:a7b:cc8b:: with SMTP id p11mr828294wma.100.1603135913118;
        Mon, 19 Oct 2020 12:31:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c130sm1070192wma.1.2020.10.19.12.31.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 12:31:52 -0700 (PDT)
Message-Id: <e1740bb7d7d8c90db68ffff443b69894177e36f3.1603135903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.758.git.1603135902.gitgitgadget@gmail.com>
References: <pull.758.git.1603135902.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Oct 2020 19:31:38 +0000
Subject: [PATCH 07/10] t3200: prepare for `main` being shorter than `master`
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the test case adjusted by this patch, we want to cut just after the
longest shown ref name. Since `main` is shorter than `master`, we need
to decrease the number of characters. Since `main2` is shown, too, and
since that is only one character shorter than `master`, we decrement the
length by one.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3200-branch.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 6efe7a44bc..55b24b76ce 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -375,9 +375,9 @@ test_expect_success 'git branch --column -v should fail' '
 	test_must_fail git branch --column -v
 '
 
-test_expect_success 'git branch -v with column.ui ignored' '
+test_expect_success PREPARE_FOR_MAIN_BRANCH 'git branch -v with column.ui ignored' '
 	git config column.ui column &&
-	COLUMNS=80 git branch -v | cut -c -9 | sed "s/ *$//" >actual &&
+	COLUMNS=80 git branch -v | cut -c -8 | sed "s/ *$//" >actual &&
 	git config --unset column.ui &&
 	cat >expect <<\EOF &&
   a/b/c
-- 
gitgitgadget

