Return-Path: <SRS0=RPsp=7C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521DFC433DF
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3080F2081A
	for <git@archiver.kernel.org>; Wed, 20 May 2020 03:45:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RkQlVHA2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728615AbgETDpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 23:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728129AbgETDpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 23:45:09 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B37C061A0E
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:09 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q24so640956pjd.1
        for <git@vger.kernel.org>; Tue, 19 May 2020 20:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xMdLUne3XHENiU2rfcTZT69FVPManFDatvC6OhSlFEE=;
        b=RkQlVHA26kG9dPZMMe/tDrg8fFy15okTmQIkyH0FpBUgI2voED0WhphFXUDvHwV/QQ
         BDJZwm+g/8rEscxtwloOWQkRqIAW8xaSTGTweqwiE2//89HmfZIGLw6Cy18eg5r877Dt
         chnu8BrnomgLPUMoE3HaHJ2oau6TDztvfwTxq6JHpQooOV6Ei5bMfMlU9z9der8cnuky
         3d4mDiXMQr6po2DOEK5Nsr5ZfTuBxV9FNF2uJ3OUl7zyH3ZqXkBASSugs92MXlRO3B0B
         NGtpN7Uu906MY4EGfLJ022bShYw6NFwgzpMuVuBMIL57drrVuYt2uH41ZV293YIOqBfu
         VcgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xMdLUne3XHENiU2rfcTZT69FVPManFDatvC6OhSlFEE=;
        b=IzgiZXQHWYdljo0X4Co2jJGekVotp43j807O+TLji756Afx3Xf7WKon1VQHtWrB4f8
         tx4/s8mZTA1TQ1NkJvf/OTnwzivsw/WffgWdpd2Go5gerMnxBZjrrcDxFoPm6kGcqtMC
         fJ2mzIsqnRK2+MI1wn60cUFeV0rmrtzQPGeTuuCD+Xjc0TKkWnklyTDn5DAjHCnafzL3
         9/3P7H7rhXhw0ja//sFXuHY9Zaa8++dRaCJ8acEko8OqQY1d0ZgkDxKdwAg6ZK01txyR
         JgU31ktj5BUA9tHEGB9ZcV38spCszCwMXExipYjoX/WVVsxW/PmEtG98bDz2Rok2rfP4
         4Dkw==
X-Gm-Message-State: AOAM530u2GsyZ0XSuzD0X5284aYts4NANdInxooXNmkoVcNLfPJEw9cW
        7GFcjjGAafpe97icDcx7bSPIgII2
X-Google-Smtp-Source: ABdhPJyEjOdMrbiAnRmLOlz3Yz4mnO9kZ10GV52lhn0q0Xv71/PQ7DLNR6LhU94zDB/HEvIw99DGZg==
X-Received: by 2002:a17:902:ab8b:: with SMTP id f11mr2713351plr.145.1589946308409;
        Tue, 19 May 2020 20:45:08 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id h4sm762820pfo.3.2020.05.19.20.45.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 19 May 2020 20:45:08 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     liu.denton@gmail.com, chwarr@microsoft.com,
        garima.singh@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 3/3] t5520: avoid alternation in grep's BRE (not POSIX)
Date:   Tue, 19 May 2020 20:44:44 -0700
Message-Id: <20200520034444.47932-4-carenas@gmail.com>
X-Mailer: git-send-email 2.27.0.rc0.187.gede8c892b8
In-Reply-To: <20200520034444.47932-1-carenas@gmail.com>
References: <20200520034444.47932-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Instead of using a BRE, that broke tests 30-32, 37-39, 42 at least with
OpenBSD 6.7; use a simpler ERE.

Fixes: d9f15d37f1 (pull: pass --autostash to merge, 2020-04-07)
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5520-pull.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 37535d63a9..9fae07cdfa 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -28,7 +28,7 @@ test_pull_autostash_fail () {
 	echo dirty >new_file &&
 	git add new_file &&
 	test_must_fail git pull "$@" . copy 2>err &&
-	test_i18ngrep "\(uncommitted changes.\)\|\(overwritten by merge:\)" err
+	test_i18ngrep -E "uncommitted changes.|overwritten by merge:" err
 }
 
 test_expect_success setup '
-- 
2.27.0.rc0.187.gede8c892b8

