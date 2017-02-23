Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B444201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:27:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751202AbdBWI1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:27:25 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:33295 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750944AbdBWI1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:27:24 -0500
Received: by mail-it0-f65.google.com with SMTP id e137so1574988itc.0
        for <git@vger.kernel.org>; Thu, 23 Feb 2017 00:27:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=6FNhXZWZ42ahY7HRHtnDyZQQwB0i9SuCue+p92MTn1k=;
        b=TM+EUq4RaGdtrUq+N0K2oIpRfTsb5fIAnsMTR/60Z60lC0G7WavZdOfrLtLYqjh907
         t0YEBZydoBaN3nwsUaofK0XSp8Q4bvdoPdFxM6pIXbVWKzblLG6xPTUn/A4TpJUqEMa7
         6TKdRxfnih6xNSMBYzBIjoGIUolzjRfSBeGDB4mh9v01TZsqKnuR6foXMrHnWMKgqeyA
         w2UIC3Zj0+/cwnAg9pHhjrGupJxA3hSXZe7xLCJ/1T9FYVshWwL5sQgWmn0wEzLA+6c1
         oSN9q722yiA61fkG2HIjWLc4qyVz44XqOwe6PsVtTTODEtUR4GE0F3ItuUcMxjc0e7X7
         okcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=6FNhXZWZ42ahY7HRHtnDyZQQwB0i9SuCue+p92MTn1k=;
        b=WVt/UYJtJCIkSnqg6xqP89upuqC97vEr2nNnrjPU3tp92jVHp9NEr65PSL22NJiTMj
         uLNRtzaCzBCpresR9pq0mZGuxfLfE7nLE7TFnciZer63fz6YQHjvUmVmt23JxoY5jeny
         3T1tXWAuSAYAy7M/F/L0ygtGCogbzQ2tf5rP58gLhh251G+ksSqgtgP/cJ7c86BLjl6C
         lI8Ju7CC59HZxNybcRTBy00OlRn7xZrpI12cKPhCv9rWwdVF2qY3VB8oaQN2ReLpRKTj
         +jtXrcf1eej2aLbUwdPm2KS9I40gnYn/v0NOpsWytfFWZvFnIxWDShBuFrYBIFqZvinQ
         qsmQ==
X-Gm-Message-State: AMke39lxUn9kenDq1vXLCffO1TKOUGIdIMn6UBkQB1DBzwJA0Nqbu3OcSu6h4uDtlnjoHA==
X-Received: by 10.36.208.134 with SMTP id m128mr1901488itg.44.1487838443771;
        Thu, 23 Feb 2017 00:27:23 -0800 (PST)
Received: from prospect.wheaton.edu (wcnat-96-27.wheaton.edu. [209.147.96.27])
        by smtp.gmail.com with ESMTPSA id e126sm1779353itb.18.2017.02.23.00.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 23 Feb 2017 00:27:22 -0800 (PST)
From:   "Devin J. Pohly" <djpohly@gmail.com>
To:     git@vger.kernel.org
Cc:     "Devin J. Pohly" <djpohly@gmail.com>
Subject: [PATCH 1/4] t7003: ensure --prune-empty can prune root commit
Date:   Thu, 23 Feb 2017 02:27:33 -0600
Message-Id: <20170223082736.31283-1-djpohly@gmail.com>
X-Mailer: git-send-email 2.11.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

New test to expose a bug in filter-branch whereby the root commit is
never pruned, even though its tree is empty and --prune-empty is given.

The setup isn't exactly pretty, but I couldn't think of a simpler way to
create a parallel commit graph sans the first commit.

Signed-off-by: Devin J. Pohly <djpohly@gmail.com>
---
 t/t7003-filter-branch.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t7003-filter-branch.sh b/t/t7003-filter-branch.sh
index cb8fbd8e5..2dfe46250 100755
--- a/t/t7003-filter-branch.sh
+++ b/t/t7003-filter-branch.sh
@@ -313,6 +313,27 @@ test_expect_success 'Tag name filtering allows slashes in tag names' '
 	git cat-file tag X/2 > actual &&
 	test_cmp expect actual
 '
+test_expect_success 'setup --prune-empty comparisons' '
+	git checkout --orphan master-no-a &&
+	git rm -rf . &&
+	unset test_tick &&
+	test_tick &&
+	GIT_COMMITTER_DATE="@0 +0000" GIT_AUTHOR_DATE="@0 +0000" &&
+	test_commit --notick B B.t B Bx &&
+	git checkout -b branch-no-a Bx &&
+	test_commit D D.t D Dx &&
+	mkdir dir &&
+	test_commit dir/D dir/D.t dir/D dir/Dx &&
+	test_commit E E.t E Ex &&
+	git checkout master-no-a &&
+	test_commit C C.t C Cx &&
+	git checkout branch-no-a &&
+	git merge Cx -m "Merge tag '\''C'\'' into branch" &&
+	git tag Fx &&
+	test_commit G G.t G Gx &&
+	test_commit H H.t H Hx &&
+	git checkout branch
+'
 
 test_expect_success 'Prune empty commits' '
 	git rev-list HEAD > expect &&
@@ -341,6 +362,15 @@ test_expect_success 'prune empty works even without index/tree filters' '
 	test_cmp expect actual
 '
 
+test_expect_success '--prune-empty is able to prune root commit' '
+	git rev-list branch-no-a >expect &&
+	git branch testing H &&
+	git filter-branch -f --prune-empty --index-filter "git update-index --remove A.t" testing &&
+	git rev-list testing >actual &&
+	git branch -D testing &&
+	test_cmp expect actual
+'
+
 test_expect_success '--remap-to-ancestor with filename filters' '
 	git checkout master &&
 	git reset --hard A &&
-- 
2.11.1

