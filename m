Return-Path: <SRS0=VMi1=BP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B490EC433DF
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89E6522B42
	for <git@archiver.kernel.org>; Wed,  5 Aug 2020 19:52:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkyXvsbG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729438AbgHETwk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Aug 2020 15:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgHEQut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Aug 2020 12:50:49 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA5C7C0A3BFD
        for <git@vger.kernel.org>; Wed,  5 Aug 2020 06:34:43 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a15so40714408wrh.10
        for <git@vger.kernel.org>; Wed, 05 Aug 2020 06:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=8qo/UduqfGZZ69wrhv8No4m5HunNDTQ7JOhdXAVzgEM=;
        b=UkyXvsbGKo4zKwut2yEuhmDFpX3XARvmW1M6CtppjHpiXSVGT20bg0pNGLfbTCxk/p
         JOAr1tqxKvDdjliImuib7drJN7m6qm328R+vwsTxWFOufy/fMPfMvV2UadNUXDaA3QEY
         v0ejoVGbixyqVbgEv2X059+PqLOwdYsV5LAzjsgJYvGHuE7PfODansRRcZyITf6tgd8W
         ZcFDwQQZhtxfVek24Y++V3cfP3eL75OYgIah6x37Adb9/mc0tpXxdsxb2qtRWLmM91HF
         mVjgpnMo6Q+vY745pSYZimB9orMyx1z0IrpEIa7+ivLu6mGPz92Xn3B4GFdyxOH4riTy
         9zDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=8qo/UduqfGZZ69wrhv8No4m5HunNDTQ7JOhdXAVzgEM=;
        b=mCGCgJFCPUXQFxUbKeI/0UT0Jjh+UX8OnL67pNteXc1ip+moPvkD0vY+La8DR8VUce
         dLMzNWbhdfq9HgY3W5Pos9JOCNMBCilcuKGO5zZfmesbEnz1KOM6p5NpsxojliH4yHoc
         nHUTAUcVQDulvU6TMqNyNRTy0SIVAu8iWVVR5XufmIxrvpF8eDl4Tfq0JP5V7Pba33DA
         C3XCOICTv6E7l63NmuKk4m7/4k5lHxaR622p/Y5CWjFYHqdpIaGzbmbcMKjPDr/1j2Is
         0/pbVeHqY6aWqiviHI8l0LcoOGK2Ae+XIIQheTjQSZR4CenjOhIhmiUWZLSv+k9zqrfC
         kuDw==
X-Gm-Message-State: AOAM5328xpeonVDFHNYNO18KA2or2pDDSXQ/vbcqbZDwQH7S5yYbCNry
        XrWdU6CRCrgd34iS3FnDVDKcOYWA
X-Google-Smtp-Source: ABdhPJxDd6j3Q6+FTCg1pyGGa8kd05Y6yxVuWUsbJTpS2wQ78K910q1ee0CIKA9qlCDTfErjg8zG1A==
X-Received: by 2002:adf:df89:: with SMTP id z9mr2825133wrl.395.1596634466977;
        Wed, 05 Aug 2020 06:34:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z7sm2778327wmk.6.2020.08.05.06.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2020 06:34:26 -0700 (PDT)
Message-Id: <fc0d2b103ec080fa38e5d51bf2205b7360c1b601.1596634463.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.693.git.1596634463.gitgitgadget@gmail.com>
References: <pull.693.git.1596634463.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 05 Aug 2020 13:34:22 +0000
Subject: [PATCH 2/3] mergetool-lib: keep a list of cross desktop merge tools
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Marco Trevisan <mail@3v1n0.net>,
        =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Marco=20Trevisan=20=28Trevi=C3=B1o=29?= <mail@3v1n0.net>

Instead of repeating the same tools multiple times, let's just keep them
in another variable and list them depending the current desktop

Signed-off-by: Marco Trevisan (Treviño) <mail@3v1n0.net>
---
 git-mergetool--lib.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index be28fe375f..243cd2b06b 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -288,11 +288,12 @@ list_merge_tool_candidates () {
 	fi
 	if test -n "$DISPLAY"
 	then
+		cross_desktop_tools="opendiff kdiff3 tkdiff xxdiff"
 		if is_desktop "GNOME"
 		then
-			tools="meld opendiff kdiff3 tkdiff xxdiff $tools"
+			tools="meld $cross_desktop_tools $tools"
 		else
-			tools="opendiff kdiff3 tkdiff xxdiff meld $tools"
+			tools="$cross_desktop_tools meld $tools"
 		fi
 		tools="$tools gvimdiff diffuse diffmerge ecmerge"
 		tools="$tools p4merge araxis bc codecompare"
-- 
gitgitgadget

