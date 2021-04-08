Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9F77C433ED
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78F9561001
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 13:34:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbhDHNew (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 09:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231566AbhDHNew (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 09:34:52 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328D8C061761
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 06:34:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w3so3094540ejc.4
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 06:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oKOPWpE2w/9EGTt9O5g6SSmd9060c/UmgzyutjoR9HY=;
        b=FEtZt+xQ4lfMdPgReBwKHMW3kGDvxgmtTwCsLdfn0OmL5gnTUJjSkoki6RQ8kcs1J+
         TcSrVjNoCP71p8Z6ys0r7pcQrbStExnJrdVWCBn6OuVhar/ZnFsfY3W07erFZPsJpvwx
         d9kH06t84yX8Df5I7fSRxkYbHMH1jm06exbJamkcEf/73k/ERH01W8rVHiywVnblXcTR
         qvkWVBHkr4kZ7BiFeexfVO2E0S73GocEFRB2iYj1cemDAFapaxbazznJDyuIbRhLQBdf
         PE8nPENwprxEQ/MWT5QCiV0ekajMWZxNC/lxxc1G1tHySarNw2KgG0zzv0iJbn2FC9Rc
         7NCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oKOPWpE2w/9EGTt9O5g6SSmd9060c/UmgzyutjoR9HY=;
        b=GYHKVy3QmCUEyTTg2pdwGZvck1ZlEpuhYz+UEw3VdxQQZwb2RqGXTrOz+ySWTWDGmj
         ZrM+ZY+Dbq7lDb2aOUo1cTAJdT8O8iotsHQBot6I2Wa4Eu89HjGz185FP+sZmMhO3X11
         jxKatYBnSuzd5eGqPZ2I8defqF/sIxVCKP18BSYC/tidBTKl3ji1gGylASA1jWLm38ot
         HM3uAr7jWxGprIv0jeNyAydHh9+FVr14TOUSw6kZsFnDUpg6SWN2x8ml9p9Hjllu/zQW
         cX5bsC5M+vuMK51YPoU0Mrgmdh42gXotf7rd1BmV9CVmDjI77PaGh/bSSI0gk/d5WK/B
         pl6w==
X-Gm-Message-State: AOAM531LTm/SmJ05tLUMoaQChucxTgmsFNvb6589SUAA7oBZG7gVbqkm
        c5ZsNZLeNjm4oKb2KdTw8UcnsQhpMsCTVg==
X-Google-Smtp-Source: ABdhPJxIcNCxqnBGxpJiuM/ipnV0sCV7c+/3ShFZ48MMZcmrYoKhabUPpPLfxxq93MGk+7MJ0LXPdw==
X-Received: by 2002:a17:907:921:: with SMTP id au1mr10072302ejc.386.1617888879683;
        Thu, 08 Apr 2021 06:34:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x24sm12441621edr.36.2021.04.08.06.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 06:34:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lin Sun <lin.sun@zoom.us>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, David Aguilar <davvid@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] config.c: add a comment about why value=NULL is true
Date:   Thu,  8 Apr 2021 15:34:25 +0200
Message-Id: <patch-1.6-bd70181ffb-20210408T133125Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.527.g9b8f7de2547
In-Reply-To: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210408T133125Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It's not very intuitive that git_parse_maybe_bool_text() would
consider NULL to be a true value. Add a small comment about it.

See a789ca70e7 (config: teach "git -c" to recognize an empty string,
2014-08-04) for the behavior of "git -c", but we'll end up here in
both the config file parsing and command-line parsing cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/config.c b/config.c
index 6428393a41..fc28dbd97c 100644
--- a/config.c
+++ b/config.c
@@ -1229,6 +1229,10 @@ ssize_t git_config_ssize_t(const char *name, const char *value)
 static int git_parse_maybe_bool_text(const char *value)
 {
 	if (!value)
+		/*
+		 * "[foo]\nbar\n" and "-c foo.bar" on the command-line
+		 * are true.
+		 */
 		return 1;
 	if (!*value)
 		return 0;
-- 
2.31.1.527.g9b8f7de2547

