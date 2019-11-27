Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C37C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E138A20835
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 19:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ICjysmm8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727415AbfK0Tx4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 14:53:56 -0500
Received: from mail-pf1-f169.google.com ([209.85.210.169]:40779 "EHLO
        mail-pf1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727372AbfK0Txz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 14:53:55 -0500
Received: by mail-pf1-f169.google.com with SMTP id i187so7452476pfc.7
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 11:53:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5Hu/LIm/VDUQszegUkq9qsUTerKLJT8Ea6zTzzQS+Xs=;
        b=ICjysmm82uduerNofI7iluZEJlIil0GGV9AaIKxQQ1CCI7TZe85R9sRihMRI+nsZ5l
         ban1Z5vQPZnpV5KZggr1UHtMZ06zZlNIojz+A+Nmhbxgo1qTR2eUUn+wtoboNljbVwbM
         0FZKf3eKegtyfkcosnG0UeiUuSB+gI/hleZ28voEfJPJpCRX685WaV9mX98EQQERzrJA
         KpmCfFRcMG8BuLQCBKhZI0oCpPdqTGAFhJ71tqxHMe2p4/VVFn78puvqoUhUM9WMVFTe
         kh4BO7WxVzudZGZdu2upLIGsky2bJ7TM1hRJ8OdkXXt6c1D0syQ9VLoLe6fgsqncixVC
         z4ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5Hu/LIm/VDUQszegUkq9qsUTerKLJT8Ea6zTzzQS+Xs=;
        b=dy/dQg0xkMCcHrncg4/v/hbr1Uzu3LBe4jzQ43MXIpUQlyDPNVUAYGtg23NCDmhbmm
         8nq4GtsqcpA2oyFJOC8TXr0lvTI5xTDMuYNcL4s6MgMYngLdXBsCY8sOxCOyOtPZrx0q
         Xztip2o900rAVtwl+vFf5FiVFX/4lFqz81/XTHzG5RASMOTfTRzxuDL4hvKDXpVHynTk
         Mef45vzcOGOvHahqCPvHnMGH9y5iRuunmEx/42TdFYnTgn964OTIe4qq9STh8HA4G2vG
         7NUVNkoVM6owVKtu2gcFyFrXCluA6EZufNK+k2Zx+ZSJ9b0/ey0ORcVaQ1z71pqUfve8
         iEeQ==
X-Gm-Message-State: APjAAAWeXqCoh1w8iRg+xM3b1n0yRVPuQiI0hpvoQhCuXXAgEOMlLrtg
        kFyQJP+ahsbg1gEJghcpTLBlxRbg
X-Google-Smtp-Source: APXvYqx7KR1hHlSGAVJ3YoijSJvgiYLDidea9jW7IeDVDrI+ouvwAv3/lidkG4cFU5bbpsOIcl5MZg==
X-Received: by 2002:a62:ac06:: with SMTP id v6mr48189270pfe.210.1574884434090;
        Wed, 27 Nov 2019 11:53:54 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id e8sm17017607pgj.80.2019.11.27.11.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 11:53:53 -0800 (PST)
Date:   Wed, 27 Nov 2019 11:53:52 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v5 21/26] t7700: s/test -f/test_path_is_file/
Message-ID: <251de77677a9eda0d13c3f5668fa456ad4a52902.1574884302.git.liu.denton@gmail.com>
References: <cover.1574731022.git.liu.denton@gmail.com>
 <cover.1574884302.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1574884302.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since we have debugging-friendly alternatives to `test -f`, replace
instances of `test -f` with `test_path_is_file` so that if a command
ever fails, we get better debugging information.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t7700-repack.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7700-repack.sh b/t/t7700-repack.sh
index a96e876c4e..1d14ddcbdb 100755
--- a/t/t7700-repack.sh
+++ b/t/t7700-repack.sh
@@ -106,7 +106,7 @@ test_expect_success 'packed obs in alt ODB are repacked even when local repo is
 	mv .git/objects/pack/* alt_objects/pack &&
 	git repack -a &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -129,7 +129,7 @@ test_expect_success 'packed obs in alt ODB are repacked when local repo has pack
 	git repack &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
@@ -148,7 +148,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	for p in alt_objects/pack/*.pack
 	do
 		base_name=$(basename $p .pack) &&
-		if test -f alt_objects/pack/$base_name.keep
+		if test_path_is_file alt_objects/pack/$base_name.keep
 		then
 			rm alt_objects/pack/$base_name.keep
 		else
@@ -157,7 +157,7 @@ test_expect_success 'packed obs in alternate ODB kept pack are repacked' '
 	done &&
 	git repack -a -d &&
 	myidx=$(ls -1 .git/objects/pack/*.idx) &&
-	test -f "$myidx" &&
+	test_path_is_file "$myidx" &&
 	for p in alt_objects/pack/*.idx
 	do
 		git verify-pack -v $p | sed -n -e "/^[0-9a-f]\{40\}/p"
-- 
2.24.0.504.g3cd56eb17d

