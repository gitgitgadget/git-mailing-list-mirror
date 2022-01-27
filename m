Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125BEC433F5
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 05:26:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236156AbiA0F05 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 00:26:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiA0F04 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 00:26:56 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F60C06173B
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:56 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id k18so2558897wrg.11
        for <git@vger.kernel.org>; Wed, 26 Jan 2022 21:26:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IB+HySO7RhV3m+YJsU8OoafOl7+wSjN/HS8QDu1KAlA=;
        b=p/6lCCDj8D0Z5a9jh8zGKB28Og5yPhEYsB04ByNfIbDitme+vKysMoc0J4mvohfxN6
         NGZQ0SoG82eoe5MpqGZDU68FNDVgiQ63+5xYh40pnWRn4ngEt4sXFcpY4JeNEHwBbEWa
         gLiA0MBS3JjQyUZvWXGtCbHNju3v/+XEZldrnoubptdOMr8g/oHb+gzCE+8Mv+Ql4092
         xWolFKm0rymWEh45AiEI/l1U+yWjYfx61wEBPZMmVfeRCk+X+tNQE8yNkTjPvwU/rfzz
         lhf2OyX5ExLmDd9/UM3yIz3hbqxOTBmEW82JWWfZU92KMbdRgpWaCZmVcwDXoxedPkE9
         +wFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IB+HySO7RhV3m+YJsU8OoafOl7+wSjN/HS8QDu1KAlA=;
        b=CSRSNSpre7nZM24CXF8e5pKg3qL/0mgBbotpUuMSlmPENsWfn3fzVkUKiE0/6rkm92
         KxTGKhX16VFIP86m9iJx1/iJjUzvYicvt9zgNqzgElzoYV+8lb1NqMt80f0pW2CDLBth
         jY5PxxZUDii31xfkhAV/Gmg4a1+9Q+0Jo+m3pzIUhb/QSa75hYCw1EuC/61/jAB6CEsT
         5u2GveEw3KT6jJSTxTjbPJcwVMGtqJ7M0l2NW9W7Omr0abvspbj9fvNZGzxOYXAWkwqi
         GV8J1jLm0Sm1z1DBzGwKWypVZxPI3m54OUW0PVpyuLm4DR/F06HB+SKdiIHEELlwZUAo
         59Ew==
X-Gm-Message-State: AOAM531FbWjKYHjSMpt33eZs6e3dxY+yeyv5rzl70xmQZ2KImGP7vu18
        pFxLp6JMQfcx0Bok2szOBl+htFvqH0Yexg==
X-Google-Smtp-Source: ABdhPJzW1XiVJGp1WTzjrfguZilSITIoOhYsxdw1EF0BlktOLue1vYXQF6l4vqxb70vSPJYCVxkPRw==
X-Received: by 2002:adf:ef48:: with SMTP id c8mr1553278wrp.368.1643261214834;
        Wed, 26 Jan 2022 21:26:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm6017661wmp.10.2022.01.26.21.26.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 21:26:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 1/7] object-name tests: add tests for ambiguous object blind spots
Date:   Thu, 27 Jan 2022 06:26:43 +0100
Message-Id: <patch-v8-1.7-756c94bda7a-20220127T052116Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.890.gd7e422415d9
In-Reply-To: <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
References: <cover-v7-0.6-00000000000-20220111T130811Z-avarab@gmail.com> <cover-v8-0.7-00000000000-20220127T052116Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the tests for ambiguous objects to check how we handle objects
where we return OBJ_BAD when trying to parse them. As noted in [1] we
have a blindspot when it comes to this behavior.

Since we need to add new test data here let's extend these tests to be
tested under SHA-256, in d7a2fc82491 (t1512: skip test if not using
SHA-1, 2018-05-13) all of the existing tests were skipped, as they
rely on specific SHA-1 object IDs.

For these tests it only matters that the first 4 characters of the OID
prefix are the same for both SHA-1 and SHA-256. This uses strings that
I mined, and have the same prefix when hashed with both.

We "test_cmp" the full output to guard against any future regressions,
and because a subsequent commit will tweak it. Showing a diff of how
the output changes is helpful to explain those subsequent commits.

The "sed" invocation in test_cmp_failed_rev_parse() doesn't need a
"/g" because under both SHA-1 and SHA-256 we'll wildcard match any
trailing part of the OID after our known starting prefix. We'd like to
convert all of that to just "..." for the "test_cmp" which follows.

1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh | 82 +++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index b0119bf8bc8..c14d88eae20 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -25,6 +25,88 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_cmp_failed_rev_parse () {
+	dir=$1
+	rev=$2
+
+	cat >expect &&
+	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
+	sed "s/\($rev\)[0-9a-f]*/\1.../" <actual.raw >actual &&
+	test_cmp expect actual
+}
+
+test_expect_success 'ambiguous blob output' '
+	git init --bare blob.prefix &&
+	(
+		cd blob.prefix &&
+
+		# Both start with "dead..", under both SHA-1 and SHA-256
+		echo brocdnra | git hash-object -w --stdin &&
+		echo brigddsv | git hash-object -w --stdin &&
+
+		# Both start with "beef.."
+		echo 1agllotbh | git hash-object -w --stdin &&
+		echo 1bbfctrkc | git hash-object -w --stdin
+	) &&
+
+	test_must_fail git -C blob.prefix rev-parse dead &&
+	test_cmp_failed_rev_parse blob.prefix beef <<-\EOF
+	error: short object ID beef... is ambiguous
+	hint: The candidates are:
+	hint:   beef... blob
+	hint:   beef... blob
+	fatal: ambiguous argument '\''beef...'\'': unknown revision or path not in the working tree.
+	Use '\''--'\'' to separate paths from revisions, like this:
+	'\''git <command> [<revision>...] -- [<file>...]'\''
+	EOF
+'
+
+test_expect_success 'ambiguous loose bad object parsed as OBJ_BAD' '
+	git init --bare blob.bad &&
+	(
+		cd blob.bad &&
+
+		# Both have the prefix "bad0"
+		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
+		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
+	) &&
+
+	test_cmp_failed_rev_parse blob.bad bad0 <<-\EOF
+	error: short object ID bad0... is ambiguous
+	hint: The candidates are:
+	fatal: invalid object type
+	EOF
+'
+
+test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
+	git init --bare blob.corrupt &&
+	(
+		cd blob.corrupt &&
+
+		# Both have the prefix "cafe"
+		echo bnkxmdwz | git hash-object -w --stdin &&
+		oid=$(echo bmwsjxzi | git hash-object -w --stdin) &&
+
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo broken >$oidf
+	) &&
+
+	test_cmp_failed_rev_parse blob.corrupt cafe <<-\EOF
+	error: short object ID cafe... is ambiguous
+	hint: The candidates are:
+	error: inflate: data stream error (incorrect header check)
+	error: unable to unpack cafe... header
+	error: inflate: data stream error (incorrect header check)
+	error: unable to unpack cafe... header
+	hint:   cafe... unknown type
+	hint:   cafe... blob
+	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path not in the working tree.
+	Use '\''--'\'' to separate paths from revisions, like this:
+	'\''git <command> [<revision>...] -- [<file>...]'\''
+	EOF
+'
+
 if ! test_have_prereq SHA1
 then
 	skip_all='not using SHA-1 for objects'
-- 
2.35.0.890.gd7e422415d9

