Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72CBEC61DA4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 22:45:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjBFWpF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 17:45:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbjBFWox (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 17:44:53 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17132303F7
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 14:44:50 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id az4-20020a05600c600400b003dff767a1f1so4840243wmb.2
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 14:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBdJUEUwtxIbnrrIC1NS1tGLrjG7T6CDEOPSFLIpltA=;
        b=nHPgTOL6RRl9lRYBWxIZ2O1zLY6EnJlGpWBaNFfaHBvC+gaf/nPVddMvXwUSXEcYyH
         Qr8+EZE7chT2KeIbcQgOcfsNucDVhMXZW6jWyQ5NHJtdOvsJzFIanGrgHnhyWKomwQfB
         kmjA7tE0vrcl7G1V9/LJl2UxLz0FR06T0ra1jA4rwH3jsVRtUAqsGGftCsvEkt1pffyx
         p+tUPoZQWddwa85EGu84XVFiOY6qPNRsvDTfNHKmqaLibTkRwFRiklyFjlFlx+bPmA0L
         5wxHrT8ih4MhD8yMi3zRbsTb85PLP7Hknna+IfgPNG5OnP979tTNzRc19cGKw38RG3lR
         tQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yBdJUEUwtxIbnrrIC1NS1tGLrjG7T6CDEOPSFLIpltA=;
        b=QsOhGsy8D5u5edgvE1UENrQNM4TnheHBjeeU8iKFd9smiOIIRDE+9Hyrnpe8ACAs6W
         UJPg+Y5tBpJn9OMGmHqUKJNXFwptQ1rNepT/VHzcR2BBLZ40OEpy01q+ZPpUr7+KBHkD
         mH2L/e5j+HHlXwfmZMWWZg0IAOsn7ywok8cLRXYfJRaRF4G2/eXmzPhd4trumQ61IpJl
         F/tw7ogFNhraguKMvbiDS/j/GLna+B5NlawQAsG6qA6kTFQMLRfw469h+vKYdN5dDFrA
         pg7OqFHmPiVHvwwgZNcprNzctAZirfmDfVMtnuw2C2lPu9tqwL0a7lfaAK2wG80GcwWX
         8+0w==
X-Gm-Message-State: AO0yUKWuZnbAyDwC6d258zUE3idDJGYnsOKEL7xwdUzKSbGQJAssnnLd
        z5I8DqMV+vlZkErGrlmP8728JxoJKSztl2P0
X-Google-Smtp-Source: AK7set9V0UnHIfJXTAseFlkG9Oxnlh7QR08d4nFdimaJ5ixL8llPNp1+xHYuVxxfGEXindiImuLzOg==
X-Received: by 2002:a05:600c:4d17:b0:3e0:b1:c118 with SMTP id u23-20020a05600c4d1700b003e000b1c118mr1191470wmp.5.1675723488753;
        Mon, 06 Feb 2023 14:44:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020a056000128700b002c3df9279f5sm6657643wrx.48.2023.02.06.14.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:44:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 6/6] tests: don't lose misc "git" exit codes
Date:   Mon,  6 Feb 2023 23:44:33 +0100
Message-Id: <patch-v5-6.6-e7f10c0641a-20230206T224200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
References: <cover-v4-0.6-00000000000-20221219T101240Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20230206T224200Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a few miscellaneous cases where:

- We lost the "git" exit code via "git ... | grep"
- Likewise by having a $(git) argument to git itself
- Used "test -z" to check that a command emitted no output, we can use
  "test_must_be_empty" and &&-chaining instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1401-symbolic-ref.sh    | 3 ++-
 t/t3701-add-interactive.sh | 8 +++++---
 t/t7516-commit-races.sh    | 3 ++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index d708acdb819..5e36899d207 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -33,7 +33,8 @@ test_expect_success 'symbolic-ref refuses non-ref for HEAD' '
 reset_to_sane
 
 test_expect_success 'symbolic-ref refuses bare sha1' '
-	test_must_fail git symbolic-ref HEAD $(git rev-parse HEAD)
+	rev=$(git rev-parse HEAD) &&
+	test_must_fail git symbolic-ref HEAD "$rev"
 '
 
 reset_to_sane
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 5841f280fb2..f1fe5d60677 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -296,9 +296,11 @@ test_expect_success FILEMODE 'stage mode and hunk' '
 	echo content >>file &&
 	chmod +x file &&
 	printf "y\\ny\\n" | git add -p &&
-	git diff --cached file | grep "new mode" &&
-	git diff --cached file | grep "+content" &&
-	test -z "$(git diff file)"
+	git diff --cached file >out &&
+	grep "new mode" out &&
+	grep "+content" out &&
+	git diff file >out &&
+	test_must_be_empty out
 '
 
 # end of tests disabled when filemode is not usable
diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
index f2ce14e9071..2d38a16480e 100755
--- a/t/t7516-commit-races.sh
+++ b/t/t7516-commit-races.sh
@@ -10,7 +10,8 @@ test_expect_success 'race to create orphan commit' '
 	test_must_fail env EDITOR=./hare-editor git commit --allow-empty -m tortoise -e &&
 	git show -s --pretty=format:%s >subject &&
 	grep hare subject &&
-	test -z "$(git show -s --pretty=format:%P)"
+	git show -s --pretty=format:%P >out &&
+	test_must_be_empty out
 '
 
 test_expect_success 'race to create non-orphan commit' '
-- 
2.39.1.1425.gac85d95d48c

