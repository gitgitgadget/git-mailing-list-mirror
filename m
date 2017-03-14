Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 67B2520953
	for <e@80x24.org>; Tue, 14 Mar 2017 21:47:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752010AbdCNVq7 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Mar 2017 17:46:59 -0400
Received: from mail-pg0-f45.google.com ([74.125.83.45]:32993 "EHLO
        mail-pg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750965AbdCNVq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Mar 2017 17:46:56 -0400
Received: by mail-pg0-f45.google.com with SMTP id n190so7621797pga.0
        for <git@vger.kernel.org>; Tue, 14 Mar 2017 14:46:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wH8fqDcr/dk62+/PAT29m0fS6KGSgnU1d/+DZIyIY7Q=;
        b=S0SY3KLOINSymZRfIYGK9NuVQwWfEeLsgJ9/twEM0ofEtUWIp6oWGj1Nq/GbH3VQNm
         gThEP5yzxNpINu63zaM7GciNiNseFYUu4BlOmPA1r29QAmaZzoxK5alJeaIkJT6uljAt
         oWmGLZmZ2TjNEFTt9G+FhwSzg5MZQhDtvUpEVstxESn52tChuvgiCEVi3c4kFxJgQGu1
         RKu9VuIeG9uEVgjWhBwhSrO+wYYPW5R3u3xT+o2epHfI51CxRgky0A/pSh5OoWCcPexi
         AHSDDFWtx4OI5br1eWIboZTfgafazlfUJqG5hJV3+5UUuiAddHk78uQUd8SvfSJbpA/E
         Kv2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wH8fqDcr/dk62+/PAT29m0fS6KGSgnU1d/+DZIyIY7Q=;
        b=VZQewJW31zGGYOwQ7jYH7gezlYytDdkkqxnzi9fhZ1kSpV4RHr1+EtrLXLbXoB1Ea0
         L2h/lP65ffUcNR93BGAe4qqCzsjKIWZCMwNbE+mgV5qqVFBLjTTbiolNuBwtvTwWs91E
         AZEYG+EFHr00kU5/xUBX9vQRp3lDb67B6k7/NpWLD8GS1jIIXXAQOiFeecNBoppFaxd1
         Iizp0WuLTj/K1AGE7vy0O5X6fGdxapkgdOTpjLIcqwbN33CGAmDzeAm8xxVryWEsV4rw
         v+uY0urEbO6ZBl0VnWeQoxKgqjxv+s/Mj4nc3EKPbpYurvIfeQNtpU3vPJgLkVvfRM25
         sh/A==
X-Gm-Message-State: AMke39n1OwfCFXAk9XH4Izt/8YN8CXvysGabATHn0SEHqt+XzNKbg6zJIsHZpgahgJFnRkNS
X-Received: by 10.99.163.110 with SMTP id v46mr44558852pgn.171.1489528014612;
        Tue, 14 Mar 2017 14:46:54 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:8559:2c0d:dab3:f802])
        by smtp.gmail.com with ESMTPSA id 187sm40329149pff.17.2017.03.14.14.46.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 14 Mar 2017 14:46:54 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 04/19] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Tue, 14 Mar 2017 14:46:27 -0700
Message-Id: <20170314214642.7701-5-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.49.g0cfd38c5f6.dirty
In-Reply-To: <20170314214642.7701-1-sbeller@google.com>
References: <20170309221543.15897-1-sbeller@google.com>
 <20170314214642.7701-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adding the repository itself as a submodule does not make sense in the
real world. In our test suite we used to do that out of convenience in
some tests as the current repository has easiest access for setting up
'just a submodule'.

However this doesn't quite test the real world, so let's do not follow
this pattern any further and actually create an independent repository
that we can use as a submodule.

When using './.' as the remote the superproject and submodule share the
same objects, such that testing if a given sha1 is a valid commit works
in either repository.  As running commands in an unpopulated submodule
fall back to the superproject, this happens in `reset_work_tree_to`
to determine if we need to populate the submodule. Fix this bug by
checking in the actual remote now.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/lib-submodule-update.sh | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/t/lib-submodule-update.sh b/t/lib-submodule-update.sh
index 5df528ea81..c0d6325133 100755
--- a/t/lib-submodule-update.sh
+++ b/t/lib-submodule-update.sh
@@ -37,6 +37,17 @@
 #
 
 create_lib_submodule_repo () {
+	git init submodule_update_sub1 &&
+	(
+		cd submodule_update_sub1 &&
+		echo "expect" >>.gitignore &&
+		echo "actual" >>.gitignore &&
+		echo "x" >file1 &&
+		echo "y" >file2 &&
+		git add .gitignore file1 file2 &&
+		git commit -m "Base inside first submodule" &&
+		git branch "no_submodule"
+	) &&
 	git init submodule_update_repo &&
 	(
 		cd submodule_update_repo &&
@@ -49,7 +60,7 @@ create_lib_submodule_repo () {
 		git branch "no_submodule" &&
 
 		git checkout -b "add_sub1" &&
-		git submodule add ./. sub1 &&
+		git submodule add ../submodule_update_sub1 sub1 &&
 		git config -f .gitmodules submodule.sub1.ignore all &&
 		git config submodule.sub1.ignore all &&
 		git add .gitmodules &&
@@ -162,7 +173,7 @@ reset_work_tree_to () {
 		test_must_be_empty actual &&
 		sha1=$(git rev-parse --revs-only HEAD:sub1) &&
 		if test -n "$sha1" &&
-		   test $(cd "sub1" && git rev-parse --verify "$sha1^{commit}")
+		   test $(cd "../submodule_update_sub1" && git rev-parse --verify "$sha1^{commit}")
 		then
 			git submodule update --init --recursive "sub1"
 		fi
-- 
2.12.0.rc1.49.g0cfd38c5f6.dirty

