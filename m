Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC67FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0845610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352935AbhJAJS5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352909AbhJAJSv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:51 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCEC8C0613E2
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:04 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id j27so6740359wms.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T7v8TdyQ32Cu9JcLQY3VyGyq9zySMfN56Hxa7Ls+Ras=;
        b=YYeuw2foAJK3jjSS/je0QNCNNvoaXzJob7UfQRFR7kDmtUS8h21Wha1Lpr2dsE6fg2
         /HmkMyp7B7S5MWcb77zrqXJrQrxZjbgTPlHGJAbtwH0NvUr4cf1GK17FJvZGJemEVShD
         0QAgM8iC6GS1splVNguh1RX0R3gp0Hdv2D3nkXQAJVpZyjHdBs4yY+G42J8LaxwKTRZV
         1MnA1wfFNJmKcRXX4SHoqU8E8NoACiMHxRyR2X3j0Nq1r6W6S3V8a2fHJ6JQVUdYUsUC
         B3JeqwfOq4Bg6QpkFZ8guUlcPY6X9dCxOgfwx3j+kMV8zO77xabyNzZcH9KowGWRR7NJ
         2xzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7v8TdyQ32Cu9JcLQY3VyGyq9zySMfN56Hxa7Ls+Ras=;
        b=hBYjTSBscEfIk50OvCbtmmymEDiJTjgVql0Cy5rkp/SMXYukQoXkycSU20qTFVEVAw
         G4rs16g5Y458ri5/vIuD13Lb1rd9Kv8+Z46oArjV1eDDnQ1cg1VlDdqhOua4qzm7mPeV
         EGbxUWT4N0uqqMgKo3D9cij6t3FfRA0YsE3W3YlkhWklgvXHBqnrPJgCoDfo3rXmdkfQ
         mMTsS+mCCkSvkavVD1pIKM5A+bjf0zDis4AHbLxe2zjXfxjPHxjCYnmKUOU0XyNO29se
         YktyAB6TNsHOEXOGMZyLA64+OO4ygBXgANiHXL7exq3HpAHk1T/Jg/cARGBi3+CCaGJy
         TGEQ==
X-Gm-Message-State: AOAM530AvutqFnSFBrucrvS1buIr4LtOa1qZhlzLGw5ImtQeo0M5cL7R
        x91Me+YAjZSQeXI0Jam8axI0jwKoxqrItg==
X-Google-Smtp-Source: ABdhPJxCSCIiAp/k3PCSPHCFEuAJWQpqzPkA7YkXISPwUNdga4hN1N/gwMLI+EMEsOrJO0FuyIR8YA==
X-Received: by 2002:a1c:98d1:: with SMTP id a200mr3412308wme.86.1633079823039;
        Fri, 01 Oct 2021 02:17:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 06/17] cat-file tests: test for missing/bogus object with -t, -s and -p
Date:   Fri,  1 Oct 2021 11:16:42 +0200
Message-Id: <patch-v10-06.17-a563c7efe1c-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we look up a missing object with cat_one_file() what error we
print out currently depends on whether we'll error out early in
get_oid_with_context(), or if we'll get an error later from
oid_object_info_extended().

The --allow-unknown-type flag then changes whether we pass the
"OBJECT_INFO_ALLOW_UNKNOWN_TYPE" flag to get_oid_with_context() or
not.

The "-p" flag is yet another special-case in printing the same output
on the deadbeef OID as we'd emit on the deadbeef_short OID for the
"-s" and "-t" options, it also doesn't support the
"--allow-unknown-type" flag at all.

Let's test the combination of the two sets of [-t, -s, -p] and
[--{no-}allow-unknown-type] (the --no-allow-unknown-type is implicit
in not supplying it), as well as a [missing,bogus] object pair.

This extends tests added in 3e370f9faf0 (t1006: add tests for git
cat-file --allow-unknown-type, 2015-05-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/oid-info/oid      |  2 ++
 t/t1006-cat-file.sh | 75 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/t/oid-info/oid b/t/oid-info/oid
index a754970523c..7547d2c7903 100644
--- a/t/oid-info/oid
+++ b/t/oid-info/oid
@@ -27,3 +27,5 @@ numeric		sha1:0123456789012345678901234567890123456789
 numeric		sha256:0123456789012345678901234567890123456789012345678901234567890123
 deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
 deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
+deadbeef_short	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbee
+deadbeef_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ea6a53d425b..abf57339a29 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -327,6 +327,81 @@ test_expect_success 'setup bogus data' '
 	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
 '
 
+for arg1 in '' --allow-unknown-type
+do
+	for arg2 in -s -t -p
+	do
+		if test "$arg1" = "--allow-unknown-type" && test "$arg2" = "-p"
+		then
+			continue
+		fi
+
+
+		test_expect_success "cat-file $arg1 $arg2 error on bogus short OID" '
+			cat >expect <<-\EOF &&
+			fatal: invalid object type
+			EOF
+
+			if test "$arg1" = "--allow-unknown-type"
+			then
+				git cat-file $arg1 $arg2 $bogus_short_sha1
+			else
+				test_must_fail git cat-file $arg1 $arg2 $bogus_short_sha1 >out 2>actual &&
+				test_must_be_empty out &&
+				test_cmp expect actual
+			fi
+		'
+
+		test_expect_success "cat-file $arg1 $arg2 error on bogus full OID" '
+			if test "$arg2" = "-p"
+			then
+				cat >expect <<-EOF
+				error: unable to unpack $bogus_long_sha1 header
+				fatal: Not a valid object name $bogus_long_sha1
+				EOF
+			else
+				cat >expect <<-EOF
+				error: unable to unpack $bogus_long_sha1 header
+				fatal: git cat-file: could not get object info
+				EOF
+			fi &&
+
+			if test "$arg1" = "--allow-unknown-type"
+			then
+				git cat-file $arg1 $arg2 $bogus_short_sha1
+			else
+				test_must_fail git cat-file $arg1 $arg2 $bogus_long_sha1 >out 2>actual &&
+				test_must_be_empty out &&
+				test_cmp expect actual
+			fi
+		'
+
+		test_expect_success "cat-file $arg1 $arg2 error on missing short OID" '
+			cat >expect.err <<-EOF &&
+			fatal: Not a valid object name $(test_oid deadbeef_short)
+			EOF
+			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef_short) >out 2>err.actual &&
+			test_must_be_empty out
+		'
+
+		test_expect_success "cat-file $arg1 $arg2 error on missing full OID" '
+			if test "$arg2" = "-p"
+			then
+				cat >expect.err <<-EOF
+				fatal: Not a valid object name $(test_oid deadbeef)
+				EOF
+			else
+				cat >expect.err <<-\EOF
+				fatal: git cat-file: could not get object info
+				EOF
+			fi &&
+			test_must_fail git cat-file $arg1 $arg2 $(test_oid deadbeef) >out 2>err.actual &&
+			test_must_be_empty out &&
+			test_cmp expect.err err.actual
+		'
+	done
+done
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
-- 
2.33.0.1375.g5eed55aa1b5

