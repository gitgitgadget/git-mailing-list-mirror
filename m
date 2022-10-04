Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8686BC433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbiJDNVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230226AbiJDNV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:21:28 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E50744DB67
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:21:26 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id y23-20020a1c4b17000000b003bd336914f9so789956wma.4
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg8JebrxPZPNrRBMxrHFES6tuYHIB+M235xOxhJkpEI=;
        b=hHVlGgscuqayacRSpoGUuDXC2dLNQTkvAB2xuqPneNd/DXEPRP40MgE4NoczfWMqh4
         SL6LYvFZ/aRfWJLlirMz9m2YAIMi+gxowbgpz8B3Tw1SBje4k1SYCm2td5PGIHwXcZtI
         dttpuO288GAeq9/i27HPiZCtC+s6u2vvMQhf4ZMvCVD1+Fhi9FUL8nOZXIq1oL37Ps2h
         kfCbnIzgL1UbiCYbTufQRIZ/04u1W1GhfBb63/T/YCocaTdNHrIxfK4uNUUlGONqaG7+
         W5bB/lrYZoba5PDNsxt/joDToLhWRwMPrt1p9Bq18h+N5ZtDLjALoUE7LXkYjVGgHy4X
         G4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg8JebrxPZPNrRBMxrHFES6tuYHIB+M235xOxhJkpEI=;
        b=rB89984YiHE9SYh3EVlvBHTJZbS5IwCe+fgmZOpZNoAMYM9NMwuQbymA3fZnXZK4bY
         rB2V5zg12d9S7RCI4Sg8fX0AdKhV5L3yNd4LjXCEbLBuyDv8orpXnmbMifr615FW0IGU
         fUiCb6IPV/HLLraB2DwziTL0yKLNGnymrCSpDCRSbJrVjCVXFPjLvpfWZTd3ivT/sEJm
         +xT+IRUlSqn/PrUXH3Q87X2TeO6S6J6VLveFy58G0xjwu2WKOhPuVaQbd8vmam+eoSDj
         7xgmtTJEP4x1oNVnoOI3Ic4AYnWUKIVwvmBRdcSMaHruhuodion4O0nNDGFF0Nh/cLc6
         lePw==
X-Gm-Message-State: ACrzQf27TZyvZ0K8lp3YhEt2AoiaSmg2Xv7fvWL47OZYkaxwwNka0RbG
        zbvWM4d593zK6sTnaPXn438YxpuWkFMZhQ==
X-Google-Smtp-Source: AMsMyM7kAsXWm7tUuCEIXlQTRJU+2sPV0xSpGW1T1rdCcEr4xEz3nbN5nDLUSqu/SSRQKcAG7CtyMg==
X-Received: by 2002:a7b:c84c:0:b0:3b3:3faa:10c3 with SMTP id c12-20020a7bc84c000000b003b33faa10c3mr10198565wml.94.1664889685033;
        Tue, 04 Oct 2022 06:21:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7-20020adfdb47000000b00228cbac7a25sm12429205wrj.64.2022.10.04.06.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:21:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/34] tests: assert *.txt SYNOPSIS and -h output
Date:   Tue,  4 Oct 2022 15:20:46 +0200
Message-Id: <patch-v3-01.34-f76804fe9ae-20221004T131009Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test to assert basic compliance with the CodingGuidelines in the
SYNOPSIS and builtin -h output. For now we only assert that the "-h"
output doesn't have "\t" characters, as a very basic syntax check.

Subsequent commits will expand on the checks here as various issues
are fixed, but let's first add the test scaffolding.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0450-txt-doc-vs-help.sh | 44 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)
 create mode 100755 t/t0450-txt-doc-vs-help.sh

diff --git a/t/t0450-txt-doc-vs-help.sh b/t/t0450-txt-doc-vs-help.sh
new file mode 100755
index 00000000000..c8820bdd38f
--- /dev/null
+++ b/t/t0450-txt-doc-vs-help.sh
@@ -0,0 +1,44 @@
+#!/bin/sh
+
+test_description='assert (unbuilt) Documentation/*.txt and -h output'
+
+TEST_PASSES_SANITIZE_LEAK=true
+. ./test-lib.sh
+
+test_expect_success 'setup: list of builtins' '
+	git --list-cmds=builtins >builtins
+'
+
+help_to_synopsis () {
+	builtin="$1" &&
+	out_dir="out/$builtin" &&
+	out="$out_dir/help.synopsis" &&
+	if test -f "$out"
+	then
+		echo "$out" &&
+		return 0
+	fi &&
+	mkdir -p "$out_dir" &&
+	test_expect_code 129 git $builtin -h >"$out.raw" 2>&1 &&
+	sed -n \
+		-e '1,/^$/ {
+			/^$/d;
+			s/^usage: //;
+			s/^ *or: //;
+			p;
+		}' <"$out.raw" >"$out" &&
+	echo "$out"
+}
+
+HT="	"
+
+while read builtin
+do
+	# -h output assertions
+	test_expect_success "$builtin -h output has no \t" '
+		h2s="$(help_to_synopsis "$builtin")" &&
+		! grep "$HT" "$h2s"
+	'
+done <builtins
+
+test_done
-- 
2.38.0.rc2.935.g6b421ae1592

