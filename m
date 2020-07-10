Return-Path: <SRS0=TxkB=AV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC94C433E0
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206352078D
	for <git@archiver.kernel.org>; Fri, 10 Jul 2020 17:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V0w2x0JZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727976AbgGJRUB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jul 2020 13:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgGJRT6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jul 2020 13:19:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A76C08C5DD
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:58 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id f2so6704154wrp.7
        for <git@vger.kernel.org>; Fri, 10 Jul 2020 10:19:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RpRQyZ/r9Xnc+t+RGRXslDIcnmH8vlNORrhwafUBC+c=;
        b=V0w2x0JZOUNaELv9a3yiHWj1KvYoVDEv7Bjqd4iAAa/57i+4AgvXPYx1c4oaHuZuJt
         vmhLAKmcF2/Sp7pKRj2U8ce4BtavSeuRykxwNmDQWIrUsmleQp3pRZjs/SvWSHfgIbtQ
         r4Yyh4VJptq+SUPY+7S1sZOUkhXpK2aLgCLd5P9LsppRM/vZCE+R4snPEKtFdHeVPr01
         MKNOe3yewA1aw4lWgU3pFh8rYT+lOcZ7c1ij6s443pIZaEsEz5vd6r84B03RyjkxLqFx
         sghwRs654VyqD8+QIzDu05hiEjeAui2smZ5DWoOlx7TRxcDfmgpYprrSYrDRUSdFe1dY
         M+gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RpRQyZ/r9Xnc+t+RGRXslDIcnmH8vlNORrhwafUBC+c=;
        b=ZBLAV+2G50d/ybPgv1uwQaHR0lvBB6SBMkMN31gR0Qp14qAkg0U9YZ5G742+/F5j0u
         rc7EJ7X+UW0GyrbRJ6N2BFoEver0oguQackogximi0GfGgnpGA681RfWMFfDfap9ud+C
         E3Caz1s5cmdGpL49xJbWoUWhDXPm1RovkcAd48AwkMYE6Cn8BSHRYN8E6t9SOmNdzwBU
         /88DpTWym7fDSBcZzDCKiirp2ZyHCBzrzQLL7Z2iW7fJx3G5yzyqSIkzfMFhbLyczmFC
         rWPokUOZ8jCCLvMz035LVHOZ1hPfhmXM0e0Ub1IzUIp7OBzbUVSm/DE+Ee9ov+dtG3ip
         bRaA==
X-Gm-Message-State: AOAM532yZQqCAFqeGeo1+uiWLRlLW6Aud9M6BdtqxqL4wY6vvnaTE33e
        36F8AS4ntsvA5LL0Wp5p9EPfWofl
X-Google-Smtp-Source: ABdhPJyaRYspmPZpT22YD5HuhV31370cOmaavKS+JxZsnd4bxPLxnwFXc0zN5b3iivbK4T47ys7vog==
X-Received: by 2002:adf:fd46:: with SMTP id h6mr50090744wrs.105.1594401596788;
        Fri, 10 Jul 2020 10:19:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q4sm10136667wmc.1.2020.07.10.10.19.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 10:19:56 -0700 (PDT)
Message-Id: <123d246edf9e3e40c321cfaff81fe96ae3a0c015.1594401593.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
References: <pull.669.git.1593518738.gitgitgadget@gmail.com>
        <pull.669.v2.git.1594401593.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 10 Jul 2020 17:19:51 +0000
Subject: [PATCH v2 2/4] t3432: use git-reflog to inspect the reflog for HEAD
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
index 6f0452c0ea..a29eda87e9 100755
--- a/t/t3432-rebase-fast-forward.sh
+++ b/t/t3432-rebase-fast-forward.sh
@@ -60,15 +60,16 @@ test_rebase_same_head_ () {
 		fi &&
 		oldhead=\$(git rev-parse HEAD) &&
 		test_when_finished 'git reset --hard \$oldhead' &&
-		cp .git/logs/HEAD expect &&
+		git reflog HEAD >expect &&
 		git rebase$flag $* >stdout &&
+		git reflog HEAD >actual &&
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

