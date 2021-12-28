Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5F7C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 13:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232691AbhL1N24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 08:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232666AbhL1N2z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 08:28:55 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC98C061574
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id c66so11602882wma.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 05:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ExpVaX1q5LRmpu0/E9cLSYfXWU2o3sjp/NZUuOb3tKs=;
        b=m5/2FG9Ckg9xOMSprYRB0pCFDXKSgedhQPr/j2DPQUy6+5l3tfTAml2fKY4r9jdvX/
         JWHZEMtgVZ+P6mfzmCnP7y2kZ0v7EqDqvlszjqETFSPH51nWyFnLKuuyYlXHJZztkTUn
         dc5UcmdJtxZSMeDBNv7hQxuKMKbKgb3qpFAQIyzp9Ly6+5cpk5i3OoyRdl/dXd5lWdW4
         XkzJgMbybaKm9nZXS6NBn8rl8U5JTpiggcg4s9aCKgiXl5u37kmzbX7udKVzviAWKKOC
         5elyt0jhJ3rFyXEsuLT9yABYcqwFj+KABLIk565x/n6RUCrpLnuvNGtme1u9hxPOEAKl
         cA7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ExpVaX1q5LRmpu0/E9cLSYfXWU2o3sjp/NZUuOb3tKs=;
        b=Bsdp8/n1voU6H+0tyDkq56oOU73ONB35umfVdN2sV6nRy9c0F4HXOZBNLZhhAJs1En
         NqwN7k1I8dRKetVAuCBrs/PLJjcV+p+ZEblfShG4JF5WD4zQoUfJ5t3Bu3b1fcZOSwED
         z5lxXw6WI0GTXkxj32bGeGK4s5G9SqGKsc/wIaph3IANecYpF4NMpWNlP64qInv91dtM
         CtDSEJ19af8ydfy/fAnmc4NeINILWDQACrLTglPZzg7Z/h4NtgM2tMTIqlEDOIhQPu9e
         GW8sqCYIMqPrxtc6hgwFWA591T4zHY2ZOqP/fLTL3QaUWuxAnCdlrkZtwHii7ViRva2e
         YkVA==
X-Gm-Message-State: AOAM533ZPklrc0sVpB6GKgYIao0vEyeTTv8agg47ycrzpWy/q6Jpay6y
        n5jcbrSirpPVrElEbRcG0kZQBWyTNMTekTsH
X-Google-Smtp-Source: ABdhPJxRhNom1P2UWJ//gmZBxRDOKrSeF85U4Ej2+OQsjcE93YOpgKsJ+qltM5KcukGrSGaQF5w2zQ==
X-Received: by 2002:a05:600c:2314:: with SMTP id 20mr16785340wmo.16.1640698133737;
        Tue, 28 Dec 2021 05:28:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d11sm19695868wri.101.2021.12.28.05.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 05:28:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 01/10] cat-file tests: test bad usage
Date:   Tue, 28 Dec 2021 14:28:41 +0100
Message-Id: <patch-v6-01.10-e52834a343f-20211228T132637Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
References: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com> <cover-v6-00.10-00000000000-20211228T132637Z-avarab@gmail.com>
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
index 0d4c55f74ec..8a29f96809d 100755
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
2.34.1.1257.g2af47340c7b

