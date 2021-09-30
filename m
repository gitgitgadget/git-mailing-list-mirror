Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A2DFC433EF
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19A4C619E9
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 13:37:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351667AbhI3Nj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 09:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351644AbhI3NjR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 09:39:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C41AC06176D
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:34 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b204-20020a1c80d5000000b0030cd967c674so1793784wmd.0
        for <git@vger.kernel.org>; Thu, 30 Sep 2021 06:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rWN+RH+Zw345gEiuKX4KhLTtLQmPsmRhJKjj02eTL44=;
        b=K28iqKLWWlTrRF/FUZWpmR3u7fWJXwqZ55XdECnoCek1JaihESH6EN/JHzSnEOywhn
         V9KC3O7PI3ZEFUtImVyGFcERnSMKTsdCPAE6NGxBvacKEyL5S5lPjjoj2F4Z4coJuoY6
         W0q5CawJ2HqUSnESe5Xn2k3F0RPKa7TZUT8lOY20JKWdCN/wv+X+k3Dp3YOOXFlE+hO9
         VDXyLXItZoQtQ+erMEi5nGe9HeZhiYtmkRIOVvCLFtP7WEfPy4i2l/+Yx5sY+BpPS9Js
         16zzXZggbCset0ND8t9XhgBudZrJTN9wK3KHFAGJgnkZLrdQoaTM6ZHTSs20SfjJRQIS
         P2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rWN+RH+Zw345gEiuKX4KhLTtLQmPsmRhJKjj02eTL44=;
        b=iWgJXwcjMscLuzmWxVxserESEnjQ0G+XqweRfFH4JRWyWf07YrG74QJ10fGkPXHD/L
         qRMI6yxJX/dzMyRdSBCB63byd53W8uPUXHa9YTgGvelO0IxLYuXG2p+lE0f7em8fJdVK
         iPtcXrkXOwHaLWbJEEZ/MDv7BIZ25/ixTqdVU2dqbqFb83LUKrFw2XiQDz5Tzf8+6LZU
         nuXJ0x0WlgAdLaAjYiUpFWmjnr8x1wnD16+f9NWDt2qsLic7iCV1KKoFGi/M/gwXz3SU
         rsp8U8i+6v1I4Brx91LYIDNONOMx0N7kWBVk2N5EcMnzL+oDTyiEE/B9vBCIlod38NwR
         m5Iw==
X-Gm-Message-State: AOAM531HppwJpQqvRGR5KuB93LPdmRS68rQR/SNnyVIE0h7IeyNV2F5g
        ZyXAc2fTWSUZqSBtw1ahbivTcaRvFGlPdz9W
X-Google-Smtp-Source: ABdhPJwPOGFT7ta+j3Bel5IuTvqiCsrWHEVQEu2aIyF7EjYsMT7d1ae3ISIRgZGmmnESe1j48ji91w==
X-Received: by 2002:a7b:c056:: with SMTP id u22mr5484967wmc.15.1633009052046;
        Thu, 30 Sep 2021 06:37:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o11sm4654713wmh.11.2021.09.30.06.37.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Sep 2021 06:37:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 06/17] cat-file tests: test for missing/bogus object with -t, -s and -p
Date:   Thu, 30 Sep 2021 15:37:11 +0200
Message-Id: <patch-v9-06.17-290bf983590-20210930T133300Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1374.g05459a61530
In-Reply-To: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
References: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com> <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com>
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
2.33.0.1374.g05459a61530

