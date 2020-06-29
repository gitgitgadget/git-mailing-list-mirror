Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBF8C433E0
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C0EB204EC
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 18:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aBaXe8qk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729193AbgF2S5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 14:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgF2S5R (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:17 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A482C031C45
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id h5so17627465wrc.7
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BwkAJ+xVXva5JeLnKBnTItz761Bu/3yszl+u7hMeHq0=;
        b=aBaXe8qkAz+6WwFGvjhKhSPzk2N9eyKmIk6N+ZNpaSPsm33tQfQ9FTIWnGKUu5CD6b
         8RC0P1F6eH2OrN94gWbqNneoOuqvn6VlrF+oFiIbEjLRKxN0E6XEsoHzufrTy7aHqVwd
         sxnizIpJpoUZz0zOthlP31w9ws/kn7X90TITGTkWK8hHDqf5i738KPA8ZgijiF47IThY
         Ur3NqtVQmhagvFH2CqwL3ZYy1aiqtWKhhTvpYQs7pIbq8l3MYp8BLWusrdjM6C7tzwp+
         XvH3ZKSOwjSGTGzB2/tu7aY5+4Dw+Gm/z3zO4k219+2nSzBchinFRblMi9lhqFH+VRdJ
         hAuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BwkAJ+xVXva5JeLnKBnTItz761Bu/3yszl+u7hMeHq0=;
        b=SSt9wcx5RCVGZfvq19zLBbxIkOnmvNXrOs8yx+lVwua7BdVtYYA07dErQfIzaTUCGM
         RKoQXpWGANLoshUry52Nlpd71OVnw8Qt5LBqan33QlpLsnC2WKSpnpgjIJNNHCyVNDT5
         uYK2NdZps/bngSm1wDuA0A45BhoUJOkjUN7SseXpa62BzUXTFOxt+rhZi3uYYzcXhM0D
         fDtb6xlSPmkY41LPSujZEDiczUk+yG3+j5zAvVz8ZjJ7CarxpxrqB/FrT47XsFEYppCR
         5Thd81gRKKIAyP1FlsCJjZC3/eCUnQ8HNHBHFl6ofI0mk6vcYG4vCQOB1CRABvLe9Xb6
         AUkA==
X-Gm-Message-State: AOAM532DSQ0qNcHvH28NsbxrKlUB3NNn45BrcpeRPbb+Ijl0TjoyDA32
        U0aSAnW+yBbQblx8/HLm1VcdoKXH9PU=
X-Google-Smtp-Source: ABdhPJxYRC2Q4F6AfD109VhW/J/Gkb0n0cTwHNBcX0Ch0EI19ssFPpxJVoS8ymGYapi9XMJ3Y0z2ow==
X-Received: by 2002:adf:f18c:: with SMTP id h12mr17628102wro.375.1593457035855;
        Mon, 29 Jun 2020 11:57:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u84sm808397wmg.7.2020.06.29.11.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:57:15 -0700 (PDT)
Message-Id: <ef0dd45f07e580044cd7f754d39e4c48a3cdaf7f.1593457018.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
        <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:55 +0000
Subject: [PATCH v19 17/20] vcxproj: adjust for the reftable changes
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

