Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC77C433ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BFD1611ED
	for <git@archiver.kernel.org>; Thu, 20 May 2021 12:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237250AbhETM1Z (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 May 2021 08:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233706AbhETM0v (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 May 2021 08:26:51 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA0C0438DD
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id z12so23222103ejw.0
        for <git@vger.kernel.org>; Thu, 20 May 2021 04:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eP4AEHzVzEbZOTA44KMAoTGCAlADhb68JBfO2bUIPSI=;
        b=bNq+fmOm+Nr+/NqLGGxpH8blE4cDktyItzD5cFIpWU0buEQJEe//RGNCpQxawX52fZ
         5AkgS/+ewFY4eF5I/wcD0FQPgTQsFZwkuFt6WKDjRObuPK39wreBV3wEPVKgLG0CzWY4
         I8F5Shp1jXrTnSjaSXU0yVOSRWiBnfZvCG9YSSKYKgsdV2nujmt2DvOr2Y5yw1L52iHu
         wwUB//ZCubJOLNp2+NwiUTnrdfWLxzY5z/KYClWs4DuXuOPYaYgmGQ0pWDPKICb5AR+Z
         OKNC9biQyLRqRJad9fwcgwGESwlXaeZH7R+QNNtuygWaFzyeedh8TcwFn8jNus1sg8aZ
         qX3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eP4AEHzVzEbZOTA44KMAoTGCAlADhb68JBfO2bUIPSI=;
        b=CGTyA0SZykcHvuXx3FEXDWEYPJpbTeQt/frtKxTThMIhoru7GMT1ddm3FtujnTNkXR
         FsqvvGggqPfnc5RAEo7yDoQ4HRfrr0IACEdE53nTc9qwz01PVLU9QBy8/IS+Rm2Cu+th
         2pnc5KgIHptBcgJXubg67lKkHdoflY8KkF9bnujQ9ar2ItuuOqHs1j6nVa57PlrJv/+N
         1Fk2CFn+mnes2kANm6o/zs1H98kCtYvGP+cfn4lPbXTubFJu1OUMOEEwX4sZoYfgcaKX
         ppQIQ1JD4TE2uUB5CVrR0VwhAEY7b5iJHm15Yz0pIXj1EoQLQV9WcFxHgYHm0x2fszdD
         OoHA==
X-Gm-Message-State: AOAM5314b9aSirRasc3hkjexfTic9kmG3+qowEGy75dz19mKgSTMtJdR
        v6RYMgxvXNN3KoleJ/+Uwsl6tTag/7Kutw==
X-Google-Smtp-Source: ABdhPJzQli/EDIUymKwISiFUNWOq68UukdW5m2htHSDuy2Y7WuM+vxU+uy68oVnX3l4d77yhIarW5A==
X-Received: by 2002:a17:906:f256:: with SMTP id gy22mr4090750ejb.537.1621509800654;
        Thu, 20 May 2021 04:23:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id jy21sm1243273ejc.13.2021.05.20.04.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 04:23:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/17] cat-file tests: test for current --allow-unknown-type behavior
Date:   Thu, 20 May 2021 13:23:01 +0200
Message-Id: <patch-07.17-9217320888-20210520T111610Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0.406.g73369325f8d
In-Reply-To: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210328T025618Z-avarab@gmail.com> <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 4a76ff024d..d3d3fd733a 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -361,6 +361,46 @@ test_expect_success 'die on broken object under -t and -s without --allow-unknow
 	test_must_be_empty out.actual
 '
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_type $bogus_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -372,6 +412,27 @@ test_expect_success "Size of broken object is correct" '
 	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.32.0.rc0.406.g73369325f8d

