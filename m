Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C2EC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C15D61159
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 02:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232321AbhIUC7e (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 22:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349419AbhIUC0c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 22:26:32 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD55CC1E326F
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:32 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so32592273wra.8
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 12:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C3IG3iAz3KxBb974bzWBQ0RZEN+n2xGFgcUoNIBvhgk=;
        b=Vaemjfo3Rt9p2zYnngTYb7wMmTmkQypPpta04Mgri2kUnfmLL8Q4c3eF4brxRQetYF
         QjPgVGnWBomMw5ep2nfbe2dW4feFwn1VvSwc7yBCNLYsRcr8Wu09IsGSIU8TVPjECiJs
         cns7TPVXLvoJS6EnwryRscDkxvUSLg4XMIVHfBt3H2YquOnVeTRC7IAbLJ71ze6OZVNq
         CxCG4k1FK3YDQyALzR52pryjWgLckRmxn9TkCuz5+6ieVl4DOHSwAnkmXaXVEB2xQr9P
         1GmQU+W3JF5ctWmMfcKapDLhYom/+bgFjoey+7s1z9FKG4w/Ga5RhHlQY31a1xcqmLtX
         Lf1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C3IG3iAz3KxBb974bzWBQ0RZEN+n2xGFgcUoNIBvhgk=;
        b=48i2Xg55ho51fJKncgkkCCWRFrzoMrcKOhLAQCyBx+5F0slQCwVHmGwvotO8L/2mmM
         gCTU6tFTPBOEe3DnsZPXq9SWrXfrESkVifdFLvH2HJ+oAsVtJD2IbaJb1NWeZYmT932b
         Esiy0B6Dzd6IsLzxHm7ZNuLwgcn4IlpKIuxaIdD1N7sdiN+8zua0i79rG7ygvDQakXwt
         FGd5UMsIjT5Km19Isfdr3xAM4yKZqPHPKnA/ObHS2GtioVIgYm90U5l1A9bYb1/P1teA
         rpS27XB6FydYf+Z+hmKHLD/N+5cDYpc1xWNrPHoX3DHJRBrDInfw/S76LTlD10+CkGsm
         ZTlw==
X-Gm-Message-State: AOAM5337F9MbCyoGDx+N9Ea0tr+zJFOtNDtmxGwBWsUcl8N5R0gm9k/n
        MRimdNL7R+GUM/6tkwUARWby57Ll7eml5g==
X-Google-Smtp-Source: ABdhPJwgsizktOQLXJQajycZoYZLk6OBI1ZONT0c99OF30bMrQJqvCxAt4yL5jAZ26BjSHVDP/oNQQ==
X-Received: by 2002:a5d:59a4:: with SMTP id p4mr30665819wrr.149.1632164671047;
        Mon, 20 Sep 2021 12:04:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o19sm8157772wrg.60.2021.09.20.12.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 12:04:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 06/17] cat-file tests: test for missing/bogus object with -t, -s and -p
Date:   Mon, 20 Sep 2021 21:04:10 +0200
Message-Id: <patch-v7-06.17-051088aa114-20210920T190305Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.g29a6526ae47
In-Reply-To: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
References: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com> <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com>
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
index a754970523c..ecffa9045f9 100644
--- a/t/oid-info/oid
+++ b/t/oid-info/oid
@@ -27,3 +27,5 @@ numeric		sha1:0123456789012345678901234567890123456789
 numeric		sha256:0123456789012345678901234567890123456789012345678901234567890123
 deadbeef	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbeef
 deadbeef	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeef
+deadbeef_short	sha1:deadbeefdeadbeefdeadbeefdeadbeefdeadbee
+deadbee_short	sha256:deadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbeefdeadbee
diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index ea6a53d425b..af59613250b 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -327,6 +327,81 @@ test_expect_success 'setup bogus data' '
 	bogus_long_sha1=$(echo_without_newline "$bogus_long_content" | git hash-object -t $bogus_long_type --literally -w --stdin)
 '
 
+for arg1 in '' --allow-unknown-type
+do
+	for arg2 in -s -t -p
+	do
+		if test $arg1 = "--allow-unknown-type" && test "$arg2" = "-p"
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
2.33.0.1098.g29a6526ae47

