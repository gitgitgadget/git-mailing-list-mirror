Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96911C77B7E
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbjEBRYG (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbjEBRYE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:24:04 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE78DE65
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:24:02 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id e9e14a558f8ab-32b1ee270ebso10780685ab.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 10:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683048242; x=1685640242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2MmMhDYESzLklXwWuyYhLIuEtpAMiAd8RW2I8icuwg=;
        b=AHYaJM2MoG+9m/b9Yyn3YfqGsqWTKMcIbdOe8VlJpa81yCDlVBsW802k1u/2Fb7itB
         4fognB4cmVlXTJ5U/rG5sa2XRHDmhT6fO+oRIeQNGiYxlmrs56TAsyiF6bveeFjh/9Zg
         etA0QMFqep1t30fwKQn9YLeIqJbifCWwoQ8MQZ17R0MTpMPnUv+6+0nFYVLG81bbO1jL
         inelfxYp0NPWMkf32Wjmct1elLaZXwABD0EZrVUqzhjcylVoKVwnWo1okaIC+v5O1a9S
         aZUfEAxkNU3fWEGeCV7Y23lVYdgbn2cTfiB7Qw5zRdYMfstGk/iT+1hIu85F6htxV2vp
         d/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048242; x=1685640242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d2MmMhDYESzLklXwWuyYhLIuEtpAMiAd8RW2I8icuwg=;
        b=P2xEds1lmrrKe+wVQkqKoXM3AV/cs3T99VC2c0L81dsWCGWquXCdDQQjbbpaezmuiM
         43s7aCMNIZ5/K2Vwb238op6k8b3yzenTE3OnBNA+CI5n/qoAVOW7aV498kwBLn0NR4Zz
         NM6zO/JfIRlBrcijpwDg6K2NSZP/sVC5e0rv2JPIrhrm2jamFDm86T5/i+2sjDybQw6Q
         mrN0g2O4iBZUsrfXxMsAYjfyp3Zwi6Gd9DADHBuQINA69tncqWOJD8vsjHXW4OhmIfAl
         VKeWbDNJoUCdI9ojL+5SEhoWnsi66ptj7N5+OxfUSE7V9QkNQGk/HRMR+yTGzkRbdeWo
         VjPw==
X-Gm-Message-State: AC+VfDzcZ+SxCD2B4L7x46hIsYn7+wwPU30Tvy9b2Pa0pu6gRxGbbsG4
        MZ42dhAE2+2akm4/e/26mPRQAg2fZR6amw==
X-Google-Smtp-Source: ACHHUZ5BCyQxlhZg30LA4t1meMLWbHdkdWtCoaVTo4MVj6OUYmcGOYWjqvgC7IfUXEzRCyvWsJUUig==
X-Received: by 2002:a92:cf03:0:b0:328:6e2d:5a2d with SMTP id c3-20020a92cf03000000b003286e2d5a2dmr10926883ilo.6.1683048241820;
        Tue, 02 May 2023 10:24:01 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q19-20020a927513000000b0032b72b5c1c3sm8128217ilc.9.2023.05.02.10.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:24:01 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v9 1/2] t1092: add tests for `git diff-files`
Date:   Tue,  2 May 2023 13:23:34 -0400
Message-Id: <20230502172335.478312-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230502172335.478312-1-cheskaqiqi@gmail.com>
References: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
 <20230502172335.478312-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before integrating the 'git diff-files' builtin with the sparse index
feature, add tests to t1092-sparse-checkout-compatibility.sh to ensure
it currently works with sparse-checkout and will still work with sparse
index after that integration.

When adding tests against a sparse-checkout definition, we test two
modes: all changes are within the sparse-checkout cone and some changes
are outside the sparse-checkout cone.

In order to have staged changes outside of the sparse-checkout cone,
make a directory called 'folder1' and copy `a` into 'folder1/a'.
'folder1/a' is identical to `a` in the base commit. These make
'folder1/a' in the index, while leaving it outside of the
sparse-checkout definition. Test 'folder1/a'being present on-disk
without modifications, then change content inside 'folder1/a' in order
to test 'folder1/a' being present on-disk with modifications.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 0c784813f1..053435bb0c 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2108,4 +2108,50 @@ test_expect_success 'sparse-index is not expanded: write-tree' '
 	ensure_not_expanded write-tree
 '
 
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files &&
+
+	test_all_match git diff-files deep/a &&
+
+	# test wildcard
+	test_all_match git diff-files "deep/*"
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	test_sparse_match test_must_fail git diff-files folder2/a &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>"$1"
+	EOF
+
+	# Add file to the index but outside of cone for sparse-checkout cases.
+	# Add file to the index without sparse-checkout cases to ensure all have
+	# same output.
+	run_on_all mkdir -p folder1 &&
+	run_on_all cp a folder1/a &&
+
+	# file present on-disk without modifications
+	# use `--stat` to ignore file creation time differences in
+	# unrefreshed index
+	test_all_match git diff-files --stat &&
+	test_all_match git diff-files --stat folder1/a &&
+	test_all_match git diff-files --stat "folder*/a" &&
+
+	# file present on-disk with modifications
+	run_on_all ../edit-contents folder1/a &&
+	test_all_match git diff-files &&
+	test_all_match git diff-files folder1/a &&
+	test_all_match git diff-files "folder*/a"
+'
+
 test_done
-- 
2.39.0

