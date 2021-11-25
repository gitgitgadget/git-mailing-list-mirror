Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8931EC433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 05:25:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235317AbhKYF21 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 00:28:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231435AbhKYF00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 00:26:26 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4D9EC061574
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 21:23:15 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l16so8870489wrp.11
        for <git@vger.kernel.org>; Wed, 24 Nov 2021 21:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=7B77aReB6qhj8DW3rGc39Jmjz7r2DqPWv4WGBSoMo0o=;
        b=FLiIgz7242H1rTKZk/IB3ofZXZXt/0aHtUVZ3mGCRvnLROtzU/umeTseS5iORnLgWs
         t5GrGDm+v+TmHwTjanvuC3SyUB4P3OGhTqsLi9d9xT70ypnRZDGlbJ8sRWBffGoqWqLD
         zP4jglBS+zSrOsVngWiyKdPvRHoe1JNpgzOKuLx4xdR+/kR/ZRl4IT+gxEuABskEKZqH
         RhGvstmOQolSfh3+GQE03zyhkUDYhanoHGK5+u/jexRZCmqzIu4vAtmkYxmn+eMs/jrU
         dlv08IHuJG7VPjcza9JwC3EVBolLq9D4G0AvWjjKriF9ugl1bGW58Rfim5+LXH3m8RIH
         dtQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=7B77aReB6qhj8DW3rGc39Jmjz7r2DqPWv4WGBSoMo0o=;
        b=w9SY9U1LcqIyHkylngBNuQtFewA0+iGgt5FH6ukEHaDvm+ZmmHGmBgy/Uo4ePNkdIv
         aX1UlWMd8YzpFqTfo/w9T8QMT7Abzvp7JxXpYFSIA3Y8fIYd8A5J5PAMJd74vs2eqQJy
         4Uzc0W9+TEpwHdmH4c31d7Z80wlJAlNTDn4uSYmNV0ocdAU8eDHSKfSwIeDYnlCcwgxd
         fl1XpAoFgsrPHg8vbxCQVAmMN/7v0wiwR0GCD5A+Tnzvn3X0jmjEWNVKezzWJMCz7d4d
         Yk0ZLt2z7ctZsSDYjBOdTVkNLI2JdPHj61fLW8zVT7HQQ6xgmptNF9iKh+eBhBpGdFx6
         C0Jw==
X-Gm-Message-State: AOAM533xYkFfU5GVCCBzyNfQgIEMfhtFAj5WkaDftnUPbTVMOIw43X1G
        MTpqqnkfF2JtrDooat1m4jdJULy2Vuc=
X-Google-Smtp-Source: ABdhPJwZoHNvvebULltTdHfyeiCCAR1PwgX1iEI8fbV1yyezsVAAbd/TazCt87adTHD0xukqVGligw==
X-Received: by 2002:a05:6000:1010:: with SMTP id a16mr3495685wrx.155.1637817794001;
        Wed, 24 Nov 2021 21:23:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g19sm7037360wmg.12.2021.11.24.21.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Nov 2021 21:23:13 -0800 (PST)
Message-Id: <pull.1142.git.git.1637817792914.gitgitgadget@gmail.com>
From:   "Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 05:23:12 +0000
Subject: [PATCH] mingw: avoid fallback for {local,gm}time_r()
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Carlo Marcelo Arenas =?UTF-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
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

the bug was fixed in winphtreads, but as a sideeffect, leaves the
reentrant functions from time.h not longer visible and therefore breaks
the build.

since the intention all along was to avoid using the fallback functions,
formalize the use of POSIX by setting the corresponding feature flag and
to make the intention clearer compile out the fallback functions.

[1] https://unix.org/whitepapers/reentrant.html

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
    mingw: avoid fallback for {local,gm}time_r()
    
    This is a cherry-pick from git-for-windows/git@adf0cd8, that is needed
    to be able to build recent master with the Git for Windows SDK or recent
    MinGW64.
    
    It was discussed recently on list[1], and might need further
    adjustements if the 32-bit Git for Windows SDK also updates their
    winpthread headers, requiring a similar fix, but since without it a
    plain build from master wouldn't work in Windows I think it is worth
    reviewing on its own merits, and had withstood the test of time in the
    git for windows fork since it was originally merged there late August.
    
    [1] https://lore.kernel.org/git/20211005063936.588874-1-mh@glandium.org/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1142%2Fcarenas%2Fwinbuild-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1142/carenas/winbuild-v1
Pull-Request: https://github.com/git/git/pull/1142

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
