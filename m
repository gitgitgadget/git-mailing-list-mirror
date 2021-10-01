Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2512CC433FE
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C613610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352983AbhJAJTA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352938AbhJAJSy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:54 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A509CC0613E7
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:06 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h15so12776068wrc.3
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WqMH4XHQj4B7JL5zu9YTFHI2EyOWDLmUkqdSOlcTwc8=;
        b=XUWU/z8oKooEu5Nt/F0SkJo9wC+RYDAA5sc/f8sV1ZOt+b840c8ZmqZyj3TeS5h+N9
         9na/EQcnL5nPO/BF7+hKAvEojSN0DJMYxvoqh4e5eoH/W6sZq28WNU/NTLbIzImKDafJ
         Pf8EuGlLvfxrF5xx/KxDO8Ln0bcs5uexVCSvor7i0XEELzVBw5nF6BaHDF9/SQgvowI6
         u44c0zrImVifJB/2kreJpRU6Fv7ZAQYjnijRLV5s432TJWObeEmVTbPdAzqDWQktGQCu
         zCK5RZiMVu8B6lp3Z8OKhXmShd+R7cddTHtRLFOQz1s7MeVhUeN3B6h3C1J2stieQJWa
         pFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WqMH4XHQj4B7JL5zu9YTFHI2EyOWDLmUkqdSOlcTwc8=;
        b=i6BY34TmeoGSdvbHP3GYYaGcpF1jXcTT1QofuFzcSAueAv3e1HVKVb1Zf+NqSfCZ99
         AaXsFU3nPlKNYkLcgxG4HQdGU6ePRZTQZf9ZyyiFoHdG1kQyvnEYPCgdf5kUhuYu2M/r
         3H/pq9LYug7oExIA87aqUzGp5Km0AQP8OwMMT9JXV6q71CTCWrW+uSVaFG2luo9dU8Ey
         aX9xJ5Ulo4kD0qNtOG1ZTK2WMkznLvc7eZxhFCyPjTOSgwXPHxjkbq2daAT6ixVJQuNo
         o6gQ2Q2vYs79C7cYM4J8S4wGEweLo1B3eTnJbHIXuFsamPCDZqUP8jz3dvOtIP839g0G
         bUYQ==
X-Gm-Message-State: AOAM531I8q55bkuxpA9JRzu6r0pxGbmzIrywWw553J73JDcdfRQsAUkl
        aeT/twS+Lk32mkFjGCtInUykAYdvz1nsdQ==
X-Google-Smtp-Source: ABdhPJxLDNywO/rrcuKEgBCaRCZFcHwCywp32Ke/167ucQw2sJlpF4wg9fxIeT/Ry+SyjHnDtkEzYA==
X-Received: by 2002:a5d:47ad:: with SMTP id 13mr11282273wrb.77.1633079824955;
        Fri, 01 Oct 2021 02:17:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 08/17] cat-file tests: test for current --allow-unknown-type behavior
Date:   Fri,  1 Oct 2021 11:16:44 +0200
Message-Id: <patch-v10-08.17-76f9888a6f7-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
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
index 15774979ad3..5b16c69c286 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -402,6 +402,67 @@ do
 	done
 done
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_short_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_short_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_short_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_short_type $bogus_short_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_short_sha1 >bogus-oid &&
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
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_short_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	test_when_finished "rm -rf .git/refs/replace" &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_short_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_short_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_short_sha1 >actual &&
-- 
2.33.0.1375.g5eed55aa1b5

