Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 98FBD20356
	for <e@80x24.org>; Thu,  9 Mar 2017 22:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbdCIWQt (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Mar 2017 17:16:49 -0500
Received: from mail-pg0-f46.google.com ([74.125.83.46]:36773 "EHLO
        mail-pg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753551AbdCIWQF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2017 17:16:05 -0500
Received: by mail-pg0-f46.google.com with SMTP id g2so13776784pge.3
        for <git@vger.kernel.org>; Thu, 09 Mar 2017 14:16:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cbtUGEn24/AAe7eRTql60iRQZ2h0PlWelXvJYLKmBWA=;
        b=NDwraVTskhZFZ/tkhjYrq1DPIkmAEJF0KxUdElKvTsKUXGaAwvEsNc/LWpv0q4XIS0
         bzKIA6HXWr9XgrQswbMaSV4HGYuDnCMXBY2KydlaWiWt/hLRetozHpq7cD4Q2ajoVuHH
         /oMi59zRCU3aAS3jfXnzS1I0ltw9qY/lqbnws2OI4R2iiT016KbuFaIg5YF3gUgPgyP1
         ef4j5XB+etGnDXuXskGcL2ztOqRl6ZK6AFIKmIew3NK4Jdvjfkq6t/EYlJo/OPkAkgtB
         kIlprcWUaWQJSqK5woMw8pyvymOH9iawrqJEEKoDPXWmIMDF89tHyTsbMRD3DQLiHWZ/
         ZGfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=cbtUGEn24/AAe7eRTql60iRQZ2h0PlWelXvJYLKmBWA=;
        b=DTHnJa2gh7MCCGNiX3dSO5mdcosyjB+fucrfIhk+dmZ9g9zoRT49dH/Bb4Vk7MJ/Ip
         xjTM7Q+D0tYjE05I3Sd/eQspTvoXxpLsrr8ubbY5OGTCmcDan2c9tpkEixLxaxa7dGGT
         +1BV1/KD3GNLENfBmseUH1UaAbEju7BGIUha0Joy+ury+cLwy1mTTRUvqwTcGdkY2Rvx
         rwUyyV8nEKAHD1H5iuPzuHz7XJ37M/gfHFD2RFz4WxSCVTCO5rGENz6wyozPvD4FHhwe
         XjNGww245fBdh0Fvc6J2jL1zfPYTLLmcZlaFyA4aQjDkfeFl5IDSYFfj+18lJwe/mXri
         Hg9g==
X-Gm-Message-State: AMke39kfQ28kydxUn4lHcc3DAJOsH+ouU5MUQxgk0B3MeBWYUrUwZB79NI6TDS8I/iF8XGL6
X-Received: by 10.98.24.9 with SMTP id 9mr16775397pfy.11.1489097759097;
        Thu, 09 Mar 2017 14:15:59 -0800 (PST)
Received: from localhost ([2620:0:1000:5b10:7494:19e8:830b:a2d7])
        by smtp.gmail.com with ESMTPSA id 90sm14344116pfl.24.2017.03.09.14.15.58
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Mar 2017 14:15:58 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com, gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, novalis@novalis.org,
        sandals@crustytoothpaste.net, hvoigt@hvoigt.net,
        jrnieder@gmail.com, ramsay@ramsayjones.plus.com
Subject: [PATCH 02/17] lib-submodule-update.sh: do not use ./. as submodule remote
Date:   Thu,  9 Mar 2017 14:15:28 -0800
Message-Id: <20170309221543.15897-3-sbeller@google.com>
X-Mailer: git-send-email 2.12.0.rc1.45.gf291f29c2e
In-Reply-To: <20170309221543.15897-1-sbeller@google.com>
References: <20170306205919.9713-1-sbeller@google.com>
 <20170309221543.15897-1-sbeller@google.com>
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
2.12.0.rc1.45.g207f5fbb2b

