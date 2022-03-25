Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF634C433EF
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 19:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiCYTfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 15:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbiCYTfC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 15:35:02 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1E12816B1
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:22 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t11so12130395wrm.5
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nsc9sExLclhNTEf9ZT/PaESQoC/goj4KrZuwwBiS/Vs=;
        b=P8xZOeJkzu9dw52any6tObxJesmkD+MRtoQ/g9GV78f/IWMA1LxpZZepT19WNYjoDJ
         BOoH55QgkwGDiVKyvmzkd3sp2bDLyBAOOpK14kl2tPpXurssyR07y96EyXwuMp6cOlpk
         wZgGnBjXliFEB6mcEFxspJ5qBceN0x3bj2f/rEAk7obbDZvAihZ6APuSxB/l0MNorbDV
         0S9ZAELlOyFwgLqoWg8c5Fs38q3I6JIZABfshAXnbeIBcoCm5fWeqHN6GbQfS6JhN4ma
         MQ0FegiLPs5/dQWHbsfg/RECKRvVfyzzx3+FXsvkCij/WvptIC6GV3/Y18Tn/ifLvCUN
         hq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nsc9sExLclhNTEf9ZT/PaESQoC/goj4KrZuwwBiS/Vs=;
        b=Nrgx2QmbKzmPmwBXUptCY6WRE7YhB5muAnarA0B37vqO4MbqZFghlevT0XcfYbjASs
         wmC+u5gmZKcanI4YAnZ+J4/SZNPS97th9qymeSD8CFrbKvBSLqx4d63ZpadoW8w5cyzZ
         2V2UQwvFOsJV35TcEZK00ZW3j51ova9/XIm8PRYvKk+rgdcrYyz+yy/tJIMuN5XYdZK0
         aWKxoCSTLczl4/58+ajuBT1eoPoiHuP3CQNDl0BcnPRnjgHUVKJQ6n8OLAPyzwFRv3RG
         h71nxOcTMVt+EY7A+sioIgvUu3CtvM2s1MMs3gzbUU6ke9DO5zr1jSoxwTL7z6kvxyHI
         1h2A==
X-Gm-Message-State: AOAM531+bIqdf1bSY3xfGrLBdxFJBfs3Uc+1Pn7yk4c6Gej0DQJNNI0H
        5KV94AH7+aZA3rtl+2Nu7T4SOb3qYEBcqw==
X-Google-Smtp-Source: ABdhPJxqAvbGzK9siE6/xaA26ez17jc7Z4uc8TG/Njw/dpkQsfw9P3S3JwtEv6IDTUHE9Sjc9aKEdw==
X-Received: by 2002:adf:e18f:0:b0:204:444:dd0d with SMTP id az15-20020adfe18f000000b002040444dd0dmr10547920wrb.678.1648236260918;
        Fri, 25 Mar 2022 12:24:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c020600b0038cbb21fb00sm4999704wmi.39.2022.03.25.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 12:24:20 -0700 (PDT)
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
Subject: [RFC PATCH v3 3/6] test(junit): avoid line feeds in XML attributes
Date:   Fri, 25 Mar 2022 20:24:12 +0100
Message-Id: <RFC-patch-v3-3.6-fc96e5b7296-20220325T183946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1517.g20a06c426a7
In-Reply-To: <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
References: <cover-v2-00.25-00000000000-20220325T182534Z-avarab@gmail.com> <RFC-cover-v3-0.6-00000000000-20220325T183946Z-avarab@gmail.com>
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
2.35.1.1517.g20a06c426a7

