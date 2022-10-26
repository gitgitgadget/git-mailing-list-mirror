Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A374C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 21:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiJZVct (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 17:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJZVcp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 17:32:45 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23F1413BB
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:44 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id d14so9697280ilf.2
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 14:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9q1Q/fmudlU9KNvS7rpcmbF9lGIfex/Bu0+j10621nQ=;
        b=BbL0rXO73HitYGvzY+x3zwJiy8DhYaG0GrJ0o+GqHFqacjmolnmy9Zmd70yi3gFA7j
         VlZlckbllrVVZvE0pERJQieUPZgd2SxT1bdIsWyvZwfhgE4aiJTUWwkJ08l/Y4obWXmS
         hBIz/s0pz6/TY5QtVrZGD4qkqouZGo6c1IezIByYc7NJH7I6sTUygW8XH9zpAdg/3Tuj
         juw0Y/h/ayimSR0XcA2FMwKdFN1WqBWCUp6XucXW0gSt56NFjAOM2HmG775maalF/4wY
         7fSspfREEFkHUaerRSXceTkuJBNScgT3IMxF2ALBUL1cdwJ91TXYlFsmG2ZqkHnkW63C
         /wyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9q1Q/fmudlU9KNvS7rpcmbF9lGIfex/Bu0+j10621nQ=;
        b=mKljKthvwqhih2rGrsscUES5XlDiPE1CLD3Wbw37ys/NgG61jRgVpHQNGCNFlLH7Aj
         u9YmzESuWU+EE3XSqzTT0vxfnqgltbuAf8UDuyotCekBRbRmGI8fNcnESGEaZhRdSsIE
         02NuPA+Phne6p6uoW+dgjBa8RyoHiN6uErV5Ozu0ywp1dRdO+mAEoRPHujAiKoZC3BHx
         VsPm5KdF+i4cabLA2HIaipRb2KzAunD/6zBrD62bgy1u1trmwS0fOs0Jvbd0XVDu47tr
         ODI2gqU7ERu6eMq/q/XBue81DOz6gNQebMb3I/E98sBxudKeQQPi5z3u5vS0aBDwAeuw
         S04A==
X-Gm-Message-State: ACrzQf3bBj0hOs8sTVYGWFkAyo5ALRvkiYZ7dyooRfg6vBKhXiGpYE2j
        PVcGahzFrZNNgksbUmIvIlb14Tj5A5gI95D2
X-Google-Smtp-Source: AMsMyM5hwvPMcNTfazvqHNyiww29pnCAO2YTyN3Brx/FiQIJJzM92yFkev5FPlFnbdJ+8PZmWMBIWA==
X-Received: by 2002:a05:6e02:18c6:b0:2fa:5726:e869 with SMTP id s6-20020a056e0218c600b002fa5726e869mr27371928ilu.250.1666819964205;
        Wed, 26 Oct 2022 14:32:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d7-20020a92d787000000b002f927051cb3sm2432132iln.46.2022.10.26.14.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 14:32:43 -0700 (PDT)
Date:   Wed, 26 Oct 2022 17:32:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: [PATCH v3 1/2] gc: add tests for --cruft and friends
Message-ID: <e8726f3de7a7a5eb3375c4b44e205b1f77174dbb.1666819953.git.me@ttaylorr.com>
References: <cover.1666815209.git.me@ttaylorr.com>
 <cover.1666819953.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1666819953.git.me@ttaylorr.com>
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
index cd6c53360d..928a522194 100755
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
+assert_cruft_packs () {
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
+		assert_cruft_packs
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
+		assert_cruft_packs
+	)
+'
+
 run_and_wait_for_auto_gc () {
 	# We read stdout from gc for the side effect of waiting until the
 	# background gc process exits, closing its fd 9.  Furthermore, the
-- 
2.38.0.16.g393fd4c6db

