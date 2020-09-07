Return-Path: <SRS0=kCdt=CQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F653C43461
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 06:00:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F68D21582
	for <git@archiver.kernel.org>; Mon,  7 Sep 2020 06:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="siZO7Z3+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIGGAM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Sep 2020 02:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgIGGAK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Sep 2020 02:00:10 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C73C061573
        for <git@vger.kernel.org>; Sun,  6 Sep 2020 23:00:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id b79so12941448wmb.4
        for <git@vger.kernel.org>; Sun, 06 Sep 2020 23:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=EIku5CpnxucEiL2lRJnQAUaNSziOnI1umneTbQVWxNA=;
        b=siZO7Z3+X8wyB/8MDfD81ETpM8oPNTugVN2FJO/QxRlfdaE3WKlvS1hAzi7yoBIIRh
         3ue4GBYn5CXEhU603psNDIeIOTFp9zw2rGnDlZLAn0xWkHWpY4IgmRMP0UiNjSlkVTuL
         OAz+++Yy3iMxUPf+iXCG1epgFIu3ZKuc4y6ReFFg18f6KLod254Qkjy2tWUynsRG5Fe5
         pg9sf4q9FJy1bFEypFF79ZqXgbmVqHjHeEBmLEi1CNBB5pQ38xqtuSlVkoNFMpSTXHdx
         X1dhbSdvPy54IzLLUGCstuTh4hEehoz+CKPuYx28krvWAV80A0rbB16BFLukcNKUTts5
         FJXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EIku5CpnxucEiL2lRJnQAUaNSziOnI1umneTbQVWxNA=;
        b=r+34UWLiQX6/I0F6r2L9GyAa/Jhi5Ko1+ixjAbuaNIJfS+CTZ5KfB37ExOrq/GCJYv
         O0LlsTYneWPu6TqK1S9lPhQrASYS+2y/+Cpw/cVGzDOMJ9vm247K/xBLnb8WVY+1iJQn
         JvM8x/OYqfY+bumFY2VyHmERl+0Msj4azDp7Pp2RiUfxBjcbYqYg2AT9cx0pHDwGGIva
         uVXzvNEGmlULSGLHtMkJ5CpzBObGdfptmFp8CToQoF23D3MoSdaMGJKcg1PwJPiaKCac
         FQGQn1vU8a7kJorEoWhcy1Io5VYfoG1ZlLUyV/ePQpZqnpEPuECqFsm0YJ7MbSmCxIFl
         bSkA==
X-Gm-Message-State: AOAM533tetNN6YKq96id9AKbOpNoEmuQvJIv/tEMMpukgj0J8l2hNwdM
        ooMB1q6//u0Sny4wgHx6BLc66S7VKno=
X-Google-Smtp-Source: ABdhPJya01NczBBK+nWauaEb/MVKxWVMXep6G7yJqdcza+ISqXCkjEYs7XL0TAzzn0qOY280XdOi7A==
X-Received: by 2002:a1c:2dcc:: with SMTP id t195mr17987134wmt.166.1599458406862;
        Sun, 06 Sep 2020 23:00:06 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k12sm25644122wrn.39.2020.09.06.23.00.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2020 23:00:06 -0700 (PDT)
Message-Id: <pull.728.git.1599458405948.gitgitgadget@gmail.com>
From:   "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Sep 2020 06:00:05 +0000
Subject: [PATCH] contrib/buildsystems: fix expat library name for generated
 vcxproj
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>, Orgad Shaneh <orgads@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

expat.lib -> libexpat.lib (libexpatd.lib for debug build).

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
    contrib/buildsystems: fix expat library name for generated vcxproj
    
    expat.lib -> libexpat.lib (libexpatd.lib for debug build).
    
    Signed-off-by: Orgad Shaneh orgads@gmail.com [orgads@gmail.com]

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-728%2Forgads%2Fvcxproj-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-728/orgads/vcxproj-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/728

 contrib/buildsystems/Generators/Vcxproj.pm | 1 +
 contrib/buildsystems/engine.pl             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/contrib/buildsystems/Generators/Vcxproj.pm b/contrib/buildsystems/Generators/Vcxproj.pm
index 5c666f9ac0..d2584450ba 100644
--- a/contrib/buildsystems/Generators/Vcxproj.pm
+++ b/contrib/buildsystems/Generators/Vcxproj.pm
@@ -80,6 +80,7 @@ sub createProject {
       $libs_release = join(";", sort(grep /^(?!libgit\.lib|xdiff\/lib\.lib|vcs-svn\/lib\.lib)/, @{$$build_structure{"$prefix${name}_LIBS"}}));
       $libs_debug = $libs_release;
       $libs_debug =~ s/zlib\.lib/zlibd\.lib/g;
+      $libs_debug =~ s/libexpat\.lib/libexpatd\.lib/g;
       $libs_debug =~ s/libcurl\.lib/libcurl-d\.lib/g;
     }
 
diff --git a/contrib/buildsystems/engine.pl b/contrib/buildsystems/engine.pl
index 070978506a..2ff9620459 100755
--- a/contrib/buildsystems/engine.pl
+++ b/contrib/buildsystems/engine.pl
@@ -349,7 +349,7 @@ sub handleLinkLine
         } elsif ("$part" eq "-lcurl") {
             push(@libs, "libcurl.lib");
         } elsif ("$part" eq "-lexpat") {
-            push(@libs, "expat.lib");
+            push(@libs, "libexpat.lib");
         } elsif ("$part" eq "-liconv") {
             push(@libs, "libiconv.lib");
         } elsif ($part =~ /^[-\/]/) {

base-commit: e19713638985533ce461db072b49112da5bd2042
-- 
gitgitgadget
