Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7392CC433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58D2161262
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 02:19:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238624AbhI1CUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Sep 2021 22:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238592AbhI1CUp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Sep 2021 22:20:45 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E0C061575
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:06 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id t8so55322815wri.1
        for <git@vger.kernel.org>; Mon, 27 Sep 2021 19:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gVf2klUvKrJzi92Idrp/ceD4GOQ4ihxxamGH7CtMziY=;
        b=UDHcH0FOtpiNfSvUrzhYyIUd3UOZqKCxS1lhDqpszKGadzGom+9urOfUoMT8dqAwVI
         UurRczKBLgD92lrPe7qvyepEY5DAry+uOLGCOIAo7fiuzBm4cf58JJI0nItSkFOEwuGE
         ylNU7QrfxzQm/qSWOKzm/h68LQRiCeUgR06l2nipYcrOS3LwbUfXcCPFHSPHG44TJIYF
         Tv3eyIgN0A3rgcHBOqog7n7cKpwqLnWDSAXFZJneuqKbQLE5aI8Qaqnlp6a7ttCDEhqw
         4w/z3gnDysK+4YaI61jZX4fKq+cni0DAcNU7kX0TyboimsC5+NJrjVIX/XRUD357ZkhV
         1+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gVf2klUvKrJzi92Idrp/ceD4GOQ4ihxxamGH7CtMziY=;
        b=xjxPP7fyobzu3RUXJ6PU4Ztqvzoyfr7TOAd1cMshqfY8rctwnCIUHNQXTIyqzay5IA
         YDFmi6Voi3eGvpXNuxp9mnqTFZRas3HKN24RDrH9sZ6f6PHQrqQ5Bs3641+umO3CSPO6
         EdUOQzvY1PEfOqCBYzyo+5iHQ1Sk5gQOOay59P+ZOp2WoJImT0OrE7c8ZFm53xQ5l5Wt
         wKUPbkj7OR2aR4/YhFJgGOQI9uzlubCE2fWIKqZGvS38KrulW4pGwQ1iiqfj0+pEQDei
         gJDw1TZAWlhY+X9BRxKp9/uYbA1W0lUzYJzw7HRIX/jyv9qkXqkOQY1ELZbcX0KRgdkO
         d0RA==
X-Gm-Message-State: AOAM5339edueX91K1zg84aSb7ymh4ND6WRdLlkeQM4lynUgdrSBTcVc1
        uxP0eOeAMSS8GeLZXkvZ1FDSFBGCB5ZT9A==
X-Google-Smtp-Source: ABdhPJyvkre2lVRv7t0D2mXp7Z92Wuf1nBDqliK+8gu9yBJC3dcQ0fVOWYcavk2+kskDC22v1J8f6w==
X-Received: by 2002:a5d:4608:: with SMTP id t8mr3699449wrq.136.1632795544646;
        Mon, 27 Sep 2021 19:19:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c132sm1126987wma.22.2021.09.27.19.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 19:19:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 06/17] cat-file tests: test for missing/bogus object with -t, -s and -p
Date:   Tue, 28 Sep 2021 04:18:47 +0200
Message-Id: <patch-v8-06.17-91229b94fac-20210928T021616Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1327.g9926af6cb02
In-Reply-To: <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
References: <cover-v7-00.17-00000000000-20210920T190304Z-avarab@gmail.com> <cover-v8-00.17-00000000000-20210928T021616Z-avarab@gmail.com>
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
2.33.0.1327.g9926af6cb02

