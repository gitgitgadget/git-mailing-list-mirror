Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E052C433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 19:57:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238576AbiDMUAH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiDMT75 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 15:59:57 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07D0275C30
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:35 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id m33-20020a05600c3b2100b0038ec0218103so1838236wms.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 12:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hbV/EY1fb1Ijz1w4r0BkhZPC/Tz2p9XL4Tj/eOFNC58=;
        b=iRn08thOomUXPuGvfVVMUEpMt3OUhJ17aCrO+ofFJtYBgGyeMoaXKn+AiuuwFEVcKi
         pkJQKV8u3VV/tb3jHhwVEMIIy/OnERAuDDz5iIIdeDY9fon2N1F8+/nR7DkcarsHTy3Z
         Nu39fNwjIVVPT+1qvuAMpFVelSueOz9F2MYM6kHy4wTWRGqozYC/3jzjYplwkraxbZTO
         5202icrXy2kelfHKr3O4HZCFwjeFPgFXxhSIKPyLU7Z5/bI6BQsTYAVv9MNuvd9T2kkv
         0pXLXw1Gb+fNv7U5IF6O1H5tqRbiESUvLv3PZWjHrYdPqyiRLnIiUNKBJAFx6Cs/FfoG
         V6+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hbV/EY1fb1Ijz1w4r0BkhZPC/Tz2p9XL4Tj/eOFNC58=;
        b=sXQR6H1tqDyI2MIt6hTgJAIlGcJPdPuwaEKeWu74j3I56O4Ods1dMXxrCAvaOJGwos
         wpAYRXaPLmiGFFK6B+35/KdG40ArzoHnKovZHm9uVnwiMWq62GjqH0UIU1DnpQ8ShCZ6
         kDD5vzHSfK/T0LDM04/0bHZUMsHhbhny8mz57ZE1IFMwGBOCBb0YpH7ahWDSknHLc05X
         bk56pWoa8bglP3xW8BJmuG/CxtrWrBEscNLVFwU6vF+xYAmrfiX3s/xAPF+asxNZwuQz
         oUDGBt/zRVU2b0r8J19H6Sx4138SehgRaJxSMBm/GAKr0cijnhbaTHYEVgsE61Hd9Eg8
         d3lA==
X-Gm-Message-State: AOAM531WEoC+qvhwI/gc5fSA2gkFs2A/xVxeHrv/ILNtp8K0DeyMPxOm
        Xv/HGOYhszJ1juu659iW+7RR1PPfq2IkIg==
X-Google-Smtp-Source: ABdhPJxR8/Vcxu0+4VYTKB35QIxLSZODCKAy1k0TWRpS/Rd/+8xH9J3R/fI3HLEwA/rK43FxitfD3Q==
X-Received: by 2002:a05:600c:4f10:b0:38c:ae36:d305 with SMTP id l16-20020a05600c4f1000b0038cae36d305mr316220wmq.34.1649879853348;
        Wed, 13 Apr 2022 12:57:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j16-20020a05600c191000b0038ca3500494sm4547802wmq.27.2022.04.13.12.57.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 12:57:32 -0700 (PDT)
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
Subject: [RFC PATCH v4 3/6] test(junit): avoid line feeds in XML attributes
Date:   Wed, 13 Apr 2022 21:57:25 +0200
Message-Id: <RFC-patch-v4-3.6-84c722969d5-20220413T195514Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
References: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com> <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com>
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
2.36.0.rc2.843.g193535c2aa7

