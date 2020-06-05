Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BC9C433E4
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 588C7206FA
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReqgorVZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgFESDp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728130AbgFESDk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:40 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23BAEC08C5C6
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x13so10652725wrv.4
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=teX7AqpUfUWLns9KilNy8wSxyty44dVk2EoRcGz+lx8=;
        b=ReqgorVZiY1J3lv1krYgXvE88igK3SSIZxzr1sK+gm0e+/ITJGCTfqcrk21lIjdMHW
         TX2oFDtG6BE7CcvkMDTetvx0SNSF1xPEeU5eIEBubXpVGUWPZOLij3B++Xv1/vD1yiAA
         Rrdb/v2WRflGc7bP5vtB5jxPoJ2r3wRQ3loLCjDRPHbPsL/cf4+B5+N+rK8nFU12YXBI
         U+O+Z1B10/t7PeYMDEmhg84ULZC2tKZ+/cSQAO3cTFrhGTB/EdhONZelEATlkwC9L3ea
         6eIaXzGSP8FD6CMMLus8riYD6d8wUVeecmgInxz4/VLWHJ//1bVpSrTgPy5t2BnT5xtJ
         +9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=teX7AqpUfUWLns9KilNy8wSxyty44dVk2EoRcGz+lx8=;
        b=hsPcWFtq4tfo1Sngk9HfrpXbBc/bcs+6MMQlNW1sRlfMo05ux1I7+mpPYFM1nPVodN
         X8/u9LmniZrQQPJHGWhz2hvyYmeoZeRgq/R7O0xiRRyQbUKaNsDMCYYzkQlls9IFMtwY
         lmeAo8hrzCVQ2mH6V6ov+5VDn9/hJSylmH3RDOlFamcYt6ZtRphrktnt9MNzymgZqwUw
         P7e4ZsmtQpvXdmL47UdaHcgnwERjEkBlMzTsFZ+XAuWb8PywVgdMH5154//1k1NwsXT+
         1IHEzObeJzxzzQObHEbxhQXgGn11TPaeJToWez6/9i721UtKEvg654J+v0p1scRjb8RL
         nNWQ==
X-Gm-Message-State: AOAM532kukXpCFYrZ6SGYhsB05HO+oeGflceadUa8E5z9TUZTpmu4efO
        IXx57U4oxEOsSZkaH0h5FkCRrbfB
X-Google-Smtp-Source: ABdhPJwHOsVM6p1PJlkxWRGkgD20VCR53Bw0+i1JSad+6XvGWpZegwVkD415zCUleHw4WXt4wMpxDw==
X-Received: by 2002:adf:f552:: with SMTP id j18mr10310382wrp.279.1591380218771;
        Fri, 05 Jun 2020 11:03:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h12sm12537105wro.80.2020.06.05.11.03.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:37 -0700 (PDT)
Message-Id: <0471f7e3570ba8a304ae0a621a1d4591609195df.1591380200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:17 +0000
Subject: [PATCH v16 13/14] vcxproj: adjust for the reftable changes
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

