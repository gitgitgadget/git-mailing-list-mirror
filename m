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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DAE6C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AEE061222
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243988AbhDLRQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243980AbhDLRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:16:01 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32128C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h4so4702408wrt.12
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u7has5A8bd2EYTrNLXyglJZzMXo17DIqwIuKC8/fYOk=;
        b=KZ62gCSSCspr+UgxGd0IpwddLDlx2QvHFrbSDzDwoZLeJsQOCuRGkFU5JiXHmKRbzZ
         h44N1rCmU6wwh+20RUAcZK1PmXdwyn7+9sPlhK9qRmCmI1mH7UDmx/y1z75VylfUk+kg
         PN0FFsq+PwDIGDbcw8XcYAoladSGf7NjUiVw2d3GfgzP0xgXnbxq6V22nELIOl3hGep1
         pC9dIfWbiYWEFJdXWhfeJF5Edoju6uOWcPJ5OTTmYpwuw51zQrhHMIX04q3rwlcfnZ+E
         VzchzsvGEIOInmtZ1iMC5lOA5ktCjwcWJ1cipR45c42nHnz0OTQDMBqxlXjPglVCho3l
         HRHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u7has5A8bd2EYTrNLXyglJZzMXo17DIqwIuKC8/fYOk=;
        b=CC+0TJ8uQnBSRfh7CkrszGozN6hIUf3cKwsd1QFbBi17FCa0+BvvpZocnNzetG4RR5
         UbDmo25al0O8V3Qks8TlVIzgjBNxJssa6aQXOkI7ACEFZ/hBNW5GA8hOPcOX9m3nWRzu
         u43PdrB+u49doEzAeQIkO8wf6P5a0lI4zfEEnMVSiAxz7/YfznU+BwwKd0LnLM1tfsAB
         0hEQcPUa2jkSKNrUYzVY7de+W18EBT6VPhKhqU0+aPAsEi48Gsc0jsm9Nf/iZQq1zGsB
         OzgEdxrJ7DIaiBOJMEkgWIIyWK55+MxrLk+wlOPvCDsD/YStB1lRz5m9QHrDp5dGDUCs
         Wjdg==
X-Gm-Message-State: AOAM532lc9H4JD5FaWpkTVXQglq1pTSzHRYZb1J4Lo2XQP4slOs6DBRI
        cyog92R9qI7GqOebZYP663YI/ouChxc/eA==
X-Google-Smtp-Source: ABdhPJyj5xkHMGf9xuGPTRH2awnxpJZmV1xHzYYXjg1xrVPgGuCtauLFiEBI4n5ITIwjQ5OejHFPEg==
X-Received: by 2002:a5d:4579:: with SMTP id a25mr24121516wrc.160.1618247741755;
        Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/22] pickaxe tests: test for -G, -S and --find-object incompatibility
Date:   Mon, 12 Apr 2021 19:15:12 +0200
Message-Id: <patch-05.22-0c4657189a8-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the options sanity check added in 5e505257f2 (diff:
properly error out when combining multiple pickaxe options,
2018-01-04).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4209-log-pickaxe.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
index 9fa770b5fbd..21e22af1e7e 100755
--- a/t/t4209-log-pickaxe.sh
+++ b/t/t4209-log-pickaxe.sh
@@ -55,6 +55,17 @@ test_expect_success setup '
 	git rev-parse --verify HEAD >expect_second
 '
 
+test_expect_success 'usage' '
+	test_expect_code 128 git log -Gregex -Sstring 2>err &&
+	grep "mutually exclusive" err &&
+
+	test_expect_code 128 git log -Gregex --find-object=HEAD 2>err &&
+	grep "mutually exclusive" err &&
+
+	test_expect_code 128 git log -Sstring --find-object=HEAD 2>err &&
+	grep "mutually exclusive" err
+'
+
 test_log	expect_initial	--grep initial
 test_log	expect_nomatch	--grep InItial
 test_log_icase	expect_initial	--grep InItial
-- 
2.31.1.639.g3d04783866f

