Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3916C433F5
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 10:17:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhK0KUw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 05:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbhK0KSu (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 05:18:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1FC2C061574
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:15:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d9so3252413wrw.4
        for <git@vger.kernel.org>; Sat, 27 Nov 2021 02:15:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vRwUFNplJgt4+gwqzv6BWgFZNHmfb8PSKeS6uRJyz0g=;
        b=goVGN/KZXgSiKiryYiILxZcRKnblytWTI6s5yGYUGPEEymU/tkVnFPiwigE9/S+kRT
         Iff2PsCYJ0iyrJyOGB+afQCOuza8k6ou24B3o/HeuxKHexHSCrSKkiRktXLuz8FBWC4O
         wm6jzoJjFUdcqBh3D6qlH9fMMQucC18WdvgHGSzvs+t7ujyL9SVIhSA1kZRHpMWWOcHy
         vLvL/F4/fbISt9QyPSUXb/k94CJ4WKq/8Z3Y+26TvutGtvhycT6Huj8XcJA1XihwDQOm
         jKrLlerYtl92luaEy3dILTee3TLOhwz+s6Pt/ANkOJr5VzhW1dtDaVVtyukZ4clLKOT8
         PK6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vRwUFNplJgt4+gwqzv6BWgFZNHmfb8PSKeS6uRJyz0g=;
        b=FQw6czUYuldL1NznOtcCrg7Jl9ermCuuIui5YewcL04p262Mu8PIvXnkw36qi84kz7
         AXyeIFBUBW8nA2ixpLkv8h4rylF9F7qcSmRYRddji2LJNlMd3VBRIcjjfhbPxXOiEalJ
         g6xVXszuWlR5IKbhxsMyrQigCSyUGj7JLy0+6X/RQSWJ4eX8auWaPm6VtcEmob9jozza
         PRcFuCtp5U0+MrglNmwirGfjEpQqDcUWfMdHIfjGinmjaZek2rg03VKeeIgRwvwMZoEW
         mxvRbVDfparBigNf3AGCJjEQBJ6FyVkuGD3HqDoc/ud5KLRDfJICBZHUSbThxFS4/wXn
         fL5w==
X-Gm-Message-State: AOAM531oFyS7lkJINYjltqSdFvP2TRntBrNgfnnRzQ4qxVjO6ByYulEV
        Wqh9ZvgZugFezrKVLSlCOzDiakbeYeY=
X-Google-Smtp-Source: ABdhPJx1N6bG+/RMKGlHzssEy2WovGzZUCIJcFxnm9mmeBJQ6amkTZbosZJIYuU4WjS12mKZ/s4fvA==
X-Received: by 2002:adf:d225:: with SMTP id k5mr19870418wrh.612.1638008134140;
        Sat, 27 Nov 2021 02:15:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m125sm13306213wmm.39.2021.11.27.02.15.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Nov 2021 02:15:33 -0800 (PST)
Message-Id: <pull.1142.v2.git.git.1638008132992.gitgitgadget@gmail.com>
In-Reply-To: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
References: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
From:   "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 27 Nov 2021 10:15:32 +0000
Subject: [PATCH v2] mingw: avoid fallback for {local,gm}time_r()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>

mingw-w64's pthread_unistd.h had a bug that mistakenly (because there is
no support for the *lockfile() functions required[1]) defined
_POSIX_THREAD_SAFE_FUNCTIONS and that was being worked around since
3ecd153a3b (compat/mingw: support MSys2-based MinGW build, 2016-01-14).

The bug was fixed in winphtreads, but as a side effect, leaves the
reentrant functions from time.h no longer visible and therefore breaks
the build.

Since the intention all along was to avoid using the fallback functions,
formalize the use of POSIX by setting the corresponding feature flag and
compile out the implementation for the fallback functions.

[1] https://unix.org/whitepapers/reentrant.html

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---
    mingw: fix 64 bit build because of missing *time_r() function
    definitions
    
    This is a cherry-pick from git-for-windows/git#3398, that is needed to
    be able to build recent master with the Git for Windows SDK or recent
    MinGW64.
    
    It was discussed recently on list[1], and might need further
    adjustements if the 32-bit Git for Windows SDK also updates their
    winpthread headers, requiring a similar fix, but since without it a
    plain build from master wouldn't work in Windows I think it is worth
    reviewing on its own merits, and had withstood the test of time in the
    Git for Windows fork since it was originally merged there late August.
    
    Changes since v1:
    
     * Fixed grammar in the commit message (suggested by Junio)
     * Added ACK (proposed by dscho)
    
    [1] https://lore.kernel.org/git/20211005063936.588874-1-mh@glandium.org/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1142%2Fcarenas%2Fwinbuild-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1142/carenas/winbuild-v2
Pull-Request: https://github.com/git/git/pull/1142

Range-diff vs v1:

 1:  363b644f801 ! 1:  c6b3fc5a16a mingw: avoid fallback for {local,gm}time_r()
     @@ Commit message
          _POSIX_THREAD_SAFE_FUNCTIONS and that was being worked around since
          3ecd153a3b (compat/mingw: support MSys2-based MinGW build, 2016-01-14).
      
     -    the bug was fixed in winphtreads, but as a sideeffect, leaves the
     -    reentrant functions from time.h not longer visible and therefore breaks
     +    The bug was fixed in winphtreads, but as a side effect, leaves the
     +    reentrant functions from time.h no longer visible and therefore breaks
          the build.
      
     -    since the intention all along was to avoid using the fallback functions,
     +    Since the intention all along was to avoid using the fallback functions,
          formalize the use of POSIX by setting the corresponding feature flag and
     -    to make the intention clearer compile out the fallback functions.
     +    compile out the implementation for the fallback functions.
      
          [1] https://unix.org/whitepapers/reentrant.html
      
          Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
     +    Acked-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
      
       ## compat/mingw.c ##
      @@ compat/mingw.c: int pipe(int filedes[2])


 compat/mingw.c    | 2 ++
 git-compat-util.h | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 9e0cd1e097f..e14f2d5f77c 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1083,6 +1083,7 @@ int pipe(int filedes[2])
 	return 0;
 }
 
+#ifndef __MINGW64__
 struct tm *gmtime_r(const time_t *timep, struct tm *result)
 {
 	if (gmtime_s(result, timep) == 0)
@@ -1096,6 +1097,7 @@ struct tm *localtime_r(const time_t *timep, struct tm *result)
 		return result;
 	return NULL;
 }
+#endif
 
 char *mingw_getcwd(char *pointer, int len)
 {
diff --git a/git-compat-util.h b/git-compat-util.h
index d70ce142861..c8005db3fb6 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -127,7 +127,9 @@
 /* Approximation of the length of the decimal representation of this type. */
 #define decimal_length(x)	((int)(sizeof(x) * 2.56 + 0.5) + 1)
 
-#if defined(__sun__)
+#ifdef __MINGW64__
+#define _POSIX_C_SOURCE 1
+#elif defined(__sun__)
  /*
   * On Solaris, when _XOPEN_EXTENDED is set, its header file
   * forces the programs to be XPG4v2, defeating any _XOPEN_SOURCE

base-commit: cd3e606211bb1cf8bc57f7d76bab98cc17a150bc
-- 
gitgitgadget
