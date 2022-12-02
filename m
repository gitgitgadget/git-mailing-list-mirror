Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66256C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 00:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiLBAH0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 19:07:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231342AbiLBAHW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 19:07:22 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0EEC5129
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 16:07:21 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id gu23so7982407ejb.10
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 16:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jd75qDYW4QtrqrmJ31ywQCkiHZdH9+1KpGTe3aVyUIg=;
        b=oKVUcltzLj0/10sNJbBgqF0keEbs4Q2AsSycII9c4QRxCk0qRtN0BMV+oSrO+Ze6zC
         4fDTqDU3HxDOD0+2oJUitC2pCd+RJ7vRhIBnNWrZ0JpM6FRwcuntoO6YQsm7ptAx+YFy
         xhbnqDjsCjcpuKjlxRjkCf3R3zS6bcg+85W46MiJ4tRNF+i0yv05cZSyCFvXcPBm5AMi
         Y2ZP/IU9Zllhy/LkwpyvKEgRhX9jv9JsJQb1TUnEIj0gSNIAkjQHaoXVrah2GajZ0TIL
         KJHZM8x+uNtL05gyVraNcqxktZXdxvUiGp0XWygPl2WNJWc/wxIaEtClD/a+WIbpiCi1
         CkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jd75qDYW4QtrqrmJ31ywQCkiHZdH9+1KpGTe3aVyUIg=;
        b=L9KF+q4JWmfOSEelUg1LbTlpx5g+Ztb1aJ62Ow5C/RaUiFWmiktpviWaojvTaPJPVM
         A2MUFUhiuRBuw9Cm+0Bhq6PWSOBTG3hs+aIAC+E3DTlJwv3fLFxlYnUPlDevLLwC8dqg
         4jmGCyVeHEyBc5TMakITU/mIdZKu8WsEParsk11+y5NfSK94aYBIW7//aRVY7VJh9gnd
         whwZUt6/0FszwdNZsvyD5qxn8tvre7zqtIqOuZUKKv5kOPfhI38vPMLhEohmy+3RhUDC
         VchuKjd2x/yZ/lYUWHM5GJ3WjylKbPUKKACPdsWDITGHDQ2QIJ4XVuH7u5lDcokPPrFk
         9aZg==
X-Gm-Message-State: ANoB5pljj4mdOW+hLGCX2PYzHmv7919wuHgyxxO5fBAOuisr9mokU2KP
        BYX0CNS//hVoDwlQmclLABhgH30RzsOA8w==
X-Google-Smtp-Source: AA0mqf4Kql6/G+u6y1d2jrQbt9cPYbNVajlDlm6HthQOcwjSKjNjL/EQLaOs2LqDbipzFSHkUG1zLw==
X-Received: by 2002:a17:906:901:b0:7ae:23c:3cb4 with SMTP id i1-20020a170906090100b007ae023c3cb4mr14484812ejd.599.1669939639860;
        Thu, 01 Dec 2022 16:07:19 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ex19-20020a170907955300b007be4d8a50d8sm2351576ejc.70.2022.12.01.16.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Dec 2022 16:07:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/8] auto-crlf tests: check "git checkout" exit code
Date:   Fri,  2 Dec 2022 01:06:28 +0100
Message-Id: <patch-v2-2.8-345a667d5bb-20221202T000227Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc1.980.g92d3d4579ad
In-Reply-To: <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com> <cover-v2-0.8-00000000000-20221202T000227Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't hide the exit code from the "git checkout" we run to checkout
our attributes file.

This fixes cases where we'd have e.g. missed memory leaks under
SANITIZE=leak, this code doesn't leak (the relevant "git checkout"
leak has been fixed), but in a past version of git we'd continue past
this failure under SANITIZE=leak when these invocations had errored
out, even under "--immediate".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0027-auto-crlf.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index a94ac1eae37..574344a99db 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -294,11 +294,17 @@ checkout_files () {
 	pfx=eol_${ceol}_crlf_${crlf}_attr_${attr}_ &&
 	for f in LF CRLF LF_mix_CR CRLF_mix_LF LF_nul
 	do
-		rm crlf_false_attr__$f.txt &&
-		if test -z "$ceol"; then
-			git checkout -- crlf_false_attr__$f.txt
+		if test -z "$ceol"
+		then
+			test_expect_success "setup $f checkout" '
+				rm crlf_false_attr__$f.txt &&
+				git checkout -- crlf_false_attr__$f.txt
+			'
 		else
-			git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
+			test_expect_success "setup $f checkout with core.eol=$ceol" '
+				rm crlf_false_attr__$f.txt &&
+				git -c core.eol=$ceol checkout -- crlf_false_attr__$f.txt
+			'
 		fi
 	done
 
-- 
2.39.0.rc1.980.g92d3d4579ad

