Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48374C433F5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B535603E5
	for <git@archiver.kernel.org>; Fri, 12 Nov 2021 22:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234372AbhKLWXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Nov 2021 17:23:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232001AbhKLWXp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Nov 2021 17:23:45 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6EAC061767
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:53 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so18031633wrb.2
        for <git@vger.kernel.org>; Fri, 12 Nov 2021 14:20:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aWR95Ex6SPl3lkN4N5PQiIkcULkOF2UqU8ynGQkaUCU=;
        b=K2E64zq+PqTq8wVofO5UcMZYvByXv71H3Dnv1S5/0Gx4My2o9eSCyi08eU94guSRLA
         WCbRMsY1KcorGRrI8qdbBc4esyakdAL6rMLH/64UPTqXtL+sp6sUUBnnc+5ye80RmASQ
         CkRjrulODfy8L2BzA2z5DjyUgJ2Hyd9rYzoOCwTpR0fHFWfs8B53hEquzfkUD3Nd6yQx
         yd0opw+HPqZW0XkbAYXFwuA9WIuNLXaX/1foxn2PHAvbQmA60XAS2rHUvoK/C9iyqP3o
         OfevoaUhvnTrYamATfjNY3LwBK/zSsNnupfH1uU8p7Q+mec6TEbzh3UJG5xIetTau7Rd
         YAgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aWR95Ex6SPl3lkN4N5PQiIkcULkOF2UqU8ynGQkaUCU=;
        b=s+/cb6R3dMkV/N3GuamCILk2+ELIbo+E9RwzjTfw3j4Kub3++Y88aLwtXSvkiDTdtV
         GYSAIMnH46GcFqaSRczcJITuifHGadsKogWG1NUROuldV/N5w4LhUIaBVVmIr+g+z79s
         0ucI1Qi5CY0oDLBGlvZFfU2ZQgA2fWIZ3MQEZvgbhAoQ4HV26IXlF9jXRMyDVHomwBYs
         ym0SocQHWsrtk0YtrSgiGf1USjoZBGRJbIU9D/J0N6371CxmRGPEA2LHl6olf1CX1blu
         dqfMGTgMvEofTQHqZTpIANYdesZo1hng9SQg/XRv6YDB0PhzziKzv4YNlJNmSm0TfjkG
         Ta8Q==
X-Gm-Message-State: AOAM533U88weNVfL0avJ1vB+krRBKCiFO13SxP/+Eh76K4oWyW0S7PrC
        jst39oh+F6IsvjyZsNNdSBQbrgaijLuCeQ==
X-Google-Smtp-Source: ABdhPJyk9h4x4ynye7ArRfiDv4E0eCXJXuQl4VAfnezW3OIP5Mkb4Mq9iOBkPK3jbhW6jBzQ2/sP0w==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr21569065wrt.91.1636755652251;
        Fri, 12 Nov 2021 14:20:52 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f7sm7896985wri.74.2021.11.12.14.20.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Nov 2021 14:20:51 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] cat-file tests: test bad usage
Date:   Fri, 12 Nov 2021 23:19:59 +0100
Message-Id: <patch-v2-01.10-3a0d2923cfa-20211112T221506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc2.795.g926201d1cc8
In-Reply-To: <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20211106T214259Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20211112T221506Z-avarab@gmail.com>
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
index 658628375c8..411efc2771e 100755
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
+    '-e -p' \
+    '-p -t' \
+    '-t -s' \
+    '-s --textconv' \
+    '--textconv --filters'
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
2.34.0.rc2.795.g926201d1cc8

