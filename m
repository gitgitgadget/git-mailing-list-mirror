Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C4EEC77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 17:24:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjEBRYD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 13:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbjEBRYB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 13:24:01 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDF2E61
        for <git@vger.kernel.org>; Tue,  2 May 2023 10:23:59 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id e9e14a558f8ab-32aabbe7e77so9154465ab.2
        for <git@vger.kernel.org>; Tue, 02 May 2023 10:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683048239; x=1685640239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xasPirDE8rxzt6NBi8iZU+L1kAusAXlVT/3N56ZMnq0=;
        b=nqwicNwMc09CBSCl9efW4mrwfGNj1pswKjFpwLAe6bTTd89VT8fIB5sIttzfE2XilR
         PeAlJRCHyl92ChdHkJRqU0H+X4MPc+IgjDIWC8IW+glvNnN2ZNoNlp0WHotNuM2mYkk+
         YZIagmCqVGfaUex+pTm8nPkFxh754O0YjxOwMJ3AoNy7vvJCPp4Ja7ZF4dlacQO3ZZF7
         Rax26VdhmFdK1wrihfLmJ9KN36OgJW0ATVnhmJ/2YYPfiJYw5zugOIOPPnUBdlLMRUgm
         BD6o6vI+hWY1NR9QN9E9NDjRPV2fZEgOe+bxW6fqL/sioSy4jWvrtYvorXVwaZcRb6dJ
         5Wdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683048239; x=1685640239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xasPirDE8rxzt6NBi8iZU+L1kAusAXlVT/3N56ZMnq0=;
        b=dpoUmQ+doShFgwn3NqWBFdfk0XwqSAeoVfcPM1TKhDGBPxsZLWxjk4SQGRO6uDIbw4
         Et7M/5CDEoBdvrc/PEb1LrW9ZnC6IoTIVVu/BUQcLAwI/4cDU1/kYQNM55sOa6FsZihd
         +vQ7Yb+wMdPMP457dbvV+d712Yqkuio9kHDioJx19Sb+Y6F1VgJ4rVrC2RjMCYLrrDlw
         IMTuZhDshfPN1Z5BjSzef3D8FvZJcVgNSKK2JpJL+knUxB9C7G1Sl7xQ/Yfdjho0qhu8
         KkFabSvjiQ4wVMdPmt9QP4j/uqX4nxZtq0op182ecm2tS3zn/GabA4hctOb9AO+icc5l
         eVDw==
X-Gm-Message-State: AC+VfDwYBP/3MHu5TBuO/Z+pWUpcLLuqOk8qRRzhTTlU3A5PtycsCpfZ
        RuIsIbbhg6trBYMX/lys0waJAOafAUAYeg==
X-Google-Smtp-Source: ACHHUZ4I3YlOBfKpGCqx+dEC+3y/KzprosU+j+wqrkyocF+J5WuG1lVZXkdEnNzSRDgYBDONtr1OGA==
X-Received: by 2002:a05:6e02:686:b0:32c:c4d9:c756 with SMTP id o6-20020a056e02068600b0032cc4d9c756mr11622717ils.12.1683048238824;
        Tue, 02 May 2023 10:23:58 -0700 (PDT)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id q19-20020a927513000000b0032b72b5c1c3sm8128217ilc.9.2023.05.02.10.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 May 2023 10:23:58 -0700 (PDT)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        gitster@pobox.com, derrickstolee@github.com
Subject: [PATCH v9 0/2] diff-files: integrate with sparse index
Date:   Tue,  2 May 2023 13:23:33 -0400
Message-Id: <20230502172335.478312-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
References: <20230423010721.1402736-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v8:

* Fix white space problem.

* Simplified the refactored function based on Victoria's suggestion.

Shuqi Liang (2):
  t1092: add tests for `git diff-files`
  diff-files: integrate with sparse index

 builtin/diff-files.c                     |  4 ++
 t/perf/p2000-sparse-operations.sh        |  2 +
 t/t1092-sparse-checkout-compatibility.sh | 73 +++++++++++++++++++++++-
 3 files changed, 77 insertions(+), 2 deletions(-)

Range-diff against v8:
1:  d7f921c1a6 ! 1:  d78513af83 t1092: add tests for `git diff-files`
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +
     +	test_all_match git diff-files &&
     +
    -+	test_all_match git diff-files deep/a && 
    ++	test_all_match git diff-files deep/a &&
     +
     +	# test wildcard
     +	test_all_match git diff-files "deep/*"
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +	EOF
     +
     +	# Add file to the index but outside of cone for sparse-checkout cases.
    -+	# Add file to the index without sparse-checkout cases to ensure all have 
    ++	# Add file to the index without sparse-checkout cases to ensure all have
     +	# same output.
     +	run_on_all mkdir -p folder1 &&
     +	run_on_all cp a folder1/a &&
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'sparse-index is n
     +	run_on_all ../edit-contents folder1/a &&
     +	test_all_match git diff-files &&
     +	test_all_match git diff-files folder1/a &&
    -+	test_all_match git diff-files "folder*/a" 
    ++	test_all_match git diff-files "folder*/a"
     +'
     +
      test_done
2:  b44384ac94 ! 2:  a2454befa0 diff-files: integrate with sparse index
    @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'index.sparse disa
      '
      
     -ensure_not_expanded () {
    -+ensure_index_state () {
    -+	local expected_expansion="$1"
    -+	shift
    -+
    ++run_sparse_index_trace2 () {
      	rm -f trace2.txt &&
      	if test -z "$WITHOUT_UNTRACKED_TXT"
      	then
     @@ t/t1092-sparse-checkout-compatibility.sh: ensure_not_expanded () {
    + 			git -C sparse-index "$@" \
      			>sparse-index-out \
      			2>sparse-index-error || return 1
    - 	fi &&
    --	test_region ! index ensure_full_index trace2.txt
    -+
    -+	if [ "$expected_expansion" = "expanded" ]
    -+	then
    -+		test_region index ensure_full_index trace2.txt
    -+	else
    -+		test_region ! index ensure_full_index trace2.txt
    +-	fi &&
     +	fi
     +}
     +
     +ensure_expanded () {
    -+	ensure_index_state "expanded" "$@"
    ++	run_sparse_index_trace2 "$@" &&
    ++	test_region index ensure_full_index trace2.txt
     +}
     +
     +ensure_not_expanded () {
    -+	ensure_index_state "not_expanded" "$@"
    ++	run_sparse_index_trace2 "$@" &&
    + 	test_region ! index ensure_full_index trace2.txt
      }
      
    - test_expect_success 'sparse-index is not expanded' '
     @@ t/t1092-sparse-checkout-compatibility.sh: test_expect_success 'diff-files with pathspec outside sparse definition' '
    - 	test_all_match git diff-files "folder*/a" 
    + 	test_all_match git diff-files "folder*/a"
      '
      
     +test_expect_success 'sparse index is not expanded: diff-files' '
-- 
2.39.0

