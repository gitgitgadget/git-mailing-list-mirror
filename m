Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48914C4332F
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbiKCRHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiKCRHM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:12 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E606C1E3C1
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:27 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x2so4062573edd.2
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qY9UoJpPZ6SR+OgozlZaW8e24wuVkkRdIzp/8TdXLZo=;
        b=ganO36WdCRQCr3Awc4twSJT/Ydl8/l5XqyDecWz2mGPezKylb42hOnPiNbeejkszmi
         VtKCTRJbJxXzJ1TLHnhEXRpfUuYLcEdcLt6OFd9awSXIQLviPkXvcDAFGBzccB09qQ3h
         Qw52HX633Yfl0sE/vvPDY8+nTYewoay2+hsOlZ/axkuSITH6Z6HzRcD3IdzGFiEEGqEr
         Or6OySsoirFlM63UUqnTCgLRtvJxobUs8aiCvoihQg7VXjggaC8okjlJXTyNlrXSFb7e
         lkyCJtZIzYquURo/lklffUyEp2fqUtBrJCkaB8mdY4rqj0xBYuUksZmyLsx4Xa79oyHF
         /RvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qY9UoJpPZ6SR+OgozlZaW8e24wuVkkRdIzp/8TdXLZo=;
        b=aCcbqpUBpJwI/2lIIirTNM1fojpm7M0kjEB8+hDjA+e1q5F6jhe363VWNg0uA39Ata
         rPNzGvDgM09RGamTxGCy48q8EgmAOkya1P1XKDQfhHdLw1EP64Yz467sTYmQ58FWWw71
         j+N9CO0SVXwmh3ZqHNo7l8xtQVv0Cb7T96c82KB2SwtJ23J2gnnG6qjSEHf4xhdBT4lH
         Wm+tE/D4998QLqmbLaWQKfzFuHjqQieLmzqpQLnTeWtblFfqCQsNcM5FOFm8XtWDiNyC
         dyu1z2kZ14xRe33xp49AZutvrFZrX/iYebBeKtyVFtSubww8mUN/AVLnIizGHRkVYXzV
         /fFw==
X-Gm-Message-State: ACrzQf1pTYabhQF5TswJGKLh/P0vsgm6js45J2F4+xSv1pRg9Jtr6LdV
        4yJGP79l12TYAgNWw/AuNHXhKwsDXbXFcQ==
X-Google-Smtp-Source: AMsMyM7qKhC3gm/UCwNLteRUyfP1IQnCbrydplOjincp3dD4pFMjth8zf/CznoaKptqOLhn1YKwesA==
X-Received: by 2002:a05:6402:1505:b0:463:1a0c:4db8 with SMTP id f5-20020a056402150500b004631a0c4db8mr368562edw.70.1667495186048;
        Thu, 03 Nov 2022 10:06:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 07/17] unpack-file: fix ancient leak in create_temp_file()
Date:   Thu,  3 Nov 2022 18:06:06 +0100
Message-Id: <patch-07.17-38e7c863dd8-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been with us since 3407bb4940c (Add "unpack-file"
helper that unpacks a sha1 blob into a tmpfile., 2005-04-18). See
00c8fd493af (cat-file: use streaming API to print blobs, 2012-03-07)
for prior art which shows the same API pattern, i.e. free()-ing the
result of read_object_file() after it's used.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/unpack-file.c        | 1 +
 t/t6060-merge-index.sh       | 2 ++
 t/t6401-merge-criss-cross.sh | 2 ++
 t/t6406-merge-attr.sh        | 1 +
 t/t6407-merge-binary.sh      | 1 +
 t/t7605-merge-resolve.sh     | 1 +
 6 files changed, 8 insertions(+)

diff --git a/builtin/unpack-file.c b/builtin/unpack-file.c
index 9e8119dd354..88de32b7d7e 100644
--- a/builtin/unpack-file.c
+++ b/builtin/unpack-file.c
@@ -19,6 +19,7 @@ static char *create_temp_file(struct object_id *oid)
 	if (write_in_full(fd, buf, size) < 0)
 		die_errno("unable to write temp-file");
 	close(fd);
+	free(buf);
 	return path;
 }
 
diff --git a/t/t6060-merge-index.sh b/t/t6060-merge-index.sh
index ed449abe552..1a8b64cce18 100755
--- a/t/t6060-merge-index.sh
+++ b/t/t6060-merge-index.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='basic git merge-index / git-merge-one-file tests'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup diverging branches' '
diff --git a/t/t6401-merge-criss-cross.sh b/t/t6401-merge-criss-cross.sh
index 9d5e992878f..1962310408b 100755
--- a/t/t6401-merge-criss-cross.sh
+++ b/t/t6401-merge-criss-cross.sh
@@ -8,6 +8,8 @@
 
 
 test_description='Test criss-cross merge'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'prepare repository' '
diff --git a/t/t6406-merge-attr.sh b/t/t6406-merge-attr.sh
index 8650a88c40a..5e4e4dd6d9e 100755
--- a/t/t6406-merge-attr.sh
+++ b/t/t6406-merge-attr.sh
@@ -8,6 +8,7 @@ test_description='per path merge controlled by merge attribute'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6407-merge-binary.sh b/t/t6407-merge-binary.sh
index e8a28717cec..0753fc95f45 100755
--- a/t/t6407-merge-binary.sh
+++ b/t/t6407-merge-binary.sh
@@ -5,6 +5,7 @@ test_description='ask merge-recursive to merge binary files'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7605-merge-resolve.sh b/t/t7605-merge-resolve.sh
index 5d56c385464..62d935d31c2 100755
--- a/t/t7605-merge-resolve.sh
+++ b/t/t7605-merge-resolve.sh
@@ -4,6 +4,7 @@ test_description='git merge
 
 Testing the resolve strategy.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.38.0.1451.g86b35f4140a

