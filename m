Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4285AC11F67
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB5A61403
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:47:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhGAOuX (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbhGAOuV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:21 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE12C061762
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:47:50 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l8so8543341wry.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=E+4P/UqyriY5nC/kbmhLD9YFCbmINoM2rwj8oEowo4w=;
        b=rMZqLeCNUGs7Fga70+QBs6WWy6nA+5E2hdkX7pEL40kxRj5jvmGI08vJv6be4lzQ1a
         HL+Bb8uRF2bHxyfB3b3fGPcaTuen8Q8oI2peCqzyEjQxkDOCNKk9Ggk+VHAOULrRx33T
         UmUEtoEw5Jw62J+8uLgB1NbRvkQeiXMF1Q6CBM1nqifWJmXtaVKYh/EbV+QEyt3fdWpr
         fxWsHPD12wOFqYNpfnBtMgM+ckCm9Vt7jZ4/eKgPZ+I+BjbgSoU89GyqBhMaxWyWJAVL
         MWgaMz1gGqN2vMw/Tg4u62TjhyOJdi6VTIa7mNNUbZNr9CKKOiM5ZTzYJsuGdY02IGLT
         Y5cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=E+4P/UqyriY5nC/kbmhLD9YFCbmINoM2rwj8oEowo4w=;
        b=jTngJz+LHj8nHr7UrCwXVjvRrkVc+03UabowlH71XCRErEnas/9/qmB127Jd3Rn5ks
         2J09UrdYfBQhISCqqMBKPkwJePJPuzVu0hQcCUjHJD7tOmUh3JQlk/aE16detsqvNTjs
         hm6vjYO7xQvhXcCpnc4GtDUNSwrIPkG2R2K5gKYcfMeiDXTx7uPTuIRmpfTnF4lV9O3B
         XL/7dcdhzxnuPMY+5JDOkIiLIqE8HYr0wowQDRaTPLAVq3klaAw7w6uiJRkSip5xE7V8
         xnEN/YSUahCIEuuBTdkMBYug5cu4/l1zTEcCGxeIp9eo9u+IfwgIp1Vg3OUZn+eTZ/Z8
         pZmg==
X-Gm-Message-State: AOAM532b+VFFApnbPprhrREt9PN17Zdp07b5nkzi9JdrJfe/vpQpvg4N
        fIxYyAIPy8BwVWLmwgNqfVNVPz0+M5E=
X-Google-Smtp-Source: ABdhPJzzYz9Sa9ipMnb8g42LS1n9fCmk82x34fnxj77nkK8YIqMtIfcQToHloQYF7jTRpz2mqVDnbw==
X-Received: by 2002:a5d:4f10:: with SMTP id c16mr5034wru.3.1625150868730;
        Thu, 01 Jul 2021 07:47:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t16sm10313880wmi.2.2021.07.01.07.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:47:48 -0700 (PDT)
Message-Id: <0aaca2f93908256b8d6385d321144dbd5cca813e.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:15 +0000
Subject: [PATCH v3 05/34] help: include fsmonitor--daemon feature flag in
 version info
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Add the "feature: fsmonitor--daemon" message to the output of
`git version --build-options`.

This allows users to know if the built-in fsmonitor feature is
supported on their platform.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 help.c        | 4 ++++
 t/test-lib.sh | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/help.c b/help.c
index 3c3bdec2135..e22ba1d246a 100644
--- a/help.c
+++ b/help.c
@@ -11,6 +11,7 @@
 #include "version.h"
 #include "refs.h"
 #include "parse-options.h"
+#include "fsmonitor-ipc.h"
 
 struct category_description {
 	uint32_t category;
@@ -664,6 +665,9 @@ void get_version_info(struct strbuf *buf, int show_build_options)
 		strbuf_addf(buf, "sizeof-size_t: %d\n", (int)sizeof(size_t));
 		strbuf_addf(buf, "shell-path: %s\n", SHELL_PATH);
 		/* NEEDSWORK: also save and output GIT-BUILD_OPTIONS? */
+
+		if (fsmonitor_ipc__is_supported())
+			strbuf_addstr(buf, "feature: fsmonitor--daemon\n");
 	}
 }
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index adaf03543e8..bfb7ff6ed17 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1674,3 +1674,9 @@ test_lazy_prereq REBASE_P '
 # Tests that verify the scheduler integration must set this locally
 # to avoid errors.
 GIT_TEST_MAINT_SCHEDULER="none:exit 1"
+
+# Does this platform support `git fsmonitor--daemon`
+#
+test_lazy_prereq FSMONITOR_DAEMON '
+	git version --build-options | grep "feature:" | grep "fsmonitor--daemon"
+'
-- 
gitgitgadget

