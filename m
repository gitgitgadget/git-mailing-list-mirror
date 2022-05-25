Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E710C433EF
	for <git@archiver.kernel.org>; Wed, 25 May 2022 11:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242360AbiEYL0k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 May 2022 07:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbiEYL01 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 May 2022 07:26:27 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 772219CCAC
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:26 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id j25so5256941wrb.6
        for <git@vger.kernel.org>; Wed, 25 May 2022 04:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9I4SldCNl3+bo1kofQPG37j+uYanyoYofvpytaTOI4U=;
        b=b0rn2N4kte0HkAxKhlAAfXClrqit7JYwCiFoplIKjI3JoD7amCvA2izxkj/WeaYmEL
         e8LpGd5+iY/wp45q58CoyJgEcym34G+3BmIY5QO+o0RBFmC/gLWR+c3k+s+JiftNGjkr
         ZvhLYeuzbkPUWu5dyaTS1Dwdah4ILuBLjDgNK3tYhIXFXwu/KVwGcnStZZ1Y5xejAeRH
         B2VbYssK4LjleDurchDznnV452VTLsceMhUJBUXVLWRwq8jEWlNJGd0+NIFVt7HG4B3I
         CkDq+uOTv5uTbHz+GL0jtuyH6hXQOm6FGOTTjR3ujMS7255//peMteFNA+9T7j5w0Bi0
         fM5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9I4SldCNl3+bo1kofQPG37j+uYanyoYofvpytaTOI4U=;
        b=THX1Uicosmk5BnJv3BryAh3NjYFYiKgxEnheIUY50BveLUZrKc3R3FqTPz5oBeWWqQ
         90MW6092FqEUcujHw9FargH/XTbZ9u7+m45EN7S5Bn3ytYtawJH8DFul4f1r6V+b7dcW
         GV6Ldnxae4jSJ8XbnhHgVhO97u4e4ccIIAe0AvAOCY9J2uk7ktqEcKa1tk8lmXAoGBYf
         /71jSJlFgOzb+iwDJWReOsY4iSAN2ylXxRSkIM2hXK6zldzxWAEjLD9ztq9F4dqSNt33
         BQnHuQhxI9aG/G2ATF8CIqYVzSufrL2ZHTKPUt0k30gDkoLh25e8DjaCdRS8hw7jomkY
         T+qg==
X-Gm-Message-State: AOAM532LGWf0RxPB+J0DRDzvF6x+OuGgOSINV/EHzHpqapb8v0RIg18V
        Qqv5zGo3kd1/X3y0bv+ntPTlIlFI4+pIEQ==
X-Google-Smtp-Source: ABdhPJwF3Vz1Mu51Ov7vRN3/j70P7TpLKrAEF8O1tj4as98b5H33LewJgLorvbv830VaR9F1MaDWAQ==
X-Received: by 2002:adf:f4c5:0:b0:20f:c397:81d6 with SMTP id h5-20020adff4c5000000b0020fc39781d6mr18549427wrp.240.1653477984836;
        Wed, 25 May 2022 04:26:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z13-20020adfd0cd000000b0020d0dfcd10asm1851095wrh.65.2022.05.25.04.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 04:26:23 -0700 (PDT)
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/14] test(junit): avoid line feeds in XML attributes
Date:   Wed, 25 May 2022 13:25:54 +0200
Message-Id: <patch-v6-05.14-5b709dde86a-20220525T100743Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1045.gf356b5617dd
In-Reply-To: <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
References: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com> <cover-v6-00.14-00000000000-20220525T100743Z-avarab@gmail.com>
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
2.36.1.1045.gf356b5617dd

