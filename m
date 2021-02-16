Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DF7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52E1564DA5
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 12:02:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbhBPMCT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 07:02:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230421AbhBPL7t (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 06:59:49 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C73AC0617A7
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:23 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m1so14224922wml.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2021 03:58:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hV8YKl0BO+QpJp/9Pnz+jmFrPVQaJFf0/6cS1rMjzJY=;
        b=fyo5UoV8qQ9qtbZgGVrwbTSamFt8p5c+u3RDFBvbr/N7DeVa8XkWziJRCWeV481Cmy
         7lHukUrV9SRJi/eJWEI7RQIpEvVu2EcsbqYzIcDPGUdw2e72XA+0PeYK8xCTmB7htoGC
         IjyNrHyxoC8ohp/Q0EtshwCGTNz9XyJVaItfDh+csecCfnE5XGxmRugIQeuhuNV3PmDH
         ncqZeEcBN16LdHjUvMw8CbjJ52nffDNpvUZWpHK9GihyXutpo0Dmor39fb7cyFcWPATo
         NIwfcrfYgALgBLzSgIlEMGDQp56azd5wAI21aQVgJ7K+pKFvsxWycrxFcB/cdJQb5D6d
         sS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hV8YKl0BO+QpJp/9Pnz+jmFrPVQaJFf0/6cS1rMjzJY=;
        b=ST6zm7GFzClZfQayy+gtXS5x3KMDCtiIrK4t3GVSn+aYDRq1fIu7D3Ca5vL5+T9IEQ
         hWK7VN9AYfoucaaa2a15cklFwz92Rd9j/UNhznEagAu4SEpSBSyk6/4RKs00QSGvpfdl
         okN4HyxzFdU0PUMWdeYSjhb3uGbIXzQuStmHJHPq738clPM4siuOmUUyZPz57gKAgfRH
         OVypbT5eT56LZT4vZZWU0kfahtU38E0Px4RZGpwFM11z0YFCCHb2Sc1cC9LmwrxTxQrr
         OvA9T+YI3MglLuJ19mYb3I5Y1S/xxzcMvvfuBqUUVw06/JbLfL6rpTM04whWj3GqgiLZ
         +NPg==
X-Gm-Message-State: AOAM532vH8avJVPPeycWL4Yq6T/UuN/c36oNPU8WM0Wo+ekm6owqoj0b
        jiXFNaNxugfrIzzACjr/4RtbikZFgDPNpA==
X-Google-Smtp-Source: ABdhPJyOIo+WLJ5AIMOw9jfKGJuVwaC0dfBi5mG5E+aNU7czQfMTfVdXI5dA1ALEARMY/eFC3Byvkw==
X-Received: by 2002:a1c:f604:: with SMTP id w4mr3120668wmc.39.1613476701885;
        Tue, 16 Feb 2021 03:58:21 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b2sm27968246wrv.73.2021.02.16.03.58.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Feb 2021 03:58:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/22] diff.h: move pickaxe fields together again
Date:   Tue, 16 Feb 2021 12:57:50 +0100
Message-Id: <20210216115801.4773-12-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210203032811.14979-1-avarab@gmail.com>
References: <20210203032811.14979-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the pickaxe and pickaxe_opts fields next to each other again. In
a past life they'd been on adjacent lines, but when they got moved
from a global variable to the diff_options struct in 6b5ee137e5 (Diff
clean-up., 2005-09-21) they got split apart.

That split made sense at the time, the "char*" and "int" (flags)
options were being grouped, but we've long since abandoned that
pattern in the diff_options struct, and now it makes more sense to
group these together again.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 diff.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/diff.h b/diff.h
index 8f0dc7ef43b..5f33e7e4f76 100644
--- a/diff.h
+++ b/diff.h
@@ -244,6 +244,7 @@ struct diff_options {
 	 * postimage of the diff_queue.
 	 */
 	const char *pickaxe;
+	unsigned pickaxe_opts;
 
 	/* -I<regex> */
 	regex_t **ignore_regex;
@@ -283,8 +284,6 @@ struct diff_options {
 	/* The output format used when `diff_flush()` is run. */
 	int output_format;
 
-	unsigned pickaxe_opts;
-
 	/* Affects the way detection logic for complete rewrites, renames and
 	 * copies.
 	 */
-- 
2.30.0.284.gd98b1dd5eaa7

