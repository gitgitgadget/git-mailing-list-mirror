Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73551C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 20:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbjDQU5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 16:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230420AbjDQU51 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 16:57:27 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618E710240
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:10 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-54fe82d8bf5so118497367b3.3
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 13:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681764871; x=1684356871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qkkwKqgaROJ7eFygG7db6ztdmnrn7KSjjlMwVUTv4mE=;
        b=E4Fgo0Sx/nfqcgeY2YzH9G/s1hIpkUFmVtcI6ObQuPwxKNm+w1aY0KiKw5WQ/eC7O0
         rjiuLAci8WqeDJiOFEEqklwuknsicJVJe+YOFPAhsiwm6mjb/31UJb8+yqhhfObKp80+
         NH4Rg2GUaLkIixie9bgijb94or2e0QHCrH+YagFZTqLl7VZSA8y7frql1hA9dHYA/WJd
         4jQQ2mCgZKEbyFBxKx4rBrTIv8TKJFCGag8tIFwE4cv5oQeWQstY63mE/k4mH7vh86GY
         rA+ezpwSOtlIybN5KPPiZvABK08mvtJvvUGR4E0nr7Ueh4FxGnnvpeqlQL/jBGF/4uLA
         ntKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681764871; x=1684356871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qkkwKqgaROJ7eFygG7db6ztdmnrn7KSjjlMwVUTv4mE=;
        b=Ns7n8w6lLayFE8barW8s3CF62fuAp3jo3Ho/epFvXsdJ+h5t+WRqxD7NlxoPmPak6e
         DVb9CEI2AL3vs2EduBydDqMzPO5dnslTyknqO4Rgk5DIwYDRhl6IQuahs1KYTEy3mPiO
         vmgoOhIrlA8gMZ3+Oa8lSqHr2ExApX2yVZnMqMm5LM0UqJOHsUVqQEjbBZ3zCQIrCeSK
         OVsRlGRsTpzGe0nhELckJ1TOofKq9YlQ4kzAjFHb3WXPYMhBbym0ljKA413UiiBCf6sn
         wO+dsy5zKhBhqSfAHYrapwpDjA/A49slFRBK6BRyxdi76zBCyP7pHVmlup7iFd8zK3nm
         zarw==
X-Gm-Message-State: AAQBX9ciBsr/YknRSveClRza2+Dqrwq3VPeB1xzITpZ+czV/3A0ZDKYp
        nuvEDjdbsbGcUtbuj+me5CfacjstmAUUzBhNWygjtA==
X-Google-Smtp-Source: AKy350YU5V1g6X9qJVAOrweWlORu6DAzvat4/lagFG6sCrG771ubpoLWDfbxggVZ36oxV7lM8R32Ig==
X-Received: by 2002:a0d:f087:0:b0:552:a2e2:684e with SMTP id z129-20020a0df087000000b00552a2e2684emr9293968ywe.52.1681764871488;
        Mon, 17 Apr 2023 13:54:31 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id by7-20020a05690c082700b00545ef25cec6sm3299750ywb.105.2023.04.17.13.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 13:54:31 -0700 (PDT)
Date:   Mon, 17 Apr 2023 16:54:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 06/10] t/t6500-gc.sh: refactor cruft pack tests
Message-ID: <56a965e517c125c1defa95f7ccf8506dbf55275f.1681764848.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681764848.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In 12253ab6d0 (gc: add tests for --cruft and friends, 2022-10-26), we
added a handful of tests to t6500 to ensure that `git gc` respected the
value of `--cruft` and `gc.cruftPacks`.

Then, in c695592850 (config: let feature.experimental imply
gc.cruftPacks=true, 2022-10-26), another set of similar tests was added
to ensure that `feature.experimental` correctly implied enabling cruft
pack generation (or not).

These tests are similar and could be consolidated. Do so in this patch
to prepare for expanding the set of command-line invocations that enable
or disable writing cruft packs. This makes it possible to easily test
more combinations of arguments without being overly repetitive.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t6500-gc.sh | 126 ++++++++++++++++++--------------------------------
 1 file changed, 44 insertions(+), 82 deletions(-)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index df6f2e6e52..a2f988c5c2 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -210,93 +210,55 @@ prepare_cruft_history () {
 	git reset HEAD^^
 }
 
-assert_cruft_packs () {
-	find .git/objects/pack -name "*.mtimes" >mtimes &&
-	sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
-
-	test_file_not_empty packs &&
-	while read pack
-	do
-		test_path_is_file "$pack" || return 1
-	done <packs
-}
-
 assert_no_cruft_packs () {
 	find .git/objects/pack -name "*.mtimes" >mtimes &&
 	test_must_be_empty mtimes
 }
 
-test_expect_success 'gc --cruft generates a cruft pack' '
-	test_when_finished "rm -fr crufts" &&
-	git init crufts &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git gc --cruft &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'gc.cruftPacks=true generates a cruft pack' '
-	test_when_finished "rm -fr crufts" &&
-	git init crufts &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c gc.cruftPacks=true gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=true generates a cruft pack' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.experimental=true gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=false allows explicit cruft packs' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c gc.cruftPacks=true -c feature.experimental=false gc &&
-		assert_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=true can be overridden' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.expiremental=true -c gc.cruftPacks=false gc &&
-		assert_no_cruft_packs
-	)
-'
-
-test_expect_success 'feature.experimental=false avoids cruft packs by default' '
-	git init crufts &&
-	test_when_finished "rm -fr crufts" &&
-	(
-		cd crufts &&
-
-		prepare_cruft_history &&
-		git -c feature.experimental=false gc &&
-		assert_no_cruft_packs
-	)
-'
+for argv in \
+	"gc --cruft" \
+	"-c gc.cruftPacks=true gc" \
+	"-c feature.experimental=true gc" \
+	"-c gc.cruftPacks=true -c feature.experimental=false gc"
+do
+	test_expect_success "git $argv generates a cruft pack" '
+		test_when_finished "rm -fr repo" &&
+		git init repo &&
+		(
+			cd repo &&
+
+			prepare_cruft_history &&
+			git $argv &&
+
+			find .git/objects/pack -name "*.mtimes" >mtimes &&
+			sed -e 's/\.mtimes$/\.pack/g' mtimes >packs &&
+
+			test_file_not_empty packs &&
+			while read pack
+			do
+				test_path_is_file "$pack" || return 1
+			done <packs
+		)
+	'
+done
+
+for argv in \
+	"-c feature.expiremental=true -c gc.cruftPacks=false gc" \
+	"-c feature.experimental=false gc"
+do
+	test_expect_success "git $argv does not generate a cruft pack" '
+		test_when_finished "rm -fr repo" &&
+		git init repo &&
+		(
+			cd repo &&
+
+			prepare_cruft_history &&
+			git $argv &&
+
+			assert_no_cruft_packs
+		)
+	'
+done
 
 test_expect_success '--keep-largest-pack ignores cruft packs' '
 	test_when_finished "rm -fr repo" &&
-- 
2.38.1

