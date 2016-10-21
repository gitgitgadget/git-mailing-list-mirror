Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B32920987
	for <e@80x24.org>; Sat, 22 Oct 2016 00:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936148AbcJVAAG (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Oct 2016 20:00:06 -0400
Received: from mail-pf0-f177.google.com ([209.85.192.177]:36627 "EHLO
        mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935727AbcJUX76 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2016 19:59:58 -0400
Received: by mail-pf0-f177.google.com with SMTP id e6so64783250pfk.3
        for <git@vger.kernel.org>; Fri, 21 Oct 2016 16:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RwNjpSmnRy7LGK/Gil3vSFkb0lkDd3Fpw2JwiCZ8240=;
        b=dxcByTl6omxNHh4mPKYKkoM+P9FVwOb04awImEFvxaFkhgfknqvn5nwUCPA51K/iXR
         h6tuHE2dyBvRdSbI7Ka6iYH4pP/1GfVnOTi/cXAr+anr7ziM1mUd7ml9Ys6sL0A0gI94
         PCJOks4Eb/qnY8VVSIGGQrcU0iJypuH2VvwDK4dGSILMnVn25Wj0kXEn8bJEhUqn5ZUk
         qUHBgL5sDERBzFX73Mjb2aqPfX09SgE2EYxCHbPxCTLjpG7lk+5zNelr2/pEtYYdjc5u
         a8fCLmrCdiFS8DIkl3VMOAZ9FdkfaIhFsDN8Q3YqDI91KX7X6J6XujUY5M2P9zmvGMEx
         Q6Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RwNjpSmnRy7LGK/Gil3vSFkb0lkDd3Fpw2JwiCZ8240=;
        b=E1z5PcIQVSEbv6vViWjI19aQYlftiTY5kMkzkE85neJoDwFEuX8EcGRB7Cw+7ezidc
         hqZOJ3GODJUvv2PFDv/zhW3WTxJa8xN5p4dEq0s219Ojggv74c7WxR7clMeWhBgMQOla
         Z1qbIPpzyUKfK1PDTNW2fo1Mm8npWBPU8xUjybD53WV7aG9R98dIWFxurhBxZs45bF+q
         1KHaHuubCG7HwLpcAUD2nAHvoiCAe3/aQPA9P1dxUJJnhx7w80NPq2tV0EDlGHdsV9ey
         9uAY95AwQKBsCq2ZYekpZz8W5MI7R5mnNcpyuHZZTaLe3lJATEA4iP8iL84AY13XHAMm
         F1Xw==
X-Gm-Message-State: ABUngvfy8kZi+meDo2Zwc68CTFxkS5/PFgLDFamJM03v9rvM/yi4H86bUzC0eT7fkwWhHlN3
X-Received: by 10.99.123.18 with SMTP id w18mr5026079pgc.155.1477094397413;
        Fri, 21 Oct 2016 16:59:57 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:cc9c:7559:8571:d165])
        by smtp.gmail.com with ESMTPSA id j4sm7610490pal.25.2016.10.21.16.59.56
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 21 Oct 2016 16:59:56 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, j6t@kdbg.org, Johannes.Schindelin@gmx.de
Cc:     git@vger.kernel.org, venv21@gmail.com, dennis@kaarsemaker.net,
        jrnieder@gmail.com, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/3] submodule tests: replace cloning from . by "$(pwd)"
Date:   Fri, 21 Oct 2016 16:59:38 -0700
Message-Id: <20161021235939.20792-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.1.507.g2a9098a
In-Reply-To: <20161021235939.20792-1-sbeller@google.com>
References: <20161021235939.20792-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When adding a submodule via "git submodule add <relative url>",
the relative url applies to the superprojects remote. When the
superproject was cloned via "git clone . super", the remote url
is ending with '/.'.

The logic to construct the relative urls is not smart enough to
detect that the ending /. is referring to the directory itself
but rather treats it like any other relative path, i.e.

    path/to/dir/. + ../relative/path/to/submodule

would result in

    path/to/dir/relative/path/to/submodule

and not omit the "dir" as you may expect.

As in a later patch we'll normalize the remote url before the
computation of relative urls takes place, we need to first get our
test suite in a shape with normalized urls only, which is why we should
refrain from cloning from '.'

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7064-wtstatus-pv2.sh      | 9 ++++++---
 t/t7403-submodule-sync.sh    | 3 ++-
 t/t7406-submodule-update.sh  | 6 ++++--
 t/t7407-submodule-foreach.sh | 3 ++-
 t/t7506-status-submodule.sh  | 3 ++-
 5 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 3012a4d..95514bb 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -330,7 +330,8 @@ test_expect_success 'verify UU (edit-edit) conflict' '
 test_expect_success 'verify upstream fields in branch header' '
 	git checkout master &&
 	test_when_finished "rm -rf sub_repo" &&
-	git clone . sub_repo &&
+	git clone "$(pwd)" sub_repo &&
+	git -C sub_repo config --unset remote.origin.url &&
 	(
 		## Confirm local master tracks remote master.
 		cd sub_repo &&
@@ -392,8 +393,10 @@ test_expect_success 'verify upstream fields in branch header' '
 
 test_expect_success 'create and add submodule, submodule appears clean (A. S...)' '
 	git checkout master &&
-	git clone . sub_repo &&
-	git clone . super_repo &&
+	git clone "$(pwd)" sub_repo &&
+	git -C sub_repo config --unset remote.origin.url &&
+	git clone "$(pwd)" super_repo &&
+	git -C super_repo config --unset remote.origin.url &&
 	(	cd super_repo &&
 		git submodule add ../sub_repo sub1 &&
 
diff --git a/t/t7403-submodule-sync.sh b/t/t7403-submodule-sync.sh
index 0726799..6d85391 100755
--- a/t/t7403-submodule-sync.sh
+++ b/t/t7403-submodule-sync.sh
@@ -15,7 +15,8 @@ test_expect_success setup '
 	git add file &&
 	test_tick &&
 	git commit -m upstream &&
-	git clone . super &&
+	git clone "$(pwd)" super &&
+	git -C super config --unset remote.origin.url &&
 	git clone super submodule &&
 	(
 		cd submodule &&
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 64f322c..9430c2a 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -26,7 +26,8 @@ test_expect_success 'setup a submodule tree' '
 	git add file &&
 	test_tick &&
 	git commit -m upstream &&
-	git clone . super &&
+	git clone "$(pwd)" super &&
+	git -C super config --unset remote.origin.url &&
 	git clone super submodule &&
 	git clone super rebasing &&
 	git clone super merging &&
@@ -64,7 +65,8 @@ test_expect_success 'setup a submodule tree' '
 	 test_tick &&
 	 git commit -m "none"
 	) &&
-	git clone . recursivesuper &&
+	git clone "$(pwd)" recursivesuper &&
+	git -C recursivesuper config --unset remote.origin.url &&
 	( cd recursivesuper
 	 git submodule add ../super super
 	)
diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
index 6ba5daf..257e817 100755
--- a/t/t7407-submodule-foreach.sh
+++ b/t/t7407-submodule-foreach.sh
@@ -17,7 +17,8 @@ test_expect_success 'setup a submodule tree' '
 	git add file &&
 	test_tick &&
 	git commit -m upstream &&
-	git clone . super &&
+	git clone "$(pwd)" super &&
+	git -C super config --unset remote.origin.url &&
 	git clone super submodule &&
 	(
 		cd super &&
diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
index 74cb6b8..62a99bc 100755
--- a/t/t7506-status-submodule.sh
+++ b/t/t7506-status-submodule.sh
@@ -197,7 +197,8 @@ A  sub1
 EOF
 
 test_expect_success 'status with merge conflict in .gitmodules' '
-	git clone . super &&
+	git clone "$(pwd)" super &&
+	git -C super config --unset remote.origin.url &&
 	test_create_repo_with_commit sub1 &&
 	test_tick &&
 	test_create_repo_with_commit sub2 &&
-- 
2.10.1.507.g2a9098a

