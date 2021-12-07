Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264C9C433FE
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240180AbhLGRtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240170AbhLGRtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:01 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BBE0C061746
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:31 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c4so31064229wrd.9
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=a7EgfAD1GeruV1R0AKwhqy5BFYsoslO+w/oz3dSC8GEvC5yjsSXUjWpGE4XxLIOLtJ
         IY0CfPn/mxTqjYCWDIygbppwgRjCIeTW+31W+XqMJpr5JLEaPkR8b3KmQnHxLUHCcgQ/
         cllDr/Ld2a8DO95GqnDs2pKBritrw1u9eRzJtP6wDFTZJT6j4dPtVO2Qzi9Szl2GnieR
         L5v6UxffpbruAqvt/NYgfA+ap+yrldT/mgz24XOsbXo6OcPmstWWsRTqCTG7BEnOi6VX
         U9/VyBrmxQ9QZ+/abYH2K3QXdg1EqpRSISMDA1LBG/7McHSZPFP8xGCFVufWYSatld/e
         Svnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=ebrRxVqBTAKKiIpJOzSblAnIfavbycUiALcWEzC6mWN7AEV++jlf6r3iO2ZvCqK61V
         N9hojFttJxo0PSUJABlvVvXB/wKspstswf8jfoIL0GhaPJXXvRTPNuIePHEUotL+nfSc
         1IRMRMAo8sGd78OSAeeP1ln9hYRhF/os4GgQEbNGte4bhSc2gZTmBMZ2nr6I+TOVcxvW
         AwcRXO487oAsKt9ztHeHCz05AokaIsjuFJdJgW+1igCgwIzDcx8oKmnU0JjuUKXG88SJ
         Dxm/96t5tb5KuC8yUpIdnwA0mRudZgyZNwinXHUv4XPlJ4zW2i7bWBLV0tBVfhCaSh8B
         9USg==
X-Gm-Message-State: AOAM532PBBmVlLJf0kLUSl8kyjuJZbZ0FJVhetvLJZIN/PYZy7c8hUnn
        uzz7gmHokQIQHBNPCh+eZLIIakkQ9lw=
X-Google-Smtp-Source: ABdhPJwl9uVFKu/68YOXGJn4ZyZrtXwQlE+CzKbS89WKcEGD0DiJUDg7roA+uggSTz2vhImJ9OaIgg==
X-Received: by 2002:adf:cc91:: with SMTP id p17mr53163373wrj.589.1638899129503;
        Tue, 07 Dec 2021 09:45:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k37sm273699wms.21.2021.12.07.09.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:29 -0800 (PST)
Message-Id: <9269977a1c3c2654afbc6ae18e9bb442fbc7968a.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:19 +0000
Subject: [PATCH 05/10] reftable: ignore remove() return value in stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d628420e63a..4b7292945c3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -89,7 +89,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

