Return-Path: <SRS0=RX4d=75=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 699CEC433E3
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4497E20776
	for <git@archiver.kernel.org>; Tue, 16 Jun 2020 19:21:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khlEH2LQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730805AbgFPTVE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Jun 2020 15:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730746AbgFPTU7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jun 2020 15:20:59 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF5DC0613EE
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:59 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r9so3930390wmh.2
        for <git@vger.kernel.org>; Tue, 16 Jun 2020 12:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=teX7AqpUfUWLns9KilNy8wSxyty44dVk2EoRcGz+lx8=;
        b=khlEH2LQ84nrsJqFYN/6y0xh5TOa4rWIrURMGc6hmtRbUo/C0tQMX57a9wqfbC6ZUp
         Ffpw66ray2STxgn6+CuIGA+Ai5h0SyPoV8LKTzrdiRMY4/sPbwMWgGbJRKNwPnjziI9i
         h9BvfHV/LGT+Pfe2lESFtrP9K8BfMsp7mkoVCM+4BCywDXzP3mr9AnMQYzocW6nQI0d6
         SizImbKCQD9CBkXQoxoR344+e8KU+aEg16iLoghA2Y0o1rwT0qKh1zdKTBja1CywtWXd
         ua32nLLyxyCAlfql+X7AB1IqWCf32p5ymh6BOJpPEssoa05fi5d+L3GM3sKn4xp3+Ej9
         EspA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=teX7AqpUfUWLns9KilNy8wSxyty44dVk2EoRcGz+lx8=;
        b=P4EN4X7eWeawe+r0Y2EWpH0EpkjdFNywe0dFkdA6IeqP6Ulw9E4lr7TEsvDW9J2WAR
         zBzam0xQ9zul+RJo/pF7YvnKSFs8O7ge1y7PQctFJYGJItZEbJbIoSH6GQcrwwQDDjKv
         +DdtlhH5n+T2utvD+U5skYKCy1kFJKTOa7UptLxPvN0Mv/gYegBAPl2xDg1Xwow+S/CT
         SGUxJF2E3PvjnCyeyKVBat8rVdJceMtdbWY52n1DEMSdKnaM3WQNGiTsgm7c1jfn6kaC
         0ukBmnd0BCr4fcyjLK3mtii93RKICygmNK9bNaCWgSVuhZEr3ziXa6zqOmLQDrjCi8Hp
         S4Pw==
X-Gm-Message-State: AOAM533Tr2xaJlrpdzSps6nwSn006wu2zPgzWfmzEMj1k0sP+twRmYTe
        frXB5XGTQxelKUsyHJSImqLaa//6
X-Google-Smtp-Source: ABdhPJxk0NcVMgz6XyqxPKzAYoryRi8vF4dXTAleVpvTDAQG3uIgyw1WpNopALWEuucN/s0ONJdxPg==
X-Received: by 2002:a05:600c:2944:: with SMTP id n4mr4955231wmd.135.1592335257815;
        Tue, 16 Jun 2020 12:20:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r7sm4907517wmh.46.2020.06.16.12.20.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 12:20:57 -0700 (PDT)
Message-Id: <1c0cc646084afb926f7bcf26e0d8fcadd724884f.1592335243.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
        <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 16 Jun 2020 19:20:40 +0000
Subject: [PATCH v17 15/17] vcxproj: adjust for the reftable changes
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
index c7eba69e54e..ae4e25a1a42 100644
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

