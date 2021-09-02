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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0429CC432BE
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF54B610A4
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346078AbhIBQCZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346068AbhIBQCY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:24 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7798EC061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 79-20020a1c0452000000b002e6cf79e572so1840717wme.1
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1r/Sx1tYCdPTm8SfL6TPtqQYj+vz+2NjwlOh67XSVLY=;
        b=Kc0p5GPZdIPbcGHpaz4nycXyUXCwBSGc3U/5avn3fYJFnUK48qTJqyl3ROwAuFqNU3
         jB6JeJjLdPrb2NxCy7MDL/Dq19QBhNiFk/cYiLC5LhkUc17kKEUcI8dbjxe33/eGVZxZ
         bQ8nKViaz5733dFxWvky2kbglmcDtVDo5L18W3+jpVLZFCLh3SAa0XAkBTy3t6XF/eGm
         XSWXrc6g3KozjdT33szOyGstnn4+Uxf78oCbhp2d1NpGNKrHAwB8+XSIsIG6Rv0Gevf8
         HNCE8UAiUdG0mqhgrVl3DF4RrPy3vdtParUVLCMZsbmET+GX5rITE6nXQSIZA5I21QMz
         bRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1r/Sx1tYCdPTm8SfL6TPtqQYj+vz+2NjwlOh67XSVLY=;
        b=qYUi3ApW0vC2DoAWtBORXHjrb2QgHj2NJ3pI4WKa8rTuc1tVTfxmbcrNPzWMPZElHw
         ha3lcDZDmlE8FrdbUpsvTbxl6s/7zLIJX00XkCOn2dAVcYzCnFIqFLmZRDGiGmSIZmhF
         D7EkRigVAuezX2EukOHplfBMXy7+ZLdWYWkW8XSASkkBdgMxC5ERaetRjDQGhMFYvtz9
         J3Hu5Bpy5OnywpfVQs07u2zlBy2oRWtkRv1o5FjTc17eUzdbTWYbuvUZ+vYEsU8XJHLC
         FqB5RthRLl++DD/sSaexfZaihdE78a9x75S3j/XqxR8+UDfDgKfMHka6knWvNOhbvsVw
         FZdQ==
X-Gm-Message-State: AOAM531ZqvAuSQDOhInoI1ND/vkbCNqd/huSXlzG12siW1FttEIigNHH
        A3sndKri/yDEGTlheixDQgVGcNtaWcmLzw==
X-Google-Smtp-Source: ABdhPJwJruxb5F6e/pUEEo0zTz4qU/Oz3yS6X0j/EYBTzs4mwoSR9WwYTmbS6btM5yKY1nDc5uxDRQ==
X-Received: by 2002:a7b:c855:: with SMTP id c21mr4003796wml.0.1630598483821;
        Thu, 02 Sep 2021 09:01:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/9] git-sh-setup: remove unused git_editor() function
Date:   Thu,  2 Sep 2021 18:01:09 +0200
Message-Id: <patch-2.9-7d3ea928099-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the git_editor() function last referenced in
49eb8d39c78 (Remove contrib/examples/*, 2018-03-25).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-sh-setup.txt | 5 -----
 git-sh-setup.sh                | 9 ---------
 2 files changed, 14 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 1ae15905492..2a28361cf66 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -40,11 +40,6 @@ die::
 usage::
 	die with the usage message.
 
-git_editor::
-	runs an editor of user's choice (GIT_EDITOR, core.editor, VISUAL or
-	EDITOR) on a given file, but error out if no editor is specified
-	and the terminal is dumb.
-
 is_bare_repository::
 	outputs `true` or `false` to the standard output stream
 	to indicate if the repository is a bare repository
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index ee6935ca455..cfedda79471 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -106,15 +106,6 @@ $LONG_USAGE")"
 	esac
 fi
 
-git_editor() {
-	if test -z "${GIT_EDITOR:+set}"
-	then
-		GIT_EDITOR="$(git var GIT_EDITOR)" || return $?
-	fi
-
-	eval "$GIT_EDITOR" '"$@"'
-}
-
 git_pager() {
 	if test -t 1
 	then
-- 
2.33.0.814.gb82868f05f3

