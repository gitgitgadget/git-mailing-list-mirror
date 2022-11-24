Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BA76C43217
	for <git@archiver.kernel.org>; Thu, 24 Nov 2022 15:39:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiKXPju (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Nov 2022 10:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiKXPjo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Nov 2022 10:39:44 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FAC30562
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:43 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id 9so1886215pfx.11
        for <git@vger.kernel.org>; Thu, 24 Nov 2022 07:39:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrodGsdgDfEdezt9f/pW1vlRzb3Km+y0QPGok/vIRE4=;
        b=MA6Zf3RS0cHzFjVO+JmC4VjiXTisrFyb7hgwHWBd9clXfpdd0rK2mB44HjR2TnEeO+
         phPIW+GBDSjpJ0UQGjsBwGUiXhJQM2MCFcEZlsXVzmbTQ9WxPie8Ik9lfy5bu4cXVWb7
         xOZ6YuqzvYga8e/vk4Ka8eu5CuPv6pHs9beNBAnuKyqvaWqk4vA31RRh26DCnfzQXrkO
         ZD6rvah3rqZUIVArtVMuKItAgBjDHRskSk5F/AB3bmW1YR52eXtTruQDgBlfzQz1Rw//
         vqJifyctkcFCPyeTt5pox99hX5D6gsB0UvOAwU5aBH64r1IoWAYwYxvFNfUo8ozKxZyn
         x5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrodGsdgDfEdezt9f/pW1vlRzb3Km+y0QPGok/vIRE4=;
        b=gwGEZrT3k1QtHdpZPKLJGhPknrq9vgV+E2/HRJQsxpgpnPiqokBJK/7E3cG4M9IY/h
         rLN9OwP+5GfOFK6sI+lNcH6IaHuafv4L2tgNynQmPHpvqEZDHTPavJcyMQRzbCo0hRNk
         2WLE3iuLKpBphmK2exCTsROambt9Z7lciu3/B5pnBcFYTj/OGeYcLrG1jDDuiEsvrpPw
         5K/UtohHusKaZzSjlvkcfZBdSOCJkdnRcwUEaVRSDfQLtIpbbXAw7qRCpILlAMXE2xbQ
         Kvwl/aunIIF/MdUv6N4n8Zn2DIjgbrBUrFLobJOw/MTW0o9tHT+j/eNxx7m96196nGyL
         mNOw==
X-Gm-Message-State: ANoB5pla12AhQINkN8f0VO6Lwcsg42CuRXXZqQOvrJVCdyxEZXMD0gay
        K8W2WAFCOY/6BcAEhTNFo0LX03t82iE=
X-Google-Smtp-Source: AA0mqf5sJsmO8e5N6mo3StvS6asCKyE0vBFperb8Dp/rLDLk9Ysrb8ApV1qD+e9H2hAEQEyK9WkcuQ==
X-Received: by 2002:a63:1659:0:b0:46e:f23a:e9aa with SMTP id 25-20020a631659000000b0046ef23ae9aamr14884231pgw.428.1669304382305;
        Thu, 24 Nov 2022 07:39:42 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0017f48a9e2d6sm1413089pln.292.2022.11.24.07.39.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 24 Nov 2022 07:39:41 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH v3 4/4] ci: install python on ubuntu
Date:   Thu, 24 Nov 2022 23:39:34 +0800
Message-Id: <20221124153934.12470-5-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221124090545.4790-1-worldhello.net@gmail.com>
References: <20221124090545.4790-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

Python is missing from the default ubuntu-22.04 runner image, which
prevent git-p4 from working. To install python on ubuntu, we need to
provide correct package name:

 * On Ubuntu 18.04 (bionic), "/usr/bin/python2" is provided by the
   "python" package, and "/usr/bin/python3" is provided by the "python3"
   package.

 * On Ubuntu 20.04 (focal) and above, "/usr/bin/python2" is provided by
   the "python2" package which has a different name from bionic, and
   "/usr/bin/python3" is provided by "python3".

Since the "ubuntu-latest" runner image has a higher version, so its safe
to use "python2" or "python3" package name.

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 2 +-
 ci/lib.sh                  | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f860c35c75..e804b1935e 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -15,7 +15,7 @@ case "$runs_on_os" in
 ubuntu)
 	sudo apt-get -q update
 	sudo apt-get -q -y install language-pack-is libsvn-perl apache2 \
-		$UBUNTU_COMMON_PKGS $CC_PACKAGE
+		$UBUNTU_COMMON_PKGS $CC_PACKAGE $PYTHON_PACKAGE
 	mkdir --parents "$P4_PATH"
 	pushd "$P4_PATH"
 		wget --quiet "$P4WHENCE/bin.linux26x86_64/p4d"
diff --git a/ci/lib.sh b/ci/lib.sh
index 991ea4f8a6..fbebad4b9c 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -232,12 +232,12 @@ ubuntu)
 		break
 	fi
 
-	if [ "$jobname" = linux-gcc ]
+	PYTHON_PACKAGE=python2
+	if test "$jobname" = linux-gcc
 	then
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python3"
-	else
-		MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/python2"
+		PYTHON_PACKAGE=python3
 	fi
+	MAKEFLAGS="$MAKEFLAGS PYTHON_PATH=/usr/bin/$PYTHON_PACKAGE"
 
 	export GIT_TEST_HTTPD=true
 
-- 
2.39.0.rc0

