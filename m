Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C4EC433F5
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 468CB611C8
	for <git@archiver.kernel.org>; Sun, 19 Sep 2021 08:47:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237084AbhISIst (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Sep 2021 04:48:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhISIss (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Sep 2021 04:48:48 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED99C061574
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:23 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id a194-20020a1c98cb000000b0030b41ac389fso5152853wme.2
        for <git@vger.kernel.org>; Sun, 19 Sep 2021 01:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tBRv2Wd7MFvbmedcRMPTTnl++Ea0U8Yv5UhhZajFYVo=;
        b=EvIaU39854ad7QuvHksLIrBnqMf4x28SUeIoagftrz6qS8H9l7CQbirENo9HYG5GlZ
         jYa7vflSE1X4IcIfgVL/XJrIHg8yyKlUfsSsocvTNHIVRwPFlh8Zk0DSnJlvnip2wEuW
         4+nA/LTHAg8xFvB5DG0SNnu+HfvRkGJXrzTUP0Kr0uF0WZ1OkrWrmeNfR2C1bpI0dUfu
         iD2w/jh/vZqKWVM2cOfnpVGGF0xt05LadBaSFiHLebB/40xZGGnVbO/hTU5sfsFROz8f
         6Q8NTh3zliIOaVhW5rqaO0s0eCODuG4jW7zJ0W7AwEfmJmKnMom8l3PP+napixJlYiZq
         c3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tBRv2Wd7MFvbmedcRMPTTnl++Ea0U8Yv5UhhZajFYVo=;
        b=1PFaf25KqX4V4FTySX63HV5CsVAYs1+w9tzMZrBg8P4ZVNUbADSrPzwM8TsjkJ+iRi
         isUQwPqNGfAAckEkt0FbSpAwAaWFo83C/0IM9SEp5l2riRBZidGxqThtvr/z/tCyclGq
         dF/fH0uql6pmn2areTWBDjj5JB9KWX+wM5O7VP3gRcUXByyECku+YNJEZ0t+SwRqVhfk
         XHBy7LlRI1WGP4opztsaN+KO7VPMY5SKWDP07arN12rj87iyvldNmUm070zg7oFUT+SA
         c3Ybky3CDQF29obnCCNLtPPo8rAh814uIdFaZGuzFlIcsmZPUMq+F3vaTJBdHR39iwHX
         Oxbg==
X-Gm-Message-State: AOAM533EedRYoAosByp5i9NHC2nptO8picUmUgYyYZBjY0B2Yjpk4W4q
        qWhfJ2PXfEkRZcZ4TFTiyLzehWFFsyeQmQ==
X-Google-Smtp-Source: ABdhPJx40JXdyx/NRyS3y1R3Rg/SnnewFVB6thkePd3Ha4sgEVzjOLUR5DQFxko7FKmmBb1pTaRoHA==
X-Received: by 2002:a7b:c414:: with SMTP id k20mr18694481wmi.146.1632041242195;
        Sun, 19 Sep 2021 01:47:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i67sm7884497wmi.41.2021.09.19.01.47.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 01:47:21 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
Date:   Sun, 19 Sep 2021 10:47:15 +0200
Message-Id: <patch-v3-1.5-4b320edc933-20210919T084703Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com> <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add fatal wrappers for setenv() and unsetenv(). In d7ac12b25d3 (Add
set_git_dir() function, 2007-08-01) we started checking its return
value, and since 48988c4d0c3 (set_git_dir: die when setenv() fails,
2018-03-30) we've had set_git_dir_1() die if we couldn't set it.

Let's provide a wrapper for both, this will be useful in many other
places, a subsequent patch will make another use of xsetenv().

The checking of the return value here is over-eager according to
setenv(3) and POSIX. It's documented as returning just -1 or 0, so
perhaps we should be checking -1 explicitly.

Let's just instead die on any non-zero, if our C library is so broken
as to return something else than -1 on error (and perhaps not set
errno?) the worst we'll do is die with a nonsensical errno value, but
we'll want to die in either case.

We could make these return "void" (as far as I can tell there's no
other x*() wrappers that needed to make that decision before),
i.e. our "return 0" is only to indicate that we didn't error, which we
would have died on. Let's return "int" instead to be consistent with
the C library function signatures, including for any future code that
expects a pointer to a setenv()-like function.

I think it would be OK skip the NULL check of the "name" here for the
calls to die_errno(). Almost all of our setenv() callers are taking a
constant string hardcoded in the source as the first argument, and for
the rest we can probably assume they've done the NULL check
themselves. Even if they didn't, modern C libraries are forgiving
about it (e.g. glibc formatting it as "(null)"), on those that aren't,
well, we were about to die anyway. But let's include the check anyway
for good measure.

1. https://pubs.opengroup.org/onlinepubs/009604499/functions/setenv.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 environment.c     |  3 +--
 git-compat-util.h |  2 ++
 wrapper.c         | 15 +++++++++++++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/environment.c b/environment.c
index d6b22ede7ea..7d8a949285c 100644
--- a/environment.c
+++ b/environment.c
@@ -330,8 +330,7 @@ char *get_graft_file(struct repository *r)
 
 static void set_git_dir_1(const char *path)
 {
-	if (setenv(GIT_DIR_ENVIRONMENT, path, 1))
-		die(_("could not set GIT_DIR to '%s'"), path);
+	xsetenv(GIT_DIR_ENVIRONMENT, path, 1);
 	setup_git_env(path);
 }
 
diff --git a/git-compat-util.h b/git-compat-util.h
index b46605300ab..0b0c0305165 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -875,6 +875,8 @@ void *xmemdupz(const void *data, size_t len);
 char *xstrndup(const char *str, size_t len);
 void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
+int xsetenv(const char *name, const char *value, int overwrite);
+int xunsetenv(const char *name);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index 7c6586af321..95f989260cd 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -145,6 +145,21 @@ void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
+int xsetenv(const char *name, const char *value, int overwrite)
+{
+	if (setenv(name, value, overwrite))
+		die_errno("setenv(%s, '%s', %d) failed", name ? name : "(null)",
+			  value, overwrite);
+	return 0;
+}
+
+int xunsetenv(const char *name)
+{
+	if (!unsetenv(name))
+		die_errno("unsetenv(%s) failed", name ? name : "(null)");
+	return 0;
+}
+
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
-- 
2.33.0.1092.g44c994ea1be

