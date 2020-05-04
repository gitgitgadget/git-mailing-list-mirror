Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8338FC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598032075B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 13:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CH78vt6S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728476AbgEDNbf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 09:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728418AbgEDNbe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 09:31:34 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1D1C061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 06:31:33 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e16so15830276wra.7
        for <git@vger.kernel.org>; Mon, 04 May 2020 06:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=0y90PgNm96SfrAVrmM5l9tEIZHz3AcvZTUZyDq6Nr8k=;
        b=CH78vt6S5CMVtiD5d9jTkZjp0oC1nPVDbGX211zBmYpGX6CoiCA6RVrmjNCpsROV3P
         uxO4zYWNnVZIUpocVpYNd6rdlTqBBgy0mDhYYWBbSbtmQWhLg43XdbLRkgSzwBwSl+er
         ziTprIJrfhNnS6MeKEExa6852Rq9dpHmFk+LqV2Ij5zXzHg2CpwVt9pC2i91Rl7jCKdj
         wFTGG4/h/2WOxvpgYNf2GjoaB87m/dKz/OA68OZRvSMpdpsh8oAhZ3s4ZOBVLsEmyKn5
         XZsZdgHQZNvTXjEvt/W8VrApvym8NuAnorofQWgY54Gw3tqD3Q+tEZ8zY+3BzR5abd2f
         1qmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=0y90PgNm96SfrAVrmM5l9tEIZHz3AcvZTUZyDq6Nr8k=;
        b=iDsstoF8kMMMMUMb8VZ2XESO8vVn00JcsW+wRBOhwIJSUXMTrkc90c+ROYy5V7iV/M
         tdqXPqHT6p+de7lI7TRcnnhQW5a/8YYlHkx2pT4F4HnyA3reHnpcqap966SkhW94xKhC
         yGI+8V6FaQlG3YzCyUQM3TbVS/PLigMUF82MOWH3UzKVEu9pDr8ImfjXwkvsg5v365sF
         +UeH3e6oifAW1/u23t2hBnFfkzjUnMCOc8nTLqY6WxImJLL0tARF1p5DUCzIQ9LTFaH0
         ckF5a5mKvKR2j0ar3cOgGomxldadFBWRYlDcB/8DOCey+445cx6lLo99HD1ryvny7b2/
         R53A==
X-Gm-Message-State: AGi0PuYPL4g7JvglEtRNCBO3Sv/PBYgcSgPmcTCT/nOO4bc+3wIoY+tm
        8cQKMfzxUYQM0UIPepU+69RxZd+i
X-Google-Smtp-Source: APiQypKjQd+wXV4gwm8ghqIu5yXLNR7pomV7CAl6z47IQl42UOxT231qxpm2nkjsl3D33Rj/DatHYw==
X-Received: by 2002:adf:e90b:: with SMTP id f11mr722897wrm.364.1588599091734;
        Mon, 04 May 2020 06:31:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i129sm14269253wmi.20.2020.05.04.06.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 06:31:31 -0700 (PDT)
Message-Id: <d05b9b9a2e0a49b1bacf0dafb99d36cd213181dc.1588599086.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.623.git.1588599086.gitgitgadget@gmail.com>
References: <pull.623.git.1588599086.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 13:31:26 +0000
Subject: [PATCH 6/6] vcxproj: adjust for the reftable changes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index 0ab8e009383..8a01a0da3f1 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -700,7 +700,7 @@ vcxproj:
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
