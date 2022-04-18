Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8985AC433F5
	for <git@archiver.kernel.org>; Mon, 18 Apr 2022 16:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346287AbiDRQcz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Apr 2022 12:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346249AbiDRQcL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Apr 2022 12:32:11 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B5AC30F4B
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:27 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id b19so19103414wrh.11
        for <git@vger.kernel.org>; Mon, 18 Apr 2022 09:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RjVpHBR3479M6afu0a0D0LrdefKLJ8H0R+dWOFipBKU=;
        b=IPoj7acmVjWA6ziL7akfM3IvcUAhA/70B5lsgbHPv00BzpmTXVNxNPBgYJEag7hqoQ
         V3MfuUuq3ZdjIRQLSdepsLuV7wtL0S9kNxADc2+qM4QIYjZZRwcmboeYabo2aJ4M7s/o
         L9BG20uzsZyNvDQUgSn91nGJCbGo7Hi4O0Yij5HcglppMF8dPT/lEbgx6wWA3Zu6aq3K
         I8FGt0T4qQOwsSTqRZy0ZL65nxOvwUPMAmze0VpSZHtHJgSe9xtlVGF56urfmZ+NHqaB
         GrqD540uth6DUzRy9XeHa1n6NtNkXpPzbEIXLu6cLf9uKLiJckxskH2F+8UfPVTnmHBG
         vX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RjVpHBR3479M6afu0a0D0LrdefKLJ8H0R+dWOFipBKU=;
        b=twJmJn7ikuDFjb/9JmZpzvEY7T+LG5Z/2zuchfRfmgHkvnnOb/EDdSyArBafXuCsDb
         7hGJfCI/JxnIMQpeQS/mRNg90mB61VeALg4FrymFWU3B1d1SeWRVpC0UwaqpcZPVf2pt
         3wMqZK1so0r28FyPYqCxOIY9SDfyGX2/IbA0GzPNMFcOxTa78EIbED9Yo0JXyWx+a2Ae
         2odVB67tA5LE9pE1xOxnYHU21jt509R7/SheRPWy5PFhPLbSfC6gtP9X3NJNsQtW7+Yo
         TULyJ6n15hoeIjl1zPUCrJrhppgGltA9jbmRSGJrm8x1Cw8YhPlNhzCgNJAmW/KnWvPx
         lRiQ==
X-Gm-Message-State: AOAM53051gQJxVklM2LunNJQ6TNBSc/vxx/YUqvDDOQcPqy+uMFFUp/Y
        jD4vnQj9sF5p3Wipl5zFevKIbfIN8B/gJg==
X-Google-Smtp-Source: ABdhPJz/8BHAxZUZn/zRR2/gMxvFW6s+v7mODOfp/HpfS4UC+KH9BXBChJ1qwCGmxNwlgFbfCgL95Q==
X-Received: by 2002:a05:6000:1848:b0:20a:8d85:ab7b with SMTP id c8-20020a056000184800b0020a8d85ab7bmr6763379wri.491.1650299365664;
        Mon, 18 Apr 2022 09:29:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p125-20020a1c2983000000b0038e6c62f527sm15701311wmp.14.2022.04.18.09.29.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:29:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 14/31] ci/lib.sh: use "test" instead of "["
Date:   Mon, 18 Apr 2022 18:28:51 +0200
Message-Id: <patch-v4-14.31-a8e70124929-20220418T132809Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.902.g60576bbc845
In-Reply-To: <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
References: <cover-v3-00.29-00000000000-20220413T194847Z-avarab@gmail.com> <cover-v4-00.31-00000000000-20220418T132809Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the ci/lib.sh script to use "if test" rather than "if [". Until
the preceding commit this script relied on the non-POSIX "export X=Y"
syntax, but now that it's POSIX portable let's use our usual style in
it, and not the bash-specific style that was used in it historically.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index cc9a368be42..ffc0e524aaa 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -94,7 +94,7 @@ ubuntu-latest)
 		break
 	fi
 
-	if [ "$jobname" = linux-gcc ]
+	if test "$jobname" = linux-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
 	else
@@ -104,7 +104,7 @@ ubuntu-latest)
 	setenv --test GIT_TEST_HTTPD true
 	;;
 macos-latest)
-	if [ "$jobname" = osx-gcc ]
+	if test "$jobname" = osx-gcc
 	then
 		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=$(which python3)"
 	else
-- 
2.36.0.rc2.898.gdf6bbac50ff

