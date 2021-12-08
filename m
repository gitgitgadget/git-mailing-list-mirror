Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD6EFC433FE
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbhLHMiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbhLHMiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:01 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCCAC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id d24so3944168wra.0
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w12Aip9Me96PywRbeocM/QqnLvMZIun7edcr0mVNjgI=;
        b=DBLjHXT1Fy/hyzgHFXltpk7/mJzqi3cg1YL53Kc7oIzj4OnJv4b1K3u+/wo1sSyjJ/
         cDFun4JFe8lFkjfDBJV67P4BrfMab2Mz1lH5NqugMBb3x+EI44jTCpIpzoFwnWwmJZ+p
         h7/WW0ONX7dw83Az2JwL1k7llAF7cjlkwBOW53XcWCbSH5qSPXnYkq943od+0833NmIQ
         uVvWDyPacctCW1PolbUsD41FfgoWh1SzXfZmSKzdxYL+2yiCa1a+9INunWWzkfctvEg4
         AAzcne9WTd8WMVJFTqH+Ds2+rt6rmbdClg9KtUEk+HvNRxJQ/0izkWN5+k+OEie4k2TL
         w1Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w12Aip9Me96PywRbeocM/QqnLvMZIun7edcr0mVNjgI=;
        b=fSxGw/AlDWGnoaBuJWvNmV4hSrsDq5JFSLZvBbwgtGLd5Btd5Lce3lM6Ght7ufysGl
         syKXQlvfq7YXvU0JTNNFGdEmp94ddOX8Fu4vg8ssEMlmrlS3m0l+2+HnbN0QkFNN1mnH
         Z4oNL3rgZ7/zAx583iTmSdckyd8+8tZAz5gNNWelmj2HEITU5/FDuBvgf0JBbjZ24Klz
         4vP62RjmcrXkEQyDxiKgcz0dd2cr+RiU+JoTsZ5rxm3Fr8u6oz68nyvxkvXefGfE+rF6
         ihYufLepmm2eB375OsE+CmBSOxa0fId+LMG99eovR5z40A3sXfm6lpDWvc87A2qZmqgi
         6JyA==
X-Gm-Message-State: AOAM533Aa4tVT5w02C6+sMeRqKXBHWlqNGRZop24COjOk0gwEiB6eXAS
        TNTJQFJtMtbQ68tGbONVPayImXPGAfwCxA==
X-Google-Smtp-Source: ABdhPJxjvAEbKrucvFksvERZCryGKCwyV7tC+ibpxGs/oS12Pez7OfHO5SVmt44eJ7s6GFiURlcPag==
X-Received: by 2002:a05:6000:1c2:: with SMTP id t2mr56781191wrx.378.1638966867421;
        Wed, 08 Dec 2021 04:34:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 01/10] cat-file tests: test bad usage
Date:   Wed,  8 Dec 2021 13:34:14 +0100
Message-Id: <patch-v4-01.10-b3d8ec1697f-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stress test the usage emitted when options are combined in ways that
isn't supported. Let's test various option combinations, some of these
we buggily allow right now.

E.g. this reveals a bug in 321459439e1 (cat-file: support
--textconv/--filters in batch mode, 2016-09-09) that we'll fix in a
subsequent commit. We're supposed to be emitting a relevant message
when --batch-all-objects is combined with --textconv or --filters, but
we don't.

The cases of needing to assign to opt=2 in the "opt" loop are because
on those we do the right thing already, in subsequent commits the
"test_expect_failure" cases will be fixed, and the for-loops unified.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 658628375c8..fc9191c1b94 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,100 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 
+test_cmdmode_usage () {
+	test_expect_code 129 "$@" 2>err &&
+	grep "^error:.*is incompatible with" err
+}
+
+for switches in \
+	'-e -p' \
+	'-p -t' \
+	'-t -s' \
+	'-s --textconv' \
+	'--textconv --filters'
+do
+	test_expect_success "usage: cmdmode $switches" '
+		test_cmdmode_usage git cat-file $switches
+	'
+done
+
+test_incompatible_usage () {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^error:.**needs" err
+}
+
+for opt in --batch --batch-check
+do
+	test_expect_success "usage: incompatible options: --path with $opt" '
+		test_incompatible_usage git cat-file --path=foo $opt
+	'
+done
+
+short_modes="-e -p -t -s"
+cw_modes="--textconv --filters"
+
+for opt in $cw_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	test_expect_failure "usage: incompatible options: --batch-all-objects with $opt" '
+		test_incompatible_usage git cat-file --batch-all-objects $opt
+	'
+done
+
+for opt in $short_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	for opt2 in --batch \
+		--batch-check \
+		--follow-symlinks
+	do
+		test_expect_failure "usage: incompatible options: $opt and $opt2" '
+			test_incompatible_usage git cat-file $opt $opt2
+		'
+	done
+
+	opt2="--path=foo HEAD:some-path.txt"
+	test_expect_success "usage: incompatible options: $opt and $opt2" '
+		test_incompatible_usage git cat-file $opt $opt2
+	'
+done
+
+for opt in $short_modes $cw_modes
+do
+	args="one two three"
+	test_expect_success "usage: too many arguments: $opt $args" '
+		test_expect_code 129 git cat-file $opt $args
+	'
+
+	for opt2 in --buffer --follow-symlinks
+	do
+		test_expect_success "usage: incompatible arguments: $opt with batch option $opt2" '
+			test_expect_code 129 git cat-file $opt $opt2
+		'
+	done
+done
+
+for opt in --buffer \
+	--follow-symlinks \
+	--batch-all-objects
+do
+	status=success
+	if test $opt = "--buffer"
+	then
+		status=failure
+	fi
+	test_expect_$status "usage: bad option combination: $opt without batch mode" '
+		test_expect_code 129 git cat-file $opt &&
+		test_expect_code 129 git cat-file $opt commit HEAD
+	'
+done
+
 echo_without_newline () {
     printf '%s' "$*"
 }
-- 
2.34.1.926.g895e15e0c0c

