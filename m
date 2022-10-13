Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6723C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiJMPjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiJMPjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:39:41 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C34AC18
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:36 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id n12so3425488wrp.10
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F1a4n8BpN7tpva6YcgIEQNdvSBgZkk/ljk6YPXopjv0=;
        b=WT4xDVStZPY13aFeYhV//o894uYMIe1EDCoxCNdsZUsrLOfwcWJ9TFgAvaZCNypyw4
         CUuTJ6olPcxNYq/Am1pCq3rlPFYyGkSdKou7WaQjY9y1Bx209kehCE/0A0g8qlEuUMtg
         q1lw9nQavMONv7Y9TDQjhxw1J3pghAp5zjWE2vq6AJFRsBexV5knPMBXB0tzbU58Be3N
         hVaoyuKXjYkm76jWG+9GSCDEf/PsP7VRP4AgCo/8AXgFj5idU9irAqRI3AvVg/33ZZYc
         VEZOMOGeZ2wrRCnOP7/hDoWr+vGWJDQ+Z4ID2RE8Q5QchrQzKtEKdcDugX14occ+Jpct
         0SrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F1a4n8BpN7tpva6YcgIEQNdvSBgZkk/ljk6YPXopjv0=;
        b=Q3qUKaBP6LzUsKYbLKH77fSBe1jOIU3wNosYb8iHUJHcNT/XZ2WBtRnssqC0WAjsbP
         9VG1NORpthfD8eYbukLMgqB3sMkleJj1fJRs/VXsz5kceMqxHzuBeYlf+ED9+PTdaxGf
         2QfU8St/jIDeLCvQhLkOwaGvFwksm4LSLA1/JISqXH9DdVx/KEbf5RNda/r3v4qwCocK
         wU/Fqnje1uSQY0CJeEXpKrhh9mwKhD22oQMqsN2f6zX5ZMKUsqRf6T+/Ff56LX9gpE3N
         e6WbXtPojuKwAxmvXiGXVioOKDu5Ovs0x4MLm7macFsYv1bvyEnMqnxyOFA5S3vH3c5q
         +8pw==
X-Gm-Message-State: ACrzQf27ZynD1EvrZfd/S0f/VEEjKEGSSpEhLErUZimxu3NbAogQaVWj
        /IqF3Pz0fffhHPOK4RVte6OfNPvTTSkjsw==
X-Google-Smtp-Source: AMsMyM5Yl2Rx5s9ECij15asv6jibQ0CKXNdD2ayi+Yq6nL4nWWVDDFlL9y7YS7hO1I3/88qV68SnHg==
X-Received: by 2002:a05:6000:258:b0:22e:6684:47fb with SMTP id m24-20020a056000025800b0022e668447fbmr373395wrz.429.1665675574773;
        Thu, 13 Oct 2022 08:39:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:33 -0700 (PDT)
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
Subject: [PATCH v5 01/34] tests: assert *.txt SYNOPSIS and -h output
Date:   Thu, 13 Oct 2022 17:38:55 +0200
Message-Id: <patch-v5-01.34-cb0e2ffcd2c-20221013T153625Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

