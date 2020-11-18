Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E2EAC63777
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D96F2246EA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnI5RQFE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727089AbgKROtO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:49:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKROtN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:49:13 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5308CC0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l1so2438159wrb.9
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9ClbEGP51hte3bm0dkdO9d3zCmtWg9VI6aNW22WM6T0=;
        b=KnI5RQFEmE8abLUYP4XKm+wz7Xv10PG0LMDT26c1c0aq9mmJzEYy0ImmvkolyQORlm
         CIWu3S/KGAT9/oMcN+JiVWaNm8ye3BqXZ2sf/uNOG/TXZOs1I/qqn3IVAGoydKYhhwY/
         1CQptPwwhVhkGMloNpYB11F6DtvHrQz9hFUlS8WR3K6xLkaYOUMv3O0Lv6q18VraEHKz
         Ly5XLPOkyTHc/5FtfpmrS8LH7MSGzr3mYsUSy67FGUDPbptykaSiCgL4TcQsPCMUHEif
         7yML06ijM+tM8iEVDYd7wSWNij3ywvywuunM2zkhRPgBwfoKgjSt3BsXFMlsTuwSfFDB
         oAyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9ClbEGP51hte3bm0dkdO9d3zCmtWg9VI6aNW22WM6T0=;
        b=qWT53NdtC7xon+BiXWUB6tQzSWP5xZYDjzgcPao9OimqlO5qOmqYLC1Bf1hhI+glsm
         J/BAyCZT+rvholr3307QybxDNK7dfPXiUbEOJXUl7blay1up3OLt0EspBuEgq7FxQwW3
         /W0+VZPpVOSdT/ra3mKTQcUjFFWj1HFhTPhqrxHXossZnHsXT6ef6ejAbx1YkQJfO0mw
         YvFmpE5Pvn7NQ2NshelNHXorjpylKUE+8TC6Mk06kWlTz5rAAOxFljRWmzVy+gC0Mgcp
         m14YC639qEF+UaXer9hZ/MO5B7Q3Q/vUpgrdfrUMce1dlOo7kO1aA9ZoxqHvLdTufemy
         aNhg==
X-Gm-Message-State: AOAM53303Vk9tv/qjUZER0d2lImz0d0mmtNOcHrHkALhNZTIX3r1Izex
        VuE/K5dWChDFEIPBmRFqqyyNm6Lr5kM=
X-Google-Smtp-Source: ABdhPJy0x3OQX/Drzrn5+1F9vgnumoTc1uLRyQtMXVPYn3Glvrb01/iHw960L/G9fOs6wa15IQedCw==
X-Received: by 2002:adf:9e4c:: with SMTP id v12mr5002077wre.22.1605710949990;
        Wed, 18 Nov 2020 06:49:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 60sm30761371wrs.69.2020.11.18.06.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:49:09 -0800 (PST)
Message-Id: <d477b02b5a3ca6d2beef5bdea21407a3c555f83e.1605710947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.792.git.1605710947.gitgitgadget@gmail.com>
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 14:49:06 +0000
Subject: [PATCH 2/3] t2106: make test independent of the current main branch
 name
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

We do have this wonderful shortcut `git checkout -` to go back to the
previous branch, thanks to the reflog.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2106-update-index-assume-unchanged.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index ff0947f388..3396f23363 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -20,7 +20,7 @@ test_expect_success 'do not switch branches with dirty file' '
 	git checkout other &&
 	echo dirt >file &&
 	git update-index --assume-unchanged file &&
-	test_must_fail git checkout master
+	test_must_fail git checkout -
 '
 
 test_done
-- 
gitgitgadget

