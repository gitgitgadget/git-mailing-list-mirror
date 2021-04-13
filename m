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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE31CC433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5355613B6
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 09:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236736AbhDMJJE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 05:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbhDMJIz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 05:08:55 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDE84C06175F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:33 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id m3so18514343edv.5
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 02:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMOrHyxOs59oX83kcUuH3Jx8H2gUPvDlypaOfNOkQic=;
        b=vQSyE0bfSrBZFKOwfuTJVg2+QaVkIYgo0gdEY490oayp2tCark40MDNrEBu6Pye4+7
         19ql2rj+fgfZOA8My4450mY9nKwV6jpLFggtUUIt23Juh4eJy+xhzrSUIYfswfgpn6ur
         0ixCSeQZ4oZxCxLc02uQye2lsR+LDArUvRf8n9WSpZ+YBNCFx0c6KLsdsG9jZ8lfnwMG
         S2ptuD6T/KJ83z4Ey59MO7+dlHMtG3MuhP+m2iMFC46du0k8fsWUfool21GtsmPoWx0u
         r0PFyD5f1dAt4+mv1KLvKWPRzlcVR++nvmin64jZQOWPOVPCTFblEQiHLVbeFaNXyTNm
         yW+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMOrHyxOs59oX83kcUuH3Jx8H2gUPvDlypaOfNOkQic=;
        b=qH+oG7/00FzZYUFFb8kMdzfckVuIfHmwXQYBxU3pUrpPxm4TApfKQPvnOsughZyago
         bXhR/+Eha5U41Yi9FEpWH/OHWGhP8BeTDYIjDOiqUzwT5i0P82Gxdlg1HKiEvWFywuDg
         It9JAAzVe9Ip1cxK2e4LaV9pu/4pvoyLSI02qCIS1dUdjur2I/2/j+JIIIennOKffYtl
         JXqZ3P7o91/P7cxFkGn00wRTgLawwltjsI9TFSnpVnl01bXZSB+G93wll8FSVMJOKD5y
         ZHw+I9e8MGTvDzWQ96BKuAPMv9pBBTF0tP5Qdbydvcwz2NUmI6KaHJXXyRyUA9bd3tVr
         8K5w==
X-Gm-Message-State: AOAM5315xHnHxnY9DD05F2zj2kgEkp73u7ah48GC6E8wCLkPO+PzETkU
        SPvityCpWLrKkXusPnUDSRBF7ACAk7L9wQ==
X-Google-Smtp-Source: ABdhPJziWFQ1E8lNzpyHFTQdXzE//F3vET8Mii9Li89v7acqF7v+0k388/7OuavWMx9cv67ZNybdpg==
X-Received: by 2002:a50:aad9:: with SMTP id r25mr34053106edc.125.1618304912033;
        Tue, 13 Apr 2021 02:08:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 28sm8918318edw.82.2021.04.13.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:08:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] api docs: document BUG() in api-error-handling.txt
Date:   Tue, 13 Apr 2021 11:08:20 +0200
Message-Id: <patch-2.3-ce78c79c9ac-20210413T090603Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.645.g989d83ea6a6
In-Reply-To: <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210328T022343Z-avarab@gmail.com> <cover-0.3-00000000000-20210413T090603Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the BUG() function was added in d8193743e08 (usage.c: add BUG()
function, 2017-05-12) these docs added in 1f23cfe0ef5 (doc: document
error handling functions and conventions, 2014-12-03) were not
updated. Let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/technical/api-error-handling.txt | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-error-handling.txt b/Documentation/technical/api-error-handling.txt
index ceeedd485c9..71486abb2f0 100644
--- a/Documentation/technical/api-error-handling.txt
+++ b/Documentation/technical/api-error-handling.txt
@@ -1,8 +1,11 @@
 Error reporting in git
 ======================
 
-`die`, `usage`, `error`, and `warning` report errors of various
-kinds.
+`BUG`, `die`, `usage`, `error`, and `warning` report errors of
+various kinds.
+
+- `BUG` is for failed internal assertions that should never happen,
+  i.e. a bug in git itself.
 
 - `die` is for fatal application errors.  It prints a message to
   the user and exits with status 128.
-- 
2.31.1.645.g989d83ea6a6

