Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B702C433EF
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 22:21:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiFUWVw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 18:21:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiFUWVr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 18:21:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6543136D
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:46 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id g27so14171751wrb.10
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 15:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rqNBfvp4my4bCi5uvbYD0WQkZ1JkQlO4DgdcROZUjpg=;
        b=H3rCI7uSw3esz+je9KGJHNVZKxH/yUE9qHe9JW52f4iyS51u86qEmhmrEyQfYLiB7J
         ivYAXlbewmWumCSyjvrlLLnkS7f09I5lIr2ZyxzDQF5OEQxIH3n/kkhtAieo7j0aKGcO
         qDQKlAVFdRp3NLNywC+JRAhLHcyU1TGovssXf9BT29cfn1tzEM4rPl/zJZnEk2LVjmMh
         sFZFG7bv3QkLIECASfj1uvAhGO5SqGbByn7pCRc0lllKat7jck/CKfDJyBmEyOJVGkIE
         ftRdtV71/722GS9XBkD5jgaeliJusApUD18sbDYWmATlGmdC7yGsiKoY/xmOvj6wKXUA
         VKcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rqNBfvp4my4bCi5uvbYD0WQkZ1JkQlO4DgdcROZUjpg=;
        b=HqtNVEqzUyxmP+jtklCWn/jqgZmAISCmFlTHi47ksHt8hz3qNX9YrB6GxmgK2w/jr8
         P7PZuHe1x3FpCoPa26YCUZlkNyDCwDyTamhoo4tq8uUwgkKDL9kC/7SoK1mN+gyHAkQa
         CeSXQ00Il1wUp8Vk+BhVTE1uoJKERJ3w/wXu7VF1KtrEL8rjVJg68/oK6FlVrB575gYV
         DR3Q9G+mb378gkMvSIZLCysqrxz7pIvE9zX0x0sgThOLInplYtUn42QcdzxDUE9DGHsq
         xxf2pJRG5MuAgJlPFKLqXqOxcldWdidff6Z2WCH6Q1dIKw1HA2kA2iogqZa0ss0TlXDY
         8PfA==
X-Gm-Message-State: AJIora8kVwCi0W7hHevJvWcGfEtrUvjA6Dta3ArHW2XE345z0wGjSnq8
        h0Q0nrhXRy0zOadSVakPXz3kVP46ByTDkQ==
X-Google-Smtp-Source: AGRyM1sRT7XJmVXphzZhn7qDNo/rcruCkcy33m2O+Q4sjlUGLZXeU8LWISk94Px7owjK/+Uh7U7VaQ==
X-Received: by 2002:adf:f411:0:b0:21b:8397:860e with SMTP id g17-20020adff411000000b0021b8397860emr195625wro.50.1655850104606;
        Tue, 21 Jun 2022 15:21:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u2-20020a5d4342000000b0020fe61acd09sm17547431wrr.12.2022.06.21.15.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 15:21:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        rsbecker@nexbridge.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/3] test-lib.sh: fix prepend_var() quoting issue
Date:   Wed, 22 Jun 2022 00:21:39 +0200
Message-Id: <patch-2.3-e06bf0cdfbe-20220621T221928Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20220621T221928Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a quoting issue in the function introduced in
b9638d7286f (test-lib: make $GIT_BUILD_DIR an absolute path,
2022-02-27), running the test suite where the git checkout was on a
path with e.g. a space in it would fail.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 55857af601b..8cabb4d10f9 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -57,14 +57,14 @@ fi
 #
 #	prepend_var VAR : VALUE
 prepend_var () {
-	eval "$1=$3\${$1:+${3:+$2}\$$1}"
+	eval "$1=\"$3\${$1:+${3:+$2}\$$1}\""
 }
 
 # If [AL]SAN is in effect we want to abort so that we notice
 # problems. The GIT_SAN_OPTIONS variable can be used to set common
 # defaults shared between [AL]SAN_OPTIONS.
 prepend_var GIT_SAN_OPTIONS : abort_on_error=1
-prepend_var GIT_SAN_OPTIONS : strip_path_prefix=\"$GIT_BUILD_DIR/\"
+prepend_var GIT_SAN_OPTIONS : strip_path_prefix="$GIT_BUILD_DIR/"
 
 # If we were built with ASAN, it may complain about leaks
 # of program-lifetime variables. Disable it by default to lower
-- 
2.36.1.1239.gfba91521d90

