Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D25C433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378904AbhK2Sbc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:31:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378894AbhK2S3a (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:29:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E331C12B686
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:02 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id d72-20020a1c1d4b000000b00331140f3dc8so12598880wmd.1
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jyhDyr3iCiLNQOLsZxbElkyFBkCNjdpPRLUxg6IUNLA=;
        b=K8k9h85Sc/YLTRQ96VZgMwLLhWJRNAUktPFTTkI20rnC91l4lHomDFffkpKCS00Oa2
         gmFqqXhNpxMkv0hAy0CjpSPTJ9y9XRUyf8+O3oH6IpOjj9q38zzbFEGHsxygQjhBjrhc
         GmIXfuF0Gty9JF87MDs14ZdIMBxv1L+A/XUjqXC8cl0APwcWYGJSXXcgmcJ20atD3eLh
         7Br9xUUtjXIXFiUVAddpSSZgjL05U/I80RwsXqVQ/33sP4bPkpU7ekON60Umf/R5Mebb
         e/7jQitjOO9L4QNeAwa+c6QKn/WdCpm2IOitDS/rUgo+nyT+wJAcRJAOy0tJ4bvygxgv
         OnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jyhDyr3iCiLNQOLsZxbElkyFBkCNjdpPRLUxg6IUNLA=;
        b=65nP6p6jH8lEvjGpayvVaNp8J9/S/qcRNKR2W5/jkuymUJ2XjGNPfBF7yztLrfbgKO
         zSu9fmCHmEOZ0dzZPg7F5Jl/4e9k8grrLgN3gkwhf8jgwHdgA3f7Uej2e/5Ebz5Aup7V
         FnGJEsR360GusIVaPLtdJxnW80wtfvRlgp8aGw1YTb5qxzGsOdEozXK2OMpc69fpqweR
         yV5hT7iEdYa32I3VdmhADAdRcf0v7g5/itNuO8Ox8hrSB8m2b+tY61TxmHybttEs6mYX
         NKk9Ym/ubsBm3RPec4N2G0AgWTZkHv+C+O9aFrXSlxPsjiYgzAdT6KW2D9Uypx9zZd3d
         iwoQ==
X-Gm-Message-State: AOAM533KHnErrer386uZrzMBwjnuDBihfwZaGvbQwiESZZvoorP2rLu6
        a7JvDNLrfyAixVqRuQmIKxsW+rhQ1XDWcA==
X-Google-Smtp-Source: ABdhPJxP95sskygndf3P3/XICS2Up9A6ZlAOpZ7V67s1dDkIGzJtjApG9SrvBCa6nvxRrGmcmAQZtw==
X-Received: by 2002:a7b:c38b:: with SMTP id s11mr37123684wmj.29.1638197458992;
        Mon, 29 Nov 2021 06:50:58 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:50:58 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/7] grep tests: add missing "grep.patternType" config test
Date:   Mon, 29 Nov 2021 15:50:49 +0100
Message-Id: <patch-v3-3.7-fcad1b1664b-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the grep tests to assert that setting
"grep.patternType=extended" followed by "grep.patternType=default"
will behave as if "--extended-regexp" was provided, and not as
"--basic-regexp". In a subsequent commit we'll need to treat
"grep.patternType=default" as a special-case, but let's make sure we
don't ignore it if "grep.patternType" was set to a non-"default" value
before.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7810-grep.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..724b1bbbc1c 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -451,6 +451,15 @@ do
 		test_cmp expected actual
 	'
 
+	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
+		echo "${HC}ab:a+bc" >expected &&
+		git \
+			-c grep.patternType=extended \
+			-c grep.patternType=default \
+			grep "a+b*c" $H ab >actual &&
+		test_cmp expected actual
+	'
+
 	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
 		echo "${HC}ab:abc" >expected &&
 		git \
-- 
2.34.1.841.gf15fb7e6f34

