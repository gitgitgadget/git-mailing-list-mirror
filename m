Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E29AF1F516
	for <e@80x24.org>; Tue, 26 Jun 2018 04:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750883AbeFZEHt (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Jun 2018 00:07:49 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:46544 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750823AbeFZEHs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Jun 2018 00:07:48 -0400
Received: by mail-pg0-f65.google.com with SMTP id q14-v6so3255117pgt.13
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 21:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=a5q2UXDveBqbUt0e+/mEpuUKAbDDik6zc0F9YMO8bGk=;
        b=dZlSOp0e8ZvhSKTaoDFqruL3bcYwpvOF9Qz2V+Cz1RoGa60vzk0vHa8OMI/oTcPyg9
         H4bQyw00U9E+XdFQzkW6RZf0GoOO0ACoZSE/W8wzWpQdngM4Z8GKie66BhGtBl7CxWRI
         +gFhar6Ilt6uGUGnkLoAp5osb2R7fwSbOMBADDDUZkS0pKmS3QGd+DJSUPNLtf0sB/L6
         kpXU+zZH5sNrRVlkZQdh0fLTvkbgSF+xSPI48I5qyILtAhaZBtRO2nWUE0vNRe9MeRTU
         GEU/NMPwoCnj931aKMIiNzdv9EMHZsP27PvvRIfmaQnEtQhNzlnIaUHmsdquYk4+sVQ5
         7CpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=a5q2UXDveBqbUt0e+/mEpuUKAbDDik6zc0F9YMO8bGk=;
        b=AY9AixkV+IHBEOqo2YQQRULREeq5fGlyYyihzc3ZjSfxvQoQsuQLUBD8DZ7sp+8JUu
         J6mm4SYmpNt9MWGf0oOW92X54KmhdSjfmXXqTFXvoTiZlnGkmeXuUlkXuFwqUZpQ3xIu
         i0Gyl/h82lwFCJc/k5jE14ZBt3W58Zk/ZY2uGGd72YoTs6AkDWXFTqvMMWM24mpvRoH7
         x2bNygLQKbmq9QltusUkpumOhjpGlJyAL6mYU0zuFxrhfCspUqpkVCoNCqB9I+c5IdkL
         t6XaZG6JvjFGKgj9Hk5Ef2lPef/AppcYiIT1TlGSs9RTX1HgZEPGmlnXiV5iVDY+d79l
         zZ8w==
X-Gm-Message-State: APt69E1hfVTTvzsKbA6oHHvDxnrDmKGlVqfd+dtBphrVJvaB1v/hsN0v
        lzbljF2RTiI39WveKW9JPxA=
X-Google-Smtp-Source: ADUXVKJ+mX8iORoNkCtecijlowinMpp2xvsOkGToagdsxZJNJQtw+3i2H1ei3F/xUZp1mXwAqaQQJg==
X-Received: by 2002:a62:660a:: with SMTP id a10-v6mr15662235pfc.156.1529986068250;
        Mon, 25 Jun 2018 21:07:48 -0700 (PDT)
Received: from gr.lan (S01069050ca9bcfa3.vn.shawcable.net. [24.87.149.132])
        by smtp.gmail.com with ESMTPSA id o5-v6sm715483pgd.24.2018.06.25.21.07.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 21:07:47 -0700 (PDT)
From:   Michael Barabanov <michael.barabanov@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, ijc@hellion.org.uk,
        Michael Barabanov <michael.barabanov@gmail.com>
Subject: [PATCH v2] filter-branch: skip commits present on --state-branch
Date:   Mon, 25 Jun 2018 21:07:33 -0700
Message-Id: <20180626040733.30757-1-michael.barabanov@gmail.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180623043639.7727-1-michael.barabanov@gmail.com>
References: <20180623043639.7727-1-michael.barabanov@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commits in state:filter.map have already been processed, so don't
filter them again. This makes incremental git filter-branch much faster.

Also add tests for --state-branch option.

Signed-off-by: Michael Barabanov <michael.barabanov@gmail.com>
---
 git-filter-branch.sh     |  1 +
 t/t7003-filter-branch.sh | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ccceaf19a..5c5afa2b9 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -372,6 +372,7 @@ while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
 
 	report_progress
+	test -f "$workdir"/../map/$commit && continue
 
 	case "$filter_subdir" in
 	"")
diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index ec4b160dd..e23de7d0b 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -107,6 +107,21 @@ test_expect_success 'test that the directory was renamed' '
 	test dir/D = "$(cat diroh/D.t)"
 '
 
+V=$(git rev-parse HEAD)
+
+test_expect_success 'populate --state-branch' '
+	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD
+'
+
+W=$(git rev-parse HEAD)
+
+test_expect_success 'using --state-branch to skip already rewritten commits' '
+	test_when_finished git reset --hard $V &&
+	git reset --hard $V &&
+	git filter-branch --state-branch state -f --tree-filter "touch file || :" HEAD &&
+	test_cmp_rev $W HEAD
+'
+
 git tag oldD HEAD~4
 test_expect_success 'rewrite one branch, keeping a side branch' '
 	git branch modD oldD &&
-- 
2.18.0

