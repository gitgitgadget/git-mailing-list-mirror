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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87DD2C433E6
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5682E64E74
	for <git@archiver.kernel.org>; Sun, 28 Feb 2021 19:56:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231550AbhB1T4M (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 28 Feb 2021 14:56:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhB1Tz6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 28 Feb 2021 14:55:58 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B181FC061797
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:42 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id mj10so4208638ejb.5
        for <git@vger.kernel.org>; Sun, 28 Feb 2021 11:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VJK0PBreuPzBDOb7waUsCKk+533hJCftJx7HJWvGoX8=;
        b=lZLJPnzd5XUktqMpYyvLFd/x2p2UL9FI4CjZblGJviGs78OXHYOw0ScoMQF2Pb0T/R
         jGkixr+6s+nZRRVDy0oYQ/I9mXJYQWcKMqmKCxMoNEoOsPamVYqomr60F1iia5DZv1q+
         hqjpRt4d4WURkmkZk89HM4+UDLN9YfqPWAErMihDyRVBvExJ9bze4LBSTQBa88qjNxY/
         eSgSRIFPBWh0KFKYnxqmlA79lrR1q7WyKApMLGmOc25tEIQENw9G+o3DAZ828uWZPFLa
         oVxPfA9oztkRkh7OKudzUTnldmiRmZ6ytau+1GJEzmbDS6aR3vAHtrx8sv0GjgIHvq0K
         xZ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VJK0PBreuPzBDOb7waUsCKk+533hJCftJx7HJWvGoX8=;
        b=IkUwdyXDGuVozE1xmEkJ1mhWgETA63deJdStxuXoiv+M+5vs06b2q3/5jmQWcP+hve
         X51Qb4A7FJ/MT3pxs7eBniQBWV2Jb9iKfZTnaQ7TKJZjvzUFsHnxOruV+k6IdFbBwGCY
         /GNg+XiSulXS3UJ131vzf1k3VfrpNL8Pnz7JhkoaUg7rWwXKTWrARGyG4HoINtd+NBE4
         4oNKC03iOPECUtPJaS7jmOBbf9p8zSRp+vyWgWKMfaN6rVrqdY9/N/+D/w8jCCDsi4yr
         nCbDQKYOMo2yPoq8iAE5K0fMZrkXi0vY/5vk2PCpJPzZNxTwxo5pzVV+uI2QOiopHbYo
         tq3Q==
X-Gm-Message-State: AOAM531PQ5JPFzgAAGP8Xc5SrOR0kcjO+3MlfBQidfV/3XYUro20pyLE
        muS8aksp83rr6l4Q0lnwkFiNeaNzNLLWlw==
X-Google-Smtp-Source: ABdhPJzEQf+zSf6zJLMLF5z2FcM1HBOOaJHKqgVgFhz6nrbB887wtIq4e0uhjaN3eK0t2TJg9avDkA==
X-Received: by 2002:a17:906:2c45:: with SMTP id f5mr12563485ejh.40.1614542081256;
        Sun, 28 Feb 2021 11:54:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm11295554ejl.1.2021.02.28.11.54.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Feb 2021 11:54:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/10] svn tests: refactor away a "set -e" in test body
Date:   Sun, 28 Feb 2021 20:54:13 +0100
Message-Id: <20210228195414.21372-10-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.116.g45ec00aa00
In-Reply-To: <20200223125102.6697-1-benno@bmevers.de>
References: <20200223125102.6697-1-benno@bmevers.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a test added in 83c9433e67 (git-svn: support for git-svn
propset, 2014-12-07) to avoid using "set -e" in the test body. This
would have broken in combination with a subsequent change to make
"test_expect_success" return 1 to catch such cases.

While I'm at it rewrite the test to conform to a modern style in our
tests, using the "test_when_finished" function for the "rm -rf", and
avoiding repeated "mkdir" in favor of "mkdir -p".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t9148-git-svn-propset.sh | 27 +++++++++++++++------------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/t/t9148-git-svn-propset.sh b/t/t9148-git-svn-propset.sh
index 102639090c..2b55e76be6 100755
--- a/t/t9148-git-svn-propset.sh
+++ b/t/t9148-git-svn-propset.sh
@@ -7,19 +7,22 @@ test_description='git svn propset tests'
 
 . ./lib-git-svn.sh
 
-foo_subdir2="subdir/subdir2/foo_subdir2"
+test_expect_success 'setup propset via import' '
+	test_when_finished "rm -rf import" &&
 
-set -e
-mkdir import &&
-(set -e ; cd import
-	mkdir subdir
-	mkdir subdir/subdir2
-	touch foo 		# for 'add props top level'
-	touch subdir/foo_subdir # for 'add props relative'
-	touch "$foo_subdir2"	# for 'add props subdir'
-	svn_cmd import -m 'import for git svn' . "$svnrepo" >/dev/null
-)
-rm -rf import
+	foo_subdir2="subdir/subdir2/foo_subdir2" &&
+	mkdir -p import/subdir/subdir2 &&
+	(
+		cd import &&
+		# for "add props top level"
+		touch foo &&
+		# for "add props relative"
+		touch subdir/foo_subdir &&
+		# for "add props subdir"
+		touch "$foo_subdir2" &&
+		svn_cmd import -m "import for git svn" . "$svnrepo"
+	)
+'
 
 test_expect_success 'initialize git svn' '
 	git svn init "$svnrepo"
-- 
2.31.0.rc0.116.g45ec00aa00

