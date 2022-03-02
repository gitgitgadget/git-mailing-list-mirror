Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F67FC433FE
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243884AbiCBR2t (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243935AbiCBR2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:31 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3741E17A95
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:42 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id x15so3868296wru.13
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gk64hYmDDzx7I1kXYmzgn8G8sS/A1+pzGNK0kxNhdRI=;
        b=WZje2nKu7dSzmLUndPjGgNiPP9DN6iozaCbay38drr8IRIILLclT1y/LrwGwdH9VRM
         OdpMccdOSSOPfJ/k9bmySbwbP7YahMkTKSvX3o2ajx0G9fBRWtlWhRz1JShSwpZczjyo
         T1UHSzYOAzC502oIou2jzSHEusMs+KgA5mOU16uytSLKdWmmmDfvjD1pXlQ+KiGT6Kya
         H0+PU59ShRK+GmhSsoJwJdLFzGUy7UOBI72VNpCHwy6Q81f7s1d+73LGNLOWMJdHt4cE
         F9sECu6DHFcQa3xDxcOXrLDzVnBY0Y1ybIm6jkCMApjqLFL8KciN/JixpQSj2ePuF3TF
         uS1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gk64hYmDDzx7I1kXYmzgn8G8sS/A1+pzGNK0kxNhdRI=;
        b=5hrbAwA4PJAW+Y/+2fMvQ5jLSUV2mR8/kNhJxQF/m0hH9sHSLfxW4M7LcJYnpSwXhY
         wh/MDPY/+hX1kNHQIuHmy2e/rNfsS62vH0aq2ds/j+PGma0ZJOSMD+dVwq8i3WqkWx5s
         XRBmXx8y65rbFTF8vl53x4dfpv7uoZ8bYxyP2ymopmZt8MulJckBtJz/RrWg+2IAsWhd
         DY8Sz6+EhXxyUUj2f4N9x27+kvf94S9hcN9C0pLU7F+tPTSpNnBejfh+OZWYhEm1IhuF
         oj/Km8oj3sme1pGj6PX7zPhAGFnGZQdxBYTC16e6Y46cyIZd+Z35WD9rbrDXUuecTfQp
         XxzA==
X-Gm-Message-State: AOAM531vxnBykjqMyoARPl42TjscrtQk0HvStc4gT42BnTE5ij2IlJ25
        K38VJBd+gwYympPKMDeeEDKSxaN/RT1X8A==
X-Google-Smtp-Source: ABdhPJxLlqgD0zBWgI7r17kd4d3adD6rgnSQxFOvN48P9M+9LdFwY0kCWTtJGblr8NFyfFUw3H7gOQ==
X-Received: by 2002:adf:fd0a:0:b0:1f0:25fd:4082 with SMTP id e10-20020adffd0a000000b001f025fd4082mr3516792wrr.501.1646242061326;
        Wed, 02 Mar 2022 09:27:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 13/15] apply tests: don't ignore "git ls-files" exit code, drop sub-shell
Date:   Wed,  2 Mar 2022 18:27:22 +0100
Message-Id: <patch-13.15-834809b1b8a-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix code added in 969c877506c (git apply --directory broken for new
files, 2008-10-12) so that it doesn't invoke "git ls-files" on the
left-hand-side of a pipe, instead let's use an intermediate file.

Since we're doing that we can also drop the sub-shell that was here to
group the two.

There are a lot of these sorts of patterns in the test suite, and
there's no particular reason to fix this one other than in a preceding
commit all similar patterns except this one were fixed in
"t/t4128-apply-root.sh", so let's fix this one straggler as well.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4128-apply-root.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t4128-apply-root.sh b/t/t4128-apply-root.sh
index ba89a2f2d73..f6db5a79dd9 100755
--- a/t/t4128-apply-root.sh
+++ b/t/t4128-apply-root.sh
@@ -96,7 +96,8 @@ test_expect_success 'apply --directory (delete file)' '
 	echo content >some/sub/dir/delfile &&
 	git add some/sub/dir/delfile &&
 	git apply --directory=some/sub/dir/ --index patch &&
-	! (git ls-files | grep delfile)
+	git ls-files >out &&
+	! grep delfile out
 '
 
 cat > patch << 'EOF'
-- 
2.35.1.1226.g8b497615d32

