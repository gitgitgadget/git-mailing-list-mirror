Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A5A6C433FE
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 13:26:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231592AbiKDN0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 09:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiKDNZr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 09:25:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 721012F3B8
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 06:25:00 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id ud5so13272585ejc.4
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 06:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8gUAFl7bhpV7Eqs4bDpWRpbSNS5chKHHzllU1WVJ9CQ=;
        b=ATO+1jN8qQvxcoOCjUcMYdAKi6jFM1wND5NO0EtwfVrEO0opd/zSKF7qzArETDiT8r
         omLYXUGIB5vVlcIvgDxKKpZDoVKNLNBA9aZjm2d0kKs9ry9HTEyyvRKWolW6By214NBK
         YBDlKQjPpNSVrIOxpJpZXDftWsr5bUQCyZSC/lKb91JPHps0OavD56CJcK4znK2Li+X7
         aYpmrM5s31LWrBUIeAlT233KwZxgc/BfTgOPEq5Jy0tQqoV5md9DvlJ4Yb/kczQksgsp
         fY1r2vEV25UMvH9cPtQ2+GnSkev0e+hi1/VxYOhwx6Umy6XyrejB+i5YtU4ZNG/Eu/Z5
         N0dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8gUAFl7bhpV7Eqs4bDpWRpbSNS5chKHHzllU1WVJ9CQ=;
        b=eoqAK5LwseZiKCUVeWbjHbt+mDUB7/Vq9+Lna7/gmWmLdJAMYM8aIhNf7MPYC8yXwH
         ksXGLces9cfT0oIXq8bDEqmT8pqtDHThG2I3xsRNu+03R/ORPPfr+o7azpIyNwnaWX/3
         yjd5ZQCfNaDlJrYSvPSq3VavcgDgOsmCXDgDF2waITF92BoovG3helBSb4v0XLxSt+w5
         ucbugOFijb3zdThwEIviWk2u3RalsCnnHkLRvoLcRmhh4vHc0lhrU9p3XH9/lVRcCBo4
         KTAvXudf8vNdqK5ynOSJSUMacqrUGQ/Zk+oqa7b+FVdg+MFe6+jWr4czC/IyK4lzuu2N
         papw==
X-Gm-Message-State: ACrzQf2lnZ+jSZ1noir8bMEopOEhsfr6DxNeG6gw9+c82Hp2T3oQ9lXp
        ioMpu3foQ0eQZkgVIjGVz67IzzbZ9kUO1Q==
X-Google-Smtp-Source: AMsMyM4tbepx5LFkXkRz5UTtt/SlKhgRFSem1qGum5DX+IDikeNsFzpdxRseDfMkBOQ5omK7dkRrHg==
X-Received: by 2002:a17:907:7286:b0:7a1:ba0:7d7a with SMTP id dt6-20020a170907728600b007a10ba07d7amr35294961ejc.227.1667568298517;
        Fri, 04 Nov 2022 06:24:58 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a170906318600b007ae38d837c5sm652979ejy.174.2022.11.04.06.24.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 06:24:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/13] bisect test: test exit codes on bad usage
Date:   Fri,  4 Nov 2022 14:22:43 +0100
Message-Id: <patch-06.13-e2a69bf8f3b-20221104T132117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1452.g710f45c7951
In-Reply-To: <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
References: <1cb1c033-0525-7e62-8c09-81019bf26060@redhat.com> <cover-00.13-00000000000-20221104T132117Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Address a test blindspot, the "log" command is the odd one out because
"git-bisect.sh" ignores any arguments it receives. Let's test both the
exit codes we expect, and the stderr and stdout we're emitting.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6030-bisect-porcelain.sh | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 69fad3f94f6..eace0af637e 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -34,6 +34,36 @@ HASH2=
 HASH3=
 HASH4=
 
+test_bisect_usage () {
+	local code="$1" &&
+	shift &&
+	cat >expect &&
+	test_expect_code $code "$@" >out 2>actual &&
+	test_must_be_empty out &&
+	test_cmp expect actual
+}
+
+test_expect_success 'bisect usage' '
+	test_bisect_usage 255 git bisect reset extra1 extra2 <<-\EOF &&
+	error: --bisect-reset requires either no argument or a commit
+	EOF
+	test_bisect_usage 255 git bisect terms extra1 extra2 <<-\EOF &&
+	error: --bisect-terms requires 0 or 1 argument
+	EOF
+	test_bisect_usage 255 git bisect next extra1 <<-\EOF &&
+	error: --bisect-next requires 0 arguments
+	EOF
+	test_bisect_usage 1 git bisect log extra1 <<-\EOF &&
+	error: We are not bisecting.
+	EOF
+	test_bisect_usage 255 git bisect replay <<-\EOF &&
+	error: no logfile given
+	EOF
+	test_bisect_usage 255 git bisect run <<-\EOF
+	error: bisect run failed: no command provided.
+	EOF
+'
+
 test_expect_success 'set up basic repo with 1 file (hello) and 4 commits' '
      add_line_into_file "1: Hello World" hello &&
      HASH1=$(git rev-parse --verify HEAD) &&
-- 
2.38.0.1452.g710f45c7951

