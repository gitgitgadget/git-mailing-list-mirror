Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92B09C433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F416208E4
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uTcbnTjr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387515AbgGaP1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387502AbgGaP1m (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:42 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1DEC06179E
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so24802315wrm.12
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BwkAJ+xVXva5JeLnKBnTItz761Bu/3yszl+u7hMeHq0=;
        b=uTcbnTjrF7fBYAuiL5PxtzOnosI+9SOcKoaguZLEMEk6/EvV8KEIuUaB8IgJ2mD7rq
         2M4G9S8Udqzm2vvPLDkUNqfLQDEdsY4aS/cEEVEeZj9GnkHSll4EE5oCzWfEqJgHde0o
         27K1xEuJUSYGEaudlklGwAGcqv6hPEOgZZjI0bk5s3S9xGmqIi8I7iJeVxg3UaldMB9M
         Ae4XSydgOYsDx4Y9Wb+o8izU0bmvZtXp49LbLnGgxRaDAHAJ8oQRcJ4onUP+2r/w2kc0
         GcyT7SchgoZw/kG3VUAc4I74AVgwPP77wBi4z/V87TlI+NqzslgwHt89oSk2QhY7pusW
         TPHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BwkAJ+xVXva5JeLnKBnTItz761Bu/3yszl+u7hMeHq0=;
        b=fxlThI8bnEXu9Yx1UMny9QhOsanHQGXxAETJ1gJbNAJmFw1cHlRR8YL62b8/swBgZt
         gmguT4NbjG9Cb239VUC0U+kETGC73LszVLAhfVm4fMcVgJK6fCbhIG2gx8pY95K63GSI
         NOyzeu43jKr8pNd5cULpVfbmwzIR1hwgblTfGCkGA5oe4lXJRtNW+x11JKVIidpN7BS4
         jp/gZwmzDfi4i8KkOLiLvqv5JK3b/kNkRDcBmQeIADcvQYQDJ/zqb6lAMxa7itYAf3Fh
         Wq0IUb+O4150B7HRcrhmnAuMpPmqToFrl/jYSG1ZU5CrzDZYei8XB5e2CrQaJdbYtfcP
         0gYA==
X-Gm-Message-State: AOAM533KX1/cZl1URidV21k2CtrEX8EArD1FQlHGwdzSxQzkpjralhqf
        yAeFyT4hUNQ4lTd+h0u128IpIUK1
X-Google-Smtp-Source: ABdhPJzx8d6PsSDeFYDEbrvApshsDOCyMEJoFP2HjUIJUvWtAwlFU5FvRJJLu78hIaghJR9Lz4bYVA==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr4103255wrn.10.1596209260514;
        Fri, 31 Jul 2020 08:27:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm16097434wre.5.2020.07.31.08.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:40 -0700 (PDT)
Message-Id: <9e6cdbe2042d61c19ec8be8b091fdb075a4b581b.1596209238.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
        <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:27:14 +0000
Subject: [PATCH v20 18/21] vcxproj: adjust for the reftable changes
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
index 5c666f9ac0..33a08d3165 100644
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

