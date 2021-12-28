Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 002E1C433F5
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 14:35:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232963AbhL1OfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Dec 2021 09:35:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbhL1OfP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Dec 2021 09:35:15 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 454D7C06173E
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:15 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id e5so38742409wrc.5
        for <git@vger.kernel.org>; Tue, 28 Dec 2021 06:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQOjVsJGMtN8Tgkgg37CqR/MRLqk5pkRUQaVFozg9dU=;
        b=Hn+vD/O2vwh3m/RS0NRFaMW8e9K3Zto62qAxJMoIn0ZHDaZyywUKfHv3MmXaJdzTwE
         572ULiRsRehC3/C3h3pvOjCuDwVxPunFujK0sEYWFPwVGT8WxkQXjGDUOVo1Rjxg2EHU
         0FrzVhYIPSwiRztlFueFytK/oDEhQTBQ0CLQe0fTjtIWdPfCPZqP0+JpAXOTPEHSA+Lp
         tFA/42pEq1Pw/6HUucKvOUzP6b0lnpsnpPdGFbOpAQMC8isanDvjAY763zhIms644TyI
         GDZi0IlGX4Xvo05oPzjl5cNyy4r9unuocyiE6AuwrZgsFqSzca8L6f5W4p4YFOdS4lLL
         1Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQOjVsJGMtN8Tgkgg37CqR/MRLqk5pkRUQaVFozg9dU=;
        b=I/3E2prRihSewj4XQ4c6mYEUoC29ckbEgBUQg/KjJGx6BRTjr3kylYn/Np0dJkmUCM
         NVsNWwl2HhdKtQ7U1ldDU2PFhqSkT1ieniiN0ZCyuQ4IaugLsW615xShYVrzbw9ckpnV
         +bWgGMcDwDjwdOxCdePuoKxQl5zCaIhN5mfM3QJD9MA+SJNJukkGgUSzrLW/FLoDGDN8
         Q6ZdMingLsv7gzgl9etfyAlbCLTVfJA/0FNv4zTN7awb6ryJOIbmhiatnIgGOvWPwfY1
         djwrxwbsH+G2CqfyERPdUicoyiLjjVyjWKb1qeKHco7vY9NFUeMoYjs6RuO6hfNdnnWp
         Ytqg==
X-Gm-Message-State: AOAM5329zhpzuttxD+a+V5CWVEQAIFmQVuIR+ulCb2ehkYYFdErK1ZeO
        yKUOiB0VdplIPDnyQ9HT9CHoVHteY2CYNgKv
X-Google-Smtp-Source: ABdhPJxJBPYWB5Oui+otJxh98oa3HfTVJW3GvIrJrVNXMcsGkdrA4rc7k27yL5XoatLtVaTUm/Fg3Q==
X-Received: by 2002:a05:6000:1789:: with SMTP id e9mr16570161wrg.529.1640702113639;
        Tue, 28 Dec 2021 06:35:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m35sm42780660wms.1.2021.12.28.06.35.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 06:35:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 1/6] object-name tests: add tests for ambiguous object blind spots
Date:   Tue, 28 Dec 2021 15:34:57 +0100
Message-Id: <patch-v6-1.6-27f267ad555-20211228T143223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1257.g2af47340c7b
In-Reply-To: <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com> <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
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

1. https://lore.kernel.org/git/YZwbphPpfGk78w2f@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1512-rev-parse-disambiguation.sh | 85 +++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/t/t1512-rev-parse-disambiguation.sh b/t/t1512-rev-parse-disambiguation.sh
index 7891a6becf3..60d2a457067 100755
--- a/t/t1512-rev-parse-disambiguation.sh
+++ b/t/t1512-rev-parse-disambiguation.sh
@@ -25,6 +25,91 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
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
+	test_must_fail git -C blob.prefix rev-parse dead &&
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
2.34.1.1257.g2af47340c7b

