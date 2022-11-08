Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BFB4C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbiKHSSZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234430AbiKHSSN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:13 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC4B315A20
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:01 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id f27so40819154eje.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOSDui1dFs3pk0J5gnQBB7uYPDw0kUKKb6xtvgKRXM8=;
        b=Po9wL4GjIBAhUs4tVpOEA/pNcQomXoHVU+HXl+cPHZlV3Y5+riEDRJnQdgcI1Jtiow
         Vqidbx8rMRPLcBeLERQ5b3lR21dGlVi2ibnY+Y0tLvgTkqBWm1ie5pq9N++sBDwNOxMA
         LYQSvQfh3gS+/TqpzHLUKMSpVE6UhEwFpwaorzNb1hP7cD+/xrfwPkuAzVW4u3IfWKJW
         O4aQrrRc4Zd3xX2hRRjlzTwCTNVeaEXON7NjiE6mKGzEuhH8aT7pQd3YU+g0ddoGnh6Q
         BLegQ6PbxJO2Lg3eOoAyLNbZ9EjjFqjGzl8MWi+rPw6PabPbXCHdmPIsvXSFe/omOO0S
         fjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nOSDui1dFs3pk0J5gnQBB7uYPDw0kUKKb6xtvgKRXM8=;
        b=mpHZyZDnJFEnz1yb3hzxfgK2IZOWQCe7+6C9v7BOCAmuFON4za+MqP3SW84/Vuxp0u
         TyGo2uH+aya2AJvpWKQjPuta+mdHfOKa9KLyiurj803PT1vMqeYKc7c4ACLnY+93qPCc
         7Tc/OLXdGoNoUmt410f0P60FagZodruQMepn55Qux637R+vffhuwaxM+0ekyHq8yTqkp
         zQa3P2GrCwzMF0EUZYcF4Y1+xaF+5IZv5VcQbSBQvmH3oyQAfozwMq6lAGlHSz546fVk
         FUGzOOymFTNlm5sroIYKv+Rz2QOJtVbH528E77Bs+3NKDoVLTf9M0FV1/jX6bfUk8fbr
         u60w==
X-Gm-Message-State: ACrzQf0hFSEDdCpuoh96b/qzbQ6GSRZlys6IKFpLrLvp5V0gpCmAohBE
        tewIIYadXwq/zLWNd5rLixbGKVHeFdZIFw==
X-Google-Smtp-Source: AMsMyM4FtfmY9aMyjjmmdLyENgi295d8Aadkhzn7FNiry7lvlttsuZzMoSBdB+V/ibnhw7IpwcgFDA==
X-Received: by 2002:a17:906:cc48:b0:7a8:4a3b:11f7 with SMTP id mm8-20020a170906cc4800b007a84a3b11f7mr55309388ejb.388.1667931479326;
        Tue, 08 Nov 2022 10:17:59 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:17:58 -0800 (PST)
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
Subject: [PATCH v2 07/15] unpack-file: fix ancient leak in create_temp_file()
Date:   Tue,  8 Nov 2022 19:17:43 +0100
Message-Id: <patch-v2-07.15-a2cc6f10d0d-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
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
2.38.0.1467.g709fbdff1a9

