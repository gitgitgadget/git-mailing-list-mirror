Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AF42C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 20:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbiJZUNn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 16:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiJZUNl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 16:13:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5520B143A77
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id s27so5037493ioa.10
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 13:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qovolsfycjEUOH5XwiXRM5hN9cKAFV9rzLAAVCFLpP0=;
        b=QQDP5bDTcsOLaE9H7dGZrX0l+NHs/st7P758nmOe30L/39YkwTu9zGTacJ6j/dFFS2
         2wF6RVXskh2+F0GoMDBMarqnyfACWHBnHCUOt890fVQwd2IjAxGP9TKtgXwn0u7Hfxfw
         jIty3Jn8UTxbh8ZcCpb4nByT87FgaIdTLizjYGMCBDZ8vvz5Nwmc90o3+AAP+zOWC7RK
         /lQtWDRt0gVqZgVCeOfoSePPUm+NaUTsOjuEhDu4ywSPDxxZ4JpY9dUC75gCPv9xNTh5
         8mkKYfI7E69M4Ye8/9edjXwa0VsZsQXvrMxBQpOjvNNY8rMJpKiYZdoD00o4WbR330Os
         l4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qovolsfycjEUOH5XwiXRM5hN9cKAFV9rzLAAVCFLpP0=;
        b=FiZp6G6HGPnjfIryIXdaaH9gBGXn23ogp3iOWcAav17Z4+V+ZegYU3j/eXD+NOWfss
         Gb7Jiu5C8jLc+4NGOA5Iq0aDeGVdAWtph68j2SMsLU9nyoiy/vK73m/T3nfFBGcQWUSG
         nSQ46UomVuT/Lu2HXRh6baj8Japx7EZKGIHDTu80yI2ASWLkyUmhmGlMaZZCayUOyfI2
         w9xUGi4T0IjX/qobWwIG7byB/RIpB2a0IeUG0ZJOFeijpeAr3YOAKaEymPR45gds8qoi
         UEJK14Jslierai3PiM2ywK0Kj83TxCDIViZCf0Lywz3ePRMqaReovgf0t0JzmjTOtl21
         xRrQ==
X-Gm-Message-State: ACrzQf1iXMhdtUg0OxvJYysXfF2jjPasTpO1qkB4Bz9SLWjTdLkKqEAi
        ZQBochXynkgjqXDsUyvh7DL5XwcEI0LtETGf
X-Google-Smtp-Source: AMsMyM5QO3uMdoJ/GRXGSgp94QGqLF7nMROjTDx2vnIEdT0HzqUHTASHyOqRcKGZ721tjdKh9+fW7w==
X-Received: by 2002:a05:6638:2494:b0:363:db50:7655 with SMTP id x20-20020a056638249400b00363db507655mr30578204jat.76.1666815219552;
        Wed, 26 Oct 2022 13:13:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r28-20020a02aa1c000000b00369a91d1bd4sm2279880jam.138.2022.10.26.13.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 13:13:39 -0700 (PDT)
Date:   Wed, 26 Oct 2022 16:13:38 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v2 1/2] gc: add tests for --cruft and friends
Message-ID: <35d2c97715008db3957a69a8260e2046c0e5e738.1666815209.git.me@ttaylorr.com>
References: <cover.1666815209.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666815209.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

In 5b92477f89 (builtin/gc.c: conditionally avoid pruning objects via
loose, 2022-05-20) gc learned to respect '--cruft' and 'gc.cruftPacks'.
'--cruft' is exercised in t5329-pack-objects-cruft.sh, but in a way that
doesn't check whether a lone gc run generates these cruft packs.
'gc.cruftPacks' is never exercised.

Add some tests to exercise these options to gc in the gc test suite.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6500-gc.sh | 43 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index cd6c53360d..9110a39088 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -202,6 +202,49 @@ test_expect_success 'one of gc.reflogExpire{Unreachable,}=never does not skip "e
 	grep -E "^trace: (built-in|exec|run_command): git reflog expire --" trace.out
 '
 
+prepare_cruft_history () {
+	test_commit base &&
+
+	test_commit --no-tag foo &&
+	test_commit --no-tag bar &&
+	git reset HEAD^^
+}
+
+assert_cruft_pack_exists () {
+	find .git/objects/pack -name "*.mtimes" >mtimes &&
+	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
+
+	test_file_not_empty packs &&
+	while read pack
+	do
+		test_path_is_file "$pack" || return 1
+	done <packs
+}
+
+test_expect_success 'gc --cruft generates a cruft pack' '
+	test_when_finished "rm -fr crufts" &&
+	git init crufts &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git gc --cruft &&
+		assert_cruft_pack_exists
+	)
+'
+
+test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
+	test_when_finished "rm -fr crufts" &&
+	git init crufts &&
+	(
+		cd crufts &&
+
+		prepare_cruft_history &&
+		git -c gc.cruftPacks=true gc &&
+		assert_cruft_pack_exists
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.38.0.16.g393fd4c6db

