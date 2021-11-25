Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99EE4C433F5
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 22:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245009AbhKYWJ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 17:09:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236876AbhKYWH2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 17:07:28 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EFDC0613F1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:49 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id az34-20020a05600c602200b0033bf8662572so5591741wmb.0
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 14:03:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oLKB6heAWR9cb0Ifv/1P9aRgTb+0oH7yCWXre0WWvq0=;
        b=OzD1wRt3NksIgln+ABrO9f1ZL66jNKKQ2m+AnJwWv2xwUtfi05KlsuqOGgIDBGJW8W
         I7ZaYRfMvdGIOc80w2XR8hy5IPw+0DwRnLPvgfvwfbH+LuZguhyku4mxXsjvNiOWr7N6
         YQm/9Ns1uNSgBvjnhttIU/3nFeSrANteIr4+Abq9UuYsJZxqi6lNcL0N90Lk2J0ODpu7
         iwWjs7jkTT7JJdU1AepxDpC1vsh/TeObFgiEVReKguj4Cvw1VejZXU+SEnbv/FGs4i76
         svri2uxWwXDaQs1KRCyvInFdSbJbAprVamdN3rs7QRfdFRhXEPdOhb1i+2Ik/YkZf9b/
         Szmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oLKB6heAWR9cb0Ifv/1P9aRgTb+0oH7yCWXre0WWvq0=;
        b=cAk+4sSfgNwWDzSj/diKkYXDt9JKWqu6ir8XhthlEZLRl327o5WocXi7qXb+p5Ar1Y
         D6DbWbaQFVhaZ6gkPrPbX1sTFHOLitdG1QdyMKPSymj0GqC8Q+uScE86tT/5a23QJrr/
         H0NqCTBVEG1iDPuN3on8Ce5shlwSBsq8RgNMlLpNIecgJ0zHFMKsyVJ3FXvS/pym876i
         3IOSRzH8LhJFsaGUQrATKADlFl6dwNUal7yPnueBseKb01APYKgUd66mVrh5zcCQOZxF
         fKoXcHJWviRxCb+xBay4aLolFiDCmt4l7Vdxoj11XP38+Fm2BEg3FpcprYdGKiOdd2Wm
         94FQ==
X-Gm-Message-State: AOAM533KJuiMsZpHpx7WDgWBGu45Oe5r+8OOwAMun9VY8eHYOuFKOWsx
        neVwD9Pr/nrmv/RWQnfCFifgTuHI1eA=
X-Google-Smtp-Source: ABdhPJwNN2JAKeGKSaqFtIam5WReag8v6KRil4a+fNi9E1xH793/cKDSCL2D7HDutmWFMRh08Jc4Rw==
X-Received: by 2002:a7b:c145:: with SMTP id z5mr11142147wmi.131.1637877827413;
        Thu, 25 Nov 2021 14:03:47 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n2sm8883726wmi.36.2021.11.25.14.03.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 14:03:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/6] object-name tests: add tests for ambiguous object blind spots
Date:   Thu, 25 Nov 2021 23:03:39 +0100
Message-Id: <patch-v5-1.6-767165d096d-20211125T215529Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.838.g779e9098efb
In-Reply-To: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
References: <cover-v4-0.3-00000000000-20211122T175219Z-avarab@gmail.com> <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
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

1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh | 84 +++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7891a6becf3..ae1c0cf2b21 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -25,6 +25,90 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
 
+test_cmp_failed_rev_parse () {
+	dir=$1
+	rev=$2
+	shift
+
+	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
+	sed "s/\($rev\)[0-9a-f]*/\1.../g" <actual.raw >actual &&
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
+	cat >expect <<-\EOF &&
+	error: short object ID beef... is ambiguous
+	hint: The candidates are:
+	hint:   beef... blob
+	hint:   beef... blob
+	fatal: ambiguous argument '\''beef...'\'': unknown revision or path not in the working tree.
+	Use '\''--'\'' to separate paths from revisions, like this:
+	'\''git <command> [<revision>...] -- [<file>...]'\''
+	EOF
+	test_cmp_failed_rev_parse blob.prefix beef
+'
+
+test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '
+	git init --bare blob.bad &&
+	(
+		cd blob.bad &&
+
+		# Both have the prefix "bad0"
+		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
+		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
+	) &&
+
+	cat >expect <<-\EOF &&
+	error: short object ID bad0... is ambiguous
+	hint: The candidates are:
+	fatal: invalid object type
+	EOF
+	test_cmp_failed_rev_parse blob.bad bad0
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
+	cat >expect <<-\EOF &&
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
+	test_cmp_failed_rev_parse blob.corrupt cafe
+'
+
 if ! test_have_prereq SHA1
 then
 	skip_all='not using SHA-1 for objects'
-- 
2.34.1.838.g779e9098efb

