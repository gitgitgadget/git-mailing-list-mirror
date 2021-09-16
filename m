Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6029FC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34054611C8
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 18:59:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345304AbhIPTBL (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 15:01:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344655AbhIPTBF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 15:01:05 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA001C0F26CE
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f62-20020a1c1f41000000b0030b42643f72so224015wmf.3
        for <git@vger.kernel.org>; Thu, 16 Sep 2021 11:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4hVnjC4Iwesp3+zpqTFJ4S8K3qfRNeZzAu88rS5shkM=;
        b=O5VYOFOXe0p+WQCpqmHBvGT0BNAfrR6gra+kNjhuYb0wm11bSPWBIoxtzo+nEbV2qG
         eNcP9yBLjs/6roFgTRI917ijTJp9f0v/24N7qLzbcGvhkM2GzRED/IemhcgZ7+u6378b
         pip35ZlayRxjxNLyjQ/SvOR85h30Z44VM/WHVXozgD4/Mo1cdpcMipiPMJbxjwVZ30jz
         xviUoFMpM8y+uWe5UVH8zmw9NWJOiicRhXuV00+BZioZa9c1TCMl1YGx0EnZ/gEiJs59
         cu8u7K5abYw/pPVsRIi5hKYMXQUgXZpqyVxMGE4Cv74UekGU43MarTco2TEaE2ArDBRH
         pEPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4hVnjC4Iwesp3+zpqTFJ4S8K3qfRNeZzAu88rS5shkM=;
        b=KopxAXhjjNe4fBcMvlUd2CIclL0t70sRgoqM3VP9dyGA2vEW7q9RJQDC9Uasyrqg8H
         5kXyxcXgiaCHpRc2lpodyMqazavNg22KkMt9LGax9rOoSHNmmXQoWisCf0TaoN98MVR0
         AeMRSiElHQou0zBo5rmNuQaPbygFMyKjTacfJ9VcFaCSEiXokBWHUD4voUbU2RYenny5
         aqU6h+DFZPa7V0rOHIkcE9qNwf2LEukBCIIbtXbh13sSVH8LWT7WeauiERKWnn+Abx1s
         Sy9RYtAdu1EJxaBT9nyyBUHP1vK8dNwGoEy8lhrbh9Bh7GQ8Wq/bovpopUjOvz8UPEBf
         Hrbg==
X-Gm-Message-State: AOAM533vT+So97wmmIChuqRrl2he/31JAF075CKn/q9HuYUMQ/WJ2kep
        vYPJkMUUAyCGNIP3uO2JpwxEgrV1v3DxZw==
X-Google-Smtp-Source: ABdhPJzseuDAUJgS9kgoLsR+uCHJ1+1pyvPqUboYflFX+tzD63DjmPdodeayR5oXsyW6JnGAZLxUZw==
X-Received: by 2002:a1c:488:: with SMTP id 130mr6363909wme.156.1631817041263;
        Thu, 16 Sep 2021 11:30:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j98sm4365700wrj.88.2021.09.16.11.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Sep 2021 11:30:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
Date:   Thu, 16 Sep 2021 20:30:32 +0200
Message-Id: <patch-v2-1.5-49706b26642-20210916T182918Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1092.g44c994ea1be
In-Reply-To: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210916T182918Z-avarab@gmail.com>
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

1. https://pubs.opengroup.org/onlinepubs/009604499/functions/setenv.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 environment.c     |  3 +--
 git-compat-util.h |  2 ++
 wrapper.c         | 18 ++++++++++++++++++
 3 files changed, 21 insertions(+), 2 deletions(-)

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
index 7c6586af321..f784904fd67 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -145,6 +145,24 @@ void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
+int xsetenv(const char *name, const char *value, int overwrite)
+{
+	if (!name)
+		die("xsetenv() got a NULL name, setenv() would return EINVAL");
+	if (setenv(name, value, overwrite))
+		die_errno("setenv(%s, '%s', %d) failed", name, value, overwrite);
+	return 0;
+}
+
+int xunsetenv(const char *name)
+{
+	if (!name)
+		die("xunsetenv() got a NULL name, xunsetenv() would return EINVAL");
+	if (!unsetenv(name))
+		die_errno("unsetenv(%s) failed", name);
+	return 0;
+}
+
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
-- 
2.33.0.1092.g44c994ea1be

