Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3829EC433EF
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 11:00:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiD1LDQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 07:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345032AbiD1LCy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 07:02:54 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE35A2056
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:06 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id jt15so2912052qvb.13
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 03:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6d0ksTklETtJVv8qjD03tTEXlY+EgLIs5NIYxI833M4=;
        b=QQnb9KvO/KqBhSdXKI6LgebBodlDxV2vpGH8BYUuDKgfpjAshmLmmHhXFWQoYa/tbq
         5t8uRKlciX/c1zFF1NypifU7Qguo7eED91nkqcEpSx8MF9oig/CcN42rbyUMbPwatCIB
         1fZTrSB14Plriqd+poMMvSh/6Zv3GsCpQZb3cxD5Gwuf8R70TLBH4tKpwpaTjMk1+4aU
         N4/U6zCE06PSSxuOSFK7+jg+xh3GXL/mse6aPLVUgrc4WDJX46ODf/O4If5V7ZUoXQ1C
         oaZEQlK1FFX8F1JeqWoWxOtK7q+5dgbnY0IWSe+5YDwqnYiWZQz8tVcEpCwe/6oG2AMv
         m6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6d0ksTklETtJVv8qjD03tTEXlY+EgLIs5NIYxI833M4=;
        b=ZupIarRQQVXL+W3nRydyb7ca/5v1jASFtvLnavgLSspdmRyZo+NEgqCcN/8PzfQogB
         ArB/UrKhZy2ydDvZM4XhYz2bINV9SMMzB5uz2pr7HcBzL02DmCVD4Nd7/1uZJYg7p6SU
         PLExbU1lJiC4XqInWujxhQWd5EoakKoEI9yJtJ1fP4n120RJ13x442cKpESVfOzBDk2N
         A56Idzys9pC9vDISZxqH+MbDC+O6LRMvVxJxIVhQ0NAIT+SQKJ3M179WqG4vc9TQ0r8/
         fUQ9LJYYBFFkuRhGYSkE4NoXe1O3lpfLq9AHKhq4uqp7Rv+7roRVmGS7YAdWU8FKx80A
         u3LQ==
X-Gm-Message-State: AOAM533rXTp4RCUDWbbWfRffWNxwnHcGjRww+CIJAXNdoinBaKybQjh5
        T+Ooxdvm/SvkbakGtFUICRTCN1YJHUs=
X-Google-Smtp-Source: ABdhPJxJ+kgEOsErArGgbriy6DSd7/xfXZuOA7hRLG5+TDkn49pxMHnqoMbbtxZa/ATuSr+MD+6bTA==
X-Received: by 2002:a0c:a68a:0:b0:443:d22b:cdff with SMTP id t10-20020a0ca68a000000b00443d22bcdffmr23412247qva.47.1651143545023;
        Thu, 28 Apr 2022 03:59:05 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id v3-20020a05622a014300b002e1dcd4cfa9sm12950299qtw.64.2022.04.28.03.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Apr 2022 03:59:04 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 3/3] t: add tests for safe.directory when running with sudo
Date:   Thu, 28 Apr 2022 03:58:52 -0700
Message-Id: <20220428105852.94449-4-carenas@gmail.com>
X-Mailer: git-send-email 2.36.0.352.g0cd7feaf86f
In-Reply-To: <20220428105852.94449-1-carenas@gmail.com>
References: <20220428033544.68188-1-carenas@gmail.com>
 <20220428105852.94449-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a previous commit the functionality for fixing this regression was
implemented, so add the basic infrastructure needed to run sudo and
implement some tests with it.

This new test is meant to be mainly run in CI and therefore assumes
that the system where it runs provides passwordless sudo to root and
doesn't sanitize the path.

All tests should depend on the new SUDO prerequisite which validates
that setup is available but it could also run locally, with the right
configuration and maybe making use of the sudo credential cache by
first invoking sudo, entering your password if needed, and then
invoking the test by doing:

  $ IKNOWWHATIAMDOING=YES ./t0034-root-safe-directory.sh

It is slightly awkward as it needs to run its own clean up task at
the end to remove the root owned directories and that the test
framework can't yet manage, can't use the library inside sudo and
it creates its own subtree and repositories while ignoring the one
provided by the framework, but improving that has been punted for now.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t0034-root-safe-directory.sh | 87 ++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100755 t/t0034-root-safe-directory.sh

diff --git a/t/t0034-root-safe-directory.sh b/t/t0034-root-safe-directory.sh
new file mode 100755
index 00000000000..fb54a2fb851
--- /dev/null
+++ b/t/t0034-root-safe-directory.sh
@@ -0,0 +1,87 @@
+#!/bin/sh
+
+test_description='verify safe.directory checks while running as root'
+
+. ./test-lib.sh
+
+if [ "$IKNOWWHATIAMDOING" != "YES" ]; then
+	skip_all="You must set env var IKNOWWHATIAMDOING=YES in order to run this test"
+	test_done
+fi
+
+is_root() {
+	test -n "$1" && CMD="sudo -n"
+	test $($CMD id -u) = $(id -u root)
+}
+
+test_lazy_prereq SUDO '
+	is_root sudo &&
+	! sudo grep -E '^[^#].*secure_path' /etc/sudoers
+'
+
+test_lazy_prereq ROOT '
+	is_root
+'
+
+test_expect_success SUDO 'setup' '
+	sudo rm -rf root &&
+	mkdir -p root/r &&
+	sudo chown root root &&
+	(
+		cd root/r &&
+		git init
+	)
+'
+
+test_expect_success SUDO 'sudo git status as original owner' '
+	(
+		cd root/r &&
+		git status &&
+		sudo git status
+	)
+'
+
+test_expect_success SUDO 'setup root owned repository' '
+	sudo mkdir -p root/p &&
+	sudo git init root/p
+'
+
+test_expect_success SUDO,!ROOT 'can access if owned by root' '
+	(
+		cd root/p &&
+		test_must_fail git status
+	)
+'
+
+test_expect_success SUDO,!ROOT 'can access with sudo' '
+	# fail to access using sudo
+	(
+		# TODO: test_must_fail missing functionality
+		cd root/p &&
+		! sudo git status
+	)
+'
+
+test_expect_success SUDO 'can access with workaround' '
+	# provide explicit GIT_DIR
+	(
+		cd root/p &&
+		sudo sh -c "
+			GIT_DIR=.git GIT_WORK_TREE=. git status
+		"
+	) &&
+	# discard SUDO_UID
+	(
+		cd root/p &&
+		sudo sh -c "
+			unset SUDO_UID &&
+			git status
+		"
+	)
+'
+
+test_expect_success SUDO 'cleanup' '
+	sudo rm -rf root
+'
+
+test_done
-- 
2.36.0.352.g0cd7feaf86f

