Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B759D2013A
	for <e@80x24.org>; Thu, 16 Feb 2017 00:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756248AbdBPAif (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 19:38:35 -0500
Received: from mail-pf0-f178.google.com ([209.85.192.178]:36509 "EHLO
        mail-pf0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756005AbdBPAi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 19:38:28 -0500
Received: by mail-pf0-f178.google.com with SMTP id 189so781462pfu.3
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 16:38:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gh9KnnWkXTk5gAYH3Ad4z+xQUIObfJnKEBk4Xxg8wE4=;
        b=wNFiMtoEruy22RqDakwURSCU5Ndm0cQzhuxtO+RCm2Smkz1XRqB0MFkB+ReVzXUWIp
         2oXSkqCvDGDFr/VRxBqlMybSpy10cVHiRmWunSPD8GCJBlNuTUMJQdt9pVSFZIvDS3rH
         xfGJdsTues26BkDuWFNMD7IWFM/7Iu+kOKrTmRWeDmshG4r6Gm1g78O/w4pZb79Xi9pd
         z5fai4wVmAmpiBUsYXMFWFjyk3w8x3wQjINhBUX/XILgpSi9+9ZLvj0zlwPB9oZ7hg+D
         i1NUHm7a01+Am+J2L0H/VeQfL/lXfOyAE74bSt4DFhd7hC0PYuHmmGDczZb8dL8vdGeW
         6PPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Gh9KnnWkXTk5gAYH3Ad4z+xQUIObfJnKEBk4Xxg8wE4=;
        b=aEz7eknIvREwH9Vp4Pm5eJ2jwdqoiZBIYbooyH/UE8bpzt6RJLQ8+ZW3gFGxtYhg2C
         MzEAlQzaiciNLbn5vgQFjNxYEgxZglU/ctd7uvFkfEIDXZIfo0N5K/oKMWMsvh7eGrXR
         qdZ5h1WtaMXACOceTmMYZT6c/is0KQwzL00twpjGMUUr3PUzRs2etrh0HbsYv3iG5n0J
         kpZe7tdESrIDviVqeIWDCS6r/kj/KmrbeTtcOxiqZoypySSzKNLYGx1nSGdlRr29U+b/
         YXv1J8rbcn50dgyfS92hZcDRps7yI9sOlgGLGwpZW26yDM0ap6NgQyLd61Z5+S94k5+2
         9x4g==
X-Gm-Message-State: AMke39kV2L+YbawlIc3Xl6rFd5TBO/b82GD04WvYAVzysvZyl81hT+1voadQlvux0bgRt80X
X-Received: by 10.84.217.153 with SMTP id p25mr44478961pli.164.1487205502271;
        Wed, 15 Feb 2017 16:38:22 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:2ca1:506:4965:89ed])
        by smtp.gmail.com with ESMTPSA id d29sm9523932pfk.83.2017.02.15.16.38.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 16:38:21 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, bmwill@google.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 02/15] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Wed, 15 Feb 2017 16:37:58 -0800
Message-Id: <20170216003811.18273-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.16.ge4278d41a0.dirty
In-Reply-To: <20170216003811.18273-1-sbeller@google.com>
References: <xmqq8tp74823.fsf@gitster.mtv.corp.google.com>
 <20170216003811.18273-1-sbeller@google.com>
To:     unlisted-recipients:; (no To-header on input)
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
2.12.0.rc1.16.ge4278d41a0.dirty

