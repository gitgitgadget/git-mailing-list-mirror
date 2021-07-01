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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 439E2C11F6A
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26F076141D
	for <git@archiver.kernel.org>; Thu,  1 Jul 2021 14:48:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233449AbhGAOu6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Jul 2021 10:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233119AbhGAOuj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jul 2021 10:50:39 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0076C0613E2
        for <git@vger.kernel.org>; Thu,  1 Jul 2021 07:48:07 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l8so8544611wry.13
        for <git@vger.kernel.org>; Thu, 01 Jul 2021 07:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5/sMXoHyGg+3j8jh501vy22q2NIOR4Of40K9vWI1fSY=;
        b=oEU3GiNd+YmSC8nU1094l8MkH9kLX4rj6rZxI+eA8OA00DIeiFI1SE+NPJgf0p9Pcx
         g2R+36AaWBZ+HhtXY1kEHs+Snu5EgXpJOGw6GpPustWpAaer0Cz8AgpquMeJ98sLPY9y
         DoOVtOsZkWGkNVf2BQdSKra6/zDZ/HfrT8YLbVmVXu6PxDFyLtg6UtNlMd0SkO0y2FvL
         X2SCWLh0Le6JV4+PoC/Zto+ChlipmYgswDz5xkkdcpatR0Y9fffDJK1IjGM515wD58C1
         041/uXdUyGCpmhxTe89e7aSlVuM6peJ+MGy+sGyAqQh/0qG6Sa4PasvL+cJ+nE3ja5pS
         cspg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5/sMXoHyGg+3j8jh501vy22q2NIOR4Of40K9vWI1fSY=;
        b=CGJnaA45DSkw/KeDUFBS+Ml1Vkh/bGlYoD0CnEpsDNSZbymB5695TuSdDI+mizEzMZ
         slVwBG+X1N4EwToa4i0S0f/7HIGd6SgKEmowVnGCw/sEYzgm7x/wx8OrjFiFcdrMZ/Z0
         f6wUn36+ySmaALGYmS1Ej7qVkf/PQzmpUPwff293j3q7r8Z3nPwVznQwoP9D41aZdMdD
         ZE5kFKAZhFYT3HZ7BYdmwS/Iem8qk5yAJqOrBOLnE8EoAC0nDkV+YiceTIB6DUOcIR5K
         Ul6o5nt9mflF18uuMcJke3HEr6wQdEV9vX3ZJjzGsU6W2iuhA7DpsY+/Nh3C5ipUmavQ
         2F3Q==
X-Gm-Message-State: AOAM530f7hercwyrSHWHrGMpBHEuTpuDwoiAcEtSFg36y7nI0iwNJhu7
        5iTcpmHF21mv1jfbRw0kI9DXrDk8OHc=
X-Google-Smtp-Source: ABdhPJyP9Gs79IBdV5qj/HtNQom36Yu1+5ols2wk4w8oENAJemlaiKJfcZ9ultv4nJgRNmYd2U+M4Q==
X-Received: by 2002:a5d:4003:: with SMTP id n3mr21579372wrp.147.1625150886480;
        Thu, 01 Jul 2021 07:48:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm136510wru.78.2021.07.01.07.48.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Jul 2021 07:48:06 -0700 (PDT)
Message-Id: <627e27fe60bb543902fdcc4b2179c620403d9c38.1625150864.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
        <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
From:   "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Jul 2021 14:47:44 +0000
Subject: [PATCH v3 34/34] t7527: test FS event reporing on MacOS WRT case and
 Unicode
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

Confirm that MacOS FS events are reported with a normalized spelling.

APFS (and/or HFS+) is case-insensitive.  This means that case-independent
lookups ( [ -d .git ] and [ -d .GIT ] ) should both succeed.  But that
doesn't tell us how FS events are reported if we try "rm -rf .git" versus
"rm -rf .GIT".  Are the events reported using the on-disk spelling of the
pathname or in the spelling used by the command.

NEEDSWORK: I was only able to test case.  It would be nice to add tests
that use different Unicode spellings/normalizations and understand the
differences between APFS and HFS+ in this area.  We should confirm that
the spelling of the workdir paths that the daemon sends to clients are
always properly normalized.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 t/t7527-builtin-fsmonitor.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t7527-builtin-fsmonitor.sh b/t/t7527-builtin-fsmonitor.sh
index b166b4a0a31..d2ff1bf6c49 100755
--- a/t/t7527-builtin-fsmonitor.sh
+++ b/t/t7527-builtin-fsmonitor.sh
@@ -178,6 +178,36 @@ test_expect_success MINGW,SHORTNAMES 'implicit daemon stop (rename GIT~2)' '
 	test_must_fail git -C test_implicit_1s2 fsmonitor--daemon status
 '
 
+# Confirm that MacOS hides all of the Unicode normalization and/or
+# case folding from the FS events.  That is, are the pathnames in the
+# FS events reported using the spelling on the disk or in the spelling
+# used by the other process.
+#
+# Note that we assume that the filesystem is set to case insensitive.
+#
+# NEEDSWORK: APFS handles Unicode and Unicode normalization
+# differently than HFS+.  I only have an APFS partition, so
+# more testing here would be helpful.
+#
+
+# Rename .git using alternate spelling and confirm that the daemon
+# sees the event using the correct spelling and shutdown.
+test_expect_success UTF8_NFD_TO_NFC 'MacOS event spelling (rename .GIT)' '
+	test_when_finished "stop_daemon_delete_repo test_apfs" &&
+
+	git init test_apfs &&
+	start_daemon test_apfs &&
+
+	[ -d test_apfs/.git ] &&
+	[ -d test_apfs/.GIT ] &&
+
+	mv test_apfs/.GIT test_apfs/.FOO &&
+	sleep 1 &&
+	mv test_apfs/.FOO test_apfs/.git &&
+
+	test_must_fail git -C test_apfs fsmonitor--daemon status
+'
+
 test_expect_success 'cannot start multiple daemons' '
 	test_when_finished "stop_daemon_delete_repo test_multiple" &&
 
-- 
gitgitgadget
