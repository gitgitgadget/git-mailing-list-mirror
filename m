Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CF82C43219
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 22:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbhK2WW3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 17:22:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbhK2WUf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 17:20:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9474C08EACB
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:16 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t9so22355059wrx.7
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=crXcE+kVXP7rdNV/rbhjFkNiVm8INcY04p9pUzcsfUs=;
        b=EBKYSDYFU7kFOJ0RaPWTKky/SMrlxLgPt2H3DI5ZfYgTg36M5JBtj6HHrZU+xjyL/P
         27UMTSBMASy6SEm0FKi54071UcaUyy8HDLdqMuyZQxs/f0Iz53T/vg3Kz1kt6XcKpJfI
         brM2W02P+8viSYcJuc2hxqkDXlOscMFj/TZGtopYY2QaXvpAgjnqT7H1dK/DjD6rwW5U
         1PxTsfCokGs0NJh4mcseN9b4DwNgIKMYIppcJqXdFcuofPZ+CsnxGMV6RU21V2utFuoJ
         LliiVdyx1vbiAnvA8bCobmhUnt2Pp/6r3t8PJsx170b1DosYtriUbQHB8Q8XBtkR97Za
         mEnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=crXcE+kVXP7rdNV/rbhjFkNiVm8INcY04p9pUzcsfUs=;
        b=CXm6JKhrg6i74j47bqn8RsyCXlIaucJrtAtqnJKavqVFnfMexEkqelnf2q3pVI3BYS
         Px+rdTbp805FNaYchZVKaVZahi9GPFEld2l9TxM4tJ4H1p+sSi1Me9FgJ4dUqdY1gjZa
         xIuv2Y07ljn9RtrwMPc9JIMdvmUNgmz9Mxq20NqyNsGCIz8UI5cRdobiVabxdJhpEXEI
         12ippaTCFPbnolqVxd+x4TiCs2WllDdtZSGEQQXJqww+tvAP8wKfre9dYFUDE20l8cs1
         M1egt4+dYC0gm8jopTcVRY6if5nBHmHML6Xp+fHx0hfnAFjXmdgzqhWiVZSKPkUvnZv+
         gB4w==
X-Gm-Message-State: AOAM530Wo6q2Siy3asDLNaspfUYNRh8zKYEPAWPiM4nQTCTTC08Y0Cvd
        eJSadWL3QL/eyx8wYzU7Z8ilUaiNPtTstA==
X-Google-Smtp-Source: ABdhPJz5Zb4bTZMS8QQElyr89dvxg4Pt09Pt3aKlHuU1ZzOcH4800ZGguMd0v//eP6mLREKZ4AI2PA==
X-Received: by 2002:a5d:47c7:: with SMTP id o7mr35231748wrc.204.1638215955117;
        Mon, 29 Nov 2021 11:59:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t8sm298200wmq.32.2021.11.29.11.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 11:59:14 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] cat-file tests: test bad usage
Date:   Mon, 29 Nov 2021 20:57:41 +0100
Message-Id: <patch-v3-01.10-d77771e3ea0-20211129T195357Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
References: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com>
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
2.34.1.841.gf15fb7e6f34

