Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F21B3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391424AbiDUSjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391404AbiDUSjb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:31 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4D37A95
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3998222wmn.1
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eBZ0gns+yMZj+MFoorlPBtWgymE4bmRlinap/Si4gaI=;
        b=ZKqOsq5HZDOkyvwDAGnzCTnpSW70ubkuHrACFIQM0j1uQvMzdlYker0TcE7GLqplU8
         vDr/PedoK5abNnEMKYBwHHJ+PO3uLZPmuFyRFqJKMIlGlUXgaQdYxLt1pWL+4T7eXG4k
         s8NCghi86iAbpS3299jOMq86lt5myVCXRk53UDFIksPqrSjmlZXihsRI5TtM2/N0+wtW
         XAtFPgiyrPmeB6Uf6+QkDEikSbgaP5Ip9EeikaqvapviHfKTkE3MoLDUmcexFFqJHsUB
         VvCxriDLP/g1Oicmyu3BD0v6uJINO+cySvNs7mOPU4rCMHhnaEGgn4KKYx3P+qvV3gea
         kg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eBZ0gns+yMZj+MFoorlPBtWgymE4bmRlinap/Si4gaI=;
        b=LRBH13WFvZRfMQKcoPJMOcaMsQOmabd+JmZahYnRSwNZrb9zHnLmKxmbJpp532O+DB
         HBJdJUxXpEtL8cW/vR1n34ETP2Zr7S8O/RN3nz42uzm4ycuxz4Bxlh0edfktMsJ9ymew
         ffUo3tswAZuXsTIzrf8n2UxkQToGzUBcO6h9xbviPOgT3rCXf84b0S3mlK9Uxu6CWaAM
         t8U8gf4gRVXzUAM9smhEHe22zXRQGXdaWOhMGhs9GbweKNOjTm6rU2a0naFGZzkSv19s
         s2eu1QURS8YVGj1KHv6Ad+xY4yUOJUAyYVwqOq0tEbgBwrc+MXBqd5LhO3QRirKX5WiO
         lo1A==
X-Gm-Message-State: AOAM531Swwat4BkxFQg1QFLYKnLqWez3LQgve1HsGNIOIEQyoSWrb7VO
        aez+CXsNTrJP8cY3Nn7CqgoaROOJJiYL0g==
X-Google-Smtp-Source: ABdhPJw4zXHEfovoGqGyYt95Xk9mnLGSw5kKI0rtRikaDVJhgpwKi6/4QzNL8R0XFhPpB2HEPfG6QA==
X-Received: by 2002:a05:600c:154b:b0:38f:f7f4:8139 with SMTP id f11-20020a05600c154b00b0038ff7f48139mr653097wmg.60.1650566198890;
        Thu, 21 Apr 2022 11:36:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:38 -0700 (PDT)
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
Subject: [RFC PATCH v5 01/10] CI: don't "cd" in ci/print-test-failures.sh
Date:   Thu, 21 Apr 2022 20:36:25 +0200
Message-Id: <RFC-patch-v5-01.10-56910df26e7-20220421T183001Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.879.g3659959fcca
In-Reply-To: <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
References: <RFC-cover-v4-0.6-00000000000-20220413T195514Z-avarab@gmail.com> <RFC-cover-v5-00.10-00000000000-20220421T183001Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the logic in ci/print-test-failures.sh so that we don't need to
"cd" at the top-level, we'll now only do so for the "tar" command.

This way we can remove some duplicate code added in
aea8879a6ac (travis-ci: include the trash directories of failed tests
in the trace log, 2018-08-01), i.e. not have both a $TEST_NAME and
$test_name. The output is exactly the same as before,
i.e. "test-results/" was included in the heading.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ci/print-test-failures.sh | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index ec395c79ccd..f6736f424e0 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -8,33 +8,36 @@ set -e
 . ${0%/*}/lib-ci-type.sh
 . ${0%/*}/lib-tput.sh
 
-cd t/
-
-if ! ls test-results/*.exit >/dev/null 2>/dev/null
+if ! ls t/test-results/*.exit >/dev/null 2>/dev/null
 then
 	echo "Build job failed before the tests could have been run"
 	exit
 fi
 
-for TEST_EXIT in test-results/*.exit
+for TEST_EXIT in t/test-results/*.exit
 do
 	if [ "$(cat "$TEST_EXIT")" != "0" ]
 	then
-		TEST_OUT="${TEST_EXIT%exit}out"
+		TEST_NAME="${TEST_EXIT%.exit}"
+		TEST_NAME="${TEST_NAME##*/}"
+		TEST_OUT="${TEST_NAME}.out"
+		TEST_MARKUP="${TEST_NAME}.markup"
+
 		echo "------------------------------------------------------------------------"
-		echo "$(tput setaf 1)${TEST_OUT}...$(tput sgr0)"
+		echo "$(tput setaf 1)test-results/${TEST_OUT}...$(tput sgr0)"
 		echo "------------------------------------------------------------------------"
-		cat "${TEST_OUT}"
+		cat "t/test-results/${TEST_OUT}"
 
-		test_name="${TEST_EXIT%.exit}"
-		test_name="${test_name##*/}"
-		trash_dir="trash directory.$test_name"
+		trash_dir="trash directory.$TEST_NAME"
 		case "$CI_TYPE" in
 		github-actions)
-			mkdir -p failed-test-artifacts
+			mkdir -p t/failed-test-artifacts
 			echo "FAILED_TEST_ARTIFACTS=t/failed-test-artifacts" >>$GITHUB_ENV
-			cp "${TEST_EXIT%.exit}.out" failed-test-artifacts/
-			tar czf failed-test-artifacts/"$test_name".trash.tar.gz "$trash_dir"
+			cp "t/test-results/${TEST_OUT}" t/failed-test-artifacts/
+			(
+				cd t &&
+				tar czf failed-test-artifacts/"$TEST_NAME".trash.tar.gz "$trash_dir"
+			)
 			;;
 		esac
 	fi
-- 
2.36.0.879.g3659959fcca

