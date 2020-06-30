Return-Path: <SRS0=HTZL=AL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BEECC433E2
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E021A2078B
	for <git@archiver.kernel.org>; Tue, 30 Jun 2020 12:05:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoZJbT8B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732527AbgF3MFp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Jun 2020 08:05:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726875AbgF3MFm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jun 2020 08:05:42 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C87C061755
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:42 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id e15so15928503edr.2
        for <git@vger.kernel.org>; Tue, 30 Jun 2020 05:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6rkMjcy9NJU9ZIgbgl1YRLSMVdS03FMU3SmL7fuVvRo=;
        b=AoZJbT8BXmI3ocgw7XkmBotuWE7LiK2cMkfTg4e/g5gUyw5dU/3uWF+b1AhWQr0CYM
         0lkd17k72c0zDJ5TWcu/WzJC6WeWslLHXRZK0B9tyDqM5LEJc0I4yAMhGot/YOtOMvIs
         jbYseosR7Jw7fk50Gl2JNhKbzgvAi5Ce4aIq1exc2IUeNcpggdzqSGTrq1AL3Q4T1h6E
         y/fZKu0Iq0FraIU+hj4iOp3hohtjManDAlF4Yn4tGBmHTKbQ/R31UfVpni6KE64vAm7t
         kXhX23CXmYk43/L6ZIMUgg4Uz/9J/GXRScZASWafHCygzhdvjF9D11vHVYW5Tbiw4N3P
         /mVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6rkMjcy9NJU9ZIgbgl1YRLSMVdS03FMU3SmL7fuVvRo=;
        b=G0O7n/NpAfN2YmKhLi00WyX1UGDJxYWhLAghb/wpfbrBr9WtHDQ0DpO9E8nWVGb0mk
         mJ5eZPJCGKh6IyC/1vc7fp9A/IQdEv4Lzg6toFutltskRlPaih5ye8mt9aSgGARB7iwm
         0K68IO8rITghAVpqbxDzSM+1fDWkbI68Cf5tKo6Gbm5hXYSA6+MXK6jJAlq65klV38xW
         XEl8kCdhDx38EgSoGgQVFPI2LEnTiqetcyNjOESWgjHK/hMZlD/W9VnEbY0N/RCcEPf2
         k0LN1maSoi+EolFNJQonSWzRRuBHz0uNT05Wo9Fu0hkNXFVN0NFZOk3Gpn0gVTPYfd+d
         bdcg==
X-Gm-Message-State: AOAM530NRpgy7Uuh4p+Vwt8cUodCKHlNPREzD/b+y7TVbNYz8KLegApe
        wvqvkQAQeFntbIWbzL7DfB+yoTFjvLM=
X-Google-Smtp-Source: ABdhPJw2w7KxwEGy7TBHx47ltNXpjZGWVszMvObsrKs/NicdqZq8rEYeChHX0jHQDoch/D771oEmig==
X-Received: by 2002:aa7:dad6:: with SMTP id x22mr11451186eds.310.1593518741103;
        Tue, 30 Jun 2020 05:05:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k23sm1848860ejo.120.2020.06.30.05.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 05:05:40 -0700 (PDT)
Message-Id: <f238d1d7f8b59832eda48e47188479a2230a5927.1593518738.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.git.1593518738.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 30 Jun 2020 12:05:36 +0000
Subject: [PATCH 2/4] t3432: use git-reflog to inspect the reflog for HEAD
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t3432-rebase-fast-forward.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3432-rebase-fast-forward.sh b/t/t3432-rebase-fast-forward.sh
index 6f0452c0ea..22afeb8ccd 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -60,15 +60,16 @@ test_rebase_same_head_ () {
 		fi &&
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		cp .git/logs/HEAD expect &&
+		git reflog HEAD > expect &&
 		git rebase$flag $* >stdout &&
+		git reflog HEAD > actual &&
 		if test $what = work
 		then
 			old=\$(wc -l <expect) &&
-			test_line_count '-gt' \$old .git/logs/HEAD
+			test_line_count '-gt' \$old actual
 		elif test $what = noop
 		then
-			test_cmp expect .git/logs/HEAD
+			test_cmp expect actual
 		fi &&
 		newhead=\$(git rev-parse HEAD) &&
 		if test $cmp = same
-- 
gitgitgadget

