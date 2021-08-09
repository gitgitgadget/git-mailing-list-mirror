Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA15C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E255A60F4B
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 01:38:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbhHIBjP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Aug 2021 21:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbhHIBjN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Aug 2021 21:39:13 -0400
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5525AC061757
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 18:38:52 -0700 (PDT)
Received: by mail-qt1-x835.google.com with SMTP id d2so11336050qto.6
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 18:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KN9iDnzhHJdBdu9jsvKEvksJMRgPoXsBSOKMBFBA6vk=;
        b=CAAw9qEbQKxNe5cOc5eMT+2Gv3AIqKvCfMvvK1kZzQhkzlwvTEbcSpl7Pm7m0ei9zD
         4Bb27ne4JOZLzSPot/kKGoVP+bXNBXbWpAXsBEYCodjidiIRHbA6E2L6f+PGelpkUMtJ
         OT2NU9I/59m7j1sEmqw/QgjALtD/0B7ecaM/SsB4/+hod0HhBIYPsdanoiHlw+lbvC+0
         ZeYvtHZ33sThTBB36npAUedbLDGy6Fce9/7RN9gST+uFvT1oZOBH9/CE/fWDcDGEc/Xu
         IgnOA/FLJD+19Paczw4ljGRhf0AGhY0YQNX2ATroESNmjpIkEhYRFaOLVZcAZF6Dj4nr
         0kcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KN9iDnzhHJdBdu9jsvKEvksJMRgPoXsBSOKMBFBA6vk=;
        b=VUdvUs0qbkvO6vtXuPKPQ8FcztXbcEtRvu4Ip4lHc4fp7ljunyfQXrpjrjrCEyZi0a
         OqijSdHffPLK3Rdm2ioMZoQinAmKPI6ud1aWWya+1HwXVeS6L4xaGdcRa1f9wMYPcDZL
         tnV9ElczXa9WmWQ9NC+mSTaethVjhFRXSea8XuP8SQeJG7YQJQMtSXvxfiewSSplFl8N
         mC4iumpTUZhpV+EAtmJp9T2vC8ezh3qaMSzkOWVCYBTGvY2sY40NTHsQHvLfrWD7yZzL
         Anrm0iZd409lo6XXPRiJUCgTIZHxk8C4mWwOMMhnsB0/DgcpWrGhwxEpeqh4ThTF7KZ+
         PTVg==
X-Gm-Message-State: AOAM533kGNcMY/2FXITyykc5XntoL13/kRQNgmCOgwPlYcwznUnAAaE+
        0W+QJL4dgK5KS2ePm+OS5OSczO2FEsg=
X-Google-Smtp-Source: ABdhPJzK75ydb1j8H2ylUoYm2uZyilFiwr5cwEThXjyr7PYqchPrz1FQhZtmMvhdObocaEJbvCR4dQ==
X-Received: by 2002:a05:622a:610:: with SMTP id z16mr18197839qta.99.1628473131355;
        Sun, 08 Aug 2021 18:38:51 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id o16sm1279492qtq.95.2021.08.08.18.38.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 18:38:51 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     e@80x24.org,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH/RFC 3/3] ci: run a pedantic build as part of the GitHub workflow
Date:   Sun,  8 Aug 2021 18:38:33 -0700
Message-Id: <20210809013833.58110-4-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809013833.58110-1-carenas@gmail.com>
References: <CAPUEsphf9F1+=zOMKx3j=jH8xqDwQX99+9uHiYUpXhFE1nervg@mail.gmail.com>
 <20210809013833.58110-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

similar to the recently added sparse task, it is nice to know as early
as possible.

add a dockerized build using fedora (that usually has the latest gcc)
to be ahead of the curve and avoid older ISO C issues at the same time.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 .github/workflows/main.yml        |  2 ++
 ci/install-docker-dependencies.sh |  4 ++++
 ci/run-build-and-tests.sh         | 10 +++++++---
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
index 47876a4f02..6b9427eff1 100644
--- a/.github/workflows/main.yml
+++ b/.github/workflows/main.yml
@@ -259,6 +259,8 @@ jobs:
           image: alpine
         - jobname: Linux32
           image: daald/ubuntu32:xenial
+        - jobname: pedantic
+          image: fedora
     env:
       jobname: ${{matrix.vector.jobname}}
     runs-on: ubuntu-latest
diff --git a/ci/install-docker-dependencies.sh b/ci/install-docker-dependencies.sh
index 26a6689766..07a8c6b199 100755
--- a/ci/install-docker-dependencies.sh
+++ b/ci/install-docker-dependencies.sh
@@ -15,4 +15,8 @@ linux-musl)
 	apk add --update build-base curl-dev openssl-dev expat-dev gettext \
 		pcre2-dev python3 musl-libintl perl-utils ncurses >/dev/null
 	;;
+pedantic)
+	dnf -yq update >/dev/null &&
+	dnf -yq install make gcc findutils diffutils perl python3 gettext zlib-devel expat-devel openssl-devel curl-devel pcre2-devel >/dev/null
+	;;
 esac
diff --git a/ci/run-build-and-tests.sh b/ci/run-build-and-tests.sh
index 3ce81ffee9..f3aba5d6cb 100755
--- a/ci/run-build-and-tests.sh
+++ b/ci/run-build-and-tests.sh
@@ -10,6 +10,11 @@ windows*) cmd //c mklink //j t\\.prove "$(cygpath -aw "$cache_dir/.prove")";;
 *) ln -s "$cache_dir/.prove" t/.prove;;
 esac
 
+if test "$jobname" = "pedantic"
+then
+	export DEVOPTS=pedantic
+fi
+
 make
 case "$jobname" in
 linux-gcc)
@@ -35,10 +40,9 @@ linux-clang)
 	export GIT_TEST_DEFAULT_HASH=sha256
 	make test
 	;;
-linux-gcc-4.8)
+linux-gcc-4.8|pedantic)
 	# Don't run the tests; we only care about whether Git can be
-	# built with GCC 4.8, as it errors out on some undesired (C99)
-	# constructs that newer compilers seem to quietly accept.
+	# built with GCC 4.8 or with pedantic
 	;;
 *)
 	make test
-- 
2.33.0.rc1.373.gc715f1a457

