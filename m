Return-Path: <SRS0=o5qA=2U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA4C2D0CE
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E1B720718
	for <git@archiver.kernel.org>; Mon, 30 Dec 2019 15:38:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KQwRZmmN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727634AbfL3Pim (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Dec 2019 10:38:42 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:32944 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727573AbfL3Pim (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Dec 2019 10:38:42 -0500
Received: by mail-ed1-f65.google.com with SMTP id r21so32900616edq.0
        for <git@vger.kernel.org>; Mon, 30 Dec 2019 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+/P6k4nV6O0kADLgcuI7flAuc5TiMcV6SX7jS8czaUA=;
        b=KQwRZmmNHRiT4syrXuMpVjTDNwZT3oKnCgzaGPJ5V5KQhH5nlprF8yKDstW38yFbEw
         WNDgfpHB38Lg3vUePBClVCtxnULx7LBOSCP0woOt2bVNCv40zYPE2vQayIZiEP96WwY+
         TOzNhvkTv1/cw1fXODihWypdPWuOcuGm0DUIbCt6ks+ZLmCyPkCU5VAFOyP/WmafGkvR
         khyOIPlFpx1uyCXh8QSZXwf+YCs6lmvfHaYngldjim2lK2ArCVJUzFbK5Xhs6+V4TS8s
         Fvq1+YUnKBYSNim8iQ+30r2deeJAyfHObjDllE5RHt+2N9EbB2OJo6+yFadf5H3am337
         hvzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+/P6k4nV6O0kADLgcuI7flAuc5TiMcV6SX7jS8czaUA=;
        b=GfcIhrr7EjHHZWAsdo92nNyiJXGpNEvK5WcSh4K8wcM5IJhO85oVcVE/FpUi+l6lOK
         mJrB9sSeevlxrt/df7Cyy6YDIXWh1+Bfz3+pPONmX34Abao1vpkFlc5VYj1UXMB/JxTQ
         Rh+8hwQFaG10PP6UYQ4pR5q7ss9q+b+mRZMQzAnkZ6gx0Cn8yzRESlp/g2ofCY4d9jKb
         y2o6U99tfMEF1gi9CnvArQFj/8BGTQkrP7Ct3tSgUO9hp42CkxqeXgtwVepzrrKB5QRF
         yn9x0cagwg3iZjoaAM8QNXKeGR+7hv+nuES794vSKQ0yVr2OE6xrEjGUNEyrLq4FPDQd
         Kuzg==
X-Gm-Message-State: APjAAAWNAJXpoKpvum9rCAZzMqU0tX5n3h6sU0NSKnPd3Y5L/gqVd3As
        D9SereAMSsVatL0dMTGClgR1Z4lI
X-Google-Smtp-Source: APXvYqzSyOtLd+rqSzmUIdZe2BlQ30Ab3fOxlPSW2TddMC2J/1ggsfCWzqKGFsYB/Ip8RE6FwmZpVQ==
X-Received: by 2002:a50:f982:: with SMTP id q2mr51797420edn.55.1577720319680;
        Mon, 30 Dec 2019 07:38:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f11sm3598882ejk.62.2019.12.30.07.38.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 30 Dec 2019 07:38:39 -0800 (PST)
Message-Id: <7a30d7ef0c556ddc743ae53afc871c26e800ce1f.1577720318.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.502.git.1577720318.gitgitgadget@gmail.com>
References: <pull.502.git.1577720318.gitgitgadget@gmail.com>
From:   "Alexandr Miloslavskiy via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 Dec 2019 15:38:38 +0000
Subject: [PATCH 1/1] t: add tests for error conditions with
 --pathspec-from-file
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>

Also move some old tests into the new tests: it doesn't seem reasonable
to have individual error condition tests.

Old test for `git commit` was corrected, previously it was instructed
to use stdin but wasn't provided with any stdin. While this works at
the moment, it's not exactly perfect.

Old tests for `git reset` were improved to test for a specific error
message.

Suggested-By: Phillip Wood <phillip.wood@dunelm.org.uk>
Signed-off-by: Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
---
 t/t2026-checkout-pathspec-file.sh | 17 +++++++++++++++++
 t/t2072-restore-pathspec-file.sh  | 18 ++++++++++++++++++
 t/t3704-add-pathspec-file.sh      | 25 +++++++++++++++++++++++++
 t/t7107-reset-pathspec-file.sh    | 30 +++++++++++++++++++++---------
 t/t7526-commit-pathspec-file.sh   | 27 ++++++++++++++++++++++++---
 5 files changed, 105 insertions(+), 12 deletions(-)

diff --git a/t/t2026-checkout-pathspec-file.sh b/t/t2026-checkout-pathspec-file.sh
index f62fd27440..0926312370 100755
--- a/t/t2026-checkout-pathspec-file.sh
+++ b/t/t2026-checkout-pathspec-file.sh
@@ -136,4 +136,21 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+
+	test_must_fail git checkout --pathspec-from-file=list --detach 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --detach" err &&
+
+	test_must_fail git checkout --pathspec-from-file=list --patch 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+
+	test_must_fail git checkout --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git checkout --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err
+'
+
 test_done
diff --git a/t/t2072-restore-pathspec-file.sh b/t/t2072-restore-pathspec-file.sh
index db58e83735..5c7abbbce3 100755
--- a/t/t2072-restore-pathspec-file.sh
+++ b/t/t2072-restore-pathspec-file.sh
@@ -136,4 +136,22 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git restore --pathspec-from-file=list --patch --source=HEAD^1 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+
+	test_must_fail git restore --pathspec-from-file=list --source=HEAD^1 -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git restore --pathspec-file-nul --source=HEAD^1 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	test_must_fail git restore --pathspec-from-file=empty_list --source=HEAD^1 2>err &&
+	test_i18ngrep -e "you must specify path(s) to restore" err
+'
+
 test_done
diff --git a/t/t3704-add-pathspec-file.sh b/t/t3704-add-pathspec-file.sh
index 3cfdb669b7..a1696e1a39 100755
--- a/t/t3704-add-pathspec-file.sh
+++ b/t/t3704-add-pathspec-file.sh
@@ -124,4 +124,29 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git add --pathspec-from-file=list --interactive 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git add --pathspec-from-file=list --patch 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git add --pathspec-from-file=list --edit 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --edit" err &&
+
+	test_must_fail git add --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git add --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	# This case succeeds, but still prints to stderr
+	git add --pathspec-from-file=empty_list 2>err &&
+	test_i18ngrep -e "Nothing specified, nothing added." err
+'
+
 test_done
diff --git a/t/t7107-reset-pathspec-file.sh b/t/t7107-reset-pathspec-file.sh
index 6b1a731fff..975a9a930a 100755
--- a/t/t7107-reset-pathspec-file.sh
+++ b/t/t7107-reset-pathspec-file.sh
@@ -128,15 +128,6 @@ test_expect_success 'quotes not compatible with --pathspec-file-nul' '
 	test_must_fail verify_expect
 '
 
-test_expect_success '--pathspec-from-file is not compatible with --soft or --hard' '
-	restore_checkpoint &&
-
-	git rm fileA.t &&
-	echo fileA.t >list &&
-	test_must_fail git reset --soft --pathspec-from-file=list &&
-	test_must_fail git reset --hard --pathspec-from-file=list
-'
-
 test_expect_success 'only touches what was listed' '
 	restore_checkpoint &&
 
@@ -152,4 +143,25 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
+test_expect_success 'error conditions' '
+	restore_checkpoint &&
+	echo fileA.t >list &&
+	git rm fileA.t &&
+
+	test_must_fail git reset --pathspec-from-file=list --patch 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --patch" err &&
+
+	test_must_fail git reset --pathspec-from-file=list -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git reset --pathspec-file-nul 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	test_must_fail git reset --soft --pathspec-from-file=list 2>err &&
+	test_i18ngrep -e "fatal: Cannot do soft reset with paths" err &&
+
+	test_must_fail git reset --hard --pathspec-from-file=list 2>err &&
+	test_i18ngrep -e "fatal: Cannot do hard reset with paths" err
+'
+
 test_done
diff --git a/t/t7526-commit-pathspec-file.sh b/t/t7526-commit-pathspec-file.sh
index 4b58901ed6..336197449f 100755
--- a/t/t7526-commit-pathspec-file.sh
+++ b/t/t7526-commit-pathspec-file.sh
@@ -127,10 +127,31 @@ test_expect_success 'only touches what was listed' '
 	verify_expect
 '
 
-test_expect_success '--pathspec-from-file and --all cannot be used together' '
+test_expect_success 'error conditions' '
 	restore_checkpoint &&
-	test_must_fail git commit --pathspec-from-file=- --all -m "Commit" 2>err &&
-	test_i18ngrep "[-]-pathspec-from-file with -a does not make sense" err
+	echo fileA.t >list &&
+	>empty_list &&
+
+	test_must_fail git commit --pathspec-from-file=list --interactive -m "Commit" 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=list --patch -m "Commit" 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with --interactive/--patch" err &&
+
+	test_must_fail git commit --pathspec-from-file=list --all -m "Commit" 2>err &&
+	test_i18ngrep -e "--pathspec-from-file with -a does not make sense" err &&
+
+	test_must_fail git commit --pathspec-from-file=list -m "Commit" -- fileA.t 2>err &&
+	test_i18ngrep -e "--pathspec-from-file is incompatible with pathspec arguments" err &&
+
+	test_must_fail git commit --pathspec-file-nul -m "Commit" 2>err &&
+	test_i18ngrep -e "--pathspec-file-nul requires --pathspec-from-file" err &&
+
+	test_must_fail git commit --pathspec-from-file=empty_list --include -m "Commit" 2>err &&
+	test_i18ngrep -e "No paths with --include/--only does not make sense." err &&
+
+	test_must_fail git commit --pathspec-from-file=empty_list --only -m "Commit" 2>err &&
+	test_i18ngrep -e "No paths with --include/--only does not make sense." err
 '
 
 test_done
-- 
gitgitgadget
