Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBC9C433F5
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 01:47:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46015611ED
	for <git@archiver.kernel.org>; Thu,  4 Nov 2021 01:47:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbhKDBu0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 3 Nov 2021 21:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbhKDBuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Nov 2021 21:50:25 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806BAC061714
        for <git@vger.kernel.org>; Wed,  3 Nov 2021 18:47:48 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id i5so6269553wrb.2
        for <git@vger.kernel.org>; Wed, 03 Nov 2021 18:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=B6hh3hf7UUqXcC6GfpiCK2A7XHjxQNhG/vKKYR/k2cY=;
        b=VFkrxabktaSOpjopVRFUT+7quf0QaYHkymPLiZjGNdAMmddINuXl5tlRGT4Svt6NWG
         Jy1iusLC+CwU2EBrXz/WdawhTRUhNlC5TkrLcvJAarPzADelD10R6S6cgNSvT0Ei+yKh
         7XHz/AzFgp8e5bHtaIpQFuh58BL+tAMrmuWsTAmdduqm9kvAcwzfXdCemm8oizihC9sV
         yQ8TylU+xmYg3F08CclIYTG4FrxxyYEj0oQXbQLh3/OO9So0y7OwVld9VmMWr6Y+sSAZ
         ihs9+h9sd01XIjkFtVT0YsanmGNMonSG7fIJv90Zd95XEwrBNSgu0RTKEmJ2pgMobXZ+
         TPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B6hh3hf7UUqXcC6GfpiCK2A7XHjxQNhG/vKKYR/k2cY=;
        b=gm7amUrOz6KZVCQfCHeD9k4LpD4aM9Y/0HLl7wxnYhamLf1s8pwHJnAb3rODXlLFGU
         jpqSM5UeUVsICxeAYQUEyjWBHj1X2Q+0u1yDWx09IJ2GLg2An1WUOnHz+8h9VFgyGGVJ
         5jzfjmJW+8DDB5XeZmz1gK2tRk+Kboc0Nfo6HlsdCMl0XpI8jqlJNVVJoXStMJ1hTaWd
         FG3dK72dIaXrSv+tfveMlp0Tk6sI3TMOymiuW15X5URz/lG1CGVLrFu4DmEQKx5cDaNT
         fEjYTOwQV32IsiGwTlWZeu8H+VIEgakrQB2886JLubmOppSjKSinT1SAF/6ReKTQg7VT
         ZHiA==
X-Gm-Message-State: AOAM531cTE0LD386kBaVqgt9hxa1CN16joMXFt+s/JRXnp0Wv+Gowi3H
        pHtD0zMXxH6ptBeDEySSOFkxFEBGqbI=
X-Google-Smtp-Source: ABdhPJynud4+vFD9FKAujXihzupH5c+SH0+2he5rez8CYf3VjJj/CWa8G4rkU1MyRUgSyfzWtQocMA==
X-Received: by 2002:a05:6000:1aca:: with SMTP id i10mr19807436wry.407.1635990467004;
        Wed, 03 Nov 2021 18:47:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t189sm3425007wma.8.2021.11.03.18.47.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 18:47:46 -0700 (PDT)
Message-Id: <pull.1072.git.1635990465854.gitgitgadget@gmail.com>
From:   "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Nov 2021 01:47:45 +0000
Subject: [PATCH] async_die_is_recursing: fix use of pthread_getspecific for
 Fedora
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, philipoakley@iee.email, eschwartz@archlinux.org,
        Victoria Dye <vdye@github.com>, Victoria Dye <vdye@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Victoria Dye <vdye@github.com>

Correct an issue encountered in the `dockerized(pedantic, fedora)` CI build,
first appearing after the release of v36 as the latest stable version of the
Fedora docker image. This image includes a version of `glibc` with the
attribute `__attr_access_none` added to `pthread_getspecific` [1], the
implementation of which only exists for GCC 11.X - the version included in
Fedora. The attribute requires that the pointer provided in the second
argument of `pthread_getspecific` must, if not NULL, be a pointer to a valid
object. In the usage in `async_die_is_recursing`, `(void *)1` is not valid,
resulting in the error.

The fix imitates a workaround added in SELinux [2] by using the pointer to
`ret` as the second argument to `pthread_getspecific`. This guaranteed
non-NULL, valid pointer adheres to the current intended usage of
`pthread_getspecific` while not triggering the build error.

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=a1561c3bbe8
[2] https://lore.kernel.org/all/20211021140519.6593-1-cgzones@googlemail.com/

Co-authored-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Victoria Dye <vdye@github.com>
---
    async_die_is_recursing: fix use of pthread_getspecific for Fedora
    
    Following up on Johannes' report earlier [1], this patch fixes a
    compiler error in the Fedora CI build (the same issue was identified in
    a local developer build about a week ago [2]). This fix changes the
    second argument in the call to pthread_getspecific from '(void *)1' to a
    valid pointer, thus preventing the error in the use of
    __attr_access_none.
    
    [1]
    https://lore.kernel.org/git/nycvar.QRO.7.76.6.2111040007170.56@tvgsbejvaqbjf.bet/
    [2]
    https://lore.kernel.org/git/43fe6d5c-bdb2-585c-c601-1da7a1b3ff8b@archlinux.org/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1072%2Fvdye%2Ffix-fedora-build-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1072/vdye/fix-fedora-build-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1072

 run-command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/run-command.c b/run-command.c
index 7ef5cc712a9..a82cf69e7d3 100644
--- a/run-command.c
+++ b/run-command.c
@@ -1099,7 +1099,7 @@ static NORETURN void die_async(const char *err, va_list params)
 static int async_die_is_recursing(void)
 {
 	void *ret = pthread_getspecific(async_die_counter);
-	pthread_setspecific(async_die_counter, (void *)1);
+	pthread_setspecific(async_die_counter, &ret); /* set to any non-NULL valid pointer */
 	return ret != NULL;
 }
 

base-commit: 876b1423317071f43c99666f3fc3db3642dfbe14
-- 
gitgitgadget
