Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 370581F516
	for <e@80x24.org>; Sat, 23 Jun 2018 04:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751366AbeFWEgy (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Jun 2018 00:36:54 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:46998 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeFWEgx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Jun 2018 00:36:53 -0400
Received: by mail-pf0-f194.google.com with SMTP id q1-v6so4081290pff.13
        for <git@vger.kernel.org>; Fri, 22 Jun 2018 21:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=mV1SjnK/hhImp9QXb87YOHzGKpyVTTw66DWfqV7HvCE=;
        b=pjAxkwYIW0dkvYZRLmQ3Bg7WeU0wcz5MeEaJa7e226lAfO0x5iNRE2HdvhSDTytx0G
         j9fXYZk4IpeFAuWspQwgHXk4ArS7V2mwKzvrUKPolUOy5vopu7Zit8LLoJzG6R4HIJC/
         zTurg7laSpDRfh02IF37inGKhIr8X58SUQD8XIAgDMVote8uAYpiejfgVz0HB5Su5iLA
         Hlol2cOEyKnF61dABeINUZYmQLrLh23qZC9+Rhfw3gwGnXc28cOL398mvGVCG7uQNl2/
         iGAfFtgN5bUR2xR9TBmNU2x5hqwIyWFfAYDH/HCD8c9khouOdHOXks68H9GMcg4FB3sr
         2YHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mV1SjnK/hhImp9QXb87YOHzGKpyVTTw66DWfqV7HvCE=;
        b=O45gx3VtJIVjr0eBPgRFT8uSZHuYdQKw+mknlrjQl0tmDX6i5TnPROaTb0bMisCm8X
         mm44mkXi9js9903qEvXMYygCo98TnNJxWfhR9Qq3Ng6v4TC5KePDEHGwemBTcB2yKBc2
         eDqGhb5wQ8Xq4KXLO2Tg5f1GqI40DhfRxibO4VnHVABqS05ffVpLxT8PU/xBH5vUP65z
         Bcu8nZmrFws2GTfBVTo1p7FqiOwqlgXp639OXJc7zzpiXjMX7k6s+11Z3rsM5yIFc0d/
         /aYn4rLrl7qQGB/u1Xezqf8gyK5D56eBzD0ovc5N5KDLd6PrEN/GdZVQruCtFZK2ZCpm
         xthg==
X-Gm-Message-State: APt69E0FB/pQXPF5xh7rvXEpAjxy/gpVcBVqDSgqEEVlOqhlKf3nvqHU
        Hgi11zNVizWeIW04EkTzSzs=
X-Google-Smtp-Source: ADUXVKKWNtDlJWKM9zvMjYzLvGxUc8RHNJ9kGR+Uq6fxBUsoXWuCgr3HznGl0ZbAOwHV9lf/0rDBjg==
X-Received: by 2002:a63:9543:: with SMTP id t3-v6mr3577910pgn.77.1529728613058;
        Fri, 22 Jun 2018 21:36:53 -0700 (PDT)
Received: from gr.lan (S01069050ca9bcfa3.vn.shawcable.net. [24.87.149.132])
        by smtp.gmail.com with ESMTPSA id 76-v6sm21084761pfr.172.2018.06.22.21.36.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Jun 2018 21:36:51 -0700 (PDT)
From:   Michael Barabanov <michael.barabanov@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, ijc@hellion.org.uk,
        Michael Barabanov <michael.barabanov@gmail.com>
Subject: [PATCH] filter-branch: skip commits present on --state-branch
Date:   Fri, 22 Jun 2018 21:36:39 -0700
Message-Id: <20180623043639.7727-1-michael.barabanov@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commits in state:filter.map have already been processed, so don't
filter them again. This makes incremental git filter-branch much faster.

Also add tests for --state-branch option.

Signed-off-by: Michael Barabanov <michael.barabanov@gmail.com>
---
 git-filter-branch.sh     |  3 +++
 t/t7003-filter-branch.sh | 15 +++++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index ccceaf19a..2df7ed107 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -372,6 +372,9 @@ while read commit parents; do
 	git_filter_branch__commit_count=$(($git_filter_branch__commit_count+1))
 
 	report_progress
+	if test -r "$workdir/../map/$commit"; then
+		continue
+	fi
 
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
2.17.1

