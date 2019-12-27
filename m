Return-Path: <SRS0=DNff=2R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F95C2D0DB
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7FA21582
	for <git@archiver.kernel.org>; Fri, 27 Dec 2019 13:47:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J0iT4Fsc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfL0Nru (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Dec 2019 08:47:50 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:36720 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfL0Nrq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Dec 2019 08:47:46 -0500
Received: by mail-qt1-f194.google.com with SMTP id q20so24595661qtp.3
        for <git@vger.kernel.org>; Fri, 27 Dec 2019 05:47:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=xJdgq7axgBtQxrUUYGy+Eua5jxEwrdmdIsn50nui39Q=;
        b=J0iT4Fsc9NPOZPr3DXzkN2TmmzH5zabobwGl8U96dk+JOFMVEvWaxR1Anqvmtn5oun
         dQeJRUvpaUGEmDn4ykWNK421uVdQgAntseIDWpdxPZhhzInuxbD59rDujf2JMP2/Ht73
         mz7jK5LcpZB4nVYfMjTi3vRs4g4wQWVVKDqfVFr5BW0jQgq8yy5VCM3G4rI7rdVDxm31
         gXrPDmNWvgP6kadS6mCL/uT5KSgoHIF3z8Wr+5b9TUzjilMp7/jiM3Y5XQUAUD3KVW+Y
         VAPZIBGmrGuSdsdEyhGleda8swO5H1NrFKxlISlfbZg6MYzKS//r4+YNPDZqGGvI3ulM
         3R4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xJdgq7axgBtQxrUUYGy+Eua5jxEwrdmdIsn50nui39Q=;
        b=Rc20Dg0yu5LtQxvMFWJnC9xanUNLrD2Uqhy66TQZWcpzOHQ2ISZNG7j1d6AeFvGDzh
         G05d+UTqzuUOe7bnyMOUlD9oL8YutF0kgkYNmbNh7mKWbzckl++v1DzyAAoIsank7wZS
         UBlXmoqLaSGDHwb2Pot2C9tfs6tgK+o+exue+f/u0Vy/Z+DgNMIvvsWfPH+PqWCUF/ie
         8XxgFfiBDKqgO/msoYW8ahhNXCKs40fGRvvpHJQBtfZIWS4zTCtgJfN303hcFEFC4Qv7
         vQHaHUhZtE7jwBLNlbKhKYaMbsuNbrmsFq5G4ePpBkeT8d4uw20ScYv0XDgCQnM78alo
         IGvg==
X-Gm-Message-State: APjAAAUp7xV8tyeF7cfYG1UHpxu+ffE3BqhNhhEmam9eLYzonfIMwIAR
        ZhXRSTn0Q6J/v0AGmIQaKZzY7qDi
X-Google-Smtp-Source: APXvYqy5xJIMQod8ImOFD/A3WKiq5g+/wCI3TgSxLrv5LLAxvmOUt0ZcyaqkFx76Mmq9+WBqw1732g==
X-Received: by 2002:ac8:1835:: with SMTP id q50mr36740936qtj.210.1577454465874;
        Fri, 27 Dec 2019 05:47:45 -0800 (PST)
Received: from archbookpro.localdomain (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id d9sm10510184qth.34.2019.12.27.05.47.44
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Dec 2019 05:47:45 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 12/16] t3504: don't use `test_must_fail test_cmp`
Date:   Fri, 27 Dec 2019 08:47:21 -0500
Message-Id: <b3e4f1698fd86f75f650c7928f2107ea0edd3600.1577454401.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.24.1.810.g65a2f617f4
In-Reply-To: <cover.1577454401.git.liu.denton@gmail.com>
References: <cover.1577454401.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_must_fail function should only be used for git commands since
we should assume that external commands work sanely. Since test_cmp() just
wraps an external command, replace `test_must_fail test_cmp` with
`! test_cmp`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t3504-cherry-pick-rerere.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3504-cherry-pick-rerere.sh b/t/t3504-cherry-pick-rerere.sh
index a267b2d144..c31141c471 100755
--- a/t/t3504-cherry-pick-rerere.sh
+++ b/t/t3504-cherry-pick-rerere.sh
@@ -95,7 +95,7 @@ test_expect_success 'cherry-pick --rerere-autoupdate more than once' '
 test_expect_success 'cherry-pick conflict without rerere' '
 	test_config rerere.enabled false &&
 	test_must_fail git cherry-pick master &&
-	test_must_fail test_cmp expect foo
+	! test_cmp expect foo
 '
 
 test_done
-- 
2.24.1.810.g65a2f617f4

