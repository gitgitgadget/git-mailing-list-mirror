Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1899EC433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 18:37:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391460AbiDUSj7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 14:39:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391437AbiDUSjp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 14:39:45 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5777C49FA2
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:49 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id h25so1844346wrc.13
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 11:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn4hoAfLj/yO+HuwQfxv1/woJptufJxbJaCjAaCCeHk=;
        b=TPJwTnhHnIV8y5GTgdRtTd//sCPSbkZVOZTktpYbYANgLiip3HHbybmA2NS9SP12Fe
         EhdoDSNZpwJtIdllNayf8j660lis5QEBVaLJUahmcA+DUkDbktx2e2vjR42ipLhXUxTf
         xBXug2p1bSHp1KAxMov4as6rb9fGYXgIbcxOfRZdX9AkJ6qGCvNmI+yYD5HP5AC2UWhk
         QViecXEugEkQFixiX8M8Ack54y8rPNrIzIqWSwj6HbcAWhXdh1jsWeaXXRb0oXZ6tpdc
         daxF+liJWgv/WbC89q+b6EMwyL/SzXCfJ5O7IzWufbuMyK0odRGefDq0JMtE0JK69vEq
         KNug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn4hoAfLj/yO+HuwQfxv1/woJptufJxbJaCjAaCCeHk=;
        b=Oz8sPTm+gOLAg4/Maceu2yu4tIDLXDKTZ6v9vw3DgDgs4dYyLqev6hB8cET8hV/hn3
         oeFGbY36qNBAi9LywhV1YtEUL/4ggwFJrt44hL0MQD8lFFaCYWkRoXYjhQFlGFf3/CVJ
         xstEEeqqwGg/bcsYL/Xk3jENzR/3NA+0voTeDjw0v2VUrD3Xuiap8ZLS1H/RPufe6zLA
         k1nz+OYxGW20wtEbFFREHDsdpgkQNjCttuYGm0RACiMPg9/zdluiDM0lRH2BExOacrKS
         yxGVmBnYN7cEDTYetJLQ6MhVdPs6YSEcmFVj3Cacqqe5GE7o8V7B53qe90HkzUiOgESj
         Rn/w==
X-Gm-Message-State: AOAM530OaTQvH1irL8r1k7KAtqMRNDecmCos9yRJfaCWXuvXWd8Lne1T
        +wHTclqNN5MRCampFoBUxnmDRYJVJo9UnQ==
X-Google-Smtp-Source: ABdhPJwmrZHTB2OVefbfowg6w5ZgSc21+/dBt7moqZjlAZWs1JnpYOHisViJp64ukRF6FSX8O35ehA==
X-Received: by 2002:a05:6000:18ac:b0:20a:a30e:f9f0 with SMTP id b12-20020a05600018ac00b0020aa30ef9f0mr738885wri.289.1650566207649;
        Thu, 21 Apr 2022 11:36:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o40-20020a05600c512800b0038ebf2858cbsm3108624wms.16.2022.04.21.11.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 11:36:47 -0700 (PDT)
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
Subject: [RFC PATCH v5 10/10] ci: call `finalize_test_case_output` a little later
Date:   Thu, 21 Apr 2022 20:36:34 +0200
Message-Id: <RFC-patch-v5-10.10-6b278194f9a-20220421T183001Z-avarab@gmail.com>
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

We used to call that function already before printing the final verdict.
However, now that we added grouping to the GitHub workflow output, we
will want to include even that part in the collapsible group for that
test case.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 8a63b4b64c9..1ceba46215f 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -782,13 +782,13 @@ trap '{ code=$?; set +x; } 2>/dev/null; exit $code' INT TERM HUP
 # the test_expect_* functions instead.
 
 test_ok_ () {
-	finalize_test_case_output ok "$@"
 	test_success=$(($test_success + 1))
 	say_color "" "ok $test_count - $@"
+	finalize_test_case_output ok "$@"
 }
 
 test_failure_ () {
-	finalize_test_case_output failure "$@"
+	failure_label=$1
 	test_failure=$(($test_failure + 1))
 	say_color error "not ok $test_count - $1"
 	shift
@@ -798,18 +798,19 @@ test_failure_ () {
 		say_color error "1..$test_count"
 		_error_exit
 	fi
+	finalize_test_case_output failure "$failure_label" "$@"
 }
 
 test_known_broken_ok_ () {
-	finalize_test_case_output fixed "$@"
 	test_fixed=$(($test_fixed+1))
 	say_color error "ok $test_count - $@ # TODO known breakage vanished"
+	finalize_test_case_output fixed "$@"
 }
 
 test_known_broken_failure_ () {
-	finalize_test_case_output broken "$@"
 	test_broken=$(($test_broken+1))
 	say_color warn "not ok $test_count - $@ # TODO known breakage"
+	finalize_test_case_output broken "$@"
 }
 
 test_debug () {
@@ -1135,10 +1136,10 @@ test_skip () {
 
 	case "$to_skip" in
 	t)
-		finalize_test_case_output skip "$@"
 
 		say_color skip "ok $test_count # skip $1 ($skipped_reason)"
 		: true
+		finalize_test_case_output skip "$@"
 		;;
 	*)
 		false
-- 
2.36.0.879.g3659959fcca

