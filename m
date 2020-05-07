Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C978C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C55A20870
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H2ft/sm6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbgEGKAF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 06:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725903AbgEGKAB (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 06:00:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE740C061A41
        for <git@vger.kernel.org>; Thu,  7 May 2020 03:00:00 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z6so6097659wml.2
        for <git@vger.kernel.org>; Thu, 07 May 2020 03:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=H2ft/sm65KsEiWUsYkyJtYcqhVXqnnJzohyVBxlnKckbrXNBiF0/wqgIPhOQyRGSgP
         6eho1fIA4U+8upMXzBZi5/wsSVFHIfCI72xDTSHOvW7eCUJhBNb0lXRY5b4f6jtltCmE
         Nq/XoDaNIg/Ir9Bx1FLm5pmHX69E22gZFZaWFU2T9T4q2HFPlAsSAKKTEg2IA5qRZWMJ
         Xw88dibs0RwWpfvtS1AOMST9SFcN3Bo9VdIYt/AusG2srXGYVvuiqgDVfGJe5tPLGUWR
         e86brQLl0w7NCyLJV8e/2Phdd9FWTENfxyJzy3zoBKAtoO1Qb2q1ZfFxZEZgzvpNLMWa
         WfOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=jha9qf+U0TMCtaf8/p3Bv9/hOa+QxlKGFXQdU4ElIOLqt/P55q7zcrPjSwwDBHuzqL
         QGN4pWvDEWq2bKrQT2wsSMFMJgTj/6eQTWa03A3Expb47bGae4OWjGozyaRH9htKyjGL
         oncb8FPW67L+61Yx9kV+VAgsgP1QfxNyh0+drQn/3AzZ8MgqBXDzfbvZr+4ZS43kuncV
         cj/yIXafTIUDMmEEdBOBghBBTmD/5TfnpS0/nM53EOdohznrDVyZlVdUTj6uFJUoWvna
         vvfwtVxRr4vSRDxdCysHhHGPJfXnIMXKQy0d/M+zK0tpKT/a2RjQAH3kiYoi5adeIt9X
         Nr/A==
X-Gm-Message-State: AGi0PuazzfR+MsY3T6HEqiPgiI7vY2ptYqki3iIwJxEqi24kHhzmDSh9
        Y3g3YoIDDxZoF/ziAJ5mP7MlbE6H
X-Google-Smtp-Source: APiQypLN6njD0x2fyA5eioy/iQiJcUB1IWZqH1kFnNcyyzdnIItlC99VO3DHiWF+2p8KWmygetaU7Q==
X-Received: by 2002:a7b:ce88:: with SMTP id q8mr10042668wmj.161.1588845599114;
        Thu, 07 May 2020 02:59:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f5sm7223014wrp.70.2020.05.07.02.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:58 -0700 (PDT)
Message-Id: <94fcc6dca6a5281294b6ad272db08d7c165aa574.1588845586.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:43 +0000
Subject: [PATCH v12 10/12] vcxproj: adjust for the reftable changes
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
index 5ad43c80b1a..484aec15ac2 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -710,7 +710,7 @@ vcxproj:
 	# Make .vcxproj files and add them
 	unset QUIET_GEN QUIET_BUILT_IN; \
 	perl contrib/buildsystems/generate -g Vcxproj
-	git add -f git.sln {*,*/lib,t/helper/*}/*.vcxproj
+	git add -f git.sln {*,*/lib,*/libreftable,t/helper/*}/*.vcxproj
 
 	# Generate the LinkOrCopyBuiltins.targets and LinkOrCopyRemoteHttp.targets file
 	(echo '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">' && \
diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 5c666f9ac03..33a08d31652 100644
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
       $libs_debug =~ s/libcurl\.lib/libcurl-d\.lib/g;
@@ -231,6 +231,7 @@ sub createProject {
 EOM
     if (!$static_library || $target =~ 'vcs-svn' || $target =~ 'xdiff') {
       my $uuid_libgit = $$build_structure{"LIBS_libgit_GUID"};
+      my $uuid_libreftable = $$build_structure{"LIBS_reftable/libreftable_GUID"};
       my $uuid_xdiff_lib = $$build_structure{"LIBS_xdiff/lib_GUID"};
 
       print F << "EOM";
@@ -240,6 +241,14 @@ sub createProject {
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

