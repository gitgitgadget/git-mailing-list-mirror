Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 707C6C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B83206B8
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MySOvlu9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgEDTED (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727828AbgEDTEB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:04:01 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A170FC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:04:00 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id h4so682792wmb.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=MySOvlu9Vl0jXfVuSCNV5tdDfhml3zjLM+OO54s9nDKuG4N+lDtQ6ixg1jFTXeUJAq
         ngH3Lk/iroQGujPEbWaRZDZTKliKiQvL0d8/0wJgHAl/602OrbtC9oNhE1gTojhKULyu
         QgYXPJcpHpW0Rsea2avO/a7yPYAY286iL0iLqKc+b/3RPhMN0eYPTyJdJFYObWyPgPdX
         izfjEtW5uceuUbVoB3s3mCa/DCMOiKd2/3SSB8JPoo/+ciszHOch+9CtsSJ4ewiynif6
         fOyqO+oE9k8W2M4N+uCSNHWTXBcrnV1kz4kKkxMhVhlhiFkofs/s6q9okYu6STUVeAPx
         olZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Vup9MT8sfUcv6xkbQAWR68a1iVgFiIUVwHGrIXy026Q=;
        b=Y6F+8IDXFO86q8x6jDObUHxMbB0rgfgOwJt3L0Ed0rtFZm7oTrdtUWL5bd+e6aImJ7
         Dfn8Zm3YzT57T2a1LatvOIHz9nbDoQZatw8MpprlmlMEPxlB21/xTlGSJrXyQNCVac89
         x4rS5/g3ccurGDZEp7uT3+XHWDCybCr1fdrJh4BdJMR3PTd5GO69tf91DOTgQ60mkUsc
         70Koz9dIskEsazrQcS6dr0se1ityS4qlOzROGc0O+QN2TPx40DjpS4f07SokLGw+rSxR
         Zu9BFL7PrSxxuD/axDtTl+wPjaF0+s/tEm6BAU29xT+eGB73ysXZOdWptaxxarqDefr0
         O16w==
X-Gm-Message-State: AGi0PuYQ2XlFE3/3Gf+3Wk3yfVRjjuTUhNNE2Z2IUhg5rtP7t7kwE+t1
        kH6LUA24vIula4f6LraNi71hSlj3
X-Google-Smtp-Source: APiQypInO7z+eklQqJq/itGmZnzNNVngN9IdnlvQkDeau5BaQguankjpQQipJFIIBKH5xYCP/5r57w==
X-Received: by 2002:a1c:bc08:: with SMTP id m8mr15966073wmf.119.1588619039222;
        Mon, 04 May 2020 12:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w6sm13431303wrt.39.2020.05.04.12.03.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:58 -0700 (PDT)
Message-Id: <513d585f0f8ad33948ea72b1f8cdb87125840cf0.1588619029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:46 +0000
Subject: [PATCH v11 10/12] vcxproj: adjust for the reftable changes
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

