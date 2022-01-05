Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5A77C433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 13:15:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237003AbiAENPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 08:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236981AbiAENP3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 08:15:29 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E7AC061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 05:15:28 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id r17so82927226wrc.3
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 05:15:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=peAPTKJRdthO7KyOudidcwv/ja3m2FONYcE3rWGwknk=;
        b=Pw+q8QgH12iGMs7wIhBuTp7A3WU1ywU9F5IpwCUzkgTpFrFmSHyX/N95pYyzz6Omh3
         kHQoptSIjUuisNaNdEDfyc2lsrzhsbxKwIrAFprmtupOYFxQYJUbAE3Mk2mtWqAPZiT3
         inhhW/VkAJDI1Idw1TuW669BKGr552UuRtwDspoib1tXMm0955IlGExyTnUiiyQydfrJ
         gn9OR8c4OumF3cUE1O6x9id8s2hfU1Fs6crDlB1QXqBpftSuvL15pAt+bkLiDhi6Jq9j
         X8CmwGrFnmpMAqh1AopQhCMIeeybWu82rM7xef7DGujfkm798z6KwfB7uaCYcxLEEIIg
         iGXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=peAPTKJRdthO7KyOudidcwv/ja3m2FONYcE3rWGwknk=;
        b=TaZt8FawEo+OTnq41yCaKtMNrKLKhx1yUThkQrx42EuG4wz5BpYJbETC4xlxofLmoN
         J9xYm1qNZ7lNBBGTkCo5NrFM99MAeNiPaSgNWjDuAZYz1w4G74QNc1I3aDA5zuHv6M28
         dLnnEvODdUxojGy3tMquRM99vrtL0UyX52vp5OBus5P6Fv47GWGQdfCeqwDVEBPqRlNt
         7RGdeQfx8o9qt0m7EJDWa8/jgciQfyTSy4Jj7HGdh8EMq13yIvsNBcMbfA9EpRkyd/lp
         Me+pLHdqVuit8arCgA7AlX/Cac/NjgbGak9AdEEYizeCa6W114E0MarIlpw39sx7HlZD
         7hGA==
X-Gm-Message-State: AOAM532lIAAD9riQ6TWg70BjeIWymGj8DmUNWeu6TgPw4vKFYTUC3fXB
        AG4+6ZaetoR4PA7Rd/xWZugG1fXeOvY=
X-Google-Smtp-Source: ABdhPJyvpuFylsk+qD8cx+RZt7AcDTZCgvSQFx1Nd6wl2JSZwFT1yPgit5fJBXoSFWeGvvqUs0wfgQ==
X-Received: by 2002:a5d:404a:: with SMTP id w10mr47878497wrp.573.1641388526646;
        Wed, 05 Jan 2022 05:15:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p15sm2487592wmj.46.2022.01.05.05.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jan 2022 05:15:26 -0800 (PST)
Message-Id: <dfeabf6af15dfab06bde1ec7dcc2d0576497be9b.1641388523.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
References: <pull.1105.git.1640181390841.gitgitgadget@gmail.com>
        <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 05 Jan 2022 13:15:23 +0000
Subject: [PATCH v2 2/2] update-index: refresh should rewrite index in case of
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
index 00000000000..171c37ebec9
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
+	test-tool chmtime =1234567890 file &&
+	test-tool chmtime =1234567890 other
+}
+
+update_assert_changed () {
+	test-tool chmtime =1234567890 .git/index &&
+	test_might_fail git update-index "$1" &&
+	test-tool chmtime --get .git/index >.git/out &&
+	! grep ^1234567890 .git/out
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
+	test-tool chmtime =1234567891 .git/index &&
+	git update-index --refresh &&
+	test-tool chmtime --get .git/index >.git/out &&
+	grep ^1234567891 .git/out
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
+	test-tool chmtime =1234567890 other &&
+	update_assert_changed --refresh
+'
+
+test_expect_success '--refresh should fix racy timestamp if racy file needs update' '
+	reset_files &&
+	echo content2 >file &&
+	test-tool chmtime =1234567890 file &&
+	update_assert_changed --refresh
+'
+
+test_done
-- 
gitgitgadget
