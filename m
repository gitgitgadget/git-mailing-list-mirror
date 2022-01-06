Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B800C433F5
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:35:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245161AbiAFWfH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:35:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245035AbiAFWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:04 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AD08C061201
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:35:04 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id h23so7649226wrc.1
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:35:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UiXm9eInVyCg4432H6ptlL5X2syI81wZa78/pW0JnFc=;
        b=h/OOTAWQwc9uiudkmV6+hMKHRWTXj4n/Di2UaK+k8MYXgZ0W+yc0nRW+d2zVnB23q+
         bZUZt0fo1Nsy/ehOCbG5iqvJDlmREWKX2DMEbm1Z7dBWImKbo+21WRh180uN/3VARN4R
         r+tk1fiZARN92ZkaaNPwxyJxRIJeCNhr0kFMryoDCm2HVduUhL7VzQBryIpMS8HQRPas
         32FA/eQyRXIfz0zPx7PbXZ3E8BWXlnLarr+QF4FySva3ciKug5ce/HMSMGWo2sz2K/3L
         fDuHKyhPs3YvYjaLsrmhxacysDDeYZYEPA9Ax124kfPDeLuTh7wO9t4jBEHoOCxoXa4p
         mEvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UiXm9eInVyCg4432H6ptlL5X2syI81wZa78/pW0JnFc=;
        b=ofdpjoWGaYa5NZ8DtKZgnFqwKUb76adPcY+Zm4Mcm2eOlIFm1gHKiiBaA52Pp+cBOO
         WhnjKI8G4b6KnupyOFzUNv9+QmUHdFJCYZgNkjZ1xZ2OGryF9zWgCLPPrFBqT/FuVCLU
         XjD4ULvU0CoDaLz9uwrudEf2Ec59pxCJYtT3veD8ntwOEj/8Ic4BfDD5eMZ7lDy+rCtn
         /bkLze4e4FG68r5LxDoY4VgzLyaCz6kr8o2J1bIs1W0x5YmID1p9OCG5lEVQwAYEONNt
         9HTilCmbtjRWi+bV0Fvy6Zoggqtetjt1JX36EiAt0IIqBFYQhRJwJ9TW6MOT5lZomWY6
         HW+w==
X-Gm-Message-State: AOAM531QgOS5kOazKOGYwz6FC5eOzzN6em8E23n1AY5//nDTpZ1R9QbD
        0N6BWdR9wMeumsIF4U0jn7G5OCf1YDU=
X-Google-Smtp-Source: ABdhPJz2icbawtovTqXHkhdh2r6FyQ7GPFhjVSlq60TZPegMePChVrqD7JsNuPARCeiaUOTNevSrNA==
X-Received: by 2002:a5d:64ad:: with SMTP id m13mr53212187wrp.714.1641508502790;
        Thu, 06 Jan 2022 14:35:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ba18sm3157014wrb.40.2022.01.06.14.35.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:35:02 -0800 (PST)
Message-Id: <4a6b18fb304cc3adda5cf219be11c29fd953e974.1641508499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 22:34:58 +0000
Subject: [PATCH v3 4/4] update-index: refresh should rewrite index in case of
 racy timestamps
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

'git update-index --refresh' and '--really-refresh' should force writing
of the index file if racy timestamps have been encountered, as
'git status' already does [1].

Note that calling 'git update-index --refresh' still does not guarantee
that there will be no more racy timestamps afterwards (the same holds
true for 'git status'):

- calling 'git update-index --refresh' immediately after touching and
  adding a file may still leave racy timestamps if all three operations
  occur within the racy-tolerance (usually 1 second unless USE_NSEC has
  been defined)

- calling 'git update-index --refresh' for timestamps which are set into
  the future will leave them racy

To guarantee that such racy timestamps will be resolved would require to
wait until the system clock has passed beyond these timestamps and only
then write the index file. Especially for future timestamps, this does
not seem feasible because of possibly long delays/hangs.

[1] https://lore.kernel.org/git/d3dd805c-7c1d-30a9-6574-a7bfcb7fc013@syntevo.com/

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 builtin/update-index.c               | 11 +++++
 cache.h                              |  1 +
 read-cache.c                         |  2 +-
 t/t2108-update-index-refresh-racy.sh | 64 ++++++++++++++++++++++++++++
 4 files changed, 77 insertions(+), 1 deletion(-)
 create mode 100755 t/t2108-update-index-refresh-racy.sh

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 187203e8bb5..7e0a0d9bf80 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -787,6 +787,17 @@ static int refresh(struct refresh_params *o, unsigned int flag)
 	setup_work_tree();
 	read_cache();
 	*o->has_errors |= refresh_cache(o->flags | flag);
+	if (has_racy_timestamp(&the_index)) {
+		/*
+		 * Even if nothing else has changed, updating the file
+		 * increases the chance that racy timestamps become
+		 * non-racy, helping future run-time performance.
+		 * We do that even in case of "errors" returned by
+		 * refresh_cache() as these are no actual errors.
+		 * cmd_status() does the same.
+		 */
+		active_cache_changed |= SOMETHING_CHANGED;
+	}
 	return 0;
 }
 
diff --git a/cache.h b/cache.h
index cfba463aa97..dd1932e2d0e 100644
--- a/cache.h
+++ b/cache.h
@@ -891,6 +891,7 @@ void *read_blob_data_from_index(struct index_state *, const char *, unsigned lon
 #define CE_MATCH_IGNORE_FSMONITOR 0X20
 int is_racy_timestamp(const struct index_state *istate,
 		      const struct cache_entry *ce);
+int has_racy_timestamp(struct index_state *istate);
 int ie_match_stat(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 int ie_modified(struct index_state *, const struct cache_entry *, struct stat *, unsigned int);
 
diff --git a/read-cache.c b/read-cache.c
index cbe73f14e5e..ed297635a33 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -2775,7 +2775,7 @@ static int repo_verify_index(struct repository *repo)
 	return verify_index_from(repo->index, repo->index_file);
 }
 
-static int has_racy_timestamp(struct index_state *istate)
+int has_racy_timestamp(struct index_state *istate)
 {
 	int entries = istate->cache_nr;
 	int i;
diff --git a/t/t2108-update-index-refresh-racy.sh b/t/t2108-update-index-refresh-racy.sh
new file mode 100755
index 00000000000..bc5f2886faf
--- /dev/null
+++ b/t/t2108-update-index-refresh-racy.sh
@@ -0,0 +1,64 @@
+#!/bin/sh
+
+test_description='update-index refresh tests related to racy timestamps'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+reset_files () {
+	echo content >file &&
+	echo content >other &&
+	test_set_magic_mtime file &&
+	test_set_magic_mtime other
+}
+
+update_assert_changed () {
+	test_set_magic_mtime .git/index &&
+	test_might_fail git update-index "$1" &&
+	! test_is_magic_mtime .git/index
+}
+
+test_expect_success 'setup' '
+	reset_files &&
+	# we are calling reset_files() a couple of times during tests;
+	# test-tool chmtime does not change the ctime; to not weaken
+	# or even break our tests, disable ctime-checks entirely
+	git config core.trustctime false &&
+	git add file other &&
+	git commit -m "initial import"
+'
+
+test_expect_success '--refresh has no racy timestamps to fix' '
+	reset_files &&
+	# set the index time far enough to the future;
+	# it must be at least 3 seconds for VFAT
+	test_set_magic_mtime .git/index +60 &&
+	git update-index --refresh &&
+	test_is_magic_mtime .git/index +60
+'
+
+test_expect_success '--refresh should fix racy timestamp' '
+	reset_files &&
+	update_assert_changed --refresh
+'
+
+test_expect_success '--really-refresh should fix racy timestamp' '
+	reset_files &&
+	update_assert_changed --really-refresh
+'
+
+test_expect_success '--refresh should fix racy timestamp if other file needs update' '
+	reset_files &&
+	echo content2 >other &&
+	test_set_magic_mtime other &&
+	update_assert_changed --refresh
+'
+
+test_expect_success '--refresh should fix racy timestamp if racy file needs update' '
+	reset_files &&
+	echo content2 >file &&
+	test_set_magic_mtime file &&
+	update_assert_changed --refresh
+'
+
+test_done
-- 
gitgitgadget
