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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA84FC11F66
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:58:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1F3B61D6C
	for <git@archiver.kernel.org>; Tue, 29 Jun 2021 13:58:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234205AbhF2OAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Jun 2021 10:00:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233329AbhF2OAX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jun 2021 10:00:23 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80039C061760
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:56 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id j24so3234657pfi.12
        for <git@vger.kernel.org>; Tue, 29 Jun 2021 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n8ovVZdtpbYlXRUJtSizBbeLJhL0PMrvjjXeRov/pAg=;
        b=cih+scgTdot332XlHmCn6BMbCtABCHpZIbfCt5KyK5yHzmBYORzQBDNifUvpNJPDHn
         52fZ2XiNdTv15pugMue9UGf/47DEgLhUimD45UY4GWn1WStqjcrujNBNgSO57l0VpJzZ
         2WTc4gBV3bIIBHDo260HEz6nEq4pvoFhtG3KXSvZUk+O4FjKcAMZwE6FwHieQTMTI3JX
         XJIubj/9wLpZMWmM+b0vZVBPa39SlgVpGWlJvqH31mkEjwr/td54ac5keCFTL010wZI+
         IKQMcinv5MTeMqOiSESThQs2ZTWlXb4hyTkJNkI/zfUCfp8brsImOPzX7r6lW8k3KOIt
         5Y7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n8ovVZdtpbYlXRUJtSizBbeLJhL0PMrvjjXeRov/pAg=;
        b=uHBhUSapbN4yh32oGk0u3NCsLMi6xehXs9dSZiiMgmpX7H7bUXuMbtOBKazl7kzcmH
         97jeQONYT+L4Vp34tCJXzDcDz0XymhJ+VexeFXub6gjbp6dzV+ET+OX4OcbQ1t+fCyva
         tKpoAk+CkLIZJvtnqU8MI5QiW3uxf4epMJBsODu7ktHBvZRtSZqCRvlfynOXtjcVRk2e
         ESpUAbto4lEnGjv7kQPtzCAbhgR7iAB4q74t7IHe9EyY8UEkkGPsp/qEzXXrqaRC9Htq
         GXjAfAUjw3b96pPFMa5qce3P3JcHQF3LWJyi8ZKSaI5hJd8ba5I4xXVLCaJf8wyRIr1Z
         PhJA==
X-Gm-Message-State: AOAM530sjzxMphYko0x8OKH5aKhlYHBl3fchknWS36rzgDd4spHt94IX
        CRhL+BbBqLURZgqK9+jFTVH61tNX1kk=
X-Google-Smtp-Source: ABdhPJwZ/XdhLoY3M7vU/h9sEH7LMK1KyghEzp++WvtuE9PEWIhLJQTAtAGD7cMw9alnrcU1IQzo/A==
X-Received: by 2002:a63:d60b:: with SMTP id q11mr7185065pgg.270.1624975075978;
        Tue, 29 Jun 2021 06:57:55 -0700 (PDT)
Received: from athena.localdomain ([2402:800:63b8:8e5c:5bd7:f8a:333f:cf5])
        by smtp.gmail.com with ESMTPSA id c62sm18376572pfa.12.2021.06.29.06.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jun 2021 06:57:55 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 1/2] t6400: preserve git ls-files exit status code
Date:   Tue, 29 Jun 2021 20:57:43 +0700
Message-Id: <49104273b8b801fc61811347120c5f4c42a3700b.1624974969.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.32.0.278.gd42b80f139
In-Reply-To: <cover.1624974969.git.congdanhqx@gmail.com>
References: <20210615172038.28917-1-congdanhqx@gmail.com> <cover.1624974969.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In t6400, we're checking number of files in the index and the working
tree by piping the output of "git ls-files" to "wc -l", thus losing the
exit status code of git.

Let's write the output of "git ls-files" to a temporary file, in order
to check exit status code of "git ls-files" properly.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 t/t6400-merge-df.sh | 30 ++++++++++++++++++++++--------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/t/t6400-merge-df.sh b/t/t6400-merge-df.sh
index 38700d29b5..c2888323c1 100755
--- a/t/t6400-merge-df.sh
+++ b/t/t6400-merge-df.sh
@@ -9,6 +9,20 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+check_ls_files_count() {
+	local ops val
+	if test "$#" -le 2
+	then
+		BUG "Expect 2 or more arguments"
+	fi &&
+	ops="$1" &&
+	val="$2" &&
+	shift 2 &&
+	mkdir -p .git/trash &&
+	git ls-files "$@" >.git/trash/output &&
+	test_line_count "$ops" "$val" .git/trash/output
+}
+
 test_expect_success 'prepare repository' '
 	echo Hello >init &&
 	git add init &&
@@ -82,13 +96,13 @@ test_expect_success 'modify/delete + directory/file conflict' '
 	git checkout delete^0 &&
 	test_must_fail git merge modify &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	check_ls_files_count = 5 -s &&
+	check_ls_files_count = 4 -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		check_ls_files_count = 0 -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		check_ls_files_count = 1 -o
 	fi &&
 
 	test_path_is_file letters/file &&
@@ -103,13 +117,13 @@ test_expect_success 'modify/delete + directory/file conflict; other way' '
 
 	test_must_fail git merge delete &&
 
-	test 5 -eq $(git ls-files -s | wc -l) &&
-	test 4 -eq $(git ls-files -u | wc -l) &&
+	check_ls_files_count = 5 -s &&
+	check_ls_files_count = 4 -u &&
 	if test "$GIT_TEST_MERGE_ALGORITHM" = ort
 	then
-		test 0 -eq $(git ls-files -o | wc -l)
+		check_ls_files_count = 0 -o
 	else
-		test 1 -eq $(git ls-files -o | wc -l)
+		check_ls_files_count = 1 -o
 	fi &&
 
 	test_path_is_file letters/file &&
-- 
2.32.0.278.gd42b80f139

