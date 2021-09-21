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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A26D7C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87D196112F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbhIUNOj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:14:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230411AbhIUNOi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:14:38 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 795F5C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u15so39050317wru.6
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 06:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dNZFxbiJRW5pSnFhgJ3zpEadwx1XOGlpPDoK23RnUE8=;
        b=NBoKMEtJ9x4MU3FXcN3dPkHTkzNbuPnnuvLWmXF688oJ6YtCGJxtA8EsmdZ0iTzzLj
         7DZlWl3WFUa1OoiM9xGd666pWBTARr0NHhBu4mmygXKiNU6qnfCqrGN7zIARXY13Atep
         fZj1V7EgSMzLaWajbwOyTyq+vy5tlW4Jovo1lDfBFW5enCagQyiWUvkOgkEmkRLrUEAz
         oC65Mn8vTvTLz2vSrCtWq1nKs6+2IFQm6HBf1s7SOwNbvKtqWTfJkWIZF25/w4Z1pblG
         PXaKXCmuDWnKqGxaKsU3vmurRGXW/e2QKafAZjESaFVfDHu4HomHvRynlXERlaAxemVJ
         VAMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNZFxbiJRW5pSnFhgJ3zpEadwx1XOGlpPDoK23RnUE8=;
        b=aeiRYSyo1Ec+n2SoIKvNqk5mKR46J3b8MdiA90P4KjUNlWEH7TfpRLAb24kHkW4+Ow
         hscFcmoQBy5F3FMfvmKCNBQCMFkHB1GipxcMKwkl4XendWaA6ZHyMyt0nI3Qm9HeBqeh
         +xsAvWmuz536CUmAWBCCMZL2hN3wo3fyKWT49KemGmD4DGFT7W5M8y0NIN7HH5Cd0hfP
         OaRFwaYZTywlWCpdVrlIGmhlSBQM6ixv3z7obF1fLBw+Drd7sz2wtyToA75RPiFSuyrw
         kSzp+kfrWTY5XTm5iu892+NxkV71VgTN+EbiNPKc8SqqSR2sG1Vj62ZZ0Xl+d/frWAMP
         7nEA==
X-Gm-Message-State: AOAM530hcSt+NrNEjYrIgpcQINokuFY4iDszPUQ30hPgR5PA5CyvD3VZ
        B8e+2+hxgLJJpQ0Skso/1kOMkCIN2YYeNA==
X-Google-Smtp-Source: ABdhPJxmC/gQLbc8o+o22OxpQdDAQ1IRjVvu6ivrRpS8RCu79WO4meHmpZSB4/rWcq0s35O/e2M4Cg==
X-Received: by 2002:adf:dc85:: with SMTP id r5mr4811871wrj.37.1632229988490;
        Tue, 21 Sep 2021 06:13:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v18sm2733260wml.44.2021.09.21.06.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 06:13:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Patrick Steinhardt <ps@pks.im>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/5] wrapper.c: add x{un,}setenv(), and use xsetenv() in environment.c
Date:   Tue, 21 Sep 2021 15:12:59 +0200
Message-Id: <patch-v4-1.5-4dd317ab65e-20210921T131003Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
References: <cover-v3-0.5-00000000000-20210919T084703Z-avarab@gmail.com> <cover-v4-0.5-00000000000-20210921T131003Z-avarab@gmail.com>
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

Let's make these return "void" instead of "int". As far as I can tell
there's no other x*() wrappers that needed to make the decision of
deviating from the signature in the C library, but since their return
value is only used to indicate errors (so we'd die here), we can catch
unreachable code such as

    if (xsetenv(...) < 0)
        [...];

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
 wrapper.c         | 12 ++++++++++++
 3 files changed, 15 insertions(+), 2 deletions(-)

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
index ddc65ff61d9..94d8250832d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -875,6 +875,8 @@ void *xmemdupz(const void *data, size_t len);
 char *xstrndup(const char *str, size_t len);
 void *xrealloc(void *ptr, size_t size);
 void *xcalloc(size_t nmemb, size_t size);
+void xsetenv(const char *name, const char *value, int overwrite);
+void xunsetenv(const char *name);
 void *xmmap(void *start, size_t length, int prot, int flags, int fd, off_t offset);
 const char *mmap_os_err(void);
 void *xmmap_gently(void *start, size_t length, int prot, int flags, int fd, off_t offset);
diff --git a/wrapper.c b/wrapper.c
index 7c6586af321..1460d4e27b0 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -145,6 +145,18 @@ void *xcalloc(size_t nmemb, size_t size)
 	return ret;
 }
 
+void xsetenv(const char *name, const char *value, int overwrite)
+{
+	if (setenv(name, value, overwrite))
+		die_errno(_("could not setenv '%s'"), name ? name : "(null)");
+}
+
+void xunsetenv(const char *name)
+{
+	if (!unsetenv(name))
+		die_errno(_("could not unsetenv '%s'"), name ? name : "(null)");
+}
+
 /*
  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
  * 64-bit is buggy, returning EINVAL if len >= INT_MAX; and even in
-- 
2.33.0.1098.gf02a64c1a2d

