Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EE3C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DCD920732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 19:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHKPXzTM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbgIPTL4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 15:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727931AbgIPTKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 15:10:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD4FC06178A
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id c18so8002745wrm.9
        for <git@vger.kernel.org>; Wed, 16 Sep 2020 12:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pZ2hp4nVBTwWqQ/pDtPoObitDzqIz4DsfgvNh55oEl4=;
        b=XHKPXzTM9KzT45+lQqgamV1rGXlMIgr8b1THfn8zKmCxlDNLPpJEHG7oQJBnxEvolz
         no3KKZRDxSBIhHfO1C3oBJh/+UHUna69lb3c83yBno5MwN0jBdl8QQ2T3UcEEsZe/QJU
         el5ghqenbJx56KyF3CmIaa1MxxhNo35fHFK5XhRzLUwZHOG8RCgOAeG04eZ1pIJVi1Zp
         pYMJlWdIJEdki0+tfVa6STmzVKsQ4I110QngyhzBA1A68cCrRVtbyrTVKaj81XMGZ2C0
         H2OjErEye5Z48t0pqoUvzi2fpzwLQ7C0LieL0lq4nCY1gHySSDwJZ0oGfHFQ4G0yUKLk
         X8sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pZ2hp4nVBTwWqQ/pDtPoObitDzqIz4DsfgvNh55oEl4=;
        b=JaWLUQtKNu5Fz/Ma30+KN/TW3iu9jpDpnKb0drldcuTN0Ux5sxUWvL9a9ptVi/7cca
         q5wjipTa/gvNyqPktM3CJoBLmQ1+skZIkoRKPxYSiipDgsBdMziWssg5bKXmp9d8CR39
         zLmYamzh0Bb45u/7T2vYFPLBygrUAu5f27l/DUUKESctcowqHypWZzFZ3hZQr4eSgBiv
         o0lIAg5FUbwhbG39wbYi9PVH3euaIm4+h4mSgC35XIqSxYuMoQ8yVL8kHf+3Sv+3tQrH
         tq1DTdBOc9Mrn+1iwzCnASpRa13FZg365QcPjq1bP73rinGSrO1m9JWfb8lQfM8ih606
         CEAQ==
X-Gm-Message-State: AOAM530C1THorUu1PP0TdiFYUzymVgygGHGbmbLFsdQ1Khm4NXYcEQvu
        wfuRPlLvWvzLbwwuwqrkJ7W4Ih6xERg=
X-Google-Smtp-Source: ABdhPJxbYqHUn4vnncQpkruqY4pc9lGPluJsygu7z8vdstzZqCajAWnso5OPQYbtHgvUkwYk8NPZ5g==
X-Received: by 2002:a5d:680e:: with SMTP id w14mr26644543wru.50.1600283419821;
        Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y1sm6654779wmi.36.2020.09.16.12.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2020 12:10:19 -0700 (PDT)
Message-Id: <0f6efc065c9a50966fdc2f43a6c3c1d526a56364.1600283416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
References: <pull.847.git.git.1600283416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Sep 2020 19:10:06 +0000
Subject: [PATCH 03/13] vcxproj: adjust for the reftable changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This allows Git to be compiled via Visual Studio again after integrating
the `hn/reftable` branch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 config.mak.uname                           |  2 +-
 contrib/buildsystems/Generators/Vcxproj.pm | 11 ++++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7eba69e54..ae4e25a1a4 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -709,7 +709,7 @@ vcxproj:
 	# Make .vcxproj files and add them
 	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
 
 	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index d2584450ba..1a25789d28 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -77,7 +77,7 @@ sub createProject {
     my $libs_release = "\n    ";
     my $libs_debug = "\n    ";
     if (!$static_library) {
-      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
+      $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib|reftable\/libreftable\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
       $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
       $libs_debug =~ s/libexpat\.lib/libexpatd\.lib/g;
@@ -232,6 +232,7 @@ sub createProject {
 EOM
     if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
       my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
+      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
       my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
 
       print F << "EOM";
@@ -241,6 +242,14 @@ sub createProject {
       <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
     </ProjectReference>
 EOM
+      if (!($name =~ /xdiff|libreftable/)) {
+        print F << "EOM";
+    <ProjectReference Include="$cdup\\reftable\\libreftable\\libreftable.vcxproj">
+      <Project>$uuid_libreftable</Project>
+      <ReferenceOutputAssembly>false</ReferenceOutputAssembly>
+    </ProjectReference>
+EOM
+      }
       if (!($name =~ 'xdiff')) {
         print F << "EOM";
     <ProjectReference Include="$cdup\\xdiff\\lib\\xdiff_lib.vcxproj">
-- 
gitgitgadget

