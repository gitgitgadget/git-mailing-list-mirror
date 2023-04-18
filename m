Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD0C4C6FD18
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 20:40:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbjDRUkt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 16:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjDRUko (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 16:40:44 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C8AC65F
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:42 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54ee0b73e08so476892887b3.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 13:40:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681850442; x=1684442442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kgMBQJmcf8c34ITq6py7jrYV3tEVfzPkI6ydstMTiAc=;
        b=B92wNuyYHIVGJMR3Rx9hIJlwZGZxpqS0c3N8y2wf2lU9baZH2iV9fZmzWFzvSOUIFW
         lLyTPsCG33x6Qcd3meexO+I+cjT2q9dyJNPIzXJcrX6N9hrvp8P0BEKptFkuO+JICf1g
         Xm1t0bNWDgEtZtQWLcrWZqgdV3kWb2PjsEL2N2NyIZc9WjEiMIOInoB61zOHUg1czCP7
         8S1jNDnZo/zjQrruoArlv6kxcy2VtSjGzm2BLi4tjJRQqc4yXzndpgvPW9OoRk3QqaGi
         bbeyJxqwTJAGmEkks1FlIyt7QxB7RyQvkOHXCDwtrLKIpSjCD8TN1k1zgPpDh/tGI2WP
         ctJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681850442; x=1684442442;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgMBQJmcf8c34ITq6py7jrYV3tEVfzPkI6ydstMTiAc=;
        b=ZncO8loLBwsIK75CrKPEk1ZawAzzRQt6MjNMMzWpagcQZYnJn9/wwN19V7K1zgzbkh
         F0skQfj1xvCoRggEPm2zZBl5Zh6KbXZsCUp1rvpP6jl/sOikMD7M2iqCmXAP6TRCK2RY
         bScEkU3Er6MdO4LrsCJfNcvWmlQs/1hIJ9hHnztEKcF8UjiCfvDMudhkfc3gQBl9djmg
         m6bEIr8eRiJcVqT8nqqk+e4Vh4Gqhq58UXD7mlGx+nymlP7A7Wwf9vkg184xvcggJE+R
         zJv/tND9l+REZ+qZAQ6Hd7lw4HlekGkJY/CyFjWony/0FcwyBIWG77Ezw4J22HOZqYpW
         Xj4g==
X-Gm-Message-State: AAQBX9fM9lT2PwNEHXxLYTnoPI/Knecx+bpCf2SMblscnmiOdlhu40iP
        kDaK8N/BiLrQ7Rx6HB+pcIh1WsBnxHM7lE1CINLxTQ==
X-Google-Smtp-Source: AKy350ZHzS6EJCmhYB4gR6wUJG02g4D3CXG8ANUqacerSJAcSJ9Cw4TsG8wKr8I5oCOoDB7rwy+eCw==
X-Received: by 2002:a0d:d286:0:b0:54f:e7cd:bb1d with SMTP id u128-20020a0dd286000000b0054fe7cdbb1dmr1116558ywd.12.1681850442242;
        Tue, 18 Apr 2023 13:40:42 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l18-20020a812512000000b0054f8b69889fsm4047611ywl.74.2023.04.18.13.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 13:40:42 -0700 (PDT)
Date:   Tue, 18 Apr 2023 16:40:41 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 04/10] t/t5304-prune.sh: prepare for `gc --cruft` by
 default
Message-ID: <905eeb90275178ac53adddb1abc17d149775dd60.1681850424.git.me@ttaylorr.com>
References: <cover.1681764848.git.me@ttaylorr.com>
 <cover.1681850424.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681850424.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many of the tests in t5304 run `git gc`, and rely on its behavior that
unreachable-but-recent objects are written out loose. This is sensible,
since t5304 deals specifically with this kind of pruning.

If left unattended, however, this test would break when the default
behavior of a bare "git gc" is adjusted to generate a cruft pack by
default.

Ensure that these tests continue to work as-is (and continue to provide
coverage of loose object pruning) by passing `--no-cruft` explicitly.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5304-prune.sh | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 5500dd0842..662ae9b152 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -62,11 +62,11 @@ test_expect_success 'prune --expire' '
 test_expect_success 'gc: implicit prune --expire' '
 	add_blob &&
 	test-tool chmtime =-$((2*$week-30)) $BLOB_FILE &&
-	git gc &&
+	git gc --no-cruft &&
 	verbose test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE &&
 	test-tool chmtime =-$((2*$week+1)) $BLOB_FILE &&
-	git gc &&
+	git gc --no-cruft &&
 	verbose test $before = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_missing $BLOB_FILE
 '
@@ -86,7 +86,7 @@ test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
 
 test_expect_success 'gc: start with ok gc.pruneExpire' '
 	git config gc.pruneExpire 2.days.ago &&
-	git gc
+	git gc --no-cruft
 '
 
 test_expect_success 'prune: prune nonsense parameters' '
@@ -137,44 +137,44 @@ test_expect_success 'gc --no-prune' '
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
 	git config gc.pruneExpire 2.days.ago &&
-	git gc --no-prune &&
+	git gc --no-prune --no-cruft &&
 	verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 	test_path_is_file $BLOB_FILE
 '
 
 test_expect_success 'gc respects gc.pruneExpire' '
 	git config gc.pruneExpire 5002.days.ago &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire 5000.days.ago &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc --prune=<date>' '
 	add_blob &&
 	test-tool chmtime =-$((5001*$day)) $BLOB_FILE &&
-	git gc --prune=5002.days.ago &&
+	git gc --prune=5002.days.ago --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
-	git gc --prune=5000.days.ago &&
+	git gc --prune=5000.days.ago --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc --prune=never' '
 	add_blob &&
-	git gc --prune=never &&
+	git gc --prune=never --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
-	git gc --prune=now &&
+	git gc --prune=now --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
 test_expect_success 'gc respects gc.pruneExpire=never' '
 	git config gc.pruneExpire never &&
 	add_blob &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_file $BLOB_FILE &&
 	git config gc.pruneExpire now &&
-	git gc &&
+	git gc --no-cruft &&
 	test_path_is_missing $BLOB_FILE
 '
 
@@ -194,7 +194,7 @@ test_expect_success 'gc: prune old objects after local clone' '
 		cd aclone &&
 		verbose test 1 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_file $BLOB_FILE &&
-		git gc --prune &&
+		git gc --prune --no-cruft &&
 		verbose test 0 = $(git count-objects | sed "s/ .*//") &&
 		test_path_is_missing $BLOB_FILE
 	)
@@ -237,7 +237,7 @@ test_expect_success 'clean pack garbage with gc' '
 	>.git/objects/pack/fake2.keep &&
 	>.git/objects/pack/fake2.idx &&
 	>.git/objects/pack/fake3.keep &&
-	git gc &&
+	git gc --no-cruft &&
 	git count-objects -v 2>stderr &&
 	grep "^warning:" stderr | sort >actual &&
 	cat >expected <<\EOF &&
-- 
2.40.0.362.gc67ee7c2ff

