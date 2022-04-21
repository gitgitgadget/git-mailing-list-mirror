Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38B2C433FE
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:37:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391447AbiDUSjv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391427AbiDUSjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:36 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5543740E4D
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:46 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3998362wmn.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yK9uyew9qG3uufy2qn6f0fd2yyugrvqcWJa91wwmldw=;
        b=EegFYy2NuOEjHZhKr3E3vkyv+L1j/ZK5ubowBa2U1c0Vzi8YNEMplQvDsUsycR578G
         4kSbKryiiQisx+Hd4/P0W5kCHkOqwOjfdeF4YpmabSVfzGzt8FxYC5brN2cm3lS4Gpqa
         2SWHgqr5NfWQhO3dIJpVyZGFTSRAKPCDcoDkPWayK10nfiJZXZwQxDF458s75ei9FX9I
         uGZQ2mjNLC/drXiOxuvVEeprkINv4hlbToifZjFhTnRNtpf1JcX3smTdzD/Ttj2Oxq80
         Z1tiyyciL3rsT7jT7xGz/ave+lEcuWz2ZaPcb9IOrQY48MjBMCz5PZqs/eJ+AfT863lQ
         04lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yK9uyew9qG3uufy2qn6f0fd2yyugrvqcWJa91wwmldw=;
        b=fWMn0VCeIE1XegYIH2AdOzi947MCWWL8lEoY4rWqzBEEbRqVNsgnti+MrFdql1ECdm
         nlWjs3pyJ+UjA7I9giZDMjt50cj3N3I1oxpWbeDxbL8kq2qL5DkCinVrNakal0F/kgG3
         oC1RYSVw+bq/Qjg5RQF4rYN9r/NP9C1GXKH3+FkZic0RazkWtA8OBsHFB/L/pJDZ2r6h
         tZPCRLdYZ0zKS2cK67xNi8l9gORqrCf9LFl91NUFNpMtQyC/A6rZwD433ZVPfCOTBLnT
         ccxzfDVpTznCe1FK3GKcxKfxYFiWS15MX9XGkSRVX6znKR+SHKBGskWLu+gPKbYYE5+w
         XeIA==
X-Gm-Message-State: AOAM531dvGldiwCfDJE752f6DexuWq8kvPRn5jMc/z5VCHFyPmRdljMu
        yEnuHQrY1j8ZfRDgHXvSFWmvWlz+PRfhcw==
X-Google-Smtp-Source: ABdhPJzT50L2FoTidAadu2Tc73op8VQ3cEMh8YSMYSBkgYRctkGRj12SW8t3xTQRzbTyMb4p3HPheQ==
X-Received: by 2002:a05:600c:4313:b0:38e:b150:2f8e with SMTP id p19-20020a05600c431300b0038eb1502f8emr9823351wme.198.1650566204720;
        Thu, 21 Apr 2022 11:36:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:44 -0700 (PDT)
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
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH v5 07/10] test(junit): avoid line feeds in XML attributes
Date:   Thu, 21 Apr 2022 20:36:31 +0200
Message-Id: <RFC-patch-v5-07.10-2d233bbdc22-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In the test case's output, we do want newline characters, but in the XML
attributes we do not want them.

However, the `xml_attr_encode` function always adds a Line Feed at the
end (which are then encoded as `&#x0a;`, even for XML attributes.

This seems not to faze Azure Pipelines' XML parser, but it still is
incorrect, so let's fix it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-junit.sh | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/t/test-lib-junit.sh b/t/test-lib-junit.sh
index 9d55d74d764..c959183c7e2 100644
--- a/t/test-lib-junit.sh
+++ b/t/test-lib-junit.sh
@@ -50,7 +50,7 @@ finalize_test_case_output () {
 		;;
 	failure)
 		junit_insert="<failure message=\"not ok $test_count -"
-		junit_insert="$junit_insert $(xml_attr_encode "$1")\">"
+		junit_insert="$junit_insert $(xml_attr_encode --no-lf "$1")\">"
 		junit_insert="$junit_insert $(xml_attr_encode \
 			"$(if test -n "$GIT_TEST_TEE_OUTPUT_FILE"
 			   then
@@ -74,12 +74,12 @@ finalize_test_case_output () {
 		set "$* (known breakage)"
 		;;
 	skip)
-		message="$(xml_attr_encode "$skipped_reason")"
+		message="$(xml_attr_encode --no-lf "$skipped_reason")"
 		set "$1" "      <skipped message=\"$message\" />"
 		;;
 	esac
 
-	junit_attrs="name=\"$(xml_attr_encode "$this_test.$test_count $1")\""
+	junit_attrs="name=\"$(xml_attr_encode --no-lf "$this_test.$test_count $1")\""
 	shift
 	junit_attrs="$junit_attrs classname=\"$this_test\""
 	junit_attrs="$junit_attrs time=\"$(test-tool \
@@ -122,5 +122,11 @@ write_junit_xml () {
 }
 
 xml_attr_encode () {
-	printf '%s\n' "$@" | test-tool xml-encode
+	if test "x$1" = "x--no-lf"
+	then
+		shift
+		printf '%s' "$*" | test-tool xml-encode
+	else
+		printf '%s\n' "$@" | test-tool xml-encode
+	fi
 }
-- 
2.36.0.879.g3659959fcca

