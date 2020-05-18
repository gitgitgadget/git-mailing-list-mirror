Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 614F6C433E1
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C2DC2081A
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G8FBgz6j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbgERUbk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgERUbg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5750C05BD0A
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n5so986028wmd.0
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=G8FBgz6jPcAYSRXRoWgo6rAPRqH/3wqb54DiyBMgOYOlAGsgMgjXfgV/hWAi52PO7c
         GNq5FKt/nbjDMXEd62+S/xM7X61vojAhtWNUVHn+TnV0XiQnPBQZvBeNSTYc2OfnbPz0
         hL8O15K+kT/tGTh36xCZvrgyJ2xdoWIxolxNJtNT2Tud1XaqoR/LEo81XtBzaK5o2+Yb
         /qAWE4wp6BVQzv9o5gVW28rg5nBibH6G7eRMiH36S1Zuvddgk53Lef5J9QcteFWr5c49
         9VnuWYxi8cy52bZIsYApLhaifsXIR6lBXZdbvIPb5+gWNLSA+0tLpfh6pbGr+OQ8F6y2
         1RkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=sMaO/MLuNGXCVXh6b5mH4JRzeArZripp2CcpiTH9gjNAPm7FuzZmRxAPVa5hAJ3l5O
         vCHKvyYoaAwzYC+pp8RatJ+dp9dw1BlKn25vEOJfZ+p8vEJrB9mGo9p+XZoZ2jAAsMpm
         q2V9ypX5iq+GgXbi5T7CVLRqZVrhqcEw1nD1BK1WDyIsWGYJy8JLgL/XgFFlb/QUdRCf
         HwCjm2zqQsYJu/W39KIjtGm0JwX4ly1Zin7YYMcaFNT7Rf+NgCZCdw+RL4MPndE0lGB4
         +0EQVkIukYJncY34B0iOBFpuiVGoDQjPZukZbMtq21KUg1XlEZtjS3Subau0Q04XuPVc
         5Q/Q==
X-Gm-Message-State: AOAM533dKWZA7My63o+M9mP33NdO9lbYGs5ZJKkwQTE8zDhTwefy2nHA
        fM9t/z7YU1Pk4+QjFfe5B3MAReqp
X-Google-Smtp-Source: ABdhPJyitRbRdwmda2HxYqR35iN5beDNTSFPDA8VtJwxE2xno5zb2nEKPDYcrr5ZXldDWy93JQ1cNw==
X-Received: by 2002:a1c:208a:: with SMTP id g132mr1204632wmg.78.1589833894145;
        Mon, 18 May 2020 13:31:34 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d6sm13293634wrj.90.2020.05.18.13.31.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:33 -0700 (PDT)
Message-Id: <54102355ce71a1c9108e832662d91890d1c7a9dd.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:23 +0000
Subject: [PATCH v14 8/9] vcxproj: adjust for the reftable changes
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

