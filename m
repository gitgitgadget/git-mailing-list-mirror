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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44748C433E9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F01A664EC9
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:37:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232938AbhBRMdK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbhBRLIm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:08:42 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4887FC0613D6
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:45 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id v15so2455864wrx.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0Y5376mYDkm0kfh0PTB6AfYnPRC65zjm/zdaq1SuyY=;
        b=XkdfqXR0j8ybWxaAead2Y1kYl6sHtGoTd9z2HKAxwwBukFxivMgtyTSLjkO6PVwxFF
         uZxLu3qvLgCQ67DzgeEOQ6Gjj/9QBDoY9dPOTAxR1KeALQLX7/MJEbZTxtHxZsDoa0Lu
         FKVYX7SCt4ih8CzokKRdYT2GA2LPJvi4S7jKJHJ+5yvGFWysechfx/umkeXZZnmqZxMB
         opgnphBKhpCaUF70e+/NTJteTYA4aUxFAFjx0MPNLBZ8BBO7YWO6lXmrsaXrbh5FBpRk
         xnWJ8aU5sON2Hz+XGN3TZx5W+g1TR/bf15bIAu94e8JGHcgjt66aubI8P2STXZTeLsWd
         dlLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0Y5376mYDkm0kfh0PTB6AfYnPRC65zjm/zdaq1SuyY=;
        b=i2zwYct+m2k6kz8AwFTbbJxCa1WH+0/o9N7+bpfQivOLrBXAUsudQ1kiDdD68Orapv
         jDqxI+doo4h5p2QfBgSiaUjcnQCwqCXrvYAblbpRkFhkix6DED3th8plZdgSJcIKkO0D
         YxxkBXhZinNZNxjp/cHrbWPhjsWLv036ry7i+X6HkBOSRC18UqFVxMX3wv+pQDTEn1Kr
         Ecx3BtzYPS3cCr3pz05R7xMdO1/Tu/4d2mavLwqXoyLwrwuJ16GvuC81vdow3NC83C3v
         f3ovZuoDG5kq8pImB3vlaNiFmCwSvWzWzZuRzNTUM/g/yNpzyyMfw/ySj+AoTR6x5qrA
         9mQA==
X-Gm-Message-State: AOAM530u03OqZop8krlXvbyIV3xhXq8WMlMEzpua3p8fZU+pYcPAgfKU
        LXSgTuHms4INhbIdumHF/4rE0V2AZTr9xg==
X-Google-Smtp-Source: ABdhPJzcURmJBRqjpCJ9WBhXnAQJMLYcIyUcCe6VyslCIFC+gwWz4AQxv3xyl1wWqt3co6C/p554FA==
X-Received: by 2002:adf:9dcc:: with SMTP id q12mr3658434wre.213.1613645923685;
        Thu, 18 Feb 2021 02:58:43 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:43 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] fsck.h: indent arguments to of fsck_set_msg_type
Date:   Thu, 18 Feb 2021 11:58:31 +0100
Message-Id: <20210218105840.11989-2-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index 423c467feb7..df0b64a2163 100644
--- a/fsck.h
+++ b/fsck.h
@@ -11,7 +11,7 @@ struct fsck_options;
 struct object;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type);
+		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
-- 
2.30.0.284.gd98b1dd5eaa7

