Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ABCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391421AbiDUSje (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391408AbiDUSjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:31 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC3B3818D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:41 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v12so1081568wrv.10
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j9Vq0HkJ2RRvZSQV89fC6AYlCIJhMdzcRGujQSX+4J0=;
        b=AtagkKebqdCdpTBQRyakrRgm9C4+Wag43OUM3HHuOF68axzqHcncPWC7ddY1ymd4Iv
         YgRC8vGsWJ+I4Z8aodWO6wO/+vdm77V97UGNO+Tj7RZfxxWs4e5oVmJvq2FklbvadsaK
         vRuqcXEUmzosIzlshALOFk7v3HF5jISythyM5xo1P5HWSIdW3zwk4iA/zlg6cAX/9FK0
         cr0LFUeiAlGr6JfMhydS7v13zMsvNEMqjRgU6mYdezhaEcT87deHmuf9MkcqbbRO1n/A
         LLUQP/BZmNcZwze3hi584YMCrk58KW1i02zSOEOFRrIbduag0+WCAKPTK+1I8r5+WuM4
         l6sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j9Vq0HkJ2RRvZSQV89fC6AYlCIJhMdzcRGujQSX+4J0=;
        b=I2sP5bhnKsActe4dBvdWJQ4k15ai5RtIavV8T7MZ6cVAKYUh+J5FEVPfwGN2e/w6JU
         8J25cbJuiOA8yjO+5YOQwIcZRfBkS7aihBdvKYFKsepGBOJz/jp3llSpKHqJcrYqpxXc
         aNjWYqicilYn4mi/z0xjcZk3Kz5lcNbjZYhEZsW5gSZ0dzuZNwWrL+Pzct/oBoIliVrY
         LWHZhFH64zIlTmfwrNbmmjdTIaMum34g9zg2sSmPxLYZV5oEMcqZIbwQbCrVvHnHPeYs
         hja6Oo1m0mqESSdkOLvA+caPOg3vu6AwTM3ZI6+XN6yqhVT6HBUT3Uvx4303/XGN2YE8
         O52A==
X-Gm-Message-State: AOAM530AGk5a0H9mTivy673GoQNHyI5871vIxwlmVt3o7RvnnK/w3ZKL
        qtHWL0IZRTyVVtKAOeTH/GWpHFeDouJ9rw==
X-Google-Smtp-Source: ABdhPJwdJjAgxZD+//2GGKiKE7sepDzoCbGFf82mgSh6FDxkdHGrdvx/x0cdSQO2k2gkVIDJAbmW6g==
X-Received: by 2002:adf:f088:0:b0:20a:8709:d381 with SMTP id n8-20020adff088000000b0020a8709d381mr746464wro.303.1650566199769;
        Thu, 21 Apr 2022 11:36:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:39 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Victoria Dye <vdye@github.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Lars Schneider <larsxschneider@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 02/10] CI: add --exit-code to ci/print-test-failures.sh
Date:   Thu, 21 Apr 2022 20:36:26 +0200
Message-Id: <RFC-patch-v5-02.10-caec0b1089a-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The ci/print-test-failures.sh scripts will exit 0 when there's failed
tests, let's teach it --exit-code to have it exit non-zero in those
cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index f6736f424e0..d00cd0e4944 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,16 +8,33 @@ set -e
 . ${0%/*}/lib-ci-type.sh
 . ${0%/*}/lib-tput.sh
 
+exit_code=
+while test $# != 0
+do
+	case "$1" in
+	--exit-code)
+		exit_code=t
+		;;
+	*)
+		echo "BUG: invalid $0 argument: $1" >&2
+		exit 1
+		;;
+	esac
+	shift
+done
+
 if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
 then
 	echo "Build job failed before the tests could have been run"
 	exit
 fi
 
+failed=
 for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
 	then
+		failed=t
 		TEST_NAME="${TEST_EXIT%.exit}"
 		TEST_NAME="${TEST_NAME##*/}"
 		TEST_OUT="${TEST_NAME}.out"
@@ -42,3 +59,11 @@ do
 		esac
 	fi
 done
+
+if test -n "$failed"
+then
+	if test -n "$exit_code"
+	then
+		exit 1
+	fi
+fi
-- 
2.36.0.879.g3659959fcca

