Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645D2C433FE
	for <git@archiver.kernel.org>; Tue,  4 Oct 2022 13:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230060AbiJDNX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Oct 2022 09:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiJDNX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2022 09:23:56 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EE72CE33
        for <git@vger.kernel.org>; Tue,  4 Oct 2022 06:23:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id f11so18658235wrm.6
        for <git@vger.kernel.org>; Tue, 04 Oct 2022 06:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eg8JebrxPZPNrRBMxrHFES6tuYHIB+M235xOxhJkpEI=;
        b=B4OkeJyjx024Xb/GADOJ3b4m1p/OoODH+CkQG6+foJdRPVSWFmr1yww1+t7vV8712g
         QWHzZXW3c4rvJYO85czsrYidpwRmq/NY46DU10FhQYBAcowz0E5syW1wk+r/XZw7QkYy
         P3Qw8SQ/IRm1acxTHj5HMIN65frZzmvRDP20gEZD3DaWcz8l11aeo066o0YDCztPaA9n
         qeKpTydU0J6eM2R7LLqPfxrZCmxfkrLSKSSNRVy/0+ZxW6NuauWI474aRvPt35pH0Xuv
         lrZ3YIqVbeH9QEfLor//8mo3luhY6WYwuuaqwHJE9MwdHvW4cxIeE6gJTMniT64wLIMk
         nupg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eg8JebrxPZPNrRBMxrHFES6tuYHIB+M235xOxhJkpEI=;
        b=iBCsKZnNDhBsvyFmIeuBqG+nCrGdjlVtTXQZnFWjfrkTuvPI4oT16efPz85UU9KXpp
         5aD76b/5rPk8vUhdSek3kFcY7d5cyPInKYmS1F3Ut21inGPWb1zGWqhHQjW6cpTOSy7O
         lR4alsshmI2KsSAMRyxVpZekrYaP4a+VbWhcDZCRXXGZAxWLIdYtz/W0W6T6n5K3VrJO
         JeH4UdeKhResGiX7A/teWy96yr25PdMFBw75ZsUa6U4qCIWZnmwL45+1z6+6rnZLpWDc
         azQdbh5YI3mSxG1cwUzIm7WK39KXPxOj2jZItyF9efJGs9HnPcXo+Faj8JXGzXg3uDF3
         o8Dg==
X-Gm-Message-State: ACrzQf0uMhuqdnWMzftSdnGQop0zBx8csEsBiNT0FlDg7bf8Rn3h8vTi
        se9x/TA+7JhOmPwA0Pu5/j1LeLLIYuL36A==
X-Google-Smtp-Source: AMsMyM7mJ0lYb4AjwjwHT7RD52r6z7hLu/U2P3el98QOlbyLqfyBJaTrPE2YhC1ghDsvuVUwOZ6Mvg==
X-Received: by 2002:a05:6000:98b:b0:22c:c3b1:3f2a with SMTP id by11-20020a056000098b00b0022cc3b13f2amr16718641wrb.11.1664889832403;
        Tue, 04 Oct 2022 06:23:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t187-20020a1c46c4000000b003b4a699ce8esm19666022wma.6.2022.10.04.06.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 06:23:51 -0700 (PDT)
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
Subject: [PATCH v4 01/34] tests: assert *.txt SYNOPSIS and -h output
Date:   Tue,  4 Oct 2022 15:23:15 +0200
Message-Id: <patch-v4-01.34-f76804fe9ae-20221004T132211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
References: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com> <cover-v4-00.34-00000000000-20221004T132211Z-avarab@gmail.com>
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

