Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB510E92716
	for <git@archiver.kernel.org>; Thu,  5 Oct 2023 16:13:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237782AbjJEQMy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Oct 2023 12:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240183AbjJEQLf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Oct 2023 12:11:35 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4D586AB
        for <git@vger.kernel.org>; Thu,  5 Oct 2023 01:17:09 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-690ce3c55f1so601884b3a.0
        for <git@vger.kernel.org>; Thu, 05 Oct 2023 01:17:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696493829; x=1697098629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8AgE+8obshuk1Rml4YfE5LWsgHMCVcELmmhJe1Y9Kwc=;
        b=hD9/QSttT/ffG7M664G9IFlyu66eDmgkzwcFX+m1hYKGeMZ0dDJ6TKE5uFXTnVru16
         ICFJltgQ9SUdxZTMMbGDiE2FHEjEJwNrOhxXC5y70c60aL9DSXVJZvhZcbW/WxHenWeQ
         wv0jcmIutKcHnAR4YGUij+T4fIqdCJPaQ0Bp5NzoNA9yE7arT2194cF02wZy+rUrf6lT
         N7FQvvKgS+mvkWMkKqX8sGhoRRo3pZTdrEeqb/xC7/EG9gypcuut7iA25Le6NP/Jf+SF
         Wxnl7zhURafo+Zx477kiUbPBKdQ5JjKMiykzLJNpOiG8nmaSZmTDU8Fn5yNMKlNahacq
         Akxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696493829; x=1697098629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8AgE+8obshuk1Rml4YfE5LWsgHMCVcELmmhJe1Y9Kwc=;
        b=igbgol8KnWwuMHbbEjwqp5N3O/hn2fQP1VTztpyXRwJ6xwv2wMS02UT+DAx+h9VTQp
         LRVVjHKSq+qUFRsAakrvMGS3hTQnCQ5NTmGlUp/o+O0h8daShT7qpvLltaAu9oY94ZJd
         I0dgEOzIWpHp6EWyHevh2TD/yBHrZsQ+LModsO6LCJJgvSqHcit0pvoSngyhIKsGUXAo
         2dKzplj7loYOU/jrjRK39POvy/2VCEEJXf27NwUslchPdJntxcri1Iwzvmm/8dWy6Np+
         6uRO7VLHB92f3+A+K3LodpTf3BxgltBaxXHCNWWJdcT7RaO+CBo8xcicSLdcXaisIMTu
         buDA==
X-Gm-Message-State: AOJu0YxESHYCiEo0yzVO01dTJEkqKxUMG8AoqVF2Ae0h0xGBXKEV37SN
        MN60zEUjKn9UimsojxGkXls=
X-Google-Smtp-Source: AGHT+IFPDwjcM1wv4Mi6+VUKtwhRAyvaYcrP8q/PcWktQt8kJCpV7Eth9Uh3pTx35TEE2rNvhG77ig==
X-Received: by 2002:a05:6a20:9189:b0:153:b16e:8db1 with SMTP id v9-20020a056a20918900b00153b16e8db1mr5089291pzd.10.1696493828963;
        Thu, 05 Oct 2023 01:17:08 -0700 (PDT)
Received: from localhost.localdomain ([2405:201:6805:207c:11d5:b720:d5d4:b9ba])
        by smtp.gmail.com with ESMTPSA id ju20-20020a170903429400b001c22292ad7esm982598plb.232.2023.10.05.01.17.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 05 Oct 2023 01:17:08 -0700 (PDT)
From:   Vinayak Dev <vinayakdev.sci@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Vinayak Dev <vinayakdev.sci@gmail.com>
Subject: [PATCH] t4014: replace "test -f" with "test_path_is_file"
Date:   Thu,  5 Oct 2023 13:47:00 +0530
Message-ID: <20231005081700.50473-1-vinayakdev.sci@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Vinayak Dev <vinayakdev.sci@gmail.com>

Many tests in the codebase use test -[e|f|d].. commands
to check for various conditions. However, the test command
upon failure simply exits with a non-zero exit code(usually 1).
Therefore, replace instances of "test -f" from t/t4014-format-patch.sh
with the function test_path_is_file() defined in t/test-lib-functions.sh
that exits with a debugging-friendly diagnostic message upon failure.

Signed-off-by: Vinayak Dev <vinayakdev.sci@gmail.com>
---
 t/t4014-format-patch.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 0a4ab36c3a..5f7d0836d6 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -763,7 +763,7 @@ test_expect_success 'format-patch from a subdirectory (1)' '
 		false
 		;;
 	esac &&
-	test -f "$filename"
+	test_path_is_file "$filename"
 '
 
 test_expect_success 'format-patch from a subdirectory (2)' '
@@ -782,7 +782,7 @@ test_expect_success 'format-patch from a subdirectory (2)' '
 		;;
 	esac &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "sub/$basename"
+	test_path_is_file "sub/$basename"
 '
 
 test_expect_success 'format-patch from a subdirectory (3)' '
@@ -794,7 +794,7 @@ test_expect_success 'format-patch from a subdirectory (3)' '
 		git format-patch -1 -o "$TRASH_DIRECTORY"
 	) &&
 	basename=$(expr "$filename" : ".*/\(.*\)") &&
-	test -f "$basename"
+	test_path_is_file "$basename"
 '
 
 test_expect_success 'format-patch --in-reply-to' '

base-commit: d0e8084c65cbf949038ae4cc344ac2c2efd77415
-- 
2.42.0

