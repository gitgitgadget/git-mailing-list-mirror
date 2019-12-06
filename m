Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56B3C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B886B206DF
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 16:08:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPoSSFYL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbfLFQIf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 11:08:35 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:32869 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726284AbfLFQIe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 11:08:34 -0500
Received: by mail-wr1-f66.google.com with SMTP id b6so8400013wrq.0
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 08:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references:reply-to
         :mime-version:content-transfer-encoding;
        bh=jRHOwhRboHnHFU+uWN8bpu3Ve38iukMqNPqsvq2lXEc=;
        b=jPoSSFYLTqRC6QX6w7JT5/aFg0pjmb/utTcr3kSXhZbDDzQHQcPe+PkparPaBPqTFI
         j7EJQi6ZWkAQVOyvrLFmBgA+/udm4M1gHPOHJf5DfpU2Q1hYm6YZujYgaebN4wrITtJ2
         GwkmtndmIq181U68oeNi2i0sEf9tf2j1/hVxMkxEx2IGmgzyOvAGed10xyuIZ5emKX+Z
         oG79oZ6c+UawHKtMlKIF7vRzJorARnoK6cu64J8yODDOgZLs1nO4L0t7O8+Z1oVRs1mQ
         dKjlQmJvwl3cmlfjWDELmwF/2o/8VAB/LSv7nUimPPwmpI0Um5NUGWSYgvxY99mqVxuL
         wLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:reply-to:mime-version:content-transfer-encoding;
        bh=jRHOwhRboHnHFU+uWN8bpu3Ve38iukMqNPqsvq2lXEc=;
        b=UekAcsCXkWvMlV1iFwu5gGnsponhcFnjaopc+QQhSNuqNYP9AlbjVy4zZMXyZ7uF0M
         DFwzeHkd3xp/3u/T9MWq5uUef7WrkW6gntJCiHHb/oeyKuFi5hSBKS12H/4an1Thd33J
         lk/2dGWPRvp9YC3sOlUIAfR8iPmOezBw1xsTPcKLbFCdF521sAQvqxmoouiFPhGl423+
         07psIBdwNqqYnR7FzK4OHPWFZIoaShvVLjY6RgIjNnlJSs+DwphtvMqwSyYp9mgyRLLh
         dZSkqJknQigxc/NDVbrYQshBMPCv7y3W1psHA36B5ZlSF4djGwHGMWw6Lpv6Z7SfYByf
         iAgQ==
X-Gm-Message-State: APjAAAVUozAdgLiYoBydGxsiK4zL7OXBOMB1Uz5sqD3+f5gyzu3a7zr3
        WxmaWl7f9up8N6hoOeSdSaqb3sY8
X-Google-Smtp-Source: APXvYqwrjiJfhgO5AAe13qCSdXiW0BsR1m1xov9lb7RR13E+GUBFKrPy9Czd6+59+Z5SfcSg13Mk0g==
X-Received: by 2002:a5d:45c4:: with SMTP id b4mr16347624wrs.303.1575648512144;
        Fri, 06 Dec 2019 08:08:32 -0800 (PST)
Received: from localhost.localdomain (host-92-22-0-192.as13285.net. [92.22.0.192])
        by smtp.gmail.com with ESMTPSA id q15sm16649799wrr.11.2019.12.06.08.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2019 08:08:31 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v2 2/9] cherry-pick: add test for `--skip` advice in `git commit`
Date:   Fri,  6 Dec 2019 16:06:07 +0000
Message-Id: <20191206160614.631724-3-phillip.wood123@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191206160614.631724-1-phillip.wood123@gmail.com>
References: <pull.417.git.1571787022.gitgitgadget@gmail.com>
 <20191206160614.631724-1-phillip.wood123@gmail.com>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In dcb500dc16c (cherry-pick/revert: advise using --skip, 2019-07-02),
`git commit` learned to suggest to run `git cherry-pick --skip` when
trying to cherry-pick an empty patch, but that was never tested for.

Here is a test that verifies that a message is given to the user that
contains the correct invocation.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t3510-cherry-pick-sequence.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 793bcc7fe3..5b94fdaa67 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -123,7 +123,8 @@ test_expect_success 'revert --skip to skip commit' '
 test_expect_success 'skip "empty" commit' '
 	pristine_detach picked &&
 	test_commit dummy foo d &&
-	test_must_fail git cherry-pick anotherpick &&
+	test_must_fail git cherry-pick anotherpick 2>err &&
+	test_i18ngrep "git cherry-pick --skip" err &&
 	git cherry-pick --skip &&
 	test_cmp_rev dummy HEAD
 '
-- 
2.24.0

